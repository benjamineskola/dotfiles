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
