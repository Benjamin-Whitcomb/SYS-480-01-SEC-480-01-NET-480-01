
function connect {

    $vcenter = Read-Host "vcenter hostname"
    Connect-VIServer $vcenter
    

}
function NetworkAdapt {
  
    Get-VM
    $vmname = Read-Host "Which VM would you like to modify?"
    Get-VM $vmname | Get-NetworkAdapter
    $netadapt = Read-Host "Which Adapter would you like to modify?"
    Get-VirtualNetwork | select-object "name"
    $network = read-host  "Which Network would you like to set this adapter to?"
    Get-VM -name $vmname | Get-NetworkAdapter -Name $netadapt | Set-NetworkAdapter -NetworkName $network 

    
}

function getIP {

Get-VM
$vmname = Read-Host "Which VM would you like the IP address for?"
$vm = get-vm $vmname
write-host $vm.Guest.IPAddress[0] hostname=$vm

}



#connect
#NetworkAdapt
getIP
