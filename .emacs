(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(dolist (p '(smooth-scroll))
  (when (not (package-installed-p p))
    (package-install p))
  (require p))

(setq inhibit-startup-echo-area-message t
      inhibit-startup-screen t)

(add-hook 'find-file-hook
	     '(lambda ()
		(if (not (eq nil (get-buffer "*scratch*")))
		    (kill-buffer "*scratch*"))))

(setq default-frame-alist '((background-color . "black")
			    (foreground-color . "light grey")
			    (font . "Inconsolata-dz 12")))

(when window-system
  (tool-bar-mode -1)
  (global-linum-mode)
  (when (eq system-type 'darwin) ;; mac specific settings
    (setq mac-option-modifier 'meta
	  mac-right-option-modifier nil
	  x-select-enable-clipboard t
	  aquamacs-save-options-on-quit nil
	  aquamacs-autoface-mode nil)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    (global-set-key [A-return] 'ns-toggle-fullscreen) ;; aquamacs
    (global-set-key [s-return] 'toggle-frame-fullscreen) ;; cocoa emacs
    ))

; don't want trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
