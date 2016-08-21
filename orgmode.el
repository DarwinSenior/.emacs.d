(require-package 'org)
(require-package 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-src-fontify-natively t)
(require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require-package 'ob-ipython)
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)

(setq org-confirm-babel-evaluate nil)
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     (python . t)
     (ruby . t))))

(defun evil-org-local-binding ()
  "keybinding after one get into orgmode"
  (nmaplocal "RET" 'org-todo) ;; enter will trigger rotate todo state
  (nmaplocal "SPC o" 'org-open-at-point)
  (nmaplocal "SPC e x" 'org-export)
  (nmaplocal "C-x" 'org-babel-execute-src-block)
  (nmaplocal "[ l" 'org-previous-link)
  (nmaplocal "] l" 'org-next-link)
  (nmaplocal "SPC c" 'org-capture)
  )


(defun org-preview-all-latex-fragments ()
  "Toggle all the latex fragments."
     (org-toggle-latex-fragment '(16)))


(add-hook 'org-mode-hook (lambda ()
               (if buffer-file-name
                   (progn
                 (add-hook 'evil-normal-state-entry-hook 'org-preview-all-latex-fragments nil t)
                 (add-hook 'evil-normal-state-exit-hook 'org-remove-latex-fragment-image-overlays nil t)
                 (setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))
                 ))))

(add-hook 'org-mode-hook 'evil-org-local-binding)
(setq org-export-coding-system 'utf-8)

(require-package 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/reveal.js/3.0.0/")

(nmap "SPC C" 'org-capture)
(setq org-default-notes-file "~/workspace/notes.org")
; log done states in todo
(setq org-log-done t)
(setq org-capture-templates
      '(
    ("t" "todo" entry (file+headline  "~/workspace/notes.org" "Tasks")
     "** TODO %^{Task} %?")
    ))
(setq org-agenda-files (list "~/workspace/notes.org"))
(nmap "SPC c a" 'org-agenda)

(require-package 'calfw)
(require 'calfw-cal)
(require 'calfw-org)
(require 'calfw-ical)
(defun open-calendar ()
  "open calendar helper"
  (interactive)
  (cfw:open-calendar-buffer :contents-sources
   (list
    (cfw:org-create-source "green")
    (cfw:ical-create-source "gcal" "https://calendar.google.com/calendar/ical/i40ej5ffhcqdg6bprs11bist18%40group.calendar.google.com/private-472a2587fa88f4c01b20f543f7e41e00/basic.ics" "IndianRed"))))
(nmap "SPC g c" 'open-calendar)

(custom-set-faces
 '(cfw:face-title ((t (:foreground "#cc666" :weight bold :height 2.0 :inherit variable-pitch))))
 '(cfw:face-header ((t (:foreground "#de935f" :weight bold))))
 '(cfw:face-sunday ((t :foreground "#f0c674" :weight bold)))
 '(cfw:face-saturday ((t :foreground "#f0c674" :weight bold)))
 '(cfw:face-holiday ((t :background "#1d1f21" :foreground "#cc6666" :weight bold)))
 '(cfw:face-grid ((t :foreground "#373b41")))
 '(cfw:face-default-content ((t :foreground "#c5c8c6")))
 '(cfw:face-periods ((t :foreground "cyan")))
 '(cfw:face-day-title ((t :foreground "gray80")))
 '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
 '(cfw:face-annotation ((t :foreground "#969896" :inherit cfw:face-day-title)))
 '(cfw:face-disable ((t :foreground "#c5c8c6" :inherit cfw:face-day-title)))
 '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
 '(cfw:face-today ((t :background: "#de935f" :weight bold)))
 '(cfw:face-select ((t :background "#c0c674")))
 '(cfw:face-toolbar ((t :foreground "#c5c8c6" :background "#373b41")))
 '(cfw:face-toolbar-button-off ((t :foreground "#c5c8c6" :background "#373b41")))
 '(cfw:face-toolbar-button-on ((t :foreground "#c5c8c6" :backgroubd "#373b41" :weight bold))))
