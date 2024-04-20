module_dotfiles() {
    sysprov::git_clone https://github.com/garrett-he/dotfiles.git ~/.dotfiles

    cd ~/.dotfiles
    git submodule init
    git submodule update
    ./install.sh
}

module_zsh() {
    # Install ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # Install powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    file::sed 's#ZSH_THEME="robbyrussell"#ZSH_THEME="powerlevel10k/powerlevel10k"#g' ~/.zshrc

    # Install zsh-autosuggestions and zsh-syntax-highlighting
    sysprov::git_clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    sysprov::git_clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

    file::sed 's#plugins=(git)#plugins=(zsh-autosuggestions zsh-syntax-highlighting)#g' ~/.zshrc
}

module_python_packages() {
    $SYSPROV_PYTHON_PIP install --upgrade pip
    $SYSPROV_PYTHON_PIP install --user --break-system-packages copier pdm

    utils::append_profiles 'export PATH="'$(python3 -m site --user-base)/bin':$PATH"'
}

module_pyenv() {
    curl -s -S -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

    utils::append_profiles
    utils::append_profiles '# pyenv'
    utils::append_profiles 'export PYENV_ROOT="$HOME/.pyenv"'
    utils::append_profiles 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"'
    utils::append_profiles 'eval "$(pyenv init -)"'
}
