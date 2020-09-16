

(global-unset-key "\C-w");
(global-set-key "\C-w" 'copy-region-as-kill);

; [BP -- 13 Aug 2002]
(global-unset-key "\M-S")
(global-set-key "\M-S" 'insert-sig)

(defun insert-sig() "<bill> insert code signature"
  (interactive)
  (setq initials "BP")  ;; CHANGE THIZ
  (insert "[" initials  " - " (format-time-string "%d %b %Y") "]")
)



(defun insert-corporatebox-module-core(modname)
 "<bill> Include corporate flowerbox"
  (interactive) ; planetary
  (insert "###########################################################################
# Licensed materials - property of LexisNexis.                            #
# (c) Copyright " (format-time-string "%Y")
                   " LexisNexis, a division of Reed Elsevier Inc.         #
# All rights reserved.                                                    #
#=========================================================================#
#
# Module name   : " modname "
# Author        : William Pollock
# Creation Date : " (format-time-string "%B %Y") "
# Description   :
#               :
#==========================================================================\n"
  )
)
;; See also newmod()
(defun insert-corporatebox-module() "<bill> Include corporate flowerbox"
  (interactive)
  (insert-corporatebox-module-core (get-module-name))    ; DOC BLOCK
)
;(defun archer()
;  (interactive)
;  (message (get-module-name))
;)
(defun get-module-name () "<bill> Include corporate flowerbox"
  (interactive)
  (setq modname buffer-file-name)
  (setq modname (replace-regexp-in-string "/segue/SymLinks/perllib" "" modname))
 (setq modname (replace-regexp-in-string "/web/docs/secure/dev/" "" modname))
 (setq modname (replace-regexp-in-string "\.pm" "" modname))
;  (setq modname (replace-regexp-in-string "/web/docs/" "" modname))
  (setq modname (replace-regexp-in-string "/" "::" modname))

  (setq modname (read-from-minibuffer "Module name: " modname))

)




(defun insert-corporatebox-app() "<bill> Include corporate flowerbox"
 (interactive)
  (setq appname (file-name-nondirectory buffer-file-name))

  (setq appname (read-from-minibuffer "Application Name: " appname))

 (insert "#########################################################################
# Licensed Materials - Property of LexisNexis.
# (C) Copyright " (format-time-string "%Y") " LexisNexis, a division of Reed Elsevier Inc.
# All rights reserved.
# ======================================================================#
# Application Name     : " appname "
# Author               : William Pollock
# Creation Date        : " (format-time-string "%B %Y") "
# Description          :
#                      :
#########################################################################")
  (previous-line 2)
  (beginning-of-line)
  (forward-char 25)
)

(defun insert-generic-flowerbox() "<bill> Include corporate flowerbox"
  (interactive)
  (insert "#
#
#########################################################################")

)




 (defun fuckoff-autosave() "<bill> Prevents autosave."
   (interactive)
   (setq auto-save-default nil)
   (setq backup-inhibited t)
 )

(defun fuckoff-changecheck() "<bill> Prevents change-checking."
  (interactive)
  (load "~/.lisp/suppress-changecheck.pl")
)

(defun graceful ()  "<bill> reboots apache server"
  (interactive)
  (save-buffer)
  (shell-command "op sn-apache graceful")
)
(defun configtest ()  "<bill> test apache config"
  (interactive)
  (save-buffer)
  (shell-command "op sn-apache configtest")
)

(defun carlin() "<bill> Find foul language in our documentation"
  (interactive)
  (re-search-forward
   "\\b\\(shit\\|fuck\\|damn\\|god\\|crap\\|ass\\b\\|effing\\|stupid\\|lame\\|sad\\|bitch\\|gay\\|ghey\\|suck\\)")
)

(defun dedos()
  (interactive)
  (set-buffer-file-coding-system 'unix 't)
)

(defun mkinstall ()   "<bill> Runs 'mkinstall' over current file"
  (interactive)
  (save-buffer)
  (setq cmdline (concat "mkinstall " (buffer-file-name)))
  (shell-command cmdline))


(defun set-spi () "<bill> establish an ARGV for Perl shell execution"
  (interactive)
  (setq spi (read-from-minibuffer "Enter SPI: " spi))

  )

(setq spi nil)

(defun spi-mkinstall ()   "<bill> Runs 'mkinstall' over current file"
  (interactive)
  (save-buffer)
  (cond ((equal spi nil) (set-spi)))
  (setq cmdline (concat "mkinstall -spi " spi " " (buffer-file-name)))
  (shell-command cmdline)
)


(defun stage-file ()   "<bill> Runs 'stage-files.pl' over current file"
  (interactive)
  (save-buffer)
  (setq cmdline (concat "stage-files.pl " (buffer-file-name)))
  (shell-command cmdline))



(defun rcsdiff ()   "<bill> Runs 'rcsdiff' over current file"
  (interactive)
  (save-buffer)
  (setq cmdline (concat "rcsdiff " (buffer-file-name)))
  (shell-command cmdline))

;(defun rcs-revert ()   "<bill> Runs 'rcsdiff' over current file"
;  (backout-rcs)
;)

(defun backout-rcs ()   "<bill> Runs 'rcsdiff' over current file"
  (interactive)
  (save-buffer)
  (setq cmdline (concat "co -f -l " (buffer-file-name) "; ci -u " (buffer-file-name)))
  (shell-command cmdline)
  (revert-buffer)
)

(defalias 'rcs-revert 'backout-rcs)

(defun css (filename)
  "<bill> Prompt user to enter a css path, with file name completion and input history support."
  (interactive (list (read-file-name "Open CSS:" "/web/docs/dev/css/")))
  (switch-to-buffer (find-file-noselect filename))
)

(defun app (filename)
  "<bill> Prompt user to enter a app path, with file name completion and input history support."
  (interactive (list (read-file-name "Open APP:" "/web/docs/secure/dev/")))
  (switch-to-buffer (find-file-noselect filename))
)

(defun template (filename)
  "<bill> Prompt user to enter a template path, with file name completion and input history support."
  (interactive (list (read-file-name "Open TEMPLATE:" "/web/docs/dev/templates/")))
  (switch-to-buffer (find-file-noselect filename))
)

(defun js (filename)
  "<bill> Prompt user to enter a js path, with file name completion and input history support."
  (interactive (list (read-file-name "Open JS:" "/web/docs/dev/js/")))
  (switch-to-buffer (find-file-noselect filename))
)

(defun upcase-template ()
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
(defun newapp () " Create a new-app dropin with other goodness"
  (interactive)
  (skel)
  (insert-corporatebox-app);
)

(defun newmod()
  (interactive)

  (beginning-of-buffer)
  (insert-corporatebox-module-core (get-module-name))    ; DOC BLOCK
  (insert "package " modname ";\n"         ; TODO:  CAN HAS PROMPT, ALAN?
          "\nuse strict;\n\n")
  (newobj)
  (insert "\n\n\nreturn 1; # A true value")
)
