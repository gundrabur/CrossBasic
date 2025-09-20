#!/bin/bash
# Build script for CrossBasic using PyInstaller

echo "🚀 Building CrossBasic for macOS/Linux..."

# Check if we're in a virtual environment
if [[ "$VIRTUAL_ENV" != "" ]]; then
    echo "✅ Using virtual environment: $VIRTUAL_ENV"
    PYTHON_CMD="python"
else
    # Try to find the virtual environment
    if [ -f ".venv/bin/python" ]; then
        echo "✅ Found .venv, activating..."
        source .venv/bin/activate
        PYTHON_CMD="python"
    else
        echo "⚠️  No virtual environment found, using system Python"
        PYTHON_CMD="python3"
    fi
fi

# Check if PyInstaller is installed
if ! $PYTHON_CMD -m PyInstaller --version &> /dev/null; then
    echo "❌ PyInstaller not found. Installing..."
    $PYTHON_CMD -m pip install pyinstaller
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build/ dist/ *.spec

# Build executable with examples included
echo "🔨 Building executable..."
$PYTHON_CMD -m PyInstaller \
    --onefile \
    --name=crossbasic \
    --add-data="examples:examples" \
    --add-data="README.md:." \
    --add-data="LICENSE:." \
    --hidden-import=pygame \
    --hidden-import=pygame.mixer \
    --hidden-import=pygame.font \
    --exclude-module=tkinter \
    --exclude-module=matplotlib \
    --exclude-module=numpy \
    --optimize=2 \
    crossbasic.py

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📦 Executable created: dist/crossbasic"
    echo "📏 File size: $(du -h dist/crossbasic | cut -f1)"
    echo ""
    cd ..
    echo ""
    echo "🎉 Ready for distribution!"
    echo "   Copy dist/crossbasic to target systems"
else
    echo "❌ Build failed!"
    exit 1
fi
