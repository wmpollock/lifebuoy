# Add colors to Terminal
export CLICOLOR=1
export CDPATH=./:~/:~/Git
export PATH=$PATH:.


alias code-lifebuoy='_code ~/Git/lifebuoy "$@"'
alias code-metafiddler='_code ~/Git/metafiddler "$@"'
_code() {
    # Allegedly this should work but not in gitbash?
    # Seems to want to wait() for the r
    code -nw $@ &
}


alias lstree="ls -R | grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# MISC HELPERS
alias h=history
alias ll='ls -l'

# Apparently unlike cshell you can't add bourne shell params but you can export funcs
# which do the same thing...
# https://stackoverflow.com/a/7131683

# We'll use aliases to keep a common lookup
alias dedos_path=_dedos-path
alias dedos-path=_dedos-path
_dedos-path(){
    echo "$*" | sed -e "s-C:-/c-" -e "s-\\\-/-g" -Ee 's/([\(\) ])/\\\1/g'
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

alias coverage-html="coverage html; chrome htmlcov/index.html"

alias py-doc='pydoc -p 6061 -b'
_py_doc() {
    pydoc -p 6061&
    sleep 2
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://localhost:6061
}

alias unittest="python3 -m unittest"

alias go-coverage="go test -coverprofile=coverage.out && go tool cover -html=coverage.out"

alias mark="pwd > ~/.skid"
alias snap='cd `cat ~/.skid`'