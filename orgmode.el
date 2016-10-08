(require-package 'org)
(require-package 'org-bullets)
(require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require-package 'ob-ipython)
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)

(setq-default org-confirm-babel-evaluate nil)
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     (python . t)
     (ruby . t))))

(defun evil-org-local-binding ()
  "keybinding after one get into orgmode"
  (nmap :keymaps 'local "RET" 'org-todo) ;; enter will trigger rotate todo state
  (nmap :keymaps 'local "SPC o" 'org-open-at-point)
  (nmap :keymaps 'local "SPC e" 'org-export-dispatch)
  (nmap :keymaps 'local "C-x" 'org-babel-execute-src-block)
  (nmap :keymaps 'local "[ l" 'org-previous-link)
  (nmap :keymaps 'local "] l" 'org-next-link)
  (nmap :keymaps 'local "SPC c" 'org-capture)
  )


(defun org-preview-all-latex-fragments ()
  "Toggle all the latex fragments."
     (org-toggle-latex-fragment '(16)))


(setq-default org-export-coding-system 'utf-8)
(setq-default org-alphabetical-lists t)
(setq-default org-reveal-root "https://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq-default org-src-fontify-natively t)

(add-hook 'org-mode-hook 'evil-org-local-binding)
(add-hook 'org-mode-hook (lambda ()
			   (org-bullets-mode 1)
			   (require-package 'ox-reveal)
			   ;; (add-to-list 'org-latex-packages-alist '(""  "minted"))
			   ;; (setq org-latex-listings 'minted)
			   (if buffer-file-name
			       (progn
				 (nmap :keymaps 'local "M-l" 'org-toggle-latex-fragment)
				 (add-hook 'evil-normal-state-exit-hook 'org-remove-latex-fragment-image-overlays nil t)
				 ))))


