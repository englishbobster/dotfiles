;;no splash screen
(setq inhibit-splash-screen t)
;;switch the bell off
(setq visible-bell 1)
;; line numbering please
(global-linum-mode 1)
;;disable auto save
(setq auto-save-default nil)
;; match parenthesis on
(show-paren-mode 1)
;;no toolbar
(tool-bar-mode -1)

;;enable company-mode as default
(add-hook 'after-init-hook 'global-company-mode)
;;and we want alchemist
(add-hook 'after-init-hook 'alchemist-mode)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; save position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;;trailing white space
(setq-default show-trailing-whitespace t)

;;package management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(custom-enabled-themes (quote (manoj-dark)))
 '(display-time-mode t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal)))))
