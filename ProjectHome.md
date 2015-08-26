# Powershell Windows Service Manager #
### By Justin Hyland (jhyland87@gmail.com) ###

**Description:**  Restart/Start/Stop service on a remote or local Windows server via powrshell scripts and parameters passed to the scripts.

This is meant to be used as jenkins job (http://jenkins-ci.org/), to manage services on a remote server. The Server, Service and Action are passed to the powershell script via the jenkins interface.

**NOTE:** For this to work via Jenkins, the jenkins service must have administrative rights on the windows server.