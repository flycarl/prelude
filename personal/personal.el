(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


(setq evil-emacs-state-cursor  '("orange" box))
(setq evil-normal-state-cursor '("gray" box))
(setq evil-visual-state-cursor '("gray" box))
(setq evil-insert-state-cursor '("gray" bar))
(setq evil-motion-state-cursor '("gray" box))


;; Disable prelude key-chords
(key-chord-define-global "jj" nil)
(key-chord-define-global "jk" nil)
(key-chord-define-global "jl" nil)
(key-chord-define-global "JJ" nil)
(key-chord-define-global "uu" nil)
(key-chord-define-global "xx" nil)
(key-chord-define-global "yy" nil)

;; setup jk as ESC
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-normal-state)

;; set evil-emacs-state on following modes
(dolist (mode '(
                cider-repl-mode
                cider-docview-mode
                cider-stacktrace-mode
                makey-key-mode
                ))
  (add-to-list 'evil-emacs-state-modes mode))

(add-hook 'cider-macroexpansion-mode-hook 'evil-emacs-state)

(provide 'personal)
;;; personal.el ends here
