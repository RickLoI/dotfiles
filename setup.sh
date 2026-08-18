#! /usr/bin/env bash 

CONFS="$HOME/.config"
DOTS="$HOME/.dotfiles"

MIME="$HOME/.local/share/applications/"

GREETD="/etc/greetd/"

LOG="$DOTS/setup.log"

init_check() {
    mkdir -p "$DOTS"
    echo "Moving the cloned repo to $DOTS" | tee "$LOG"
    local cwd=$(pwd)
    if [[ $cwd != $DOTS ]]; then
        mv "$cwd/".* "$cwd/"* "$DOTS"
    fi
    cd "$DOTS"
}

init_package_install() {
    local required=(
        "adw-gtk-theme"
        "bat"
        "brother-dcp-l2510d"
        "fish"
        "gimp"
        "greetd"
        "gvfs"
        "gvfs-mtp"
        "hyprland"
        "hyprpolkitagent"
        "imv"
        "keychain"
        "kitty"
        "libxcrypt-compat"
        "localsend-bin"
        "mpv"
        "neovim"
        "nwg-look"
        "noctalia"
        "noctalia-greeter"
        "papirus-icon-theme"
        "telegram-desktop"
        "thunar"
        "thunar-volman"
        "timeshift"
        "tree-sitter-cli"
        "ttf-lilex-nerd"
        "tumbler"
        "wl-clipboard"
        "xdg-desktop-portal-hyprland"
        "yazi"
        "zathura"
        "zathura-pdf-poppler"
        "zen-browser-bin"
    )

    echo "Installing required packages:" | tee -a "$LOG"
    for pkg in "${required[@]}"; do 
        echo "    * Installing $pkg" | tee -a "$LOG"
        yay -Syq --needed --noconfirm --answerdiff N --answerclean N $pkg
    done
    echo "All required packages have been installed" | tee -a "$LOG"

    local additional=(
        "spotify"
        "spicitify-cli"
        "steam"
        "texlive"
    )
    
    echo "Some additional packages are suggested:" | tee -a "$LOG"
    for pkg in "${additional[@]}"; do 
        read -r -p "    * Wanna install $pkg?" ans | tee -a "$LOG"
        case $ans in
            [Yy]* | "")
                if [[ "$pkg" == "texlive" ]]; then
                    echo "Building TeXLive from source" | tee -a "$LOG"
                    cd "/tmp/"
                    curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
                    zcat < install-tl-unx.tar.gz | tar xf -
                    cd install-tl-2* 
                    sudo perl ./install-tl --no-interaction
                else 
                    echo "Installing $pkg" | tee -a "$LOG"
                    yay -S --answerclean N --answerdiff N $pkg
                fi
                ;;
            [Nn]*)
                echo "Skipping $pkg" | tee -a "$LOG"
                ;;
        esac
    done
}

init_symlinks() {
    echo "Symlinking dotfiles to config" | tee -a "$LOG"
    cd "$DOTS"

    ln -sfn $DOTS/{fish,hypr,kitty,nvim,zathura} "$CONFS"
    mkdir -p "$MIME"
    cp $DOTS/mime/desktops/* "$MIME"
    cp "$DOTS/mime/mimeapps.list" "$CONFS"
    ln -sfn "$DOTS/wallpapers" "$HOME/Pictures/"

    cp -r "$DOTS/noctalia/"* "$CONFS/noctalia"
}

update_greetd() {
    echo "Updating greetd configs" | tee -a "$LOG"
    sudo cp "$DOTS/greetd/config.toml" "$GREETD"
    sudo systemctl enable greetd.service
}

update_settings() {
    echo "Updating system settings" | tee -a "$LOG"
    sudo systemctl enable bluetooth

    bat cache --build

    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"

    xfconf-query -c thunar -p /last-icon-view-zoom-level -s THUNAR_ZOOM_LEVEL_75_PERCENT
    xfconf-query -c thunar -p /last-menubar-visible -s false

    sudo firewall-cmd --add-port=53317/tcp --permanent
    sudo firewall-cmd --add-port=53317/udp --permanent
    sudo firewall-cmd --reload

    chsh --shell $(which fish)
    echo "Please reboot to apply all change" | tee -a "$LOG_FILE"
}

init_check
init_package_install
init_symlinks
update_greetd
update_settings
