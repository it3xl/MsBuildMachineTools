. "$PSScriptRoot\util\setEnv.ps1"

. $DisableNodeReuse


# Uncomment the workarounds as needed.
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
& %env_vs2017_dev_cmd%


& MSBuild @args

