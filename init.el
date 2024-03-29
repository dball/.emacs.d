;; Disable backup files, we have version control
(setq make-backup-files nil)
;; Disable autosave files, I'll save when I want
(setq auto-save-default nil)
;; Disable weird lock files, stop trying to make locking a thing
(setq create-lockfiles nil)
;; Always reload from disk when safe, git checkouts are a thing
(global-auto-revert-mode t)

;; Allow installation of named packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Enable paredit mode in clojure and cider
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook #'enable-paredit-mode)

;; Enable company mode in clojure and cider
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)

;; Enable eldoc mode in cider
(add-hook 'cider-mode-hook #'eldoc-mode)

;; Enable paren mode in clojure
(add-hook 'clojure-mode-hook #'show-paren-mode)

;; Dark, peaceful colors
(load-theme 'zenburn t)

;; Projectile mode for file loading?
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Wow it's annoying that a package stuffs its autogen config here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (smartparens xref-js2 js2-refactor js2-mode go-mode inf-clojure projectile zenburn-theme company paredit cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; https://emacs.cafe/emacs/javascript/setup/2017/04/23/emacs-setup-javascript.html
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)
(require 'xref-js2)
;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; smartparens-mode
;; show-smartparens-mode

(setq-default js2-basic-offset 2)
(setq-default indent-tabs-mode nil)

;; possibly this should be js-switch-indent-offset 2 ??
(setq-default js2-indent-switch-body t)
