(provide 'gui)
(tool-bar-mode -1)
(global-linum-mode)
(global-set-key (kbd "C-x C-c") 'close-all-buffers)

(setq default-frame-alist '((background-color . "black")
			    (foreground-color . "light grey")
			    (font . "Inconsolata-dz 12")))
