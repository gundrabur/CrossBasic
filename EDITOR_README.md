# CrossBasic Line Editor

The CrossBasic Line Editor provides an interactive environment for writing and editing BASIC programs with modern editor features like cursor control, command history, and real-time syntax checking.

## Features

### Interactive Line Editing
- **Cursor Navigation**: Use LEFT/RIGHT arrow keys to move the cursor within a line (Windows only)
- **Line Editing**: 
  - BACKSPACE to delete character before cursor
  - DELETE to delete character at cursor position
  - INSERT characters at cursor position
- **Command History**: Use UP/DOWN arrow keys to navigate through previously entered commands
- **Real-time Syntax Checking**: Every line is checked for syntax errors before execution or storage

### Program Management
- **Line Numbers**: Lines starting with numbers (e.g., `10 PRINT "Hello"`) are added to the program
- **Immediate Execution**: Lines without numbers (e.g., `PRINT "Hello"`) are executed immediately
- **Program Storage**: Build programs incrementally by adding numbered lines
- **File Operations**: Load and save programs to/from files

## Usage

### Starting the Editor
```bash
python crossbasic.py
```

### Basic Commands

#### Editor Commands
- `help` - Show help information
- `new` - Clear the current program from memory
- `list` - Display the current program
- `run` - Execute the current program
- `load <filename>` - Load a program from a file
- `save <filename>` - Save the current program to a file
- `quit` or `exit` - Exit the editor

#### BASIC Programming
```basic
# Adding lines to a program (with line numbers)
10 PRINT "Hello World"
20 LET A = 5
30 PRINT "A ="; A

# Immediate execution (without line numbers)
PRINT "This runs right now"
LET X = 10
PRINT X * 2

# View the program
list

# Run the program
run
```

### Editor Features in Detail

#### Syntax Checking
The editor performs real-time syntax checking:
- ✅ Valid: `10 PRINT "Hello"`
- ❌ Invalid: `10 PRNT "Hello"` (typo in PRINT)
- ❌ Invalid: `10 LET = 5` (missing variable name)

#### Command History
- Press UP arrow to recall previous commands
- Press DOWN arrow to go forward in history
- History persists during the editing session
- Maximum 100 commands stored

#### Line Number Detection
- Lines starting with numbers are automatically detected as program lines
- Examples:
  - `10 PRINT "Hello"` → Added to program at line 10
  - `PRINT "Hello"` → Executed immediately

### Cross-Platform Support

#### Windows
- Full cursor control with arrow keys
- Advanced line editing features
- Uses `msvcrt` for keyboard input

#### Linux/macOS
- Basic line editing (fallback mode)
- Command history still available
- Uses standard input methods

## Example Session

```
CrossBasic Line Editor v1.0
Enter BASIC commands. Lines starting with numbers are added to the program.
Commands without line numbers are executed immediately.
Type 'help' for help, 'list' to show program, 'run' to execute, 'quit' to exit.
Use UP/DOWN arrow keys for command history (Windows only).

BASIC> 10 PRINT "=== My First Program ==="
Line added to program

BASIC> 20 INPUT "Enter your name: ", NAME
Line added to program

BASIC> 30 PRINT "Hello, "; NAME; "!"
Line added to program

BASIC> 40 END
Line added to program

BASIC> list
10 PRINT "=== My First Program ==="
20 INPUT "Enter your name: " , NAME
30 PRINT "Hello, " ; NAME ; "!"
40 END

BASIC> run
=== My First Program ===
Enter your name: ? John
Hello, John!

BASIC> save myprogram.bas
Program saved to myprogram.bas

BASIC> PRINT "This runs immediately"
This runs immediately

BASIC> quit
Goodbye!
```

## Advanced Features

### Variable Persistence
Variables set in immediate mode persist and can be used in the program:
```basic
BASIC> LET X = 42
BASIC> 10 PRINT "X is"; X
BASIC> run
X is 42
```

### Graphics Support
The editor supports all graphics commands:
```basic
BASIC> GRAPHICS
BASIC> 10 CIRCLE 400, 300, 100
BASIC> 20 COLOR 2
BASIC> 30 PLOT 400, 300
BASIC> run
```

### Error Handling
- Syntax errors are caught before execution
- Runtime errors are displayed with line numbers
- Program execution stops on errors

## File Format

Programs are saved in standard BASIC text format:
```basic
10 REM This is a comment
20 PRINT "Hello World"
30 LET A = 5
40 PRINT "A ="; A
50 END
```

## Limitations

- Advanced cursor control only available on Windows
- Line numbers must be integers
- Maximum command history of 100 entries
- Some terminal features may not work in all environments

## Technical Notes

The editor uses the existing CrossBasic parser and interpreter, adding an interactive layer with:
- `BasicEditor` class for line editing and command management
- Real-time syntax validation using the built-in lexer/parser
- Command history management
- Platform-specific keyboard handling
