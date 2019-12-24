# R2D2のIDL解析コード

これはR2D2のIDL解析コードである。
R2D2での解析はPythonが推奨されるが、経過的措置としてIDL解析コードもメンテナンスを続けている。

R2D2 IDLでは以下の関数を提供する。使用には、r2d2_で始まるプログラムをIDLのパスの通ったディレクトリに配置すること

***
### r2d2_init(*dir*)

<dl>
<dt>parameter</dt>
 <dd>dir(str) - データの場所</dd>
<dt>return</dt>
<dd>(structure) - 計算設定が含まれる構造体</dd>
</dl>

解析のはじめに実行する関数。戻り値として、計算設定が含まれる構造体が返される。
この戻り値は、他の関数への入力として使われる。

***
### r2d2_read_qq_select(*dir*, *xs*, *n*, *p*)

<dl>
<dt>parameter</dt> 
<dd>dir(str) - データの場所</dd>
<dd>xs (float) - 読み込む高さ</dd>
<dd>n (integer) - 読み込む時間ステップ</dd>
<dd>p (structure) - 計算設定が含まれる構造体</dd>
<dt>return</dt>
<dd>(structure) ２次元のスライスデータが格納された構造体</dd>
</dl>

ある高さの計算結果を読み込むときに使う関数。最もよく使われる。

***
### r2d2_read_qq(*dir*, *n*, *p*)

<dl>
<dt>parameter</dt> 
<dd>dir(str) - データの場所</dd>
<dd>n (integer) - 読み込む時間ステップ</dd>
<dd>p (structure) - 計算設定が含まれる構造体</dd>
<dt>return</dt>
<dd>(structure) 3次元のデータが格納された構造体</dd>
</dl>

計算領域全体を読み込むための関数。読み込みにはしばしば時間がかかる。

***
### r2d2_read_tau(*dir*, *n*, *p*)

<dl>
<dt>parameter</dt> 
<dd>dir(str) - データの場所</dd>
<dd>n (integer) - 読み込む時間ステップ</dd>
<dd>p (structure) - 計算設定が含まれる構造体</dd>
<dt>return</dt>
<dd>(structure) ある光学的厚さでの2次元データ</dd>
</dl>

ある光学的厚さの2次元データを読み込むための関数。現状では光学的厚さ1, 0.1, 0.01の結果を提供しているが、0.1, 0.01の結果はどこかにバグがあるようで、ごくまれに異常な数値を示すことがある。参考程度に用いるのが良い。

***
### r2d2_read_time(*dir*, *n*, *p*)

<dl>
<dt>parameter</dt> 
<dd>dir(str) - データの場所</dd>
<dd>n (integer) - 読み込む時間ステップ</dd>
<dd>p (structure) - 計算設定が含まれる構造体</dd>
<dt>return</dt>
<dd>(float) 時間データ</dd>
</dl>

ある時間ステップの時間を読み込んで返す。

***
### r2d2_read_vc(*dir*, *n*, *p*)

<dl>
<dt>parameter</dt> 
<dd>dir(str) - データの場所</dd>
<dd>n (integer) - 読み込む時間ステップ</dd>
<dd>p (structure) - 計算設定が含まれる構造体</dd>
<dt>return</dt>
<dd>(structure) 解析データを含む構造体</dd>
</dl>

Fortranの計算中に解析したデータを読み込んで返す


***
全ての関数は構造体を返すので、`help`で要素を確認すること

```IDL
help,p
```

などとして要素を確認すること。構造体の各項目の意味については[R2D2のマニュアル](https://hottahd.github.io/R2D2-manual/notation.html)にまとめてある。

## 使用例

```IDL
dir = 'data'
n = 10
p = r2d2_read_init(dir) ;; 初期データの読込
qq2 = r2d2_read_qq_select(dir,p.rsun,n,p) ;; 2次元スライスの読込, p.rsunは太陽半径
qq3 = r2d2_read_qq_select(dir,n,p) ;; 3次元データの読込
t = r2d2_read_time(dir,n,p) ;; 時間の読込
qqi = r2d2_read_tau(dir,n,p) ;; 光学的厚さ1, 0.1, 0.01の場所でのデータの読込
vc = r2d2_read_tau(dir,n,p) ;; 解析ずみのデータの読込

end
```

使用例として`mov.pro`も含まれているので参考にされたい。