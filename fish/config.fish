if status is-interactive

    # SSH session setup
    set -gx GITHUB_SSH_KEY "$HOME/.ssh/id_github"
    set -gx GITLAB_SSH_KEY "$HOME/.ssh/id_gitlab"
    keychain -q --eval $GITHUB_SSH_KEY $GITLAB_SSH_KEY | source
    clear

    fish_config theme choose "haligan"
end

# Global Variables
# CLI stuff 
set -gx MANPAGER "nvim +Man!"
set -gx EDITOR nvim
set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"

# Languages
## TEX
set -gx TEX_HOME /usr/local/texlive/*/bin/x86_64-linux
set -gx PATH $TEX_HOME $PATH
set -gx TEXMFHOME "$HOME/.texmf"

## JAVA
set -gx JAVA_HOME /usr/lib/jvm/*/bin/
set -gx PATH $JAVA_HOME $PATH

## QML 
set -gx QML_IMPORT_PATH /usr/lib/qt6/qml

# ---- To remove after uni
# UNI related pathing
set -gx SPARK_HOME /mnt/spark/
set -gx PATH $SPARK_HOME/bin $SPARK_HOME/sbin $PATH

# Fish specific
set -U fish_greeting

# Aliases
alias yayu "yay -Syu --needed --answerclean=N --answerdiff=N"
