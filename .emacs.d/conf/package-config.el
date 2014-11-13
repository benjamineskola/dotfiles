(provide 'package-config)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(defvar package-list '(
		       smooth-scroll
		       puppet-mode
		       ))

(dolist (p package-list)
  (when (not (package-installed-p p))
    (package-install p))
  (require p))
