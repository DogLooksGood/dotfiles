(require 'package)

(add-to-list 'package-archives
	     '("popkit" . "http://elpa.popkit.org/packages/"))

(package-initialize)

;; Load plugin with `use-package`
(unless (package-installed-p 'use-package)
  (progn
    ;; If there's no use-package, this should be the first launch
    ;; So, refresh the package list
    (package-refresh-contents)
    (package-install 'use-package)))
(require 'use-package)

;; =============================================================================
;; Basic configurations.
(set-face-attribute 'default nil
		    :family "Source Code Pro"
		    :height 120
		    :weight 'medium)

(add-to-list 'default-frame-alist '(alpha 92 92))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq ring-bell-function 'ignore)
(hl-line-mode)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (linum-mode 1)))

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
    (projectile-global-mode)))

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
    (add-hook 'prog-mode-hook 'eldoc-mode)))

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
;; Avy
(use-package avy
  :ensure t
  :bind
  (("M-SPC" . avy-goto-word-or-subword-1)))

;; =============================================================================
;; Lispy
(defun enable-lispy ()
  (lispy-mode 1))

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
    ;; Override lispy's M-n.
    (when (bound-and-true-p highlight-symbol-mode)
      (bind-key "M-n" 'highlight-symbol-next lispy-mode-map))
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

(defhydra hydra-navi ()
  "navi"
  ("u" undo)
  ("g" goto-line)
  ("p" projectile-switch-project)
  ("o" projectile-find-file-dwim)
  ("<" beginning-of-buffer)
  (">" end-of-buffer)
  ("a" beginning-of-line)
  ("e" end-of-line)
  ("y" kill-ring-save "yank" :color blue)
  ("d" delete-region "del" :color blue)
  ("m" set-mark-command "mark")
  ("f" forward-word)
  ("b" backward-word)
  ("l" forward-char)
  ("h" backward-char)
  ("j" next-line)
  ("k" previous-line)
  ("q" nil "quit"))

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

(bind-key "C-o" 'hydra-navi/body)
(bind-key "C-M-o" 'hydra-window/body)

;; =============================================================================
;; Theme
;; (use-package color-theme-sanityinc-solarized
;;   :ensure t
;;   :init
;;   (load-theme 'sanityinc-solarized-dark t))

;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t
;;   :init
;;   (load-theme 'sanityinc-tomorrow-blue t))

(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t))

;; =============================================================================
;; Clojure
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (dolist (c (string-to-list ":_-?!#*"))
	      (modify-syntax-entry c "w" clojure-mode-syntax-table))))

(use-package cider
  :ensure t
  :init
  (progn
    (setq cider-lein-parameters "with-profile +emacs repl :headless")
    (setq cider-cljs-lein-repl "(in-ns 'user) (cljs-repl)")
    (setq clojure-defun-style-default-indent t)
    (add-hook 'cider-repl-mode-hook (eldoc-mode 1))))

(server-start)
