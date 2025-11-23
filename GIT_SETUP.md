# Git Installation and Commit Guide

## Option 1: Install Git for Windows (Recommended)

1. **Download Git for Windows:**
   - Go to: https://git-scm.com/download/win
   - Download the installer
   - Run the installer with default settings

2. **After installation, restart PowerShell**

3. **Configure Git (first time only):**
   ```powershell
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

4. **Commit your changes:**
   ```powershell
   git add .
   git commit -m "Refactor: Replace Toyota Link with Google Maps automation

   - Remove Toyota Link app dependencies and files
   - Add Google Maps Docklands search automation
   - Create Android Studio setup scripts
   - Add pure PowerShell search script (no WSL2 required)
   - Simplify project structure for better usability
   - Add comprehensive setup and documentation guides"
   ```

## Option 2: Use GitHub Desktop (GUI)

1. **Download GitHub Desktop:**
   - Go to: https://desktop.github.com/
   - Install and set up with your GitHub account

2. **Open this repository in GitHub Desktop**
3. **Review changes and commit with a message**

## Option 3: Manual Commit Message (Copy/Paste)

If you install Git, use this commit message:

```
Refactor: Replace Toyota Link with Google Maps automation

- Remove Toyota Link app dependencies and files
- Add Google Maps Docklands search automation  
- Create Android Studio setup scripts
- Add pure PowerShell search script (no WSL2 required)
- Simplify project structure for better usability
- Add comprehensive setup and documentation guides

Key Changes:
* Removed entire toyota-link/ directory
* Added pure-powershell-search.ps1 for Windows-native testing
* Added setup-android-studio.ps1 for environment setup
* Created google-maps/ folder with Maestro automation files
* Updated README.md with simplified instructions
* Added ANDROID_STUDIO_SETUP.md for detailed guidance
* Cleaned up unwanted files and dependencies
```

## Quick Install Git:

```powershell
# Using winget (if available)
winget install Git.Git

# Or using Chocolatey (if available)
choco install git

# Or download manually from git-scm.com
```

After installing Git, you can commit your changes! 🚀