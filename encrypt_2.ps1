class Encrypt {
    # propety
    [object] $RSA
    [object] $PublicKey 
    [object] $PrivateKey

    # create Encrypt-Object
    Encrypt() {
        # アセンブリロード
        Add-Type -AssemblyName System.Security
        # RSACryptoServiceProviderオブジェクト作成
        $this.RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider
        # 公開鍵
        $this.PublicKey = $this.RSA.ToXmlString($false)
        # 秘密鍵
        $this.PrivateKey = $this.RSA.ToXmlString($true)
    } 

    
    ##################################################
    # 公開鍵 暗号化
    ##################################################
    [void] RSAEncrypto($PlainString, $PublicKey, $PrivateKey, $file_name) {
        # アセンブリロード
        #Add-Type -AssemblyName System.Security

        # RSACryptoServiceProviderオブジェクト作成
        #$this.RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider

        # バイト配列の生成
        $ByteData = [System.Text.Encoding]::UTF8.GetBytes($PlainString)

        # 公開鍵を指定
        $this.RSA.FromXmlString($PublicKey)

        # 暗号化
        $EncryptedData = $this.RSA.Encrypt($ByteData, $false)

        # 文字列に変換
        $EncryptedString = [System.Convert]::ToBase64String($EncryptedData)
    
        # オブジェクト削除
        $this.RSA.Dispose()

        $keys_path = "C:\appl\data\" + $file_name + "_keys.txt"
        $crypto_path = "C:\appl\data\" + $file_name + "_crypto.text" 
        $PublicKey, $PrivateKey | Set-Content $keys_path -Encoding UTF8
        Set-ItemProperty -path $keys_path -name Attributes -value "Readonly"

        $EncryptedString | Set-Content $crypto_path -Encoding UTF8
        Set-ItemProperty -path $keys_path -name Attributes -value "Hidden, Readonly"
    }

    
    ##################################################
    # 秘密鍵 復号化
    ##################################################
    [string] RSADecrypto($EncryptoString, $PlivateKey){
        # アセンブリロード
        #Add-Type -AssemblyName System.Security

        # バイト配列にする
        $this.ByteData = [System.Convert]::FromBase64String($EncryptoString)

        # RSACryptoServiceProviderオブジェクト作成
        #$this.RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider

        # 秘密鍵を指定
        $this.RSA.FromXmlString($PlivateKey)

        $this.PublicKey | Add-Content "C:\appl\data\test.txt" -Encoding UTF8
        $this.PrivateKey | Add-Content "C:\appl\data\test.txt" -Encoding UTF8

        # 復号
        $this.DecryptedData = $this.RSA.Decrypt($this.ByteData, $false)

        # 文字列にする
        $this.PlainString = [System.Text.Encoding]::UTF8.GetString($this.DecryptedData)

        # オブジェクト削除
        $this.RSA.Dispose()

        return $this.PlainString
    }

}