(setq inhibit-splash-screen t)
(global-linum-mode t)
(tool-bar-mode -1)
;;(menu-bar-mode -1)
(show-paren-mode 1)
(helm-mode 1)


(load-theme 'gruvbox-dark-medium t)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(better-defaults
                      projectile
                      clojure-mode
                      cider
		      helm
		      helm-cider))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm helm-cider helm-cider-history gruvbox-theme projectile better-defaults cider clojure-mode))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "PfEd" :slant normal :weight normal :height 154 :width normal)))))
