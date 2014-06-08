(provide 'darwin)
(when (display-graphic-p)
    (setq mac-option-modifier 'meta
	  mac-right-option-modifier nil
	  x-select-enable-clipboard t
	  ns-pop-up-frames nil)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    (global-set-key [s-return] 'toggle-frame-fullscreen)
    (global-set-key (kbd "s-q") 'ask-before-closing))
