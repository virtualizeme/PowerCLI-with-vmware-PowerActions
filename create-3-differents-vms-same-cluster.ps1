param(
    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.VirtualMachine]$Template1,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.VirtualMachine]$Template2,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.VirtualMachine]$Template3,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.Inventory.Cluster]$Cluster,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.ViCore.Types.V1.DatastoreManagement.Datastore]$Datastore,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.Vds.Types.V1.VDSwitch]$DistributedSwitch,

    [Parameter(Mandatory=$true)]
    [VMware.VimAutomation.Vds.Types.V1.VDPortgroup]$PortGroup,

    [Parameter(Mandatory=$true)]
    [string]$VMNameBase1,
    
    [Parameter(Mandatory=$true)]
    [string]$VMNameBase2,
    
    [Parameter(Mandatory=$true)]
    [string]$VMNameBase3,

    [Parameter(Mandatory=$false)]
    [int]$NumCPU = 2,

    [Parameter(Mandatory=$false)]
    [int]$MemoryGB = 4
)

# Tworzenie VM z Template1
New-VM -Name $VMNameBase1 -Template $Template1 -Datastore $Datastore -ResourcePool $Cluster -Location $Cluster -NetworkName $PortGroup.Name -VMHost $Cluster -NumCpu $NumCPU -MemoryGB $MemoryGB

# Tworzenie VM z Template2
New-VM -Name $VMNameBase2 -Template $Template2 -Datastore $Datastore -ResourcePool $Cluster -Location $Cluster -NetworkName $PortGroup.Name -VMHost $Cluster -NumCpu $NumCPU -MemoryGB $MemoryGB

# Tworzenie VM z Template3
New-VM -Name $VMNameBase3 -Template $Template3 -Datastore $Datastore -ResourcePool $Cluster -Location $Cluster -NetworkName $PortGroup.Name -VMHost $Cluster -NumCpu $NumCPU -MemoryGB $MemoryGB
