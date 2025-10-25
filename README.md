# dark_menu — simple Bash pentesting toolkit
A lightweight, extensible Bash menu system to help you organize common penetration-testing tasks (recon, web exploitation, post-exploitation).
Designed for learning and quick interactive workflows on your local machine. Scripts are small, self-contained, and easy to extend.

## What this project includes
```bash
dark_menu/
├── dark_menu.sh                    # top-level launcher
└── menus/
    ├── utils/
    │   ├── colors.sh               # color variables
    │   ├── helper_functions.sh     # reusable functions for the script
    │   └── state.sh                # simple persistent state (.dark_menu_state)
    ├── recon_scan.sh               # Information Gathering (network & web recon)
    └── exploitation_tools.sh       # Exploitation menu ->  XSS/SQLi helpers (GET/POST support), netcat listener
```
The project uses a tiny state file `.dark_menu_state` to keep the last-used `target` and `url`. No external database.
## Quickstart — install & run
1. Clone / copy the dark_menu folder to your machine, and make scripts executable:
```bash
git clone https://github.com/MohamedSa3eed/dark_menu.git
cd dark_menu
chmod -R +x dark_menu.sh menus
```
2. Run the menu:
```bash
./dark_menu.sh
```
3. Navigate via the numbered menu prompts.

## Dependencies
The toolkit uses external tools for scanning and exploitation. Install the ones you need:

### Common:
- `bash` (>= 4 recommended)
- `curl`
- `nc` (netcat)

### Recon / scanning:
- `nmap`
- `arp-scan` (network discovery)
- `dnsrecon` or `dig` or `host`
- `wafw00f` (WAF detection)
- `dirb` (directory brute-force)
### Exploitation:
- `xsser` (XSS automation)
- `sqlmap` (SQL injection)

### Install example (Debian/Ubuntu/kali):

```bash
sudo apt update
sudo apt install nmap arp-scan dnsrecon wafw00f xsser sqlmap curl netcat dirb
```
## Outputs & logs
State (last `target` and `url`) is persisted to `.dark_menu_state` in the repo root.

## Security, legality & responsible use
- This toolkit is for educational and authorized testing only.
- Do not run scans, exploitation, or other intrusive actions against systems you do not own or do not have explicit permission to test.
- You are responsible for complying with local laws, organizational policies, and ethical guidelines. Use this toolkit only in legal, ethical contexts (your lab, CTFs, or explicit engagements).
## Tips & troubleshooting
- If a submenu reports a missing tool, install it or skip that option.
- If `xsser` or `sqlmap` behaves differently on your system, check tool versions (`xsser --help`, `sqlmap --help`) and adjust flags inside `menus/exploitation_tools.sh`.
## Future enhancements (ideas)
1. Implementing `post_exploit.sh`.
1. Per-target output directories and automatic saving of command outputs.
1. Add fzf-based target selection (multi-target history).
1. Add Hyprland floating terminal integration (open scans in terminals).
1. Add more scanners/wrappers: `ffuf`, `nikto`, `gobuster`, `linpeas`, `pspy`.
1. Better cookie/header handling and CSRF token helpers.

## Contributing
Contributions are welcome! If you have suggestions for new features or improvements, please feel free to submit a pull request or open an issue on the GitHub repository.

