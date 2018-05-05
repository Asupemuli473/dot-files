(require 'package)

(menu-bar-mode -1)
(tool-bar-mode -1)

;; set up packages
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;personal info
(setq user-mail-address "") ;; TODO set up email
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
  (progn
  (setq org-journal-dir "") ;; TODO journal directory
  (global-set-key (kbd "C-x j") 'org-journal-new-entry)))

(use-package multi-web-mode
  :ensure t
  :config
  (progn
  (setq mweb-default-major-mode 'html-mode)
  (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
		    (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
		    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
  (multi-web-global-mode 1)))
  
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
  :bind (("M-g c" . avy-goto-char)
	 ("M-g C" . avy-goto-char-2)
	 ("M-g w" . avy-goto-word-1)
	 ("M-g W" . avy-goto-word-0)
	 ("M-g l" . avy-goto-line)))

;;org-mode stuff
;;keys to access org functionality
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done 'time)

;;set agenda files
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m)))
 '(initial-buffer-choice t)
 '(org-agenda-files (quote (""))) ;; TODO setup agenda file dir
 '(org-log-into-drawer (quote LOGBOOK))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(package-selected-packages (quote (multi-web-mode org-journal))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Hotkeys
(global-set-key (kbd "C-C C-/") 'comment-dwim)


(load-theme 'leuven)
(setq default-directory "") ;; TODO setup default dir
