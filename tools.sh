#!/bin/sh

###################### INSTALL ######################

install_getrelationship() {
    wget "https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/getrelationship.py"
    mkdir "${GETRELATIONSHIP_PATH}"
    mv getrelationship.py "${GETRELATIONSHIP_PATH}/getrelationship.py"
    chmod +x "${GETRELATIONSHIP_PATH}/getrelationship.py"
    chown -R "${g_user}:${g_user}" "${GETRELATIONSHIP_PATH}"
    ln -s "${GETRELATIONSHIP_PATH}/getrelationship.py" /usr/bin/getrelationship
}

install_subdomainizer() {
    git clone "https://github.com/nsonaniya2010/SubDomainizer.git" "${WORKING_DIR}/SubDomainizer"
    pip install -r "${WORKING_DIR}/SubDomainizer/requirements.txt"
    mkdir "${SUBDOMAINIZER_PATH}"
    cp "${WORKING_DIR}/SubDomainizer/SubDomainizer.py" "${SUBDOMAINIZER_PATH}"
    chmod +x "${SUBDOMAINIZER_PATH}/SubDomainizer.py"
    chown -R "${g_user}:${g_user}" "${SUBDOMAINIZER_PATH}"
    ln -s "${SUBDOMAINIZER_PATH}/SubDomainizer.py" /usr/bin/subdomainizer
    rm -rf "${WORKING_DIR}/SubDomainizer"
}

install_subscraper() {
    git clone "https://github.com/m8r0wn/subscraper" "${WORKING_DIR}/subscraper"
    cd "${WORKING_DIR}/subscraper"
    python3 setup.py install
    pip install ipparser
    mkdir "${SUBSCRAPER_PATH}"
    mv /usr/bin/subscraper "${SUBSCRAPER_PATH}/subscraper"
    echo '#!/bin/sh' >"${SUBSCRAPER_PATH}/subscraper.sh"
    echo "${SUBSCRAPER_PATH}/subscraper --censys-api ${CENSYS_API_KEY} --censys-secret ${CENSYS_SECRET}" '${@}' >>"${SUBSCRAPER_PATH}/subscraper.sh"
    chmod +x "${SUBSCRAPER_PATH}/subscraper.sh"
    chown -R "${g_user}:${g_user}" "${SUBSCRAPER_PATH}"
    ln -s "${SUBSCRAPER_PATH}/subscraper.sh" /usr/bin/subscraper
    cd -
    rm -rf "${WORKING_DIR}/subscraper"
}

install_shosubgo() {
    git clone "https://github.com/incogbyte/shosubgo" "${SHOSUBGO_PATH}"
    echo '#!/bin/sh' >"${SHOSUBGO_PATH}/shosubgo.sh"
    echo "go run ${SHOSUBGO_PATH}/main.go -s ${SHODAN_API_KEY}" '${@}' >>"${SHOSUBGO_PATH}/shosubgo.sh"
    chmod +x "${SHOSUBGO_PATH}/shosubgo.sh"
    ln -s "${SHOSUBGO_PATH}/shosubgo.sh" /usr/bin/shosubgo
    chown -R "${g_user}:${g_user}" "${SHOSUBGO_PATH}"
}

install_github_search() {
    git clone "https://github.com/gwen001/github-search.git" "${GITHUB_SEARCH_PATH}"
    chown -R "${g_user}:${g_user}" "${GITHUB_SEARCH_PATH}"
}

install_eyewitness() {
    git clone https://github.com/cuvidk/EyeWitness.git "${EYEWITNESS_PATH}"
    chown -R "${g_user}:${g_user}" "${EYEWITNESS_PATH}"
    cd "${EYEWITNESS_PATH}"
    git checkout fix-recursive-symlink-and-bad-pkg-name-arch
    sh "${EYEWITNESS_PATH}/Python/setup/setup.sh"
    ln -s "${EYEWITNESS_PATH}/Python/EyeWitness.py" /usr/bin/eyewitness
    cd -

    # the following issue should be fixed upstream instead; i submitted a pullrequest
    # to their git repository

    #rm -rf /usr/bin/geckodriver
    #geckodriver_x86_64='https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz'
    #wget ${geckodriver_x86_64}
    #tar -xvf geckodriver-v0.26.0-linux64.tar.gz
    #rm geckodriver-v0.26.0-linux64.tar.gz
    #mv geckodriver /usr/bin/geckodriver

    # # firefox is not installed because python3-netaddr is not a valid package (fix this upstream)
    #for package in python-netaddr firefox; do
    #    pacman -S --noconfirm "${package}"
    #done
}

