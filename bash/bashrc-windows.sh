export LSCOLORS=GxFxCxDxBxegedabagaced
# Fix some colors
# export LS_COLORS="ex=32"


alias chrome="/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"
alias drawio='/c/Program\ Files/draw.io/draw.io.exe' 
alias hosts='cat "c:\Windows\System32\Drivers\etc\hosts"'
alias kill-winpty='kill -9 `ps -ef | grep winpty | sed -Ee "s/ +/ /g;"  | cut -f 2 -d " "`'

alias mysqldump='/c/Program Files/MySQL/MySQL Workbench 8.0 CE/mysqldump.exe'
alias mysqlx='"/c/Program Files/MySQL/MySQL Workbench 8.0 CE/mysql.exe"'
# alias mysql='"C:\Program Files\MySQL\MySQL Workbench 8.0 CE\mysql.exe"'
alias otherperl="/c/Strawberry/perl/bin/perl.exe"
alias pylint='python -m pylint'
alias pydoc='python -m pydoc' # *allegedly* not necessary
# I need hte result of python but o'wise this would be nicer
# wrapped in winpty -- winpty can't hax the
alias python3="/c/Python38/python.exe"
alias whereis=where
alias reset-tty='kill -WINCH $$'
alias unittest="python -m unittest"
