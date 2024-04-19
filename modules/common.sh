module_dotfiles() {
    sysprov::git_clone https://github.com/garrett-he/dotfiles.git ~/.dotfiles

    cd ~/.dotfiles
    git submodule init
    git submodule update
    ./install.sh
}
