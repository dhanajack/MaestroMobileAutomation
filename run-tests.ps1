param(
    [string]$TestName = "all",
    [string]$Platform = "android",
    [string]$AppId,
    [string]$DeviceName
)

Set-StrictMode -Version Latest
Set-Location -Path $PSScriptRoot

if ($Platform -eq 'ios') {
    if (-not $AppId) { $AppId = 'com.google.Maps' }
    if (-not $DeviceName) { $DeviceName = 'iPhone 15 Pro' }
    $TestDir = 'src/google-maps-ios/tests'
} else {
    if (-not $AppId) { $AppId = 'com.google.android.apps.maps' }
    if (-not $DeviceName) { $DeviceName = 'emulator-5554' }
    $TestDir = 'src/google-maps-android/tests'
}

# Resolve absolute test directory path based on script location
$TestDirPath = Join-Path -Path $PSScriptRoot -ChildPath $TestDir

function Write-Info([string]$message) {
    Write-Host $message -ForegroundColor Yellow
}

function Write-Success([string]$message) {
    Write-Host $message -ForegroundColor Green
}

function Write-ErrorAndExit([string]$message) {
    Write-Host $message -ForegroundColor Red
    exit 1
}

Write-Info "Starting Maestro Test Execution"
Write-Host "PLATFORM: $Platform"
Write-Host "APP_ID: $AppId"
Write-Host "DEVICE: $DeviceName"
Write-Host "TEST: $TestName"
Write-Host "================================"

$maestroExe = $null
$maestroCmd = Get-Command maestro -ErrorAction SilentlyContinue
if ($maestroCmd) {
    $maestroExe = $maestroCmd.Source
} else {
    $localMaestro = Join-Path $env:USERPROFILE '.maestro\bin\maestro.bat'
    if (Test-Path $localMaestro) {
        $maestroExe = $localMaestro
    }
}

if (-not $maestroExe) {
    Write-ErrorAndExit "Maestro is not installed. Please install it first or ensure ~/.maestro/bin is available."
}

Write-Info "Checking device connection..."

if ($Platform -eq 'ios') {
    $booted = & xcrun simctl list devices | Select-String -Pattern 'Booted' -Quiet
    if (-not $booted) {
        Write-ErrorAndExit "No iOS Simulator is running. Please start a simulator first."
    }
} else {
    $adbCommand = $null
    $adbCmdInfo = Get-Command adb -ErrorAction SilentlyContinue
    if ($adbCmdInfo) {
        $adbCommand = $adbCmdInfo.Source
    } else {
        $sdkPaths = @(
            $env:ANDROID_HOME,
            $env:ANDROID_SDK_ROOT,
            "$env:USERPROFILE\AppData\Local\Android\Sdk"
        ) | Where-Object { $_ }

        foreach ($sdkPath in $sdkPaths) {
            $candidate = Join-Path -Path $sdkPath -ChildPath 'platform-tools\adb.exe'
            if (Test-Path $candidate) {
                $adbCommand = $candidate
                break
            }
        }
    }

    if (-not $adbCommand) {
        Write-ErrorAndExit "ADB is not available. Please install Android SDK Platform-Tools and add adb to PATH, or set ANDROID_HOME / ANDROID_SDK_ROOT."
    }

    $deviceFound = $false
    try {
        $deviceFound = & $adbCommand devices | Select-String -Pattern $DeviceName -Quiet
    } catch {
        Write-ErrorAndExit "Failed to run adb. Ensure Android SDK Platform-Tools are installed and adb is executable."
    }

    if (-not $deviceFound) {
        Write-ErrorAndExit "Device $DeviceName not found. Please start your emulator and verify with 'adb devices'."
    }
}

Write-Success "Device connected"

function Run-Test {
    param(
        [string]$TestFile
    )

    $testName = [System.IO.Path]::GetFileNameWithoutExtension($TestFile)
    Write-Info "Running test: $testName"

    & "$maestroExe" test -e "APP_ID=$AppId" $TestFile
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Test $testName passed"
        return $true
    }

    Write-Host "Test $testName failed" -ForegroundColor Red
    return $false
}

switch ($TestName) {
    'basic-launch' {
        if (-not (Run-Test (Join-Path $TestDirPath 'basic-launch.yaml'))) { exit 1 }
        break
    }
    'coordinate-search' {
        if (-not (Run-Test (Join-Path $TestDirPath 'coordinate-based-search.yaml'))) { exit 1 }
        break
    }
    'all' {
        Write-Info "Running all $Platform tests..."
        $failedTests = 0

        if (-Not (Test-Path $TestDirPath)) {
            Write-ErrorAndExit "Test directory not found: $TestDirPath"
        }

        Get-ChildItem -Path $TestDirPath -Filter '*.yaml' | ForEach-Object {
            if (-not (Run-Test $_.FullName)) {
                $failedTests++
            }
        }

        if ($failedTests -eq 0) {
            Write-Success "All tests passed!"
        } else {
            Write-Host "$failedTests test(s) failed" -ForegroundColor Red
            exit 1
        }
        break
    }
    Default {
        Write-ErrorAndExit "Unknown test: $TestName`nAvailable tests: basic-launch, coordinate-search, all`nPlatforms: android, ios`n`nUsage examples:`n  .\\run-tests.ps1 all android`n  .\\run-tests.ps1 all ios`n  .\\run-tests.ps1 basic-launch ios"
    }
}

Write-Success "Test execution completed"
