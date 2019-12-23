# R2D2のIDL解析コード

これはR2D2のIDL解析コードである。
R2D2での解析はPythonが推奨されるが、経過的措置としてIDL解析コードもメンテナンスを続けている。

R2D2 IDLでは以下の関数を提供する。使用には、r2d2_で始まるプログラムをIDLのパスの通ったディレクトリに配置すること

### r2d2_read_init, *dir*

<dl>
<dt>parameter</dt>
 <dd>dir(str) - データの場所</dd>
<dt>return</dt>
<dd>(structure) - 計算設定が含まれる構造体</dd>
</dl>

解析のはじめに実行する関数。戻り値として、計算設定が含まれる構造体が返される。
この戻り値は、他の関数への入力として使われる。

### r2d2_read_qq_select, *dir*, *xs*, *n*

<dt>parameter</dt> 
<dd>dir(str) - データの場所</dd>
<dd>xs (float) - 読み込む高さ</dd>
<dd>n (integer) - 読み込む時間ステップ</dd>

ある高さの計算結果を読み込むときに使うルーチン。最もよく使われる。