alias hosts='cat "c:\Windows\System32\Drivers\etc\hosts"'
alias whereis=where
alias reset-tty='kill -WINCH $$'
alias kill-winpty='kill -9 `ps -ef | grep winpty | sed -Ee "s/ +/ /g;"  | cut -f 2 -d " "`'

alias mysqldump='/c/Program Files/MySQL/MySQL Workbench 8.0 CE/mysqldump.exe'
alias mysql='/c/Program Files/MySQL/MySQL Workbench 8.0 CE/mysql.exe'
alias drawio='/c/Program\ Files/draw.io/draw.io.exe' 

# Python - linux world does just fine, thanks.
alias pydoc='python -m pydoc'
# Hurrrr, just install pip they say :/
alias pylint='python -m pylint'
