# Android Studio Installation and Setup Script

Write-Host "🤖 Android Studio + Google Maps Testing Setup" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Check if Android Studio is installed
$androidStudioPaths = @(
    "${env:ProgramFiles}\Android\Android Studio\bin\studio64.exe",
    "${env:ProgramFiles(x86)}\Android\Android Studio\bin\studio64.exe",
    "${env:LOCALAPPDATA}\JetBrains\Toolbox\apps\AndroidStudio\ch-0\*\bin\studio64.exe"
)

$studioFound = $false
foreach ($path in $androidStudioPaths) {
    if (Test-Path $path) {
        Write-Host "✅ Android Studio found at: $path" -ForegroundColor Green
        $studioFound = $true
        break
    }
}

if (-not $studioFound) {
    Write-Host "❌ Android Studio not found" -ForegroundColor Red
    Write-Host "📥 Please download and install Android Studio from:" -ForegroundColor Yellow
    Write-Host "   https://developer.android.com/studio" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "After installation, run this script again." -ForegroundColor Yellow
    
    # Open download page
    $openBrowser = Read-Host "Open download page in browser? (y/n)"
    if ($openBrowser -eq 'y' -or $openBrowser -eq 'Y') {
        Start-Process "https://developer.android.com/studio"
    }
    exit
}

# Check for Android SDK
$androidSdkPaths = @(
    "$env:USERPROFILE\AppData\Local\Android\Sdk",
    "$env:ANDROID_HOME",
    "$env:ANDROID_SDK_ROOT"
)

$sdkFound = $false
$sdkPath = ""
foreach ($path in $androidSdkPaths) {
    if ($path -and (Test-Path "$path\platform-tools")) {
        Write-Host "✅ Android SDK found at: $path" -ForegroundColor Green
        $sdkPath = $path
        $sdkFound = $true
        break
    }
}

if (-not $sdkFound) {
    Write-Host "⚠️ Android SDK not found" -ForegroundColor Yellow
    Write-Host "Please open Android Studio and:" -ForegroundColor White
    Write-Host "1. Go to Tools → SDK Manager" -ForegroundColor Cyan
    Write-Host "2. Install Android SDK Platform-Tools" -ForegroundColor Cyan
    Write-Host "3. Install at least one Android API level" -ForegroundColor Cyan
    
    $defaultSdkPath = "$env:USERPROFILE\AppData\Local\Android\Sdk"
    Write-Host "Expected SDK location: $defaultSdkPath" -ForegroundColor Yellow
} else {
    # Add SDK to PATH if not already there
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $platformTools = "$sdkPath\platform-tools"
    
    if ($currentPath -notlike "*$platformTools*") {
        Write-Host "🔧 Adding Android SDK to PATH..." -ForegroundColor Yellow
        $newPath = "$currentPath;$platformTools"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        $env:Path = "$env:Path;$platformTools"
        Write-Host "✅ Added to PATH" -ForegroundColor Green
    }
}

# Test ADB
Write-Host "`n📱 Testing ADB connection..." -ForegroundColor Yellow
try {
    if ($sdkPath) {
        $adbPath = "$sdkPath\platform-tools\adb.exe"
        if (Test-Path $adbPath) {
            $adbVersion = & $adbPath version 2>$null
            Write-Host "✅ ADB is working!" -ForegroundColor Green
            Write-Host "$adbVersion" -ForegroundColor Cyan
            
            # Check for devices
            $devices = & $adbPath devices 2>$null
            if ($devices -match "device$") {
                Write-Host "✅ Android device(s) connected:" -ForegroundColor Green
                & $adbPath devices
            } else {
                Write-Host "⚠️ No devices connected" -ForegroundColor Yellow
                Write-Host "Please start an Android emulator from Android Studio" -ForegroundColor White
            }
        }
    } else {
        Write-Host "⚠️ Could not test ADB - SDK path not found" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠️ ADB test failed" -ForegroundColor Yellow
}

Write-Host "Next Steps:" -ForegroundColor Green
Write-Host "1. Open Android Studio" -ForegroundColor White
Write-Host "2. Create/Start an Android emulator (Tools -> Device Manager)" -ForegroundColor White
Write-Host "3. Install Google Maps on the emulator" -ForegroundColor White
Write-Host "4. Run: .\pure-powershell-search.ps1" -ForegroundColor Cyan

Write-Host "`nAndroid Studio Setup Checklist:" -ForegroundColor Yellow
Write-Host "□ Android Studio installed" -ForegroundColor White
Write-Host "□ SDK installed (Tools → SDK Manager)" -ForegroundColor White
Write-Host "□ Emulator created (Tools → Device Manager)" -ForegroundColor White
Write-Host "□ Google Maps installed on emulator" -ForegroundColor White
Write-Host "□ Emulator running and connected" -ForegroundColor White

Write-Host "Test Commands:" -ForegroundColor Green
Write-Host "adb devices                 # Check connected devices" -ForegroundColor Cyan
Write-Host "adb shell pm list packages | findstr maps  # Check if Google Maps installed" -ForegroundColor Cyan
Write-Host ".\pure-powershell-search.ps1              # Run Docklands search test" -ForegroundColor Cyan