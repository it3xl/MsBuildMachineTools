. "$PSScriptRoot\util\setEnv.ps1"

. $DisableNodeReuse


# Uncomment the workarounds as needed.
# & %env_qManager%\workaround\DevEnv-Vdproj-VS2015-HRESULT-8000000A-EnableOutOfProcBuild.bat
. $FileSystemRedirector
# & %env_qManager%\workaround\MSBuild-Unable-to-create-Temp-directory.bat

"Preparing development environment of Visual Studio."
# We need to invoke the exact preparation script here because after migration from VS2010 to VS2015 we got a broken environment on our Build-Server. It is actual for VS2017 too.
#  and we are getting the empty SDK40ToolsPath.
# MSB3086 Microsoft.Common.targets Task could not find "sgen.exe" using the SdkToolsPath "" or the registry key "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x86". Make sure the SdkToolsPath is set and the tool exists in the correct processor specific location under the SdkToolsPath and that the Microsoft Windows SDK is installed
# http://stackoverflow.com/questions/2731365/running-msbuild-fails-to-read-sdktoolspath
# http://stackoverflow.com/questions/34045326/msbuild-sgen-exe-is-missing
# http://stackoverflow.com/questions/26442450/why-is-visual-studio-2013-using-the-wrong-sdktoolspath-for-lc-exe
#
$env:dev_cmd = "%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"
& %dev_cmd%


# We have to use exactly the "DevEnv.COM" wrapper of the VS IDE "DevEnv.EXE". There are some troubles with "DevEnv.EXE".
# So, here we explicitly prevent cases where ".COM" not the first value at the PATHEXT environment variable.
# Example of the problem - PATHEXT: ".EXE;.COM;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC"
& DevEnv.COM @args

