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

        # 暗号ファイル
        $this.crypto_file = "C:\appl\sp\config\" + $filename

        # 公開鍵・秘密鍵の出力ファイル
        $this.keys_file = $this.crypto_file + ".key"
    }

    ##################################################
    # 公開鍵 秘密鍵
    ##################################################
    [void] CreateKeys() {
        # 公開鍵生成
        $public_key = $this.RSA.ToXmlString($false)

        # 秘密鍵生成
        $private_key = $this.RSA.ToXmlString($true)

        # 公開鍵・秘密鍵のファイル出力
        $public_key, $private_key | Set-Content $this.keys_file -Encoding UTF8

        # Attribute -> Hidden(隠しファイル),Readonly(読み取り専用)に変更
        Set-ItemProperty -path $this.keys_file -name Attributes -value "Hidden, Readonly"
    }

    ##################################################
    # 暗号化
    ##################################################
    [void] RSAEncrypt($array_plain_txt) {
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
        $public_key = $keys_array[0]

        # 公開鍵を指定
        $this.RSA.FromXmlString($public_key)
        foreach ($plain_txt in $array_plain_txt){
                
            # バイト配列生成
            $byte_data = [System.Text.Encoding]::UTF8.GetBytes($plain_txt)

            # 暗号化
            $encrypted_data = $this.RSA.Encrypt($byte_data, $false)

            # 暗号文に変換
            $encrypted_string = [System.Convert]::ToBase64String($encrypted_data)

            # 暗号文のファイル出力
            $encrypted_string | Out-File $this.crypto_file -Append -Encoding UTF8
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
        $private_key = $keys_array[1]
        # 秘密鍵を指定
        $this.RSA.FromXmlString($private_key)

        # 暗号ファイルの読み込み
        $crypto_txt = $this.crypto_file
        $enc = [Text.Encoding]::GetEncoding("UTF-8")
        $file = New-Object System.IO.StreamReader($crypto_txt, $enc)
        $array_plain_txt = @()
        while ($null -ne ($encrypt_string = $file.ReadLine())){
            # バイト配列にする
            $byte_data = [System.Convert]::FromBase64String($encrypt_string)

            # 復号
            $decrypted_data = $this.RSA.Decrypt($byte_data, $false)

            # 平文にする
            $plain_txt = [System.Text.Encoding]::UTF8.GetString($decrypted_data)

            $array_plain_txt += $plain_txt
        }
        $file.Close()

        # 平文を格納した配列を返す
        return $array_plain_txt
    }
}