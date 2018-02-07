#Login-AzureRmAccount
$cred = System.Management.Automation.PSCredential
$a = Add-AzureRMAccount -ServicePrincipal -Tenant "cad48419-b97b-49d7-ada5-ec8163607164" -Credential System.Management.Automation.PSCredential # -EnvironmentName AzureCloud
Select-AzureRMSubscription -SubscriptionId "05a66e83-19de-47b2-98ce-8d101275e5d2" -TenantId "cad48419-b97b-49d7-ada5-ec8163607164"

#Get-AzureRmSubscription
#Adding NSG Rules
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

$rule2 = New-AzureRmNetworkSecurityRuleConfig -Name web-rule -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80

New-AzureRmNetworkSecurityGroup -ResourceGroupName "RG_VM" -Location "centralus" -Name "NSG-FrontEnd" -SecurityRules $rule1,$rule2