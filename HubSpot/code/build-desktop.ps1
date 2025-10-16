param(
    [string]$MakePath = "C:\Users\DanMarshall\.vscode\extensions\powerquery.vscode-powerquery-sdk-0.6.3-win32-x64\.nuget\Microsoft.PowerQuery.SdkTools.2.146.1\tools\MakePQX.exe",
    [string]$Src      = "C:\Users\DanMarshall\OneDrive - Kno2\Github\powerbi-custom-connectors\HubSpot\code",
    [string]$TargetName = "Kno2HubSpotConnector"  # base name; .mez is appended
)

$onedriveDesktop = "C:\Users\DanMarshall\OneDrive - Kno2\Desktop"

# If the user provided an absolute path for TargetName, treat it as the full target base.
# Otherwise, place the target on the OneDrive Desktop (user requested default).
if ([System.IO.Path]::IsPathRooted($TargetName)) {
    $targetBase = $TargetName
} else {
    $targetBase = Join-Path $onedriveDesktop $TargetName
}

if (-not (Test-Path $MakePath)) {
    Write-Error "MakePQX not found: $MakePath`nInstall the Power Query SDK or update the MakePath parameter."
    exit 2
}
if (-not (Test-Path $Src)) {
    Write-Error "Source folder not found: $Src"
    exit 3
}

Write-Host "Compiling Kno2 HubSpot Connector..."
# Run compiler and capture exit code + output
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $MakePath
$psi.Arguments = "compile `"$Src`" -t `"$targetBase`""
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.UseShellExecute = $false
$proc = [System.Diagnostics.Process]::Start($psi)
$stdout = $proc.StandardOutput.ReadToEnd()
$stderr = $proc.StandardError.ReadToEnd()
$proc.WaitForExit()
Write-Host $stdout
if ($proc.ExitCode -ne 0) {
    Write-Error "MakePQX failed with exit code $($proc.ExitCode)`n$stderr"
    exit $proc.ExitCode
}

# Resolve output (.mez or accidental .mez.mez)
$candidate1 = "$targetBase.mez"
$candidate2 = "$targetBase.mez.mez"
$outFile = $null

if (Test-Path $candidate1) {
    $outFile = $candidate1
} elseif (Test-Path $candidate2) {
    Rename-Item $candidate2 $candidate1 -Force
    $outFile = $candidate1
}

if ($outFile) {
    Write-Host "`n✅ Build succeeded!`nMEZ created at: $outFile"

    $pbifolder = Join-Path $env:USERPROFILE "Documents\Power BI Desktop\Custom Connectors"
    if (!(Test-Path $pbifolder)) {
        New-Item -ItemType Directory -Path $pbifolder | Out-Null
    }

    Copy-Item $outFile $pbifolder -Force
    Write-Host "Copied to Power BI connectors folder: $pbifolder"
    exit 0
} else {
    Write-Error "`n❌ Build failed or file not found. Look for output on Desktop: $desktop"
    exit 4
}