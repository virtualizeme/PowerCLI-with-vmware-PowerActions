[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.VirtualMachine]$VirtualMachine,

    [Parameter(Mandatory=$true)]
    [string]$GuestUsername,

    [Parameter(Mandatory=$true)]
    [System.Security.SecureString]$GuestPassword,

    [Parameter(Mandatory=$true)]
    [string]$DomainName
)

# Tworzenie obiektu PSCredential z podanego użytkownika i hasła
$GuestCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $GuestUsername, $GuestPassword

# Instalacja roli AD i DNS
$installAdCommand = @"
Import-Module ServerManager
Add-WindowsFeature AD-Domain-Services,DNS
"@

Invoke-VMScript -VM $VirtualMachine -GuestCredential $GuestCredential -ScriptText $installAdCommand -ScriptType Powershell

# Konfiguracja domeny
$configureDomainCommand = @"
Import-Module ADDSDeployment
Install-ADDSDomain `
    -NewDomainName $DomainName `
    -DomainMode Win2016 `
    -ForestMode Win2016 `
    -DatabasePath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -NoRebootOnCompletion:$true `
    -Force:$true
Restart-Computer -Force
"@

Invoke-VMScript -VM $VirtualMachine -GuestCredential $GuestCredential -ScriptText $configureDomainCommand -ScriptType Powershell
