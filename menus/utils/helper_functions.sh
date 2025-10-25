#!/bin/bash

pause(){
  echo -e $YELLOW
  read -rsn1 -p "Press any key to continue..."
  echo -e $WHITE
}

require_tool(){ command -v "$1" &>/dev/null || { printf "%b[!] Missing tool: %s%b\n" "$RED" "$1" "$WHITE"; return 1; } }
