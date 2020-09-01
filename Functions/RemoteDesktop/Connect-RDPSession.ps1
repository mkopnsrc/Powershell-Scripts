#Load this function only if current user is administrator or member of administrators group
if(IsAdmin){
  Function Connect-RDPSession() {
  <#
  .SYNOPSIS
  None
   
  .DESCRIPTION
  The RDP administrator can use the Shadow session mode to view and remotely manage active RDP session of any user. You can connect using this function command to remotely control user's session.
   
  .EXAMPLE
  Connect-RDPSession Computer_Name OR IP_Address
  Connect-RDPSession -ComputerName Computer_Name OR IP_Address
  Connect-RDPSession -ComputerName Computer_Name OR IP_Address -UserName Logged_on_Username
   
  .INPUTS
  Remote Computer Name
  Remote IP Address
  Logged on Username [Optional - But required when it detects multiple users logged on]
   
  .OUTPUTS
  It connects to logged on user session of a remote pc by creating remote shadow connection
   
  .NOTES
  None
  #>

    [CmdletBinding()]
    Param (
      [Parameter(Mandatory=$true, HelpMessage="Computer Name or IP Address of the destination")] [string] $ComputerName,
      [Parameter(Mandatory=$false, HelpMessage="Username of user session you want to Intercept")] [string] $UserName
    )
    
    Write-Verbose "Running Get-QueryUser function to get all session(s)"
    $Sessions=(Get-QueryUser -ComputerName $ComputerName)
      
      # if $SessionID return single session ID number and $SessionID variable type is string 
      Write-Verbose "Checking if $($ComputerName) computer has single session"
      if (($Sessions.ID.Count -eq 1) -and ($Sessions.ID.GetType().Name -eq 'String')) {
        #Initiate the RDP to connect to remote machine
        Write-Verbose "Connecting to $($ComputerName) with session id $($Sessions.ID)"
          mstsc /V:$($ComputerName) /shadow:$($Sessions.ID) /Control

      # Follow else if $SessionID returns multiple session ID number and $SessionID variable type is object or array
      }else {
          Write-Verbose "$($ComputerName) computer has multiple active sessions, checking if USERNAME was provided as arugment"
          if($UserName) {
              $Session=($Sessions | Where-Object { $_.USERNAME -like "*$UserName*" })
              if (($Session.ID.Count -eq 1) -and ($Session.ID.GetType().Name -eq 'String')) {
                  Write-Verbose "Connecting to $($ComputerName) with session id $($Session.ID)"
                  mstsc /V:$($ComputerName) /shadow:$($Session.ID) /Control
                  Remove-Variable $Session -ErrorAction SilentlyContinue
              }else { Write-Error "Session doesn't exist" }
          }else { Write-Error "Username must be provided due to multiple logged on sessions found on $ComputerName." }
      }
      Remove-Variable $Sessions -ErrorAction SilentlyContinue
  }
}