# Pure PowerShell Google Maps Docklands Search Script
# No WSL2/Ubuntu required - Windows native solution

param(
    [string]$DeviceName = "",
    [string]$SearchTerm = "Docklands"
)

Write-Host "🗺️ Pure Windows Google Maps Search Script" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

# Check if ADB is available
try {
    $adbVersion = adb version 2>$null
    if (-not $adbVersion) {
        Write-Host "❌ ADB not found. Please install Android SDK Platform Tools" -ForegroundColor Red
        Write-Host "Download from: https://developer.android.com/studio/releases/platform-tools" -ForegroundColor Yellow
        exit 1
    }
    Write-Host "✅ ADB found" -ForegroundColor Green
} catch {
    Write-Host "❌ ADB not available" -ForegroundColor Red
    exit 1
}

# Check devices
Write-Host "`n📱 Checking connected devices..." -ForegroundColor Yellow
$devices = adb devices 2>$null
if (-not ($devices -match "device$")) {
    Write-Host "❌ No Android devices connected" -ForegroundColor Red
    Write-Host "Please start an emulator or connect a device" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Device(s) found:" -ForegroundColor Green
adb devices | Select-String "device$" | ForEach-Object {
    Write-Host "   $($_.Line)" -ForegroundColor Cyan
}

# Launch Google Maps
Write-Host "`n🚀 Launching Google Maps..." -ForegroundColor Yellow
adb shell am start -n com.google.android.apps.maps/.MapsActivity
Start-Sleep -Seconds 3

# Wait for app to load
Write-Host "⏳ Waiting for Google Maps to load..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Tap on search box (approximate coordinates)
Write-Host "🔍 Tapping search box..." -ForegroundColor Yellow
adb shell input tap 540 200
Start-Sleep -Seconds 2

# Clear any existing text and type "Docklands"
Write-Host "⌨️ Typing '$SearchTerm'..." -ForegroundColor Yellow
adb shell input keyevent 123  # CTRL+A to select all
adb shell input text $SearchTerm
Start-Sleep -Seconds 2

# Press Enter to search
Write-Host "🔎 Searching..." -ForegroundColor Yellow
adb shell input keyevent 66  # Enter key
Start-Sleep -Seconds 3

# Tap on the first search result (approximate coordinates)
Write-Host "📍 Selecting search result..." -ForegroundColor Yellow
adb shell input tap 540 400
Start-Sleep -Seconds 3

# Take a screenshot for verification
Write-Host "📸 Taking screenshot..." -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$screenshotPath = "docklands_search_$timestamp.png"
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png $screenshotPath
adb shell rm /sdcard/screenshot.png

if (Test-Path $screenshotPath) {
    Write-Host "✅ Screenshot saved: $screenshotPath" -ForegroundColor Green
} else {
    Write-Host "⚠️ Screenshot may not have been saved" -ForegroundColor Yellow
}

Write-Host "`n🎉 Test completed!" -ForegroundColor Green
Write-Host "📱 Google Maps should now be showing Docklands location" -ForegroundColor Cyan
Write-Host "📸 Check the screenshot: $screenshotPath" -ForegroundColor Cyan

# Optional: Check if we can find "Docklands" text on screen
Write-Host "`n🔍 Verifying results..." -ForegroundColor Yellow
$screenText = adb shell uiautomator dump /dev/stdout 2>$null
if ($screenText -match "Docklands") {
    Write-Host "✅ 'Docklands' found on screen - Test PASSED" -ForegroundColor Green
} else {
    Write-Host "⚠️ Could not verify 'Docklands' text - Check screenshot manually" -ForegroundColor Yellow
}