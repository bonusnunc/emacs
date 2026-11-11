;; -*- lexical-binding: t -*-
(require 'package)
(setq package-archives '(
			   ;;("melpa-stable" . "https://stable.melpa.org/packages/")
			   ("melpa" . "https://melpa.org/packages/")
			   ("org" . "https://orgmode.org/elpa/")
			   ("elpa" . "https://elpa.gnu.org/packages/")))

(setq package-quickstart t)
;;(package-initialize)
;;(unless package-archive-contents
;;  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq custom-file "~/.config/emacs/config.el")

(setq native-comp-speed 3)

;; Ensure Emacs loads the most recent byte-compiled files.
(setq load-prefer-newer t)

 ;; Guardar historial de archivos
(use-package recentf
  :ensure nil
;;  :defer 1
  :custom
;;  (setq recentf-auto-cleanup 'never)
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-items 25)
  (global-set-key "\C-x\ \C-r" 'recentf-open-files) ;; Atajo para abrir archivos recientes
  :config (recentf-mode 1))

(electric-pair-mode t) ;; Cerrar automáticamente los paréntesis etc
(setq electric-pair-pairs '(
			      (?\¿ . ?\?)
			      (?\“ . ?\”)
			      ))
(delete-selection-mode t)

(use-package ultra-scroll
;:load-path "~/code/emacs/ultra-scroll" ; if you git clone'd instead of package-vc-install 
  :config
  (setq scroll-conservatively 101) ; important!
  (setq scroll-margin 0)
  (ultra-scroll-mode 1))

(use-package yasnippet
  :hook (org-mode . yas-minor-mode)
  :config
  (setq yas-snippet-dir '("~/.config/emacs/snippets"))
  (yas-reload-all))

(use-package auto-complete
  :hook (yas-minor-mode . auto-complete-mode)
  :config (ac-flyspell-workaround)
  (ac-config-default)
  (add-to-list 'ac-modes 'org-mode)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
  (setq ac-auto-start 1)
  ;;   (ac-set-trigger-key "TAB")
  ;; (ac-set-trigger-key "<tab>")
  )

(defun autorg ()
  (setq ac-sources '(ac-source-yasnippet)))

(add-hook 'org-mode-hook 'autorg)

;;(use-package nerd-icons)
;;(use-package all-the-icons)

(use-package ligature
  :config
  ;; Enable all Iosevka ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->"
				       "<->" "<-->" "<--->" "<---->" "<!--"
                                       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  (ligature-set-ligatures 'org-mode '(
				      "Qy" "Th"
				      "ae"
				      "ch" "ck" "ct"
				      "ffb" "ffh" "ffi" "ffj" "ffk" "ffl" "ffl" "fft"
				      "fn" "ff" "fh" "fi" "fj" "fk" "fp" "ft"
				      "oe"
				      "qꝫ"

				      "<---" "<--"  "<<-" "<-" "->" "-->" "--->"
				      "<->" "<-->" "<--->" "<---->" "<!--"
                                      "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                      "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                      ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;;(display-battery-mode 1)
;;(setq display-time-default-load-average 'nil)
;;(display-time-mode 1)

(use-package nyan-mode)
(setq nyan-animate-nyancat t)
(setq nyan-wavy-trail t)
(nyan-mode)
(nyan-start-animation)

(defun espaciado ()
    (setq-local line-spacing 0.25))
(add-hook 'text-mode-hook 'espaciado)

(setq custom-safe-themes t)
(use-package batppuccin
:ensure t
:config
(load-theme 'batppuccin-latte t))

  ;; (use-package auto-dark
  ;;   :custom
  ;;   (auto-dark-themes '((batppuccin-mocha) (batppuccin-latte)))
  ;;   :init (auto-dark-mode))

(use-package visual-fill-column
	:hook (org-mode . visual-fill-column-mode)
	:config
	(setq-default visual-fill-column-width 72)
	(setq-default visual-fill-column-center-text t)
	(setq visual-fill-column-enable-sensible-window-split t))

(use-package adaptive-wrap
	:hook (org-mode . adaptive-wrap-prefix-mode))

(setq ispell-program-name "hunspell")
;;  (setq ispell-local-dictionary "es")

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(setq-default org-hide-emphasis-markers t
  	      org-pretty-entities t
  	      org-use-sub-superscripts "{}"
  	      org-startup-with-inline-images t
  	      org-image-actual-width 300)

(font-lock-add-keywords 'org-mode
			'(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(setq org-ellipsis " ☜")

(use-package org-appear
  :after org
  :hook (org-mode . org-appear-mode)
  :custom
  (org-appear-autolinks t)
  (org-appear-autokeywords t)
  (org-appear-autoemphasis t)
  (org-appear-autoentities t)
  )

(custom-set-faces
 '(org-block ((t (:inherit (fixed-pitch) :height 0.8))))
 '(org-block-begin-line ((nil (:inherit fixed-pitch :height 0.8))))
 '(org-block-end-line ((nil (:inherit fixed-pitch :height 0.8))))
 '(org-checkbox ((nil (:inherit fixed-pitch))))
 '(org-code ((nil (:inherit (shadow fixed-pitch)))))
 '(org-document-author ((nil (:weight black :underline nil))))
 '(org-document-title ((nil (:weight black :height 1.8 :underline nil))))
 '(org-indent ((nil (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((nil (:weight black :weight black :height 1.7))))
 '(org-level-2 ((nil (:weight black :height 1.25))))
 '(org-level-3 ((nil (:weight black :height 1.1))))
 '(org-list-dt ((nil (:inherit fixed-pitch))))
 '(org-meta-line ((nil (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((nil (:inherit fixed-pitch))))
 '(org-special-keyword ((nil (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((nil (:inherit fixed-pitch :height 0.8))))
 '(org-tag ((nil (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((nil (:inherit (shadow fixed-pitch))))))

(use-package ox-reveal
  :hook (org-mode . (lambda() (require 'ox-reveal)))
  :config
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  )

(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'org-bullets-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'adaptive-wrap-prefix-mode)
(add-hook 'org-mode-hook 'visual-fill-column-mode)
(add-hook 'org-mode-hook 'flyspell-mode)

(use-package auctex
  :ensure t
  :defer t)

;;(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)


;; Lector de PDFs
(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :init (pdf-loader-install))
(add-hook 'pdf-view-mode-hook
          (lambda ()
            (auto-revert-mode 1)))

(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
