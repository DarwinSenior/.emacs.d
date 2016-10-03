(savehist-mode 1)
(require-package 'auto-package-update)
(auto-package-update-maybe)

(setq initial-scratch-message "")
(setq-default indent-tabs-mode nil)

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode)

(require-package 'golden-ratio)
(golden-ratio-mode 1)
(setq golden-ratio-extra-commands
      (append golden-ratio-extra-commands
              '(evil-window-up
                 evil-window-left
                 evil-window-right
                 evil-window-down
                 select-window-1
                 select-window-2
                 select-window-3
                 select-window-4
                 select-window-5)))

(require-package 'smartparens)
(smartparens-global-mode t)
(show-paren-mode t)
(require 'smartparens-config)
(setq show-paren-delay 0)
(require-package 'highlight-numbers)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(with-eval-after-load
  'evil
  (require-package 'evil-anzu))
(require-package 'exec-path-from-shell)
(exec-path-from-shell-initialize)
