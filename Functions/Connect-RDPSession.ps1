Function Connect-RDPSession() {   
	param
	(
		[Parameter(Mandatory=$true)] [string] $ComputerName,
		[Parameter(Mandatory=$false)] [string] $UserName
	)

	$SessionID=Get-QueryUser -ComputerName $ComputerName -GetSessionID

	//Initiate the RDP to connect to remote machine
	mstsc /V:$ComputerName /shadow:$SessionID /Control
    
}
