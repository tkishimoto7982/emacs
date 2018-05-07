(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(require 'use-package)

(exec-path-from-shell-initialize)

(require 'undohist)
(undohist-initialize)

(add-to-list 'load-path "~/.emacs.d/packages")

;; spice-mode
;; (setq load-path (cons (expand-file-name "~/.emacs.d/spice-mode/") load-path))

(autoload 'spice-mode "spice-mode" "Spice/Layla Editing Mode" t)
(setq auto-mode-alist (append (list (cons "\\.sp$" 'spice-mode)
				    (cons "\\.spi$" 'spice-mode)
				    (cons "\\.src.net$" 'spice-mode))
			      auto-mode-alist))

;; C-x C-fの際に大文字を補完
(setq read-file-name-completion-ignore-case t)
(setq display-time-24hr-format t)

;; ;;tmuxとのprefix互換性
(global-set-key (kbd "C-a") 'nil)

(global-set-key "\C-a\C-g" 'goto-line)	   ;;C-x,C-gで行指定ジャンプ
;;文字列サーチ
(define-key isearch-mode-map "\C-k" 'isearch-edit-string)

(global-linum-mode t)
(show-paren-mode t)
(line-number-mode t)
(column-number-mode t)
(recentf-mode t)
(delete-selection-mode 1)
(setq frame-title-format "%f")

(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background  "#98FB98"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

(define-key global-map (kbd "C-z") 'undo)
(setq quail-japanese-use-double-n t)
(set-scroll-bar-mode 'right)
(setq inhibit-startup-message t)
;;; バックアップファイルを作らない
(setq backup-inhibited t)
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
					;文字背景色
(setq initial-frame-alist
      (append (list
	       '(width . 90)
	       '(height . 35)
	       '(font . "VL Gothic-12")
	       )
	      initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

(custom-set-faces
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 114 :width normal :foundry "unknown" :family "VL Gothic")))))
'(cursor ((((class color)
	    (background dark))
	   (:background "#00AA00"))
	  (((class color)
	    (background light))
	   (:background "#999999"))
	  (t ())
	  ))

(add-to-list 'default-frame-alist '(foreground-color . "white"))

(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))

;; reload buffer
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)

;; tabber-mode

(use-package tabbar
  :config
  ;; タブ上でマウスホイール操作無効
  (tabbar-mwheel-mode nil)
  ;; グループ化しない
  (setq tabbar-buffer-groups-function nil)
  ;; 画像を使わないことで軽量化する
  (setq tabbar-use-images nil)
  )
;; key bindings
(global-set-key [(C-tab)]   'tabbar-forward-tab)
(global-set-key [(C-shift-tab)] 'tabbar-backward-tab)
(global-set-key (kbd "M-<right>") 'tabbar-forward-tab)
(global-set-key (kbd "M-<left>") 'tabbar-backward-tab)

(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
		     ((equal "*terminal<1>*" (buffer-name b)) b) ; *terminal*バッファは表示する
		     ((equal "*terminal<2>*" (buffer-name b)) b) 
		     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
;; F4 で tabbar-mode
(global-set-key [f4] 'tabbar-mode)

(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-z") 'undo-tree-redo)

(defun my-move-beginning-of-line ()
  (interactive)
  (if (bolp)
      (back-to-indentation)    
    (beginning-of-line)))

(global-set-key "\C-a\C-a"'my-move-beginning-of-line)

(global-set-key (kbd "C-a <left>")  'windmove-left)
(global-set-key (kbd "C-a <down>")  'windmove-down)
(global-set-key (kbd "C-a <up>")    'windmove-up)
(global-set-key (kbd "C-a <right>") 'windmove-right)

(global-set-key (kbd "C-<left>")  'windmove-left)
(global-set-key (kbd "C-<down>")  'windmove-down)
(global-set-key (kbd "C-<up>")    'windmove-up)
(global-set-key (kbd "C-<right>") 'windmove-right)

;;auto-revert-mode
(global-set-key [f7] 'auto-revert-mode)

;; ;;global-aut-revert
;; (global-set-key [f8] 'global-auto-revert-mode)
;;分割ウインドウサイズ変更
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?6)
               (enlarge-window-horizontally dx))
              ((= c ?4)
               (shrink-window-horizontally dx))
              ((= c ?2)
               (enlarge-window dy))
              ((= c ?8)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

(global-set-key [f9] 'window-resizer)

(setq mouse-wheel-scroll-amount '(3 ((shift) . 20)((control) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

(use-package anzu
  :config
  (global-anzu-mode 1)
  (custom-set-variables
   '(anzu-mode-lighter "")
   '(anzu-deactivate-region t)
   '(anzu-search-threshold 1000))
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  )
(use-package zlc
  :config
  (zlc-mode t)
  (let ((map minibuffer-local-map))
    (define-key map (kbd "<down>")  'zlc-select-next-vertical)
    (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
    ;; (define-key map (kbd "<right>") 'zlc-select-next)
    ;; (define-key map (kbd "<left>")  'zlc-select-previous)
    (define-key map (kbd "M-<tab>") 'zlc-select-previous)
    (define-key map (kbd "M-TAB") 'zlc-select-previous)
  ;;; reset selection
    (define-key map (kbd "C-a c") 'zlc-reset))
  )
;;一括インデント
(defun all-indent ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))

(defun electric-indent ()
  "Indent specified region.
When resion is active, indent region.
Otherwise indent whole buffer."
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (all-indent)))

(global-set-key (kbd "C-M-\\") 'electric-indent)

(add-hook 'dired-load-hook
          '(lambda ()
             ;; ディレクトリを再帰的にコピー可能にする
             (setq dired-recursive-copies 'always)
             ;; lsのオプション 「l」(小文字のエル)は必須
             (setq dired-listing-switches "-FlhtA")
             ;; find-dired/find-grep-diredで、条件に合ったファイルをリストする形式
             (setq find-ls-option '("-print0 | xargs -0 ls -Flhatd"))
             ;; 無効コマンドdired-find-alternate-fileを有効にする
             (put 'dired-find-alternate-file 'disabled nil)))
;; ファイル・ディレクトリ名のリストを編集することで、まとめてリネーム可能にする
(use-package wdired
  :config
  ;; wdiredモードに入るキー(下の例では「r」)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
  ;; 新規バッファを作らずにディレクトリを開く(デフォルトは「a」)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  ;; 「a」を押したときに新規バッファを作って開くようにする
  (define-key dired-mode-map "a" 'dired-advertised-find-file)
  )
(ffap-bindings)

;;M-x r-p-o RET で「、。」に，M-x r-p-, RET で「，。」に，M-x r-p-. RET で「，．」に，変換
(defun replace-punctuation (a1 a2 b1 b2)
  "Replace periods and commas"
  (let ((s1 (if mark-active "選択領域" "バッファ全体"))
        (s2 (concat a2 b2))
        (b (if mark-active (region-beginning) (point-min)))
        (e (if mark-active (region-end) (point-max))))
    (if (y-or-n-p (concat s1 "の句読点を「" s2 "」にしますがよろしいですか?"))
        (progn
          (replace-string a1 a2 nil b e)
          (replace-string b1 b2 nil b e)))))
(defun replace-punctuation-ten-maru ()
  "選択領域またはバッファ全体の句読点を「、。」にします"
  (interactive)
  (replace-punctuation "，" "、" "．" "。"))
(defun replace-punctuation-comma-maru ()
  "選択領域またはバッファ全体の句読点を「，。」にします"
  (interactive)
  (replace-punctuation "、" "，" "．" "。"))
(defun replace-punctuation-comma-period ()
  "選択領域またはバッファ全体の句読点を「，．」にします"
  (interactive)
  (replace-punctuation "、" "，" "。" "．"))
(defalias 'replace-punctuation-o 'replace-punctuation-ten-maru)
(defalias 'replace-punctuation-\, 'replace-punctuation-comma-maru)
(defalias 'replace-punctuation-. 'replace-punctuation-comma-period)
(defalias 'tenmaru 'replace-punctuation-ten-maru)
(defalias 'commamaru 'replace-punctuation-comma-maru)
(defalias 'commaperiod 'replace-punctuation-comma-period)

(global-set-key [f11] 'replace-punctuation-o)
(global-set-key [f12] 'replace-punctuation-.)

;; cperl-mode
(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(add-to-list 'auto-mode-alist '("\.\([pP][Llm]\|al\|t\|cgi\)\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(defalias 'perl-mode 'cperl-mode)

(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-close-paren-offset -4
      cperl-label-offset -4
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-indent-parens-as-block t
      cperl-tab-always-indent nil
      cperl-font-lock t)

(add-hook 'cperl-mode-hook 
          (function (lambda ()
                      (set-face-background 'cperl-hash-face "black")
                      (set-face-background 'cperl-array-face "black")
		      )))
(setq cperl-electric-backspace-untabify nil)

(add-hook 'python-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode nil)
	     (setq indent-level 4)
	     (setq python-indent 4)
	     (setq tab-width 4)))

;; (use-package jedi
;;   :config
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   (setq jedi:complete-on-dot t)
;;   )

;; (elpy-enable)
;; (elpy-use-ipython)
;; (setq elpy-rpc-backend "jedi")
;; (when (require 'flycheck nil t)
;;   (remove-hook 'elpy-modules 'elpy-module-flymake)
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  
  (global-set-key (kbd "\C-a n") 'flycheck-next-error)
  (global-set-key (kbd "\C-a p") 'flycheck-previous-error)
  (global-set-key (kbd "\C-a d") 'flycheck-list-errors)
  (setq flycheck-display-errors-delay 0.8)
  )
(defmacro flycheck-define-clike-checker (name command modes)
  `(flycheck-define-checker ,(intern (format "%s" name))
     ,(format "A %s checker using %s" name (car command))
     :command (,@command source-inplace)
     :error-patterns
     ((warning line-start (file-name) ":" line ":" column ": 警告:" (message) line-end)
      (error line-start (file-name) ":" line ":" column ": エラー:" (message) line-end))
     :modes ',modes))
(flycheck-define-clike-checker c-gcc-ja
			       ("gcc" "-fsyntax-only" "-Wall" "-Wextra")
			       c-mode)
(add-to-list 'flycheck-checkers 'c-gcc-ja)
(flycheck-define-clike-checker c++-g++-ja
			       ("g++" "-fsyntax-only" "-Wall" "-Wextra" "-std=c++11")
			       c++-mode)
(add-to-list 'flycheck-checkers 'c++-g++-ja)
(flycheck-define-checker c/c++
  "A C/C++ checker using g++."
  :command ("g++" "-Wall" "-Wextra" source)
  :error-patterns  ((error line-start
                           (file-name) ":" line ":" column ":" " エラー: " (message)
                           line-end)
                    (warning line-start
			     (file-name) ":" line ":" column ":" " 警告: " (message)
			     line-end))
  :modes (c-mode c++-mode))


;; (use-package auto-complete
;;   :config
;;   (require 'auto-complete-config); 必須ではないですが一応
;;   (global-auto-complete-mode t)
;;   (ac-set-trigger-key "TAB")
;;   (setq ac-use-menu-map t)
;;   (setq ac-use-fuzzy t)
;;   (setq-default ac-sources '(ac-source-filename ac-source-words-in-same-mode-buffers))
;;   (require 'auto-complete-latex)
;;   ;; (add-to-list 'ac-modes 'yatex-mode)
;;   )

(use-package company
  :config
  (require 'company)
  (global-company-mode) ; 全バッファで有効にする 
  (setq company-idle-delay 0) ; デフォルトは0.5
  (setq company-minimum-prefix-length 4) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

  (set-face-attribute 'company-tooltip nil
		      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common nil
		      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common-selection nil
		      :foreground "white" :background "steelblue")
  (set-face-attribute 'company-tooltip-selection nil
		      :foreground "black" :background "steelblue")
  (set-face-attribute 'company-preview-common nil
		      :background nil :foreground "lightgrey" :underline t)
  (set-face-attribute 'company-scrollbar-fg nil
		      :background "orange")
  (set-face-attribute 'company-scrollbar-bg nil
		      :background "gray40")
  (defun company--insert-candidate2 (candidate)
    (when (> (length candidate) 0)
      (setq candidate (substring-no-properties candidate))
      (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
	  (insert (company-strip-prefix candidate))
	(if (equal company-prefix candidate)
	    (company-select-next)
          (delete-region (- (point) (length company-prefix)) (point))
	  (insert candidate))
	)))

  (defun company-complete-common2 ()
    (interactive)
    (when (company-manual-begin)
      (if (and (not (cdr company-candidates))
	       (equal company-common (car company-candidates)))
	  (company-complete-selection)
	(company--insert-candidate2 company-common))))

  (define-key company-active-map [tab] 'company-complete-common2)
  (define-key company-active-map [backtab] 'company-select-previous) ; おまけ

  )

;; 自動改行をoffにする
(setq text-mode-hook 'turn-off-auto-fill)

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; 括弧の色を強調する設定
(use-package cl-lib)
(use-package color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

;; expand-region
(use-package expand-region
  :config
  (global-set-key (kbd "C-@") 'er/expand-region)
  (global-set-key (kbd "C-M-@") 'er/contract-region)
  )

(use-package flycheck-pos-tip)
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(use-package smartparens-config
  :config
  (smartparens-global-mode t)
  (with-eval-after-load 'cperl-mode
    (define-key cperl-mode-map "{" nil)))
;; Aspell
(setq-default ispell-program-name "aspell") 
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; 
(global-set-key (kbd "C-M-$") 'ispell-complete-word)

(use-package multi-term
  :config
  (setq multi-term-program shell-file-name)
  (global-set-key (kbd "C-c n") 'multi-term-next)
  (global-set-key (kbd "C-c p") 'multi-term-prev)
  (global-set-key (kbd "C-c t") '(lambda ()
				   (interactive)
				   (if (get-buffer "*terminal<1>*")
				       (switch-to-buffer "*terminal<1>*")
				     (multi-term))))
  (add-to-list 'term-unbind-key-list '"C-<right>")
  (add-to-list 'term-unbind-key-list '"C-<left>")
  (add-to-list 'term-unbind-key-list '"C-<up>")
  (add-to-list 'term-unbind-key-list '"C-<down>")
  (add-to-list 'term-unbind-key-list '"C-a")
  )
(use-package shell-pop
  :config
  (custom-set-variables
   '(shell-pop-shell-type (quote ("multi-term" "*teiminal<1>*" (lambda () (multi-term)))))
   '(shell-pop-set-internal-mode "multi-term")
   '(shell-pop-set-window-height 30)
   '(shell-pop-window-position "bottom"))
  (global-set-key [f6] 'shell-pop))

(use-package auto-async-byte-compile
  :config
  (setq auto-async-byte-compile-exclude-files-regexp "/junk")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))

(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
;; (cancel-timer global-hl-line-timer)
;; (cua-mode t)
;; (define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)
(global-set-key [f8] 'cua-mode)

;; リージョン内のperlソースを整形する。
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(global-set-key "\C-ct" 'perltidy-region)

;; ソースすべてを整形する。
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun) (perltidy-region)))
(global-set-key "\C-c\C-t" 'perltidy-defun)

;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)
(add-hook 'diff-mode-hook
	  (lambda()
	    (define-key diff-mode-map (kbd "C-M-n") 'diff-file-next)
	    (define-key diff-mode-map (kbd "C-M-p") 'diff-file-prev)
	    (define-key diff-mode-map (kbd "M-k") 'diff-hunk-kill)
	    (define-key diff-mode-map (kbd "C-M-k") 'diff-file-kill)))

(global-set-key (kbd "C-a r") 'replace-string)

;; C-i でタブを入力できるように
(global-set-key "\C-i" '(lambda ()
			  (interactive)
			  (quoted-insert "\t")))

;; (require 'ibus)
;; (add-hook 'after-init-hook 'ibus-mode-on)

;; ;; C-SPC は Set Mark に使う
;; (ibus-define-common-key "C-s" nil)
;; ;; C-/ は Undo に使う
;; (ibus-define-common-key "C-/" nil)
;; ;; IBusの状態によってカーソル色を変化させる ("on" "off" "disabled")
;; (setq ibus-cursor-color '("firebrick" "dark orange" "royal blue"))
;; ;; すべてのバッファで入力状態を共有 (default ではバッファ毎にインプットメソッドの状態を保持)
;; (setq ibus-mode-local nil)
;; ;; カーソル位置で予測候補ウィンドウを表示 (default はプリエディット領域の先頭位置に表示)
;; (setq ibus-prediction-window-position t)
;; ;; isearch 時はオフに
;; (ibus-disable-isearch)
;; ;; mini buffer ではオフに
;; (add-hook 'minibuffer-setup-hook 'ibus-disable)
;; (global-set-key (kbd "M-SPC") 'ibus-toggle)
;; (global-set-key (kbd "M-o") (lambda () (interactive) (ibus-enable "m17n:sa:vz-prefix")))
;; (global-set-key (kbd "C-o") (lambda () (interactive) (ibus-enable "mozc-jp")))
;; (global-set-key (kbd "C-<f7>")
;;                 (lambda ()
;;                   (interactive)
;;                   (shell-command-to-string
;;                    "/usr/lib/mozc/mozc_tool --mode=word_register_dialog")))

;; (require 'helm-config)
;; (helm-mode 1)
;; (add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
;; ;; For find-file etc.
;; (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; ;; For helm-find-files etc.
;; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;; (define-key global-map (kbd "C-;") 'helm-mini)
;; (define-key global-map (kbd "M-y") 'helm-show-kill-ring)
;; (define-key global-map (kbd "M-x")     'helm-M-x)
;; (define-key global-map (kbd "C-x C-f") 'find-file)
;; (define-key global-map (kbd "C-a C-r") 'helm-recentf)
;; (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
;; (define-key global-map (kbd "C-c i")   'helm-imenu)
;; (define-key global-map (kbd "C-x b")   'helm-buffers-list)
;; (define-key global-map (kbd "M-r")     'helm-resume)
;; ;; Emulate `kill-line' in helm minibuffer
;; (setq helm-delete-minibuffer-contents-from-point t)
;; (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
;;   "Emulate `kill-line' in helm minibuffer"
;;   (kill-new (buffer-substring (point) (field-end))))
;; (setq helm-buffer-max-length 50)

;; (use-package popwin
;;   :config
;;   (setq helm-samewindow nil)
;;   (setq display-buffer-function 'popwin:display-buffer)
;;   (setq popwin:adjust-other-windows t)
;; (push '("^\\*helm" :regexp t :width 80 :position :right) popwin:special-display-config))
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(global-set-key (kbd "<delete>") 'delete-char)
(global-set-key (kbd "A-w") 'copy-region-as-kill)
(define-key global-map [?¥] [?\\])


