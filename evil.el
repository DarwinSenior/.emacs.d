(require-package 'evil)

(defcustom dotemacs-evil/emacs-state-major-modes
  '(eshell-mode
    term-mode
    calculator-mode
    makey-key-mode)
  "List of major modes that should default to Emacs state."
  :type '(repeat (symbol))
  :group 'dotemacs-evil)

(defcustom dotemacs-evil/emacs-state-minor-modes
  '(edebug-mode
    git-commit-mode
    magit-blame-mode)
  "List of minor modes that when active should switch to Emacs state."
  :type '(repeat (symbol))
  :group 'dotemacs-evil)


(defcustom dotemacs-evil/emacs-insert-mode
  nil
  "If non-nil, insert mode will act as Emacs state."
  :type 'boolean
  :group 'dotemacs-evil)

(setq evil-search-module 'evil-search)

(evil-mode 1)

(require-package 'evil-surround)
(global-evil-surround-mode 1)

(require-package 'evil-commentary)
(evil-commentary-mode)

(require-package 'evil-matchit)
(global-evil-matchit-mode 1)
(require-package 'evil-leader)
(global-evil-leader-mode 1)
(evil-leader/set-leader " ")

(require-package 'evil-exchange)
(evil-exchange-cx-install)

(require-package 'evil-extra-operator)
(define-key evil-motion-state-map "gr" 'evil-operator-eval)

(require-package 'evil-visualstar)
(global-evil-visualstar-mode t)

;; this should be changed later
;; TO-DO

(defun nmap (keybinding action)
  "adding the default"
  (define-key evil-normal-state-map (kbd keybinding) action))

(defun nmaplocal (keybinding action)
  "local mapping"
  (define-key evil-normal-state-local-map (kbd keybinding) action))

(defmacro retain-pos-do (&rest actions)
  (let ((oldpos (point)))
    (progn actions)
    (goto-char oldpos)))

(defun insert-new-line-above ()
  "insert a new line below while the retain the cursor position"
  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline)
    (goto-char oldpos)))

(defun insert-new-line-below ()
  "insert a new line below while the retain the cursor position"
  (interactive)
  (let ((oldpos (point)))
    (beginning-of-line)
    (newline-and-indent)
    (goto-char oldpos)))

(defun move-line-up ()
  "move the line above"
  (interactive)
  (transpose-lines 1)
  (previous-line 2))

(defun move-line-down ()
  "move the line down"
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (previous-line 1))

(defun save-file ()
  "save if it is a file else do nothing"
  (interactive)
  (when (buffer-file-name)
      (save-buffer)))


(require-package 'avy)
(defface avy-lead-face-0
  '((t (:foreground "red" :background nil)))
  "Face used for first non-terminating leading chars.")
(defface avy-lead-face-1
  '((t (:foreground "blue" :background nil)))
  "Face used for matched leading chars.")
(defface avy-lead-face
  '((t (:foreground "blue" :background nil)))
  "Face used for matched leading chars.")
;; (defun nmap (keys action)
;;   (key-chord-define evil-normal-state-map (kbd keys) action))


(nmap "Q" 'call-last-kbd-macro)
(nmap "J" (lambda () (interactive) (forward-line 5)))
(nmap "K" (lambda () (interactive) (forward-line -5)))
(nmap "[ SPC" 'insert-new-line-below)
(nmap "] SPC" 'insert-new-line-above)
(nmap "[ e" 'move-line-up)
(nmap "] e" 'move-line-down)
(nmap "C-l" 'evil-ex-nohighlight)
(nmap "SPC w" 'avy-goto-word-0)
(nmap "SPC b i" (lambda ()
		      (interactive)
		      (save-file)
		      (helm-buffers-list)))
(nmap "SPC f i" (lambda ()
		      (interactive)
		      (save-file)
		      (call-interactively 'helm-find)))
