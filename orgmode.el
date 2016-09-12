(require-package 'org)
(require-package 'org-bullets)
(require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require-package 'ob-ipython)
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)

(setq org-confirm-babel-evaluate nil)
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     (python . t)
     (ruby . t))))

(setq org-latex-create-formula-image-program 'imagemagick)

(defun evil-org-local-binding ()
  "keybinding after one get into orgmode"
  (nmaplocal "RET" 'org-todo) ;; enter will trigger rotate todo state
  (nmaplocal "SPC o" 'org-open-at-point)
  (nmaplocal "SPC e" 'org-export-dispatch)
  (nmaplocal "C-x" 'org-babel-execute-src-block)
  (nmaplocal "[ l" 'org-previous-link)
  (nmaplocal "] l" 'org-next-link)
  (nmaplocal "SPC c" 'org-capture)
  )


(defun org-preview-all-latex-fragments ()
  "Toggle all the latex fragments."
     (org-toggle-latex-fragment '(16)))


(setq org-export-coding-system 'utf-8)
(setq org-alphabetical-lists t)
(setq org-reveal-root "https://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-latex-listings t)
(setq org-src-fontify-natively t)
(setq org-latex-listings 'minted)

(add-hook 'org-mode-hook 'evil-org-local-binding)
(add-hook 'org-mode-hook (lambda ()
			   (org-bullets-mode 1)
			   (require-package 'ox-reveal)
			   (add-to-list 'org-latex-packages-alist '(""  "minted"))
			   (if buffer-file-name
			       (progn
				 (nmaplocal "M-l" 'org-toggle-latex-fragment)
				 (add-hook 'evil-normal-state-exit-hook 'org-remove-latex-fragment-image-overlays nil t)
				 (setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))
				 ))		   (setenv "PDFLATEX" "pdflatex --shell-escape")
						   ))
