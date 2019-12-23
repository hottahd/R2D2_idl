# R2D2のIDL解析コード

これはR2D2のIDL解析コードである。
R2D2での解析はPythonが推奨されるが、経過的措置としてIDL解析コードもメンテナンスを続けている。

R2D2 IDLでは以下の関数を提供する。使用には、r2d2_で始まるプログラムをIDLのパスの通ったディレクトリに配置すること

### r2d2_read_init, *dir*

- parameter :: dir(str) - データの場所
- return :: p (structure) - 計算設定が含まれる構造体

解析のはじめに実行する関数。
