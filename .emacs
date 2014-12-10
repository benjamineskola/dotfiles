(add-to-list 'load-path "~/.emacs.d/conf")
(require 'package-config)

(setq cache-directory (expand-file-name "~/.cache/emacs")) ; do first so 'system-type can override.
(when (display-graphic-p)
  (require 'gui))
(require system-type)

(setq inhibit-startup-echo-area-message t
      inhibit-startup-screen t)

(with-eval-after-load 'smooth-scroll-mode
  (smooth-scroll-mode))
(cua-selection-mode t)

(setq tramp-default-method "ssh")

; indentation
(setq indent-tabs-mode nil ; most things I use want spaces by default
      js-indent-level 8
      ruby-deep-indent-paren nil
      sh-basic-offset 8
      sh-indentation 8)
(add-hook 'sh-mode-hook (lambda () (setq indent-tabs-mode t)))
(add-hook 'js-mode-hook (lambda () (setq indent-tabs-mode t)))
(add-to-list 'auto-mode-alist
             '("\\.json\\'" . (lambda ()
                                (progn
                                  (js-mode)
                                  (setq-local indent-tabs-mode nil)
                                  (setq-local js-indent-level 2)))))
(electric-indent-mode +1)
(electric-pair-mode 1)

(show-paren-mode 1)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match "#040")

(setq-default cursor-type 'bar)
(set-face-background 'cursor "green")

(setq ruby-insert-encoding-magic-comment nil)

; don't want trailing whitespaces.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

; utf-8 everything
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-locale-environment "en_GB.UTF-8")
(prefer-coding-system 'utf-8)

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

(add-to-list 'backup-directory-alist `("." . ,cache-directory))

(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'tex-mode-hook 'flyspell-mode)
(add-hook 'tex-mode-hook 'visual-line-mode)
(add-hook 'tex-mode-hook (lambda () (progn
				      (setq fill-column 999999)
				      (set-visual-wrap-column 80))))

(setq flyspell-default-dictionary "british"
      ispell-dictionary "british"
      ispell-program-name "/usr/local/bin/aspell"
      ispell-list-command "--list")

(defvar visual-wrap-column nil)
(defun set-visual-wrap-column (new-wrap-column &optional buffer)
  "Force visual line wrap at NEW-WRAP-COLUMN in BUFFER (defaults
    to current buffer) by setting the right-hand margin on every
    window that displays BUFFER.  A value of NIL or 0 for
    NEW-WRAP-COLUMN disables this behavior."
  (interactive (list (read-number "New visual wrap column, 0 to disable: " (or visual-wrap-column fill-column 0))))
  (if (and (numberp new-wrap-column)
	   (zerop new-wrap-column))
      (setq new-wrap-column nil))
  (with-current-buffer (or buffer (current-buffer))
    (visual-line-mode t)
    (set (make-local-variable 'visual-wrap-column) new-wrap-column)
    (add-hook 'window-configuration-change-hook 'update-visual-wrap-column nil t)
    (let ((windows (get-buffer-window-list)))
      (while windows
	(when (window-live-p (car windows))
	  (with-selected-window (car windows)
	    (update-visual-wrap-column)))
	(setq windows (cdr windows))))))

(defun update-visual-wrap-column ()
  (if (not visual-wrap-column)
      (set-window-margins nil nil)
    (let* ((current-margins (window-margins))
	   (right-margin (or (cdr current-margins) 0))
	   (current-width (window-width))
	   (current-available (+ current-width right-margin)))
      (if (<= current-available visual-wrap-column)
	  (set-window-margins nil (car current-margins))
	(set-window-margins nil (car current-margins)
			    (- current-available visual-wrap-column))))))
