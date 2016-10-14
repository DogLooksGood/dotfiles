;; Minimal setup for Clojure development & Org document.

(require 'package)
(setq package-enable-at-startup nil)


(setq package-archives
      '(("gnu-cn" . "http://elpa.zilongshanren.com/gnu/")
        ("melpa-cn" . "http://elpa.zilongshanren.com/melpa/")
        ("melpa-stable-cn" . "	http://elpa.zilongshanren.com/melpa-stable/")
        ("marmalade-cn" . "http://elpa.zilongshanren.com/marmalade/")
        ("org-cn" . "	http://elpa.zilongshanren.com/org/")))
(package-initialize)

;; -----------------------------------------------------------------------------
;; Use Package
;; -----------------------------------------------------------------------------

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t
      use-package-always-defer t)
(require 'use-package)

;; -----------------------------------------------------------------------------
;; Basics
;; -----------------------------------------------------------------------------

(blink-cursor-mode 0)
(setq cursor-in-non-selected-windows nil)
(setq mac-option-modifier 'meta)
(setq frame-title-format "emacs")
(setq column-number-mode t)
(setq-default line-spacing 2)
(setq-default indent-tabs-mode nil)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(unless window-system
  (menu-bar-mode -1))
(scroll-bar-mode -1)
(global-auto-revert-mode 5)
(setq-default indicate-empty-lines t)
(add-hook 'prog-mode-hook #'linum-mode)
(use-package ediff
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

(setq speedbar-tag-hierarchy-method nil)

;; --- Scroll ------------------------------------------------------------------
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't)

;; --- Encoding ----------------------------------------------------------------
(prefer-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8-unix
      default-file-name-coding-system 'utf-8-unix
      default-keyboard-coding-system 'utf-8-unix
      default-process-coding-system '(utf-8-unix . utf-8-unix)
      default-sendmail-coding-system 'utf-8-unix
      default-terminal-coding-system 'utf-8-unix)

;; --- Plugins -----------------------------------------------------------------

(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :init
    (exec-path-from-shell-initialize)))

(use-package counsel
  :bind
  (("C-c g" . counsel-git)
   ("C-c G" . counsel-git-grep)
   ("C-c s" . swiper)
   ("C-c m" . counsel-imenu)
   ("C-c A" . counsel-ag)))

(use-package counsel-projectile
  :init
  (counsel-projectile-on))

(use-package ivy
  :init
  (ivy-mode 1))

(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-\\" . mc/skip-to-next-like-this)
   ("C-<" . mc/mark-previous-like-this))
  :init
  (setq mc/always-run-for-all t))

(use-package highlight-symbol
  :bind
  (("M-p" . highlight-symbol-prev)
   ("M-n" . highlight-symbol-next))
  :init
  (add-hook 'prog-mode-hook #'highlight-symbol-mode))

(use-package projectile
  :defer nil
  :init
  (projectile-global-mode 1))

(use-package company
  :bind
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous))

  :init
  (add-hook 'eshell-mode-hook
            (lambda ()
              (bind-key "<tab>" 'company-complete-common eshell-mode-map)
              (bind-key "TAB" 'company-complete-common eshell-mode-map)))
  (add-hook 'clojure-mode-hook
            (lambda ()
              (bind-key "<tab>" 'company-indent-or-complete-common clojure-mode-map)
              (bind-key "TAB" 'company-indent-or-complete-common clojure-mode-map)))
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (bind-key "<tab>" 'company-indent-or-complete-common emacs-lisp-mode-map)
              (bind-key "TAB" 'company-indent-or-complete-common emacs-lisp-mode-map)))
  (setq company-idle-delay nil)
  (global-company-mode))

;; -----------------------------------------------------------------------------
;; Lisp
;; -----------------------------------------------------------------------------

(show-paren-mode t)

(use-package lispy
  :init
  (setq lispy-eval-display-style 'overlay))

(use-package rainbow-delimiters)

;; (use-package parinfer
;;   :bind
;;   (:map parinfer-mode-map
;;         ("<tab>" . parinfer-smart-tab:dwim-right)
;;         ("S-<tab>" . parinfer-smart-tab:dwim-left)
;;         ("C-," . parinfer-toggle-mode)
;;    :map parinfer-region-mode-map
;;         ("<tab>" . parinfer-smart-tab:dwim-right)
;;         ("S-<tab>" . parinfer-smart-tab:dwim-left))
;;   :init
;;   (setq parinfer-lighters '(" PI:->" . " PI:()"))
;;   (setq parinfer-extensions '(company pretty-parens smart-tab smart-yank))
;;   (add-hook 'emacs-lisp-mode-hook 'parinfer-mode)
;;   (add-hook 'clojure-mode-hook 'parinfer-mode))

;; -----------------------------------------------------------------------------
;; Clojure
;; -----------------------------------------------------------------------------

(use-package clojure-mode
  :init
  (add-hook 'clojure-mode-hook #'eldoc-mode))

;; -----------------------------------------------------------------------------
;; Cider
;; -----------------------------------------------------------------------------

(use-package cider
  :init
  (setq cider-lein-command "/usr/local/bin/lein")
  (setq cider-boot-command "/usr/local/bin/boot")
  (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")
  (setq cider-use-overlays t))

;; -----------------------------------------------------------------------------
;; Clj Refactor
;; -----------------------------------------------------------------------------

(use-package yasnippet
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (unbind-key "<tab>" yas-minor-mode-map))

(use-package clj-refactor
  :init
  (cljr-add-keybindings-with-prefix "C-,")
  (add-hook 'clojure-mode-hook #'clj-refactor-mode)
  (add-hook 'clojure-mode-hook #'yas-minor-mode))

;; -----------------------------------------------------------------------------
;; Org
;; -----------------------------------------------------------------------------

(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package org
  :init
  (setq org-src-fontify-natively t)
  (add-hook 'org-mode-hook
      (lambda ()
        (setq org-src-ask-before-returning-to-edit-buffer nil)
        (org-indent-mode 1))))

(use-package org-plus-contrib)

;; -----------------------------------------------------------------------------

(use-package emmet-mode
  :init
  (add-hook 'html-mode-hook 'emmet-mode))
  
;; -----------------------------------------------------------------------------
;; Magit
;; -----------------------------------------------------------------------------

(use-package magit
  :bind
  (("C-x M-g" . magit-dispatch-popup))
  :init
  (global-magit-file-mode t))

;; -----------------------------------------------------------------------------
;; User Customize
;; -----------------------------------------------------------------------------

(add-hook 'org-mode-hook
          (lambda ()
            (face-remap-add-relative 'default :family "Source Han Sans HW")))  

(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 150
                    :weight 'regular)
                   
;; (if window-system
;;     (use-package solarized-theme
;;       :init
;;       (set-frame-parameter (selected-frame) 'alpha '(95 95))
;;       (add-to-list 'default-frame-alist '(alpha 95 95))
;;       (setq solarized-use-less-bold t)
;;       (setq solarized-high-contrast-mode-line t)
;;       (load-theme 'solarized-light t))) 

(add-to-list 'load-path "~/Git/parinfer-mode")

(require 'parinfer)
(setq parinfer-extensions
      '(defaults pretty-parens smart-tab smart-yank))
(add-hook 'emacs-lisp-mode-hook 'parinfer-mode)
(add-hook 'clojure-mode-hook 'parinfer-mode)
(setq parinfer-auto-switch-indent-mode t)
(setq parinfer-lighters '(" PI:->" . " PI:()"))
(bind-key "C-'" 'parinfer-toggle-mode parinfer-mode-map)

(use-package circe
  :init
  (setq circe-network-options
        '(("Freenode"
           :tls t
           :nick "DogLooksGood"
           :sasl-username "DogLooksGood"
           :sasl-password "s1t2s3d4d5"
           :channels ("#clojure" "#emacs")))))

(load-theme 'niflheim t)

;; -----------------------------------------------------------------------------
;; Custom
;; -----------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (niflheim-theme flatland-black-theme use-package spacemacs-theme solarized-theme smartparens smart-mode-line rainbow-delimiters powerline paper-theme org-plus-contrib org-mime org-bullets magit lispy key-seq highlight-symbol exec-path-from-shell evil emmet-mode counsel-projectile company color-theme-sanityinc-tomorrow clj-refactor circe benchmark-init aggressive-indent))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
