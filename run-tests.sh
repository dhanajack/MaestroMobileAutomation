#!/bin/bash

# Maestro Test Runner Script
# Usage: ./run-tests.sh [test-name] [platform] [app-id] [device-name]

set -e

# Default values
PLATFORM=${2:-"android"}
TEST_NAME=${1:-"all"}

# Platform-specific defaults
if [ "$PLATFORM" = "ios" ]; then
    APP_ID=${3:-"com.google.Maps"}
    DEVICE_NAME=${4:-"iPhone 15 Pro"}
    TEST_DIR="google-maps-ios/tests"
else
    APP_ID=${3:-"com.google.android.apps.maps"}
    DEVICE_NAME=${4:-"emulator-5554"}
    TEST_DIR="google-maps/tests"
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Starting Maestro Test Execution${NC}"
echo -e "PLATFORM: ${BLUE}${PLATFORM}${NC}"
echo -e "APP_ID: ${APP_ID}"
echo -e "DEVICE: ${DEVICE_NAME}"
echo -e "TEST: ${TEST_NAME}"
echo "================================"

# Check if maestro is installed
if ! command -v maestro &> /dev/null; then
    echo -e "${RED}❌ Maestro is not installed. Please install it first.${NC}"
    echo "Run: curl -Ls 'https://get.maestro.mobile.dev' | bash"
    exit 1
fi

# Check if device is connected
echo -e "${YELLOW}📱 Checking device connection...${NC}"

if [ "$PLATFORM" = "ios" ]; then
    # Check iOS Simulator
    if ! xcrun simctl list devices | grep -q "Booted"; then
        echo -e "${RED}❌ No iOS Simulator is running. Please start a simulator first.${NC}"
        echo "Run: open -a Simulator"
        exit 1
    fi
else
    # Check Android device
    if ! adb devices | grep -q "${DEVICE_NAME}"; then
        echo -e "${RED}❌ Device ${DEVICE_NAME} not found. Please start your emulator.${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✅ Device connected${NC}"

# Navigate to project directory
cd "$(dirname "$0")"

# Function to run a specific test
run_test() {
    local test_file=$1
    local test_name=$(basename "$test_file" .yaml)
    
    echo -e "${YELLOW}🧪 Running test: ${test_name}${NC}"
    
    if maestro test -e APP_ID="${APP_ID}" "$test_file"; then
        echo -e "${GREEN}✅ Test ${test_name} passed${NC}"
        return 0
    else
        echo -e "${RED}❌ Test ${test_name} failed${NC}"
        return 1
    fi
}

# Main execution logic
case $TEST_NAME in
    "basic-launch")
        run_test "${TEST_DIR}/basic-launch.yaml"
        ;;
    "coordinate-search")
        run_test "${TEST_DIR}/coordinate-based-search.yaml"
        ;;
    "all")
        echo -e "${YELLOW}🔄 Running all ${PLATFORM} tests...${NC}"
        failed_tests=0
        
        for test_file in ${TEST_DIR}/*.yaml; do
            if ! run_test "$test_file"; then
                ((failed_tests++))
            fi
        done
        
        if [ $failed_tests -eq 0 ]; then
            echo -e "${GREEN}🎉 All tests passed!${NC}"
        else
            echo -e "${RED}💥 $failed_tests test(s) failed${NC}"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}❌ Unknown test: $TEST_NAME${NC}"
        echo "Available tests: basic-launch, coordinate-search, all"
        echo "Platforms: android, ios"
        echo ""
        echo "Usage examples:"
        echo "  ./run-tests.sh all android"
        echo "  ./run-tests.sh all ios"
        echo "  ./run-tests.sh basic-launch ios"
        exit 1
        ;;
esac

echo -e "${GREEN}🏁 Test execution completed${NC}"
