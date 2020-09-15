;;;; | ___ \   | | |          | |
;;;; | |_/ /__ | | | ___   ___| | __
;;;; |  __/ _ \| | |/ _ \ / __| |/ /
;;;; | | | (_) | | | (_) | (__|   <
;;;; \_|  \___/|_|_|\___/ \___|_|\_\

;;; .emacs


(load "~/.emacs.d/emacs.lib.el")
(load "~/.emacs.d/perl.lib.el")

;; Bind modes that occasionally don't want to come up...
(setq auto-mode-alist (append (list (cons "\\.tmpl\\'" 'html-mode)) auto-mode-alist))
(setq auto-mode-alist (append (list (cons "\\.php\\'" 'php-mode)) auto-mode-alist))
(setq auto-mode-alist (append (list (cons "\\.ec\\'" 'c-mode)) auto-mode-alist))


(put 'eval-expression 'disabled nil)
(display-time)

(global-unset-key "\C-xp")

(put 'downcase-region 'disabled nil)

(put 'upcase-region 'disabled nil)

(put 'set-goal-column 'disabled nil)



;; This is done for us on iris, but not on other systems necessarily
;; redefinition
(defun make-auto-save-file-name ()
(if buffer-file-name
    (concat
     (file-name-directory buffer-file-name)
     ",#"
     (file-name-nondirectory buffer-file-name)
     "#")
  (expand-file-name
   (concat ",#%" (buffer-name) "#"))))

;; Newer EMACSen will do this for us too...whee :(
(defun make-backup-file-name (file)
(if buffer-file-name
    (concat
     (file-name-directory buffer-file-name)
     ",#"
     (file-name-nondirectory buffer-file-name)
     "#")
  (expand-file-name
   (concat ",#%" (buffer-name) "#"))))

;; Lame! -- turn off the splash they added in 21 or '2
(setq inhibit-splash-screen t)


;; No more tabs [BP - 15 Oct 2014]
(setq-default indent-tabs-mode nil)

;; Fuck this (accidental typo) shit
(global-unset-key "\C-z"); no more suspend
(global-unset-key "\C-x\C-z"); no more suspsend

(setq default-tab-width 4);
(put 'narrow-to-region 'disabled nil)

;; MOAR COLORS [BP - 08 Aug 2017]
(global-font-lock-mode 1)

;; Clear whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Fix default CSS spacing
; https://www.emacswiki.org/emacs/css-mode.el
(setq css-indent-offset 2)
(setq make-backup-files nil)