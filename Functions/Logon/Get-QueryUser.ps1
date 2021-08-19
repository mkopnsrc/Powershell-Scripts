#Load this function only if current user is administrator or member of administrators group
if(IsLocalAdmin){
  Function Get-QueryUser() {
  <#
  .SYNOPSIS
  None
   
  .DESCRIPTION
  Displays information about user sessions on Remote Desktop Host server. You can use this function and command 'Get-QueryUser' to find out if a specific user session or to get list of users session that are logged on to a specific Remote Desktop Session Host server or workstation. This scripts requires elevated admin access to be able to execute.
   
  .EXAMPLE
  Get-QueryUser Computer_Name OR IP_Address
  Get-QueryUser -ComputerName Computer_Name OR IP_Address
  Get-QueryUser -ComputerName Computer_Name OR IP_Address -UserName Logged_on_Username
   
  .INPUTS
  Remote Computer Name
  Remote IP Address
  Logged on Username [Optional - But required when it detects multiple users logged on]
   
  .OUTPUTS
  Lists logged on sessions from remote host
   
  .NOTES
  None
  #>

    param
    (
      [Parameter(Mandatory=$false, HelpMessage="Computer Name or IP Address of the destination")] [string] $ComputerName,
      [switch]$Json,
      [switch]$GetSessionID
    )

    $HT = @()
    if(!$ComputerName){$ComputerName = "$env:COMPUTERNAME";}
      
      try {
        $Lines = @(query user /server:$ComputerName).foreach({$(($_) -replace('\s{2,}',','))}) # REPLACES ALL OCCURENCES OF 2 OR MORE SPACES IN A ROW WITH A SINGLE COMMA
        $header=@("COMPUTERNAME")+$($Lines[0].split(',').trim())  # EXTRACTS THE FIRST ROW FOR ITS HEADER LINE BUT ALSO PROVIDING COMPUTERNAME HEADER MANUALLY IN FRONT
        #Write-Host "Header: "$header
        for($i=1;$i -lt $($Lines.Count);$i++){ # NOTE $i=1 TO SKIP THE HEADER LINE

          $Res = "" | Select-Object $header # CREATES AN EMPTY PSCUSTOMOBJECT WITH PRE DEFINED FIELDS
          $Line = $($Lines[$i].split(',')).foreach({ $_.trim().trim('>') }) # SPLITS AND THEN TRIMS ANOMALIES

          if($Line.count -eq 5) { $Line = @($ComputerName,$Line[0],"$($null)",$Line[1],$Line[2],$Line[3],$Line[4] ) } # ACCOUNTS FOR DISCONNECTED SCENARIO
          if($Line.count -eq 6) { $Line = @($ComputerName,$Line[0],$Line[1],$Line[2],$Line[3],$Line[4],$Line[5] ) } # ACCOUNTS FOR CONNECTED SCENARIO

          for($x=0;$x -lt $($Line.count);$x++){
            $Res.$($header[$x]) = $Line[$x] # DYNAMICALLY ADDS DATA TO $Res
          }
          $HT += $Res # APPENDS THE LINE OF DATA AS PSCUSTOMOBJECT TO AN ARRAY

          Remove-Variable Res # DESTROYS THE LINE OF DATA BY REMOVING THE VARIABLE
        }

        if($Json) {
          $JsonObj = [pscustomobject]@{ $($ComputerName)=$HT } | convertto-json  # CREATES ROOT ELEMENT OF COMPUTERNAME AND ADDS THE COMPLETED ARRAY
          Return $JsonObj
        }
        if($GetSessionID){
          Return $HT.ID
        }
        if((!$Json) -and !($GetSessionID) ) { Return $HT; Remove-Variable HT }
      }
      catch {
          #make the distinction between no results vs. query failure
          if($_.exception.message -ne 'No User exists for *'){
              Write-Error $_.exception.message
          }
      }
  }
}