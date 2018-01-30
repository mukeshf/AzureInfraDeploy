$customData = Get-Content "C:\AzureData\CustomData.bin"
$separator = ","
$URL = $customData.split($separator)
$Matches = Select-String -InputObject $customData -Pattern "https" -AllMatches
$buildCount = $Matches.Matches.Count

for ($i=0; $i -lt $buildCount; $i++ ){

$buildfilename1 = $URL[$i].Substring($URL[$i].LastIndexOf("/") + 1)
$fileSeparator1 = "."
if ($fileSeparator1 -eq "."){
$buildFoldername1 = $buildfilename1.split($fileSeparator1)
$buildFolder1 = $buildFoldername1[0]
$path1 = Test-Path "C:\Builds\$buildFolder1\Nova_Shell.exe"
if($path1){
#Copy-Item -Path "C:\Builds\$buildFolder1\Nova_Shell.exe" -Destination "$env:USERPROFILE\Desktop"
$Shell = New-Object -ComObject ("WScript.Shell")
$ShortCut = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\Nova_Shell.lnk")
$ShortCut.TargetPath="C:\Builds\$buildFolder1\Nova_Shell.exe"
$ShortCut.Save()
}
$path2 = Test-Path "C:\Builds\$buildFolder1\Debug\LivaNova.GenSim.WPF.exe"
if($path2){
#Copy-Item -Path "C:\Builds\$buildFolder1\Debug\LivaNova.GenSim.WPF.exe" -Destination "$env:USERPROFILE\Desktop"
$Shell = New-Object -ComObject ("WScript.Shell")
$ShortCut = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\LivaNova.GenSim.WPF.lnk")
$ShortCut.TargetPath="C:\Builds\$buildFolder1\Debug\LivaNova.GenSim.WPF.exe"
$ShortCut.Save()
}
}
}

<#**********************************************************************************#>

#Network Drive Mapping

New-PSDrive –Name “m” –PSProvider FileSystem –Root “\\livanovafs.testnova.com\SharedFolder” –Persist