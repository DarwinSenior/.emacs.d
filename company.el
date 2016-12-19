(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
;; (load-user-file "company-complete-cycle.el")
(load-user-file "company-auto-expand-frontend.el")
(setq-default company-idle-delay 0)
(setq-default company-backends
      '(
	(company-files
	company-keywords
	company-yasnippet
	company-dabbrev-code
	company-capf)))
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<tab>") 'company-auto-expand-trigger-navigate)
  (define-key company-active-map (kbd "<backtab>") 'company-auto-expand-trigger-navigate-back)
  (define-key company-active-map (kbd "RET") 'company-abort))

(require-package 'company-quickhelp)
(company-quickhelp-mode 1)
(setq-default company-quickhelp-delay 1)
(setq-default company-minimum-prefix-length 1)
(with-eval-after-load 'company
                      (define-key company-active-map (kbd "C-w") nil))


(require-package 'yasnippet)
(yas-global-mode 1)
(setq-default yas-snippet-dirs '("~/.emacs.d/snippets"))
;; redefine enter instead of tab for expansion
(define-key yas-minor-mode-map (kbd "<C-return>") 'yas-expand)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-keymap (kbd "TAB") nil)
(define-key yas-keymap (kbd "<tab>") nil)
(define-key yas-keymap (kbd "C-k") 'yas-next-field-or-maybe-expand)
