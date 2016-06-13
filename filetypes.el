;; syntax highlighting
(require-package 'vimrc-mode)
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))
(require-package 'python-mode)
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require-package 'company-jedi)
(autoload 'jedo:setup "jedi" nil t)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook
             (lambda ()
               (jedi:setup)
               (add-to-list 'company-backends 'company-jedi)
               (set jedi:environment-root "jedi")
               (set jedi:environment-virtualenv
                    (append python-environment-virtualenv
                            '("--python" "/usr/bin/python3")))))
(add-hook 'python-mode-hook 'run-python-internal)

(require-package 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

(require-package 'web-mode)
(require-package 'emmet-mode)
(require-package 'company-web)
(require 'company-web-html)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(setq web-mode-enable-current-element-highlight t)

(require-package 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-hook 'js2-mode-hook (lambda ()
			   (tern-mode t)
			   (add-to-list (make-local-variable 'company-backends)
					'company-tern)))

(defun web-mode-binding ()
  (nmaplocal "RET" 'emmet-expand-line))

(require-package 'restclient)
(add-to-list 'auto-mode-alist '("\\.http?\\'" . restclient-mode))

