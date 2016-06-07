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
                            '("--python" "/usr/local/bin/python3")))))
(add-hook 'python-mode-hook 'run-python-internal)

(require-package 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
