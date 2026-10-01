# WIP
# This entire file is a work-in-progress

[CmdletBinding()]
param (
    [string]$InstallDir = "$PSScriptRoot\nvim-deps"
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue' # Drastically speeds up downloads in PS 5.1

# Enforce TLS 1.2/1.3 for older Windows PowerShell installs
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

# 1. Define target directories
$BinDir     = Join-Path $InstallDir "bin"
$NodeDir    = Join-Path $InstallDir "node"
$GccDir     = Join-Path $InstallDir "w64devkit"
$TempDir    = Join-Path $InstallDir "_temp"

Write-Host "Setting up local directories at: $InstallDir" -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $BinDir, $NodeDir, $GccDir, $TempDir | Out-Null

function Download-And-Extract ($Url, $ZipName, $ExtractSubDir) {
    $ZipPath = Join-Path $TempDir $ZipName
    $DestPath = Join-Path $TempDir $ExtractSubDir
    
    Write-Host "--> Downloading $ZipName..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $Url -OutFile $ZipPath -UseBasicParsing

    Write-Host "--> Extracting $ZipName..." -ForegroundColor DarkYellow
    Expand-Archive -Path $ZipPath -DestinationPath $DestPath -Force
    Remove-Item $ZipPath -Force
    return $DestPath
}

# 2. ripgrep (rg)
$rgOut = Download-And-Extract `
    -Url "https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-pc-windows-msvc.zip" `
    -ZipName "ripgrep.zip" `
    -ExtractSubDir "rg"
Get-ChildItem -Path $rgOut -Filter "rg.exe" -Recurse | Move-Item -Destination (Join-Path $BinDir "rg.exe") -Force

# 3. fd-find (fd)
$fdOut = Download-And-Extract `
    -Url "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-pc-windows-msvc.zip" `
    -ZipName "fd.zip" `
    -ExtractSubDir "fd"
Get-ChildItem -Path $fdOut -Filter "fd.exe" -Recurse | Move-Item -Destination (Join-Path $BinDir "fd.exe") -Force

# 4. tree-sitter CLI
$tsOut = Download-And-Extract `
    -Url "https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.3/tree-sitter-windows-x64.zip" `
    -ZipName "tree-sitter.zip" `
    -ExtractSubDir "ts"
Get-ChildItem -Path $tsOut -Filter "tree-sitter*.exe" -Recurse | Move-Item -Destination (Join-Path $BinDir "tree-sitter.exe") -Force

# 5. Node.js & npm (LTS zip)
$nodeOut = Download-And-Extract `
    -Url "https://nodejs.org/dist/v22.14.0/node-v22.14.0-win-x64.zip" `
    -ZipName "node.zip" `
    -ExtractSubDir "node"
$nodeRoot = (Get-ChildItem -Path $nodeOut -Filter "node.exe" -Recurse).DirectoryName
Get-ChildItem -Path $nodeRoot | Move-Item -Destination $NodeDir -Force

# 6. GCC (w64devkit - includes gcc, g++, make, and busybox)
$gccOut = Download-And-Extract `
    -Url "https://github.com/skeeto/w64devkit/releases/download/v2.0.0/w64devkit-2.0.0.zip" `
    -ZipName "w64devkit.zip" `
    -ExtractSubDir "gcc"
$gccRoot = (Get-ChildItem -Path $gccOut -Filter "gcc.exe" -Recurse).Directory.Parent.FullName
Get-ChildItem -Path $gccRoot | Move-Item -Destination $GccDir -Force

# 7. unzip & wget
# w64devkit includes BusyBox for Windows. In BusyBox, renaming the binary to an
# applet name (unzip.exe, wget.exe) makes it execute that applet natively.
$busyboxExe = Join-Path $GccDir "bin\busybox.exe"
Copy-Item $busyboxExe -Destination (Join-Path $BinDir "unzip.exe") -Force

try {
    Write-Host "--> Downloading standalone wget.exe..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://eternallybored.org/misc/wget/1.21.4/64/wget.exe" `
        -OutFile (Join-Path $BinDir "wget.exe") -UseBasicParsing
} catch {
    Write-Host "--> Wget fallback: using busybox applet" -ForegroundColor DarkGray
    Copy-Item $busyboxExe -Destination (Join-Path $BinDir "wget.exe") -Force
}

# 8. Cleanup temp files
Remove-Item $TempDir -Recurse -Force

# 9. Generate local activation scripts
$activatePs1 = @"
`$EnvRoot = "`$PSScriptRoot"
`$env:PATH = "`$EnvRoot\bin;`$EnvRoot\node;`$EnvRoot\w64devkit\bin;`$env:PATH"
Write-Host "Local Neovim dependencies added to current session PATH." -ForegroundColor Green
"@
Set-Content -Path (Join-Path $InstallDir "activate.ps1") -Value $activatePs1

$launchCmd = @"
@echo off
set "DEPS_ROOT=%~dp0"
set "PATH=%DEPS_ROOT%bin;%DEPS_ROOT%node;%DEPS_ROOT%w64devkit\bin;%PATH%"
if "%~1"=="" (
    nvim
) else (
    nvim %*
)
"@
Set-Content -Path (Join-Path $InstallDir "launch-nvim.cmd") -Value $launchCmd

Write-Host "`nSetup complete! Tools installed to: $InstallDir" -ForegroundColor Green
