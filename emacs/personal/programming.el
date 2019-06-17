(setq prelude-guru nil)

;; disable guru-mode, whitespace-mode and whitespace-cleanup
;(add-hook 'prelude-prog-mode-hook
           ;(lambda ()
             ;(guru-mode 0)
;;             (prelude-turn-off-whitespace t)
             ;(remove-hook 'before-save-hook 'whitespace-cleanup)) t)

(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

(add-to-list 'auto-mode-alist '("BUILD" . bazel-mode))

(global-git-commit-mode)

(setq display-line-numbers-width-start t)
;(global-display-line-numbers-mode)

(add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)

(setq ffip-use-rust-fd t)

;; Disable `Symbolic link to Git-controlled source file; follow link? (y or n)' prompt.
(setq vc-follow-symlinks nil)

(defun prelude-python-mode-defaults ()
  "Defaults for Python programming."
  (subword-mode +1)
  (elpy-mode +1)
  (eldoc-mode +1)
  (highlight-indentation-mode 0)
  (define-key elpy-mode-map (kbd "M-,") 'pop-tag-mark)
  (setq-local electric-layout-rules
              '((?: . (lambda ()
                        (and (zerop (first (syntax-ppss)))
                             (python-info-statement-starts-block-p)
                             'after)))))
  (when (fboundp #'python-imenu-create-flat-index)
    (setq-local imenu-create-index-function
                #'python-imenu-create-flat-index))
  (add-hook 'post-self-insert-hook
            #'electric-layout-post-self-insert-function nil 'local)
  (add-hook 'after-save-hook 'prelude-python-mode-set-encoding nil 'local))

;; So that pasting from a Mac through iTerm2 works as a whole block without
;; messed up indentation.
(require 'bracketed-paste)
(bracketed-paste-enable)

(add-hook 'python-mode-hook 'importmagic-mode)

(defun yarn-lint-file ()
  (interactive)
  (message "yarn lint-ing the file" (buffer-file-name))
  (shell-command (concat "yarn lint " (buffer-file-name) " > /dev/null")))

(defun yarn-lint-file-and-revert ()
  (interactive)
  (yarn-lint-file)
  (revert-buffer t t)
  )

;(add-hook 'vue-mode-hook
          ;(lambda ()
            ;(add-hook 'after-save-hook #'yarn-lint-file)))

; https://github.com/editorconfig/editorconfig-emacs/issues/169#issuecomment-406734211
(with-eval-after-load 'editorconfig
  (add-to-list 'editorconfig-indentation-alist
               '(vue-mode css-indent-offset
                          js-indent-level
                          sgml-basic-offset
                          ssass-tab-width
                          typescript-indent-level
                          js2-basic-offset
                          )))
