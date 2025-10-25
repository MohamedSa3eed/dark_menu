#!/usr/bin/env bash

# simple ephemeral state persistence for target
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STATE_FILE="$BASE_DIR/.dark_menu_state"

# load existing state
_load_state(){
  if [[ -f "$STATE_FILE" ]]; then
    source "$STATE_FILE"
  fi
}

_save_state(){
  cat > "$STATE_FILE" <<EOF
# dark_menu state (auto-generated)
target="${target:-}"
url="${url:-}"
EOF
}

set_target(){
  _load_state
  printf "%bCurrent target: %b%s%b\n" "$CYAN" "$GREEN" "${target:-<none>}" "$WHITE"
  read -e -p "Enter target (domain or IP) [${target:-none}]: " input
  if [[ -n "$input" ]]; then target="$input"; _save_state; fi
  printf "%bTarget is: %s%b\n" "$BLUE" "${target:-<none>}" "$WHITE"
}

set_url(){
  _load_state
  printf "%bCurrent URL: %b%s%b\n" "$CYAN" "$GREEN" "${url:-<none>}" "$WHITE"
  read -e -p "Enter target URL (including scheme) [${url:-none}]: " input
  if [[ -n "$input" ]]; then url="$input"; _save_state; fi
  printf "%bURL is: %s%b\n" "$BLUE" "${url:-<none>}" "$WHITE"
}

get_target_var(){
  _load_state
  printf "%s" "${target:-}"
}
get_url_var(){
  _load_state
  printf "%s" "${url:-}"
}
