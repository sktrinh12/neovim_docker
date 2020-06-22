FROM alpine:latest as builder

WORKDIR /mnt/build/ctags

RUN apk add \
	git \
	xfce4-dev-tools \
	build-base

RUN \
	git clone https://github.com/universal-ctags/ctags \
	&& cd ctags \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install

ENV RG_VERSION=11.0.2

RUN set -x \
    && wget https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz \
    && tar xzf ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz \
    && mv ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg /rg

FROM alpine:latest

ENV \
    UNAME="neovim" \
    GNAME="neovim" \
    SHELL="/bin/sh" \
    WORKSPACE="/mnt/workspace" \
    NVIM_CONFIG="/home/neovim/.config/nvim" \
    NVIM_PCK="/home/neovim/.local/share/nvim/site/pack" \
    ENV_DIR="/home/neovim/.local/share/vendorvenv" \
    NVIM_PROVIDER_PYLIB="python3_neovim_provider" \
    PATH="/home/neovim/.local/bin:${PATH}"

COPY --from=builder /usr/local/bin/ctags /usr/local/bin

COPY --from=builder /rg /usr/local/bin/

RUN \
	# install packages
	#apk --no-cache --update add \
	apk --update add \
		# for setting time zone
	tzdata \
		# needed by neovim :CheckHealth to fetch info
	curl \
		# needed to change uid and gid on running container
	shadow \
		# needed to install apk packages as neovim user on the container
	sudo \
		# needed to switch user
        su-exec \
		# needed for neovim python3 support
	python3 \
		# pip
	py-pip \
		# needed for pipsi
	py3-virtualenv \
		# text editor
        neovim \
        neovim-doc \
		# add fuzzy finder
	fzf \
		# needed to install fzf
	bash \
	git \
		#copy paste from editor
	xclip \
		# set the locale to UTF
	&& cp /usr/share/zoneinfo/America/New_York /etc/localtime \
	&& rm -r /usr/share/zoneinfo/Africa \
	&& rm -r /usr/share/zoneinfo/Antarctica \
	&& rm -r /usr/share/zoneinfo/Arctic \
	&& rm -r /usr/share/zoneinfo/Asia \
	&& rm -r /usr/share/zoneinfo/Atlantic \
	&& rm -r /usr/share/zoneinfo/Australia \
	&& rm -r /usr/share/zoneinfo/Europe  \
	&& rm -r /usr/share/zoneinfo/Indian \
	&& rm -r /usr/share/zoneinfo/Mexico \
	&& rm -r /usr/share/zoneinfo/Pacific \
	&& rm -r /usr/share/zoneinfo/Chile \
	&& rm -r /usr/share/zoneinfo/Canada \
	&& echo "America/New_York" > /etc/timezone \
	# install build packages
	&& apk --no-cache add --virtual build-dependencies \
	python3-dev \
	gcc \
	musl-dev \
	# create user
	&& addgroup "${GNAME}" \
	&& adduser -D -G "${GNAME}" -g "" -s "${SHELL}" "${UNAME}" \
	# enable no password for the user and all cmds
    && echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
	# install neovim python3 provider in virtualenv
	&& sudo -u neovim python3 -m venv "${ENV_DIR}/${NVIM_PROVIDER_PYLIB}" \
	&& "${ENV_DIR}/${NVIM_PROVIDER_PYLIB}/bin/pip" install --upgrade pip \
	pynvim  \
	neovim \
	msgpack \
	jedi \
	# install pipsi and python language server
	&& curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | sudo -u neovim python3 \
	&& sudo -u neovim pipsi install python-language-server \
	# install plugins & vim-plug
	&& curl -fLo "${NVIM_PCK:0:-4}/autoload/plug.vim" --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
	&& mkdir -p "${NVIM_PCK}/common/start" "${NVIM_PCK}/filetype/start" "${NVIM_PCK}/colors/opt" \
	#"${NVIM_PCK}/fzf" \
	#&& touch "${NVIM_PCK}/fzf/test_file" && ls "${NVIM_PCK}/fzf" \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/tpope/vim-commentary \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/tpope/vim-surround \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/tpope/vim-obsession \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 2 https://github.com/yuttie/comfortable-motion.vim \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/wellle/targets.vim \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/SirVer/ultisnips \
	&& git -C "${NVIM_PCK}/filetype/start" clone --depth 1 https://github.com/mattn/emmet-vim \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/autozimu/LanguageClient-neovim \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/scrooloose/nerdtree \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/scrooloose/syntastic \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/zchee/deoplete-jedi \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/Shougo/deoplete.nvim \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/tpope/vim-fugitive \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/bling/vim-airline \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/sk1418/Join \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/alvan/vim-closetag \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/Xuyuanp/nerdtree-git-plugin \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/ryanoasis/vim-devicons \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/jpalardy/vim-slime \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/hanschen/vim-ipython-cell \
	&& git -C "${NVIM_PCK}/common/start" clone --depth 1 https://github.com/davidhalter/jedi \
	#&& git -C "${NVIM_PCK}/fzf" clone --depth 1 https://github.com/junegunn/fzf.git \
	#&& cd "${NVIM_PCK}/fzf" && ls "${NVIM_PCK}/fzf/fzf" && "${NVIM_PCK}/fzf/fzf/install" \
	&& cd "${NVIM_PCK}/common/start/LanguageClient-neovim/" && sh install.sh \
	&& mkdir -p /home/neovim/.local/share/nvim/shada \
	&& touch /home/neovim/.local/share/nvim/main.shada \
	&& chown -R neovim:neovim /home/neovim/.local \
	&& chown 0600 /home/neovim/.local/share/nvim/main.shada \
	# remove build packages
	&& apk del build-dependencies

ENV TZ America/New_York
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TERM=xterm-256color

COPY entrypoint.sh /usr/local/bin/ 

VOLUME "${WORKSPACE}"
VOLUME "${NVIM_CONFIG}"

#change the install dir for fzf in nvim (no need since we pass this argument into docker run -it)
#RUN sed -i "s#/usr/local/opt/fzf/#/${NVIM_PCK}/fzf/fzf#g" /.config/nvim/init.vim

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
