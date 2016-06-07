(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(load-user-file "company-complete-cycle.el")
(setq company-idle-delay 0)
(setq company-backends
      '((company-files
          company-yasnippet
          company-keywords
          company-dabbrev-code
          company-capf)))

(require-package 'company-quickhelp)
(company-quickhelp-mode 1)
(setq company-quickhelp-delay 2)
(setq company-minimum-prefix-length 1)
(with-eval-after-load 'company
                      (define-key company-active-map (kbd "C-w") nil))


