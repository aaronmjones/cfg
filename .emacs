;; =============================================================================
;; TOC
;; =============================================================================


;; My Preferences
;;   My Global Preferences
;;   My Mode Styles
;;   My Mode Hooks
;; Emacs Reference
;;   Set Major Mode
;;   Files and Buffers
;;   Cursor Movement
;;   Deletion
;;   Regions
;;   Reformatting
;;   Transposition
;;   Case
;;   Remapping Keys
;;   Incremental Search
;;   Query Replace
;;   Regex
;;   Regex Search
;;   Ispell
;;   Window Commands
;;   Buffer Manipulation
;;   Buffer List Commands
;;   Bookmarks
;;   Commands for Editing Bookmark List
;;   Shell
;;   Shell Mode Commands
;;   Dired Commands
;;   Printing Commands
;;   Reading Manpages
;;   Displaying the time
;;   Calendar
;;   Displaying Holidays
;;   Calendar and Diary Commands
;;   Summary of Tab Commands
;;   Using Fill Prefixes
;;   Indentation
;;   Centering Text
;;   Rectangle Commands
;;   Picture Mode Commands
;;   Macro Commands
;;   Customizing Emacs
;;     Special Character Conventions
;;     Emacs Variables
;;   C-Mode
;;     Advanced C Motion Commands
;;     Customizing Code Indentation Style
;;   etags
;;     etags Commands
;;   LISP
;;     Basic LISP entities
;;     Turning LISP Functions into Emacs Commands
;;     LISP Primitive Functions
;;     LISP Library
;;   X Display Customizations

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;;(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)


