(require-package 'vimrc-mode)

(defun autoformat-default ()
  (interactive)
  (message "autoformat has not been set yet"))
(nmap "SPC SPC SPC" 'autoformat-default)

(defun auto-format (mode-hook action)
  (add-hook mode-hook `(lambda ()
                         (nmap-local "SPC SPC SPC" ',action))))

(defun auto-complete (mode-hook backend)
  (add-hook mode-hook
	    `(lambda ()
	       (add-to-list (make-local-variable 'company-backends) ',backend))))

(defun auto-doc (mode-hook action)
  (add-hook mode-hook
            `(lambda ()
               (nmap-local "?" ',action))))

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
(auto-complete 'python-mode-hook 'company-jedi)
(auto-format 'python-mode-hook 'py-autopep8-buffer)
(auto-doc 'python-mode-hook 'jedi:show-doc)

;; json
(require-package 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(auto-format 'json-mode-hook 'json-mode-beautify)


;; javascript css html
(require-package 'web-mode)
(require-package 'emmet-mode)
(require-package 'company-web)
(require-package 'company-tern)

(require-package 'js2-mode)
(require-package 'web-beautify)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(setq-default web-mode-enable-current-element-highlight t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js2-mode-hook (lambda ()
			   (tern-mode t)))
(auto-complete 'js2-mode-hook 'company-tern)
(auto-doc 'js2-mode-hook 'tern-get-docs)
(auto-format 'web-mode-hook 'web-beautify-html)
(auto-format 'css-mode-hook 'web-beautify-css)
(auto-format 'js2-mode-hook 'web-beautify-js)

;; REST API

(require-package 'company-restclient)
(require-package 'restclient)
(add-to-list 'auto-mode-alist '("\\.http?\\'" . restclient-mode))
(auto-complete 'restclient-hook 'company-restclient)


;; C++ / C 
(require-package 'irony)
(require-package 'company-irony)
(require-package 'flycheck-irony)
(require-package 'clang-format)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(auto-complete 'irony-mode-hook 'company-irony)
(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
(auto-format 'c++-mode-hook 'clang-format-buffer)
(auto-format 'c-mode-hook 'clang-format-buffer)
(auto-format 'objc-mode-hook 'clang-format-buffer)
(setq-default c-basic-offset 4)


;; cmake
(require-package 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))


;; typescript
(require-package 'tide)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-hook 'typescript-mode-hook 'tide-setup)
(auto-complete 'typescript-mode-hook 'company-tide)
(auto-format 'typescript-mode-hook 'tide-format)

;; haskell
(require-package 'haskell-mode)
(require-package 'hindent)
(require-package 'ghc)
(require-package 'company-ghc)
(require-package 'flycheck-stack)
(require 'flycheck-stack)
(setq-default hindent-style "johan-tibell")
(auto-format 'haskell-mode-hook 'hindent-reformat-buffer)
(auto-complete 'haskell-mode-hook 'company-ghc)
(auto-doc 'ghc-mode 'ghc-show-info)
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
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(auto-complete 'rust-mode-hook 'company-racer)


;; scala
(require-package 'ensime)
(require-package 'scala-mode)
(add-hook 'scala-mode-hook 'ensime-mode)
(add-hook 'scala-mode-hook 'ensime)
(auto-complete 'scala-mode-hook 'ensime-company)
(auto-format 'scala-mode-hook 'ensime-format-source)
(auto-doc 'scala-mode-hook 'ensime-show-doc-for-symbol-at-point)
(defvar ensime-startup-snapshot-notification nil)
(setq ensime-startup-snapshot-notification nil)


;; octave / matlab
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(provide 'filetypes)
;;; filetypes ends here
