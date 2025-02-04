# Home directory setup

## Clone configs from github
Create bash alias:
```bash
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
```
Get configs from github (read-only):
```bash
# Read-only 
dotfiles clone https://github.com/de-spot/dotfiles.git
# Read-write
dotfiles clone git@github.com:de-spot/dotfiles.git
```

## Operations
Use `dotfiles` instead of `git` to interact with repository.
```bash
dotfiles pull
dotfiles add ...
dotfiles commit -m "..."
dotfiles push
```
