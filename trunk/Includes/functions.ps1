# FUNCTONS
# Functions for Windows_Service_Manager.ps1
#

# DoExit function, just so I can make it pause now, or alert later, or whatever..
#
Function DoExit () {
	Write-Host "Press any key to continue ...."`n
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit
}

# Restart Service Function
#
Function RestartService () {
	# Is it asked to be forced? If so, Try to ask the service to forcefully kill itself
	#
	if ( $Force -eq $True ) {
		Write-Host "Killing Process ID $ProcessID (Forcefully) ... " -NoNewLine
		Stop-Service -Name $Service -force -ErrorAction SilentlyContinue
		if ( $? -eq $False ) {
			# If that failed, try to kill the process ID..
			#
			Stop-Process -Id $ProcessID -Force -ErrorAction SilentlyContinue
			if ( $? -eq $False ) {
				Write-Host "Failed"
				DoExit
			}
			else {
				Write-Host "Success"
			}
		}
		else {
			Write-Host "Success"
		}
		
	}
	else {
		Write-Host "Killing Process ID $ProcessID (Gracefully) ... " -NoNewLine
		Stop-Process -Id $ProcessID -Force -ErrorAction SilentlyContinue
		if ( $? -eq $False ) {
			Write-Host "Failed"
			DoExit
		}
		else {
			Write-Host "Success"
		}
	}
	
	# Ok, its stopped, lets start it back up
	#
	Write-Host "Starting up service $Service ... " -NoNewLine
	Start-Service -Name $Service -ErrorAction SilentlyContinue
	if ( $? -eq $False ) {
		Write-Host "Failed"
	}
	else {
		Write-Host "Success"
	}
}

# Stop Service Function
#
Function StopService () {
	# Is it asked to be forced? If so, Try to ask the service to forcefully kill itself
	#
	if ( $Force -eq $True ) {
		Write-Host "Killing Process ID $ProcessID (Forcefully) ... " -NoNewLine
		Stop-Service -Name $Service -force -ErrorAction SilentlyContinue
		if ( $? -eq $False ) {
			# If that failed, try to kill the process ID..
			#
			Stop-Process -Id $ProcessID -Force -ErrorAction SilentlyContinue
			if ( $? -eq $False ) {
				Write-Host "Failed"
				DoExit
			}
			else {
				Write-Host "Success"
			}
		}
		else {
			Write-Host "Success"
		}
		
	}
	else {
		Write-Host "Killing Process ID $ProcessID (Gracefully) ... " -NoNewLine
		Stop-Process -Id $ProcessID -Force -ErrorAction SilentlyContinue
		if ( $? -eq $False ) {
			Write-Host "Failed"
			DoExit
		}
		else {
			Write-Host "Success"
		}
	}
}

Function StartService () {
	Write-Host "Starting up service $Service ... " -NoNewLine
	Start-Service -Name $Service -ErrorAction SilentlyContinue
	if ( $? -eq $False ) {
		Write-Host "Failed"
	}
	else {
		Write-Host "Success"
	}
}