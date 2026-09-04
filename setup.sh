#! /usr/bin/env bash 

CONFIG="$HOME/.config"
DOTFILES="$HOME/.dotfiles"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DESKTOPS_DIR="$HOME/.local/share/applications"
GREETD_DIR="/etc/greetd/"

LOG_FILE="$SCRIPT_DIR/setup.log"

# Step 1. Check whether yay or paru are installed.
# Prefer yay if neither exist.
echo "Ensuring a AUR helper (yay or paru) exists" | tee "$LOG_FILE"
helper=""
yay_exists=$(command -v yay)
paru_exists=$(command -v paru)

if [[ $paru_exists ]]; then
    echo "Paru was found! Using it as helper" | tee -a "$LOG_FILE"
    helper="paru"
fi

if [[ $yay_exists ]]; then
    echo "Yay was found! Using it as helper" | tee -a "$LOG_FILE"
    helper="yay"
fi

if [[ -z $helper ]]; then
    echo "No helper was found. Installing yay" | tee -a "$LOG_FILE"
    sudo pacman -S yay
    helper="yay"
fi

# Step 2. Installing packages
required_pkgs=(
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
    "brave-origin-nightly"
)

optional_pkgs=(
    "spotify"
    "spicitify-cli"
    "steam"
    "texlive"
)

echo "Installing required packages" | tee -a "$LOG_FILE"
for pkg in "${required_pkgs[@]}"; do 
    echo "Installing $pkg" | tee -a "$LOG_FILE"
    $helper -Syuq --needed --noconfirm --answerdiff N --answerclean N $pkg
done
echo "All required packages have been installed" | tee -a "$LOG_FILE"

echo "The following optional packages are suggested" | tee -a "$LOG_FILE"
for pkg in "${optional_pkgs[@]}"; do 
    read -r -p "    * Wanna install $pkg? " ans
    echo "    * Wanna install $pkg? A: $ans" >> "$LOG_FILE"
    case $ans in 
        [yY]* | "")
            if [[ "$pkg" == "texlive" ]]; then
                echo "Building TeXLive from source" | tee -a "$LOG_FILE"
                cd "/tmp/"
                curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
                zcat < install-tl-unx.tar.gz | tar xf -
                cd install-tl-2* 
                sudo perl ./install-tl --no-interaction
            else 
                echo "Installing $pkg" | tee -a "$LOG_FILE"
                yay -S --answerclean N --answerdiff N $pkg
            fi

            ;;
        [nN]* | *)
            echo "Skipping the installion for $pkg" | tee -a "$LOG_FILE"
            ;;
    esac
done

# Step 3. Init setup
read -r -p "Create a local copy of the repo?" do_copy
echo "Create a local copy of the repo? A: $do_copy" >> "$LOG_FILE"
case $do_copy in 
    [yY]* | "")
        echo "Creating a local copy at $DOTFILES" | tee -a "$LOG_FILE"
        mkdir -p "$DOTFILES"
        if [[ $SCRIPT_DIR != $DOTFILES ]]; then 
            cp -r "$SCRIPT_DIR/".* "$SCRIPT_DIR/"* "$DOTFILES"
        fi

        echo "Treating the copy as symlinks" | tee -a "$LOG_FILE"
        ln -sfn $DOTFILES/{fish,hypr,kitty,noctalia,nvim,zathura} "$CONFIG"
        ln -sfn "$DOTFILES/wallpapers" "$HOME/Pictures/"
        ;;
    [nN]* | *)
        echo "Hard-copying repo at $CONFIG" | tee -a "$LOG_FILE"
        cp -r $SCRIPT_DIR/{fish,hypr,kitty,noctalia,nvim,zathura} "$CONFIG"
        cp -r "$SCRIPT_DIR/wallpapers" "$HOME/Pictures/"
        ;;
esac

# Step 4. Desktop files 
echo "Adding custom desktop files for imv, nvim and zathura"
mkdir -p "$DESKTOPS_DIR"
cp -r $SCRIPT_DIR/mime/desktops/* "$DESKTOPS_DIR"
cp "$SCRIPT_DIR/mime/mimeapps.list" "$CONFIG"

# Step 5. Updating greetd
echo "Updating greetd configs" | tee -a "$LOG_FILE"
sudo cp "$SCRIPT_DIR/greetd/config.toml" "$GREETD_DIR"
sudo systemctl enable greetd.service

# Step 5. Updating other options
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

