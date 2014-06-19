(provide 'package-config)
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(dolist (p '(smooth-scroll puppet-mode))
  (when (not (package-installed-p p))
    (package-install p))
  (require p))
