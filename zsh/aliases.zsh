# cd
alias ..='cd ..'

# ls
alias ls="ls -F --color=always"
alias l="ls -lAh --color=always"
alias ll="ls -l --color=always"
alias la='ls -A --color=always'

# commands starting with % for pasting from web
alias %=' '

# colors
alias grep='grep --color=auto'
alias egrep='grep --color=auto'
alias fgrep='grep --color=auto'

# colored mans
alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike man"

# colored less
alias less='less -r'
