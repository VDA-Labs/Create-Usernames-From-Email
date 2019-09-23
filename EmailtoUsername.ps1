$EmailPasswordRaw = @()
$EmailRaw = @()
$EmailUsernames = @()
$EmailUsername = @()
$Email = @()
$Username = @()
$Name = @() 
$Names = @()
$Domain = "haworth"
$TLD = ".com"
$CSVLocation = "C:\Temp\HaworthUsername.csv"
$UsernameatDomain = @()
$UsernameNoDomain = @()
$DomainSlashUsername = @()

#Import CSV file of email addresses and passwords
$EmailPasswordRaw = Import-CSV $CSVLocation
#Remove Passwords from the list
$EmailRaw = $EmailPasswordRaw.Username


#Remove the domain from the email address
Foreach ($Email in $EmailRaw)
{
$EmailUsernames += $Email.Split('@')[0]

}



#Split the email address into a firstname and lastname
Foreach  ($Emailusername in $EmailUsernames) 
{
$Names += $Emailusername | ForEach-Object {
    [PSCustomObject]@{ Firstname = $Emailusername.Split('.')[0]; Lastname = $Emailusername.Split('.')[1]; }
}
}


#Builds username based on internal username structure
Foreach ($Name in $Names)
{
#For use in logins that require the domain name in Name@domainformat
$UsernameatDomain += $Name.Firstname.Substring(0,1) + $Name.Lastname + "@" + $Domain + $TLD
#For use in logins that do not require the domain name
$UsernameNoDomain += $Name.Firstname.Substring(0,1) + $Name.Lastname
#For use in logs that use domain/username
$DomainSlashUsername += $Domain + "/" + $Name.Firstname.Substring(0,1) + $Name.Lastname
}

#Show the various formats that have been created
$UsernameatDomain[1]
$UsernameNoDomain[1]
$DomainSlashUsername[1]
