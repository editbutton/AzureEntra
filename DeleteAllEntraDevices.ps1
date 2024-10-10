
$scopes = @("Device.ReadWrite.All","User.Read.All","GroupMember.Read.All","DeviceManagementManagedDevices.ReadWrite.All","DeviceManagementConfiguration.ReadWrite.All")
Connect-MgGraph -Scopes $scopes



# Get all devices associated with the Entra ID
$devices = Get-MgDevice

Write-Host "Total:" $devices.count "devices"

# Delete each device
foreach ($device in $devices) {
    Write-Host "Removing" $device.Id
    Remove-MgDevice -DeviceId $device.Id
}

