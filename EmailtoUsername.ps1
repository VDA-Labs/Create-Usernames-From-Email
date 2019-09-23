$EmailPasswordRaw = @()
$EmailRaw = @()
$EmailUsernames = @()
$EmailUsername = @()
$Email = @()
$Username = @()
$Name = @() 
$Names = @()
$Domain = "@Company.com"
$CSVLocation = "C:\Temp\company.csv"

$EmailPasswordRaw = Import-CSV $CSVLocation
$EmailRaw = $EmailPasswordRaw.Username



Foreach ($Email in $EmailRaw)
{
$EmailUsernames += $Email.Split('@')[0]

}

Foreach  ($Emailusername in $EmailUsernames) 
{
$Names += $Emailusername | ForEach-Object {
    [PSCustomObject]@{ Firstname = $Emailusername.Split('.')[0]; Lastname = $Emailusername.Split('.')[1]; }
}
}

Foreach ($Name in $Names)
{
$Username += $Name.Firstname.Substring(0,1) + $Name.Lastname + $Domain

}

$Username
