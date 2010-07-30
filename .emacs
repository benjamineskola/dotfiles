; -*-Emacs-Lisp-*-

(setq tab-width 8)
(setq indent-tabs-mode t)
(setq make-backup-files nil)
(setq default-major-mode 'text-mode)

(setq bbdb-north-american-phone-numbers-p nil)

(menu-bar-mode -1)
(setq require-final-newline t)
(setq vc-follow-symlinks t)

(define-key global-map (kbd "RET") 'newline-and-indent)

;; c
(defun bsd () (interactive)
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
  )

(add-hook 'c-mode-common-hook 'bsd)

;; org-mode stuff
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-include-diary t)

(setq org-agenda-files
      (list "~/.data/org/todo.org"))

(setq european-calendar-style t)

;; set up org-mode/remember
(org-remember-insinuate)
(setq org-directory "~/.data/org")
(setq org-default-notes-file (concat org-directory "/todo.org"))
(define-key global-map "\C-cr" 'org-remember)
(setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n  %i\n  %a" "~/.data/org/todo.org" "Tasks")))

(defun wc ()
  (interactive)
  (message "Word count: %s" (how-many "\\w+" (point-min) (point-max))))

;; stuff related to mutt.
(defun axels-mail-mode-hook ()
  (turn-on-auto-fill) ;;; Auto-Fill is necessary for mails
  (turn-on-font-lock) ;;; Font-Lock is always cool *g*
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*") ;;; Kills quoted sigs. 
  (not-modified) ;;; We haven't changed the buffer, haven't we? *g*
  (mail-text) ;;; Jumps to the beginning of the mail text
  (setq make-backup-files nil) ;;; No backups necessary.
)

(or
  (assoc "mutt-" auto-mode-alist)
  (setq auto-mode-alist (cons '("mutt-" . mail-mode) auto-mode-alist)))
(add-hook 'mail-mode-hook 'axels-mail-mode-hook)

(defface font-lock-comment-face ((nil (:foreground "red"))))
(defface identica-reply-face ((t nil)))

(dolist (file
	 (file-expand-wildcards "~/.emacs.d/conf/*.el"))
  (load file))

(setq cssm-indent-level 8)
(setq cssm-newline-before-closing-bracket t)
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-mirror-mode nil)

(global-linum-mode 1)
(setq linum-format "%d ")
