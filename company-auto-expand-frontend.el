(defvar-local company-auto-expand-mode nil)
(defun company-auto-expand-frontend (command)
  (when company-auto-expand-mode
    (cl-case command
      (pre-command
       (company--shrink-selection)
        (when (and this-command
		  (company-auto-expand-finish-commmand this-command))
	 (company-complete-selection)))
      (post-command
       (company--expand-selection)
       (when (overlayp company-preview-overlay)
	 (company-preview-hide)))
      (hide
       (setq-local company-auto-expand-mode nil)))))
     	   
(defun company--expand-selection ()
  (let (company-auto-expand-mode
	(company--candidate (nth company-selection
				 company-candidates)))
    (company-call-frontends 'pre-command)
    (company--insert-candidate company--candidate)
    (let ((company-prefix (substring-no-properties
    			   company--candidate)))
      (company-call-frontends 'post-command))))

(defun company--shrink-selection ()
  (delete-region company-point (point)))

;; ----------------------
(defun company-auto-expand-finish-commmand (command)
  (or (eq command 'self-insert-command)
      (not (lookup-command-in-keymap-p command company-active-map))))
;; TODO: more efficient 
(defun lookup-command-in-keymap-p (command keymap)
  (when (equal command 
	    (catch 'lookup-p
	      (do-lookup-command-in-keymap-p command keymap)))
    t))

(defun do-lookup-command-in-keymap-p (command keymap)
  (when (consp keymap)
    (let ((sub-keymap (cdr keymap)))
      (if (eq command sub-keymap)
	  (throw 'lookup-p command)
	(when (listp sub-keymap)
	  (mapc (lambda (ssub-keymap)
		  (do-lookup-command-in-keymap-p command ssub-keymap))
		sub-keymap))))))

(defun company-complete-previous-or-abort (&optional arg)
  "Insert the common part of all candidates, or select the next one.
With ARG, move by that many elements."
  (interactive "p")
  (when (company-manual-begin)
    (let ((tick (buffer-chars-modified-tick)))
      (call-interactively 'company-complete-common)
      (when (eq tick (buffer-chars-modified-tick))
        (let ((company-selection-wrap-around t)
              (current-prefix-arg arg))
          (call-interactively 'company-select-previous-or-abort))))))
;; ---------------------------------------------------------------------------------------------------
;; TODO: shoud more common
(defvar company-auto-expand-navigate 'company-select-next)
(defvar company-auto-expand-navigate-back 'company-select-previous)
(defun company-auto-expand-trigger-navigate (&optional arg)
  (interactive "p")
  (if company-auto-expand-mode
      (let ((current-prefix-arg arg))
	(call-interactively company-auto-expand-navigate))
    (setq-local company-auto-expand-mode t)))
(defun company-auto-expand-trigger-navigate-back (&optional arg)
  (interactive "P")
  (if company-auto-expand-mode
      (let ((current-prefix-arg arg))
        (call-interactively company-auto-expand-navigate-back))
    (setq-local company-auto-expand-mode t))
  )
;; (define-key company-active-map (kbd "<f8>") 'company-auto-expand-trigger-navigate)

(setq company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend
	company-preview-if-just-one-frontend
	company-auto-expand-frontend	;shoud after any preview frontend
	company-echo-metadata-frontend))

(provide 'company-auto-expand-frontend)
