param(
    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.VirtualMachine]$VirtualMachine,

    [Parameter(Mandatory=$true)]
    [string]$GuestUsername,

    [Parameter(Mandatory=$true)]
    [string]$GuestPassword,

    [Parameter(Mandatory=$true)]
    [string]$BashCommand
)

# Uwierzytelnienie w maszynie wirtualnej
$guestCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $GuestUsername, $GuestPassword

# Wykonanie polecenia
Invoke-VMScript -VM $VirtualMachine -GuestCredential $guestCredential -ScriptText $BashCommand -ScriptType Bash
