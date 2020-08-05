Function Connect-RDPSession() {   
  [CmdletBinding()]
	Param (
		[Parameter(Mandatory=$true)] [string] $ComputerName,
		[Parameter(Mandatory=$false)] [string] $UserName
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
