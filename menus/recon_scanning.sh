#!/bin/bash

# ─────────────────────────────
# Colors
# ─────────────────────────────
RED="\e[31m"; GREEN="\e[32m"; BLUE="\e[34m"; YELLOW="\e[33m"; VIO="\e[35m"; CYAN="\e[36m"; WHITE="\e[0m"

# ─────────────────────────────
# Menu options
# ─────────────────────────────
options=(
  "Scan Other Hosts"
  "Port Scan"
  "Target OS Detection"
  "Get DNS Records"
  "Reverse DNS"
  "Get robots.txt"
  "WAF Scanning"
  "Back"
)

pause(){
  echo -e $YELLOW
  read -rsn1 -p "Press any key to continue..."
  echo -e $WHITE
}

get_target(){
  echo -e $CYAN 
  read -e -p "Enter the target name [${target:-none}]: " input
  echo -e $WHITE
  # If user pressed Enter, keep previous; otherwise update
  if [[ -n $input ]]; then
    target=$input
  fi
}

scan_other_hosts(){
  echo -e "$YELLOW[*] Starting Network Devices Scanning...$WHITE"
  arp-scan -l
}

port_scan(){
  get_target
  echo -e "$YELLOW[*] Starting TCP Port Scanning...$WHITE"
  nmap -p- -sS -sV -T4 $target
  echo -e "$YELLOW[*] Starting UDP Port Scanning...$WHITE"
  nmap -sU -pU:1-65535 -T2 $target
}

target_os_detection(){
  get_target
  echo -e "$YELLOW[*] Starting OS Scanning...$WHITE"
  nmap -O -sV $target
}

get_dns_records(){
  get_target
  echo -e "$YELLOW[*] Starting DNS Scanning...$WHITE"
  dnsrecon -d $target
}

reverse_dns(){
  get_target
  echo -e "$YELLOW[*] Starting Reverse DNS Scanning...$WHITE"
  host $target
}

get_robots(){
  get_target
  echo -e "$YELLOW[*] Retreving robots.txt...$WHITE"
  curl https://$target/robots.txt
}

waf_scan(){
  get_target
  echo -e "$YELLOW[*] Starting WAF Scanning...$WHITE"
  wafw00f -a $target
}

while true; do
  clear
  echo -e $VIO
  PS3="Choose an option: ";export PS3;
  select option in "${options[@]}"
  do 
    case $option in
      'Scan Other Hosts')
        scan_other_hosts
        break
        ;;
      'Port Scan')
        port_scan
        break
        ;;
      'Target OS Detection')
        target_os_detection
        break
        ;;
      'Get DNS Records')
        get_dns_records
        break
        ;;
      'Reverse DNS')
        reverse_dns
        break
        ;;
      'Get robots.txt')
        get_robots
        break
        ;;
      'WAF Scanning')
        waf_scan
        break
        ;;
      Back)
        exit 0
        ;;
      *)
        echo -e "$RED Invalid Input. $WHITE"
        break
        ;;
    esac
  done
  pause
done
