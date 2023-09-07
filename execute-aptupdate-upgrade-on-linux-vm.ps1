param(
    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.VirtualMachine]$VirtualMachine,

    [Parameter(Mandatory=$true)]
    [string]$GuestUsername,

    [Parameter(Mandatory=$true)]
    [string]$GuestPassword
)

$GuestScriptUpdate = "apt-get update"
$GuestScriptUpgrade = "apt-get upgrade -y"

# Wykonanie aktualizacji
Invoke-VMScript -VM $VirtualMachine -ScriptText $GuestScriptUpdate -GuestUser $GuestUsername -GuestPassword $GuestPassword -ScriptType Bash

# Wykonanie uaktualnień
Invoke-VMScript -VM $VirtualMachine -ScriptText $GuestScriptUpgrade -GuestUser $GuestUsername -GuestPassword $GuestPassword -ScriptType Bash
