# 暗号化スクリプトのロード
. "C:\appl\sp\script\encrypt.ps1"

# アセンブリの読み込み
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Encrypt = New-Object Encrypt('network_folder')
$array = $Encrypt.RSADecrypt()
$user_ID = $array[0]
$password =  $array[1]

# ネットワークフォルダアクセス
net use "C:\Users\shouh\.ssh" /user:$user_ID $password

# アクセスの成功/失敗判断
if ($? -eq $false) {
    Write-Host "フォルダアクセスに失敗しました"
    $null = [System.Windows.Forms.MessageBox]::Show("フォルダアクセスに失敗しました", "エラー", "OK", "Hand")
    exit 
}

$null = [System.Windows.Forms.MessageBox]::Show("フォルダアクセスに成功しました", "フォルダアクセス", "OK")