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

;; this is a work round for fci rendering,
;; this will temperary turn of the fci when company has options
;; (defun my/on-off-fci-before-company(command)
;;   (when (string= "show" command)
;;     (turn-off-fci-mode))
;;   (when (string= "hide" command)
;;     (turn-on-fci-mode)
;;     (when (bound-and-true-p visual-line-mode)
;; 	(turn-on-visual-line-mode))))
;; (advice-add 'company-call-frontends :before #'my/on-off-fci-before-company)


(require-package 'company-quickhelp)
(company-quickhelp-mode 1)
(setq company-quickhelp-delay 1)
(setq company-minimum-prefix-length 1)
(with-eval-after-load 'company
                      (define-key company-active-map (kbd "C-w") nil))

