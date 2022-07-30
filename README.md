# dotfiles
- Tools / Preference for my development workflow
- Tmux x Neovim x Zsh
- Script for quick development environment restore

Table of Contents
=================

* [Introduction](#introduction)
* [Tools](#tools)
* [Preference](#preference)
* [Installation](#installation)
* [FAQ](#faq)
* [Great Resources](#great-resources)

## Tools

### Zsh
[Z shell - Wikipedia](https://en.wikipedia.org/wiki/Z_shell)
> The Z shell (Zsh) is a Unix shell that can be used as an interactive login shell and as a command interpreter for shell scripting. Zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh.

### Zim
[zimfw/zimfw: Zim: Modular, customizable, and blazing fast Zsh framework](https://github.com/zimfw/zimfw)
> Zim is a Zsh configuration framework that bundles a [plugin manager](https://github.com/zimfw/zimfw#usage), useful [modules](https://zimfw.sh/docs/modules/), and a wide variety of [themes](https://zimfw.sh/docs/themes/), without compromising on [speed](https://github.com/zimfw/zimfw/wiki/Speed).

### Neovim
[Neovim](https://neovim.io/)
> Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from [Stevie](https://en.wikipedia.org/wiki/Stevie_%28text_editor%29)). It is not a rewrite but a continuation and extension of Vim. Many clones and derivatives exist, some very clever—but none are Vim. Neovim is built for users who want the good parts of Vim, and more.

### Tmux
[Getting Started · tmux/tmux Wiki](https://github.com/tmux/tmux/wiki/Getting-Started)
> tmux is a program which runs in a terminal and allows multiple other terminal programs to be run inside it. Each program inside tmux gets its own terminal managed by tmux, which can be accessed from the single terminal where tmux is running - this called multiplexing and tmux is a terminal multiplexer.

### stow
[Stow - GNU Project - Free Software Foundation](https://www.gnu.org/software/stow/)
[Documentation (Stow)](https://www.gnu.org/software/stow/manual/html_node/index.html)

> GNU Stow is a symlink farm manager which takes distinct packages of software and/or data located in separate directories on the filesystem, and makes them appear to be installed in the same place. For example, `/usr/local/bin` could contain symlinks to files within `/usr/local/stow/emacs/bin`, `/usr/local/stow/perl/bin` etc., and likewise recursively for any other subdirectories such as `.../share`, `.../man`, and so on.

### asdf
[asdf-vm/asdf: Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more](https://github.com/asdf-vm/asdf)
> asdf is a CLI tool that can manage multiple language runtime versions on a per-project basis. It is like `gvm`, `nvm`, `rbenv` & `pyenv` (and more) all in one! Simply install your language's plugin!

### fzf
[junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)
> fzf is a general-purpose command-line fuzzy finder.
> It's an interactive Unix filter for command-line that can be used with any list; files, command history, processes, hostnames, bookmarks, git commits, etc.

### ripgrep
[BurntSushi/ripgrep: ripgrep recursively searches directories for a regex pattern while respecting your gitignore](https://github.com/BurntSushi/ripgrep)
> ripgrep is a line-oriented search tool that recursively searches the current directory for a regex pattern. By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files. ripgrep is similar to other popular search tools like The Silver Searcher, ack and grep.

### bat
[sharkdp/bat: A cat(1) clone with wings.](https://github.com/sharkdp/bat)
> A _cat(1)_ clone with syntax highlighting and Git integration.

### zoxide
[ajeetdsouza/zoxide: A smarter cd command. Supports all major shells.](https://github.com/ajeetdsouza/zoxide)
>zoxide is a **smarter cd command**, inspired by z and autojump.
>It remembers which directories you use most frequently, so you can "jump" to them in just a few keystrokes.

### exa
[exa · a modern replacement for ls](https://the.exa.website/)
> **exa** is an improved file lister with more features and better defaults. It uses colours to distinguish file types and metadata. It knows about symlinks, extended attributes, and Git. And it’s small, fast, and just one single binary.

---

### wget
[Wget - GNU Project - Free Software Foundation](https://www.gnu.org/software/wget/)
> GNU Wget is a [free software](https://www.gnu.org/philosophy/free-sw) package for retrieving files using HTTP, HTTPS, FTP and FTPS, the most widely used Internet protocols. It is a non-interactive commandline tool, so it may easily be called from scripts, `cron` jobs, terminals without X-Windows support, etc.

### httpie
- [httpie/httpie: As easy as /aitch-tee-tee-pie/ 🥧 Modern, user-friendly command-line HTTP client for the API era. JSON support, colors, sessions, downloads, plugins & more](https://github.com/httpie/httpie)
- [HTTPie 3.2.1 (latest) docs](https://httpie.io/docs/cli)
 > Its goal is to make CLI interaction with web services as human-friendly as possible. HTTPie is designed for testing, debugging, and generally interacting with APIs & HTTP servers. The `http` & `https` commands allow for creating and sending arbitrary HTTP requests. They use simple and natural syntax and provide formatted and colorized output.

---

### tig
[Introduction · Tig - Text-mode interface for Git](https://jonas.github.io/tig/)
> Tig is an ncurses-based text-mode interface for git. It functions mainly as a Git repository browser, but can also assist in staging changes for commit at chunk level and act as a pager for output from various Git commands.


### diff-highlight
[git and diff-highlight | michaelheap.com](https://michaelheap.com/git-and-diff-highlight/#:~:text=diff%2Dhighlight%20is%20a%20contrib,%2C%20not%20entire%20lines%2Fparagraphs.)
> diff-highlight is a contrib script that ships with git. It's a better way to visualise a diff when the changes are small words, not entire lines/paragraphs.

---

### htop
- [htop - an interactive process viewer](https://htop.dev/)
- [htop-dev/htop: htop - an interactive process viewer](https://github.com/htop-dev/htop)
> a cross-platform interactive process viewer. It is a text-mode application (for console or X terminals) and requires ncurses.
> `htop` allows scrolling the list of processes vertically and horizontally to see their full command lines and related information like memory and CPU consumption. Also system wide information, like load average or swap usage, is shown.

### gnu-sed / gnu-time
- [GNU sed - GNU Project - Free Software Foundation](https://www.gnu.org/software/sed/)
- [GNU Time - GNU Project - Free Software Foundation](https://www.gnu.org/software/time/)

We will need gsed / gtime in some scripts of our projects

## Preference

### General
- disable homebrew auto update
- enable vim mode in command line

### Zsh - .zimrc / .zshrc
- zmodule setup in `.zimrc`
- aliases / ENV setup in `.zshrc` / `.zshenv` (for run commands in vim)

### Tmux - tmux.conf
- remap prefix key to `

### NeoVim - init.vim
- remap mapleader to `,`
- ale-linters will need dependencies
    - clj-kondo
    - rubocop

### Git - tigrc
[tigrc(5) · Tig - Text-mode interface for Git](https://jonas.github.io/tig/doc/tigrc.5.html)


### Ruby - default - gems / pryrc
- disable gem doc install to save time
- will install gems after Ruby installed (trigger by asdf Ruby plugin)
    - bundler, to manage Ruby dependencies
    - pry, a better irb
    - awesome_print, a better printer in pry
    - mailcatcher, for email testing
- `.pryrc` have several commands / remap for project development
    - `change-password`
    - `at` => `whereami`
    - `ep` => `exit-program`

### Clojure - deps.edn
- [seancorfield/dot-clojure: My .clojure/deps.edn file](https://github.com/seancorfield/dot-clojure)


## Installation

install `zsh` first, and set `zsh`  as your default shell

`chsh -s /bin/zsh`

then run:

`git clone git@github.com:Springok/dotfiles.git ~/dotfiles`

`~/dotfiles/setup_env.zsh`

### Things ain’t automated in setup script
- Install tmux plugins
    - `prefix key + I` after running setup script
- install `tmux-color256` (or you can use `xterm-256color` in `tmux.conf`)
    - `sudo /usr/bin/tic -x ./tmux-256color.src`
- Install fonts
    - `brew tap homebrew/cask-fonts
    - `brew install --cask font-hack-nerd-font
    - https://www.nerdfonts.com/


##  FAQ

    - What is vm?
    - What is wscript?
    - Private project vim-abagile.git
    - proj?

## Great Resources

### General
- [Dotfiles – What is a Dotfile and How to Create it in Mac and Linux](https://www.freecodecamp.org/news/dotfiles-what-is-a-dot-file-and-how-to-create-it-in-mac-and-linux/)
- [15 Command Line Tools which Spark Joy in Your Terminal - jmfayard.dev](https://jmfayard.dev/posts/15-command-line-tools-which-spark-joy-in-your-terminal-45ln/#%20sharkdpbat-a-cat1-clone-with-wings)
- [Managing dotfiles with GNU Stow | Bastian Venthur's Blog](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html)

### Vim / Neovim

### Tmux
- [Getting Started · tmux/tmux Wiki](https://github.com/tmux/tmux/wiki/Getting-Started)
- [Tmux Cheat Sheet & Quick Reference](https://tmuxcheatsheet.com/)

### Ruby


### Clojure
- [seancorfield/clj-new: Generate new projects based on clj, Boot, or Leiningen Templates!](https://github.com/seancorfield/clj-new)
- [dot-clojure/deps.edn at develop · seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure/blob/develop/deps.edn)

