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
