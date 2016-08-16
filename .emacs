(require 'package)
(add-to-list 'package-archives
	     '("melpa-cn" . "http://elpa.codefalling.com/melpa/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))
(require 'use-package)

(setq use-package-always-defer t
      use-package-always-ensure t)

;; =============================================================================
;; Basic configurations.
(set-face-attribute 'default nil
		    :family "Fira Code"
		    :height 130
		    :weight 'regular)

;; (fringe-mode '(0 . 0))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)

(setq inhibit-startup-screen t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq-default line-spacing 5)

(prefer-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'utf-8-unix)
(setq default-keyboard-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(setq default-sendmail-coding-system 'utf-8-unix)
(setq default-terminal-coding-system 'utf-8-unix)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (linum-mode t)))

(when window-system
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)

  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (setq ring-bell-function 'ignore))

(hl-line-mode)
(show-paren-mode t)

(set-frame-parameter (selected-frame) 'alpha '(100 . 95))
(add-to-list 'default-frame-alist '(alpha . (100 . 95)))

(defun recent-buffer ()
  "Switch to other buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))

;; =============================================================================
;; Eshell
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

;; =============================================================================
;; Ido
(defun ido-define-keys ()
  (bind-key "C-n" 'ido-next-match ido-completion-map)
  (bind-key "C-p" 'ido-prev-match ido-completion-map))

(use-package ido
  :ensure t
  :bind
  (("<escape>" . keyboard-escape-quit))
  :init
  (progn
    (ido-mode t)
    (add-hook 'ido-setup-hook 'ido-define-keys)
    (add-to-list 'ido-ignore-buffers
		 "*nrepl-messages .+*")))

;; =============================================================================
;; Sublimity
(use-package sublimity
  :init
  (progn
    ;; (setq sublimity-attractive-centering-width 100)
    ;; (require 'sublimity-attractive)
    ;; (sublimity-mode 1)
    ))

(use-package smooth-scrolling
  :init
  (setq smooth-scroll-margin 5))

;; =============================================================================
;; Smex
(use-package smex
  :ensure t
  :bind
  (("M-x" . smex)))

;; =============================================================================
;; Projectile
(use-package projectile
  :ensure t
  :init
  (progn
    (setq projectile-file-exists-remote-cache-expire nil)
    (setq projectile-mode-line "")
    (projectile-global-mode 1)))

(use-package helm-projectile
  :ensure t)

(add-hook 'find-file-hook
          (lambda ()
            (if (locate-dominating-file default-directory ".git")
                (projectile-mode))))

(eval-after-load "projectile"
  '(progn
     (defvar-local bk/projectile-project-name-cache nil
       "Cached value of projectile-project-name")
     (defadvice projectile-project-name (around bk/projectile-project-name activate)
       (if (not bk/projectile-project-name-cache)
           (setq bk/projectile-project-name-cache ad-do-it))
       (setq ad-return-value bk/projectile-project-name-cache))))

;; =============================================================================
;; Eldoc
(use-package eldoc
  :ensure t
  :init
  (progn
    (add-hook 'clojure-mode-hook #'eldoc-mode)
    (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)))

;; =============================================================================
;; Company
(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))

(use-package company
  :ensure t
  :bind
  (:map prog-mode-map
	("<tab>" . indent-or-complete)
   :map company-active-map
   ("<escape>" . company-abort)
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous))
  :init
  (progn
    (setq company-idle-delay nil)
    (global-company-mode)))

;; =============================================================================
;; Rainbow Delimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)))

;; =============================================================================
;; Highlight Parentheses
(use-package highlight-parentheses
  :ensure t
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
    (add-hook 'clojure-mode-hook 'highlight-parentheses-mode)))

;; =============================================================================
;; Highlight Symbol
(use-package highlight-symbol
  :ensure t
  :init
  (progn
    (add-hook 'prog-mode-hook
	      (lambda ()
		(highlight-symbol-mode)
		(highlight-symbol-nav-mode)))
    (setq highlight-symbol-idle-delay 0.25)))

;; =============================================================================
;; Exec Path From Shell
(use-package exec-path-from-shell
  :ensure t
  :init
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;; =============================================================================
;; Avy
(use-package avy
  :ensure t
  :bind
  (("M-SPC" . avy-goto-word-or-subword-1)))

;; =============================================================================
;; Lispy
(defun enable-lispy ()
  (eldoc-add-command-completions "lispy-")
  (lispy-mode 1)
  (unbind-key "M-n" lispy-mode-map)
  (unbind-key "<spc>" lispy-mode-map))

(defun lispy-escape ()
  "escape form by ESC"
  (interactive)
  (if (region-active-p)
      (keyboard-escape-quit)
    (beginning-of-defun)))

(defun lispy-beginning-of-buffer ()
  (interactive)
  (progn
    (beginning-of-buffer)
    (call-interactively 'lispy-forward)
    (call-interactively 'lispy-backward)))

(defun lispy-end-of-buffer ()
  (interactive)
  (progn
    (end-of-buffer)
    (lispy-escape)
    (special-lispy-view)))

(defun lispy-escape-or-quit-mc ()
  (interactive)
  (if (bound-and-true-p multiple-cursors-mode)
      (call-interactively 'mc/keyboard-quit)
    (call-interactively 'lispy-escape)))

(defun lispy-align ()
  (interactive)
  (if (or (lispy-left-p)
	  (lispy-right-p))
      (call-interactively 'clojure-align)
    (call-interactively 'self-insert-command)))

(use-package multiple-cursors
  :bind
  (:map mc/keymap
	("<backspace>" . backward-delete-char-untabify))
  :init
  (progn
    (setq mc/always-run-for-all t)))

(use-package lispy
  :ensure t
  :bind
  (:map lispy-mode-map
	("<escape>" . lispy-escape-or-quit-mc)
	("s-v" . lispy-yank)
	("A" . lispy-align)
	("s-," . lispy-beginning-of-buffer)
	("s-." . lispy-end-of-buffer)
	("M-[" . lispy-left)
	("M-]" . lispy-right)
	("C-j" . indent-new-comment-line))
  :init
  (progn
    (setq lispy-no-space t)
    (setq mc/always-run-for-all t)
    (add-hook 'cider-repl-mode-hook 'enable-lispy)
    (add-hook 'emacs-lisp-mode-hook 'enable-lispy)
    (add-hook 'clojure-mode-hook 'enable-lispy)))

(use-package windmove
  :ensure t)

;; =============================================================================
;; Hydra
(use-package hydra
  :ensure t)

(defhydra hydra-window ()
  "window"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out")
  ("h" windmove-left)
  ("l" windmove-right)
  ("k" windmove-up)
  ("j" windmove-down)
  ("w" delete-window)
  ("o" delete-other-windows)
  ("SPC" ace-window)
  ("v" split-window-right)
  ("s" split-window-below)
  ("e" eshell)
  ("z" ace-swap-window)
  ("i" ace-maximize-window)
  ("b" ido-switch-buffer)
  ("t" projectile-find-file)
  ("q" nil "quit"))

;; =============================================================================
;; Theme
;; (use-package spacemacs-theme
;;   :init
;;   (load-theme 'spacemacs-light t))

;; (use-package solarized-theme
;;   :init
;;   (progn
;;     (setq solarized-use-less-bold t)
;;     (load-theme 'solarized-dark t)))

;; (use-package color-theme-sanityinc-solarized
;;   :init
;;   (load-theme 'sanityinc-solarized-dark t))

(use-package color-theme-sanityinc-tomorrow
  :init
  (load-theme 'sanityinc-tomorrow-night t))

;; =============================================================================
;; Clojure

(defun clojure-mode-init ()
  (subword-mode 1)
  (yas-minor-mode 1))

(add-hook 'clojure-mode-hook #'clojure-mode-init)
(add-hook 'clojure-mode-hook #'eldoc-mode)

(use-package clj-refactor
  :ensure t
  :bind
  (:map clojure-mode-map
	("s-R" . hydra-cljr-help-menu/body))
  :init
  (progn
    (add-hook 'clojure-mode-hook 'clj-refactor-mode))
  :config
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(defun lispy-cider-eval ()
  (interactive)
  (cond
   ((lispy-left-p)
    (progn (call-interactively 'special-lispy-different)
	   (call-interactively 'cider-eval-last-sexp)
	   (call-interactively 'special-lispy-different)))
   ((lispy-right-p)
    (call-interactively 'cider-eval-last-sexp))
   (t (call-interactively 'self-insert-command))))

(use-package cider
  :ensure t
  :bind
  (:map cider-mode-map
	("e" . lispy-cider-eval)
	("s-l" . cider-load-buffer)
	("s-n" . cider-repl-set-ns)
	("s-q" . cider-quit)
	("s-e" . cider-eval-defun-at-point)
	("s-<return>" . cider-eval-defun-at-point))
  :config
  (setq-local lispy-eval-display-style 'overlay)
  :init
  (progn
    (setq cider-repl-display-help-banner nil)
    (setq cider-lein-command "/usr/local/bin/lein")
    ;; (setq cider-lein-parameters "with-profile +dirac repl :headless")
    (setq cider-cljs-lein-repl "(in-ns 'boot.user) (start-repl)")))

;; =============================================================================
;; Emmet

(defun hiccup-emmet-expand-line ()
  (interactive)
  (insert "|hic")
  (call-interactively 'emmet-expand-line))

(defun clojure-emmet-init ()
  (emmet-mode t)
  (bind-key "s-e" 'hiccup-emmet-expand-line))

(defun html-emmet-init ()
  (emmet-mode t)
  (bind-key "s-e" 'emmet-expand-line))

(use-package emmet-mode
  :ensure t
  :init
  (progn
    (add-hook 'html-mode-hook #'html-emmet-init)
    (add-hook 'clojure-mode-hook #'clojure-emmet-init)))

;; =============================================================================
(use-package neotree
  :init
  (progn
    (setq neo-smart-open t)
    (setq projectile-switch-project-action 'neotree-projectile-action)
    (setq neo-theme 'nerd))
  :bind
  ("s-T" . neotree-projectile-action))

;; =============================================================================
;; Undo-tree
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode t))

;; ============================================================================
;; Org-mode setup
(setq org-src-fontify-natively t)
(add-hook 'org-mode-hook
	  (lambda ()
	    (org-indent-mode 1)
	    (face-remap-add-relative 'default :family "Source Han Sans HW"
				     :height 140)))

;; =============================================================================
;; Dired
(defun dired-mode-init ()
  (progn
    (put 'dired-find-alternate-file 'disabled nil)
    (bind-key "<Return>" 'find-alternate-file dired-mode-map)
    (bind-key "b" (lambda ()
		    (interactive)
		    (find-alternate-file "..") dired-mode-map))))

(add-hook 'dired-mode-hook #'dired-mode-init)

;; =============================================================================
;; Ag
(use-package helm-ag)

;; =============================================================================
;; Keybindings

(bind-key "s-;" 'other-window)
(bind-key "s-o" 'ido-find-file)
(bind-key "s-O" 'ido-find-file-read-only)
(bind-key "s-p" 'hydra-window/body)
(bind-key "s-w" 'kill-buffer)
(bind-key "s-R" 'highlight-symbol-query-replace)
(bind-key "s-f" 'swiper)
(bind-key "s-k" 'scroll-down-command)
(bind-key "s-j" 'scroll-up-command)
(bind-key "s-t" 'projectile-find-file-dwim)
(bind-key "s-P" 'projectile-switch-project)
(bind-key "s-1" 'delete-other-windows)
(bind-key "s-0" 'delete-window)
(bind-key "s-z" 'undo-tree-undo)
(bind-key "s-Z" 'undo-tree-redo)
(bind-key "s-d" 'ido-dired)
(bind-key "s-a" 'helm-projectile-ag)
(bind-key "s-b" 'ido-switch-buffer)
(bind-key "s-." 'end-of-buffer)
(bind-key "s-," 'beginning-of-buffer)
(bind-key "s-B" 'ido-switch-buffer-other-window)
(bind-key "s-\\" 'recent-buffer)
(bind-key "s-r" 'highlight-symbol-query-replace)
(bind-key "s-g" 'goto-line)
(bind-key "s-6" 'delete-indentation)
(bind-key "s-/" 'pop-global-mark)
(bind-key "s-m" 'set-mark-command)
(bind-key "s-x" 'kill-region)
(bind-key "s-c" 'kill-ring-save)
(bind-key "s-i" 'quoted-insert)

;; =============================================================================

(server-start)
(toggle-frame-maximized)


