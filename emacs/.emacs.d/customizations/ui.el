;; These customizations change the way emacs looks and disable/enable
;; some user interface elements. Some useful customizations are
;; commented out, and begin with the line "CUSTOMIZE". These are more
;; a matter of preference and may require some fiddling to match your
;; preferences

;; No splash screen
(setq inhibit-splash-screen t)

;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)

;; Turn off tool-bar as well
(tool-bar-mode -1)

;; Show line numbers
(global-linum-mode t)

;; Gruvbox theme
(load-theme 'gruvbox-dark-medium t)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell
(setq ring-bell-function 'ignore)

;;visual line mode so that lines wrap
(global-visual-line-mode t)
