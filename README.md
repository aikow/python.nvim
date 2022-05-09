# python.nvim

This repository contains some python specific code I've extracted from my neovim
config.

## Features and Integrations

- Automatic formatting with the `require('python.nvim').format()`
    
    - [black](https://github.com/psf/black)
    - [isort](https://github.com/PyCQA/isort)

- Linting of the current file with `require('python.nvim').flake8()`

    - This opens the results of flake8 in a new buffer with some added syntax
      highlighting

## To Do

- Add open flake8 lint results in a quickfix list to enable fast jumping.
