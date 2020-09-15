

(global-unset-key "\C-w");
(global-set-key "\C-w" 'copy-region-as-kill);

;[BP--13Aug2002]
(global-unset-key "\M-S")
(global-set-key "\M-S" 'insert-sig)

(defun insert-sig
    () "<bill> insert code signature"
    (interactive)
    (setq initials "BP")  ;; CHANGE THIZ
    (insert "[" initials  " - " 
        (format-time-string "%d %b %Y") "]")
)






)

(defun deactivate-autosave
    () "<bill> Prevents autosave."
    (interactive)
    (setq auto-save-default nil)
    (setq backup-inhibited t)
)

(defun deactivate-changecheck
    () "<bill> Prevents change-checking."
    (interactive)
    (load "~/.lisp/suppress-changecheck.pl")
)


(defun carlin
    () "<bill> Find foul language in our documentation"
    (interactive)
    (re-search-forward
"\\b\\shit\\|fuck\\|damn\\|god\\|crap\\|ass\\b\\|effing\\|stupid\\|lame\\|sad\\|bitch\\|gay\\|ghey\\|suck\\")
)

(defun dedos
    ()
    (interactive)
    (set-buffer-file-coding-system 'unix 't)
)




(defun rcsdiff 
    ()   "<bill> Runs 'rcsdiff' over current file"
    (interactive)
    (save-buffer)
    (setq cmdline 
        (concat "rcsdiff " 
            (buffer-file-name)))
    (shell-command cmdline))
    ()   "<bill> Runs 'rcsdiff' over current file"
;)

(defun backout-rcs 
    ()   "<bill> Runs 'rcsdiff' over current file"
    (interactive)
    (save-buffer)
    (setq cmdline 
        (concat "co -f -l " 
            (buffer-file-name) "; ci -u " 
            (buffer-file-name)))
    (shell-command cmdline)
    (revert-buffer)
)

(defalias 'rcs-revert 'backout-rcs)

(defun css 
    (filename)
"<bill> Prompt user to enter a css path, with file name completion and input history support."
    (interactive 
        (list 
            (read-file-name "Open CSS:" "/web/docs/dev/css/")))
    (switch-to-buffer 
        (find-file-noselect filename))
)

(defun app 
    (filename)
"<bill> Prompt user to enter a app path, with file name completion and input history support."
    (interactive 
        (list 
            (read-file-name "Open APP:" "/web/docs/secure/dev/")))
    (switch-to-buffer 
        (find-file-noselect filename))
)

(defun template 
    (filename)
"<bill> Prompt user to enter a template path, with file name completion and input history support."
    (interactive 
        (list 
            (read-file-name "Open TEMPLATE:" "/web/docs/dev/templates/")))
    (switch-to-buffer 
        (find-file-noselect filename))
)

(defun js 
    (filename)
"<bill> Prompt user to enter a js path, with file name completion and input history support."
    (interactive 
        (list 
            (read-file-name "Open JS:" "/web/docs/dev/js/")))
    (switch-to-buffer 
        (find-file-noselect filename))
)

(defun upcase-template 
    ()
"<bill> Replace bogus TMPL constructs"
    (interactive)
    (beginning-of-buffer)
    (replace-string "tmpl_loop" "TMPL_LOOP")
    (beginning-of-buffer)
    (replace-string "tmpl_var" "TMPL_VAR")
    (beginning-of-buffer)
    (replace-string "tmpl_if" "TMPL_IF")
    (beginning-of-buffer)
    (replace-string "tmpl_else" "TMPL_ELSE")
)
(defun newapp 
    () " Create a new-app dropin with other goodness"
    (interactive)
    (skel)
    (insert-corporatebox-app);
)

(defun newmod
    ()
    (interactive)

    (beginning-of-buffer)
    (insert-corporatebox-module-core 
        (get-module-name))    ; DOC BLOCK
    (insert "package " modname ";\n"         ; TODO:  CAN HAS PROMPT, ALAN?
"\nuse strict;\n\n")
    (newobj)
    (insert "\n\n\nreturn 1; # A true value")
)