(customize-set-variable 'org-journal-dir "~/Dropbox/Org/Journal/")
(require 'org-journal)
;;(setq org-journal-dir "~/Dropbox/journal")

;; =============================================================================
;; My Preferences
;; =============================================================================


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages (quote (org-journal))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; My Global Preferences
;; -----------------------------------------------------------------------------
(setq inhibit-startup-message t)              ;; Don't display splash screen?
(setq kill-whole-line t)                      ;; Kill line also deletes \n?
(setq next-line-add-newlines nil)             ;; Down arrow adds \n at end?
(setq require-final-newline t)                ;; Put \n at end of last line?
(setq make-backup-files nil)                  ;; Make backup files?
(setq scroll-step 1)                          ;; Scroll n lines at a time
(setq line-number-mode t)                     ;; Put line number in display?
(setq column-number-mode t)                   ;; Put column number in display?
(setq default-major-mode 'text-mode)          ;; Default mode for new buffers
(setq fill-column 80)                         ;; Text lines limit to n chars
;;(setq c-default-style "linux"
;;     c-basic-offset 4)
;;(setq-default indent-tabs-mode nil)


;; My Mode Styles
;; -----------------------------------------------------------------------------
(c-add-style "my-c-style"
             '("linux"
               (indent-tabs-mode . nil)
                           (c-basic-offset . 2)
                           (c-offsets-alist . ((inline-open . 0)
                                               (brace-list-open . 0)
                                                                   (innamespace . 0)))))
(defun maybe-gnu-style ()
  (interactive)
  (when (and buffer-file-name
             (or (string-match "/path/to/gnu/style/source/1" buffer-file-name)
                             (string-match "/path/to/gnu/style/source/2" buffer-file-name)))
            (c-set-style "gnu")))
(defun my-c-mode ()
  (interactive)
  (c-set-style "my-c-style")
  (maybe-gnu-style))


;; My Mode Hooks
;; -----------------------------------------------------------------------------
;; emacs-lisp-mode
;; ---------------
(add-hook 'emacs-lisp-mode-hook
  (lambda()
    (setq-default indent-tabs-mode nil)
        (setq lisp-body-indent 2
              indent-line-function 'lisp-indent-line)
  )
)
;; text-mode
;; ---------
(add-hook 'text-mode-hook
  (lambda()
    (setq-default indent-tabs-mode t)
        (setq tab-width 4
              indent-line-function (quote indent-relative))
  )
)
;; sh-mode
;; -------
(add-hook 'sh-mode-hook
  (lambda()
    (setq indent-tabs-mode nil)
    (set tab-width 4
         sh-basic-offset 4
         sh-indentation 4)
          ;;indent-line-function (quote sh-indent-line))
  )
)
;; c-mode-common
;; -------------
(add-hook 'c-mode-common-hook 'my-c-mode)
;; less common file extensions
;; ---------------------------
(add-to-list 'auto-mode-alist '("\\.proto\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . sh-mode))


(setq org-capture-templates
      '(;; other entries
        ("j" "Journal entry" plain
         (file+datetree+prompt "~/org/personal/journal.org")
         "%K - %a\n%i\n%?\n")
        ;; other entries
        ))


;; =============================================================================
;; Emacs Reference
;; =============================================================================


;; Set Major Mode
;; -----------------------------------------------------------------------------
;; M-x makefile-mode
;; M-x emacs-lisp-mode
;; M-x lisp-mode
;; M-x c-mode
;; M-x text-mode

;; Files and Buffers
;; -----------------------------------------------------------------------------
;; C-x C-v      find-alternate-file
;; C-x i        insert-file
;; C-x C-w      write-file


;; Cursor Movement
;; -----------------------------------------------------------------------------
;; C-f          forward-char
;; C-b          backward-char
;; C-p          previous-line
;; C-n          next-line
;; ESC f        forward-word
;; ESC b        backward-word
;; C-a          beginning-of-line
;; C-e          end-of-line
;; ESC e        forward-sentence
;; ESC a        backward-sentence
;; ESC }        forward-paragraph
;; ESC }        backward-paragraph
;; C-v          scroll-up
;; ESC v        scroll-down
;; C-x ]        forward-page
;; C-x [        backward-page
;; ESC <        beginning-of-buffer
;; ESC >        end-of-buffer
;; ESC n        digit-argument Repeat next command n times.
;; C-u n        universal-argument Repeat next command n times (default 4).


;; Deletion
;; -----------------------------------------------------------------------------
;; C-d          delete-char
;; DEL          delete-backward-char
;; ESC d        kill-word
;; ESC DEL      backward-kill-word
;; C-k          kill-line
;; ESC k        kill-sentence
;; C-x DEL      backward-kill-sentence
;; C-y          yank
;; C-w          kill-region
;; (none)       kill-paragraph
;; (none)       backward-kill-paragraph


;; Regions
;; -----------------------------------------------------------------------------
;; C-SPACE      set-mark-command
;; C-x C-x      exchange-point-and-mark
;; C-w          kill-region
;; C-y          yank
;; ESC w        kill-ring-save
;; ESC h        mark-paragraph
;; C-x C-p      mark-page
;; C-x h        mark-whole-buffer
;; ESC y        yank-pop                      After C-y, pastes earlier deletion


;; Reformatting
;; -----------------------------------------------------------------------------
;; ESC q        fill-paragraph                                Reformat paragraph
;; (none)       fill-region                  Reformat paragraphs within a region


;; Transposition
;; -----------------------------------------------------------------------------
;; C-t          transpose-chars
;; ESC t        transpose-words
;; C-x C-t      transpose-lines
;; (none)       transpose-sentences
;; (none)       transpose-paragraphs


;; Case
;; -----------------------------------------------------------------------------
;; ESC c        capitalize-word
;; ESC u        upcase-word
;; ESC l        downcase-word
;; ESC - ESC c  negative-argument; capitalize-word
;; ESC - ESC u  negative-argument; upcase-word
;; ESC - ESC l  negative-argument; downcase-word


;; Remapping Keys
;; -----------------------------------------------------------------------------
;; (global-unset-key "\e\e")
;; (global-unset-key "\C-x\C-u")
;; (define-key global-map "\C-h" 'backward-char)


;; Incremental Search
;; -----------------------------------------------------------------------------
;; C-s          isearch-forward
;; C-r          isearch-backward
;; RETURN       (none)                                             Exit a search
;; C-g          keyboard-quit                                      Cancel search
;; DEL          (none)
;; C-s C-w      (none)                                         Use word at point
;; C-s C-y      (none)                                          Use point to EOL
;; C-s ESC y    (none)                                             Use kill ring
;; C-s C-s      (none)                                           Previous search


;; Query Replace
;; -----------------------------------------------------------------------------
;; ESC %        Start query-replace
;; SPACE        Replace
;; DEL          Don't replace
;; .            Replace current and quit
;; ,            Replace - let me see the result before continuing
;; !            Replace all and don't ask
;; ^            Backup to previous instance
;; RETURN or q  Exit
;; C-r          Enter a recursive edit
;; C-w          Delete this instance and enter a recursive edit
;; ESC C-c      Exit recursive edit and resume query-replace
;; C-]          Exit recursive edit and exit query-replace
;; Related variables:
;; (setq-default case-fold-search nil)                  Require case exact match
;; (setq-default case-replace nil)              Never change case when replacing


;; Regex
;; -----------------------------------------------------------------------------
;; char   Match
;; ^      Beginning of line
;; $      End of line
;; .      Any single char
;; .*     Any group of zero or more chars
;; \<     Beginning of word
;; \>     End of word
;; []     Any char within brackets


;; Regex Search
;; -----------------------------------------------------------------------------
;; ESC C-s RETURN     re-search-forward
;; ESC C-r RETURN     re-search-backward
;; ESC C-s            isearch-forward-regexp
;; ESC C-r            isearch-backward-regexp
;; (none)             query-replace-regexp
;; (none)             replace-regexp


;; Ispell
;; -----------------------------------------------------------------------------
;; ESC $        ispell-word
;; (none)       ispell-region
;; (none)       ispell-buffer
;; (none)       ispell-message
;; C-u ESC $    ispell-continue
;; (none)       ispell-kill-ispell
;; ESC TAB      ispell-complete-word


;; Window Commands
;; -----------------------------------------------------------------------------
;; C-x 0        delete-window
;; C-x 1        delete-other-windows
;; C-x 2        split-window-vertically
;; C-x 3        split-window-horizontally
;; C-x o        other-window
;; C-x +        balance-windows


;; Buffer Manipulation
;; -----------------------------------------------------------------------------
;; C-x b        switch-to-buffer
;; C-x C-b      list-buffers
;; C-x k        kill-buffer
;; (none)       kill-some-buffers
;; (none)       rename-buffer
;; C-x s        save-some0-buffers


;; Buffer List Commands
;; -----------------------------------------------------------------------------
;; C-n          Next buffer in list
;; SPACE        Next buffer in list
;; C-p          Preview buffer in list
;; d            Mark for deletion
;; k            Mark for deletion
;; s            Save buffer
;; u            Unmark buffer
;; x            Execute other one-letter commands
;; DEL          Unmark previous buffer in list
;; ~            Mark buffer as unmodified
;; %            Toggle read-only status
;; 1            Display buffer in full screen
;; 2            Display this buffer and next in horizontal windows
;; f            Replace buffer list with this one
;; o            Replace other window with this buffer
;; m            Mark buffers to be displayed in windows
;; v            Display buffers marked with m
;; q            Quit buffer list


;; Bookmarks
;; -----------------------------------------------------------------------------
;; ~/.emacs.bmk is user bookmark file
;; C-x r m      bookmark-set
;; C-x r b      bookmark-jump
;; (none)       bookmark-rename
;; (none)       bookmark-delete
;; C-x r 1      (none)                                            List bookmarks


;; Commands for Editing Bookmark List
;; -----------------------------------------------------------------------------
;; d            Flag for deletion
;; r            Rename bookmark
;; s            Save all bookmarks listed
;; f            Display the bookmark
;; m            Mark bookmarks to be displayed in multiple windows
;; v            Display marked bookmarks or the one the cursor is on
;; t            Toggle display of paths to files
;; w            Display location of file associated with bookmark
;; x            Delete bookmarks flagged for deletion
;; u            Remove mark from bookmark
;; DEL          Remove mark from bookmark on previous line
;; q            Exit bookmark list


;; Shell
;; -----------------------------------------------------------------------------
;; (none)       shell                                        Run shell in buffer
;; ESC !        shell-command                    Run shell command in minibuffer
;; ESC |        shell-command-on-region   Run shell command with region as input
;; C-u ESC |               Same as above, but replace region with command output


;; Shell Mode Commands
;; -----------------------------------------------------------------------------
;; (none)       shell                                           Enter shell mode
;; C-c C-c      comint-interrupt-subjob         Equivalent to C-c in UNIX shells
;; C-d          comint-delchar-or-maybe-eof  Send EOF at end of buffer or delete
;; C-c C-d      comint-send-eof                               Send EOF character
;; C-c C-u      comint-kill-input               Equivalent to C-u in UNIX shells
;; C-c C-z      comint-stop-subjob              Equivalent to C-z in UNIX shells
;; ESC p        comint-previous-input                 Retrieve previous commands
;; ESC n        comint-next-input                   Retrieve subsequent commands
;; RETURN       comint-send-input                     Send input on current line
;; TAB          comint-dynamic-complete    Complete current command/filename/var
;; C-c C-o      comint-kill-output               Delete output from last command
;; C-c C-r      comint-show-output    Move first line of output to top of window
;; C-c C-e      comint-show-maximum-output    Move last line of output to bottom
;; C-c C-p      comint-previous-prompt                  Move to previous command
;; C-c C-n      comint-next-prompt                          Move to next command


;; Dired Commands
;; -----------------------------------------------------------------------------
;; C-x d        dired
;; C            dired-do-copy                                          Copy file
;; d            dired-flag-deletion                              Flag for delete
;; D            dired-do-delete                       Query for immediate delete
;; e            dired-find-file                                        Edit file
;; f            dired-advertised-find-file                       Find (for edit)
;; g            revert-buffer                     Reread the directory from disk
;; G            dired-do-chgrp                          Change group permissions
;; k            dired-do-kill-lines                     Remove line from display
;; m            dired-mark                                           Mark with *
;; n            dired-next-line                                Move to next line
;; o            dired-find-file-other-window         Find file in another window
;; C-o          dired-display-file       Find file in another window; don't move
;; P            dired-do-print                                        Print file
;; q            dired-quit                                            Quit dired
;; Q            dired-do-query-replace      Query replace string in marked files
;; R            dired-do-rename                                      Rename file
;; u            dired-unmark                                         Remove mark
;; v            dired-view-file                                        View file
;; x            dired-do-flagged-delete              Delete files flagged with D
;; Z            dired-do-compress                   Compress or uncompress files
;; ESC DEL      dired-unmark-all-files                          Remove all marks
;; ~            dired-flag-backup-files           Flag backup files for deletion
;;                                                             Unmark with C-u ~
;; *            dired-mark-executables       Mark executables; Unmark with C-u *
;; #            dired-flag-auto-save-files     Flag auto-save files for deletion
;;                                                             Unmark with C-u #
;; .            dired-clean-directory         Flag numbered backups for deletion
;; /            dired-mark-directories       Mark directories; Unmark with C-u /
;; =            dired-diff                 Compare this file and the one at mark
;; ESC =        dired-backup-diff              Compare this file with its backup
;; !            dired-do-shell-command  Ask for shell command to execute on file
;; ESC }        dired-next-marked-file                  Move to next marked file
;; ESC {        dired-prev-marked-file              Move to previous marked file
;; % d          dired-flag-files-regexp
;; % m          dired-mark-files-regexp
;; +            dired-create-directory
;; >            dired-next-dirline
;; <            dired-prev-dirline
;; s            dired-sort-toggle-or-edit


;; Printing Commands
;; -----------------------------------------------------------------------------
;; print-buffer
;; print-region
;; lpr-buffer
;; lpr-region
;; dired-do-print
;; ps-print-buffer-with-faces
;; lpr switches example: (setq lpr-switches '("-Plpt1"))


;; Reading Manpages
;; -----------------------------------------------------------------------------
;; man
;; manual-entry


;; Displaying the time
;; -----------------------------------------------------------------------------
;; display-time


;; Calendar
;; -----------------------------------------------------------------------------
;; calendar
;; .            calendar-goto-today
;; C-f          calendar-forward-day
;; C-b          calendar-backward-day
;; C-n          calendar-forward-week
;; C-p          calendar-backward-week
;; ESC }        calendar-forward-month
;; ESC {        calendar-backward-month
;; C-x ]        calendar-forward-year
;; C-x [        calendar-backward-year
;; C-a          calendar-beginning-of-week
;; C-e          calendar-end-of-week
;; ESC a        calendar-beginning-of-month
;; ESC e        calendar-end-of-month
;; ESC <        calendar-beginning-of-year
;; ESC >        calendar-end-of-year
;; C-u n        universal-argument
;; g d          calendar-goto-date
;; o            calendar-other-month
;; C-x <        scroll-calendar-left
;; C-x >        scroll-calendar-right
;; SPACE        scroll-other-window


;; Displaying Holidays
;; -----------------------------------------------------------------------------
;; a            list-calendar-holidays
;; ESC x holidays                                     Holidays surrounding month
;; h            (none)                                 See if today is a holiday


;; Calendar and Diary Commands
;; -----------------------------------------------------------------------------
;; p d          calendar-print-day-of-year
;; SPACE        scroll-other-window
;; q            exit-calendar
;; a            list-calendar-holidays
;; h            calendar-cursor-holidays
;; x            mark-calendar-holidays
;; u            calendar-unmark
;; i w          insert-weekly-diary-entry
;; i y          insert-yearly-diary-entry
;; i d          insert-diary-entry
;; i m          insert-monthly-diary-entry
;; i c          insert-cyclic-diary-entry
;; i a          insert-anniversary-diary-entry
;; i b          insert-block-diary-entry
;; m            mark-diary-entries
;; d            view-diary-entries
;; s            show-all-diary-entries
;; ESC =        calendar-count-days-region
;; M            calendary-phases-of-moon
;; S            calendar-sunrise-sunset
;; C-SPACE      calendar-set-mark


;; Summary of Tab Commands
;; -----------------------------------------------------------------------------
;; edit-tab-stops                                            Change tab settings
;; tabify                                                         Spaces to tabs
;; untabify                                                       Tabs to spaces
;; fill-individual-paragraphs                                Reformat paragraphs


;; Using Fill Prefixes
;; -----------------------------------------------------------------------------
;; C-x .        set-fill-prefix       After typing a prefix at beginning of line
;; M-q          fill-paragraph


;; Indentation
;; -----------------------------------------------------------------------------
;; auto-fill-mode
;; indented-text-mode
;; ESC m        back-to-indentation
;; ESC C-o      split-line


;; Centering Text
;; -----------------------------------------------------------------------------
;; ESC x text-mode                                          Must be in text-mode
;; ESC s        center-line
;; ESC S        center-paragraph
;; (none)       center-region


;; Rectangle Commands
;; -----------------------------------------------------------------------------
;; C-x r k      kill-rectangle
;; C-x r d      delete-rectangle
;; C-x r y      yank-rectangle
;; C-x r c      clear-rectangle
;; C-x r o      open-rectangle


;; Picture Mode Commands
;; -----------------------------------------------------------------------------
;; edit-picture                                               Enter picture mode
;; C-c C-e      picture-mode-exit                              Exit picture mode
;; C-c ^        picture-movement-up
;; C-c .        picture-movement-down
;; C-c >        picture-movement-right
;; C-c <        picture-movement-left
;; C-c `        picture-movement-nw
;; C-c '        picture-movement-ne
;; C-c /        picture-movement-sw
;; C-c \        picture-movement-se
;; C-c C-f      picture-motion
;; C-c C-b      picture-motion-reverse
;; C-f          picture-forward-column
;; C-b          picture-backward-column
;; C-n          picture-move-down
;; C-p          picture-move-up
;; C-d          picture-clear-column
;; C-c C-d      delete-char
;; C-k          picture-clear-line
;; C-o          picture-open-line
;; C-c C-w r    picture-clear-rectangle-to-register
;; C-u C-c C-w r picture-clear-rectangle-to-register
;; C-c C-x r    picture-yank-rectangle-from-register


;; Macro Commands
;; -----------------------------------------------------------------------------
;; C-x (        start-kbd-macro
;; C-x )        end-kbd-macro
;; C-x e        call-last-kbd-macro
;; ESC n C-x e  digit-argument; call-last-kbd-macro
;; C-u C-x (    universal-argument; start-kbd-macro
;; (none)       name-last-kbd-macro
;; (none)       load-file
;; (none)       macroname
;; C-x q        kbd-macro-query
;; C-u C-x q    (none)             Insert a recursive edit in a macro definition
;; ESC C-c      exit-recursive-edit


;; Customizing Emacs
;; -----------------------------------------------------------------------------
;; Every emacs command corresponds to a LISP function.
;;     (function-name args)
;;
;; Example: ESC f is bound to (forward-word 1)
;;
;; Key strokes are associated with commands via key bindings.
;; A keymap is a collection of key bindings.
;;
;; The 2 keymaps are:
;;     global-keymap
;;     local-keymap
;;
;; 3 functions for creating key bindings:
;;     (define-key keymap "keystroke" 'command-name)
;;     (global-set-key "keystroke" 'command-name)
;;     (local-set-key "keystroke" 'command-name)
;;
;; Special Character Conventions
;; -----------------------------
;; \C-x         C-x
;; \C-[ or \e   ESC
;; \C-j or \n   LINEFEED
;; \C-m or \r   RETURN
;; \C-i or \t   TAB
;;
;; Emacs Variables
;; ---------------
;; boolean      t or nil
;; strings      chars in double quotes
;; characters   preceded with ?
;; symbols      preceded with single quote
;; setq         LISP function sets local value for a variable
;; setq-default LISP function sets default value for a variable


;; C-Mode
;; -----------------------------------------------------------------------------
;; ESC ;        indent-for-comment                  Uses comment-column variable
;; (none)       comment-region
;; (none)       kill-comment
;;
;; Advanced C Motion Commands
;; --------------------------
;; ESC a        c-beginning-of-statement
;; ESC e        c-end-of-statement
;; ESC q        c-fill-paragraph
;; ESC C-a      beginning-of-defun
;; ESC C-e      end-of-defun
;; ESC C-h      c-mark-function
;; C-c C-q      c-indent-function
;; C-c C-u      c-up-conditional
;; C-c C-p      c-backward-conditional
;; C-c C-n      c-forward-conditional
;;
;; Customizing Code Indentation Style
;; ----------------------------------
;; c-set-style                            Press TAB to see completions available
;;
;; C-c C-a      c-toggle-auto-state                          Toggle auto-newline
;; C-c C-d      c-toggle-hungry-state                   Toggle hungry-delete key
;; ESC j        indent-new-comment-line                Toggle comment-multi-line
;; C-c C-e      c-macro-expand
;; C-c :        c-scope-operator              Insert :: without causing reindent
;; (none)       c-forward-into-nomenclature
;; (none)       c-backward-into-nomenclature
;; See cc-mode.el


;; etags
;; -----------------------------------------------------------------------------
;; A multi-file search facility. Helpful for large multifile projects.
;;
;; Run the shell command etags *.[ch] to create the file TAGS.
;; Make the TAGS file known to emacs by ESC x visit-tags-file or add themes
;; following to your .emacs file:
;;
;;     (setq tags-table-list '("path-to-TAGS-1" "path-to-TAGS-2"))
;;
;; Now you can use emacs tags commands.
;;
;; etags Commands
;; --------------
;; ESC .        find-tag
;; ESC . C-x 4 . find-tag-other-window
;; ESC ,        tags-loop-continue
;; (none)       tags-search               Use regular expression to search files
;; (none)       tags-query-replace          Use regular expression query-replace
;;                                   Use C-u argument to match only entire words
;; (none)       tags-apropos
;; (none)       list-tags                        List all functions for a C file
;;                                ESC . to look at the actual code of a function


;; LISP
;; -----------------------------------------------------------------------------
;;
;; Basic LISP entities
;; -------------------
;; Functions    Procedures, subroutines, programs, operators.
;; Variables    Do not have types.
;; Atoms        Values of any type.
;;              Integers, floats, chars, strings, booleans, symbols.
;;
;; setq         This function assigns a value to varible.
;;              Can be used to assign multiple variables in one function call.
;;              Returns the value of the last value assigned.
;;
;; (defun function-name arguments
;;        statement-block)
;; (let ((var1 val1) (var2 val2) ...)
;;      statement-block)
;; (while condition statement-block)
;;
;; Turning LISP Functions into Emacs Commands
;; ------------------------------------------
;; Type (function-name) in LISP interaction window.
;; Place cursor after closing parenthesis and type C-j (or LINEFEED).
;;
;; Register LISP function with Emacs with (interactive "prompt-string")
;;
;; To add a documentation string for C-h f:
;; (defun function-name ()
;;        "documentation string"
;;        statement-block)
;;
;; LISP Primitive Functions
;; ------------------------
;; Arithmetic   +, -, *, /
;;              %                                                      remainder
;;              1+                                                     increment
;;              1-                                                     decrement
;;              max, min
;; Comparison   >, <, >=, <=
;;              /=                                                     not equal
;;              =                                    equal for numbers and chars
;;              equal                       equal for strings and comple objects
;; Logic        and, or, not
;;
;; (progn statement-block)     Make a block of statements look like a single one
;;
;; (if condition
;;     true-case
;;     false-block)
;;
;; LISP Library
;; ------------
;; load-path, load, load-library, auto-load


;; X Display Customizations
;; -----------------------------------------------------------------------------
;; (menu-bar-mode nil)
;; (setq pop-up-frames t)
;; In ~/.Xdefaults: Emacs.geometry:=80x49+270+0
