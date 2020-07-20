# Powershell-Scripts
These Powershell scripts are being used for various tasks to automate and make Windows Admin's life easy and less stresfull.

## Functions
### Get-QueryUser.ps1
Displays information about user sessions on Remote Desktop Host server. You can use this function and command 'Get-QueryUser' to find out if a specific user or to get list of users that are logged on to a specific Remote Desktop Session Host server or workstation.

### Connect-RDPSession.ps1
The RDP administrator can use the Shadow session mode to view and remotely manage active RDP session of any user. You can connect using this function command to remotely control user's session.
Example: Connect-RDPSession -ComputerName Your_Computer_Name_OR_IP_Address -UserName Logged_on_Username
