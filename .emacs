(setq inhibit-startup-echo-area-message t)

(setq default-frame-alist '((background-color . "black")
			    (foreground-color . "light grey")
			    (font . "Inconsolata-dz 12")))

(when window-system
  (tool-bar-mode -1)
  (global-linum-mode)
  (when (eq system-type 'darwin) ;; mac specific settings
    (setq mac-option-modifier 'meta
	  mac-right-option-modifier nil
	  x-select-enable-clipboard t)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    (global-set-key [A-return] 'ns-toggle-fullscreen)
    ))
