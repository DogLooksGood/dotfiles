;;; Emacs configuration
;;; Tweaking for Clojure development with dvorak layout.



;;; Basic setup for dvorak keyboard.
;;; C-x is hard to type, so switch C-x to C-h
;;; Change help map to C-@

(global-set-key (kbd "C-@") help-map)
(global-set-key (kbd "C-h") ctl-x-map)
(global-unset-key (kbd "C-\\"))

;; split window or close window without shift
;; in programmer dvorak.

(global-set-key (kbd "C-h -") 'split-window-below)
(global-set-key (kbd "C-h \\") 'split-window-right)
(global-set-key (kbd "C-h x") 'delete-window)
(global-set-key (kbd "C-h o") 'delete-other-windows)



;;; Require `package'

(require 'package)

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)



;; Install `use-package'

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)



;;; Look & Feels

;; Font Setup.

(progn
  (setq my-font "MesloLGMDZ-11")
  (set-default-font my-font)
  (add-to-list 'default-frame-alist `(font . ,my-font))
  (set-face-attribute 'default t :font my-font))

(set-fontset-font t nil "NotoSansMono Nerd Font" nil 'prepend)

(defun user/flycheck-feebleline-status ()
  (let ((text (pcase flycheck-last-status-change
                (`not-checked "")
                (`no-checker "-")
                (`running "*")
                (`errored "!")
                (`finished
                 (let-alist (flycheck-count-errors flycheck-current-errors)
                   (if (or .error .warning)
                       (format "%s/%s" (or .error 0) (or .warning 0))
                     "")))
                (`interrupted ".")
                (`suspicious "?"))))
    (concat text)))

(defun user/cider-info ()
  (when (fboundp 'cider-mode)
    (let ((info (cider--modeline-info)))
      (unless (string-equal info "not connected")
	info))))


;; Hide mode line for distraction free style
(use-package feebleline
  :ensure  t
  :init
  (setq flycheck-mode-line-prefix "")
  :config
  (setq feebleline-msg-functions
        '((feebleline-line-number         :post "" :fmt "%5s")
          (feebleline-column-number       :pre ":" :fmt "%-2s")
	  (feebleline-project-name        :pre "{" :post "} ")
          (feebleline-file-directory      :face feebleline-dir-face :post "")
          (feebleline-file-or-buffer-name :face font-lock-keyword-face :post "")
          (feebleline-file-modified-star  :face font-lock-warning-face :post "")
          (feebleline-git-branch          :face font-lock-comment-face :pre " : ")
	  (user/flycheck-feebleline-status)))
  (feebleline-mode 1))

(setq window-divider-default-right-width 1)
(setq window-divider-default-places 't)
(window-divider-mode 1)

(use-package auto-dim-other-buffers
  :ensure t
  :init
  (setq auto-dim-other-buffers-dim-on-focus-out t)
  (setq auto-dim-other-buffers-dim-on-switch-to-minibuffer t)
  (auto-dim-other-buffers-mode t))

;; (use-package solarized-theme
;;   :ensure t
;;   :custom-face
;;   (window-divider ((nil :foreground "#002B36")))
;;   (auto-dim-other-buffers-face ((nil :background "#002632")))
;;   (fringe ((nil :background nil)))
;;   (font-lock-comment-face ((t (:italic t))))
;;   (font-lock-comment-delimiter-face ((t (:italic t))))
;;   (font-lock-doc-face ((t (:italic t))))
;;   :init
;;   (load-theme 'solarized-dark t))

;; (use-package plan9-theme
;;   :ensure t
;;   :custom-face
;;   (window-divider ((nil :foreground "#FFFFE8")))
;;   (auto-dim-other-buffers-face ((nil :background "#F5F5E0"
;; 				     :foreground "#666666")))
;;   (fringe ((nil :background nil)))
;;   (font-lock-comment-face ((t (:italic t))))
;;   (font-lock-comment-delimiter-face ((t (:italic t))))
;;   (font-lock-doc-face ((t (:italic t))))
;;   :init
;;   (load-theme 'plan9 t))

;; ;; Easy on eye themes
(use-package zenburn-theme
  :ensure t
  :custom-face
  (window-divider ((nil :foreground "#3f3f3f")))
  (auto-dim-other-buffers-face ((nil :background "#2e302e"
				     :foreground "#C0C0B0")))
  (fringe ((nil :background nil)))
  (font-lock-comment-face ((t (:italic t))))
  (font-lock-comment-delimiter-face ((t (:italic t))))
  (font-lock-doc-face ((t (:italic t))))
  :init
  (setq zenburn-scale-org-headlines t)
  (setq zenburn-scale-outline-headlines t)
  (load-theme 'zenburn t))

;; Skip startup screen and set scratch message to empty.
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; Silent bell
(setq ring-bell-function 'ignore)

;; Hide menu bar, tool bar and minibuffer scrollbar
(menu-bar-mode -1)

;; Hide tool bar.
(tool-bar-mode -1)

;; Hide scroll bar.
(scroll-bar-mode -1)

;; Show matched paren
(show-paren-mode 1)

;; Stop cursor blinking
(blink-cursor-mode -1)

;; Highlight current line in prog-mode
(add-hook 'prog-mode-hook 'hl-line-mode)

;; Transparent setup
(set-frame-parameter (selected-frame) 'alpha '(88 . 88))
(add-to-list 'default-frame-alist '(alpha . (88 . 88)))

;; Internal border
(add-to-list 'default-frame-alist '(internal-border-width . 30))

;; Default to vertical split
(setq split-height-threshold nil)
(setq split-width-threshold 120)



;;; Better Defaults

(bind-key "M-RET" 'make-frame)

;; Enable narrow to page
(put 'narrow-to-page 'disabled nil)

;; Always use dir-locals
(defun safe-local-variable-p (sym val) t)

;; IMenu auto rescan
(setq imenu-auto-rescan t)

;; ESC to quit minibuffer
(define-key minibuffer-local-map (kbd "<escape>") 'minibuffer-keyboard-quit)

;; C-= to align with regexp
(bind-key "C-=" 'align-regexp)

;; Easy keybinding for register
(bind-key "C-r" 'point-to-register)
(bind-key "C-j" 'jump-to-register)

;; M-h switch to last buffer
(bind-key "M-h" 'mode-line-other-buffer)

;; C-h C-b ibuffer
(bind-key "C-h C-b" 'ibuffer)

;; Auto delete selection when insert on region.
(delete-selection-mode t)

(bind-key "<escape>" 'keyboard-escape-quit)

;; Custom file path
;; Actually we don't need custom file, this file can be generated
;; accidentally, so we add this file to .gitignore and never load it.
(setq custom-file "~/.emacs.d/custom.el")

;; No lockfiles
(setq create-lockfiles nil)

;; Larger GC threshold
(setq gc-cons-threshold 35000)

;; UTF8
(prefer-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8-unix
      default-file-name-coding-system 'utf-8-unix
      default-keyboard-coding-system 'utf-8-unix
      default-process-coding-system '(utf-8-unix . utf-8-unix)
      default-sendmail-coding-system 'utf-8-unix
      default-terminal-coding-system 'utf-8-unix)

;; Delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Always have a newline at end of file
(setq require-final-newline t)

;; backup and auto-save settings
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq backup-by-copying t)

(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Use y-or-n instead of yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;; Auto revert file when file is modified somewhere
(global-auto-revert-mode 1)

;; Mouse yank at point instead of click position.
(setq mouse-yank-at-point t)

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)



;;; Plugins for editor basics

(use-package anzu
  :ensure t
  :bind
  (("C-*" . anzu-query-replace-at-cursor)
   ("C-&" . anzu-query-replace-regexp))
  :init
  (global-anzu-mode 1)
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))

(use-package flycheck
  :ensure t
  :init
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

(use-package easy-kill
  :ensure t
  :defer t
  :commands (easy-kill)
  :bind
  (("M-w" . easy-kill)))

(use-package ace-window
  :ensure t
  :defer t
  :commands (ace-window)
  :bind
  (("C-h C-h" . ace-window))
  :init
  (setq aw-ignore-on t)
  (setq aw-scope 'frame)
  (setq aw-ignored-buffers '(treemacs-mode neotree-mode))
  (setq aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n)))

(use-package winner
  :ensure t
  :bind
  (("C-h u" . winner-undo))
  :init
  (winner-mode 1))

(global-unset-key (kbd "C-z"))

(use-package ztree
  :ensure t
  :bind
  (("C-h z" . ztree-dir)))

(use-package projectile
  :ensure t
  :bind
  (("C-z f" . projectile-find-file)
   ("C-z d" . projectile-dired)
   ("C-z k" . projectile-kill-buffers)
   ("C-z g" . projectile-grep)
   ("C-z b" . projectile-switch-to-buffer)
   ("C-z q" . projectile-switch-project)
   ("C-z c" . projectile-commander))
  :init
  (projectile-global-mode 1))

(use-package highlight-parentheses
  :ensure t
  :init
  (global-highlight-parentheses-mode nil))

(use-package highlight-symbol
  :ensure t
  :bind
  (("M-p" . highlight-symbol-prev)
   ("M-n" . highlight-symbol-next))
  :custom-face
  (highlight-symbol-face ((t (:underline t))))
  :init
  (add-hook 'prog-mode-hook #'highlight-symbol-mode))

(use-package ag
  :ensure t
  :bind
  (("C-c j" . ag)))

(use-package wgrep
  :ensure t
  :bind
  (:map wgrep-mode-map
	("C-c C-c" . wgrep-finish-edit)
	("C-c ESC" . wgrep-abort-changes))
  :init
  (setq wgrep-enable-key (kbd "C-c C-c"))
  (setq wgrep-auto-save-buffer t))

(use-package wgrep-ag
  :ensure t
  :init
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup))

(use-package counsel
  :ensure t)

(use-package counsel-projectile
  :ensure t
  :bind
  (("C-z a" . counsel-projectile-ag))
  :init
  (setq projectile-completion-system 'ivy))

(use-package ivy
  :ensure t
  :bind
  (("C-c g" . counsel-git)
   ("C-c G" . counsel-git-grep)
   ("C-s" . swiper)
   ("C-h m" . counsel-imenu)
   ("C-c A" . counsel-ag)
   ("M-x" . counsel-M-x)
   ("<C-escape>" . ivy-resume)
   :map ivy-minibuffer-map
   ("<tab>" . ivy-alt-done)
   ("<S-return>" . ivy-immediate-done)
   ("<escape>" . minibuffer-keyboard-quit)
   ("C-r" . counsel-expression-history))
  :init
  (setq ivy-use-virtual-buffers nil)
  (setq ivy-use-selectable-prompt t)
  (ivy-mode 1))

;; (use-package ivy-posframe
;;   :ensure t
;;   :init
;;   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;;   (ivy-posframe-mode 1))

(use-package avy
  :init
  (setq avy-keys (list ?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  (setq avy-all-windows nil)
  :bind
  (("M-c" . avy-goto-word-or-subword-1)
   ("M-l" . avy-goto-line)))

(defun user/haskell-indent-or-complete ()
  (interactive)
  (if (member (char-before) '(32 10))
      (call-interactively #'shm/tab)
    (call-interactively #'company-complete-common)))

(use-package company
  :bind
  (:map prog-mode-map
   ("<tab>" . company-indent-or-complete-common)
   :map company-active-map
   ("<escape>" . company-abort))
  :init
  (setq company-idle-delay nil)
  (setq company-minimum-prefix-length 3)
  (global-company-mode t))

(use-package yasnippet
  :ensure t
  :bind
  (("C-h y" . yas-expand)
   :map yas/keymap
   ("<tab>" . yas-next-field-or-maybe-expand))
  :init
  :config
  (use-package yasnippet-snippets
    :ensure t))

(use-package expand-region
  :ensure t
  :bind
  (("C-+" . er/expand-region)))

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-M-." . mc/mark-next-like-this)
   ("C-M-," . mc/skip-to-next-like-this)
   ("C-M-:" . mc/mark-all-in-region-regexp)
   :map mc/keymap
   ("<escape>" . mc/keyboard-quit))
  :init
  (setq mc/always-run-for-all t)
  (multiple-cursors-mode 1))

(use-package magit
  :ensure t
  :bind
  (("C-h g" . magit-status))
  :init
  (global-magit-file-mode t)
  (setq magit-completing-read-function 'ivy-completing-read))

(use-package diff-hl
  :ensure t
  :init
  (global-diff-hl-mode t)
  (diff-hl-dired-mode t))

(use-package form-feed
  :ensure t
  :custom-face
  (form-feed-line ((t (:strike-through "#40883F"))))
  :init
  (add-hook 'prog-mode-hook #'form-feed-mode)
  :config
  (set-face-attribute 'form-feed-line nil :strike-through "#40883F"))

;;; Java

(use-package autodisass-java-bytecode
  :ensure t
  :defer t)

(use-package google-c-style
  :defer t
  :ensure t
  :commands
  (google-set-c-style))

(use-package smartparens :ensure t)

(use-package meghanada
  :ensure t
  :defer t
  :init
  (add-hook 'java-mode-hook
            (lambda ()
              (google-set-c-style)
              (google-make-newline-indent)
              (flycheck-mode t)
              (meghanada-mode t)
              (smartparens-mode t)
              (sp-local-pair 'java-mode "<" ">")
              (setq-local whitespace-line-column 100)
              (setq c-basic-offset 4)
              (setq tab-width 4)))
  :config
  (use-package realgud
    :ensure t)
  (setq meghanada-server-remote-debug t)
  (setq meghanada-javac-xlint "-Xlint:all,-processing")
  :bind
  (:map meghanada-mode-map
        ("TAB" . company-indent-or-complete-common)
        ("C-S-t" . meghanada-switch-testcase)
        ("M-RET" . meghanada-local-variable)
        ("M-r" . meghanada-reference)
        ("M-t" . meghanada-typeinfo))
  :commands
  (meghanada-mode))

(defun user/singlequote ()
  "If behind a singlequote, convert it to a pair of doublequote.
Otherwise will insert a singlequote."
  (interactive)
  (if (equal (char-before) 39)
      (progn
	(save-mark-and-excursion
	  (backward-delete-char 1)
	  (insert "\""))
	(insert "\""))
    (insert "'")))

(bind-key "'" #'user/singlequote)



;;; JavaScript

(use-package rjsx-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode)))

(use-package tide
  :ensure t
  :init
  (add-hook 'rjsx-mode-hook #'setup-tide-mode)
  (add-hook 'rjsx-mode-hook #'smartparens-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq-local flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-local js2-basic-offset 2)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'typescript-mode-hook #'setup-tide-mode)



;;; Clojure

(defun user/lisp-semicolon ()
  "Will insert a semicolon if we are at the beginning of the line,
otherwise will insert a colon."
  (interactive)
  (if (or (nth 3 (syntax-ppss))
	  (nth 4 (syntax-ppss))
	  (equal (point) (line-beginning-position)))
      (call-interactively 'paredit-semicolon)
    (insert ":")))



(defun user/paredit-delete ()
  (interactive)
  (if (region-active-p)
      (call-interactively 'delete-region)
    (call-interactively 'paredit-backward-delete)))

(use-package paredit
  :ensure t
  :bind
  (:map paredit-mode-map
	(";" . user/lisp-semicolon)
	("DEL" . user/paredit-delete)
	("M-(" . corral-parentheses-backward)
	("M-)" . corral-parentheses-forward)
	("M-[" . corral-brackets-backward)
	("M-]" . corral-brackets-forward)
	("M-{" . corral-braces-backward)
	("M-}" . corral-braces-forward)
	("M-\"" . corral-double-quotes-backward))
  :config
  (unbind-key "C-j" paredit-mode-map)
  :init
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))


(use-package corral
  :ensure t
  :bind
  (("M-(" . corral-parentheses-backward)
   ("M-)" . corral-parentheses-forward)
   ("M-[" . corral-brackets-backward)
   ("M-]" . corral-brackets-forward)
   ("M-{" . corral-braces-backward)
   ("M-}" . corral-braces-forward)
   ("M-\"" . corral-double-quotes-backward))
  :init
  (setq corral-syntax-entries '((?# "_")
				(?* "_")
				(?- "w"))))

(use-package clojure-mode
  :ensure t
  :config
  (require 'flycheck-clj-kondo)
  (define-clojure-indent
    (are '(1))
    (car/wcar '(1))
    (defui  '(1 :form :defn))
    (assoc  '(1))
    (match  '(1))
    (mlet   :defn))
  :init
  (remove-hook 'post-self-insert-hook 'blink-paren-post-self-insert-function)
  (setq clojure-toplevel-inside-comment-form nil)
  (setq cider-overlays-use-font-lock nil)
  (setq cider-repl-display-help-banner nil)
  (setq cider-repl-history-maximum-display-length 100000)
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'flycheck-mode)
  :config
  (unbind-key "C-:" clojure-mode-map))

(use-package flycheck-clj-kondo
  :ensure t)

(use-package inf-clojure
  :ensure t)

(use-package clj-refactor
  :ensure t
  :init
  (setq cljr-warn-on-eval t)
  (setq cljr-suppress-middleware-warnings t)
  (cljr-add-keybindings-with-prefix "C-,")
  (add-hook 'clojure-mode-hook #'clj-refactor-mode))

(defun user/cider-eval ()
  "Workaround for bug of `clojure-toplevel-inside-comment-form'."
  (interactive)
  (let ((clojure-toplevel-inside-comment-form t))
    (call-interactively 'cider-eval-defun-at-point)))

(use-package cider
  :ensure t
  :pin melpa
  :bind
  (:map cider-mode-map
        ("C-c <tab>" . cider-inspect-last-result)
        ("C-c C-s" . cider-browse-spec)
	("C-c n" . cider-find-ns)
        :map cider-repl-mode-map
        ("<tab>" . company-complete-common))
  :init
  (setq-default bidi-display-reordering nil)
  (setq cider-prompt-for-symbol nil)
  (setq cider-use-overlays t)
  (setq cider-font-lock-reader-conditionals nil)
  (setq cider-use-fringe-indicators t)
  (setq cider-lein-command "/usr/bin/lein")
  (setq nrepl-use-ssh-fallback-for-remote-hosts nil))



;;; Haskell

(use-package haskell-mode
  :ensure t
  :bind
  (:map haskell-mode-map
	("C-c C-k" . haskell-process-load-file)
        ("C-c C-z" . haskell-interactive-bring))
  :init
  (add-hook 'haskell-mode-hook 'company-mode))

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode))



;;; Rust

(use-package rust-mode
  :bind
  (:map rust-mode-map
	("C-c SPC" . rust-format-buffer))
  :ensure t
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (add-hook 'rust-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook 'flycheck-mode))

(use-package flycheck-rust
  :ensure t)

(use-package racer
  :ensure t)

(use-package cargo
  :ensure t
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode))



;;; Markdown

(use-package markdown-mode
  :ensure t
  :init
  (setq markdown-command "pandoc")
  (setq markdown-fontify-code-blocks-natively t))



;;; HTML

(use-package emmet-mode
  :ensure t
  :bind
  (:map html-mode-map
	("M-h" . emmet-expand-line))
  :init
  (add-hook 'html-mode-hook #'emmet-mode))



;;; C

(add-hook 'c-mode-hook #'smartparens-mode)



;;; Python

(use-package elpy
  :ensure t
  :init
  (add-hook 'python-mode-hook #'elpy-mode))



;;; SQL

(defun user/uppercase-sql-keyword ()
  (let ((init-pos (point)))
    (when (member (char-before)
		  '(41 40 44 59 32 10))
      (save-mark-and-excursion
	(backward-word)
	(if (and (not (nth 3 (syntax-ppss)))
		 (not (nth 4 (syntax-ppss)))
		 (not (let ((face-or-faces (get-text-property (point) 'face)))
			(if (listp face-or-faces)
			    (or (member 'font-lock-constant-face face-or-faces)
				(member 'font-lock-variable-name-face face-or-faces))
			  (or (eq 'font-lock-constant-face face-or-faces)
			      (eq 'font-lock-variable-name-face face-or-faces))))))
	    (when (<= (save-mark-and-excursion
			(forward-word 1)
			(point))
		      init-pos)
	      (upcase-word 1)))))))

(defun user/enable-sql-auto-uppercase-keyword ()
  (interactive)
  (add-hook 'post-self-insert-hook #'user/uppercase-sql-keyword t t)
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?- "w"))

(add-hook 'sql-mode-hook #'user/enable-sql-auto-uppercase-keyword)

;;; Add keywords for sql fontlock
(font-lock-add-keywords
 'sql-mode
 '(;; For Postgres
   ("\"[-a-zA-Z0-9_]+\"" . font-lock-constant-face)
   ;; For MySQL
   ("`[-a-zA-z0-9_]+`" . font-lock-constant-face)
   ;; For placeholder
   (":[-a-zA-Z0-9_]+" . font-lock-variable-name-face)))



;;; Org

(setq org-src-fontify-natively t)
(setq org-hide-leading-stars t)
(setq org-adapt-indentation nil)
(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(add-hook 'org-mode-hook 'org-indent-mode)




;;; Patching

(defun user/clojure-repl-type ()
  (cond
   ((equal major-mode 'clojure-mode) 'clj)
   ((equal major-mode 'clojurescript-mode) 'cljs)))

(defun sesman-current-session (system &optional cxt-types)
  (let ((sessions (or (sesman--linked-sessions system 'sort cxt-types)
		      (sesman--friendly-sessions system 'sort))))
    (if-let ((repl-type (user/clojure-repl-type)))
	(car (--filter (equal repl-type (cider-repl-type (cadr it))) sessions))
      (car sessions))))
