(require-package 'flycheck)
(global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))

(require-package 'flyspell)
(add-hook 'text-mode-hook 'flyspell-mode)

(defun flyspell-goto-previous-error (arg)
  "Go to arg previous spelling error."
  (interactive "p")
  (while (not (= 0 arg))
    (let ((pos (point))
	  (min (point-min)))
      (if (and (eq (current-buffer) flyspell-old-buffer-error)
	       (eq pos flyspell-old-pos-error))
	  (progn
	    (if (= flyspell-old-pos-error min)
		;; goto beginning of buffer
		(progn
		  (message "Restarting from end of buffer")
		  (goto-char (point-max)))
	      (backward-word 1))
	    (setq pos (point))))
      ;; seek the next error
      (while (and (> pos min)
		  (let ((ovs (overlays-at pos))
			(r '()))
		    (while (and (not r) (consp ovs))
		      (if (flyspell-overlay-p (car ovs))
			  (setq r t)
			(setq ovs (cdr ovs))))
		    (not r)))
	(backward-word 1)
	(setq pos (point)))
      ;; save the current location for next invocation
      (setq arg (1- arg))
      (setq flyspell-old-pos-error pos)
      (setq flyspell-old-buffer-error (current-buffer))
      (goto-char pos)
      (if (= pos min)
	  (progn
	    (message "No more miss-spelled word!")
	    (setq arg 0))))))
(cond
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_UK")
  (setq ispell-local-dictionary-alist
    '(("en_UK" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_UK") nil utf-8)))))

(defun my/goto-next-error (arg)
  "Go to next error."
  (interactive "p")
  (if (bound-and-true-p flyspell-mode)
      (flyspell-goto-next-error)
    (flycheck-next-error)))
(defun my/goto-prev-error (arg)
  "Go to prev error."
  (interactive "p")
  (if (bound-and-true-p flyspell-mode)
      (flyspell-goto-previous-error arg)
    (flycheck-previous-error)))

(nmap "[ s" 'my/goto-prev-error)
(nmap "] s" 'my/goto-next-error)
(nmap "z =" 'ispell-word)


;;
