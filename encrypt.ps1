
##################################################
# 公開鍵 暗号化
##################################################
function RSAEncrypto($PublicKey, $PlainString){
    # アセンブリロード
    Add-Type -AssemblyName System.Security

    # バイト配列にする
    $ByteData = [System.Text.Encoding]::UTF8.GetBytes($PlainString)

    # RSACryptoServiceProviderオブジェクト作成
    $RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider

    # 公開鍵を指定
    $RSA.FromXmlString($PublicKey)

    # 暗号化
    $EncryptedData = $RSA.Encrypt($ByteData, $False)

    # 文字列にする
    $EncryptedString = [System.Convert]::ToBase64String($EncryptedData)

    # オブジェクト削除
    $RSA.Dispose()

    return $EncryptedString
}