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
;;spaces and not tabs
(setq-default indent-tabs-mode nil)
;;helm mode is a must
(add-hook 'after-init-hook 'helm-mode)
;;enable company-mode as default
(add-hook 'after-init-hook 'global-company-mode)
;;and we want alchemist
(add-hook 'after-init-hook 'alchemist-mode)
;;yasnippet
(add-hook 'prog-mode-hook 'yas-minor-mode)

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

;;orgmode settings
(setq-default org-list-indent-offset 4)

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
 '(custom-enabled-themes (quote (manoj-dark)))
 '(display-time-mode t)
 '(elm-format-on-save t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-todo-keywords (quote ((sequence "TODO(t)" "DONE(d)"))))
 '(package-selected-packages
   (quote
    (docker docker-api docker-compose-mode dockerfile-mode magit gradle-mode tomatinho restclient-helm markdown-toc markdown-preview-mode markdown-preview-eww markdown-mode+ haskell-tab-indent haskell-mode groovy-mode google-this google-maps gh-md erlang elm-mode elixir-yasnippets ace-mc ace-jump-helm-line ac-alchemist)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans" :foundry "monotype" :slant normal :weight normal :height 158 :width normal)))))


;;configure-tomatinho
(require 'tomatinho)
(global-set-key (kbd "<f12>") 'tomatinho)

;;ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;;yang mode
(add-to-list 'load-path "~/.emacs.d/other_plugins")
(load "yang-mode.el")

     (autoload 'yang-mode "yang-mode" "Major mode for editing YANG modules."
               t)
     (add-to-list 'auto-mode-alist '("\\.yang$" . yang-mode))

     (setq blink-matching-paren-distance nil)

;;   Common YANG layout:
     (defun my-yang-mode-hook ()
       "Configuration for YANG Mode. Add this to `yang-mode-hook'."
       (if window-system
         (progn
           (c-set-style "BSD")
           (setq indent-tabs-mode nil)
           (setq c-basic-offset 2)
           (setq font-lock-maximum-decoration t)
           (font-lock-mode t))))
     (add-hook 'yang-mode-hook 'my-yang-mode-hook)

;;elm stuff
(add-hook 'elm-mode-hook #'elm-oracle-setup-ac)

(find-file "~/src/Docs/orgmode/personal_notes.org")

