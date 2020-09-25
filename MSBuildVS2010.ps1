. "$PSScriptRoot\util\setEnv.ps1"

. $DisableNodeReuse







"Preparing development environment of Visual Studio."
# We need to invoke the exact preparation script here because after migration from VS2010 to VS2015 we got a broken environment on our Build-Server. It is actual for VS2017 too.
# MSB3086 Microsoft.Common.targets Task could not find "sgen.exe" using the SdkToolsPath "" or the registry key "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x86". Make sure the SdkToolsPath is set and the tool exists in the correct processor specific location under the SdkToolsPath and that the Microsoft Windows SDK is installed
# http://stackoverflow.com/questions/2731365/running-msbuild-fails-to-read-sdktoolspath
# http://stackoverflow.com/questions/34045326/msbuild-sgen-exe-is-missing
# http://stackoverflow.com/questions/26442450/why-is-visual-studio-2013-using-the-wrong-sdktoolspath-for-lc-exe
#
# VS2010 has no "MSBuild Command Prompt"!
$env:dev_cmd = "%ProgramFiles(x86)%\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
& %dev_cmd%


& MSBuild @args


