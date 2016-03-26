;;; init-evil.el --- Emacs Prelude: evil-mode configuration.
;;
;; Copyright © 2011-2016 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: http://batsov.com/prelude
;; Version: 1.0.0
;; Keywords: convenience


;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for evil-mode.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;;; goto-chg lets you use the g-; and g-, to go to recent changes
;;; evil-visualstar enables searching visual selection with *
;;; evil-numbers enables vim style numeric incrementing and decrementing

(prelude-require-packages '(evil
                            goto-chg
                            evil-surround
                            evil-visualstar
                            evil-numbers
                            evil-leader))

(require 'evil-visualstar)
(require 'evil-leader)
(global-evil-leader-mode)

(defun air--config-evil-leader ()
  "Configure evil leader mode."
  (evil-leader/set-leader ",")
  ;(setq evil-leader/in-all-states 1)
  (evil-leader/set-key
    ","  'avy-goto-char-2
    "."  'switch-to-previous-buffer
    "s"  'ag-project            ;; Ag search from project's root
    )
)

(air--config-evil-leader)

(setq evil-mode-line-format 'before)

(setq evil-emacs-state-cursor  '("orange" box))
(setq evil-normal-state-cursor '("gray" box))
(setq evil-visual-state-cursor '("gray" box))
(setq evil-insert-state-cursor '("gray" bar))
(setq evil-motion-state-cursor '("gray" box))

;; prevent esc-key from translating to meta-key in terminal mode
(setq evil-esc-delay 0)

(evil-mode 1)
(global-evil-surround-mode 1)

(define-key evil-normal-state-map (kbd "C-A")
  'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-S-A")
  'evil-numbers/dec-at-pt)

;;
;; Other useful Commands
;;
(evil-ex-define-cmd "W"     'evil-write-all)
(evil-ex-define-cmd "Tree"  'speedbar-get-focus)
(evil-ex-define-cmd "linum" 'linum-mode)
(evil-ex-define-cmd "Align" 'align-regexp)

(defun prelude-yank-to-end-of-line ()
  "Yank to end of line."
  (interactive)
  (evil-yank (point) (point-at-eol)))

(define-key evil-normal-state-map
  (kbd "Y") 'prelude-yank-to-end-of-line)

(defun prelude-shift-left-visual ()
  "Shift left and restore visual selection."
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun prelude-shift-right-visual ()
  "Shift right and restore visual selection."
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(define-key evil-visual-state-map (kbd ">") 'prelude-shift-right-visual)
(define-key evil-visual-state-map (kbd "<") 'prelude-shift-left-visual)


;;
;; Magit from avsej
;;
(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard
  "L" 'magit-log-popup)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard
  "l" 'magit-log-popup
  "h" 'magit-diff-toggle-refine-hunk)

(setq evil-shift-width 2)

;;; enable avy with evil-mode
(define-key evil-normal-state-map (kbd "SPC") 'avy-goto-word-1)

;; set evil-emacs-state on following modes
(dolist (mode '(
                cider-repl-mode
                cider-docview-mode
                cider-stacktrace-mode
                makey-key-mode
                ))
  (add-to-list 'evil-emacs-state-modes mode))

(add-hook 'cider-macroexpansion-mode-hook 'evil-emacs-state)

(provide 'init-evil)
;;; init-evil.el ends here
