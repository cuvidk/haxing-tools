#!/bin/sh

SCRIPT_DIR="$(realpath "$(dirname "${0}")")"
. "${SCRIPT_DIR}/../config-files/shell-utils/util.sh"
. "${SCRIPT_DIR}/../config-files/paths.sh"
. "${SCRIPT_DIR}/../paths.sh"

install() {(
    set -e
    git clone 'https://github.com/robertdavidgraham/masscan' "${SCRIPT_DIR}/masscan"
    cd "${SCRIPT_DIR}/masscan"
    make
    mkdir -p "${PATH_MASSCAN}"
    cp "${SCRIPT_DIR}/masscan/bin/masscan" "${PATH_MASSCAN}"
    ln -s "${PATH_MASSCAN}/masscan" /usr/bin/masscan
    cd -
    rm -rf "${SCRIPT_DIR}/masscan"
)}

uninstall() {(
    set -e
    rm -rf /usr/bin/masscan
    rm -rf "${PATH_MASSCAN}"
)}

usage() {
    print_msg "Usage: ${0} <install | uninstall> [--verbose]"
}

main() { 
    setup_verbosity "${@}"

    case "${1}" in
        "install")
            perform_task install 'installing masscan'
            ;;
        "uninstall")
            perform_task uninstall 'uninstalling masscan'
            ;;
        *)
            usage
            exit 1
            ;;
    esac

    check_for_errors
}

main "${@}"