class Encrypt {
    # propety
    [object] $RSA
    [string] $keys_file
    [string] $crypto_file

    # create Encrypt-Object
    Encrypt($filename) {
        # アセンブリロード
        Add-Type -AssemblyName System.Security
        # RSACryptoServiceProviderオブジェクト作成
        $this.RSA = New-Object System.Security.Cryptography.RSACryptoServiceProvider
        # 格納先
        $file_path = "C:\appl\data\" + $filename
        # 公開鍵・秘密鍵の出力ファイル
        $this.keys_file = $file_path + "_keys.txt"
        # 暗号文
        $this.crypto_file = $file_path + "_crypto.txt" 
    }

    ##################################################
    # 公開鍵 秘密鍵
    ##################################################
    [void] CreateKeys() {
        # 公開鍵生成
        $Public_Key = $this.RSA.ToXmlString($false)
        # 秘密鍵生成
        $Private_Key = $this.RSA.ToXmlString($true)
        # 公開鍵・秘密鍵のファイル出力
        $Public_Key, $Private_Key | Set-Content $this.keys_file -Encoding UTF8
        # Attribute -> Hidden(隠しファイル),Readonly(読み取り専用)に変更
        Set-ItemProperty -path $this.keys_file -name Attributes -value "Hidden, Readonly"
    }

    ##################################################
    # 暗号化
    ##################################################
    [void] RSAEncrypt($Array_Plain_Text) {
        # Keysファイルの読み込み
        $keys_txt = $this.keys_file
        $enc = [Text.Encoding]::GetEncoding("UTF-8")
        $file = New-Object System.IO.StreamReader($keys_txt, $enc)
        $keys_array = @()
        while ($null -ne ($line = $file.ReadLine())){
            $keys_array += $line
        }
        $file.Close()

        # 公開鍵読み込み
        $Public_Key = $keys_array[0]

        # 公開鍵を指定
        $this.RSA.FromXmlString($Public_Key)
        foreach ($Plain_String in $Array_Plain_Text){
                
            # バイト配列生成
            $Byte_Data = [System.Text.Encoding]::UTF8.GetBytes($Plain_String)

            # 暗号化
            $Encrypted_Data = $this.RSA.Encrypt($Byte_Data, $false)

            # 暗号文に変換
            $Encrypted_String = [System.Convert]::ToBase64String($Encrypted_Data)

            # 暗号文のファイル出力
            $Encrypted_String | Out-File $this.crypto_file -Append -Encoding UTF8
        }
        # Attribute -> Readonly(読み取り専用)に変更
        Set-ItemProperty -path $this.crypto_file -name Attributes -value "Readonly"
    }

    ##################################################
    # 復号化
    ##################################################
    [array] RSADecrypt(){
        # Keysファイルの読み込み
        $keys_txt = $this.keys_file
        $enc = [Text.Encoding]::GetEncoding("UTF-8")
        $file = New-Object System.IO.StreamReader($keys_txt, $enc)
        $keys_array = @()
        while ($null -ne ($line = $file.ReadLine())){
            $keys_array += $line
        }
        $file.Close()

        # 秘密鍵読み込み
        $Private_Key = $keys_array[1]
        # 秘密鍵を指定
        $this.RSA.FromXmlString($Private_Key)

        # 暗号ファイルの読み込み
        $crypto_txt = $this.crypto_file
        $enc = [Text.Encoding]::GetEncoding("UTF-8")
        $file = New-Object System.IO.StreamReader($crypto_txt, $enc)
        $Array_PlainString = @()
        while ($null -ne ($Encrypt_String = $file.ReadLine())){
            # バイト配列にする
            $Byte_Data = [System.Convert]::FromBase64String($Encrypt_String)

            # 復号
            $Decrypted_Data = $this.RSA.Decrypt($Byte_Data, $false)

            # 平文にする
            $Plain_Text = [System.Text.Encoding]::UTF8.GetString($Decrypted_Data)

            $Array_PlainString += $Plain_Text
        }
        $file.Close()

        # オブジェクト削除
        $this.RSA.Dispose()
        # 平文を格納した配列を返す
        return $Array_PlainString
    }
}