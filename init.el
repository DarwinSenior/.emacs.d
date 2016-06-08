(setq package-archives
  '(("melpa" . "http://melpa.org/packages/")
    ("gnu" . "http://elpa.gnu.org/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")))
(require 'package)
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(require-package 'el-get)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(defun install-el-get ()
  eval-url
  "https://github.com/dimitri/el-get/raw/master/el-get-install.el")
(unless (require 'el-get nil)
  (install-el-get))

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "appearance.el")
(load-user-file "company.el")
(load-user-file "passive.el")
(load-user-file "evil.el")
(load-user-file "filetypes.el")
(load-user-file "helm.el")
(load-user-file "magit.el")
(load-user-file "spell.el")
(load-user-file "orgmode.el")

(global-set-key (kbd "ESC") 'keyboard-escape-quit)

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; (require-package 'smart-tabs-mode)



(require-package 'yasnippet)
(yas-global-mode 1)
;; redefine enter instead of tab for expansion
(define-key yas-minor-mode-map (kbd "S-RET") 'yas-expand)
(define-key yas-minor-mode-map (kbd "TAB") nil)


; set up terminal
(setq system-uses-info nil)
(defadvice terminal-handle-exit
           (after term-kill-buffer-on-exit activate)
           (kill-buffer))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(add-hook 'term-mode-hook (lambda () (setq yas-dont-activate t)))
(nmap "SPC s h" (lambda () (interactive) 
		  (ansi-term "/bin/zsh")))

(require-package 'writeroom-mode)
(require-package 'restclient)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (restclient writeroom-mode magit yasnippet rainbow-delimiters ob-ipython exec-path-from-shell org-bullets helm-projectile whitespace-cleanup-mode vimrc-mode smartparens python-mode projectile nlinum-relative json-mode highlight-numbers helm golden-ratio evil-visualstar evil-surround evil-matchit evil-leader evil-extra-operator evil-exchange evil-commentary evil-anzu el-get company-quickhelp company-jedi color-theme-sanityinc-tomorrow avy airline-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
