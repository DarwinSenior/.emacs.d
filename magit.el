(require-package 'magit)

(defun mg-map (keybinding action)
  "binding key in the magit mapping"
  (define-key magit-mode-map (kbd keybinding) action))

(eval-after-load 'magit-mode-map
  '(progn
    (nmap "SPC m g" 'magit-status)
    (mg-map "+" 'magit-stage)
    (mg-map "-" 'magit-unstage)
    (mg-map "[" 'magit-section-backward)
    (mg-map "]" 'magit-section-forward)))

;; I wish I could quit for git commands

; (message (prin1-to-string (assoc 'w '((a . b) (c . d) (r . x) (s . y) (r . z)))))

; (defun magit-git-command (args directory)
;   "Execute a Git subcommand asynchronously, displaying the output.
; With a prefix argument run Git in the root of the current
; repository, otherwise in `default-directory'."
;   (interactive (magit-read-shell-command "Git subcommand (pwd: %s)"))
;   (require 'eshell)
;   (with-temp-buffer
;     (insert args)
;     (setq args (mapcar 'eval (eshell-parse-arguments (point-min)
;                                                      (point-max))))
;     (setq default-directory directory)
;     (let ((magit-git-global-arguments
;            ;; A human will want globbing by default.
;            (remove "--literal-pathspecs"
;                    magit-git-global-arguments)))
;      (magit-run-git-async args)))
;   (magit-process-buffer))
