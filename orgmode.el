(require-package 'org)
(require-package 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-src-fontify-natively t)
(require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require-package 'ob-ipython)

(setq org-confirm-babel-evaluate nil)
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     (python . t)
     (ruby . t))))

(defun evil-org-local-binding ()
  "keybinding after one get into orgmode"
  (nmaplocal "RET" 'org-todo) ;; enter will trigger rotate todo state
  (nmaplocal "SPC o" 'org-open-at-point)
  (nmaplocal "SPC e x" 'org-export)
  (nmaplocal "C-x" 'org-babel-execute-src-block)
  )
(add-hook 'org-mode-hook 'evil-org-local-binding)
