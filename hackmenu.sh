#!/bin/bash
# Termux Hacking Menu v1.0
# Author: YourName / GitHub: YourUsername

# Ranglar kodlari
RED='\e[1;91m'
GREEN='\e[1;92m'
YELLOW='\e[1;93m'
BLUE='\e[1;94m'
PURPLE='\e[1;95m'
CYAN='\e[1;96m'
WHITE='\e[1;97m'
NC='\e[0m' # Rangni o'chirish

# Chiqishni boshqarish
trap 'printf "\n${YELLOW}[!] Dastur toxtatildi.${NC}\n"; exit 1' 2

banner() {
    clear
    printf "${CYAN}"
    printf " _____                               _   _            _     \n"
    printf "|_   _|                             | | | |          | |    \n"
    printf "  | | ___ _ __ _ __ ___  _   ___  __  | |_| | __ _  ___| | __ \n"
    printf "  | |/ _ \ '__| '_ \` _ \| | | \ \/ /  |  _  |/ _\` |/ __| |/ / \n"
    printf "  | |  __/ |  | | | | | | |_| |>  <   | | | | (_| | (__|   <  \n"
    printf "  \_/\___|_|  |_| |_| |_|\__,_/_/\_\  \_| |_/\__,_|\___|_|\_\\\\\n"
    printf "  ${YELLOW}======= Termux Hacking Tools Suite v1.0 =======${NC}\n\n"
}

# Talab qilinadigan paketlarni avtomat tekshirish va o'rnatish
check_deps() {
    for pkg in git curl python wget clang; do
        if ! command -v $pkg &> /dev/null; then
            printf "${YELLOW}[*] $pkg o'rnatilmoqda...${NC}\n"
            pkg install $pkg -y
        fi
    done
}

# Asbobni o'rnatish uchun yordamchi funksiya
install_tool() {
    local name=$1
    local repo=$2
    local dir=$3
    
    banner
    if [ -d "$HOME/$dir" ]; then
        printf "${GREEN}[+] $name allaqachon o'rnatilgan.${NC}\n"
    else
        printf "${YELLOW}[*] $name yuklab olinmoqda...${NC}\n"
        git clone "$repo" "$HOME/$dir"
        if [ $? -eq 0 ]; then
            printf "${GREEN}[+] $name muvaffaqiyatli o'rnatildi!${NC}\n"
        else
            printf "${RED} [-] Yuklashda xatolik yuz berdi.${NC}\n"
        fi
    fi
    read -p "Davom etish uchun [Enter] bosing..."
}

menu() {
    while true; do
        banner
        printf "${WHITE}[1] ${CYAN}Nmap${WHITE} - Port skanerlash asbobi\n"
        printf "[2] ${CYAN}UserRecon${WHITE} - Username qidiruvchi (OSINT)\n"
        printf "[3] ${CYAN}PhoneInfoga${WHITE} - Telefon raqami razvedkasi\n"
        printf "[4] ${CYAN}Sqlmap${WHITE} - SQL Injection zaifliklarini aniqlash\n"
        printf "[5] ${CYAN}Termux Sozlamalari${WHITE} - Xotira ruxsatini berish\n"
        printf "${WHITE}[0] ${RED}Chiqish${NC}\n\n"
        
        read -p $'\e[1;92m[?] Tanlovni kiriting: \e[0m' choice
        
        case $choice in
            1)
                banner
                if ! command -v nmap &> /dev/null; then
                    printf "${YELLOW}[*] Nmap o'rnatilmoqda...${NC}\n"
                    pkg install nmap -y
                fi
                read -p $'\e[1;96m[?] IP yoki Sayt manzilini kiriting: \e[0m' target
                nmap -v $target
                read -p "Davom etish uchun [Enter] bosing..."
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
                printf "${YELLOW}[*] Storage ruxsati tekshirilmoqda...${NC}\n"
                termux-setup-storage
                sleep 2
                ;;
            0)
                printf "${GREEN}\nXizmatdan foydalanganingiz uchun rahmat! Xayr.${NC}\n"
                exit 0
                ;;
            *)
                printf "${RED}\n[-] Noto'g'ri tanlov! Qaytadan urinib ko'ring.${NC}\n"
                sleep 1.5
                ;;
        esac
    done
}

# Skriptni ishga tushirish qismi
check_deps
menu
