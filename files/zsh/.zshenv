# Default programs
export VISUAL="nvim"
export EDITOR="nvim"
export PAGER="less"
export BROWSER="firefox"
export TERMINAL="st"

# XDG compliance
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

# Runtime
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR:?}/bus"
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
export TMUX_TMPDIR="${XDG_RUNTIME_DIR}"

# Config
export LESSHISTFILE="-"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch/notmuchrc"
export WEECHAT_HOME="${XDG_CONFIG_HOME}/weechat"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export KUBECONFIG="${XDG_CONFIG_HOME}/kube/config"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME}/java"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle"
export I3BLOCKS_DIR="${XDG_CONFIG_HOME}/i3/i3blocks/blocks"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export MPD_HOST="${XDG_CONFIG_HOME}/mpd/socket"

# Data
export NMBGIT="${XDG_DATA_HOME}/notmuch/nmbug"
export GEM_HOME="${XDG_DATA_HOME}/gem"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass/password-store"
export WINEPREFIX="${XDG_DATA_HOME}/wine"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle"

# Cache
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"

# Pass configuration
export PASSWORD_STORE_CLIP_TIME=20
export PASSWORD_STORE_GENERATED_LENGTH=20

# gpg-agent
GPG_TTY="$(tty)"
export GPG_TTY
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

# PATH
export PATH="${PATH}:${XDG_BIN_HOME}"
