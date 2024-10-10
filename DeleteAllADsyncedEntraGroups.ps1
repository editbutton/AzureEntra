# Delete all AD Synced groups in Entra ID

Connect-MgGraph -Scopes "Directory.AccessAsUser.All"

# Get all groups in the specified Entra
$groups = Get-MgGroup -Filter "onPremisesSyncEnabled eq true"
Write-Host "Total on-prem groups: " $groups.Count

# Delete each group
foreach ($group in $groups) {
    Write-Host "Removing" $group.MailNickname
    Remove-MgGroup -GroupId $group.Id
}