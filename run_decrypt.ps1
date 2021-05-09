. "C:\encrypt\encrypt_2.ps1"

$Encrypt = New-Object Encrypt('aaa')
#$PlanText1 = "ABCDEFghijk"
#$PlanText2 = ""
#$Array_PlainString = @($PlanText1, $PlanText2)

#$object.CreateKeys()
#$object.RSAEncrypto($Array_PlainString)
$array = $Encrypt.RSADecrypt()
write-host $array[0]
write-host $array[1]

# RSAオブジェクトを破棄
$Encrypt.RSA.Dispose()