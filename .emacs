(setq inhibit-startup-echo-area-message t
      inhibit-startup-screen t)

(add-hook 'find-file-hook
	     '(lambda ()
		(if (not (eq nil (get-buffer "*scratch*")))
		    (kill-buffer "*scratch*"))))

(setq default-frame-alist '((background-color . "black")
			    (foreground-color . "light grey")))

(when window-system
  (tool-bar-mode -1)
  (global-linum-mode)
  (when (eq system-type 'darwin) ;; mac specific settings
    (setq mac-option-modifier 'meta
	  mac-right-option-modifier nil
	  x-select-enable-clipboard t
	  aquamacs-save-options-on-quit nil)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    (global-set-key [A-return] 'ns-toggle-fullscreen)
    ))

; don't want trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
