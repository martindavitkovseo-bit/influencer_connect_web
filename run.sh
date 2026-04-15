#!/bin/bash
# Influencer Connect Web - Setup and Run Script

echo "======================================"
echo "Influencer Connect Web Platform"
echo "======================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter from https://flutter.dev"
    exit 1
fi

echo "✓ Flutter found: $(flutter --version | head -1)"
echo ""

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo "✓ Dependencies installed"
echo ""

# Show available options
echo "Choose an option:"
echo "1) Run development server (local)"
echo "2) Build for web (release)"
echo "3) Install dependencies only"
echo ""
read -p "Select option (1-3): " choice

case $choice in
    1)
        echo ""
        echo "🚀 Starting development server..."
        echo "The app will open at http://localhost:5000"
        echo ""
        flutter run -d chrome
        ;;
    2)
        echo ""
        echo "🔨 Building for production..."
        flutter build web --release
        echo "✓ Build complete! Output: build/web/"
        ;;
    3)
        echo "✓ Dependencies installed"
        ;;
    *)
        echo "❌ Invalid option"
        exit 1
        ;;
esac

echo ""
echo "======================================"
echo "Done!"
echo "======================================"
