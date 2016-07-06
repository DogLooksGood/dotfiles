;; Shortcuts
;; 
;; | function              | keybinding  |
;; |-----------------------+-------------|
;; | clojure refactor menu | control + . |
;; | git menu              | command + . |
;; | window operators      | control + o |
;; | swith project         | command + p |
;; | open file in project  | command + e |
;; | open file             | command + f |
;; | kill current buffer   | command + k |
;; | save current file     | command + s |
;; | swith buffer          | command + b |
;; | close other window    | command + 1 |
;; | close current window  | command + 0 |
;; | swith window          | option + TAB|

;; =============================================================================
;; Initialize
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))
(require 'use-package)

;; =============================================================================
;; Basic configurations.
(set-face-attribute 'default nil
		    :family "Source Code Pro"
		    :height 125
		    :weight 'regular)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(when window-system
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)

  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (setq ring-bell-function 'ignore))

(hl-line-mode)
(show-paren-mode t)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (linum-mode 1)))

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
  (lispy-mode 1)
  (unbind-key "M-n" lispy-mode-map))

;; Use ESC to escape from form
(defun lispy-escape ()
  (interactive)
  (if (region-active-p)
      (keyboard-escape-quit)
    (beginning-of-defun)))

(use-package lispy
  :ensure t
  :bind
  (:map lispy-mode-map
	("<escape>" . lispy-escape)
	("M-[" . lispy-left)
	("M-]" . lispy-right))
  :init
  (progn
    (setq lispy-eval-display-style 'overlay)
    (setq lispy-no-space t)
    (add-hook 'emacs-lisp-mode-hook 'enable-lispy)
    (add-hook 'clojure-mode-hook 'enable-lispy)))

;; =============================================================================
;; Ace-window
(use-package ace-window
  :ensure t
  :bind
  (("M-<tab>" . ace-window))
  :init
  (progn
    (setq aw-dispatch-always nil)))

(use-package helm-projectile
  :ensure t)

(use-package windmove
  :ensure t)

;; =============================================================================
;; Hydra
(use-package hydra
  :ensure t)

(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out"))

(defhydra hydra-window ()
  "window"
  ("h" windmove-left)
  ("l" windmove-right)
  ("k" windmove-up)
  ("j" windmove-down)
  ("x" delete-window)
  ("o" delete-other-windows)
  ("SPC" ace-window)
  ("v" split-window-right)
  ("s" split-window-below)
  ("z" ace-swap-window)
  ("i" ace-maximize-window)
  ("b" ido-switch-buffer)
  ("q" nil "quit"))

(bind-key "C-o" 'hydra-window/body)

;; =============================================================================
;; Theme
(use-package color-theme-sanityinc-solarized
  :ensure t
  :init
  (load-theme 'sanityinc-solarized-light t))

;; =============================================================================
;; Git
(use-package magit
  :ensure t
  :bind
  (("s-." . magit-dispatch-popup)))

;; =============================================================================
;; Clojure

(defun clojure-mode-init ()
  (setq clojure-defun-style-default-indent nil)
  (subword-mode 1)
  (yas-minor-mode 1)
  (eldoc-mode 1))

(add-hook 'clojure-mode-hook 'clojure-mode-init)

(use-package clj-refactor
  :ensure t
  :bind
  (:map clojure-mode-map
	("C-." . hydra-cljr-help-menu/body))
  :init
  (progn
    (add-hook 'clojure-mode-hook 'clj-refactor-mode))
  :config
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package cider
  :ensure t
  :init
  (progn
    (setq cider-lein-command "/usr/local/bin/lein")
    (setq cider-lein-parameters "with-profile +emacs repl :headless")
    (setq cider-cljs-lein-repl "(in-ns 'boot.user) (start-repl)")))

;; =============================================================================
;; Emmet
(use-package emmet-mode
  :ensure t
  :bind
  (("C-j" . emmet-expand-line)))

;; ============================================================================
;; Org-mode setup
(add-hook 'org-mode-hook
	  (lambda ()
	    (org-indent-mode 1)
	    (face-remap-add-relative 'default :family "Source Han Sans HW"
				     :height 145)))

;; =============================================================================
;; Dired
(defun dired-mode-init ()
  (progn
    (put 'dired-find-alternate-file 'disabled nil)
    (bind-key "b" (lambda () (interactive)
		    (find-alternate-file "..") dired-mode-map))))

(add-hook 'dired-mode-hook #'dired-mode-init)

;; =============================================================================
;; Keybindings
(bind-key "s-f" 'ido-find-file)
(bind-key "s-e" 'projectile-find-file)
(bind-key "s-b" 'ido-switch-buffer)
(bind-key "s-s" 'save-buffer)
(bind-key "s-p" 'projectile-switch-project)
(bind-key "s-1" 'delete-other-windows)
(bind-key "s-0" 'delete-window)
