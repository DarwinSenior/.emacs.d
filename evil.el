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

(setq-default evil-search-module 'evil-search)

(evil-mode 1)

(require-package 'evil-surround)
(global-evil-surround-mode 1)

(require-package 'evil-commentary)
(evil-commentary-mode)
(require-package 'evil-matchit)
;; (global-evil-matchit-mode 1)
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


(defun add-hook-local (hook mode action)
  "Bind the hook only for local mode."
  (add-hook hook
	    (lambda () (when (bound-and-true-p mode) (action)))))

(require-package 'avy)
(defface avy-lead-face-0
  '((t (:foreground "black" :background "white")))
  "Face used for first non-terminating leading chars.")
(defface avy-lead-face-1
  '((t (:foreground "black" :background "white")))
  "Face used for matched leading chars.")
(defface avy-lead-face-2
  '((t (:foreground "black" :background "white")))
  "Face used for matched leading chars.")
(defface avy-lead-face
  '((t (:foreground "black" :background "white")))
  "Face used for matched leading chars.")

(evil-define-operator evil-operator-send-to-buffer (beg end type)
  :move-point nil
  (interactive "<R>")
  (append-to-buffer (current-buffer) beg end))
(defun my/send-command (command)
  (comint-send-string))

(defun my/get-associate-eval-buffer (init-name)
  (if (null (get-buffer (my/isend-buffer-name)))
      (term ))
  (get-buffer (my/isend-buffer-name)))

(defmacro define-and-bind-text-object (key start-regex end-regex)
  (let ((inner-name (make-symbol "inner-name"))
        (outer-name (make-symbol "outer-name")))
    `(progn
       (evil-define-text-object ,inner-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count nil))
       (evil-define-text-object ,outer-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count t))
       (define-key evil-inner-text-objects-map ,key (quote ,inner-name))
       (define-key evil-outer-text-objects-map ,key (quote ,outer-name)))))
(define-and-bind-text-object "$" "\\$" "\\$")
(define-and-bind-text-object "|" "|" "|")

(defun previous-file-buffer ()
  (interactive)
  (previous-buffer)
  (when (not (buffer-file-name))
      (previous-file-buffer)))

(defun next-file-buffer ()
  (interactive)
  (next-buffer)
  (when (not (buffer-file-name))
    (next-file-buffer)))

(defmacro retain-pos-do (&rest actions)
  (let ((oldpos (point)))
    (progn actions)
    (goto-char oldpos)))

(defun insert-new-line-above ()
  "Insert a new line below while the retain the cursor position"
  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline)
    (goto-char oldpos)))

(defun insert-new-line-below ()
  "Insert a new line below while the retain the cursor position"
  (interactive)
  (let ((oldpos (point)))
    (beginning-of-line)
    (newline-and-indent)
    (goto-char oldpos)))

(defun move-line-up ()
  "Move the line above"
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  "Move the line down"
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (forward-line -1))

(require-package 'general)
(general-evil-setup t)

(require-package 'evil-args)
(require-package 'evil-indent-plus)
(require-package 'sentence-navigation)

(general-define-key :keymaps 'inner
                    "a" 'evil-inner-arg
                    "i" 'evil-indent-plus-i-indent
                    "I" 'evil-indent-plus-i-indent-up
                    "s" 'sentence-nav-evil-inner-sentence)
(general-define-key :keymaps 'outer
                    "a" 'evil-outer-arg
                    "i" 'evil-indent-plus-a-indent
                    "I" 'evil-indent-plus-a-indent-up
                    "s" 'sentence-nav-evil-outer-sentence)

(nmap "L" 'evil-forward-arg)
(mmap "H" 'evil-backward-arg)
(nmap "Q" 'call-last-kbd-macro)
(nvmap "J" (general-simulate-keys "5j"))
(nvmap "K" (general-simulate-keys "5k"))
(nmap "C-l" 'evil-ex-nohighlight)
(nmap "C-J" 'evil-join)
(nmap "[ e" 'move-line-up)
(nmap "] e" 'move-line-down)
(nmap "[ b" 'next-file-buffer)
(nmap "] b" 'previous-file-buffer)
(nmap "[ SPC" 'insert-new-line-below)
(nmap "] SPC" 'insert-new-line-above)
(nmap "SPC w c" 'count-words)
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

