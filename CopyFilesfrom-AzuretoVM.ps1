md -Force C:\Scripts | Out-Null
$URL = "https://1imagestore.blob.core.windows.net/scripts/PasswordPolicy.ps1"
$file = "C:\Scripts\PasswordPolicy.ps1"
Invoke-WebRequest -Uri $URL -OutFile $file