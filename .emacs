(set 'inhibit-startup-screen t)

(add-hook 'find-file-hook 'whitespace-mode)
(add-hook 'emacs-lisp-mode-hook '(lambda () (setq indent-tabs-mode nil)))

(setq default-tab-width 8)
(define-key global-map (kbd "RET") 'newline-and-indent)

(setq whitespace-style
      '(face trailing lines space-before-tab newline indentation
             empty space-after-tab tab-mark newline-mark))

(global-linum-mode 1)
(setq linum-format "%d ")

(tool-bar-mode -1)
(menu-bar-mode -1)
(column-number-mode)

(setq backup-directory-alist `(("." . "~/.cache/emacs")))

(if window-system
    (set 'default-frame-alist
         '((background-color . "black")
           (foreground-color . "light grey")
           (font . "Inconsolata-dz-12"))))

(setq mac-command-modifier 'super
      ns-alternate-modifier 'meta
      ns-right-alternate-modifier 'none)
(global-set-key (kbd "<s-return>") 'ns-toggle-fullscreen)
