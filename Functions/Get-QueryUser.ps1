Function Get-QueryUser() {

#Requires -RunAsAdministrator
	param
	(
		[Parameter(Mandatory=$false)] [string] $ComputerName,
		[Parameter(Mandatory=$false)] [string] $UserName,
		[switch]$Json,
		[switch]$GetSessionID
	)

	$HT = @()
	if(!$ComputerName){$ComputerName = "$env:COMPUTERNAME";}

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
