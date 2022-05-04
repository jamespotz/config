. "$HOME/.cargo/env"
if [ -e /home/jamespotz/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jamespotz/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PS0="%B%~ %b$ "

export PATH="$HOME/.cargo/bin:$PATH"

# Add Go
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/go/bin:$PATH"

# Add Local bin
export PATH="$HOME/.local/bin:$PATH"

export LIBGL_ALWAYS_INDIRECT=1 #GWSL
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL

# fnm
eval "$(fnm env --use-on-cd)"

