Import-Module GroupPolicy

# Correct GPO names and matching OU DNs
$gpoOuMap = @{
    "Tier 0 - Domain Controllers Policy" = "OU=Tier 0 - Domain Controllers,OU=Security Tiers,DC=IDSentinelSolutions,DC=com"
    "Tier 1 - Servers Policy"            = "OU=Tier 1 - Servers,OU=Security Tiers,DC=IDSentinelSolutions,DC=com"
    "Tier 2 - Clients Policy"            = "OU=Tier 2 - Clients,OU=Security Tiers,DC=IDSentinelSolutions,DC=com"
}

foreach ($gpoName in $gpoOuMap.Keys) {
    $ou = $gpoOuMap[$gpoName]

    try {
        # Create the GPO if it doesn't already exist
        if (-not (Get-GPO -Name $gpoName -ErrorAction SilentlyContinue)) {
            Write-Host "Creating GPO: $gpoName"
            New-GPO -Name $gpoName -Comment "Baseline policy for $gpoName"
        } else {
            Write-Host "GPO already exists: $gpoName"
        }

        # Link the GPO to the OU
        Write-Host "Linking GPO '$gpoName' to OU: $ou"
        New-GPLink -Name $gpoName -Target $ou -LinkEnabled Yes

    } catch {
        Write-Warning "Error processing GPO '$gpoName': $_"
    }
}

Write-Host "✅ All Security Tier GPOs processed."
