# NeovimDocker

Attempt to dockerize a neovim IDE with fzf, python autocomplete (deoplete), ipython capabilities (vim-slime) and other popular vim plugins

## Code borrowed from:  

* <https://github.com/nicodebo/neovim-docker>

## Run from console/bash

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
