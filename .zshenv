# . "$HOME/.cargo/env"

export PS0="%B%~ %b$ "

export PATH="$HOME/.cargo/bin:$PATH"

# Add Go
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/go/bin:$PATH"

# Add Local bin
export PATH="$HOME/.local/bin:$PATH"

# Add neovim to path
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

export LIBGL_ALWAYS_INDIRECT=1 #GWSL
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL

export PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/snap/bin:$PATH"
export PATH="/home/jamespotz/.cursor-server/bin/:$PATH"
export PATH="/home/jamespotz/.cursor-server/bin/069284f607cba9bcfab9af796d80cb3698d9a6e0/bin/remote-cli/:$PATH"
