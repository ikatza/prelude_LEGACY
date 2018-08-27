;;;; Package -- summary

;;;; Code:

;; disable guru-mode
(setq prelude-guru nil)

(global-undo-tree-mode 0)

;;;; Python stuff:
;; (defvar myPackages
;;   '(elpy
;;     ;;py-autopep8
;;     ))
;;(package-initialize)
;;(elpy-enable)

;; enable autopep8 formatting on save
;;(prelude-require-package 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;;; yasnippet
;; remember to symlink the folders!
(prelude-require-packages '(yasnippet yasnippet-snippets))
(setq yas-snippet-dirs
      '("~/.emacs.d/personal/snippets"                 ;; personal snippets
        "~/.emacs.d/snippets"
        ))
(yas-global-mode +1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

;;(setq latex-run-command "xelatex")

;; set XeTeX mode in TeX/LaTeX
(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query nil)
            (setq TeX-show-compilation t)))

;;to display time
(display-time)

;; cuda files treated like c++
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))


;; Change behavior of page-up page-down to make it go back to the same
;; line.
(defun sfp-page-down ()
  (interactive)
  (setq this-command 'next-line)
  (next-line
   (- (window-text-height)
      next-screen-context-lines)))

(defun sfp-page-up ()
  (interactive)
  (setq this-command 'previous-line)
  (previous-line
   (- (window-text-height)
      next-screen-context-lines)))

(global-set-key [next] 'sfp-page-down)
(global-set-key [prior] 'sfp-page-up)

;; Move thru camelCase Words
(global-subword-mode 1) ; 1 for on, 0 for off

;;Defining environmental variable for tramp
(setenv "SU" "/su::")
(setenv "EXAMPLE" "/ssh:user@address.com:/home/user/")


(defun ergoemacs-forward-open-bracket (&optional number)
  "Move cursor to the next occurrence of left bracket or quotation mark.

With prefix NUMBER, move forward to the next NUMBER left bracket or quotation mark.

With a negative prefix NUMBER, move backward to the previous NUMBER left bracket or quotation mark."
  (interactive "p")
  (if (and number (> 0 number))
      (ergoemacs-backward-open-bracket (- 0 number))
    (forward-char 1)
    (search-forward-regexp
     (eval-when-compile
       (regexp-opt
	'("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«" "¡" "¿"))) nil t number)
    (backward-char 1)))

(defun ergoemacs-backward-open-bracket (&optional number)
  "Move cursor to the previous occurrence of left bracket or quotation mark.
With prefix argument NUMBER, move backward NUMBER open brackets.
With a negative prefix NUMBER, move forward NUMBER open brackets."
  (interactive "p")
  (if (and number (> 0 number))
      (ergoemacs-forward-open-bracket (- 0 number))
    (search-backward-regexp
   (eval-when-compile
     (regexp-opt
      '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«" "¡" "¿"))) nil t number)))

(defun ergoemacs-forward-close-bracket (&optional number)
  "Move cursor to the next occurrence of right bracket or quotation mark.
With a prefix argument NUMBER, move forward NUMBER closed bracket.
With a negative prefix argument NUMBER, move backward NUMBER closed brackets."
  (interactive "p")
  (if (and number (> 0 number))
      (ergoemacs-backward-close-bracket (- 0 number))
    (search-forward-regexp
     (eval-when-compile
       (regexp-opt '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»" "!" "?"))) nil t number)))

(defun ergoemacs-backward-close-bracket (&optional number)
  "Move cursor to the previous occurrence of right bracket or quotation mark.
With a prefix argument NUMBER, move backward NUMBER closed brackets.
With a negative prefix argument NUMBER, move forward NUMBER closed brackets."
  (interactive "p")
  (if (and number (> 0 number))
      (ergoemacs-forward-close-bracket (- 0 number))
    (backward-char 1)
    (search-backward-regexp
     (eval-when-compile
       (regexp-opt '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»" "!" "?"))) nil t number)
    (forward-char 1)))

(global-set-key (kbd "<M-S-right>") 'ergoemacs-forward-close-bracket)
(global-set-key (kbd "<M-S-left>") 'ergoemacs-backward-open-bracket)

;; Copy and comment
;; supported in Prelude with C-c M-d

;; yafolding
;; we'll see

;; Scroll screen
(defun up-semi-slow () (interactive) (scroll-up 2))
(defun down-semi-slow () (interactive) (scroll-down 2))
(defun other-up-semi-slow () (interactive) (scroll-other-window 2))
(defun other-down-semi-slow () (interactive) (scroll-other-window-down 2))
;;(setq prelude-move-text nil)
;; (define-key move-text-down (kbd "<M-S-down>") nil)
;; (define-key move-text-up (kbd "<M-S-up>") nil)

(global-set-key (kbd "<M-S-down>") 'up-semi-slow)
(global-set-key (kbd "<M-S-up>") 'down-semi-slow)
(global-set-key (kbd "<M-S-next>") 'other-up-semi-slow)
(global-set-key (kbd "<M-S-prior>") 'other-down-semi-slow)

;; disable smartparens
(smartparens-global-mode -1)
;; (add-hook 'prelude-prog-mode-hook (lambda () (smartparens-mode -1)) t)

(require 'paren)
(show-paren-mode t)
;;Parantes-matchning--------------------------
;;Match parenthesis through high lighting rather than retarded jumps. Good!
(when (fboundp 'show-paren-mode)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis))

;; (defadvice show-paren-function
;;     (after show-matching-paren-offscreen activate)
;;   "If the matching paren is offscreen, show the matching line in the
;;         echo area. Has no effect if the character before point is not of
;;         the syntax class ')'."
;;   (interactive)
;;   (let* ((cb (char-before (point)))
;;          (matching-text (and cb
;;                              (char-equal (char-syntax cb) ?\) )
;;                              (blink-matching-open))))
;;     (when matching-text (message matching-text))))

;; (defadvice show-paren-function (after my-echo-paren-matching-line activate)
;;   "If a matching paren is off-screen, echo the matching line."
;;   (when (char-equal (char-syntax (char-before (point))) ?\))
;;     (let ((matching-text (blink-matching-open)))
;;       (when matching-text
;;         (message matching-text)))))

;; (defvar match-paren--idle-timer nil)
;; (defvar match-paren--delay 0.5)
;; (setq match-paren--idle-timer
;;       (run-with-idle-timer match-paren--delay t #'blink-matching-open))

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)


;;(require 'mic-paren) ; loading
;;(paren-activate)     ; activating


;;search other window
(defun isearch-forward-other-window ()
  (interactive)
  (save-selected-window
    (other-window 1)
    (isearch-forward)))
(defun isearch-backward-other-window ()
  (interactive)
  (save-selected-window
    (other-window 1)
    (isearch-backward)))
(global-set-key (kbd "M-S") 'isearch-forward-other-window)
(global-set-key (kbd "M-R") 'isearch-backward-other-window)



;; maybe not actually necessary
;; ;; set up unicode
;; (prefer-coding-system       'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)

(let ((eqv-list '("aAàÀáÁâÂãÃäÄåÅ"
                  "cCçÇ"
                  "eEèÈéÉêÊëË"
                  "iIìÌíÍîÎïÏ"
                  "nNñÑ"
                  "oOòÒóÓôÔõÕöÖøØ"
                  "uUùÙúÚûÛüÜ"
                  "yYýÝÿ"))
      (table (standard-case-table))
      canon)
  (setq canon (copy-sequence table))
  (mapcar (lambda (s)
            (mapcar (lambda (c) (aset canon c (aref s 0))) s))
          eqv-list)
  (set-char-table-extra-slot table 1 canon)
  (set-char-table-extra-slot table 2 nil)
  (set-standard-case-table table))


;; Matches between "¿" and "?"  and "¡" "!"
(defun my-match-marks ()
  (modify-syntax-entry ?¿ "(?")
  (modify-syntax-entry ?? ")¿")
  (modify-syntax-entry ?¡ "(!")
  (modify-syntax-entry ?! ")¡"))
(add-hook 'text-mode-hook 'my-match-marks)

(defun my-custom-keywords ()
  (font-lock-add-keywords nil (list
                               (list "\\(¡\\)\\(\\(.\\|\n\\)+?\\)\\(!\\)"
                                     '(1 font-lock-keyword-face t)
                                     '(2 'default t)
                                     '(4 font-lock-keyword-face t))
                               (list "\\(¿\\)\\(\\(.\\|\n\\)+?\\)\\([?]\\)"
                                     '(1 font-lock-keyword-face t)
                                     '(2 'default t)
                                     '(4 font-lock-keyword-face t))
                               (list "\\(¡\\|!\\|¿\\|[?]\\)"
                                     '(1 font-lock-warning-face))  )))
(add-hook 'text-mode-hook 'my-custom-keywords)

;; ;; Not sure is necessary
;; ;;Cutting and Pasting between emacs and other applications.
;; (setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;Calendar options
(setq european-calendar-style t)
(setq calendar-week-start-day 1)

;; (setq calendar-day-name-array
;;       ["Domingo" "Lunes" "Martes"
;;        "Miercoles" "Jueves" "Viernes" "Sábado"])
;; (setq calendar-month-name-array
;;       ["Enero" "Febrero" "Marzo" "Abril"
;;        "Mayo" "Junio" "Julio" "Agosto" "Septiembre"
;;        "Octubre" "Noviembre" "Diciembre"])

;; ;;Latitude and longitude of Mexico City
;; (setq calendar-latitude 19.4)
;; (setq calendar-longitude -99.1)
;; (setq calendar-location-name "Mexico City")


;;Latitude and longitude of Brighton
(setq calendar-latitude 50.86)
(setq calendar-longitude -0.08)
(setq calendar-location-name "Brighton")



;; Org-mode settings
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-ca" 'org-agenda)
;;(global-font-lock-mode 1)
;;(setq org-log-done t)
(setq org-cycle-include-plain-lists t)
;;(setq org-hide-leading-stars t)
(setq org-highest-priority ?A)
(setq org-lowest-priority ?E)
(setq org-default-priority ?C)
(setq org-todo-keywords
      '((sequence "TODO" "PENDING" "VERIFY" "|" "DONE" "CANCELED" "DELEGATED")))

;;(setq org-agenda-files '("~/org/2016"))

;; (setq org-agenda-files (list
;;"~/org/work.org"
;;"~/org/books.org"
;; ))


;; themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(prelude-require-package 'theme-changer)
(require 'theme-changer)
;;(change-theme 'solarized-light 'solarized-dark)
;;(change-theme 'jonadabian-slate 'underwater)
;;(change-theme 'jonadabian-slate 'twilight-anti-bright)
;;(change-theme 'jonadabian-slate 'sanityinc-tomorrow-night)
;;(change-theme 'jonadabian-slate 'gruber-darker)
(change-theme 'anti-zenburn 'zenburn)

;;(setq prelude-theme 'solarized-dark)


;; to override prelude key-binding's
(prelude-require-package 'use-package)
(bind-keys*
 ((kbd "<C-backspace>") . sp-backward-kill-word)
 ;;moving
 ((kbd "<C-right>") . right-word)
 ((kbd "<C-left>") . left-word)
 ;;search other window
 ((kbd "M-S") . isearch-forward-other-window)
 ((kbd "M-R") . isearch-backward-other-window)
 ;; scroll windows
 ((kbd "<M-S-down>") . up-semi-slow)
 ((kbd "<M-S-up>") . down-semi-slow)
 ((kbd "<M-S-next>") . other-up-semi-slow)
 ((kbd "<M-S-prior>") . other-down-semi-slow)
;; Move between windows
 ((kbd "<M-left>") . windmove-left)
 ((kbd "<M-right>") . windmove-right)
 ((kbd "<M-up>") . windmove-up)
 ((kbd "<M-down>") . windmove-down)

 ((kbd "C-x r") . revert-buffer)
 ([f3] . shell)
 ([f4] . goto-line)
 ([f5] . query-replace)
 ([f6] . switch-to-buffer)
 ([f7] . ispell-word)
 ([f8] . flyspell-buffer)
 ([f9] . ispell-change-dictionary)
 ([f12] . calendar)

;; ("C-M-n" . forward-page)
 ;;("C-M-p" . backward-page)
 )
;;;;;;;;;;;;;;;;;;;;;;
;; code folding
;;;;;;;;;;;;;;;;;;;;;;

;; not working globally
;; (defun toggle-selective-display (column)
;;   (interactive "P")
;;   (set-selective-display
;;    (or column
;;        (unless selective-display
;;          (1+ (current-column))))))
;; (defun toggle-hiding (column)
;;   (interactive "P")
;;   (if hs-minor-mode
;;       (if (condition-case nil
;;               (hs-toggle-hiding)
;;             (error t))
;;           (hs-show-all))
;;     (toggle-selective-display column)))

;; (load-library "hideshow")
;; (global-set-key (kbd "C-c <C-SPC>") 'toggle-hiding)
;; (global-set-key (kbd "C-\\") 'toggle-selective-display)
;; (global-set-key (kbd "C-c <C-right>") 'hs-show-block)
;; (global-set-key (kbd "C-c <C-left>")  'hs-hide-block)
;; (global-set-key (kbd "C-c <C-up>")    'hs-hide-all)
;; (global-set-key (kbd "C-c <C-down>")  'hs-show-all)
;; (hs-minor-mode t)
;; (add-hook 'c-mode-common-hook   'hs-minor-mode)
;; ;;(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;; ;;(add-hook 'java-mode-hook       'hs-minor-mode)
;; ;;(add-hook 'lisp-mode-hook       'hs-minor-mode)
;; ;;(add-hook 'perl-mode-hook       'hs-minor-mode)
;; ;;(add-hook 'sh-mode-hook         'hs-minor-mode)



(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-c <C-SPC>")   'hs-toggle-hiding)
            (local-set-key (kbd "C-c <C-right>") 'hs-show-block)
            (local-set-key (kbd "C-c <C-left>")  'hs-hide-block)
            (local-set-key (kbd "C-c <C-up>")    'hs-hide-all)
            (local-set-key (kbd "C-c <C-down>")  'hs-show-all)
            (hs-minor-mode t)))
(add-hook 'python-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-c <C-SPC>")   'hs-toggle-hiding)
            (local-set-key (kbd "C-c <C-right>") 'hs-show-block)
            (local-set-key (kbd "C-c <C-left>")  'hs-hide-block)
            (local-set-key (kbd "C-c <C-up>")    'hs-hide-all)
            (local-set-key (kbd "C-c <C-down>")  'hs-show-all)
            (hs-minor-mode t)))
(add-hook 'latex-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-c <C-SPC>")   'hs-toggle-hiding)
            (local-set-key (kbd "C-c <C-right>") 'hs-show-block)
            (local-set-key (kbd "C-c <C-left>")  'hs-hide-block)
            (local-set-key (kbd "C-c <C-up>")    'hs-hide-all)
            (local-set-key (kbd "C-c <C-down>")  'hs-show-all)
            (hs-minor-mode t)))


(require 'multi-line)
(global-set-key (kbd "C-c ;") 'multi-line)


;; 1). Use compile-again to run the same compile as the last time
;; automatically, no prompt. If there is no last time, or there is a
;; prefix argument, it acts like M-x compile.

;; 2). compile will split the current window, it will not affect the
;; other windows in this frame.

;; 3). it will auto-close the *compilation* buffer (window) if there
;; is no error, keep it if error exists.

;; 4). it will highlight the error line and line number of the source
;; code in the *compilation* buffer, use M-n/p to navigate every error
;; in *compilation* buffer, Enter in the error line to jump to the
;; line in your code code.
(require 'compile)
(setq compilation-last-buffer nil)
(defun compile-again (ARG)
  "Run the same compile as the last time.

If there is no last time, or there is a prefix argument, this
acts like M-x compile."
  (interactive "p")
  (if (and (eq ARG 1)
           compilation-last-buffer)
      (progn
        (set-buffer compilation-last-buffer)
        (revert-buffer t t))
    (progn
      (call-interactively 'compile)
      (setq cur (selected-window))
      (setq w (get-buffer-window "*compilation*"))
      (select-window w)
      (setq h (window-height w))
      (shrink-window (- h 10))
      (select-window cur))))
(global-set-key (kbd "C-x C-m") 'compile-again)
(defun my-compilation-hook ()
  "Make sure that the compile window is splitting vertically."
  (progn
    (if (not (get-buffer-window "*compilation*"))
        (progn
          (split-window-vertically)))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)
(defun compilation-exit-autoclose (STATUS code msg)
  "Close the compilation window if there was no error at all."
  ;; If M-x compile exists with a 0
  (when (and (eq STATUS 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; and delete the *compilation* window
    (delete-window (get-buffer-window (get-buffer "*compilation*"))))
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
(setq compilation-exit-message-function 'compilation-exit-autoclose)
(defvar all-overlays ())
(defun delete-this-overlay(overlay is-after begin end &optional len)
  (delete-overlay overlay)
  )
(defun highlight-current-line ()
"Highlight current line."
  (interactive)
  (setq current-point (point))
  (beginning-of-line)
  (setq beg (point))
  (forward-line 1)
  (setq end (point))
  ;; Create and place the overlay
  (setq error-line-overlay (make-overlay 1 1))

  ;; Append to list of all overlays
  (setq all-overlays (cons error-line-overlay all-overlays))

  (overlay-put error-line-overlay
               'face '(background-color . "red"))
  (overlay-put error-line-overlay
               'modification-hooks (list 'delete-this-overlay))
  (move-overlay error-line-overlay beg end)
  (goto-char current-point))
(defun delete-all-overlays ()
  "Delete all overlays"
  (while all-overlays
    (delete-overlay (car all-overlays))
    (setq all-overlays (cdr all-overlays))))
(defun highlight-error-lines(compilation-buffer process-result)
  (interactive)
  (delete-all-overlays)
  (condition-case nil
      (while t
        (next-error)
        (highlight-current-line))
    (error nil)))
(setq compilation-finish-functions 'highlight-error-lines)

(provide 'personal)

;;; personal.el ends here
