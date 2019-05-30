;; (eval-when-compile
;;   (require 'use-package))
(require 'package)

(menu-bar-mode -1)
(tool-bar-mode -1)

;; set up packages
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;personal info
(setq user-mail-address "utduu@student.kit.edu")
(setq language-environment "Latin-1")

;;setting up calendar location
(setq calendar-longtitude 8.3858333)
(setq calendar-latitude 49.0047222)
(setq calendar-location-name "Karlsruhe")

;;setting up names
 (add-hook 'calendar-load-hook
              (lambda ()
                (calendar-set-date-style 'european)))
   (setq calendar-week-start-day 1
          calendar-day-name-array ["Sonntag" "Montag" "Dienstag" "Mittwoch"
                                   "Donnerstag" "Freitag" "Samstag"]
          calendar-month-name-array ["Januar" "Februar" "März" "April" "Mai"
                                     "Juni" "Juli" "August" "September"
                                     "Oktober" "November" "Dezember"])

;; install packages
(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))


(use-package org-journal
  :ensure t
  :config
  (setq org-journal-dir "~/ownCloud/org/notes/") 
  (global-set-key (kbd "C-x j") 'org-journal-new-entry))

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

;; (use-package multi-web-mode
;;   :ensure t
;;   :config
;;   (progn
;;   (setq mweb-default-major-mode 'html-mode)
;;   (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;; 		    (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;; 		    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;;   (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;;   (multi-web-global-mode 1)))
  
(use-package ace-window
  :ensure t
  :bind (("C-x o" . ace-window)))


(use-package counsel
  :ensure t
  )

(use-package swiper
  :ensure t
  :bind(("C-s" . swiper)
	("C-r" . swiper)
	("C-c C-r" . ivy-resume)
	("M-x" . counsel-M-x)
	("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    ))


(use-package avy
  :ensure
  :bind (("C-+" . avy-goto-char)
	 ("C-ä" . avy-goto-word-1)
	 ("M-g h" . avy-goto-line)))

;;org-mode stuff
(setq org-agenda-files (list "~/ownCloud/org"))

;;keys to access org functionality
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done 'time)


(use-package org-pomodoro
  :ensure t
  :bind ("\C-cp" . 'org-pomodoro))

(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

(use-package opencl-mode
  :ensure t)

(use-package lua-mode
  :ensure t) 

(load-file "/home/tom/.emacs.d/rtags/build/src/rtags.el")
(setq rtags-path "/home/tom/.emacs.d/rtags/build/bin")
(define-key c-mode-base-map (kbd "M-g d")
  (function rtags-find-symbol-at-point))

(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

(use-package company
  :ensure t)
(add-hook 'after-init-hook 'global-company-mode)

(use-package company-rtags
  :ensure t
  :after (rtags)
  :config
  (progn
    (setq rtags-autostart-diagnostics t)
    (setq rtags-completions-enabled t)
    (push 'company-rtags company-backends)
    (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
    ))



(use-package flycheck
  :ensure t)

(use-package flycheck-rtags
  :ensure t
  :after (rtags)
  :config
  (progn
    (add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
    (add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
    (add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)
    ))

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))

(use-package ess
  :ensure t)

(use-package helm
  :ensure t)

(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)

;; (use-package irony
;;   :ensure t)

;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)



(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 120
                    :weight 'normal)

(global-set-key "\C-xr" 'replace-string)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   (quote
    ("3f44e2d33b9deb2da947523e2169031d3707eec0426e78c7b8a646ef773a2077" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-pomodoro-length 1)
 '(package-selected-packages
   (quote
    (opencl-mode shell-here yaml-mode php-mode neotree ess helm irony flycheck company company-mode zenburn-theme which-key use-package try org-pomodoro org-journal lua-mode counsel ace-window)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

(add-hook 'c-mode-hook 'electric-pair-mode)
(add-hook 'c++-mode-hook 'electric-pair-mode)
(add-hook 'objc-mode-hook 'electric-pair-mode)

(global-set-key (kbd "M-g o") 'imenu)


(setq-default c-basic-offset 4)


(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)))

(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle) ("<f9>" . neotree-find))

(use-package php-mode
  :ensure t)

(use-package shell-here
  :ensure t
  :bind ("C-C !" . shell-here))

(setq org-directory "~/ownCloud/org")
(setq org-default-notes-file (concat org-directory "/capture.org"))
(global-set-key (kbd "C-c t") (lambda () (interactive) (find-file (concat org-directory "/todo.org"))))
