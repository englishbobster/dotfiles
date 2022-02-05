;; First setup packages

;; Set package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" ."http://stable.melpa.org/packages/") t)

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; Activate packages before we use them
(package-initialize)

;; Refresh the packages
(when (not package-archive-contents)
  (package-refresh-contents))

;; My required packages to be installed
(defvar my-packages '(
                      ;;Add markdown mode for jekyll editing
                      markdown-mode
                      
                      ;; makes handling lisp expressions much, much easier
		      ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
		      paredit

		      ;; great theme
		      gruvbox-theme
		      
		      ;; Use the better defaults packages
		      ;; https://github.com/technomancy/better-defaults
		      better-defaults

		      ;; Project integration
		      ;; https://github.com/bbatsov/projectile
                      projectile

		      ;; Clojure Major mode
		      ;; https://github.com/clojure-emacs/clojure-mode
                      clojure-mode

		      ;; integration with a Clojure REPL
		      ;; https://github.com/clojure-emacs/cider
		      cider

		      ;; Incremental completion
		      ;; https://emacs-helm.github.io/helm/
		      helm
		      helm-cider

		      ;; colorful parenthesis matching
		      rainbow-delimiters))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Langauage-specific
(load "clojure.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Org mode stuff
(load "orgmode.el")

;; HTML editiing
(load "html.el")

;; Hard-to-categorize customizations
(load "misc.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit rainbow-delimiters paredit k8s-mode yaml-mode helm helm-cider helm-cider-history gruvbox-theme projectile better-defaults cider clojure-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "PfEd" :slant normal :weight normal :height 154 :width normal)))))
