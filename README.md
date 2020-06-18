# NeovimDocker

Attempt to dockerize a neovim IDE with fzf, python autocomplete (deoplete), ipython capabilities (vim-slime) and other popular vim plugins. The container is portable and light-weight. Do away with the long process of setting up nvim for each computer. 

## Core code borrowed from:  

* <https://github.com/nicodebo/neovim-docker>

## Run from console
1. First build the container. You may chose your own container name and tag.

```
	docker buid -t neovim-docker:latest .
```


2. Then run the container using:

```
	docker run \
        --rm -it \
        -v $(pwd):/mnt/workspace \
        -v $HOME/.dotfiles/nvim:/home/neovim/.config/nvim \
        neovim-docker:latest \ #name of the docker container
        "$@"
```

## Remarks

Must `cd` into the directory where the files you want to edit are located. The `entrypoint.sh` will launch a python interpreter automatically. In order to send commands from the editor to the REPL; simply move to the terminal pane and type `echo b:terminal_job_id` and enter the output into `:SlimeConfig`.
