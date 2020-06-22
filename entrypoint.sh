#!/usr/bin/env sh

#usermod -u "${UID}" neovim
#groupmod -g "${GID}" neovim
cd "${WORKSPACE}" && \
	# su-exec neovim nvim --cmd 'set shada+=/home/neovim/.local/share/nvim/main.shada' +UpdateRemotePlugins +qall && \
	su-exec neovim nvim +UpdateRemotePlugins +PlugUpdate +qall && \
    su-exec neovim nvim +'split | te python3' "$@"

