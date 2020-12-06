GNU EmacsでLaTeX文書を書く話
============================

文書のコンパイル方法
--------------------

- `make`: article.orgからarticle.satyhを生成する
- `make pdf`: article.orgからarticle.satyhを生成した後諸々合わせてPDFを生成する


init.elのコンパイル方法
-----------------------

1. article.orgの後ろの方にある コメントアウトを除去する
2. `C-c C-v t` でtangleする
3. article.orgの後ろの方の コメントアウトを戻す
