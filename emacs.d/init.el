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
					; Vertical Rule
(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
(setq fci-always-use-textual-rule 1)
(setq fci-rule-character-color "darkblue")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
