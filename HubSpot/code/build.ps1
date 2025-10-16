<#
Simple build helper for the HubSpot Power BI connector (.mproj)
Usage:
  powershell.exe -ExecutionPolicy Bypass -File .\build.ps1 -Configuration Debug
  .\build.ps1 -Configuration Release

What it does:
 - Builds HubSpot.mproj using: dotnet msbuild -> msbuild (PATH) -> MSBuild discovered via vswhere
 - Exits non-zero on failure
 - Reports the resulting .mez path and verifies the file exists
#>
param(
    [string]$Configuration = "Debug",
    [string]$ProjectFile = "HubSpot.mproj"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectPath = Join-Path $scriptDir $ProjectFile
if (-not (Test-Path $projectPath)) {
    Write-Error "Project file not found: $projectPath"
    exit 2
}

Write-Host "Building project: $projectPath (Configuration=$Configuration)"

function Run-CommandAndExitCode([string]$exe, [string[]]$args) {
    Write-Host "Running: $exe $($args -join ' ')"
    & $exe @args
    return $LASTEXITCODE
}

# Try dotnet msbuild first
if (Get-Command dotnet -ErrorAction SilentlyContinue) {
    $rc = Run-CommandAndExitCode dotnet @("msbuild", "$projectPath", "-p:Configuration=$Configuration")
} elseif (Get-Command msbuild -ErrorAction SilentlyContinue) {
    $rc = Run-CommandAndExitCode msbuild @("$projectPath", "/p:Configuration=$Configuration")
} else {
    # Try to locate MSBuild via vswhere
    $vswhere = Join-Path $Env:ProgramFiles(x86) "Microsoft Visual Studio\Installer\vswhere.exe"
    if (Test-Path $vswhere) {
        $installationPath = & $vswhere -latest -products * -requires Microsoft.Component.MSBuild -property installationPath
        if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($installationPath)) {
            Write-Error "vswhere found but couldn't locate an MSBuild-capable instance."
            exit 3
        }
        $msbuildPath = Join-Path $installationPath "MSBuild\Current\Bin\MSBuild.exe"
        if (-not (Test-Path $msbuildPath)) {
            # fallback to older path
            $msbuildPath = Join-Path $installationPath "MSBuild\15.0\Bin\MSBuild.exe"
        }
        if (-not (Test-Path $msbuildPath)) {
            Write-Error "Could not find MSBuild.exe under the Visual Studio installation: $installationPath"
            exit 4
        }
        $rc = Run-CommandAndExitCode $msbuildPath @("$projectPath", "/p:Configuration=$Configuration")
    } else {
        Write-Error "Neither dotnet nor msbuild were found in PATH, and vswhere.exe not available to locate MSBuild. Install Visual Studio or the .NET SDK."
        exit 5
    }
}

if ($rc -ne 0) {
    Write-Error "Build failed with exit code $rc"
    exit $rc
}

$outFile = Join-Path $scriptDir (Join-Path "bin\$Configuration" "HubSpot.mez")
if (Test-Path $outFile) {
    Write-Host "Build succeeded. Output: $outFile"
    exit 0
} else {
    Write-Warning "Build reported success but the expected output was not found: $outFile"
    Get-ChildItem -Path (Join-Path $scriptDir 'bin') -Recurse -File | ForEach-Object { Write-Host $_.FullName }
    exit 6
}
