if [[ $(arch) == "arm64" ]]; then
    SYSPROV_DARWIN_HOMEBREW_PREFIX="/opt/homebrew"
else
    SYSPROV_DARWIN_HOMEBREW_PREFIX="/usr/local"
fi

module_darwin_homebrew() {
    export HOMEBREW_API_DOMAIN="${SYSPROV_MIRROR_HOMEBREW_API_DOMAIN-}"
    export HOMEBREW_BOTTLE_DOMAIN="${SYSPROV_MIRROR_HOMEBREW_BOTTLE_DOMAIN-}"
    export HOMEBREW_BREW_GIT_REMOTE="${SYSPROV_MIRROR_HOMEBREW_BREW_GIT_REMOTE-}"
    export HOMEBREW_CORE_GIT_REMOTE="${SYSPROV_MIRROR_HOMEBREW_CORE_GIT_REMOTE-}"
    export HOMEBREW_PIP_INDEX_URL="${SYSPROV_MIRROR_PYPI_INDEX-}"

    if [[ -z "${SYSPROV_MIRROR_HOMEBREW_INSTALL_GIT_REMOTE-}" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        git clone "$SYSPROV_MIRROR_HOMEBREW_INSTALL_GIT_REMOTE" /tmp/brew-install
        /bin/bash /tmp/brew-install/install.sh
        rm -rf /tmp/brew-install
    fi

    utils::append_profiles
    utils::append_profiles '# darwin_homebrew'
    utils::append_profiles "export HOMEBREW_API_DOMAIN=$HOMEBREW_API_DOMAIN"
    utils::append_profiles "export HOMEBREW_BOTTLE_DOMAIN=$HOMEBREW_BOTTLE_DOMAIN"
    utils::append_profiles "export HOMEBREW_BREW_GIT_REMOTE=$HOMEBREW_BREW_GIT_REMOTE"
    utils::append_profiles "export HOMEBREW_CORE_GIT_REMOTE=$HOMEBREW_CORE_GIT_REMOTE"
    utils::append_profiles "export HOMEBREW_PIP_INDEX_URL=$HOMEBREW_PIP_INDEX_URL"
}

module_darwin_homebrew_packages() {
    $SYSPROV_DARWIN_HOMEBREW_PREFIX/bin/brew install coreutils gnu-sed gnu-tar findutils jq wget

    utils::append_profiles
    utils::append_profiles '# darwin_homebrew_packages'
    utils::append_profiles 'export PATH="'$SYSPROV_DARWIN_HOMEBREW_PREFIX'/opt/coreutils/libexec/gnubin:$PATH"'
    utils::append_profiles 'export PATH="'$SYSPROV_DARWIN_HOMEBREW_PREFIX'/opt/gnu-sed/libexec/gnubin:$PATH"'
    utils::append_profiles 'export PATH="'$SYSPROV_DARWIN_HOMEBREW_PREFIX'/opt/gnu-tar/libexec/gnubin:$PATH"'
    utils::append_profiles 'export PATH="'$SYSPROV_DARWIN_HOMEBREW_PREFIX'/opt/findutils/libexec/gnubin:$PATH"'
}

module_darwin_python() {
    $SYSPROV_DARWIN_HOMEBREW_PREFIX/bin/brew install python

    utils::append_profiles
    utils::append_profiles '# darwin_python'
    utils::append_profiles 'export PATH="'$SYSPROV_DARWIN_HOMEBREW_PREFIX'/opt/python/libexec/bin:$PATH"'
}

module_darwin_lua() {
    $SYSPROV_DARWIN_HOMEBREW_PREFIX/bin/brew install lua luarocks

    utils::append_profiles
    utils::append_profiles '# darwin_lua'
    utils::append_profiles 'export PATH="$HOME/.luarocks/bin:$PATH"'
}

module_darwin_php() {
    $SYSPROV_DARWIN_HOMEBREW_PREFIX/bin/brew install php
}

module_darwin_preferences() {
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    defaults write com.apple.screencapture location ~/Pictures
    killall SystemUIServer
}
