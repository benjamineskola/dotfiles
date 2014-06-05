(add-to-list 'load-path "~/.emacs.d/elisp")
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

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(defun close-all-buffers ()
  "Loop through all buffers and close them."
  (interactive)

  (dolist (buf (buffer-list))
    (unless (string= (buffer-name buf) "*scratch*")
      (kill-buffer buf))))

(when (display-graphic-p)
  (require 'gui))
(require system-type)

; don't want trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)
