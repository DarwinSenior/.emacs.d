(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(load-user-file "company-complete-cycle.el")
(setq company-idle-delay 0)
(require-package 'company-tern)
(setq company-backends
      '(
	(company-files
	company-keywords
	company-yasnippet
	company-dabbrev-code
	company-capf)))

(require-package 'company-quickhelp)
(company-quickhelp-mode 1)
(setq company-quickhelp-delay 1)
(setq company-minimum-prefix-length 1)
(with-eval-after-load 'company
                      (define-key company-active-map (kbd "C-w") nil))

(require-package 'flycheck)
(global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
(nmap "[ s" 'flycheck-previous-error)
(nmap "] s" 'flycheck-next-error)

