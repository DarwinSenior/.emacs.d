(require-package 'powerline)
(powerline-default-theme)
(require-package 'airline-themes)

; theme and all that stuff
(require-package 'color-theme-sanityinc-tomorrow)
(load-theme 'airline-molokai t)
(load-theme 'sanityinc-tomorrow-night t)
(set-default-font "Fantasque Sans Mono-18")
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(require-package 'nlinum-relative)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)      ;; delay
(setq nlinum-relative-current-symbol "")      ;; or "" for display current line number
(setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...
(add-hook 'evil-after-load-hook 'nlinum-relative-setup-evil)                    ;; setup for evil


