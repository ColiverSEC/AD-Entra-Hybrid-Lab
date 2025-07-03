# Import the GroupPolicy module
Import-Module GroupPolicy

# Define your OU distinguished names
$ouList = @(
    "OU=IT,OU=Departments,DC=IDSentinelSolutions,DC=com",
    "OU=HR,OU=Departments,DC=IDSentinelSolutions,DC=com"
)

# Define GPO names corresponding to each OU
$gpoNames = @(
    "IT Security Policy",
    "HR Security Policy"
)

for ($i = 0; $i -lt $ouList.Count; $i++) {
    $ou = $ouList[$i]
    $gpoName = $gpoNames[$i]

    # Create the GPO
    Write-Host "Creating GPO: $gpoName"
    $gpo = New-GPO -Name $gpoName -Comment "Policy for $gpoName" -ErrorAction Stop

    # Link the GPO to the OU
    Write-Host "Linking GPO '$gpoName' to OU: $ou"
    New-GPLink -Name $gpoName -Target $ou -LinkEnabled Yes

    # (Optional) You can add specific settings here, like enabling password policies or other preferences
}

Write-Host "GPO creation and linking completed."
