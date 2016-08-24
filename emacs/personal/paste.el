(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((sgml-indent-level . 2) (nxml-attribute-indent . 3) (nxml-child-indent . 3)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; http://stackoverflow.com/questions/9985316/how-to-paste-to-emacs-from-clipboard
;(defun copy-from-osx ()
;  (shell-command-to-string "pbpaste"))

;(defun paste-to-osx (text &optional push)
;  (let ((process-connection-type nil))
;    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;      (process-send-string proc text)
;      (process-send-eof proc))))

;(setq interprogram-cut-function 'paste-to-osx)
;(setq interprogram-paste-function 'copy-from-osx)

(global-set-key (kbd "C-c C-v") '(lambda () (interactive) (insert (shell-command-to-string "pbpaste"))))

(defun put-the-date ()
  (interactive)
  (insert (shell-command-to-string "date")))

(global-set-key
 (kbd "C-c C-d")
 'put-the-date
 )
