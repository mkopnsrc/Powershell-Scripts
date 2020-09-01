# Powershell-Scripts
These Powershell scripts are being used for various tasks to automate and make Windows Admin's life easy and less stresfull.

## Functions
### Get-QueryUser.ps1
Displays information about user sessions on Remote Desktop Host server. You can use this function and command 'Get-QueryUser' to find out if a specific user session or to get list of users session that are logged on to a specific Remote Desktop Session Host server or workstation. This scripts requires elevated admin access to be able to execute.

* Examples
> Get-QueryUser Computer_Name OR IP_Address
> Get-QueryUser -ComputerName Computer_Name OR IP_Address -Json

### Connect-RDPSession.ps1
The RDP administrator can use the Shadow session mode to view and remotely manage active RDP session of any user. You can connect using this function command to remotely control user's session.

* Examples
> Connect-RDPSession Computer_Name OR IP_Address
> Connect-RDPSession -ComputerName Computer_Name OR IP_Address
> Connect-RDPSession -ComputerName Computer_Name OR IP_Address -UserName Logged_on_Username
