eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# wsl.exe -d wsl-vpnkit service wsl-vpnkit start
wsl.exe -d wsl-vpnkit service wsl-vpnkit status >/dev/null || \
  wsl.exe -d wsl-vpnkit service wsl-vpnkit start
