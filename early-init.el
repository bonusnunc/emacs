;; -*- lexical-binding: t -*- 
;;(profiler-start 'cpu)

;; Emacs startup proceeds through several stages: it loads the early init and
;; regular init files, processes command-line options, sets after-init-time,
;; runs emacs-startup-hook, performs additional initial-frame setup such as
;; applying frame parameters from the configuration, and then runs
;; window-setup-hook after the initial frame parameters have been configured.
;; This makes window-setup-hook a useful place to record a broader startup-time
;; measurement.
;;
;; URL: https://www.jamescherti.com/measuring-emacs-startup-time/
(defvar my-recorded-startup-time-message nil
  "Stores the formatted string of the Emacs startup metrics.")

(defun my-record-startup-time ()
  "Calculate and record the elapsed startup time.
This function records the time when `window-setup-hook' runs."
  (setq my-recorded-startup-time-message
        (format "Emacs loaded in %.2f seconds (Init time: %.2fs) with %d garbage collections."
                (float-time (time-since before-init-time))
                (float-time (time-subtract after-init-time before-init-time))
                gcs-done))
  ;; Output to the *Messages* buffer during the initial launch
  (message "%s" my-recorded-startup-time-message))

(defun my-display-startup-time ()
  "Display the previously recorded Emacs startup time in the echo area."
  (interactive)
  (if my-recorded-startup-time-message
      (message "%s" my-recorded-startup-time-message)
    (message "Startup time was not recorded.")))

;; Read startup summary:
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Startup-Summary.html
;; (setq gc-cons-threshold 1000000000) ;; Minimize garbage collection during startup
;; (setq gc-cons-percentage 0.5)


(eval-and-compile
  (setq gc-cons-threshold 402653184
        gc-cons-percentage 0.6))
(run-with-idle-timer 10 t #'garbage-collect)

(add-hook 'window-setup-hook #'my-record-startup-time 99)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(tool-bar-mode -1)
(menu-bar-mode -1)
(setq use-dialog-box nil)
(scroll-bar-mode -1)
(tooltip-mode -1)
(setq server-client-instructions nil)
(setq frame-inhibit-implied-resize t)
(setq-default cursor-type '(bar . 2))


(setq inhibit-startup-echo-area-message "tychoish")
(setq inhibit-startup-message 't)
;;(setq initial-major-mode 'org-mode)


(set-face-attribute 'default nil
    		    :family "Iosevkada"
  		    :height 220
   		    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
    		    :family "Iosevkada"
    		    :weight 'medium
    		    :height 220)
(set-face-attribute 'mode-line nil
       		    :family "Iosevkada"
       		    :weight 'medium
       		    :height 180)
(set-face-attribute 'variable-pitch nil
    		    :family "Cormorant Garamond Medium"
    		    :height 280)
