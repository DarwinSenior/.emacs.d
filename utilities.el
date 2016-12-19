(require-package 'blog-admin)
(require 'blog-admin)
(setq blog-admin-backend-path "~/blog")
(setq blog-admin-backend-type 'hexo)
(setq blog-admin-backend-new-post-in-drafts t) ;; create new post in drafts by default
(setq blog-admin-backend-new-post-with-same-name-dir t) ;; create same-name directory with new post
(setq blog-admin-backend-hexo-config-file "_config.yml") ;; default assumes _config.yml
(nmap "SPC b l" 'blog-admin-start)


(require-package 'gist)
(nmap "SPC g s" 'gist-list)

(require-package 'writeroom-mode)

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
(setq cfw:org-overwrite-default-keybinding t)

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

(require-package 'org-gcal)
(setq org-gcal-client-id "1097446452898-fb932bhobhlruho9bd8oo4po09d4kc5e.apps.googleusercontent.com")
(setq org-gcal-client-secret "_lpPrjAbdEW8bgeUKt15FJEK")
(setq org-gcal-file-alist '(
			    ("jg38igl3i4dgo9uu8crqstes98@group.calendar.google.com" .
			     "~/workspace/ClassSchedule.org")
			    ))


(provide 'utilities)
;;; utilities.el ends here
