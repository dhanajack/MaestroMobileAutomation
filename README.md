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

   ### Maestro CLI on Windows
   1. Install Java JDK 17 or higher.
   2. Install `unzip` if you do not already have it.
   3. Download the latest Maestro CLI zip from:
      - `https://github.com/mobile-dev-inc/maestro/releases/latest/download/maestro.zip`
   4. Extract the zip to your Windows user folder:
      - `%USERPROFILE%\.maestro`
   5. Add the Maestro binary folder to your PATH:
      - `%USERPROFILE%\.maestro\bin`
   6. Open a new terminal and verify:
      ```powershell
      maestro --version
      ```

   If you have Git Bash or WSL on Windows, you can also install using the official installer script:
   ```bash
   curl -Ls "https://get.maestro.mobile.dev" | bash
   ```

   ### Android Studio and Emulator Setup on Windows
   1. Install Android Studio and open Device Manager.
   2. Create or start an emulator with Google Play support.
   3. Install Google Maps on the emulator.
   4. Verify ADB works:
      ```powershell
      adb version
      adb devices
      ```
   5. Confirm Maestro is available:
      ```powershell
      maestro --version
      ```
   6. Run tests with:
      ```powershell
      npm run test:android
      npm run test:android:basic
      ```

   > Note: `setup-android-studio.ps1` and `tsconfig.json` were removed. Windows test setup is now documented here in README.

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
