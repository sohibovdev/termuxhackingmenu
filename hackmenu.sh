#!/bin/bash
# Termux Hacking Menu v1.0
# Developed by: whoami

# Color Codes
RED='\e[1;91m'
GREEN='\e[1;92m'
YELLOW='\e[1;93m'
BLUE='\e[1;94m'
PURPLE='\e[1;95m'
CYAN='\e[1;96m'
WHITE='\e[1;97m'
NC='\e[0m' # No Color

# Handle Exit
trap 'printf "\n${YELLOW}[!] Script interrupted by user.${NC}\n"; exit 1' 2

banner() {
    clear
    printf "${CYAN}"
    printf " _____                               _   _            _     \n"
    printf "|_   _|                             | | | |          | |    \n"
    printf "  | | ___ _ __ _ __ ___  _   ___  __  | |_| | __ _  ___| | __ \n"
    printf "  | |/ _ \ '__| '_ \` _ \| | | \ \/ /  |  _  |/ _\` |/ __| |/ / \n"
    printf "  | |  __/ |  | | | | | | |_| |>  <   | | | | (_| | (__|   <  \n"
    printf "  \_/\___|_|  |_| |_| |_|\__,_/_/\_\  \_| |_/\__,_|\___|_|\_\\\\\n"
    printf "  ${RED}[*] Created with passion by: whoami [*]${NC}\n"
    printf "  ${YELLOW}======= Termux Hacking Tools Suite v1.0 =======${NC}\n\n"
}

# Auto-check and install core packages
check_deps() {
    for pkg in git curl python wget clang; do
        if ! command -v $pkg &> /dev/null; then
            printf "${YELLOW}[*] Installing dependency: $pkg...${NC}\n"
            pkg install $pkg -y
        fi
    done
}

# Helper function to install sub-tools
install_tool() {
    local name=$1
    local repo=$2
    local dir=$3
    
    banner
    if [ -d "$HOME/$dir" ]; then
        printf "${GREEN}[+] $name is already installed.${NC}\n"
    else
        printf "${YELLOW}[*] Cloning $name from repository...${NC}\n"
        git clone "$repo" "$HOME/$dir"
        if [ $? -eq 0 ]; then
            printf "${GREEN}[+] $name successfully installed!${NC}\n"
        else
            printf "${RED}[-] Failed to clone $name.${NC}\n"
        fi
    fi
    read -p "Press [Enter] to continue..."
}

menu() {
    while true; do
        banner
        printf "${WHITE}[1] ${CYAN}Nmap${WHITE} - Network & Port Scanner\n"
        printf "[2] ${CYAN}UserRecon${WHITE} - OSINT Username Tracker\n"
        printf "[3] ${CYAN}PhoneInfoga${WHITE} - Phone Number Intelligence\n"
        printf "[4] ${CYAN}Sqlmap${WHITE} - SQL Injection & Takeover Tool\n"
        printf "[5] ${CYAN}Termux Storage${WHITE} - Grant Android Storage Access\n"
        printf "${WHITE}[0] ${RED}Exit Menu${NC}\n\n"
        
        read -p $'\e[1;92m[?] Select an option: \e[0m' choice
        
        case $choice in
            1)
                banner
                if ! command -v nmap &> /dev/null; then
                    printf "${YELLOW}[*] Installing Nmap...${NC}\n"
                    pkg install nmap -y
                fi
                read -p $'\e[1;96m[?] Enter Target IP or Domain: \e[0m' target
                nmap -v $target
                read -p "Press [Enter] to continue..."
                ;;
            2)
                install_tool "UserRecon" "https://github.com" "userrecon"
                if [ -f "$HOME/userrecon/userrecon.sh" ]; then
                    bash $HOME/userrecon/userrecon.sh
                fi
                ;;
            3)
                install_tool "PhoneInfoga" "https://github.com" "phoneinfoga"
                ;;
            4)
                install_tool "Sqlmap" "https://github.com" "sqlmap"
                if [ -d "$HOME/sqlmap" ]; then
                    python3 $HOME/sqlmap/sqlmap.py --wizard
                fi
                ;;
            5)
                banner
                printf "${YELLOW}[*] Requesting storage access...${NC}\n"
                termux-setup-storage
                sleep 2
                ;;
            0)
                printf "${GREEN}\nThank you for using Termux Hacking Menu. Goodbye!\n"
                printf "Brought to you by whoami.${NC}\n"
                exit 0
                ;;
            *)
                printf "${RED}\n[-] Invalid choice! Please try again.${NC}\n"
                sleep 1.5
                ;;
        esac
    done
}

check_deps
menu
