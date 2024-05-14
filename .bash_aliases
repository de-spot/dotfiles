alias cdub='cd ~/Documents/0LocalUbuntu/bin'
alias youtube-dl='~/mybin/youtube-dl -f bestvideo\[height\<=2160\]+bestaudio/best'
alias yt-dlp='~/mybin/yt-dlp -f bestvideo\[height\<=2160\]+bestaudio/best --merge-output-format mkv --remux-video mkv'
alias yt-dlp='~/mybin/yt-dlp -f bestvideo\[height\<=2160\]+bestaudio/best'

alias vdiff='meld'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias rm='rm --preserve-root'
alias chmod='chmod -c --preserve-root'
alias chown='chown -c --preserve-root'
alias chgrp='chgrp -c --preserve-root'

alias vdiff='meld'
alias colorgrep='grep --color=always'
alias diff='colordiff'
alias dufcolor='CLICOLOR_FORCE=1 COLORTERM="yes" watch -c -n 1 duf --width 200'
alias dff='df -T --type=ext2 --type=ext3 --type=ext4 --type=ecryptfs --type=exfat --type=fat32 --type=vfat --type=fuse.sshfs --type=cifs --type=fuseblk --type=jmtpfs --type=fuse.jmtpfs --type=fuse.gocryptfs'

alias dus='du -sc --bytes *|sort -nr|awk "{print \$1,\" \",\$1,\" \",\$2;}"| numfmt --to=iec --field=2|column -t'
alias ports='ss -tanp'
alias portsl='ss -tlnp'
alias grepi='grep --color=auto -i'
# Resume wget by default
alias wget='wget -c'
if ! command -v docker-compose &>/dev/null ; then
  if command -v docker &>/dev/null ; then
    alias docker-compose="docker compose"
  fi
fi
# Dotfiles
# Init: git init --bare ~/.dotfiles

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
# Init: git init --bare ~/.dotfiles
# Clone: git clone --bare git@github.com:de-spot/dotfiles.git $HOME/.dotfiles
# Config: dotfiles config status.showUntrackedFiles no


