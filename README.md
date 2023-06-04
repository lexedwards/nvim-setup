# NeoVim Setup

A Neovim config based on [LazyVim](https://lazyvim.org).

## Getting Started

> If there's a current neovim setup, it's wise to back it up.

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

```bash
git clone git@github.com:lexedwards/nvim-setup.git ~/.config/nvim
```

## Installation

### Nerd Font

Visit [Nerd Fonts](https://www.nerdfonts.com/font-downloads), download and install your favourite font.

Use it as in your choice of terminal; i.e. iTerm2.

### Core Packages

Included is a convenient `Brewfile` (MacOS) to install all core and useful utilities.

To install them, use `brew bundle install --file=~/.config/nvim/Brewfile`. On other systems, inspect the packages in the list and install them manually.
 

## Language Support

* Go
* Javascript
* Rust
* Typescript
