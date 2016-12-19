;; background control
(add-to-list 'default-frame-alist '(alpha 90 100))


;; create a new line
(require-package 'powerline)

(require-package 'airline-themes)
(require 'airline-themes)
(require 'airline-molokai-theme)
; (load-theme 'airline-light)

;; theme and all that stuff
(require-package 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-night t)
(set-default-font "FantasqueSansMonoNerdFont-15")
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)


(require-package 'nlinum-relative)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(add-hook 'text-mode-hook 'linum-mode)
(setq nlinum-relative-redisplay-delay 0)      ;; delay
(setq nlinum-relative-current-symbol "")      ;; or "" for display current line number
(setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...
(add-hook 'evil-after-load-hook 'nlinum-relative-setup-evil)                    ;; setup for evil
(add-hook 'evil-operator-state-entry-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-on))))
(add-hook 'evil-operator-state-exit-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-off))))
(add-hook 'evil-normal-state-entry-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-on))))
(add-hook 'evil-normal-state-exit-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-off))))
(add-hook 'evil-visual-state-entry-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-on))))
(add-hook 'evil-visual-state-exit-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-off))))
(add-hook 'evil-insert-state-entry-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-off))))
(add-hook 'evil-insert-state-exit-hook
	  (lambda () (when (bound-and-true-p nlinum-relative-mode) (nlinum-relative-on))))


;; (add-hook 'prog-mode-hook 'fci-mode)

(require-package 'delight)
(delight '((auto-revert-mode nil auto-revert)
	   (flycheck-mode nil flycheck)
	   (evil-commentary-mode nil evil-commentary)
	   (whitespace-cleanup-mode nil whitespace-cleanup)
	   (smartparens-mode nil smartparens)
	   (helm-mode nil helm)
	   (yas-minor-mode nil yasnippet)
	   (undo-tree-mode nil undo-tree)
	   (golden-ratio-mode nil golden-ratio)
	   (company-mode nil company)))

(require-package 'tabbar)
(setf tabbar-background-color (background-color-at-point))
(setq-default tabbar-home-button (cons (cons "" "") (cons "" "")))
(setq-default tabbar-buffer-home-button (cons (cons "" "") (cons "" "")))
(setq-default tabbar-scroll-left-button (cons (cons "" "") (cons "" "")))
(setq-default tabbar-scroll-right-button (cons (cons "" "") (cons "" "")))
(setq-default tabbar-separator '(1))
;; Tabbar settings

(tabbar-mode 1)
