(setq gnus-select-method
      '(nnimap "mail" (nnimap-stream shell)))
(setq imap-shell-program "env MAIL=maildir:~/mail:LAYOUT=fs /usr/lib/dovecot/imap 2> /dev/null")

(if (not (string-equal (getenv "HOSTNAME") "bma-desktop")) ; don't want usenet at work.
    (setq gnus-secondary-select-methods '((nntp "nntp.aioe.org") (nntp "news.gmane.org"))))

(setq gnus-message-archive-group "nnimap+mail:archive"
      nndraft-directory "~/mail/drafts"
      nntp-marks-directory "~/.data/news/marks"
      gnus-cache-directory "~/.data/news/cache"
      gnus-agent-directory "~/.data/news/gnus-agent"
      gnus-startup-file "~/.data/news/newsrc"
      gnus-kill-files-directory "~/.data/news/scores"
      gnus-treat-display-smileys nil
      gnus-group-line-format "%M%S%p%P%5y:%B%(%G%)%O\n"
      gnus-save-newsrc-file nil)

(setq gnus-buttonized-mime-types '("multipart/signed"))
(setq gnus-summary-line-format "%U%R |%-20,20f |%&user-date; %37=|%4L|%B %s\n")

(eval-after-load "mm-decode"
 '(progn
      (add-to-list 'mm-discouraged-alternatives "text/html")
      (add-to-list 'mm-discouraged-alternatives "text/richtext")))

; i don't like having read messages hidden by default.
(defun gnus-group-select-group-all ()
  (interactive)
  (gnus-group-select-group t))
(define-key gnus-agent-group-mode-map (kbd "C-m") 'gnus-group-select-group-all)
