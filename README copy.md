# Maestro Mobile Testing Project

Automated mobile UI testing for Google Maps using Maestro framework.

**Platforms Supported**: Android & iOS

### � Best Practices

- Tests use **coordinate-based tapping** instead of element IDs for better compatibility across different Google Maps versions
- All tests include **location setup** for consistent results
- **Screenshots are captured** at key points for debugging
- Tests use **clearState** to ensure clean starting conditions
- **Waits and timeouts** are included to handle loading states

## 🔄 Platform Differences

| Feature | Android | iOS |
|---------|---------|-----|
| **App ID** | `com.google.android.apps.maps` | `com.google.Maps` |
| **Device Type** | Emulator | Simulator |
| **Search Bar Y-Position** | 10% | 8% |
| **Permissions** | Auto-prompted | Must be specified |
| **Submit Search** | Enter key | "Search" button or Enter |
| **Screenshots** | Standard naming | Prefixed with `ios-` |
| **Requirements** | Android SDK | macOS + Xcode |ick Start

### Prerequisites
- Maestro installed (`curl -Ls "https://get.maestro.mobile.dev" | bash`)
- **For Android**: Android SDK Platform Tools (ADB), Android Emulator
- **For iOS**: macOS with Xcode and iOS Simulator
- Google Maps installed on device/simulatorobile Testing Project

Automated mobile UI testing for Google Maps using Maestro framework.

##  Quick Start

### Prerequisites
- Maestro installed (`curl -Ls "https://get.maestro.mobile.dev" | bash`)
- Android SDK Platform Tools (ADB)
- Android Emulator or physical device
- Google Maps installed on device

### Installation

1. Install Maestro:
   ```bash
   curl -Ls "https://get.maestro.mobile.dev" | bash
   ```

2. Install Android Platform Tools (macOS):
   ```bash
   brew install --cask android-platform-tools
   ```

3. Clone this repository

### Running Tests

```bash
# Android Tests
./run-tests.sh all android                    # Run all Android tests
./run-tests.sh basic-launch android           # Run specific Android test
./run-tests.sh coordinate-search android      # Run search test on Android

# iOS Tests
./run-tests.sh all ios                        # Run all iOS tests
./run-tests.sh basic-launch ios               # Run specific iOS test
./run-tests.sh coordinate-search ios          # Run search test on iOS

# Run directly with Maestro
maestro test google-maps/tests/basic-launch.yaml                    # Android
maestro test google-maps-ios/tests/basic-launch.yaml                # iOS
```

## 📁 Project Structure

```
Maestro/
├── google-maps/                             # Android Tests
│   ├── config.yaml                          # Maestro configuration
│   ├── README.md                            # Android-specific docs
│   └── tests/
│       ├── basic-launch.yaml                # Simple app launch test
│       └── coordinate-based-search.yaml     # Location search test
├── google-maps-ios/                         # iOS Tests
│   ├── config.yaml                          # iOS Maestro configuration
│   ├── README.md                            # iOS-specific docs
│   └── tests/
│       ├── basic-launch.yaml                # iOS app launch test
│       └── coordinate-based-search.yaml     # iOS location search test
├── run-tests.sh                             # Cross-platform test runner
├── README.md                                # This file
└── .gitignore                               # Git ignore rules
```

## 🧪 Test Cases

### Android Tests (`google-maps/`)

#### 1. Basic Launch
**File**: `basic-launch.yaml`  
**Purpose**: Verify Google Maps launches successfully  
**Tags**: `smoke`, `launch`

**Steps**:
- Set location to Melbourne CBD
- Launch Google Maps with clear state
- Wait for app to load
- Capture screenshot

#### 2. Coordinate-Based Search
**File**: `coordinate-based-search.yaml`  
**Purpose**: Test search functionality using coordinate tapping  
**Tags**: `search`, `functional`

**Steps**:
- Launch Google Maps
- Tap on search bar (using coordinates for better compatibility)
- Enter "Docklands Melbourne"
- Submit search
- Verify results loaded and capture screenshot

### iOS Tests (`google-maps-ios/`)

Same test cases adapted for iOS with:
- iOS-specific app ID (`com.google.Maps`)
- Location permissions explicitly granted
- Adjusted UI coordinates for iOS interface
- iOS-specific screenshots (prefixed with `ios-`)

## 🛠️ Test Results & Debugging

Test artifacts (screenshots, logs) are automatically saved in:
```
~/.maestro/tests/<timestamp>/
```

**Note**: Screenshots and test artifacts are excluded from git via `.gitignore` to keep the repository clean.

Each test run creates a new directory with:
- Screenshots at key points
- Maestro execution logs
- UI hierarchy dumps
- AI analysis reports (if enabled)

## 📊 Current Status

✅ **Android Tests**: All passing (2/2)  
⚠️  **iOS Tests**: Ready to run (requires iOS Simulator with Google Maps installed)

## 🔧 Configuration

### Android
- **App ID**: `com.google.android.apps.maps`
- **Default Device**: `emulator-5554`
- **Test Location**: Melbourne CBD (-37.8136, 144.9631)

### iOS
- **App ID**: `com.google.Maps`
- **Default Device**: `iPhone 15 Pro`
- **Test Location**: Melbourne CBD (-37.8136, 144.9631)
- **Permissions**: Location access auto-granted in tests

## � Best Practices

- Tests use **coordinate-based tapping** instead of element IDs for better compatibility across different Google Maps versions
- All tests include **location setup** for consistent results
- **Screenshots are captured** at key points for debugging
- Tests use **clearState** to ensure clean starting conditions
- **Waits and timeouts** are included to handle loading states

## 🎯 Useful Commands

### Android Device Management
```bash
# List connected devices
adb devices

# Start emulator
emulator -avd <device_name>
```

### iOS Device Management
```bash
# List available iOS Simulators
xcrun simctl list devices

# Start iOS Simulator
open -a Simulator

# Boot specific device
xcrun simctl boot "iPhone 15 Pro"

# Check booted simulators
xcrun simctl list devices | grep Booted
```

### App Management
```bash
# Android - Check if Google Maps is installed
adb shell pm list packages | grep maps

# Android - Clear app data
adb shell pm clear com.google.android.apps.maps

# iOS - List installed apps
xcrun simctl listapps booted | grep -i maps
```

### Maestro Debugging
```bash
# Run with verbose output
maestro test --debug-output google-maps/tests/basic-launch.yaml

# Record test execution
maestro test --record google-maps/tests/coordinate-based-search.yaml
```

## 🤝 Contributing

This project demonstrates clean, maintainable mobile test automation. Feel free to add more test cases following the same patterns.

## 📚 Resources

- [Maestro Documentation](https://maestro.mobile.dev/)
- [Maestro API Reference](https://maestro.mobile.dev/api-reference/commands)
- [Maestro Best Practices](https://maestro.mobile.dev/best-practices/best-practices)
