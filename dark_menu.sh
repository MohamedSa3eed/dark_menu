#!/bin/bash
# dark_menu.sh - top-level launcher for the dark_menu toolkit


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
# Menu options
# ─────────────────────────────

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MENUS_DIR="$BASE_DIR/menus"

# load utils
source "$MENUS_DIR/utils/colors.sh" 2>/dev/null || true
source "$MENUS_DIR/utils/state.sh" 2>/dev/null || true

options=(
  "Information Gathering"
  "Exploitation Tools"
  "Post-Exploitation"
  "Exit"
)

# helper: run submenu script by path (checks)
run_menu_script() {
  local script="$1"
  if [[ -x "$script" ]]; then
    ( "$script" )
  elif [[ -f "$script" ]]; then
    bash "$script"
  else
    printf "%bMissing submenu: %s%b\n" "$YELLOW" "$script" "$WHITE"
    sleep 1.2
  fi
}

trap 'printf "%b\nExiting...%b\n" "$YELLOW" "$WHITE"; exit 0' SIGINT SIGTERM

while true; do
  clear
  logo
  printf "%b==== Main Menu ====%b\n" "$VIO" "$WHITE"
  PS3="Choose an option: "
  select opt in "${options[@]}"; do
    case "$opt" in
      "Information Gathering")
        run_menu_script "$MENUS_DIR/recon_scanning.sh"
        break
        ;;
      "Exploitation Tools")
        run_menu_script "$MENUS_DIR/exploitation_tools.sh"
        break
        ;;
      "Post-Exploitation")
        run_menu_script "$MENUS_DIR/post_exploit.sh"
        break
        ;;
      "Exit")
        printf "%bGoodbye.%b\n" "$YELLOW" "$WHITE"
        exit 0
        ;;
      *)
        printf "%bInvalid input.%b\n" "$RED" "$WHITE"
        sleep 1.2
        break
        ;;
    esac
  done
done
