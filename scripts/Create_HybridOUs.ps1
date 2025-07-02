# Create OU structure (excluding Users OU)
$ouStructure = @(
    "OU=Departments,DC=IDSentinelSolutions,DC=com",
    "OU=IT,OU=Departments,DC=IDSentinelSolutions,DC=com",
    "OU=HR,OU=Departments,DC=IDSentinelSolutions,DC=com",
    "OU=Sales,OU=Departments,DC=IDSentinelSolutions,DC=com",
    "OU=Devices,DC=IDSentinelSolutions,DC=com",
    "OU=Workstations,OU=Devices,DC=IDSentinelSolutions,DC=com",
    "OU=Servers,OU=Devices,DC=IDSentinelSolutions,DC=com",
    "OU=Security Tiers,DC=IDSentinelSolutions,DC=com",
    "OU=Tier 0 - Domain Controllers,OU=Security Tiers,DC=IDSentinelSolutions,DC=com",
    "OU=Tier 1 - Servers,OU=Security Tiers,DC=IDSentinelSolutions,DC=com",
    "OU=Tier 2 - Clients,OU=Security Tiers,DC=IDSentinelSolutions,DC=com",
    "OU=Locations,DC=IDSentinelSolutions,DC=com",
    "OU=HQ,OU=Locations,DC=IDSentinelSolutions,DC=com",
    "OU=Remote,OU=Locations,DC=IDSentinelSolutions,DC=com",
    "OU=Groups,DC=IDSentinelSolutions,DC=com",
    "OU=Departments,OU=Groups,DC=IDSentinelSolutions,DC=com",
    "OU=Tiers,OU=Groups,DC=IDSentinelSolutions,DC=com"
)

Write-Host "`nCreating OU structure..." -ForegroundColor Cyan
foreach ($ou in $ouStructure) {
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ou'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name (($ou -split ",")[0] -replace "OU=", "") -Path ($ou -replace "^OU=[^,]+,", "") -ProtectedFromAccidentalDeletion $false
        Write-Host "Created: $ou"
    } else {
        Write-Host "Exists:  $ou"
    }
}

# Create sample security groups
$groups = @(
    @{Name='IT_Group';           OU='OU=Departments,OU=Groups,DC=IDSentinelSolutions,DC=com'},
    @{Name='HR_Group';           OU='OU=Departments,OU=Groups,DC=IDSentinelSolutions,DC=com'},
    @{Name='Sales_Group';        OU='OU=Departments,OU=Groups,DC=IDSentinelSolutions,DC=com'},
    @{Name='Tier0_Group';        OU='OU=Tiers,OU=Groups,DC=IDSentinelSolutions,DC=com'},
    @{Name='Tier1_Group';        OU='OU=Tiers,OU=Groups,DC=IDSentinelSolutions,DC=com'},
    @{Name='Tier2_Group';        OU='OU=Tiers,OU=Groups,DC=IDSentinelSolutions,DC=com'}
)

Write-Host "`nCreating security groups..." -ForegroundColor Cyan
foreach ($g in $groups) {
    $dn = "CN=$($g.Name),$($g.OU)"
    if (-not (Get-ADGroup -Identity $dn -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $g.Name -Path $g.OU -GroupScope Global -GroupCategory Security
        Write-Host "Created: $($g.Name) in $($g.OU)"
    } else {
        Write-Host "Exists:  $($g.Name)"
    }
}

Write-Host "`n✅ OU and Group setup complete." -ForegroundColor Green
