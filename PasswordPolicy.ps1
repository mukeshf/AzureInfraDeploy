<#
***The script is designed to configure Network Security Group, Windows Firewall Rules and Windows Password Policies.***
***Author: Mukesh Fulewale***
***Version: 1.0***
#>

##Changing Password Policy for Local(Standalone) Virtual Machine
#Password Policies
net accounts /minpwlen:12 /maxpwage:45 /minpwage:30 /uniquepw:24

#Account Lockout Policies
net accounts /lockoutduration:5 /lockoutthreshold:3 /lockoutwindow:5

#Password Policy for Password Complexity
secedit /export /cfg c:\secpol.cfg
$SecFile = gc C:\secpol.cfg
$SecFile | % { If ($_.ReadCount -eq 7) {$_ -Replace "PasswordComplexity = 0", "PasswordComplexity = 1"} Else{$_} } | Set-Content -Path "C:\secpol.cfg"
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
