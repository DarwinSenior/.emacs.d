(setq package-archives
  '(("melpa" . "http://melpa.org/packages/")
    ("org" . "http://orgmode.org/elpa/")
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

(load-user-file "evil.el")
;; (load-user-file "evil-remap.el")
(load-user-file "passive.el")
(load-user-file "appearance.el")
(load-user-file "company.el")
(load-user-file "spell.el")
(load-user-file "helm.el")
(load-user-file "filetypes.el")
(load-user-file "magit.el")
(load-user-file "orgmode.el")
(load-user-file "org-agenda.el")
(load-user-file "utilities.el")



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

(require-package 'writeroom-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("962dacd99e5a99801ca7257f25be7be0cebc333ad07be97efd6ff59755e6148f" default)))
 '(package-selected-packages
   (quote
    (helm-ag general sentence-navigation evil-indent-plus evil-args disable-mouse-mode yaml-mode writeroom-mode whitespace-cleanup-mode web-mode web-beautify wc-mode vimrc-mode tide smartparens rainbow-delimiters racer python-mode py-autopep8 ox-reveal org-gcal org-bullets ob-ipython nlinum-relative magit json-mode js2-mode hindent highlight-numbers helm-projectile golden-ratio flycheck-stack flycheck-rust flycheck-irony exec-path-from-shell evil-visualstar evil-surround evil-matchit evil-leader evil-extra-operator evil-exchange evil-commentary evil-anzu ensime emmet-mode el-get delight company-web company-tern company-restclient company-racer company-quickhelp company-jedi company-irony company-ghc company-emacs-eclim color-theme-sanityinc-tomorrow cmake-mode clang-format calfw blog-admin avy auto-package-update airline-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfw:face-annotation ((t :foreground "#969896" :inherit cfw:face-day-title)))
 '(cfw:face-day-title ((t :foreground "gray80")))
 '(cfw:face-default-content ((t :foreground "#c5c8c6")))
 '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
 '(cfw:face-disable ((t :foreground "#c5c8c6" :inherit cfw:face-day-title)))
 '(cfw:face-grid ((t :foreground "#373b41")))
 '(cfw:face-header ((t (:foreground "#de935f" :weight bold))))
 '(cfw:face-holiday ((t :background "#1d1f21" :foreground "#cc6666" :weight bold)))
 '(cfw:face-periods ((t :foreground "cyan")))
 '(cfw:face-saturday ((t :foreground "#f0c674" :weight bold)))
 '(cfw:face-select ((t :background "#c0c674")))
 '(cfw:face-sunday ((t :foreground "#f0c674" :weight bold)))
 '(cfw:face-title ((t (:foreground "#cc666" :weight bold :height 2.0 :inherit variable-pitch))))
 '(cfw:face-today ((t :background: "#de935f" :weight bold)))
 '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
 '(cfw:face-toolbar ((t :foreground "#c5c8c6" :background "#373b41")))
 '(cfw:face-toolbar-button-off ((t :foreground "#c5c8c6" :background "#373b41")))
 '(cfw:face-toolbar-button-on ((t :foreground "#c5c8c6" :backgroubd "#373b41" :weight bold))))
