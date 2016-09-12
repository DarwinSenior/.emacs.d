(nmap "SPC C" 'org-capture)
(setq org-default-notes-file "~/workspace/notes.org")
; log done states in todo
(setq org-log-done t)
(setq org-capture-templates
      '(
    ("t" "todo" entry (file+headline  "~/workspace/notes.org" "Tasks")
     "** TODO %^{Task} %?")
    ("h" "homework" entry (file+headline "~/workspace/Assignment.org" "Assignment")
     "\n** TODO %^{Assignment} %? \n DEADLINE: %T")
    ))
;; (setq org-agenda-files (list "~/workspace/notes.org"))
(setq org-agenda-files (list
			"~/workspace/ClassSchedule.org"
			"~/workspace/Assignment.org"
			"~/workspace/ExcerciseSchedule.org"))
(nmap "SPC c a" 'org-agenda)

(setq org-log-done 'time)
