module_linux_python() {
    sudo pacman -S --noconfirm python python-pip

    utils::append_profiles
    utils::append_profiles '# linux_python'
    utils::append_profiles 'export PATH="$HOME/.local/bin:$PATH"'
}
