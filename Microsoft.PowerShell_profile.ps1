set-executionpolicy remotesigned -s currentuser
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Avit
# $ThemeSettings.Colors.PromptForegroundColor = $ThemeSettings.Colors.GitForegroundColor
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
$DefaultUser = 'right'

# Visual Studioから起動した際にCtrl-Cを有効化
$code = @"
using System;
using System.Reflection;
using System.Runtime.InteropServices;
public static class CtrlCEnabler
{
    private delegate bool PHANDLER_ROUTINE(UInt32 ctrlType);
    [DllImport("kernel32.dll")]
    private static extern bool SetConsoleCtrlHandler(PHANDLER_ROUTINE handlerRoutine, bool add);
    public static bool EnableCtrlC()
    {
        return SetConsoleCtrlHandler(null, false);
    }
}
"@
Add-Type -TypeDefinition $code -Language CSharp
[void][CtrlCEnabler]::EnableCtrlC()

# Beep音を無効化
Set-PSReadlineOption -BellStyle None

function gh {
	cd $(ghq list -p | peco)
}
if (Test-Path alias:cat) {
	del alias:cat
}
function cat {
	bat $args --paging=never
}

if (Test-Path alias:less) {
	del alias:less
}
function less {
	bat $args
}
