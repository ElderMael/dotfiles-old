					; MELPA repository
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-treshold 50000000)


					; Global Line Numbers
(global-linum-mode 1)
					; Global Column Numbers
(setq column-number-mode t)
					; Vertical Rule
(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
(setq fci-always-use-textual-rule 1)
(setq fci-rule-character-color "darkblue")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (nyan-mode auto-package-update magit auto-complete markdown-mode company all-the-icons hcl-mode material-theme ceylon-mode neotree terraform-mode fill-column-indicator))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'all-the-icons)
(load-theme 'material t)
(setq make-backup-files nil)

;; I _HATE_ Tabs
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)

;; setup files ending in “.tf” to open in hcl-mode
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))

;; No Backups, I use git
(setq make-backup-files nil)

(ac-config-default)
(global-set-key [f12] 'magit-status)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;; Neo Tree Theme
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
