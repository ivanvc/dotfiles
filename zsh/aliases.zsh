# cd
alias ..='cd ..'

# ls
alias ls="ls -F -G"
alias l="ls -lAh -G"
alias ll="ls -l -G"
alias la='ls -A -G'

# commands starting with % for pasting from web
alias %=' '

# colors
alias grep='grep --color=auto'
alias egrep='grep --color=auto'
alias fgrep='grep --color=auto'

# colored mans
alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"
