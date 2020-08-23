export LSCOLORS=GxFxCxDxBxegedabagaced
# Fix some colors
# export LS_COLORS="ex=32"

alias drawio='/c/Program\ Files/draw.io/draw.io.exe' 
alias hosts='cat "c:\Windows\System32\Drivers\etc\hosts"'
alias kill-winpty='kill -9 `ps -ef | grep winpty | sed -Ee "s/ +/ /g;"  | cut -f 2 -d " "`'

alias mysqldump='/c/Program Files/MySQL/MySQL Workbench 8.0 CE/mysqldump.exe'
alias mysql='/c/Program Files/MySQL/MySQL Workbench 8.0 CE/mysql.exe'
alias pylint='python -m pylint'
alias pydoc='python -m pydoc' # *allegedly* not necessary
alias whereis=where
alias reset-tty='kill -WINCH $$'
alias unittest="python -m unittest"
