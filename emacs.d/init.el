					; MELPA repository
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


					; list the packages you want
(setq package-list
      '( nyan-mode auto-package-update magit
           auto-complete markdown-mode company
           hcl-mode material-theme ceylon-mode
           neotree terraform-mode fill-column-indicator))


; activate all the packages
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

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


(load-theme 'material t)
(setq make-backup-files nil)

;; I _HATE_ Tabs
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq indent-line-function 'insert-tab)

;; setup files ending in “.tf” to open in hcl-mode
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))

;; No Backups, I use git
(setq make-backup-files nil)

(ac-config-default)
(global-set-key [f12] 'magit-status)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;; Font
(set-default-font "Ubuntu Mono derivative Powerline 20")

;; Nyan!!!!!!!!
(define-globalized-minor-mode global-nyan-mode nyan-mode
  (lambda () (nyan-mode 1)))

(define-globalized-minor-mode global-whitespace-mode whitespace-mode
  (lambda () (whitespace-mode 1)))


(global-nyan-mode 1)
(global-whitespace-mode 1)

