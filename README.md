Dog's Vim.
===
1. 克隆项目。
    ```shell
    $ git clone https://github.com/DogLooksGood/dotfiles
    ```
2. 安装[NeoVim](https://github.com/neovim/neovim)。
3. 复制.nvimrc，并且链接。
    ```shell
    $ cp .nvimrc ~/
    $ cd
    $ mkdir -p .config/nvim/
    $ cd .config/nvim
    $ ln -s ~/.nvimrc init.vim
    ```
4. `nvim`启动，然后安装依赖。

快捷键
===
Leader key
---
*使用`Space`作为Leader key.

Ace Jump
---
<space><space>{any key}
屏幕间代码间跳转。

