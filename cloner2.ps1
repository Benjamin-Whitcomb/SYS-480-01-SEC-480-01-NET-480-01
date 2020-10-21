
function connect {

    $vcenter = Read-Host "vcenter hostname"
    Connect-VIServer $vcenter
    clone

}

function clone {


    $clonetype = Read-Host "What would you like to do? [F]ull clone or [L]inked Clone from Base"

    if ($clonetype -eq "L"){

       linkedimport

    }


    if ($clonetype -eq "F") {

        fullimport

    }

}

function linked {

 Get-Folder | select name

        $basefolder = Read-Host "Which folder contains your base VMs"

        Get-VM -Location $basefolder | select name

        $basevm = Read-Host "Which VM"

        Get-Datastore | select name

        $dstore = Read-Host "select datastore"

        Get-Snapshot -VM $basevm | select name

        $bname = Read-Host "Choose snapshot to clone"

        $snapshot = Get-Snapshot -VM $basevm -name $bname

        $vmname = Read-Host "enter name for new VM"

        $vmhost = Get-VMHost

        $newvm = New-VM -Name $vmname -VM $basevm -LinkedClone -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $dstore -Location $basefolder

        Write-Host "Creating Clone, Check Vcenter"

        exit

        }

function full {

Get-Folder | select name

        $basefolder = Read-Host "Which folder contains your base VMs"

        Get-VM -Location $basefolder | select name

        $basevm = Read-Host "Which VM"

        Get-Datastore | select name

        $dstore = Read-Host "select datastore"

        Get-Snapshot -VM $basevm | select name

        $vmname = Read-Host "enter name for new VM"

        $vmhost = Get-VMHost

        $newvm = New-VM -Name $vmname -VM $basevm -VMHost $vmhost -Datastore $dstore 

        exit

    }

function linkedimport {

$confpath = ".\Untitled2.json"
$conf = ""
 
if (Test-Path $confpath){

$conf = (Get-Content -Raw -Path $confpath | ConvertFrom-Json)

$basefolder = $conf.base_folder
 Get-VM -Location $basefolder | select name

        $basevm = Read-Host "Which VM"
$dstore = $conf.preferred_datastore
Get-Snapshot -VM $basevm | select name

        $bname = Read-Host "Choose snapshot to clone"

        $snapshot = Get-Snapshot -VM $basevm -name $bname
$vmname = Read-Host "VM Name"
$vmhost = $conf.esxi_server

$newvm = New-VM -Name $vmname -VM $basevm -LinkedClone -ReferenceSnapshot $snapshot -VMHost $conf.esxi_server -Datastore $conf.preferred_datastore -Location $conf.basefolder
Get-VM -name $vmname | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $conf.prefered_network
 
 }
 }
connect 


