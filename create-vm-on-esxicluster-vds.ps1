param(
    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.VirtualMachine]$Template,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.Cluster]$Cluster,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.DatastoreManagement.Datastore]$Datastore,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.Vds.Types.V1.VDSwitch]$DistributedSwitch,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.Vds.Types.V1.VDPortgroup]$PortGroup,

    [Parameter(Mandatory=$true)]
    [string]$VMNameBase,

    [Parameter(Mandatory=$false)]
    [int]$NumCPU = 2,

    [Parameter(Mandatory=$false)]
    [int]$MemoryGB = 4,

    [Parameter(Mandatory=$true)]
    [int]$Count = 1
)

for ($i = 1; $i -le $Count; $i++) {
    $VMName = "${VMNameBase}_$i"
    # Tworzenie VM z wybranego szablonu
    New-VM -Template $Template -Name $VMName -ResourcePool $Cluster -Datastore $Datastore -OSCustomizationSpec "MyCustomSpec" -Location (Get-Folder -Name "MyFolder")

    # Konfiguracja sieci dla nowej VM
    $networkAdapter = Get-NetworkAdapter -VM $VMName
    Set-NetworkAdapter -NetworkAdapter $networkAdapter -Portgroup $PortGroup -Confirm:$false

    # Konfiguracja procesora i pamięci
    Set-VM -VM $VMName -NumCpu $NumCPU -MemoryGB $MemoryGB -Confirm:$false
}
