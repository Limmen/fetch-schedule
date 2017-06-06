;; fetch-schedule.el
;;
;; fetch exported schedule (ics) format from URL and update diary/calendar.
;; dependencies: use-package and request.

(use-package request)

(defvar diary-remote-calendar ""
  "URL to remote .cs calendar.")

(defvar diary-remote-calendar-local-replica ""
  "Path to where the local replica of the calendar is saved")

(defun fetch-schedule ()
  "Fetch schedule given a http link to ICS exported schedule"
  (interactive)
  (if (and (boundp 'diary-remote-calendar)
	   (boundp 'diary-remote-calendar-local-replica)
	   (not (string= diary-remote-calendar ""))
	   (not (string= diary-remote-calendar-local-replica "")))
      (request
       diary-remote-calendar
       :parser (lambda () (buffer-string))
       :success (cl-function
		 (lambda (&key data &allow-other-keys)
		   (let (
			 (oldbuf (current-buffer))
			 (tempfile "~/diary-remote-calendar.tmp")
			 )
		     (progn
		       (del-file diary-remote-calendar-local-replica)
		       (del-file tempfile)
		       (with-temp-file tempfile
			 (set-buffer-file-coding-system 'raw-text)
			 (insert data))
		       (icalendar-import-file tempfile diary-remote-calendar-local-replica)
		       (switch-to-buffer oldbuf)
		       (message "Calendar successfully updated"))
		     ))))
    (message "diary-remote-calendar or diary-remote-calendar-local-replica is not set")))

(provide 'fetch-schedule)

(defun del-file (f)
  (when (file-exists-p f)
    (progn
      (message "file exists")
      (delete-file f)
      (message "file %s deleted" f))
    ))
