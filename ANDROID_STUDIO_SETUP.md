# 🤖 Android Studio + Maestro Setup Guide
# All-in-one solution with Android Studio

## Why Android Studio is Perfect for This:

✅ **Includes ADB** (Android Debug Bridge)
✅ **Built-in Emulator** (no separate emulator needed)
✅ **SDK Manager** (handles all Android tools)
✅ **Device Manager** (easy emulator creation)
✅ **Terminal** (can run Maestro commands)
✅ **One Download** (everything included)

## Step 1: Download Android Studio

1. Go to: https://developer.android.com/studio
2. Download Android Studio for Windows
3. Run the installer (follow default options)

## Step 2: Initial Android Studio Setup

1. **Open Android Studio**
2. **Complete setup wizard:**
   - Choose "Standard" installation
   - Accept licenses
   - Let it download SDK components
3. **Create a new project** (or skip)

## Step 3: Install SDK and Create Emulator

### SDK Setup:
1. Go to **Tools** → **SDK Manager**
2. Install:
   - ✅ Android API 34 (latest)
   - ✅ Android SDK Platform-Tools
   - ✅ Android SDK Build-Tools

### Create Emulator:
1. Go to **Tools** → **Device Manager**
2. Click **"Create Device"**
3. Choose:
   - **Phone** → **Pixel 7** (recommended)
   - **API Level 34** (latest)
   - **Download** the system image
4. **Finish** and **Start** the emulator

## Step 4: Add Android Studio to PATH

### Windows Environment Variables:
1. Open **System Properties** → **Environment Variables**
2. Add to **System PATH**:
   ```
   C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools
   C:\Users\%USERNAME%\AppData\Local\Android\Sdk\tools
   ```

### Or use PowerShell:
```powershell
# Add Android SDK to PATH
$androidSdk = "$env:USERPROFILE\AppData\Local\Android\Sdk"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$currentPath;$androidSdk\platform-tools;$androidSdk\tools"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")
```

## Step 5: Test ADB Connection

```powershell
# Restart PowerShell first, then test:
adb version
adb devices
```

## Step 6: Install Maestro in Android Studio Terminal

Android Studio has a built-in terminal! Use it to install Maestro:

### Option A: Use Android Studio Terminal
1. Open **View** → **Tool Windows** → **Terminal**
2. Install Maestro:
   ```bash
   # If on Windows with Git Bash in Android Studio:
   curl -Ls "https://get.maestro.mobile.dev" | bash
   ```

### Option B: Use PowerShell (Simpler)
```powershell
# Download Maestro for Windows
# Check if they have a Windows release at: https://github.com/mobile-dev-inc/maestro/releases
```

### Option C: Use WSL2 in Android Studio
1. Enable WSL2 in Android Studio
2. Install Ubuntu
3. Install Maestro in Ubuntu

## Step 7: Test Your Setup

1. **Start your emulator** from Android Studio
2. **Install Google Maps** on the emulator
3. **Test with PowerShell:**

```powershell
# Check devices
adb devices

# Install Google Maps (if you have APK)
adb install google-maps.apk

# Or install from Play Store on emulator
```

## Step 8: Run Your Google Maps Test

```powershell
# If Maestro is installed:
maestro test google-maps/tests/simple-docklands-googlemaps.yaml

# Or use our pure PowerShell script:
.\pure-powershell-search.ps1
```

## Android Studio Advantages:

### 🎯 **Everything in One Place:**
- Emulator management
- ADB commands
- Device monitoring
- Log viewing
- Screenshot/recording tools

### 🔧 **Built-in Tools:**
- **Logcat** - See app logs
- **Device Explorer** - Browse device files
- **Layout Inspector** - Inspect UI elements
- **Network Inspector** - Monitor network calls

### 📱 **Easy Emulator Management:**
- Create multiple devices
- Different Android versions
- Easy start/stop
- Snapshot saves

## Quick Test Commands:

```powershell
# Check if everything is working:
adb devices                     # Should show your emulator
adb shell am start -n com.google.android.apps.maps/.MapsActivity  # Launch Google Maps
adb shell input text "Docklands"  # Type text
adb shell screencap /sdcard/test.png  # Take screenshot
adb pull /sdcard/test.png       # Download screenshot
```

This gives you a complete testing environment with just Android Studio + our test scripts! 🚀