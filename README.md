# MaestroMobileAutomation
# Maestro Mobile Automation Framework 

## Overview
This framework combines the power of Maestro for mobile automation testing with TypeScript and AI capabilities for intelligent test generation and maintenance.

## Project Structure
```
maestro-mobile-ai/
├── src/
│   ├── core/
│   │   ├── ai/
│   │   │   ├── imageRecognition.ts
│   │   │   ├── testGeneration.ts
│   │   │   └── selfHealing.ts
│   │   ├── config/
│   │   │   ├── deviceConfig.ts
│   │   │   └── environmentConfig.ts
│   │   └── utils/
│   │       ├── logger.ts
│   │       └── reporter.ts
│   ├── tests/
│   │   ├── e2e/
│   │   ├── smoke/
│   │   └── regression/
│   ├── pages/
│   │   └── screens/
│   └── data/
│       ├── testData/
│       └── aiModels/
├── flows/
│   └── maestro/
├── reports/
└── config/
    └── maestro.yaml
```

## Features

### 1. AI Capabilities
- **Intelligent Test Generation**
  - AI-powered test scenario creation
  - Dynamic test data generation
  - Smart test prioritization

- **Self-Healing Tests**
  - Automatic element locator updates
  - Dynamic wait handling
  - Smart retry mechanisms

- **Image Recognition**
  - OCR capabilities
  - Visual validation
  - Dynamic element detection

### 2. Core Framework Features
- TypeScript support
- Page Object Model
- Custom reporting
- Parallel execution
- Cross-platform support
- CI/CD integration

## Setup Instructions

1. **Prerequisites**
   ```bash
   Node.js (v16 or higher)
   TypeScript
   Android SDK
   Java JDK 17 or higher
   unzip
   ```

2. **Installation**
   ```bash
   npm install
   ```

   ### Maestro Studio on Windows - Complete Installation Guide

   #### Step 1: Install Prerequisites
   - Java JDK 17 or higher
   - Node.js (v16 or higher)
   - Android SDK
   - Git Bash or WSL2 (optional but recommended)

   #### Step 2: Install Android Studio
   1. Download and install [Android Studio](https://developer.android.com/studio)
   2. Open Android Studio and complete initial setup
   3. Go to **View → Tool Windows → Device Manager**
   4. Create a new virtual device or use an existing emulator with Google Play support

   #### Step 3: Configure Java Environment
   Open PowerShell as Admin and set up Java:
   ```powershell
   $javaHome = "C:\Program Files\Java\jdk-17" # Adjust path based on your JDK installation
   [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHome, "User")
   ```

   #### Step 4: Add Android to PATH
   Open PowerShell as Admin and run:
   ```powershell
   $androidSdk = "$env:USERPROFILE\AppData\Local\Android\Sdk"
   $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
   $newPath = "$currentPath;$androidSdk\platform-tools;$androidSdk\tools"
   [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
   ```

   #### Step 5: Test ADB
   Open a new PowerShell terminal and verify ADB is accessible:
   ```powershell
   adb version
   adb devices
   ```

   #### Step 6: Install Maestro
   **Option A - Using Android Studio Terminal (Recommended):**
   1. Open **View → Tool Windows → Terminal** in Android Studio
   2. Run the official installer script:
      ```bash
      curl -Ls "https://get.maestro.mobile.dev" | bash
      ```

   **Option B - Manual Installation:**
   1. Download the latest Maestro CLI zip from:
      - `https://github.com/mobile-dev-inc/maestro/releases/latest/download/maestro.zip`
   2. Extract to your Windows user folder:
      - `%USERPROFILE%\.maestro`
   3. Add the Maestro binary folder to your PATH:
      - `%USERPROFILE%\.maestro\bin`
   4. Verify installation:
      ```powershell
      maestro --version
      ```

   **Option C - Using WSL2:**
   1. Enable WSL2 in Android Studio
   2. Install Maestro in Ubuntu terminal:
      ```bash
      curl -Ls "https://get.maestro.mobile.dev" | bash
      ```

   #### Step 7: Configure Google Maps
   1. Start an emulator in Device Manager
   2. Install Google Maps from Play Store on the emulator
   3. Verify emulator is accessible via ADB:
      ```powershell
      adb devices
      ```

   #### Step 8: Run Tests
   Once setup is complete, run Maestro tests:
   ```powershell
   npm run test:android
   npm run test:android:basic
   ```

   > Note: `npm test` runs Jest in this project and is not the Android Maestro test runner.

3. **Configuration**
   - Set up environment variables
   - Configure devices in `deviceConfig.ts`
   - Set up AI model parameters

4. **Running Tests**
   ```bash
   # Run app tests using the Android test runner
   npm run test:android

   # Run a single Android test
   npm run test:android:basic
   ```

   > Note: `npm test` runs Jest in this project and is not the Android Maestro test runner.

## AI Integration

### 1. Test Generation
```typescript
import { AITestGenerator } from '../core/ai/testGeneration';

const generator = new AITestGenerator();
await generator.createTestScenarios({
  feature: 'login',
  complexity: 'high',
  platform: ['android', 'ios']
});
```

### 2. Self-Healing
```typescript
import { SelfHealingManager } from '../core/ai/selfHealing';

const healer = new SelfHealingManager();
await healer.initializeHealing({
  maxAttempts: 3,
  healingStrategies: ['xpath', 'accessibility', 'image']
});
```

## Best Practices

1. **AI Model Management**
   - Regular model updates
   - Version control for AI models
   - Performance monitoring

2. **Test Organization**
   - Maintain clear test hierarchy
   - Separate concerns
   - Follow naming conventions

3. **Reporting**
   - AI-enhanced reporting
   - Visual test results
   - Failure analysis

## CI/CD Integration

- Jenkins Pipeline support
- GitHub Actions workflows
- Azure DevOps integration
- Docker containerization

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## Support

For support and queries, contact:
- QETS Practice
- Automation COE

## License
Copyright © 2025 Capgemini. All rights reserved.
