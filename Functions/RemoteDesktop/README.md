# PS Function Name List
  - Get-QueryUser


### Connect-RDPSession.ps1
The RDP administrator can use the Shadow session mode to view and remotely manage active RDP session of any user. You can connect using this function command to remotely control user's session.

#### Examples
```powershell
Connect-RDPSession Computer_Name OR IP_Address
Connect-RDPSession -ComputerName Computer_Name OR IP_Address
Connect-RDPSession -ComputerName Computer_Name OR IP_Address -UserName Logged_on_Username
```