param(
    [string]$ModuleRoot = "FuseCP/Sources/FuseCP.WebPortal/DesktopModules/FuseCP",
    [switch]$FailOnHardRegressions
)

$ErrorActionPreference = "Stop"

function Get-RgPath {
    $cmd = Get-Command rg -ErrorAction SilentlyContinue
    if ($cmd) {
        return $cmd.Source
    }

    $wingetRg = "C:\Users\mtigg\AppData\Local\Microsoft\WinGet\Packages\BurntSushi.ripgrep.MSVC_Microsoft.Winget.Source_8wekyb3d8bbwe\ripgrep-15.1.0-x86_64-pc-windows-msvc\rg.exe"
    if (Test-Path $wingetRg) {
        return $wingetRg
    }

    throw "ripgrep (rg) not found. Install rg or update Get-RgPath in this script."
}

function Get-PathCount {
    param([string[]]$Lines)

    $map = @{}
    foreach ($line in $Lines) {
        if ($line -match "^(.+?):\d+:") {
            $path = $matches[1] -replace "\\", "/"
            if (-not $map.ContainsKey($path)) {
                $map[$path] = 0
            }
            $map[$path]++
        }
    }

    return $map.GetEnumerator() | Sort-Object Value -Descending
}

$rg = Get-RgPath
$glob = "$ModuleRoot/**/*.{ascx,aspx,master}"

$legacyPattern = '\b(Button1|Button2|Button3)\b|<\s*cpcc:\s*button\b|<\s*cpcc:button\b|fa fa-|FontAwesome'
$oldHtmlPattern = '\s(align|valign|hspace|vspace)\s*=|\sborder\s*=\s*"\d+"'
$widthPattern = '\bwidth\s*=\s*"[^"]+"|style\s*=\s*"[^"]*\bwidth\s*:[^";]+|ItemStyle-Width\s*=\s*"[^"]+"'

$legacyLines = @(& $rg -n --glob $glob -e $legacyPattern)
$oldHtmlLines = @(& $rg -n --glob $glob -e $oldHtmlPattern)
$widthLines = @(& $rg -n --glob $glob -e $widthPattern)
$widthLines = @($widthLines | Where-Object { $_ -notmatch "window\.open\(" })
$inlineScriptLines = @(& $rg -n -P --glob $glob -e "<script(?![^>]*\bsrc\s*=)[^>]*>")

$legacyCount = $legacyLines.Count
$oldHtmlCount = $oldHtmlLines.Count
$widthCount = $widthLines.Count
$inlineCount = $inlineScriptLines.Count

Write-Output "GUI modernization guard summary"
Write-Output "module_root=$ModuleRoot"
Write-Output "legacy_button_icon_hits=$legacyCount"
Write-Output "old_html_attr_hits=$oldHtmlCount"
Write-Output "width_backlog_hits_excluding_popup=$widthCount"
Write-Output "inline_script_candidates=$inlineCount"

if ($legacyCount -gt 0) {
    Write-Output ""
    Write-Output "Top legacy button/icon files:"
    Get-PathCount -Lines $legacyLines | Select-Object -First 20 | ForEach-Object { Write-Output ("{0} ({1})" -f $_.Name, $_.Value) }
}

if ($oldHtmlCount -gt 0) {
    Write-Output ""
    Write-Output "Top old-html-attribute files:"
    Get-PathCount -Lines $oldHtmlLines | Select-Object -First 20 | ForEach-Object { Write-Output ("{0} ({1})" -f $_.Name, $_.Value) }
}

if ($widthCount -gt 0) {
    Write-Output ""
    Write-Output "Top width backlog files (popup excluded):"
    Get-PathCount -Lines $widthLines | Select-Object -First 30 | ForEach-Object { Write-Output ("{0} ({1})" -f $_.Name, $_.Value) }
}

if ($inlineCount -gt 0) {
    Write-Output ""
    Write-Output "Top inline script candidate files:"
    Get-PathCount -Lines $inlineScriptLines | Select-Object -First 30 | ForEach-Object { Write-Output ("{0} ({1})" -f $_.Name, $_.Value) }
}

if ($FailOnHardRegressions -and ($legacyCount -gt 0 -or $oldHtmlCount -gt 0)) {
    throw "Hard regression guard failed (legacy or old-html hits found)."
}
