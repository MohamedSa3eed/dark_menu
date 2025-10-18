#!/bin/bash


#        .S_sSSs     .S_SSSs     .S_sSSs     .S    S.          .S_SsS_S.     sSSs   .S_sSSs     .S       S.   
#       .SS~YS%%b   .SS~SSSSS   .SS~YS%%b   .SS    SS.        .SS~S*S~SS.   d%%SP  .SS~YS%%b   .SS       SS.  
#       S%S   `S%b  S%S   SSSS  S%S   `S%b  S%S    S&S        S%S `Y' S%S  d%S'    S%S   `S%b  S%S       S%S  
#       S%S    S%S  S%S    S%S  S%S    S%S  S%S    d*S        S%S     S%S  S%S     S%S    S%S  S%S       S%S  
#       S%S    S&S  S%S SSSS%S  S%S    d*S  S&S   .S*S        S%S     S%S  S&S     S%S    S&S  S&S       S&S  
#       S&S    S&S  S&S  SSS%S  S&S   .S*S  S&S_sdSSS         S&S     S&S  S&S_Ss  S&S    S&S  S&S       S&S  
#       S&S    S&S  S&S    S&S  S&S_sdSSS   S&S~YSSY%b        S&S     S&S  S&S~SP  S&S    S&S  S&S       S&S  
#       S&S    S&S  S&S    S&S  S&S~YSY%b   S&S    `S%        S&S     S&S  S&S     S&S    S&S  S&S       S&S  
#       S*S    d*S  S*S    S&S  S*S   `S%b  S*S     S%        S*S     S*S  S*b     S*S    S*S  S*b       d*S  
#       S*S   .S*S  S*S    S*S  S*S    S%S  S*S     S&        S*S     S*S  S*S.    S*S    S*S  S*S.     .S*S  
#       S*S_sdSSS   S*S    S*S  S*S    S&S  S*S     S&        S*S     S*S   SSSbs  S*S    S*S   SSSbs_sdSSS   
#       SSS~YSSY    SSS    S*S  S*S    SSS  S*S     SS        SSS     S*S    YSSP  S*S    SSS    YSSP~YSSY    
#                          SP   SP          SP                        SP           SP                         
#                          Y    Y           Y                         Y            Y                                                                                             

# ─────────────────────────────
# Colors
# ─────────────────────────────
RED="\e[31m"; GREEN="\e[32m"; BLUE="\e[34m"; YELLOW="\e[33m"; VIO="\e[35m"; CYAN="\e[36m"; WHITE="\e[0m"

# ─────────────────────────────
# Logo
# ─────────────────────────────
logo () { 
  echo -e $GREEN
  cat << "EOF"
   ____                   _                                         
  |  _ \    __ _   _ __  | | __    _ __ ___     ___   _ __    _   _ 
  | | | |  / _` | | '__| | |/ /   | '_ ` _ \   / _ \ | '_ \  | | | |
  | |_| | | (_| | | |    |   <    | | | | | | |  __/ | | | | | |_| |
  |____/   \__,_| |_|    |_|\_\   |_| |_| |_|  \___| |_| |_|  \__,_|
EOF
  echo -e $WHITE
}

# ─────────────────────────────
# Menu options
# ─────────────────────────────
options=(
  "Recon & Scanning"
  "Exploitation Tools"
  "Post-Exploitation"
  "Exit"
)
while true; do
  clear;logo;
  echo -e $BLUE
  PS3="Choose an option: ";export PS3;
  select option in "${options[@]}"
  do 
    case $option in
      'Recon & Scanning')
        ./menus/recon_scanning.sh
        break
        ;;
      'Exploitation Tools')
        ./menus/exploitation_tools.sh
        break
        ;;
      'POST-Exploitation')
        #TODO
        break
        ;;
      Exit)
        echo -e "$RED Goodbye. $WHITE"
        exit 0
        ;;
      *)
        echo -e "$RED Invalid Input. $WHITE"
        break
        ;;
    esac
  done
done
