;;; package -- Summary
;;; Commentary:
;;; Code:
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(sp-local-pair 'clojure-mode "`" "`")

(prelude-require-packages '(evil-smartparens  bind-key ag))
(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
(setq ag-highlight-search t)

(provide 'personal)
;;; personal.el ends here
