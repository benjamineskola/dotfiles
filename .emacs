(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(dolist (p '(smooth-scroll puppet-mode))
  (when (not (package-installed-p p))
    (package-install p))
  (require p))
(smooth-scroll-mode)
(cua-selection-mode t)

(setq inhibit-startup-echo-area-message t
      inhibit-startup-screen t)

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
	  aquamacs-autoface-mode nil
	  ns-pop-up-frames nil)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    (global-set-key [A-return] 'ns-toggle-fullscreen) ;; aquamacs
    (global-set-key [s-return] 'toggle-frame-fullscreen) ;; cocoa emacs
    ))

; don't want trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
