(require-package 'helm)
(helm-mode 1)
(require-package 'projectile)
(projectile-global-mode)
(require-package 'helm-projectile)
(helm-projectile-on)
(helm-autoresize-mode 1)
(setq helm-autoresize-max-height 30)
(setq helm-autoresize-min-height 30)

(defun save-file ()
  "save if it is a file else do nothing"
  (interactive)
  (when (buffer-file-name)
    (save-buffer)))

(nmap "SPC f i" ((lambda ()
		   (interactive)
		   (save-file)
		   (helm-projectile))))
(nmap "SPC b i" (lambda ()
		      (interactive)
		      (save-file)
		      (helm-buffers-list)))
(nmap "SPC a i" ((lambda ()
		   (interactive)
		   (save-file)
		   (helm-projectile-ag))))

(defun hmap (keybinding action)
  "adding key binding for helm"
  (define-key helm-map (kbd keybinding) action))

(setq meta-prefix-char nil)
(define-key esc-map (kbd "<ESC><ESC>") nil)
(hmap "ESC" 'helm-keyboard-quit)
(hmap "TAB" 'helm-next-line)

