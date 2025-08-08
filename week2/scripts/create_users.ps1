# Import the AD module so New-ADUser works
Import-Module ActiveDirectory

# Path to the CSV file (adjust path if needed)
$users = Import-Csv "C:\Path\To\users.csv"

foreach ($u in $users) {
    $SecurePass = ConvertTo-SecureString $u.Password -AsPlainText -Force

    New-ADUser `
        -Name "$($u.GivenName) $($u.Surname)" `
        -GivenName $u.GivenName `
        -Surname $u.Surname `
        -SamAccountName $u.Sam `
        -UserPrincipalName "$($u.Sam)@contoso.com" `
        -Path $u.OU `
        -AccountPassword $SecurePass `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    Write-Host "Created user: $($u.Sam)" -ForegroundColor Green
}
