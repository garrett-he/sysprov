module_cygwin_skel() {
    for skel in /etc/skel/.*; do
        test -f "$skel" && cp -n "$skel" ~
    done

       cp "$SYSPROV_ROOT"/modules/cygwin/.minttyrc ~
}

module_cygwin_apt-cyg() {
    if [[ -z "${SYSPROV_MIRROR_CYGWIN-}" ]]; then
        utils::read 'cygwin mirror' SYSPROV_MIRROR_CYGWIN
    fi

    sysprov::git_clone https://github.com/transcode-open/apt-cyg.git /usr/local/apt-cyg SYSPROV_MIRROR_APT_CYG_GIT_REMOTE

    ln -s /usr/local/apt-cyg/apt-cyg /usr/local/bin

    apt-cyg cache /var/cache/cygwin
    apt-cyg mirror "$SYSPROV_MIRROR_CYGWIN"
}

module_cygwin_apt-cyg_packages() {
    apt-cyg install gcc-core make cmake gdb libssl-devel libiconv-devel zlib-devel libffi-devel vim bash-completion dos2unix fdupes
}

module_cygwin_python() {
    apt-cyg install python3 python3-devel python3-pip python3-cffi

    ln -sf /usr/bin/python3.9.exe /usr/local/bin/python3
    ln -sf /usr/bin/python3.9.exe /usr/local/bin/python
    ln -sf /usr/bin/pip3.9 /usr/local/bin/pip3
    ln -sf /usr/bin/pip3 /usr/local/bin/pip
}

module_cygwin_lua() {
    apt-cyg install lua liblua-devel liblua5.3 unzip

    # luarocks
    ln -sf /usr/lib/liblua5.3.dll.a /usr/lib/liblua.a
    ln -sf /usr/include/lua5.3 /usr/include/lua

    curl https://luarocks.github.io/luarocks/releases/luarocks-3.9.2.tar.gz -o /tmp/luarocks-3.9.2.tar.gz

    cd /tmp
    tar xf luarocks-3.9.2.tar.gz
    cd luarocks-3.9.2

    ./configure --with-lua-include=/usr/include/lua5.3
    make
    make install

    cd /tmp
    rm -rf luarocks-3.9.2

    utils::append_profiles
    utils::append_profiles '# cygwin_lua'
    utils::append_profiles 'export PATH="$HOME/.luarocks/bin:$PATH"'
}
