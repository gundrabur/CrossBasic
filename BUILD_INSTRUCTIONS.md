# CrossBasic Build Instructions

This document explains how to build CrossBasic into standalone executables for different platforms.

## 🎯 Quick Start

### For Current Platform (Recommended)
```bash
# macOS/Linux
./build.sh

# Windows
build.bat
```

## 🔧 Manual Building with PyInstaller

### Prerequisites
```bash
pip install pyinstaller
```

### Basic Build Commands

#### Single File Executable (Recommended)
```bash
# macOS/Linux/Windows
pyinstaller --onefile --add-data "examples:examples" crossbasic.py
```

#### With All Features
```bash
pyinstaller \
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
```

## 📦 Build Results

After building, you'll get:
- **macOS**: `dist/crossbasic` (~15-20MB)
- **Windows**: `dist/crossbasic.exe` (~15-25MB)  
- **Linux**: `dist/crossbasic` (~15-25MB)

## 🚀 Distribution

The resulting executables are completely standalone and include:
- ✅ Python interpreter
- ✅ All dependencies (pygame, etc.)
- ✅ CrossBasic interpreter code
- ✅ All example programs
- ✅ Documentation

### What Users Need
- **Nothing!** Just download and run the executable
- No Python installation required
- No pip packages to install
- No setup or configuration needed

## 🔄 Cross-Platform Building

### From macOS
```bash
# For macOS (native)
./build.sh

# For Windows (requires Windows VM/container)
# Use GitHub Actions or Windows machine

# For Linux (requires Linux VM/container)  
# Use Docker or Linux machine
```

### From Windows
```batch
REM For Windows (native)
build.bat

REM For macOS/Linux - use CI/CD
```

### From Linux
```bash
# For Linux (native)
./build.sh

# For Windows/macOS - use CI/CD
```

## 🤖 Automated CI/CD Building

### GitHub Actions Example
Create `.github/workflows/build.yml`:

```yaml
name: Build CrossBasic
on: [push, pull_request]

jobs:
  build:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    
    runs-on: ${{ matrix.os }}
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.12'
        
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install pygame pyinstaller
        
    - name: Build executable
      run: |
        pyinstaller --onefile --add-data "examples:examples" crossbasic.py
        
    - name: Upload artifacts
      uses: actions/upload-artifact@v3
      with:
        name: crossbasic-${{ matrix.os }}
        path: dist/
```

## 🛠️ Alternative Build Tools

### 1. cx_Freeze
```bash
pip install cx_freeze
python setup_cx.py build
```

### 2. Nuitka (Fastest Performance)
```bash
pip install nuitka
python -m nuitka --onefile --include-data-dir=examples=examples crossbasic.py
```

### 3. Auto-py-to-exe (GUI Interface)
```bash
pip install auto-py-to-exe
auto-py-to-exe
```

## 📊 Comparison of Build Tools

| Tool | File Size | Build Time | Performance | Ease of Use |
|------|-----------|------------|-------------|-------------|
| PyInstaller | ~15-25MB | Medium | Good | ⭐⭐⭐⭐⭐ |
| Nuitka | ~10-20MB | Slow | Excellent | ⭐⭐⭐ |
| cx_Freeze | ~15-30MB | Fast | Good | ⭐⭐⭐⭐ |

## 🐛 Troubleshooting

### Common Issues

#### "Module not found" errors
```bash
# Add missing modules explicitly
pyinstaller --hidden-import=missing_module crossbasic.py
```

#### Large file sizes
```bash
# Exclude unnecessary modules
pyinstaller --exclude-module=tkinter --exclude-module=numpy crossbasic.py
```

#### macOS "App can't be opened" 
```bash
# Allow unsigned applications
sudo spctl --master-disable
# Or sign the app (requires developer account)
```

#### Windows antivirus warnings
- Add executable to antivirus whitelist
- Use official code signing certificate

## ✅ Testing Built Executables

### Basic Test
```bash
# Test that it starts
./dist/crossbasic
# Type: quit

# Test example loading
echo 'load "examples/basic/example1.bas"' | ./dist/crossbasic
```

### Automated Testing
```bash
# Create test script
echo "PRINT \"Hello World!\"" > test.bas
echo -e "load \"test.bas\"\nrun\nquit" | ./dist/crossbasic
```

## 🎉 Success!

Your CrossBasic interpreter is now a standalone executable that users can download and run immediately on any supported platform without any installation requirements!
