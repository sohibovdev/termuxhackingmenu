# Termux Hacking Menu (THM) 📱💀

An interactive, user-friendly, and automated Bash-based CLI menu that consolidates standard Penetration Testing and OSINT tools directly inside the **Termux** environment. 

## ✨ Features
- 🛠 **Auto-Dependency Installer:** Automatically checks and installs required core components (`git`, `curl`, `python`, etc.) on first launch.
- 🎨 **Visual UI:** Built with sleek ASCII arts and distinct color-coded prompts.
- 🚀 **One-Click Installation:** Fetch and boot well-known offensive security tools directly from the menu.

## 📱 Integrated Tools
- **Nmap:** Direct network scanner integrations.
- **UserRecon:** Fast Open Source Intelligence (OSINT) username tracking.
- **PhoneInfoga:** Advanced information gathering framework for international phone numbers.
- **Sqlmap:** Automated SQL injection testing script wizard.

## 🛠 Setup & Run Instructions

Open your Termux application and execute the following commands sequently:

```bash
# Update local packages
pkg update && pkg upgrade -y

# Clone this repository
git clone https://github.com
cd termuxhackingmenu

# Make the wrapper executable
chmod +x hackmenu.sh

# Fire up the engine
./hackmenu.sh
```

## 📋 Prerequisites
The program will handle sub-dependencies autonomously, but ensure your core shell has execution rights. Works seamlessly on non-rooted Android environments via Termux app.

## ⚠️ Legal Disclaimer
This script is explicitly designed for educational purposes, defensive system hardening, and authorized penetration testing campaigns. The developer takes zero accountability for illegal exploitation or unintended infrastructural damage.
