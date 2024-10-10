# Install Microsoft Graph PowerShell module if not already installed
Install-Module Microsoft.Graph -Scope AllUsers

# Import the Microsoft Graph module
Import-Module Microsoft.Graph

# Define the required scopes (permissions) to delete devices
$scopes = @("DeviceManagementManagedDevices.ReadWrite.All")

# Authenticate to Microsoft Graph and get an access token
$authResult = Connect-MgGraph -Scopes $scopes

# Check if authentication was successful
if ($null -eq $authResult) {
    Write-Host "Authentication failed. Please check your credentials or permissions." -ForegroundColor Red
    exit
}

# Confirm that you want to proceed with deleting all devices
$confirmation = Read-Host "Are you sure you want to delete all Intune devices? Type 'yes' to confirm"

if ($confirmation -ne "yes") {
    Write-Host "Operation canceled." -ForegroundColor Yellow
    exit
}

# Retrieve all Intune managed devices from Graph API
$devices = Get-MgDeviceManagementManagedDevice

# Check if there are any devices to delete
if ($devices.Count -eq 0) {
    Write-Host "No devices found in Intune." -ForegroundColor Yellow
    exit
}

# Loop through each device and delete it
foreach ($device in $devices) {
    try {
        Write-Host "Deleting device: $($device.DeviceName) (ID: $($device.Id))" -ForegroundColor Green
        Remove-MgDeviceManagementManagedDevice -ManagedDeviceId $device.Id
    } catch {
        Write-Host "Failed to delete device: $($device.DeviceName). Error: $_" -ForegroundColor Red
    }
}

Write-Host "All devices have been processed." -ForegroundColor Green