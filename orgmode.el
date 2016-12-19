(require-package 'org)
(require-package 'org-plus-contrib)
(require-package 'org-bullets)
(require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require-package 'ob-ipython)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(setq-default org-confirm-babel-evaluate nil)
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     (python . t)
     (ruby . t))))


(defun my/ipython-src-hook ()
  ;; (elpy-enable)
  ;; (add-to-list (make-local-variable 'company-backends) 'elpy-company-backend)
  )

;; (add-hook 'org-src-mode-hook (progn
;;                                (message "current mode is %s" major-mode)
;;                                (when (equal major-mode 'python-mode)
;;                                  (my/ipython-src-hook))))

(require-package 'company-math)
(my/autocomplete 'org-mode-hook '(company-math-symbols-latex company-math-symbols-unicode))

(defun evil-org-local-binding ()
  "keybinding after one get into orgmode"
  (nmap-local "RET" 'org-todo) ;; enter will trigger rotate todo state
  (nmap-local "SPC o" 'org-open-at-point)
  (nmap-local "SPC e" 'org-export-dispatch)
  (nmap-local "C-x" 'org-babel-execute-src-block)
  (nmap-local "[ l" 'org-previous-link)
  (nmap-local "] l" 'org-next-link)
  (nmap-local "SPC c" 'org-capture)
  )


(defun org-preview-all-latex-fragments (args)
  "Toggle all the latex fragments."
  (interactive "P")
  (org-remove-latex-fragment-image-overlays)
  (org-preview-latex-fragment '(16)))



(setq-default org-export-coding-system 'utf-8)
(setq-default org-alphabetical-lists t)
(setq-default org-reveal-root "https://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq-default org-src-fontify-natively t)
(setq-default org-latex-preview-ltxpng-directory "/tmp/ltxpng/")

(my/autoformat 'org-mode-hook 'org-preview-all-latex-fragments)

(add-hook 'org-mode-hook 'evil-org-local-binding)
(add-hook 'org-mode-hook (lambda ()
			   (org-bullets-mode 1)
			   (require-package 'ox-reveal)
			   ;; (add-to-list 'org-latex-packages-alist '(""  "minted"))
			   ;; (setq org-latex-listings 'minted)
                           (plist-put org-format-latex-options :scale 1.5)
                           (nmap-local "C-l" 'org-toggle-latex-fragment)
			   (if buffer-file-name
			       (progn
				 ))))


