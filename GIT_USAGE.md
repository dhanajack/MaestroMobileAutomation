# Git Usage Guide

## What's Ignored

The following files and directories are automatically ignored by git (won't be pushed):

### Test Artifacts
- `*.png`, `*.jpg`, `*.jpeg` - All screenshot files
- `.maestro/` - Maestro test output directory
- `*.log` - Log files
- `*.html`, `*.json`, `*.xml` - Test reports

### macOS Files
- `.DS_Store` - macOS folder metadata
- `._*` - macOS thumbnail files

### IDE Files
- `.idea/` - IntelliJ IDEA
- `.vscode/` - Visual Studio Code

### Other
- `node_modules/` - Dependencies
- `.env` - Environment variables
- `*.tmp`, `*.bak` - Temporary/backup files

## Committing Changes

### Stage Your Changes
```bash
# Stage specific files
git add google-maps/tests/basic-launch.yaml
git add run-tests.sh

# Stage all changes
git add .

# Check what's staged
git status
```

### Commit Changes
```bash
git commit -m "Add Google Maps test cases"
```

### Push to Repository
```bash
git push origin main
```

## Useful Commands

### Check Status
```bash
# See what's changed, staged, and ignored
git status --ignored
```

### View Ignored Files
```bash
# See what git is ignoring
git status --ignored | grep "^!"
```

### Remove File from Git (but keep locally)
```bash
git rm --cached filename.png
```

### Clean Up Untracked Files (careful!)
```bash
# Preview what will be deleted
git clean -n

# Remove untracked files
git clean -f

# Remove untracked files and directories
git clean -fd
```

## Current Branch

You're working on: `main`

## Best Practices

1. ✅ Always check `git status` before committing
2. ✅ Write clear commit messages
3. ✅ Don't commit screenshots or test artifacts
4. ✅ Review changes with `git diff` before committing
5. ✅ Pull latest changes before pushing: `git pull origin main`
