(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'package-config)

(when (display-graphic-p)
  (require 'gui))
(require system-type)

(setq inhibit-startup-echo-area-message t
      inhibit-startup-screen t)

(smooth-scroll-mode)
(cua-selection-mode t)

(setq tramp-default-method "ssh")

; indentation
(setq indent-tabs-mode nil ; most things I use want spaces by default
      sh-basic-offset 8
      sh-indentation 8)
(add-hook 'sh-mode-hook (lambda () (setq indent-tabs-mode t)))
(electric-indent-mode +1)

; don't want trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

; Don't prompt to wrap when isearch reaches the end of a file.
(defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))

(setq backup-by-copying-when-linked t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(add-to-list 'backup-directory-alist `("." . ,(substitute-in-file-name "$XDG_CACHE_HOME/emacs")))

(server-start)
