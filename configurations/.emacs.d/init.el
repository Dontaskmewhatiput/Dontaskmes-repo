;;; -*- lexical-binding: t; -*-
;; Disables UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; Backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; UI elements
(global-display-line-numbers-mode 1)
(load-theme 'modus-vivendi t)

;; Indentation
(setq-default tab-width 2)
(setq-default indent-tabs-mode t)
(setq-default c-basic-offset 2)

;; Package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Packages
(use-package vertico
  :ensure t
  :init (vertico-mode))

(use-package orderless
	:ensure t
	:custom
	(completion-styles '(orderless basic)))



(use-package marginalia
  :ensure t
  :init (marginalia-mode))

(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
	 ("C-c f" . consult-fd)
	 ("C-c s" . consult-ripgrep)
	 ("C-s" .   consult-line)))








(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(consult marginalia orderless smart-tabs-mode vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
(put 'upcase-region 'disabled nil)
