. "C:\encrypt\encrypt_2.ps1"

$object = New-Object Encrypt('test2')
#$PlanText1 = "ABCDEFghijk"
#$PlanText2 = ""
#$Array_PlainString = @($PlanText1, $PlanText2)

#$object.CreateKeys()
#$object.RSAEncrypto($Array_PlainString)
$array = $object.RSADecrypt()
write-host $array[0]
write-host $array[1]
