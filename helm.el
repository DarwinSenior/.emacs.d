(require-package 'helm)
(helm-mode 1)
(require-package 'projectile)
(projectile-global-mode)
(require-package 'helm-projectile)
(helm-projectile-on)

(require-package 'helm-ag)
(helm-autoresize-mode 1)
(setq-default helm-autoresize-max-height 30)
(setq-default helm-autoresize-min-height 30)
(setq-default projectile-svn-command "find . -type f -not -iwholename '*.svn/*' -print0")

(defun save-file ()
  "Save the current buffer when it is actually a buffer"
  (interactive)
  (when (buffer-file-name)
    (save-buffer)))

(defun helm-backspace ()
  "Forward to `backward-delete-char'.
On error (read-only), quit without selecting."
  (interactive)
  (condition-case nil
      (backward-delete-char 1)
    (error
     (helm-keyboard-quit))))

(nmap "SPC f i" 'helm-projectile)
(nmap "SPC b i" 'helm-buffers-list)
(nmap "SPC a i" 'helm-projectile-ag)
(nmap "SPC p i" 'helm-projectile-switch-project)

; (nmap "SPC f i" ((lambda ()
;            (interactive)
;            (save-file)
;            (helm-projectile))))
; (nmap "SPC b i" (lambda ()
;               (interactive)
;               (save-file)
;               (helm-buffers-list)))
; (nmap "SPC a i" ((lambda ()
;            (interactive)
;            (save-file)
;            (helm-projectile-ag))))

(defun hmap (keybinding action)
  "adding key binding for helm"
  (define-key helm-map (kbd keybinding) action))

(setq meta-prefix-char nil)
(define-key esc-map (kbd "<ESC><ESC>") nil)
(hmap "ESC" 'helm-keyboard-quit)
(hmap "TAB" 'helm-next-line)
(hmap "DEL" 'helm-backspace)
