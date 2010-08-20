; -*-Emacs-Lisp-*-

(setq tab-width 8)
(setq indent-tabs-mode t)
(setq make-backup-files nil)
(setq default-major-mode 'text-mode)

(setq bbdb-north-american-phone-numbers-p nil)

(menu-bar-mode -1)
(setq require-final-newline t)
(setq vc-follow-symlinks t)

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
(or
  (assoc "mutt-" auto-mode-alist)
  (setq auto-mode-alist (cons '("mutt-" . mail-mode) auto-mode-alist)))

(add-hook 'mail-mode-hook '(lambda ()
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*") ;;; Kills quoted sigs.
  (not-modified) ;;; We haven't changed the buffer, haven't we? *g*
  (mail-text) ;;; Jumps to the beginning of the mail text
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

;; org-mode stuff
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-include-diary t)

(setq org-agenda-files
      (list "~/.data/org/todo.org" "~/.data/org/todo.org_archive"))

(setq european-calendar-style t)

;; set up org-mode/remember
(org-remember-insinuate)
(setq org-directory "~/.data/org/")
(setq org-default-notes-file (concat org-directory "/todo.org"))
(define-key global-map "\C-cr" 'org-remember)
(setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n  %i\n  %a" "~/.data/org/todo.org" "Tasks")))

;; functions
(defun wc ()
  (interactive)
  (message "Word count: %s" (how-many "\\w+" (point-min) (point-max))))

;; faces
(set-face-foreground 'font-lock-comment-face "red")

(add-hook 'identica-mode-hook
	  '(lambda ()
	     (set-face-background 'identica-reply-face nil)
	     (linum-mode nil)
	     ))

(add-hook 'twittering-mode-hook
	  '(lambda ()
	     (linum-mode nil)
	     ))

(dolist (file
	 (append
	  (file-expand-wildcards "~/.emacs.d/conf/[a-zA-Z0-9]*.el")
	  (file-expand-wildcards "~/.emacs.d/[a-zA-Z0-9]*.el")
	  )
	 )
  (load file))
