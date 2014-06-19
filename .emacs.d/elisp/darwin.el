(provide 'darwin)

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(when (display-graphic-p)
    (setq mac-option-modifier 'meta
	  mac-right-option-modifier nil
	  x-select-enable-clipboard t
	  ns-pop-up-frames nil)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    (global-set-key [s-return] 'toggle-frame-fullscreen)
    (global-set-key (kbd "s-q") 'ask-before-closing))

(setq cache-directory (expand-file-name "~/Library/Caches/emacs"))
