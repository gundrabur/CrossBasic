# VS Code CrossBasic Integration

This document explains how to run .bas files directly from VS Code using the CrossBasic interpreter.

## Setup

The VS Code workspace has been configured with the following files:

- **`.vscode/tasks.json`** - Defines tasks for running BASIC files
- **`.vscode/settings.json`** - File associations and editor settings for .bas files
- **`.vscode/keybindings.json`** - Keyboard shortcuts for quick execution
- **`.vscode/launch.json`** - Debug configurations
- **`run_bas.py`** - Wrapper script for direct file execution

## How to Run BASIC Files

### Method 1: Keyboard Shortcuts (Recommended)

1. Open any `.bas` file in VS Code
2. Press **F5** to run the current file
3. The program will execute in the integrated terminal
4. If the program uses graphics, a graphics window will open

### Method 2: Command Palette

1. Open any `.bas` file in VS Code
2. Press **Cmd+Shift+P** (macOS) or **Ctrl+Shift+P** (Windows/Linux)
3. Type "Tasks: Run Task"
4. Select "Run Current BASIC File"

### Method 3: Terminal Menu

1. Go to **Terminal** → **Run Task...**
2. Select "Run Current BASIC File"

## Available Tasks

- **Run Current BASIC File** (F5) - Runs the currently active .bas file
- **CrossBasic Interactive Mode** (Ctrl+F5) - Opens the interactive line editor
- **CrossBasic Classic Mode** (Shift+F5) - Opens the classic BASIC interpreter

## Additional Keyboard Shortcuts

- **F5** - Run current BASIC file (only when a .bas file is active)
- **Ctrl+F5** - Start CrossBasic in interactive mode
- **Shift+F5** - Start CrossBasic in classic mode

## File Associations

- `.bas` and `.BAS` files are automatically associated with zxbasic syntax highlighting
- Tab size is set to 4 spaces for BASIC files
- Word wrap is enabled for better readability

## Debug Support

You can also debug BASIC file execution:

1. Set breakpoints in the `run_bas.py` or `crossbasic.py` files
2. Press **F5** or go to **Run → Start Debugging**
3. Select "Run Current BASIC File" or "CrossBasic Interactive"

## Examples

Try running these example files:

- `examples/basic/example1.bas` - Simple math operations
- `examples/basic/example2.bas` - Loops and conditions  
- `examples/graphics/graphics_demo.bas` - Graphics demonstration
- `examples/mandelbrot/mandelbrot_simple.bas` - Mandelbrot set visualization

## Graphics Programs

When running graphics programs:

- A graphics window will automatically open
- The program output appears in the VS Code terminal
- Close the graphics window to end the program
- The graphics window stays on top for better visibility

## Troubleshooting

### "pygame not found" Error

Make sure the virtual environment is activated and pygame is installed:

```bash
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
pip install pygame
```

### Graphics Window Issues

- On macOS, graphics windows work best with the system Python
- If graphics don't appear, try running the program again
- Some graphics programs may need a moment to initialize

### File Not Found

Make sure you're running the task from within the CrossBasic workspace folder.

## Python Environment

The setup uses a virtual environment located at `.venv/` with the following packages:

- `pygame>=2.0.0` - For graphics support
- `setuptools<81` - For compatibility

The tasks are configured to use the virtual environment automatically.