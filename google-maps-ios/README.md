# Google Maps iOS Tests

iOS-specific test cases for Google Maps using Maestro.

## 📱 Prerequisites

### For iOS Testing:
- **macOS** (required for iOS Simulator)
- **Xcode** installed with iOS Simulator
- **Google Maps iOS app** installed on simulator
- **Maestro** installed

### Install Xcode Command Line Tools
```bash
xcode-select --install
```

### Install Google Maps on Simulator
1. Open Xcode
2. Launch iOS Simulator (Xcode → Open Developer Tool → Simulator)
3. Open Safari in simulator and download Google Maps from App Store
   OR
4. Install via command line if you have the IPA file:
   ```bash
   xcrun simctl install booted /path/to/GoogleMaps.app
   ```

## 🚀 Running iOS Tests

### List Available iOS Simulators
```bash
xcrun simctl list devices
```

### Start iOS Simulator
```bash
# Start default simulator
open -a Simulator

# Or start specific device
xcrun simctl boot "iPhone 15 Pro"
```

### Run Tests

```bash
# Run all iOS tests
maestro test google-maps-ios/

# Run specific test
maestro test google-maps-ios/tests/basic-launch.yaml
maestro test google-maps-ios/tests/coordinate-based-search.yaml

# Run on specific device
maestro --device "iPhone 15 Pro" test google-maps-ios/tests/basic-launch.yaml
```

## 📋 Test Cases

### 1. Basic Launch (`basic-launch.yaml`)
- **Platform**: iOS
- **Purpose**: Verify Google Maps launches successfully
- **Permissions**: Location access granted
- **Steps**:
  - Set location to Melbourne CBD
  - Launch Google Maps with clear state
  - Grant location permissions
  - Wait for app to load
  - Capture screenshot

### 2. Coordinate-Based Search (`coordinate-based-search.yaml`)
- **Platform**: iOS
- **Purpose**: Test search functionality
- **Steps**:
  - Launch Google Maps
  - Tap on search bar (coordinate-based for iOS)
  - Enter "Docklands Melbourne"
  - Submit search
  - Verify results and capture screenshot

## 🔧 iOS vs Android Differences

| Feature | Android | iOS |
|---------|---------|-----|
| **App ID** | `com.google.android.apps.maps` | `com.google.Maps` |
| **Search Bar Position** | Top (10%) | Top (8%) |
| **Permissions** | Auto-prompted | Must be specified in test |
| **Submit Search** | Enter key | "Search" button or Enter |
| **Device** | Emulator | Simulator |

## 🛠️ Troubleshooting

### Simulator Not Found
```bash
# List available devices
xcrun simctl list devices

# Boot a device
xcrun simctl boot "iPhone 15 Pro"
```

### App Not Installed
```bash
# Check installed apps
xcrun simctl listapps booted

# Install Google Maps
# Download from App Store on simulator
```

### Location Not Working
- Ensure location permissions are granted in test
- Check simulator location settings
- Verify setLocation command in test

## 📊 Current Status

Tests are ready to run on iOS Simulator once Google Maps is installed.

## 📝 Notes

- iOS tests require macOS
- Simulator must be running before tests
- Location permissions must be explicitly granted
- Screenshot names are prefixed with `ios-` to distinguish from Android
