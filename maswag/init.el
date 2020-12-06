(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)
(package-install 'use-package)
(require 'use-package)
(use-package company
  :ensure t
  :config
  (global-company-mode)
  ;; 遅延なしにする。
  (setq company-idle-delay 0)
  ;; デフォルトは4。より少ない文字数から補完が始まる様にする。
  (setq company-minimum-prefix-length 2)
  ;; 候補の一番下でさらに下に行こうとすると一番上に戻る。
  (setq company-selection-wrap-around t)
  ;; 番号を表示する。
  (setq company-show-numbers t)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("C-s" . company-filter-candidates)
              ("<tab>" . company-complete-selection))
  :bind (:map company-search-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)))
(use-package company-tabnine 
  :ensure t
  :config
  (add-to-list 'company-backends #'company-tabnine))
(use-package yatex
  ;; YaTeX がインストールされていない場合、package.elを使ってインストールする
  :ensure t
  ;; :commands autoload するコマンドを指定
  :commands (yatex-mode)
  ;; :mode auto-mode-alist の設定
  :mode (("\\.tex$" . yatex-mode)
         ("\\.ltx$" . yatex-mode)
         ("\\.cls$" . yatex-mode)
         ("\\.sty$" . yatex-mode)
         ("\\.clo$" . yatex-mode)
         ("\\.bbl$" . yatex-mode))
  :init
  (setq YaTeX-inhibit-prefix-letter t)
  ;; :config キーワードはライブラリをロードした後の設定などを記述します。
  :config
  (setq YaTeX-kanji-code nil)
  (setq YaTeX-latex-message-code 'utf-8)
  (setq YaTeX-use-LaTeX2e t)
  (setq YaTeX-use-AMS-LaTeX t)
  (setq tex-command "/Library/TeX/texbin/latexmk -pdf -pvc -view=none")
  (setq tex-pdfview-command "/usr/bin/open -a Skim")
  (auto-fill-mode 0)
  ;; company-tabnineによる補完。companyについては後述
  (set (make-local-variable 'company-backends) '(company-tabnine)))
(use-package reftex
  :ensure nil
  :hook (yatex-mode . reftex-mode)
  :bind (:map reftex-mode-map
              ("C-c (" . reftex-reference)
              ("C-c )" . nil)
              ("C-c >" . YaTeX-comment-region)
              ("C-c <" . YaTeX-uncomment-region))
  :defer t
  :custom
  ;; \ref ではなく \cref を使うための設定
  (reftex-ref-style-default-list '("Cleveref") "Use cref/Cref as default"))
(package-install 'biblio)
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode)
  :config
  (flycheck-add-mode 'tex-chktex 'yatex-mode)
  (flycheck-add-mode 'tex-lacheck 'yatex-mode)
  ;; chktexが自動で見付からない場合は以下の様に指定する。lacheckについても同様
  (setq flycheck-tex-chktex-executable "/Library/TeX/texbin/chktex")
  :bind (:map flycheck-mode-map
            ("M-n" . flycheck-next-error)
            ("M-p" . flycheck-previous-error)))
(use-package ispell
  :init
  ;; スペルチェッカとしてaspellを使う
  (setq ispell-program-name "/usr/local/bin/aspell")
  :config
  ;; 日本語の部分を飛ばす
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
(use-package flyspell
  ;; flyspellをインストールする
  :ensure t
  ;; YaTeXモードでflyspellを使う
  :hook (yatex-mode . flyspell-mode))
(use-package ace-jump-mode
  :ensure t
  :bind (("C-c j" . ace-jump-mode)))
