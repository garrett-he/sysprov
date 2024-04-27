module_linux_python() {
    sudo pacman -S --noconfirm python python-pip

    utils::append_profiles
    utils::append_profiles '# linux_python'
    utils::append_profiles 'export PATH="$HOME/.local/bin:$PATH"'
}

module_linux_lua() {
    sudo pacman -S --noconfirm lua luarocks

    utils::append_profiles
    utils::append_profiles '# linux_lua'
    utils::append_profiles 'export PATH="$HOME/.luarocks/bin:$PATH"'
}

module_linux_php() {
    sudo pacman -S --noconfirm php composer
}

module_linux_clash() {
    sudo pacman -S --noconfirm clash

    systemctl enable --user clash
    systemctl start --user clash
}
