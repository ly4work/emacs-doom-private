;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "LZJ"
      user-mail-address "--")

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

(setq frame-title-format '("NEO-VIM-IED-FROM-1975"))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 17))
(setq doom-font (font-spec :family "Sarasa Fixed CL" :size 20))

(defun +my/better-font()
 (interactive)
 ;; english font
 (if (display-graphic-p)
     (progn
       (set-face-attribute 'default nil :font (format "%s:pixelsize=%d" "Source Code Variable" 20)) ;; 11 13 17 19 23
       ;; chinese font
       (dolist (charset '(kana han symbol cjk-misc bopomofo))
         (Set-fontset-font (frame-parameter nil 'font)
                           charset
                           (font-spec :family "Sarasa Mono SC" 20)))) ;; 14 16 20 22 28
   ))

(defun +my|init-font(frame)
 (with-selected-frame frame
   (if (display-graphic-p)
       (+my/better-font))))

;; (if (and (fboundp 'daemonp) (daemonp))
;;    (add-hook 'after-make-frame-functions #'+my|init-font)
;;  (+my/better-font))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;
;; (load-theme 'doom-gruvbox t)

(use-package! lsp-java
  :config
  (setq lombok-jar-path (expand-file-name "~/.doom.d/myconfig/lombok.jar"))
  (setq lsp-java-vmargs `(
                          , (concat "-javaagent:" lombok-jar-path)
                          , (concat "-Xbootclasspath/a:" lombok-jar-path)
                            )))
;; to enable the lenses
;; (add-hook 'lsp-mode-hook #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

(setq lsp-enable-file-watchers nil)
(setq lsp-java-jdt-download-url "https://mirrors.tuna.tsinghua.edu.cn/eclipse/jdtls/snapshots/jdt-language-server-latest.tar.gz")
(add-hook 'java-mode-hook #'lsp)

(setq lsp-java-import-maven-enabled t)
(setq lsp-java-maven-download-sources t)
(setq lsp-java-configuration-maven-user-settings (expand-file-name "~/.m2/settings.xml"))

(global-set-key (kbd "M-i") 'lsp-goto-implementation)
(global-set-key (kbd "M-d") 'lsp-goto-type-definition)
(use-package! dap-java
  :defer 2)
(use-package! dap-mode
  :defer 2
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

;; (use-package! company-box
;;   :after company
;;   :hook (company-mode . company-box-mode))
;;(def-package! dap-mode
;;  :after java-mode
;;  :ensure t
;;  :config
;;  (dap-mode t)
;;  (dap-ui-mode t))
;; (map! :ne "SPC j" 'evil-avy-goto-char)

(map! :ne "f" 'evil-avy-goto-word-1)
(map! :ne "SPC j" 'evil-avy-goto-word-1)
(map! :ne "SPC z" 'counsel-fzf)
(map! :ne "SPC v" 'vterm)
(map! :ne "M-1" 'neotree-find)
(map! :ne "M-j" 'drag-stuff-down)
(map! :ne "M-k" 'drag-stuff-up)
(map! :ne "; w" 'save-buffer)
(map! :ne "; b" 'switch-to-buffer)
(map! :ne "; e" 'ace-window)
(map! :ne "; d" 'delete-other-windows)
(map! :ne "; f" 'neotree-find)
(map! :ne "; h" 'neotree-toggle)
;; (map! :ne "; r" 'doom/reload)
(map! :ne "; i" 'lsp-java-organize-imports)
(map! :ne "; m" 'lsp-java-add-unimplemented-methods)
(map! :ne ", f" 'lsp-format-buffer)


(map! :ne ", n" 'dap-next)
(map! :ne ", b" 'dap-breakpoint-toggle)
(map! :ne ", c" 'dap-continue)
(map! :ne ", r" 'dap-eval-region)
(map! :ne ", a" 'dap-eval-thing-at-point)
(map! :ne ", d" 'dap-debug)
(map! :ne ", u" 'dap-ui-repl)
;;
;; (global-set-key (kbd "<f7>") 'symbol-overlay-mode)

;; region forward
(defalias 'forward-evil-word 'forward-evil-symbol)

(use-package! evil-fcitx)
(use-package! ejc-sql)
(add-hook 'ejc-sql-minor-mode-hook
          (lambda ()
            (auto-complete-mode nil)))
(add-hook 'ejc-sql-connected-hook
          (lambda ()
            (ejc-set-fetch-size 50)
            (ejc-set-max-rows nil)
            (ejc-set-column-width-limit nil)
            ))
(setq ejc-result-table-impl 'ejc-result-mode)
(use-package! db)

(use-package! string-inflection)
(map! :ne "; r" 'string-inflection-java-style-cycle)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-box-scrollbar ((t (:background "#5B5B5B" :foreground "#000000"))))
 '(company-tooltip ((t (:background "#44475a" :foreground "#E1FFFF"))))
 '(company-tooltip-annotation ((t (:foreground "#FFA500"))))
 '(company-tooltip-annotation-selection ((t (:foreground "#2F4F4F"))))
 '(company-tooltip-common ((t (:foreground "#E6E6FA"))))
 '(company-tooltip-common-selection ((t (:foreground "#800000"))))
 '(company-tooltip-selection ((t (:background "#FFE66F" :foreground "#000000"))))
 '(linum ((t (:inherit (shadow default) :foreground "DimGray" :background "dark"))))
 '(linum-highlight-face ((t (:background "#282828" :foreground "#EEEE00"))))
 '(lsp-face-semhl-field ((t (:foreground "#6272a4"))))
 '(lsp-face-semhl-variable ((t (:foreground "#6272a4"))))
 '(lsp-face-semhl-variable-local ((t (:foreground "#6272a4"))))
 '(powerline-active0 ((t (:foreground "#f8f8f2"))))
 '(powerline-active1 ((t (:foreground "#FFDEAD"))))
 ;; '(doom-modeline-evil-insert-state ((t (:foreground "#B22222" :background "#FFB90F"))))
 ;; '(doom-modeline-evil-normal-state ((t (:foreground "#FFFFFF" :background "#2F4F4F"))))
 '(show-paren-match ((t (:background "#6272a4" :foreground "#00000")))))

(setq evil-emacs-state-tag "EMACS")
(setq evil-hybrid-state-tag "HYBRID")
(setq evil-insert-state-tag "INSERT")
(setq evil-lisp-state-tag "LISP")
(setq evil-motion-state-tag "MOTION")
(setq evil-normal-state-tag "NORMAL")
(setq evil-operator-state-tag "OPERATOR")
(setq evil-visual-state-tag "VISUAL")

(use-package! insert-translated-name)
(setq insert-translated-name-translate-engine "youdao")
(map! :ne "; t" 'insert-translated-name-replace-with-camel)

;; (setq counsel-fzf-dir-function 'vc-root-dir)
(setq counsel-fzf-dir-function
(lambda ()
  (let ((d (locate-dominating-file default-directory ".git")))
    (if (or (null d)
      (equal (expand-file-name d)
        (expand-file-name "~/")))
  default-directory
d))))

;; (use-package! org-bullets-mode
;;   :custom
;;   (org-ellipsis "⤵ ")
;;   :hook (org-mode . org-bullets-mode))

(setq org-export-with-sub-superscripts nil)

(setq org-hide-emphasis-markers t
      org-fontify-done-headline t
      org-hide-leading-stars t
      org-pretty-entities nil
      )
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)
;; load image in org mode
(defun org-toggle-image-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
  (iimage-mode))
(setq org-image-actual-width nil)

;; uml plantuml.jar
(setq org-plantuml-jar-path (expand-file-name "~/soft/jdk/plantuml.jar"))
(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . nil)
    (org . t)
    (plantuml . t)))
(setq org-confirm-babel-evaluate nil)


;;number-region
(defun number-region (start end)
  (interactive "r")
  (let* ((count 1)
     (indent-region-function (lambda (start end)
                   (save-excursion
                     (setq end (copy-marker end))
                     (goto-char start)
                     (while (< (point) end)
                       (or (and (bolp) (eolp))
                       (insert (format "%d " count))
                       (setq count (1+ count)))
                       (forward-line 1))
                     (move-marker end nil)))))
    (indent-region start end)))
(setq gc-cons-threshold (* 2 1000 1000))

(setq display-line-numbers-type 'relative)

(use-package! bm)

(map! :ne "' c" 'bm-toggle)
(map! :ne "' n" 'bm-next)
(map! :ne "' p" 'bm-previous)
(bm-bookmark-add nil nil t)

(fset 'table-name-6-fix5-n
   [?v ?e ?y ?: ?\C-m ?$ escape ?b ?v ?e ?p ?\C-c ?\C-c ?* ?n ?$ ?F ?= ?l ?v ?e ?y ?n ?w ?p ?\C-i ?\; ?w])

(setq +doom-dashboard-banner-file (expand-file-name "banner/ue-colorful.png" doom-private-dir))


