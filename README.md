# NeovimDocker

Attempt to dockerize a neovim IDE with python autocomplete and ipython capabilities

## Code borrowed from:  

* <https://github.com/nicodebo/neovim-docker>

## Run from console/bash

```

docker run \
        --rm -it \
        -v $(pwd):/mnt/workspace \
        -v $HOME/.dotfiles/nvim:/home/neovim/.config/nvim \
        nicodebo/neovim-docker:latest \
        "$@"

```

## Remarks

Must `cd` into the directory where the files you want to edit are located.
