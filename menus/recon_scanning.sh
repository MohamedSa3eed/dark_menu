#!/bin/bash

source "menus/utils/colors.sh"
source "menus/utils/state.sh"
source "menus/utils/helper_functions.sh"

options=(
  "Set / Show Target"
  "Network Recon (local)"
  "Port & Service Scans"
  "OS Detection"
  "DNS & Reverse DNS"
  "Fetch robots.txt"
  "WAF Detection (wafw00f)"
  "Directory Bruteforce (dirb)"
  "Back"
)

network_recon(){
  require_tool arp-scan || return; 
  printf "%b[*] Running arp-scan...%b\n" "$YELLOW" "$WHITE";
  arp-scan -l; 
}

port_service_scans(){
  require_tool nmap || return
  t=$(get_target_var)
  if [[ -z "$t" ]]; then read -e -p "Enter target for port scan: " t; fi
  [[ -z "$t" ]] && { echo "No target set."; return; }
  select scan_type in "TCP" "UDP" "Both" "Cancel"; do
    case "$scan_type" in
      "TCP")
        printf "%b[*] Starting TCP Port Scanning...%b\n" "$YELLOW" "$WHITE";
        sudo nmap -p- -sS -sV -T4 $t;
        break;;
      "UDP") 
        printf "%b[*] Starting UDP Port Scanning...%b\n" "$YELLOW" "$WHITE";
        sudo nmap -sU -pU:1-65535 -T2 $t;
        break;;
      "Both") 
        printf "%b[*] Starting TCP and UDP Port Scanning...%b\n" "$YELLOW" "$WHITE";
        sudo nmap -p- -sS -sU -sV -T4 $t;
        break;;
      "Cancel")
        printf "%bScan cancelled.%b\n" "$YELLOW" "$WHITE"; break;;
      *) printf "%bInvalid input.%b\n" "$RED" "$WHITE";;
    esac
  done
}

os_service_detection(){
  require_tool nmap || return
  t=$(get_target_var)
  [[ -z "$t" ]] && { read -e -p "Enter target for OS detection: " t; }
  [[ -z "$t" ]] && { echo "No target set."; return; }
  sudo nmap -O -sV "$t"
}

dns_reverse(){
  read -e -p "Enter domain (leave blank to use target): " domain
  domain=${domain:-$(get_target_var)}
  [[ -z "$domain" ]] && { echo "No domain set."; return; }
  echo "1) dnsrecon  2) host  3) dig (A NS MX)"
  read -e -p "Choose: " c
  case "$c" in
    1) command -v dnsrecon &>/dev/null && dnsrecon -d "$domain" || echo "dnsrecon not installed.";;
    2) host "$domain" || echo "host cmd failed or not available.";;
    3) command -v dig &>/dev/null && dig +noall +answer A NS MX "$domain" || echo "dig not available.";;
    *) echo "Cancelled.";;
  esac
}

fetch_robots(){
  t=$(get_target_var)
  [[ -z "$t" ]] && { read -e -p "Enter host for web recon: " t; }
  [[ -z "$t" ]] && { echo "No target set."; return; }
  printf "%bFetching robots.txt (https then http)...%b\n" "$YELLOW" "$WHITE"
  curl -fsSL "https://$t/robots.txt" || curl -fsSL "http://$t/robots.txt" || echo "Not found."
}

waf_detect(){
  t=$(get_target_var)
  [[ -z "$t" ]] && { read -e -p "Enter host for web recon: " t; }
  [[ -z "$t" ]] && { echo "No target set."; return; }
  printf "\n%bWAF detection (wafw00f)...%b\n" "$YELLOW" "$WHITE"
  command -v wafw00f &>/dev/null && wafw00f -a "$t" || echo "wafw00f not installed."
}

directory_bruteforce(){
  require_tool dirb || return
  t=$(get_target_var)
  [[ -z "$t" ]] && { read -e -p "Enter host for directory bruteforce: " t; }
  [[ -z "$t" ]] && { echo "No target set."; return; }
  dirb "http://$t" || dirb "https://$t"
}

while true; do
  clear
  logo
  printf "%b=== Information Gathering ===%b\n" "$VIO" "$WHITE"
  PS3="Choose: "
  select opt in "${options[@]}"; do
    case "$opt" in
      "Set / Show Target") set_target; break;;
      "Network Recon (local)") network_recon; break;;
      "Port & Service Scans") port_service_scans; break;;
      "OS Detection") os_service_detection; break;;
      "DNS & Reverse DNS") dns_reverse; break;;
      "Fetch robots.txt") fetch_robots; break;;
      "WAF Detection (wafw00f)") waf_detect ; break;;
      "Directory Bruteforce (dirb)") directory_bruteforce; break;;
      "Back") exit 0;;
      *) printf "%bInvalid input.%b\n" "$RED" "$WHITE"; break;;
    esac
  done
  pause
done
