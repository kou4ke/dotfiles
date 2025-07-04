#Requires AutoHotkey v2.0
; Alt + Shift + Uで実行
+!u:: {
    Clipboard := "kosuke.watanabe@openpage.co.jp"  ; ここにコピーしたいテキストを入力
    Send("^v")  ; Ctrl + Vで貼り付け
}
