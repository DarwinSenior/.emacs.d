(require-package 'magit)

(defun mg-map (keybinding action)
  "binding key in the magit mapping"
  (define-key magit-mode-map (kbd keybinding) action))

(nmap "SPC m g" 'magit-status)
(mg-map "+" 'magit-stage)
(mg-map "-" 'magit-unstage)
(mg-map "[" 'magit-section-backward)
(mg-map "]" 'magit-section-forward)
