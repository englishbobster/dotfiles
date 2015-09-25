;;no splash screen
(setq inhibit-splash-screen t)

;;switch the bell off
(setq visible-bell 1)

;; line numbering please
(global-linum-mode 1)

;;start in a good default position
(setq initial-frame-alist '((left . 350) (top . 150)))

;;enable company-mode as default
(add-hook 'after-init-hook 'global-company-mode)

;;and a nice size
(when (display-graphic-p)
  (set-frame-height (selected-frame) 60)
  (set-frame-width (selected-frame)  120)
)

;;disable backup
;;(setq backup-inhibited t)

;;disable auto save
(setq auto-save-default nil)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; match parenthesis on
(show-paren-mode 1)

;;tomatinho
(add-to-list 'load-path "~/.emacs.d/konr-tomatinho-1836b2e")
(require 'cl)
(require 'tomatinho)
(global-set-key (kbd "<f12>") 'tomatinho)


;;remove icon tool bar
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("2e5705ad7ee6cfd6ab5ce81e711c526ac22abed90b852ffaf0b316aa7864b11f" default)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 128 :width normal)))))


;;groovy
;; turn on syntax highlighting
(global-font-lock-mode 1)

;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'load-path "~/.emacs.d/emacs-groovy-mode_2011-06-29")
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

;;yang-mode
(autoload 'yang-mode "yang-mode" "Major mode for editing YANG modules." t)
(add-to-list 'auto-mode-alist '("\\.yang$" . yang-mode))

;;javascript stuff
(add-to-list 'load-path "/usr/local/src/dev/git/github/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-20150727.2148")
(load-theme 'zenburn t)

;;default alchemist-elixir
(global-company-mode)
(require 'elixir-mode)
(require 'alchemist)
