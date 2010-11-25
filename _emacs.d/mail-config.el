(provide 'mail-config)

(or
  (assoc "mutt-" auto-mode-alist)
  (setq auto-mode-alist (cons '("mutt-" . mail-mode) auto-mode-alist)))

(defun kill-quoted-signature ()
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*") ;;; Kills quoted sigs.
  (not-modified) ;;; We haven't changed the buffer, haven't we? *g*
  (mail-text) ;;; Jumps to the beginning of the mail text
)

(add-hook 'mail-mode-hook 'kill-quoted-signature)
(add-hook 'message-mode-hook 'kill-quoted-signature)
(add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)
(add-hook 'message-mode-hook '(lambda () (define-key message-mode-map (kbd "M-TAB") 'bbdb-complete-name)))

;; notmuch
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

;; bbdb
(setq bbdb-north-american-phone-numbers-p nil)
