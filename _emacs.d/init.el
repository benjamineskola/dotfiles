; -*-Emacs-Lisp-*-

(setq tab-width 8)
(setq indent-tabs-mode t)
(setq make-backup-files nil)
(setq default-major-mode 'text-mode)

(setq bbdb-north-american-phone-numbers-p nil)

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(global-set-key (kbd "<mouse-2>") 'yank)

(setq require-final-newline t)
(setq vc-follow-symlinks t)

(global-linum-mode 1)
(setq linum-format "%d ")

(column-number-mode)

(display-time)
(setq display-time-24hr-format t)

(setq show-trailing-whitespace t)

(add-to-list 'load-path "~/.emacs.d/")

;; c
(add-hook 'c-mode-common-hook
	  '(lambda () (interactive)
	     (c-set-style "bsd")
	     (setq indent-tabs-mode t)
	     ;; Use C-c C-s at points of source code so see which
	     ;; c-set-offset is in effect for this situation
	     (c-set-offset 'defun-block-intro 8)
	     (c-set-offset 'statement-block-intro 8)
	     (c-set-offset 'statement-case-intro 8)
	     (c-set-offset 'substatement-open 4)
	     (c-set-offset 'substatement 8)
	     (c-set-offset 'arglist-cont-nonempty 4)
	     (c-set-offset 'inclass 8)
	     (c-set-offset 'knr-argdecl-intro 8)
	     (local-set-key (kbd "RET") 'newline-and-indent)
	     ))

;; css
(setq cssm-indent-level 8)
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-mirror-mode nil)

;; mail
(or
  (assoc "mutt-" auto-mode-alist)
  (setq auto-mode-alist (cons '("mutt-" . mail-mode) auto-mode-alist)))

(add-hook 'mail-mode-hook '(lambda ()
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*") ;;; Kills quoted sigs.
  (not-modified) ;;; We haven't changed the buffer, haven't we? *g*
  (mail-text) ;;; Jumps to the beginning of the mail text
))

;; notmuch
(add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)
(add-hook 'message-mode-hook '(lambda () (define-key message-mode-map (kbd "M-TAB") 'bbdb-complete-name)))
(setq notmuch-fcc-dirs
       '((".*@mendeley.com" . "mendeley/archive")
	 (".*" . "archive")))
(setq notmuch-saved-searches '(
                       ("inbox" . "tag:inbox AND NOT tag:mendeley")
                       ("personal" . "tag:personal AND tag:unread")
                       ("inbox/work" . "tag:mendeley AND tag:inbox AND NOT tag:trac")
                       ("archive" . "*")
                       ("archive/work" . "tag:mendeley")
                       ("trac" . "tag:mendeley AND tag:trac AND tag:unread")
                       ("archive/trac" . "tag:mendeley AND tag:trac")
                       ("feeds" . "tag:feeds AND tag:unread")
                       ("archive/feeds" . "tag:feeds")
))

;; php
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . html-mode))

;; python
(add-hook 'python-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "RET") 'newline-and-indent)
	     (add-to-list 'safe-local-variable-values '(encoding . utf-8))))

;; ruby
(add-hook 'ruby-mode-hook
	  '(lambda () (interactive)
	     (setq indent-tabs-mode t)
	     (setq ruby-indent-tabs-mode t)
	     (setq ruby-indent-level 8)
	     (local-set-key (kbd "RET") 'newline-and-indent)
	     ))

;; shell
(add-hook 'sh-mode-hook
	  '(lambda () (interactive)
	     (setq sh-basic-offset 8
		   sh-indentation 8
		   sh-indent-for-case-label 0
		   sh-indent-for-case-alt '+)))

;; org-mode stuff
(require 'org-config)

;; functions
(defun wc ()
  (interactive)
  (message "Word count: %s" (how-many "\\w+" (point-min) (point-max))))

;; faces
(set-face-foreground 'font-lock-comment-face "red")
(set-face-foreground 'default "lightgray")
(set-face-background 'default "black")

(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono 11"))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . right))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))

(add-hook 'identica-mode-hook
	  '(lambda ()
	     (set-face-background 'identica-reply-face nil)
	     (linum-mode nil)
	     ))

(add-hook 'twittering-mode-hook
	  '(lambda ()
	     (linum-mode nil)
	     ))

(global-set-key [f1] 'help)

(require 'twittering-mode)
(require 'identica-mode)
