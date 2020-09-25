

# This workaround is actual if your run your bulids under the Local System account.
#
# For any build under the system local account (Local System for our Build-Server's Win Service) there is a bug for implicit switching
#  from C:\Windows\System32\config\systemprofile to C:\Windows\SysWOW64\config\systemprofile\AppData
# A workaround for this is to use x64 MSBuild but we have no this option for DevEnv calling.
#
# It is important to modify the CMD environment by this workaround before running MSBuild or DevEnv Command Prompts.
# E.g. VsDevCmd.bat installs some .NET stuff into the current AppData folder.
# And possibly DevEnv will be using C:\Windows\system32\... again for the Local System account.
# Workaround info-URLs:
# https://social.msdn.microsoft.com/Forums/en-US/70f80ccd-9e15-49db-94ea-4564dfc1e593/msbuild-failure-what-permissions-are-needed-to-build-workflow-projects-compileworkflowtask?forum=msbuild
# https://msdn.microsoft.com/en-us/library/windows/desktop/aa384187%28v=vs.85%29.aspx?f=255&MSPPError=-2147217396
# http://stackoverflow.com/questions/9096208/cannot-build-workflow-project-with-msbuild-sharepoint-2010/9097079
# https://connect.microsoft.com/VisualStudio/feedback/details/1580569/32-bit-msbuild-exe-running-as-local-system-calls-64-bit-vbcscompiler-exe-causing-csc-error-cs2001-source-file-file-could-not-be-found
#
# My workaround allows to eliminate any use of x64 MSBuild that was proposed in the URLs above.

# $env:homeRootRelative=Jenkins-Home
# $env:homeRootRelative=CCN-Home
$env:homeRootRelative=Build-Server-Home

"$env:HOMEPATH  is switched to"
$env:HOMEPATH=\$env:homeRootRelative
"$env:HOMEPATH"

$env:homeRootAbsolute=$env:SystemDrive:\$env:homeRootRelative

"$env:APPDATA  is switched to"
$env:APPDATA=$env:homeRootAbsolute\AppData\Roaming
"$env:APPDATA"

"$env:LOCALAPPDATA  is switched to"
$env:LOCALAPPDATA=$env:homeRootAbsolute\AppData\Local
"$env:LOCALAPPDATA"

"$env:TEMP  is switched to"
$env:TEMP=$env:homeRootAbsolute\TEMP
"$env:TEMP"

"$env:TMP  is switched to"
$env:TMP=$env:homeRootAbsolute\TEMP
"$env:TMP"

"$env:USERPROFILE  is switched to"
$env:USERPROFILE=$env:homeRootAbsolute
"$env:USERPROFILE"


# The \TEMP folder must exist otherwise there will be errors. MSBuild & DevEnv can't create it that is mad!
if(!(Test-Path "$env:homeRootAbsolute\TEMP" -PathType Container)){
    New-Item -ItemType Directory -Force -Path "$env:homeRootAbsolute\TEMP"
}

# The \AppData\Local\Temp folder must exist otherwise there will be errors. MSBuild & DevEnv can't create it that is mad!
if(!(Test-Path "$env:LOCALAPPDATA\Temp" -PathType Container)){
    New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\Temp"
}

