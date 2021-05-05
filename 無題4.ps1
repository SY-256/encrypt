$i=1
$txt = "c:\appl\\data\test.txt"
$enc = [Text.Encoding]::GetEncoding("UTF-8")
$fh = New-Object System.IO.StreamReader($txt, $enc)
$array = @()
while ( ($line = $fh.ReadLine()) -ne $null){
    $array += $line
}
$fh.Close()

. "C:\encrypt\encrypt_2.ps1"

$object = New-Object Encrypt

$Text = $object.RSADecrypto($array[0], $object.PrivateKey)
