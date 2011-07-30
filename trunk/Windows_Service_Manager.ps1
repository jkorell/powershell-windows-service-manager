# Windows_Service_Manager.ps1
# By: Justin Hyland
# Desc: Will take arguments (Server, Service, Action, Force/Graceful), and execute the 
# Appropriate commands on $Server and run $Action on $Service with $Force
# P.S.... This is totally my first powershell script.. Cross yer fingers!
#

clear-host

# Include Settings
# This is just temporary for troubleshooting, it will be passed via jenkins later
#
. .\Includes\settings.ps1

# Include Functions
#
. .\Includes\functions.ps1
#Write-Host "$Service $Server $Action $Force"`n

# Check all strings for value
#
if ( !$Service -or !$Server -or !$Action ) {
	Write-Host "Service, Server or Action is empty or null"`n
	DoExit
}

# Get the correct Name for the selected Service
#
switch ( $Service ) {
	BlueTooth 	{ 	$Service = "bthserv"
					#Write-Host "You chose" $Service
					break }
					
	default		{ 	Write-Host "IDK wtf you picked"
					DoExit
					break }
}

# Test the connection to the $Server
#
Write-Host "Checking Connection to $Server... " -NoNewLine
if( ( Test-Connection $Server -quiet ) -ne $True ) {
	Write-Host "Failed"
	Write-Host "Unable to connect to the target server"
	DoExit
}
else {
	Write-Host "Success"
}

# Get Service Information, and make sure theres a result
#
$wmiItems = Get-WmiObject -query "Select Name, Caption, ProcessID, State, Status, DisplayName, ExitCode, Description From Win32_Service Where Name='$Service'"

if( !$wmiItems ) {
	Write-Host "No WMI Object returned for a service named $Service"
	DoExit
} 
else { 
	$Caption 		= $wmiItems.Caption
	$ProcessID		= $wmiItems.ProcessID
	$Status			= $wmiItems.Status
	$State			= $wmiItems.State
	$DisplayName	= $wmiItems.DisplayName
}

# Perform the correct function depending on the $Action value
# Note: The $Service and $Force are already set.. No need to set them
#
switch ( $Action ) {
	Restart	{ 	RestartService
				break }
	Stop	{ 	StopService
				break }
	Start	{ 	StartService
				break }
	default	{ 	Write-Host "Unknown Action"
				DoExit }
}
