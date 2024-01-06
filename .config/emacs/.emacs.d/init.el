;; REF: https://github.com/daviwil/emacs-from-scratch/blob/1a13fcf0dd6afb41fce71bf93c5571931999fed8/init.el#L37
;;      https://www.youtube.com/watch?v=VcgjTEa0kU4&list=PLEoMzSkcN8oPH1au7H6B7bBJ4ZO7BXjSZ&index=5&ab_channel=SystemCrafters

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; frontend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(button ((t (:background "black" :foreground "white" :box (:line-width (2 . 2) :color "grey" :style released-button) :underline t :weight bold))))
  '(menu ((t (:background "black" :foreground "yellow" :underline "yellow"))))
  '(mode-line ((t (:background "black" :foreground "yellow" :box (1 . 1) :height 0.9))))
  '(mode-line-buffer-id ((t (:background "black" :foreground "yellow" :weight bold :height 0.9))))
  '(mode-line-inactive ((t (:inherit mode-line :background "black" :foreground "brightblack" :box (1 . 1) :weight light :height 0.9))))
  '(org-hide ((t (:foreground "black"))))
  '(vertical-border ((t (:inherit nil :background "black" :foreground "yellow")))))
(load-theme 'manoj-dark)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar
(xterm-mouse-mode 1)        ; Enable mouse

;; disable auto-indentation of new lines
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; show line numbers
;; (require 'linum)
;; (global-linum-mode 1)
;; line color
;; (set-face-foreground 'linum "yellow")

;; not create a files below(lock file, backup file or so)
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq delete-auto-save-files t)

;; make underline on current line
(setq hl-line-face 'underline)
(global-hl-line-mode)

;; smooth scroll
(setq scroll-step            1
      scroll-conservatively  10000)

;; show line numbers
(if (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))
(setq display-line-numbers-width-start t)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key binding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; delete a backward character
(global-set-key [?\C-h] 'delete-backward-char)
;; overrides mark-whole-buffer
(global-set-key [?\C-x ?h] 'help-command)
;; function to delete characters to the begining on the line
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))
(global-set-key [?\C-c ?u] 'backward-kill-line) ;; `C-c u'
;; agenda view
(global-set-key "\C-ca" 'org-agenda)
;; open file
(global-set-key "\C-cf" 'find-file)
;; org-capture
(global-set-key "\C-cc" 'org-capture)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; status
(setq org-todo-keywords
      '((sequence "TODO(t)" "TODAY(T)" "NEXT(n)" "WIP(w)" "|" "DONE(d@/!)" "CANC(c@/!)" )))
(require 'org-agenda)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)
(setq org-habit-preceding-days 14)
(setq org-habit-following-days 3)
(setq org-habit-show-habits-only-for-today t)
(setq org-duration-format 'h:mm)

(customize-set-variable 'org-global-properties
                        '(("Effort_ALL" . "0:10 0:20 0:30 1:00 3:00 5:00 8:00 16:00 24:00 40:00")))
;; columns which shows effort on agenda. : <cc> <cx> <cc>
(setq org-columns-default-format
      "%68ITEM(Task) %6Effort(Effort){:} %6CLOCKSUM(Clock){:}")
;; hide clock log on agenda
(setq org-agenda-log-mode-items '(closed))

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-tag-alist
      '((:startgroup)
        ; Put mutually exclusive tags here
        (:endgroup)
        ("work" . ?w)
        ("study" . ?s)
        ("quick" . ?q)
        ("english" . ?e)
        ("daily" . ?D)
        ("weekly" . ?W)
        ("monthly" . ?M)
        ("journal" . ?j)
        ("keep" . ?c)
        ("problem" . ?p)
        ("try" . ?f)
        ("habit" . ?h)
        ("idea" . ?i)))


;; setting
;; indent heading
(setq org-startup-indented t)
;; not hide * of indent
;; (setq org-indent-mode-turns-on-hiding-stars nil)

;; width of indent
(setq org-indent-indentation-per-level 2)

;; show headings when emacs runs
(setq org-startup-folded 'content)

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-agenda-files
      '("~/org/agendas/tasks.org"
        "~/org/agendas/habits.org"))
(setq org-todo-files
      '("~/org/agendas/tasks.org"))
(defun my-clocktable-files ()
  (list "~/org/agendas/tasks.org"
	"~/org/agendas/habits.org"
	"~/org/agendas/journal.org"))

(setq org-refile-targets '(("~/org/agendas/journal.org" :maxlevel . 3)))
(setq org-archive-files "~/org/agendas/journal.org")

;; Registers for file shortcuts
(set-register ?t (cons 'file "~/org/agendas/tasks.org"))
(set-register ?h (cons 'file "~/org/agendas/habits.org"))
(set-register ?j (cons 'file "~/org/agendas/journal.org"))

(setq org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3 :properties ("Effort") :fileskip0 t))



;; Configure custom agenda views
(setq org-agenda-custom-commands
      '(("A" "Archived Agenda"
         ((agenda ""
		((org-agenda-files org-archive-files)))))

        ("d" "Dashboard"
         ((agenda ""
		((org-agenda-span 1)
		(org-deadline-warning-days 0)))
          (todo "TODAY"
                ((org-agenda-overriding-header "Today's tasks")
                 (org-agenda-files org-agenda-files)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")
                 (org-agenda-files org-agenda-files)))
          (todo "WIP"
                ((org-agenda-overriding-header "Work In Progress")
                 (org-agenda-files org-agenda-files)))
          (todo "DONE"
                ((org-agenda-overriding-header "DONE")
                 (org-agenda-files org-agenda-files)))
          (todo "CANC"
                ((org-agenda-overriding-header "CANCELLED")
                 (org-agenda-files org-agenda-files)))
          (todo "TODO"
                ((org-agenda-overriding-header "Unscheduled TODO Tasks")
                 (org-agenda-files org-agenda-files)
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'deadline))))
          ))

        ("h" "Habits in consistency graph"
         agenda ""
         ((org-agenda-span 'day)
          (org-agenda-use-time-grid nil)
          (org-agenda-prefix-format '((agenda . "")))
          (org-habit-show-all-today t)
          (org-habit-graph-column 40)
          (org-habit-preceding-days 30)
          (org-habit-following-days 14)
          (org-agenda-sorting-strategy '(scheduled-up))
          ;; display habits only
          (org-agenda-skip-function
            (lambda ()
              (and (save-excursion
                     (not (org-is-habit-p)))
                   (progn (outline-next-heading) (point)))))))))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(setq org-capture-templates
      `(("t" "Task Entries")
        ("tt" "Task" entry
         (file+olp "~/org/agendas/tasks.org" "Tasks")
         "* TODO %? \nCREATED_AT: %U\n  %^{Effort}p"
         :empty-lines 1)
        ("tT" "Task with schedule" entry
         (file+olp "~/org/agendas/tasks.org" "Tasks")
         "* TODO %? \nSCHEDULED: %^t DEADLINE: %^t\nCREATED_AT: %U\n  %^{Effort}p"
         :empty-lines 1)
        ("tq" "Quick task" entry
         (file+olp "~/org/agendas/tasks.org" "Quicks")
         "* TODO %? :quick:\nCREATED_AT: %U\n  %^{Effort}p"
         :empty-lines 1)
        ("tQ" "Quick task with schedule" entry
         (file+olp "~/org/agendas/tasks.org" "Quicks")
         "* TODO %? :quick:\nSCHEDULED: %^t DEADLINE: %^t\nCREATED_AT: %U\n  %^{Effort}p"
         :empty-lines 1)

        ("s" "Study Entries")
        ("ss" "Study" entry
         (file+olp "~/org/agendas/tasks.org" "Studies")
         "* TODO %? :study:\nCREATED_AT: %U\n  %^{Effort}p\n** Properties\n** Homework\n** Notes"
         :empty-lines 1)
        ("sS" "Study with schedule" entry
         (file+olp "~/org/agendas/tasks.org" "Studies")
         "* TODO %? :study:\nSCHEDULED: %^t DEADLINE: %^t\nCREATED_AT: %U\n  %^{Effort}p\n** Properties\n** Homework\n** Notes"
         :empty-lines 1)

        ("w" "Work Entries")
        ("ww" "Work" entry
         (file+olp "~/org/agendas/tasks.org" "Works")
         "* TODO %? :work:\nCREATED_AT: %U\n  %^{Effort}p"
         :empty-lines 1)
        ("wW" "Work with schedule" entry
         (file+olp "~/org/agendas/tasks.org" "Works")
         "* TODO %? :work:\nSCHEDULED: %^t DEADLINE: %^t\nCREATED_AT: %U\n  %^{Effort}p"
         :empty-lines 1)

        ("j" "Journal Entries")
        ("jd" "Daily" entry
         (file+olp+datetree org-archive-files)
         "\n* %<%I:%M %p> - Journal :daily:journal:\n%?\n#+BEGIN: clocktable :maxlevel 4 :block %(format-time-string \"%Y-%m-%d\") :scope my-clocktable-files :properties (\"Effort\") \n#+END\n** Study\n#+BEGIN: clocktable :maxlevel 4 :block %(format-time-string \"%Y-%m-%d\") :scope my-clocktable-files :match \"study\" :properties (\"Effort\") \n#+END\n** Morning\n** Afternoon\n** Evening\n** Positive\n** Appreciation\n** Pomodoro\n** Thoughts\n\n\n\n"
         :clock-in :clock-resume
         :empty-lines 1)
        ("jw" "Weekkly" entry
         (file+olp+datetree org-archive-files)
         "\n* %<%I:%M %p> - Journal :weekly:journal:\n%?\n#+BEGIN: clocktable :maxlevel 5 :scope my-clocktable-files :properties (\"Effort\") :tstart \"%(format-time-string \"<%Y-%m-%d>\")\" :tend \"%(format-time-string \"<%Y-%m-%d>\")\" \n#+END\n\n** Keep\n** Fix\n** Change\n** Problem\n** Try\n** Positive\n** Events\n** Music\n** Movie/Drama/Anime/Video\n** News\n** Book\n"
         :clock-in :clock-resume
         :empty-lines 1)
        ("jm" "Monthly" entry
         (file+olp+datetree org-archive-files)
         "\n* %<%I:%M %p> - Journal :monthly:journal:\n#+BEGIN: clocktable :maxlevel 5 :scope my-clocktable-files :properties (\"Effort\") :tstart \"%(format-time-string \"<%Y-%m-01>\")\" :tend \"%(format-time-string \"<%Y-%m-%d>\")\" \n#+END\n\n%?\n\n"
         :clock-in :clock-resume
         :empty-lines 1)

        ("r" "Reflection Entries")
	("rk" "Keep" entry
         (file+olp "~/org/agendas/journal.org" "Keep")
         "* %? :keep:\nCREATED_AT: %U\n"
         :empty-lines 1)
	("rp" "Problem" entry
         (file+olp "~/org/agendas/journal.org" "Problem")
         "* %? :problem:\nCREATED_AT: %U\n"
         :empty-lines 1)
	("rt" "Try" entry
         (file+olp "~/org/agendas/journal.org" "Try")
         "* %? :try:\nCREATED_AT: %U\n"
         :empty-lines 1)
        
        ("h" "Habit Entries")
        ("hd" "Daily" entry
         (file+olp "~/org/agendas/habits.org" "Daily")
         "* TODO %? :daily:\nSCHEDULED: %^{Scheduled}t\n:PROPERTIES:\n:STYLE: habit\n:END:\nCREATED_AT: %U\n %^{Effort}p"
         :empty-lines 1)

        ("hw" "Weekly" entry
         (file+olp "~/org/agendas/habits.org" "Weekly")
         "* TODO %? :weekly:\nSCHEDULED: %^{Scheduled}t\n:PROPERTIES:\n:STYLE: habit\n:END:\nCREATED_AT: %U\n %^{Effort}p"
         :empty-lines 1)

        ("hm" "Monthly" entry
         (file+olp "~/org/agendas/habits.org" "Monthly")
         "* TODO %? :monthly:\nSCHEDULED: %^{Scheduled}t\n:PROPERTIES:\n:STYLE: habit\n:END:\nCREATED_AT: %U\n %^{Effort}p"
         :empty-lines 1)))


