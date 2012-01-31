; -*-Emacs-Lisp-*-
; vim:ft=lisp

(add-to-list 'load-path "~/.config/emacs/")
(require 'gui-setup)

(setq indent-tabs-mode t)
(setq tab-width 8)

(setq default-major-mode 'text-mode)
(setq make-backup-files nil)

(setq auto-save-list-file-prefix "~/.cache/emacs/auto-save-list/.saves-"
      user-emacs-directory "~/.config/emacs/")

(setq display-time-24hr-format t)
(setq inhibit-startup-screen t)
(setq require-final-newline t)
(setq show-trailing-whitespace t)
(setq vc-follow-symlinks t)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "www")

(menu-bar-mode -1)
(column-number-mode)
(display-time)

(setq gnus-select-method '(nnimap "mail.subvert.org.uk"
				  (nnimap-stream ssl)))
(setq gnus-secondary-select-methods '((nntp "nntp.aioe.org")
				      (nntp "news.gmane.org")))

(setq nntp-marks-directory "~/.data/news/marks"
      gnus-cache-directory "~/.data/news/cache"
      gnus-agent-directory "~/.data/news/gnus-agent"
      gnus-startup-file "~/.data/news/newsrc"
      gnus-kill-files-directory "~/.data/news/scores"
      gnus-treat-display-smileys nil
      gnus-group-line-format "%M%S%p%P%5y:%B%(%G%)%O\n"
      gnus-read-newsrc-file nil
      gnus-save-newsrc-file nil
      gnus-agent nil)

(setq gnus-buttonized-mime-types '("multipart/signed"))
(setq gnus-summary-line-format "%U%R |%-20,20f |%&user-date; %37=|%4L|%B %s\n")

(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(require 'w3m)

;;(defun commit-newsrc-to-git ()
;;  (interactive)
;;  (shell-command "(cd ~/.data && git add -u news > /dev/null && git commit -q -m 'updating gnus.' && git fetch && git merge -s ours origin/master && git push -q)"))
;;
;;(defun save-and-commit ()
;;  (interactive)
;;  (gnus-group-save-newsrc)
;;  (commit-newsrc-to-git))
;;
;;(add-hook 'gnus-after-exiting-gnus-hook 'commit-newsrc-to-git)
;;(add-hook 'gnus-after-getting-new-news-hook 'save-and-commit)
;;(add-hook 'gnus-started-hook '(lambda () (shell-command "(cd ~/.data && git pull)")))
;;
;;(add-hook 'gnus-group-mode-hook
;;	  '(lambda ()
;;	     (local-set-key "s" 'save-and-commit)))
