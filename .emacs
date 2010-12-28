; -*-Emacs-Lisp-*-
(add-to-list 'load-path "~/.config/emacs/")
(require 'gui-setup)

(setq tab-width 8)
(setq indent-tabs-mode t)
(setq make-backup-files nil)
(setq default-major-mode 'text-mode)

(setq inhibit-startup-screen t)

(global-set-key (kbd "<mouse-2>") 'yank)

(setq require-final-newline t)
(setq vc-follow-symlinks t)

(require 'linum) ; needs to be loaded first.
(setq linum-disabled-modes-list '(identica-mode twittering-mode))
(defun linum-on ()
;  (print major-mode)
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list) (string-match "*" (buffer-name)))
    (linum-mode 1)))
(global-linum-mode 1)
(setq linum-format "%d ")

(column-number-mode)

(display-time)
(setq display-time-24hr-format t)

(setq show-trailing-whitespace t)

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
(require 'mail-config)

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
(add-hook 'identica-mode-hook
	  '(lambda ()
	     (set-face-background 'identica-reply-face nil)
	     (set-face-foreground 'identica-reply-face nil)))

(global-set-key [f1] 'help)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "www")

(require 'twittering-mode)
(require 'identica-mode)
