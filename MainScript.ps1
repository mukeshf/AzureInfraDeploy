#Download the Build from Azure Storage and copy it to C Drive

$Newfolder = mkdir "C:\Builds"
$customData = Get-Content "C:\AzureData\CustomData.bin"
$separator = ","
$URL = $customData.split($separator)
$Matches = Select-String -InputObject $customData -Pattern "https" -AllMatches
$buildCount = $Matches.Matches.Count

for ($i=0; $i -lt $buildCount; $i++ ){
$buildfilename = $URL[$i].Substring($URL[$i].LastIndexOf("/") + 1)
$buildLocation = "C:\Builds\" + $buildfilename
Invoke-WebRequest -Uri $URL[$i] -OutFile $buildLocation

#Create folder and extract Build files into that folder 
$fileSeparator = "."
if ($fileSeparator -eq "."){
$buildFoldername = $buildfilename.split($fileSeparator)
$buildFolder = $buildFoldername[0]
$extractedFiles = New-Item "C:\Builds\$buildFolder" -ItemType Directory -Force
Expand-Archive $buildLocation  -DestinationPath $extractedFiles
}
}

<#**********************************************************************************#>

#Add VM to Domain

$username = "testnova\testadmin"
$password = "Pass@1234567" | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer –DomainName "testnova.com" –Credential $credential -Restart -Force

