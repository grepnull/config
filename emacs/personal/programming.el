(setq prelude-guru nil)

;; disable guru-mode, whitespace-mode and whitespace-cleanup
;(add-hook 'prelude-prog-mode-hook
           ;(lambda ()
             ;(guru-mode 0)
;;             (prelude-turn-off-whitespace t)
             ;(remove-hook 'before-save-hook 'whitespace-cleanup)) t)

(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

(global-git-commit-mode)
