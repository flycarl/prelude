(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(sp-local-pair 'clojure-mode "`" "`")

(prelude-require-packages '(evil-smartparens ag))
(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

(provide 'personal)
;;; personal.el ends here
