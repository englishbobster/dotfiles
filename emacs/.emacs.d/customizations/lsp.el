(require 'lsp-mode)

;; going to need a language server for java script and friends
(add-hook 'js-mode-hook #'lsp-deferred)
(add-hook 'js-jsx-mode-hook #'lsp-deferred)
(add-hook 'typescript-mode-hook #'lsp-deferred)

;; enable complete any for all major modes
(add-hook 'after-init-hook 'global-company-mode)




;; This Server supports automatic install. 
;; Install this language server with <M-x>lsp-install-server<RET>jsts-ls<RET>.
(setq exec-path (append exec-path '("~/.nvm/versions/node/v16.14.0/bin/")))
