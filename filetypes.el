(require-package 'vimrc-mode)

(defun auto-format (mode-hook action)
  (add-hook mode-hook
	    `(lambda () (nmaplocal "SPC SPC SPC" ',action))))

(defun auto-complete (mode-hook backend)
  (add-hook mode-hook
	    `(lambda ()
	       (add-to-list (make-local-variable 'company-backends) ',backend))))

;; python
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))
(require-package 'python-mode)
(require-package 'company-jedi)
(require-package 'py-autopep8)
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(autoload 'jedo:setup "jedi" nil t)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook
	     (lambda ()
               (jedi:setup)
	       (set jedi:environment-root "jedi")
               (set jedi:environment-virtualenv
                    (append python-environment-virtualenv
                            '("--python" "/usr/bin/python3")))))
(auto-complete 'python-mode-hook 'company-jedi)
(auto-format 'python-mode-hook 'py-autopep8-buffer)
(add-hook 'python-mode-hook 'run-python-internal)

(require-package 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(auto-format 'json-mode-hook 'json-mode-beautify)

(require-package 'web-mode)
(require-package 'emmet-mode)
(require-package 'company-web)
(require 'company-web-html)
(require-package 'js2-mode)
(require-package 'web-beautify)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(setq web-mode-enable-current-element-highlight t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js2-mode-hook (lambda ()
			   (tern-mode t)))
(auto-complete 'js2-mode-hook 'company-tern)
(auto-format 'html-mode-hook 'web-beautify-html-buffer)
(auto-format 'css-mode-hook 'web-beautify-css-buffer)
(auto-format 'js2-mode-hook 'web-beautify-js-buffer)

(require-package 'company-restclient)
(require-package 'restclient)
(add-to-list 'auto-mode-alist '("\\.http?\\'" . restclient-mode))
(add-hook 'restclient-hook (lambda ()
			     (add-to-list (make-local-variable 'company-backends 'company-restclient))))

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
