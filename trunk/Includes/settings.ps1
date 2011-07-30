# SETTINGS
# Settings for Windows_Service_Manager.ps1
#

# Service, this will actually be passed via Jenkins
#
$Service="BlueTooth"

# Server, Also passed via Jenkins
#
$Server="localhost"

# Action .... Jenkins
# Possible Actions: Stop, Start, Restart
#
$Action="Restart"

# Force
#
$Force=$False