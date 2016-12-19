(require-package 'vimrc-mode)
(require-package 'ggtags)
;; (require-package 'dumb-jump)
;; (dumb-jump-mode)
(nmap "g d" 'ggtags-find-definition)
(nmap "g f" 'ggtags-find-reference)

(require-package 'origami)
(add-hook 'prog-mode-hook (progn
                            (nmap-local "<tab>" 'origami-toggle-node)
                            (nmap-local "g <tab>" 'origami-toggle-all-nodes)
                            (origami-mode)
                            (ggtags-mode)))

(defun my/folding-rule (mode parser)
  "add folding to the rule"
  (add-to-list 'origami-parser-alist (cons mode parser)))

(defun autoformat-default ()
  (interactive)
  (message "autoformat has not been set yet"))
(nmap "SPC SPC SPC" 'autoformat-default)

(defun my/autoformat (mode-hook action)
  (add-hook mode-hook `(lambda ()
                         (nmap-local "SPC SPC SPC" ',action))))

(defun my/autocomplete (mode-hook backend)
  (add-hook mode-hook
	    `(lambda ()
	       (add-to-list (make-local-variable 'company-backends) ',backend))))

(defun my/autodoc (mode-hook action)
  (add-hook mode-hook
            `(lambda ()
               (nmap-local "?" ',action))))

(require-package 'paredit)
(require-package 'evil-paredit)
(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

;; python
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))

(require-package 'python-mode)
(require-package 'company-jedi)
(require-package 'py-autopep8)
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook 'jedi:setup)
(autoload 'jedo:setup "jedi" nil t)
(setq-default jedi:complete-on-dot t)
(setq-default python-shell-interpreter "ipython")
(my/autocomplete 'python-mode-hook 'company-jedi)
(my/autoformat 'python-mode-hook 'py-autopep8-buffer)
(my/autodoc 'python-mode-hook 'jedi:show-doc)

;; json
(require-package 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(my/autoformat 'json-mode-hook 'json-mode-beautify)
;; javascript css html
(require-package 'web-mode)
(require-package 'emmet-mode)
(require-package 'company-web)
(require-package 'company-tern)
(require-package 'js2-mode)
(require-package 'web-beautify)
(require-package 'tidy)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(setq-default web-mode-enable-current-element-highlight t)
(setq-default web-mode-enable-auto-closing t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js2-mode-hook (lambda ()
			   (tern-mode t)))
(my/autocomplete 'js2-mode-hook 'company-tern)
(my/autodoc 'js2-mode-hook 'tern-get-docs)
(my/autoformat 'web-mode-hook 'tidy-buffer)
(my/autoformat 'css-mode-hook 'web-beautify-css)
(my/autoformat 'js2-mode-hook 'web-beautify-js)

;; REST API

(require-package 'company-restclient)
(require-package 'restclient)
(add-to-list 'auto-mode-alist '("\\.http?\\'" . restclient-mode))
(my/autocomplete 'restclient-hook 'company-restclient)


;; C++ / C
(require-package 'irony)
(require-package 'company-irony)
(require-package 'flycheck-irony)
(require-package 'clang-format)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(my/autocomplete 'irony-mode-hook 'company-irony)
(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
(my/autoformat 'c++-mode-hook 'clang-format-buffer)
(my/autoformat 'c-mode-hook 'clang-format-buffer)
(my/autoformat 'objc-mode-hook 'clang-format-buffer)
(setq-default clang-format-style "file")
(setq-default c-basic-offset 4)


;; cmake
(require-package 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))


;; typescript
(require-package 'tide)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-hook 'typescript-mode-hook 'tide-setup)
(my/autocomplete 'typescript-mode-hook 'company-tide)
(my/autoformat 'typescript-mode-hook 'tide-format)
(my/folding-rule 'typescript-mode 'origami-c-style-parser)

;; haskell
(require-package 'haskell-mode)
(require-package 'hindent)
(require-package 'ghc)
(require-package 'company-ghc)
(require-package 'flycheck-stack)
(require 'flycheck-stack)
(setq-default hindent-style "johan-tibell")
(my/autoformat 'haskell-mode-hook 'hindent-reformat-buffer)
(my/autocomplete 'haskell-mode-hook 'company-ghc)
(my/autodoc 'ghc-mode 'ghc-show-info)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook 'ghc-init)
(add-hook 'haskell-mode-hook (lambda ()
			       (flycheck-select-checker 'stack)
			       (flycheck-mode)))


;; yaml
(require-package 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


;; rust
(require-package 'rust-mode)
(require-package 'company-racer)
(require-package 'flycheck-rust)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(my/autocomplete 'rust-mode-hook 'company-racer)
(my/autoformat 'rust-mode-hook 'rust-format-buffer)
(my/folding-rule 'rust-mode-hook 'origami-c-style-parser)
(setenv "RUST_SRC_PATH" "/usr/src/rust/src") 


;; scala
(require-package 'ensime)
(require-package 'scala-mode)
(add-hook 'scala-mode-hook 'ensime-mode)
(add-hook 'scala-mode-hook 'ensime)
(my/autocomplete 'scala-mode-hook 'ensime-company)
(my/autoformat 'scala-mode-hook 'ensime-format-source)
(my/autodoc 'scala-mode-hook 'ensime-show-doc-for-symbol-at-point)
(defvar ensime-startup-snapshot-notification nil)
(setq ensime-startup-snapshot-notification nil)


;; php
(require-package 'php-mode)
(require-package 'company-php)
(require 'company-php)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(my/autocomplete 'php-mode-hook 'company-ac-php-backend)
;; octave / matlab
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(provide 'filetypes)
;;; filetypes ends here