install_subfinder() {
    local version="2.4.5"
    mkdir "${WORKING_DIR}/subfinder"
    cd "${WORKING_DIR}/subfinder"
    wget "https://github.com/projectdiscovery/subfinder/releases/download/v${version}/subfinder_${version}_linux_amd64.tar.gz"
    tar -xzvf "subfinder_${version}_linux_amd64.tar.gz"
    mv subfinder /usr/bin/
    cd -
    rm -rf "${WORKING_DIR}/subfinder"
}

install_massdns() {
    git clone 'https://github.com/blechschmidt/massdns.git' "${WORKING_DIR}/massdns"
    cd "${WORKING_DIR}/massdns"
    make
    mkdir "${MASSDNS_PATH}"
    cp "${WORKING_DIR}/massdns/bin/massdns" "${MASSDNS_PATH}"
    cp -R "${WORKING_DIR}/massdns/lists" "${MASSDNS_PATH}"
    chown -R "${g_user}:${g_user}" "${MASSDNS_PATH}"
    ln -s "${MASSDNS_PATH}/massdns" /usr/bin/massdns
    cd -
    rm -rf "${WORKING_DIR}/massdns"
}

install_masscan() {
    git clone 'https://github.com/robertdavidgraham/masscan' "${WORKING_DIR}/masscan"
    cd "${WORKING_DIR}/masscan"
    make
    mkdir "${MASSCAN_PATH}"
    cp "${WORKING_DIR}/masscan/bin/masscan" "${MASSCAN_PATH}"
    chown -R "${g_user}:${g_user}" "${MASSCAN_PATH}"
    ln -s "${MASSCAN_PATH}/masscan" /usr/bin/masscan
    cd -
    rm -rf "${WORKING_DIR}/masscan"
}

install_dnmasscan() {
    git clone "https://github.com/rastating/dnmasscan.git" "${WORKING_DIR}/dnmasscan"
    mkdir "${DNMASSCAN_PATH}"
    cp "${WORKING_DIR}/dnmasscan/dnmasscan" "${DNMASSCAN_PATH}"
    chown -R "${g_user}:${g_user}" "${DNMASSCAN_PATH}"
    ln -s "${DNMASSCAN_PATH}/dnmasscan" /usr/bin/dnmasscan
    rm -rf "${WORKING_DIR}/dnmasscan"
}

install_nmap() {
    pacman -S --noconfirm nmap
}

install_medusa() {
    pacman -S --noconfirm medusa
}

install_brutespray() {
    git clone "https://github.com/x90skysn3k/brutespray.git" "${WORKING_DIR}/brutespray"
    mkdir "${BRUTESPRAY_PATH}"
    pip install -r "${WORKING_DIR}/brutespray/requirements.txt"
    cp "${WORKING_DIR}/brutespray/brutespray.py" "${BRUTESPRAY_PATH}"
    chown -R "${g_user}:${g_user}" "${BRUTESPRAY_PATH}"
    ln -s "${BRUTESPRAY_PATH}/brutespray.py" /usr/bin/brutespray
    cp -r "${WORKING_DIR}/brutespray/wordlist/" "${WORDLISTS_PATH}/brutespray"
    rm -rf "${WORKING_DIR}/brutespray"
}

install_favfreak() {
    git clone "https://github.com/devanshbatham/FavFreak" "${WORKING_DIR}/FavFreak"
    mkdir "${FAVFREAK_PATH}"
    pip install -r "${WORKING_DIR}/FavFreak/requirements.txt"
    cp "${WORKING_DIR}/FavFreak/favfreak.py" "${FAVFREAK_PATH}"
    chmod +x "${FAVFREAK_PATH}/favfreak.py"
    chown -R "${g_user}:${g_user}" "${FAVFREAK_PATH}"
    ln -s "${FAVFREAK_PATH}/favfreak.py" /usr/bin/favfreak
    rm -rf "${WORKING_DIR}/FavFreak"
}

install_sqlmap() {
    pacman -S --noconfirm sqlmap
}

create_wordlist() {
    mkdir -p "${WORDLISTS_PATH}"
}

fix_wordlists_owner() {
    chown -R "${g_user}:${g_user}" "${WORDLISTS_PATH}"
}

