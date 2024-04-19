sysprov_install_log="$SYSPROV_ROOT"/.install.log

sysprov::is_module_defined() {
    type module_"$1" > /dev/null 2> /dev/null

    return $?
}

sysprov::is_module_installed() {
    grep "$1" "$sysprov_install_log" > /dev/null 2> /dev/null

    return $?
}

sysprov::install_module() {
    if ! sysprov::is_module_defined "$1"; then
        logging::error "Module '$1' not defined."
        return 1
    fi

    if ! sysprov::is_module_installed "$1"; then
        module_"$1"

        echo "$1" >> "$sysprov_install_log"
    fi

    return 0
}

sysprov::git_clone() {
    local git_remote_url

    if [[ -z "${3-}" ]] || [[ -z "${!3-}" ]]; then
        git_remote_url=$1
    else
        git_remote_url=${!3}
    fi

    git clone "$git_remote_url" "$2"
}
