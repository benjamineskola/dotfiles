(provide 'org-config)

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-include-diary t)

(setq org-agenda-files
      (list "~/.data/org/todo.org" "~/.data/org/todo.org_archive"))

(setq european-calendar-style t)

;; set up org-mode/remember
(org-remember-insinuate)
(setq org-directory "~/.data/org/")
(setq org-default-notes-file (concat org-directory "/todo.org"))
(define-key global-map "\C-cr" 'org-remember)
(setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n  %i\n  %a" "~/.data/org/todo.org" "Tasks")))

(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; org-mode holidays (actually diary-mode)
(setq holiday-general-holidays
      '((holiday-fixed 1 1 "New Year's Day")
       (holiday-fixed 2 14 "Valentine's Day")
       (holiday-float 3 0 -1 "Mother's Day")
       (holiday-fixed 4 1 "April Fools' Day")
       (holiday-fixed 5 1 "International Workers' Day")
       (holiday-float 6 0 3 "Father's Day")
       (holiday-fixed 10 31 "Hallowe'en")
       (holiday-fixed 11 11 "Remembrance Day")
       (holiday-float 11 0 1 "Remembrance Sunday" 11)
       (holiday-fixed 12 31 "New Year's Eve"))
)

(setq calendar-chinese-all-holidays-flag t
      calendar-christian-all-holidays-flag t
      calendar-hebrew-all-holidays-flag t
      calendar-islamic-all-holidays-flag t)
