(provide 'linum-hack)
(require 'linum) ; needs to be loaded first.
(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list) (string-match "*" (buffer-name)))
    (linum-mode 1)))