install_all() {
    #install_eyewitness
    create_wordlist
    install_getrelationship
    install_subdomainizer
    install_subscraper
    install_shosubgo
    install_github_search
    install_subfinder
    install_massdns
    install_masscan
    install_dnmasscan
    install_nmap
    install_medusa
    install_brutespray
    install_favfreak
    install_sqlmap
    fix_wordlists_owner
}

###################### UNINSTALL ######################

remove_getrelationship() {
    rm -rf "${GETRELATIONSHIP_PATH}"
    rm -rf /usr/bin/getrelationship
}

remove_subdomainizer() {
    rm -rf "${SUBDOMAINIZER_PATH}"
    rm -rf /usr/bin/subdomainizer
}

remove_subscraper() {
    rm -rf "${SUBSCRAPER_PATH}"
    rm -rf /usr/bin/subscraper
}

remove_shosubgo() {
    rm -rf "${SHOSUBGO_PATH}"
    rm -rf /usr/bin/shosubgo
}

remove_github_search() {
    rm -rf "${GITHUB_SEARCH_PATH}"
}

remove_eyewitness() {
    rm -rf "${EYEWITNESS_PATH}"
    rm -rf /usr/bin/eyewitness
    # eyewitness has a custom installer that installs
    # a lot of dependencies; I cannot delete those manually
    # because a lot of them may be required by other software
}

remove_subfinder() {
    rm -rf /usr/bin/subfinder
}

remove_massdns() {
    rm -rf "${MASSDNS_PATH}"
    rm -rf /usr/bin/massdns
}

remove_masscan() {
    rm -rf "${MASSCAN_PATH}"
    rm -rf /usb/bin/masscan
}

remove_dnmasscan() {
    rm -rf "${DNMASSCAN_PATH}"
    rm -rf /usr/bin/dnmasscan
}

remove_nmap() {
    pacman -Rs --noconfirm nmap
}

remove_medusa() {
    pacman -Rs --noconfirm medusa
}

remove_brutespray() {
    rm -rf "${BRUTESPRAY_PATH}"
    rm -rf /usr/bin/brutespray
}

remove_favfreak() {
    rm -rf "${FAVFREAK_PATH}"
    rm -rf /usr/bin/favfreak
}

remove_sqlmap() {
    pacman -Rs --noconfirm sqlmap
}

remove_wordlists() {
    rm -rf "${WORDLISTS_PATH}"
}

remove_all() {
    #remove_eyewitness
    remove_getrelationship
    remove_subdomainizer
    remove_subscraper
    remove_shosubgo
    remove_github_search
    remove_subfinder
    remove_massdns
    remove_masscan
    remove_dnmasscan
    remove_nmap
    remove_medusa
    remove_brutespray
    remove_favfreak
    remove_sqlmap
    remove_wordlists
}

#######################################################

WORKING_DIR="$(realpath "$(dirname "${0}")")"

. "${WORKING_DIR}/config-files/install_paths.sh"

export GOPATH="${PATH_GOLANG}"
GO_PACKAGE_PATH="${PATH_GOLANG}"

EYEWITNESS_PATH='/opt/eyewitness'
GETRELATIONSHIP_PATH='/opt/getrelationship'
SUBDOMAINIZER_PATH='/opt/subdomainizer'
SUBSCRAPER_PATH='/opt/subscraper'
SHOSUBGO_PATH='/opt/shosubgo'
GITHUB_SEARCH_PATH='/opt/github-search'
MASSDNS_PATH='/opt/massdns'
MASSCAN_PATH='/opt/masscan'
DNMASSCAN_PATH='/opt/dnmasscan'
BRUTESPRAY_PATH='/opt/brutespray'
FAVFREAK_PATH='/opt/favfreak'

usage() {
    echo "Usage: ${0} <install|remove> [--user <user_owning_tools>]"
}

if [ $(id -u) -ne 0 ]; then
    echo "Run this as root."
    exit 1
fi

case "${1}" in
    "install")
        operation=install_all
        shift
        ;;
    "remove")
        operation=remove_all
        shift
        ;;
    *)
        usage
        exit 2
        ;;
esac

g_user="root"
if [ $# -gt 0 ]; then
    case "${1}" in
        "--user")
            g_user="${2}"
            ;;
        *)
            usage
            exit 3
            ;;
    esac
fi

if [ "$(cat /etc/passwd | grep "${g_user}" | cut -d ':' -f1)" != "${g_user}" ]; then
    echo "Unknown user ${g_user}"
    exit 4
fi

${operation}
