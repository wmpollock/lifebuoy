;;;; | ___ \   | | |          | |
;;;; | |_/ /__ | | | ___   ___| | __
;;;; |  __/ _ \| | |/ _ \ / __| |/ /
;;;; | | | (_) | | | (_) | (__|   <
;;;; \_|  \___/|_|_|\___/ \___|_|\_\

;;; perl.lib.el
;;; Functions specific to better perl hacking

;;; Settings
(setq cperl-indent-level 4)

;;; Probably legacy most modern revs -- apply modes automatically based on path
(setq auto-mode-alist (append (list (cons "\\.pl\\'" 'cperl-mode))
                               auto-mode-alist))
(setq auto-mode-alist (append (list (cons "\\.plx\\'" 'cperl-mode))
                               auto-mode-alist))
(setq auto-mode-alist (append (list (cons "\\.pm\\'" 'cperl-mode))
                               auto-mode-alist))
(setq auto-mode-alist (append (list (cons "\\.cgi\\'" 'cperl-mode))
                               auto-mode-alist))


;;; SK's past editors in particular did bad things iwth line indention and
;;; practices;[BP - 05 Sep 2015]
(defun normalize-perl-style () ""
  (interactive)
  (setq here (point))
  (replace-string "else{" "else {");
  (goto-line here)
  (replace-string "my(" "my (");
  (goto-line here)
  (replace-string "unless(" "unless (");
  (goto-line here)
  (replace-string "if(" "if (");
  (goto-line here)
  (replace-string "}els" "} els");
  (goto-line here)
)

(defun order-perl-subs ()   "<bill> Orders perl subroutines (via sort-lines)"
  (interactive)
  (previous-line 1)
  (setq here (point))
  (replace-string "\n" "•–—")
  (goto-line here)
  (beginning-of-line)
  (replace-string "sub " "\nsub ")
  (end-of-buffer)
  (setq there (point))
  (sort-lines nil here there)
  (goto-line here)
  (beginning-of-buffer)
  (replace-string "•–—" "\n")
  (goto-line here)
)


(defun prog ()  "<bill> runs program being edited in current window"
  (interactive)
  (untabify (point-min) (point-max))
  (save-buffer)
  (cond ((equal argvee nil)
         (set-argv)))
  (setq cmdline (concat (buffer-file-name) (concat " " argvee)))
  (message (concat "Running " cmdline))
  (shell-command cmdline)
;  (message (concat "Finished with run of " cmdline)) ; Message now appears inline
)
(defun pod2text ()  "<bill> runs program being edited in current window"
  (interactive)
  (untabify (point-min) (point-max))
  (save-buffer)
  (setq cmdline (concat "pod2text " (buffer-file-name)))
  (message (concat "Running " cmdline))
  (shell-command cmdline)
;  (message (concat "Finished with run of " cmdline)); Message now appears inline
)


(defun perlfunc ()  "<bill> drops perl knowledge per function"
  (interactive)
  (setq perlfunc (read-from-minibuffer "Describe perl function: "))
  (setq cmdline (concat "perldoc -f " perlfunc))
;  (message (concat "Running " cmdline))
  (shell-command cmdline (concat "perlfunc " perlfunc))
;  (rename-buffer perlfunc)
)


(defun perldoc ()  "<bill> drops perl knowledge per function"
  (interactive)
  (setq perlfunc (read-from-minibuffer "Perldoc for: "))
  (setq cmdlineg (concat "perldoc -t -T " perlfunc))
;  (message (concat "Running " cmdline))
  (shell-command cmdline )
;  (rename-buffer perlfunc)
)

(defun find-vars () "<bill> finds variables"
  (interactive)
  (save-buffer)
  (if (get-buffer "**find.vars optimization output") (kill-buffer "**find.vars optimization output"))
  (setq cmdline (concat "find.vars " (buffer-file-name)))
  (message (concat "Running " cmdline))
  (shell-command cmdline)
  (other-window 1)
  (rename-buffer "find.vars optimization output")
  (other-window 1)
)

(defun find-vars-opt () "<bill> finds variables"
  (interactive)
  (save-buffer)
  (if (get-buffer "**find.vars optimization output") (kill-buffer "**find.vars optimization output"))
  (setq cmdline (concat "find.vars opt " (buffer-file-name)))
  (message (concat "Running " cmdline))
  (shell-command cmdline)
  (other-window 1)
  (rename-buffer "**find.vars optimization output")
  (other-window 1)
)

(setq argvee "")
(defun argv () "<bill> displays the argv"
  (interactive)
  (message (concat "ARGV IS:" argvee))
)

(defun set-argv () "<bill> establish an ARGV for Perl shell execution"
  (interactive)
  (setq argvee (read-from-minibuffer "Enter command line args (ARGV): " nil))
  (message (concat "ARGV is now: " argvee))
  )

(defun modify-argv () "<bill> establish an ARGV for Perl shell execution"
  (interactive)
  (setq argvee (read-from-minibuffer "Enter command line args (ARGV): " argvee))
  (message (concat "ARGV is now: " argvee))
  )

(defun append-argv () "<bill> establish an ARGV for Perl shell execution"
  (interactive)
  (setq argvee (read-from-minibuffer "Enter command line args (ARGV): " argvee))
  (message (concat "ARGV is now: " argvee))
  )


(defun print-array()   "<bill> print all elements of a given array"
  (interactive)
  (insert "\ngrep((print"\$_\n"),@ )")
)




(
 defun newobj()
       (interactive)
       (insert "sub new {\n")
       (insert "   my($class, %opts) = @_;\n")
       (insert "\n   my $self = bless \\%opts, $class;\n")
       (insert "\n   return $self;\n")
       (insert "}\n")
)

;;(defalias 'new-prog 'skel)
(defalias 'newprog 'skel) ; WTF, I keep calling.

(defun skel ()   "<bill> drops in new stuff for Perl constructs"
 (interactive)
 (perl-mode)
 (goto-line 1)
 (insert "#!/usr/local/bin/perl\n\n\n")
 (insert "use strict;\n\n")
 (save-buffer)
 (shell-command (concat "chmod 775 " (buffer-file-name)))
 )

(defun newcgi ()   "<bill> drops in new stuff for Perl constructs"
 (interactive)
 (perl-mode)
 (goto-line 1)
 (insert "#!/usr/local/bin/perl\n\n")
 (insert "use strict;\n")
 (insert "use CGI qw(:all);\n")
 (insert "use CGI::Carp qw(fatalsToBrowser);\n\n")
;; (end-of-buffer)
 (save-buffer)
 (shell-command (concat "chmod 775 " (buffer-file-name)))
 )

(defun insert-dbi ()   "<bill> drops in new stuff for Perl constructs"
 (interactive)
 (perl-mode)
 (insert "use DBI;\n");
 (insert "my $dbh = DBI->connect('dbi:Informix:ipa') or\n")
 (insert "    die \"FATAL: Can't connect to ipa -- \", DBI->errstr, \"\\n\";\n");
 (insert "$dbh->{ChopBlanks} = 1;\n");
 )
(defun insert-sth ()   "<bill> drops in new stuff for Perl constructs"
 (interactive)
 (perl-mode)
 (insert "my $sth = $dbh->prepare('') or\n")
 (insert "    die \"FATAL: Can't prepare query -- \", $dbh->errstr, \"\\n\";\n");
 (insert "$sth->execute() or\n")
 (insert "    die \"FATAL: Can't execute query -- \", $dbh->errstr, \"\\n\";\n");
 (insert "while (my $row = $sth->fetchrow_hashref){\n\n}\n")
 )

(defun newshell ()   "<bill> drops in new stuff for Shell constructs"
 (interactive)
 (perl-mode)
 (goto-line 1)
 (insert "#!/usr/bin/sh\n\n")
 (next-line 1)
 (save-buffer)
 (shell-command (concat "chmod 775 " (buffer-file-name)))
 )

(defun foreach () "<bill> inserts standard perl foreach loop"
  (interactive)
  (setq looppoint (current-column))
  (insert "foreach \(\) \{\n\n")
  (indent-to-column looppoint)
  (insert "\}")
  (previous-line 1)
  (indent-to-column (+ looppoint 4)))


(defun lockprog () "<bill> inserts standard perl lockout line"
  (interactive)
  (insert "\($ENV\{USER\} eq \"billp\"\) \n\t|| die \(\"billp is currently working on this program\\nplease talk to him before attempting to run it again\\n\"\);")
  (previous-line 1)
  (beginning-of-line))

(defun check-syntax-perl ()   "<bill> checks perl syntax of current buffer"
  (interactive)
  (untabify (point-min) (point-max))
  (save-buffer)
  (setq cmdline (concat "/usr/local/bin/perl -cw " (buffer-file-name)))
  (shell-command cmdline))

;;; LEGACY:  saved for ++black arts
;(defun add-diagnostic ()  "<bill> Adds master diagnostic piece"
;  (interactive)
;  (insert "#Master diagnostic section.  Allows us to figure out who is running what.\n")
;  (insert "open \(DIAG,\">>/text/bin/Scripts/.billp_master_diagnostic\"\);\n")
;  (insert "print DIAG \"$ENV\{\'USER\'\} ran $0 on \" . \`date\`;\n")
;  (insert "close DIAG;")
;  )



(defun whileloop ()   "<bill> inserts standard perl while loop"
  (interactive)
  (setq looppoint (current-column))
  (insert "while (<>) {\n\n")
  (indent-to-column looppoint)
  (insert "\}")
  (previous-line 1)
  (indent-to-column (+ looppoint 4)))

(defun comment-region-perl (start end) "<bill> commentizes the region"
  ;; There was a problem with the old routine in that it didn't take into
  ;; consideration the addition of the "#" character into the current position

  (interactive "r") ; Tell it that we want the char start and end of region

  ;; Try and save current position information
  (setq whereat (point))


  (goto-char start) ; go to the top
  (setq counter 0) ; variable init

  ;; Find the number of lines
  (while (<= (point) end)
    (next-line 1)
    (setq counter (1+ counter))
    )

  ;; Now, prepare to comment
  (goto-char start) ; # Start of region
  (setq linepos 1); # Begin counting
  (while (<= linepos counter)
    (beginning-of-line) ; # front of line
    (insert "#") ; # insert "#"
    (next-line 1) ; Go to the next
    (setq linepos (1+ linepos)) ; # incriment linecounter
    )
  (message "%d %d %d %d" linepos counter whereat (+ whereat counter))
  (goto-char (+ whereat counter))
  )


(defun insert-init ()"<billp> insert standard initialization stuffs"
    (interactive)
    (perl-mode)
    (insert "sub initialize {\n    $0 =~ s!.+/!!;\n")

    ;lines must be separate to keep RCS from fucking up the Revision below
    (insert "    \(my $revision = q\\$Revision: PRERELEASE")
    (insert "$\\) =~ s/( ?\\$)//g;\n    print \"Running $0 -- $revision\\n\";\n\n");


    (insert "    #system \"/text/bin/Scripts/logrun $0 $ENV{'USER'}\";\n\n}")
    (previous-line 1)
)

(defun insert-documentation ()"<billp> insert standard documentation header"
  (interactive)
  (perl-mode)
 '' (insert-file "/home/billp/Shtuff/perlhead")
);


(defun perl-indent-buffer()  "<bill> Grind the entire buffer (from point) in happy-perl format"
  (interactive)
''  (cperl-mode)
  (while (not (eobp))
    (message (what-line))
  ''  (perl-indent-line)
  (cperl-indent-command)
    (next-line 1)
    )
  )

(defun comment-box() "<bill> Insert comment box"
  (interactive)
  (beginning-of-line)
  (insert "    ####")
  (perl-indent-line)
  (insert "\n # ")
  (perl-indent-line)
  (insert "\n ####")
  (perl-indent-line)
  (newline)
  (previous-line 2)
  (end-of-line)
)

(defun insert-cmt-box () "<bill> alias for comment-box"
  (interactive)
  (comment-box)
)

(defun cmtbox () "<bill> alias for comment-box"
  (interactive)
  (comment-box)
)


(defun insert-debug ()
  "<billp> Insert debug line"
  (interactive)
  (insert "($debug = '$Locker:  $') =~ s/\\$\\w+: (\\w*) ?\\$/$1/;")
)


(defun sub ()
  "<billp> inserts new perl sub"
  (interactive)
  (insert "sub  \{\n    #####\n    # \n    #####\n\}\n")
  (previous-line 5)
  (beginning-of-line)
  (forward-char 4)
)

(defun stat ()
  "<billp> inserts generic stat return"
  (interactive)
  (insert "\($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size,")
  (perl-indent-line);
  (next-line 1);
  (insert "$atime, $mtime, $ctime, $blksize, $blocks\) = stat;\n")
  (perl-indent-line);
)

(defun insert-datereg ()
   "<billp> inserts procate reg"
   (interactive)
   (insert "/^(?:19|20)[90]\\d[01]\\d[0-3]\\d$/")

)

(defun rcs-fatten()
  "Make the RCS program double-accurate"
  (interacive)
  (if (bufffer-read-only) (toggle-read-only))
  (query-replace-regexp "\\(\\b[0-9]\\)\\." "\\1.0")

)

(defun insert-statereg()
   "Drop in a state-list regular expression"
   (interactive)
   (insert "(AK|AL|AR|AZ|CA|CO|CT|DE|DC|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MT|NC|ND|NE|NH|NJ|NM|NV|NY|OH|OK|OR|PA|RI|SC|SD|TN|TX|US|UT|VA|VT|WA|WI|WV|WY)")
   );

(global-unset-key "\M-D")
(global-set-key "\M-D" 'data-dumper)
(defun data-dumper()
    "[bp] Add Data::Dumper block of code.\n"
    (interactive)
;;    (insert "use Data::Dumper;\n")
    (insert "use Data::Dumper;") ;; now with more oneliner
    (insert "die(Data::Dumper->Dump([]));\n");
    )

(global-unset-key "\M-C")
(global-set-key "\M-C" 'cgi-dumper)
(defun cgi-dumper()
    "[bp] Add Data::Dumper block of code for CGI.\n"
    (interactive)
    (insert "use Data::Dumper;\n")
    (insert "print header(),\n")
    (insert "pre({-align => 'left'},\nData::Dumper->Dump([]));\n");
    (insert "exit;\n")
    )


(defun newsub ()
  "<billp> inserts new() perl sub"
  (interactive)
  (insert "sub new \{\n    my($class, %opts) = @_;\n    my $self = bless \\%opts, $class;\n\n    return $self;\n}\n");
  (previous-line 5)
  (beginning-of-line)
  (forward-char 4)
)


(global-unset-key "\M-n");  wasn't set in recent emacs [BP - 26 Aug 2010]
(global-set-key "\M-n" 'next-long-line)

 ;; From http://www.emacswiki.org/emacs/FindLongLines
 ;; [BP - 26 Aug 2010]
 (defun next-long-line (arg)
    "Move to the ARGth next long line greater than `fill-column'."
    (interactive "p")
;    (setq targ-len fill-column)
    (setq targ-len 79); FTFY [BP - 26 Aug 2010]
    (or arg (setq arg 1))
    (let ((opoint (point))
          (line-length 0))
      ;; global-variable: targ-len
      (while (and (<= line-length targ-len)
                  (zerop (forward-line (if (< arg 0) -1 1))))
        (setq line-length (save-excursion
                            (end-of-line)
                            (current-column))))
      ;; Stop, end of buffer reached.
      (if (> line-length targ-len)
          (if (> arg 1)
              (my-next-long-line (1- arg))
            (if (< arg -1)
                (my-next-long-line (1+ arg))
              (message (format "Long line of %d columns found"
                               line-length))))
        (goto-char opoint)
        (message "Long line not found"))))


(defun unamp ()   "<bill> Orders perl subroutines (via sort-lines)"
  (interactive)
  (goto-char 0) ; go to the top
  (query-replace-regexp "&#38;\\(#38;\\)+" "&#38;" nil)
  (goto-char 0) ; go to the top
  (query-replace "&#38;" "&" nil)
)

(defun insert-doc-flowerbox () "<bill> enters documentation stub for pod"
  (interactive)
  (insert "#---------------------------------------------------------------------------
=head2 method

=cut
"))
(defun insert-flowerbox () "<bill> enters documentation stub for pod"
  (interactive)
  (insert "#
#---------------------------------------------------------------------------
")
  (previous-line 3)
  (beginning-of-line)
  (forward-char 3)
  )

(defun template-denormalize()
  "Change HTML::Template vars to HTML-form"
  (interactive)
;;  (beginning-of-buffer)
  ;;  (replace-regexp "<!--\\(/?TMPL_\(LOOP|IF[^>]+\\)-->" "<\\1>")
  (replace-regexp "<!--\\(/?TMPL_IF[^>]*\\)-->" "<\\1>" nil 1 (point-max))
  ;; Okay, so we went too far and shouldn't muck with includes as nestable cases
;;  (replace-regexp "<\\(TMPL_\(INCLUDE|ELSE\)[^>]+\\)>" "<!--\\1-->" nil)
  );

(defun template-normalize()
  "Change HTML::Template vars to HTML-form"
  (interactive)
  (replace-regexp "<\\(/?TMPL[^>]+\\)>" "<!--\\1-->" nil 1 (point-max))
);
