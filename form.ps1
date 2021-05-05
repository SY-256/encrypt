# アセンブリの読み込み
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# フォームの作成
$form = New-Object System.Windows.Forms.Form
$form.Text = "テキスト暗号化"
$form.Size = New-Object System.Drawing.Size(340,350)

# OKボタンの設定
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(40,230)
$OKButton.Size = New-Object System.Drawing.Size(75,30)
$OKButton.Text = "OK"
$OKButton.DialogResult = "OK"

# キャンセルボタンの設定
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(130,230)
$CancelButton.Size = New-Object System.Drawing.Size(75,30)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = "Cancel"

# ラベルの設定
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,50)
$label1.Size = New-Object System.Drawing.Size(250,20)
$label1.Text = "暗号化するIDを入力してください"

# ラベルの設定
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,100)
$label2.Size = New-Object System.Drawing.Size(250,20)
$label2.Text = "暗号化するパスワードを入力してください"

# ラベルの設定
$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(10,150)
$label3.Size = New-Object System.Drawing.Size(250,30)
$label3.Text = "出力ファイル名を入力してください`r`n(出力先フォルダ：C:\appl\data)"


# 入力ボックスの設定
$textBox_ID = New-Object System.Windows.Forms.TextBox
$textBox_ID.Location = New-Object System.Drawing.Point(10,70)
$textBox_ID.Size = New-Object System.Drawing.Size(225,50)

$textBox_Pass = New-Object System.Windows.Forms.TextBox
$textBox_Pass.Location = New-Object System.Drawing.Point(10,120)
$textBox_Pass.Size = New-Object System.Drawing.Size(225,50)

$textBox_filename = New-Object System.Windows.Forms.TextBox
$textBox_filename.Location = New-Object System.Drawing.Point(10,180)
$textBox_filename.Size = New-Object System.Drawing.Size(225,50)

# キーとボタンの関係
$form.AcceptButton = $OKButton
$form.CancelButton = $CancelButton

# ボタン等をフォームに追加
$form.Controls.Add($OKButton)
$form.Controls.Add($CancelButton)
$form.Controls.Add($label1)
$form.Controls.Add($label2)
$form.Controls.Add($label3)
$form.Controls.Add($textBox_ID)
$form.Controls.Add($textBox_Pass)
$form.Controls.Add($textBox_filename)

# フォームを表示させ、その結果を受け取る
$result = $form.ShowDialog()
if ($result -eq "Cancel")
{
    exit
}
$x = $textBox_ID.Text
$y = $textBox_Pass.Text
$z = $textBox_filename.Text

$x
$y
$z

pause 