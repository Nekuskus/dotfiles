if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    echo ".bash_profile: sourced .bashrc"
fi
