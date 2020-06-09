#!/usr/bin/env sh

#usermod -u "${UID}" neovim
#groupmod -g "${GID}" neovim
#su-exec neovim nvim +PlugInstall +qall 
cd "${WORKSPACE}" && \
	# su-exec neovim nvim --cmd 'set shada+=/home/neovim/.local/share/nvim/main.shada' +UpdateRemotePlugins +qall && \
	su-exec neovim nvim +UpdateRemotePlugins +qall && \
	su-exec neovim nvim --cmd 'split | te python3' "$@"

