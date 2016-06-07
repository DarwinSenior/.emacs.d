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
(load-user-file "spell.el")
(load-user-file "orgmode.el")

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; (require-package 'smart-tabs-mode)



(require-package 'yasnippet)
(yas-global-mode 1)
;; redefine enter instead of tab for expansion
(define-key yas-minor-mode-map (kbd "RET") 'yas-expand)
(define-key yas-minor-mode-map (kbd "TAB") nil)


(require-package 'magit)

; set up terminal
(setq system-uses-info nil)
(defadvice terminal-handle-exit
           (after term-kill-buffer-on-exit activate)
           (kill-buffer))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(require-package 'writeroom-mode)
