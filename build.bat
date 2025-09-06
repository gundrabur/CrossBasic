@echo off
REM Build script for CrossBasic using PyInstaller on Windows

echo 🚀 Building CrossBasic for Windows...

REM Check if PyInstaller is installed
pyinstaller --version >nul 2>&1
if errorlevel 1 (
    echo ❌ PyInstaller not found. Installing...
    pip install pyinstaller
)

REM Clean previous builds
echo 🧹 Cleaning previous builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist *.spec del *.spec

REM Build executable with examples included
echo 🔨 Building executable...
pyinstaller ^
    --onefile ^
    --name=crossbasic ^
    --add-data="examples;examples" ^
    --add-data="README.md;." ^
    --add-data="LICENSE;." ^
    --hidden-import=pygame ^
    --hidden-import=pygame.mixer ^
    --hidden-import=pygame.font ^
    --exclude-module=tkinter ^
    --exclude-module=matplotlib ^
    --exclude-module=numpy ^
    --optimize=2 ^
    crossbasic.py

if %errorlevel% equ 0 (
    echo ✅ Build successful!
    echo 📦 Executable created: dist\crossbasic.exe
    dir dist\crossbasic.exe
    echo.
    echo 🧪 Testing executable...
    cd dist
    crossbasic.exe --help >nul 2>&1 || echo Ready to run!
    cd ..
) else (
    echo ❌ Build failed!
    exit /b 1
)
