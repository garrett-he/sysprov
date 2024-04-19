#!/usr/bin/env bash

set -eo pipefail

SYSPROV_ROOT=$(dirname "$(realpath "$0")")
source "$SYSPROV_ROOT"/vendor/shlib/lib/logging.sh
source "$SYSPROV_ROOT"/vendor/shlib/lib/os.sh
source "$SYSPROV_ROOT"/vendor/shlib/lib/utils.sh
source "$SYSPROV_ROOT"/vendor/shlib/lib/file.sh
source "$SYSPROV_ROOT"/functions.sh

sysprov_announce() {
    echo '==========================================================='
    echo
    echo '███████╗██╗   ██╗███████╗██████╗ ██████╗  ██████╗ ██╗   ██╗'
    echo '██╔════╝╚██╗ ██╔╝██╔════╝██╔══██╗██╔══██╗██╔═══██╗██║   ██║'
    echo '███████╗ ╚████╔╝ ███████╗██████╔╝██████╔╝██║   ██║██║   ██║'
    echo '╚════██║  ╚██╔╝  ╚════██║██╔═══╝ ██╔══██╗██║   ██║╚██╗ ██╔╝'
    echo '███████║   ██║   ███████║██║     ██║  ██║╚██████╔╝ ╚████╔╝ '
    echo '╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝   ╚═══╝  '
    echo
    echo '==========================================================='
    echo
    echo 'A set of scripts for provisioning systems on POSIX operating systems.'
}

sysprov_help() {
    echo 'usage: install.sh'
    echo 'A set of scripts for provisioning systems on POSIX operating systems.'
}

sysprov_prepare() {
    # Load modules
    local module_dir="$SYSPROV_ROOT"/modules

    logging::debug 'Load modules for common'
    source "$module_dir"/common.sh

    local ostype=$(os::type)

    if [[ $ostype == "linux" ]]; then
        eval $(cat /etc/*-release | grep "^ID=")

        if [[ "$ID" == "manjaro" ]]; then
            ID=arch
        fi

        local linux_module_file="$SYSPROV_ROOT/modules/linux/${ID}.sh"
        if [[ -f $linux_module_file ]]; then
            source "$linux_module_file"
        else
            logging::warning "linux module file not found: ${linux_module_file}"
        fi
    else
        source "$module_dir/$ostype".sh
    fi

    # Load configurations
    source "$SYSPROV_ROOT/config/$ostype.conf"
}

sysprov_install() {
    for module in "${modules[@]}"; do
        if sysprov::is_module_installed "$module"; then
            logging::warning "Module '$module' already installed."
            continue
        fi

        if utils::confirm "Install module: $module"; then
            echo
            logging::info "Installing module: $module"
            if ! sysprov::install_module "$module"; then
                exit 1
            fi
        fi
        echo
    done
}

main() {
    while getopts 'h:' opt; do
        case $opt in
            h) sysprov_help && exit 0 ;;
            *) ;;
        esac
    done

    sysprov_announce

    echo
    read -n 1 -s -r -p "Press any key to install or Ctrl+C to quit..."
    echo -e "\n\n"

    sysprov_prepare
    sysprov_install
}

(main "$@")
