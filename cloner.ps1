$check = Read-Host "[C]onnect if not already or [S]kip if already connected"

if ($check -eq "C"){ connect } if ($check -eq "S"){ clone }

function connect {

$vcenter = Read-Host "vcenter hostname"
$username = Read-Host "Username"
$password = Read-Host "Password"
Connect-VIServer $vcenter -user $username -Password $password


clone
}

function clone {

$clonetype = Read-Host "What would you like to do? [F]ull clone or [L]inked Clone from Base"

if ($clonetype -eq "L"){

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


if ($clonetype -eq "F") {

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