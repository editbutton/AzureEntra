# Remove all on-prem synced users in Entra

# Import the Microsoft Graph module
Import-Module Microsoft.Graph

# Define the required scopes (permissions)
$scopes = @("User.ReadWrite.All", "Directory.ReadWrite.All")

# Authenticate to Microsoft Graph
$authResult = Connect-MgGraph -Scopes $scopes

# Check if authentication was successful
if ($null -eq $authResult) {
    Write-Host "Authentication failed. Please check your credentials or permissions." -ForegroundColor Red
    exit
}

$users = Get-MgUser -Filter "onPremisesSyncEnabled eq true"

# Delete each user
foreach ($user in $users) {
    Remove-MgUser -UserId $user.Id
}
