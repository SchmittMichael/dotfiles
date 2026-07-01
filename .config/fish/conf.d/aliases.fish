# General
alias gs='git stash'
alias gsp='git stash pop'
alias md='mkdir -p'
alias ghpr='gh pr view --web'

# eza
alias l='eza -la'
alias lss='eza -lf --color=always --sort=size'
alias ll='eza -l --group-directories-first'
alias lda='eza -lDa'
alias lf='eza -lf --color=always'
alias lfa='eza -lfa --color=always'
alias lh='eza -dl .* --group-directories-first'
alias lt='eza -al --sort=modified'

# git alias
# source "$HOME/.config/fish/functions/custom/git.fish"
# git-aliases 

# work related
if grep -q anevis-admin /etc/passwd
    alias rn='run-it'
    alias mongodocker='mongosh --port 17027 -u root -p password --authenticationDatabase admin uat'
    alias serv='anevis-services'
    alias pgtop='sudo -u postgres pg_top'
    alias doceng='cd /srv/documentengine'
    alias print-mq='sudo /opt/apache/activemq/bin/activemq dstat queues | tail -n +14'
end
