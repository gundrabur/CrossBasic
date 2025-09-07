# CrossBasic - Cross-Platform BASIC Interpreter

A complete BASIC interpreter written in Python with graphics support that runs on all platforms where Python is available.

## Autor: Christian Moeller
- **September 2025**
- **Version 1.0**

![CrossBasic Demo](https://img.shields.io/badge/Python-3.6+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)

## 🚀 Features

### Core BASIC Commands
- **Variables and Assignments**: `LET`, direct assignment
- **Input/Output**: `PRINT`, `INPUT`
- **Control Structures**: `IF...THEN...ELSE`, `FOR...NEXT`, `WHILE...WEND`
- **Program Flow**: `GOTO`, `GOSUB`, `RETURN`, `END`
- **Comments**: `REM` or `'`

### Mathematical Functions
- Basic operations: `+`, `-`, `*`, `/`, `^` (power)
- Comparison operators: `=`, `<>`, `<`, `>`, `<=`, `>=`
- Logical operators: `AND`, `OR`, `NOT`
- Built-in functions:
  - `ABS(x)` - Absolute value
  - `INT(x)` - Integer part
  - `SQR(x)` - Square root
  - `SIN(x)`, `COS(x)`, `TAN(x)` - Trigonometric functions
  - `RND([x])` - Random number
  - `LEN(s)` - String length
  - `CHR(x)`, `ASC(s)` - Character/ASCII conversion
  - `TIME()` - Current time in seconds (for benchmarking)

### Graphics Functions
- **Graphics Mode**: `GRAPHICS [mode]` - Initialize graphics window
- **Drawing Commands**:
  - `PLOT x, y` - Draw point
  - `PSET x, y` - Set pixel
  - `LINE x1, y1 TO x2, y2` - Draw line
  - `CIRCLE x, y, radius` - Draw circle
  - `RECT x, y, width, height` - Draw rectangle
- **Screen Control**:
  - `CLS` - Clear screen
  - `COLOR color` - Set drawing color (0-9)

### Color Palette
- 0: Black    - 1: White   - 2: Red     - 3: Green   - 4: Blue
- 5: Yellow   - 6: Magenta - 7: Cyan    - 8: Gray    - 9: Orange

## 📦 Installation

### Prerequisites
- Python 3.6 or higher
- Pygame for graphics functions

### Install Pygame
```bash
pip install pygame
```

### Run CrossBasic
```bash
python crossbasic.py
```

## 💻 Usage

### Interactive Mode
The interpreter starts in interactive mode where you can enter direct commands:

```
CrossBasic> PRINT "Hello World!"
Hello World!

CrossBasic> LET X = 10
CrossBasic> PRINT X * 2
20
```

### Interpreter Commands
- `help` - Show help
- `new` - Clear current program
- `list` - Show loaded program
- `run` - Execute program
- `load <file>` - Load program from file
- `quit` / `exit` - Exit interpreter

### Loading and Running Programs
```
CrossBasic> load examples/basic/example1.bas
Program loaded from examples/basic/example1.bas

CrossBasic> run
CrossBasic Interpreter Demo
=========================

A = 10
B = 20
A + B = 30

Square root of 16: 4.0
Random number: 42
```

## ⌨️ Interactive Line Editor

CrossBasic features a modern, cross-platform line editor with advanced editing capabilities:

### Cross-Platform Support
- **Windows**: Full cursor control using `msvcrt`
- **macOS/Linux**: Full cursor control using `termios` 
- **Fallback**: Command history using `readline` or basic input

### Editor Features
- **Line Numbers**: Lines starting with numbers are added to the program
- **Line Overwrite**: Entering an existing line number overwrites that line
- **Immediate Execution**: Lines without numbers execute immediately
- **Command History**: Navigate previous commands with UP/DOWN arrows
- **Cursor Control**: Move within lines using LEFT/RIGHT arrows
- **In-line Editing**: Insert/delete characters at any position
- **Syntax Checking**: Real-time validation before execution
- **File Operations**: Save and load programs seamlessly

### Usage Example
```
BASIC> 10 PRINT "Hello World"    (adds to program)
Line added to program

BASIC> PRINT "Immediate"         (executes now)
Immediate

BASIC> list                      (show program)
10 PRINT "Hello World"

BASIC> run                       (execute program)
Hello World
```

### Editor Controls
| Key | Action |
|-----|--------|
| ↑/↓ | Navigate command history |
| ←/→ | Move cursor within line |
| BACKSPACE | Delete character before cursor |
| DELETE | Delete character at cursor |
| ENTER | Execute/store command |

See `CROSSPLATFORM_README.md` for detailed cross-platform information.

## 📁 Example Programs

CrossBasic comes with an extensive collection of example programs:

### `/examples/basic/` - Basic BASIC Programs
- **`beispiel1.bas`** - Demonstrates basic math and output
- **`beispiel2.bas`** - Shows `FOR` loops and conditions
- **`zahlenraten.bas`** - Interactive number guessing game

### `/examples/graphics/` - Graphics Programs
- **`grafik_demo.bas`** - Draws geometric shapes using graphics commands
- **`muster_demo.bas`** - Creates complex graphical patterns

### `/examples/mandelbrot/` - Mandelbrot Fractals
- **`mandelbrot.bas`** - Basic version of Mandelbrot set
- **`mandelbrot_hd.bas`** - High-resolution version
- **`mandelbrot_einfach.bas`** - Simple, fast version
- **`mandelbrot_explorer.bas`** - Interactive version with different regions
- **`mandelbrot_lernen.bas`** - Educational version with detailed explanations

### `/examples/benchmarks/` - Performance Testing
- **`benchmark_test.bas`** - Comprehensive benchmark suite
- **`mandelbrot_benchmark.bas`** - Mandelbrot fractal performance test
- **`time_examples.bas`** - Various TIME function demonstrations
- **`time_test_simple.bas`** - Simple timing example

See `examples/README.md` for detailed documentation.

## 📝 BASIC Syntax

### Line Numbers
Line numbers are optional but recommended for structured programs:
```basic
10 PRINT "First line"
20 PRINT "Second line"
```

### Variables
Variables can contain numbers or strings:
```basic
LET NAME = "John"
LET AGE = 25
LET PI = 3.14159
```

### Loops
```basic
REM FOR loop
FOR I = 1 TO 10
    PRINT I
NEXT I

REM WHILE loop
LET X = 1
WHILE X <= 5
    PRINT X
    LET X = X + 1
WEND
```

### Conditionals
```basic
INPUT "Enter your age: ", AGE
IF AGE >= 18 THEN 
    PRINT "You are an adult"
ELSE 
    PRINT "You are a minor"
```

### Graphics
```basic
GRAPHICS          REM Open graphics window
COLOR 2           REM Red color
CIRCLE 400, 300, 100  REM Circle in center
LINE 0, 0 TO 800, 600  REM Diagonal line
```

### Benchmarking with TIME()
```basic
REM Time a loop operation
10 START_TIME = TIME()
20 FOR I = 1 TO 10000
30   LET X = SQR(I)
40 NEXT I
50 END_TIME = TIME()
60 PRINT "Loop took "; (END_TIME - START_TIME); " seconds"
```

## 🌐 Platform Compatibility

CrossBasic runs on all platforms that support Python:
- **Windows**: Fully supported
- **macOS**: Fully supported  
- **Linux**: Fully supported
- **Other Unix systems**: Should work

### Platform Features
- Graphics functions use Pygame for cross-platform compatibility
- Console clearing (`CLS`) automatically detects operating system
- File paths are handled correctly on all platforms

## 🏗️ Architecture

The interpreter consists of several components:

1. **Lexer (`BasicLexer`)**: Breaks source code into tokens
2. **Parser (`BasicParser`)**: Analyzes syntax and creates syntax tree
3. **Interpreter (`BasicInterpreter`)**: Executes the program
4. **Graphics Engine (`GraphicsEngine`)**: Handles all graphics operations

### Extensible Design
- New BASIC commands can be easily added
- Additional functions can be built into `builtin_functions`
- Graphics system is modular and extensible

## ⚠️ Limitations

- No arrays (DIM) implemented (can be extended)
- No file I/O commands (OPEN, CLOSE, etc.)
- No string functions like MID$, LEFT$, RIGHT$
- Sound commands not implemented

## 🔧 Development

### Adding New Commands
1. Add keyword to `BasicLexer.KEYWORDS`
2. Create parser method in `BasicParser`
3. Implement execution method in `BasicInterpreter`

### Adding New Functions
Simply add to `BasicInterpreter.builtin_functions`:
```python
self.builtin_functions['NEWFUNC'] = lambda x: x * 2
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup
1. Clone the repository
2. Install dependencies: `pip install pygame`
3. Run tests: `python test_crossbasic.py`
4. Make your changes
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

CrossBasic was developed as a demonstration project for a complete BASIC interpreter implementation.

## 🐛 Known Issues

- Performance may be affected with complex graphics
- Very long programs may cause memory issues
- Error handling could be improved

## 🔮 Future Enhancements

- [ ] Array support (DIM)
- [ ] String functions
- [ ] File I/O operations
- [ ] Sound system
- [ ] Debugging features
- [ ] Syntax highlighting
- [ ] Better error messages
- [ ] Performance optimizations
- [ ] IDE integration
- [ ] More graphics primitives

## 📊 Project Stats

- **Language**: Python 3.6+
- **Dependencies**: Pygame
- **Lines of Code**: ~1500
- **Example Programs**: 15+
- **Supported BASIC Commands**: 20+
- **Built-in Functions**: 11+

---

**Happy coding with CrossBasic!** 🎉
