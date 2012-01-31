(provide 'gui-setup)

(menu-bar-mode -1)
(if window-system
      (tool-bar-mode -1))

(set-face-foreground 'font-lock-comment-face "red")
(set-face-foreground 'default "lightgray")
(set-face-background 'default "black")

(add-to-list 'default-frame-alist '(font . "Droid Sans Mono 10"))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . right))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
