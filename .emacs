(set 'inhibit-startup-screen t)

(add-hook 'find-file-hook 'whitespace-mode)
(setq whitespace-style '(face tabs trailing lines
			      space-before-tab newline
			      indentation empty space-after-tab
			      tab-mark newline-mark))

(global-linum-mode 1)
(setq linum-format (format "%%d%c" ?\x200B))

(if window-system
    (set 'default-frame-alist
	 '((background-color . "black")
	   (foreground-color . "light grey")
	   (font . "Inconsolata-dz-12"))))

(tool-bar-mode -1)

(setq mac-command-modifier 'super
      ns-alternate-modifier 'meta
      ns-right-alternate-modifier 'none)
(global-set-key (kbd "<s-return>") 'ns-toggle-fullscreen)
