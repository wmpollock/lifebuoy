# Add colors to Terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export CDPATH=./:~/:~/Git
export PATH=$PATH:.

# MISC HELPERS
alias h=history
alias ll='ls -l'
# Apparently unlike cshell you can't add bourne shell params but you can export funcs
# which do the same thing...
# https://stackoverflow.com/a/7131683

alias unittest="python -m unittest"


# If we alias we can see in the alias list o'wise these kinda get lost
alias dedos-path=_dedos-path
_dedos-path(){
    echo "$*" | sed -e "s-C:-/c-" -e "s-\\\-/-g"
}

alias endos-path=_endos-path
_endos-path(){
    echo "$*" | sed -e "s-~/-$HOME/-" -e "s-/c/-C:/-"  -e "s-/-\\\-g"
}
alias agrep=_alias_grep
_alias_grep() {
    alias | grep -- '$*'
}

alias go-doc=_go_doc
_go_doc() {
    godoc -http=:6060&
    sleep 2
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://localhost:6060
}

alias py-doc='pydoc -p 6061 -b'
_py_doc() {
    pydoc -p 6061&
    sleep 2
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://localhost:6061
}


