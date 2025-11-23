# Google Maps Maestro Automation

This project demonstrates how to use Maestro to automate Google Maps for location searches.

## 🚀 Getting Started

### 📱 Prerequisites

- Maestro installed
- Android emulator or device with Google Maps app
- ADB configured and running

### 📁 Project Structure

```
google-maps/
├── config.yaml
├── data/
│   └── location-data.js
├── functions/
│   ├── search-location.yaml      # Generic location search
│   └── search-docklands.yaml     # Specific Docklands search
└── tests/
    ├── simple-docklands-googlemaps.yaml     # Basic Docklands search
    ├── search-docklands-googlemaps.yaml     # Detailed Docklands search
    └── multiple-location-search.yaml        # Search multiple locations
```

### 🎯 Test Cases

1. **Simple Docklands Search** - Basic search for Docklands location
2. **Detailed Docklands Search** - Search with assertions and validations
3. **Multiple Location Search** - Search for multiple Melbourne locations

### 🏃‍♂️ How to Run

#### Using PowerShell Script (Recommended)
```powershell
.\run-googlemaps-search.ps1 -DeviceName "YourEmulatorName"
```

#### Manual WSL2 Commands
1. Start your emulator and ensure Google Maps is installed
2. In PowerShell:
   ```powershell
   adb -a -P 5037 nodaemon server
   ```
3. In WSL2:
   ```bash
   cd /mnt/c/Users/dkamaraj/Documents/Meastro/maestro
   adb kill-server
   export ADB_SERVER_SOCKET=tcp:YOUR_WINDOWS_IP:5037
   adb devices
   maestro --host YOUR_WINDOWS_IP --device YOUR_DEVICE test google-maps/tests/simple-docklands-googlemaps.yaml
   ```

### 📍 Features

- ✅ Search for specific locations (Docklands)
- ✅ Generic location search function
- ✅ Multiple location searches in sequence
- ✅ Screenshot capture for verification
- ✅ Location verification and assertions
- ✅ GPS location setting for Melbourne context

### 🗺️ Supported Locations

The automation includes predefined searches for:
- Docklands
- Federation Square
- Queen Victoria Market
- Melbourne Zoo
- Royal Botanic Gardens Melbourne

### 🔧 Customization

To search for different locations, modify the `location-data.js` file or set the `SEARCH_LOCATION` variable in your test scripts.