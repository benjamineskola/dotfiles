;; ERC

(add-hook 'erc-mode-hook '(lambda ()
  (global-linum-mode nil)
  (setq erc-log-channels-directory "~/.data/erc/logs/")
  (setq erc-log-insert-log-on-open nil)
  (setq erc-log-file-coding-system 'utf-8)
  (add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
  (add-hook 'erc-send-post-hook 'erc-save-buffer-in-logs)

  (erc-scrolltobottom-enable)
  (setq erc-input-line-position -1)
  (erc-autojoin-mode 1)
  (setq erc-auto-query 'bury)

  (setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof
                                      -CAfile /home/bma/.private/certs/CAs.pem
                                      -cert /home/bma/.private/certs/nick.pem"
                    "gnutls-cli --priority secure256
                                --x509cafile /home/bma/.private/certs/CAs.pem
                                --x509certfile /home/bma/.private/certs/nick.pem -p %p %h"
                    "gnutls-cli --priority secure256 -p %p %h"))
  (setq erc-fill-column 118)
  (setq erc-hide-list (quote ("305" "306")))
  (setq erc-nick "bma")
  (setq erc-query-display (quote window-noselect))
  (setq erc-text-matched-hook (quote (erc-log-matches erc-beep-on-match)))
  (setq erc-track-exclude-server-buffer t)
  (setq erc-track-exclude-types (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353")))
  (setq erc-user-full-name "Benjamin M. A'Lee")

  (setq erc-auto-discard-away t)
  (setq erc-autoaway-idle-seconds 600)
  (setq erc-timestamp-only-if-changed-flag nil
	erc-timestamp-format "%d/%H:%M "
	erc-fill-prefix "         "
	erc-insert-timestamp-function 'erc-insert-timestamp-left)

  (defun erc-cmd-BAN (nick)
    (let* ((chan (erc-default-target))
	   (who (erc-get-server-user nick))
	   (host (erc-server-user-host who))
	   (user (erc-server-user-login who)))
      (erc-send-command (format "MODE %s +b *!%s@*" chan user host))))

  (defun erc-cmd-KICKBAN (nick &rest reason)
    (setq reason (mapconcat #'identity reason " "))
    (and (string= reason "")
	 (setq reason nil))
    (erc-cmd-BAN nick)
    (erc-send-command (format "KICK %s %s %s"
			      (erc-default-target) nick (or reason "Kicked (kickban)"))))

  (add-hook 'erc-insert-post-hook 'erc-truncate-buffer)

  (define-key erc-mode-map (kbd "C-c C-c") ()) ; disable mapping for erc-toggle-interpret-controls

  (add-to-list 'erc-noncommands-list 'erc-cmd-GAWAY)
  (add-to-list 'erc-noncommands-list 'erc-cmd-AWAY)

  (setq erc-keywords '("\\bbma\\b" "\\bbmalee\\b" "\\bbma's\\b" "\\bbmalee's\\b"))

  (add-hook 'window-configuration-change-hook
	    '(lambda ()
	       (setq erc-fill-column (- (window-width) 2))))

  (require 'netrc)
  (setq netrc-data (netrc-parse "~/.netrc"))
  (defun netrc-login (host)
    (netrc-get (netrc-machine netrc-data host t) "login"))
  (defun netrc-password (host)
    (netrc-get (netrc-machine netrc-data host t) "password"))

  (add-hook 'erc-after-connect
	    '(lambda (SERVER NICK)
	       (erc-message "PRIVMSG" (concat "NickServ identify " (netrc-password SERVER)))))

  (set-face-foreground 'erc-current-nick-face "red")
  (set-face-foreground 'erc-input-face "red")
  (set-face-foreground 'erc-keyword-face "red")
  (set-face-foreground 'erc-my-nick-face "red")

  (add-hook 'erc-join-hook 'bitlbee-identify)
  (defun bitlbee-identify ()
    "If we're on the bitlbee server, send the identify command to the
 &bitlbee channel."
    (when (and (string= "localhost" erc-session-server)
	       (string= "&bitlbee" (buffer-name)))
      (erc-message "PRIVMSG" (format "%s identify %s"
				     (erc-default-target)
				     (netrc-password "bitlbee.subvert.org.uk")))))
  
  (defun iswitchb-local-keys ()
    (mapc (lambda (K)
	    (let* ((key (car K)) (fun (cdr K)))
	      (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	  '(("<right>" . iswitchb-next-match)
	    ("<left>"  . iswitchb-prev-match)
	    ("<up>"    . ignore             )
	    ("<down>"  . ignore             ))))

  (add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)


  (defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
    (if (erc-query-buffer-p)
	(setq ad-return-value (intern "erc-current-nick-face"))
      ad-do-it))

  (eval-after-load 'erc-track
    '(progn
       (defun erc-bar-move-back (n)
	 "Moves back n message lines. Ignores wrapping, and server messages."
	 (interactive "nHow many lines ? ")
	 (re-search-backward "^.*<.*>" nil t n))

       (defun erc-bar-update-overlay ()
	 "Update the overlay for current buffer, based on the content of
erc-modified-channels-alist. Should be executed on window change."
	 (interactive)
	 (let* ((info (assq (current-buffer) erc-modified-channels-alist))
		(count (cadr info)))
	   (if (and info (> count erc-bar-threshold))
	       (save-excursion
		 (end-of-buffer)
		 (when (erc-bar-move-back count)
		   (let ((inhibit-field-text-motion t))
		     (move-overlay erc-bar-overlay
				   (line-beginning-position)
				   (line-end-position)
				   (current-buffer)))))
	     (delete-overlay erc-bar-overlay))))

       (defvar erc-bar-threshold 1
	 "Display bar when there are more than erc-bar-threshold unread messages.")
       (defvar erc-bar-overlay nil
	 "Overlay used to set bar")
       (setq erc-bar-overlay (make-overlay 0 0))
       (overlay-put erc-bar-overlay 'face '(:underline "white"))
       ;;put the hook before erc-modified-channels-update
       (defadvice erc-track-mode (after erc-bar-setup-hook
					(&rest args) activate)
	 ;;remove and add, so we know it's in the first place
	 (remove-hook 'window-configuration-change-hook 'erc-bar-update-overlay)
	 (add-hook 'window-configuration-change-hook 'erc-bar-update-overlay))
       (add-hook 'erc-send-completed-hook (lambda (str)
					    (erc-bar-update-overlay)))))

))

(defun run-erc-oftc () "Connect to IRC on OFTC." (interactive)
  (erc-tls :server "irc.oftc.net" :port 6697
	   :nick "bma" :full-name "Benjamin M. A'Lee"))
(defun run-erc-uwcs () "Connect to IRC on UWCS." (interactive)
  (erc-tls :server "irc.uwcs.co.uk" :port 6669
	   :nick "bma" :full-name "Benjamin M. A'Lee"))
(defun run-erc-bitlbee () "Connect to IRC on my local Bitlbee server." (interactive)
  (erc     :server "localhost" :port 6667
	   :nick "bma" :full-name "Benjamin M. A'Lee"))
(defun run-erc-linuxchix () "Connect to Linuxchix IRC" (interactive)
  (erc-tls :server "irc.linuxchix.org" :port 6697
	   :nick "bma" :full-name "Benjamin M. A'Lee"))
(defun run-erc-freenode () "Connect to FreeNode IRC" (interactive)
  (erc-tls :server "irc.freenode.net" :port 7000
	   :nick "bmalee" :full-name "Benjamin M. A'Lee"))

(defun run-erc () "Connect to IRC." (interactive)
  (require 'erc-join)
  (require 'erc-autoaway)
  (require 'erc-button)
  (require 'erc-fill)
  (require 'erc-match)
  (require 'erc-menu)
  (require 'erc-netsplit)
  (require 'erc-networks)
  (require 'erc-ring)
  (require 'erc-stamp)
  (require 'erc-track)
  (require 'erc-log)
  (require 'tls)

  (run-erc-oftc)
  (run-erc-uwcs)
  (run-erc-bitlbee)
  (run-erc-linuxchix)
  (run-erc-freenode)
)
