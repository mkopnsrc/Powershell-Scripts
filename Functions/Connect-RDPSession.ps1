Function Connect-RDPSession() {   
	param
	(
		[Parameter(Mandatory=$true)] [string] $ComputerName,
		[Parameter(Mandatory=$false)] [string] $UserName
	)

	$Sessions=(Get-QueryUser -ComputerName $ComputerName)
    
    # if $SessionID return single session ID number and $SessionID variable type is string 
    if (($Sessions.ID.Count -eq 1) -and ($Sessions.ID.GetType().Name -eq 'String')) {
	    #Initiate the RDP to connect to remote machine
	    #Write-Host "Connecting to $($ComputerName) with session id $($Sessions.ID)"
        mstsc /V:$($ComputerName) /shadow:$($Sessions.ID) /Control

    # Follow else if $SessionID returns multiple session ID number and $SessionID variable type is object or array
    }else {
        if($UserName) {
            $Session=($Sessions | Where-Object { $_.USERNAME -like "*$UserName*" })
            if (($Session.ID.Count -eq 1) -and ($Session.ID.GetType().Name -eq 'String')) {
                mstsc /V:$($ComputerName) /shadow:$($Session.ID) /Control
                Remove-Variable $Session -ErrorAction SilentlyContinue
            }else { Write-Error "Session doesn't exist" }
        }else { Write-Error "Username must be provided due to multiple logged on sessions found on $ComputerName." }
    }
    Remove-Variable $Sessions -ErrorAction SilentlyContinue
}
