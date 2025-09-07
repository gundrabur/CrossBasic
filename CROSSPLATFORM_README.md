# CrossBasic Cross-Platform Line Editor

## Overview
The CrossBasic Line Editor now provides full cross-platform support with adaptive input handling for Windows, macOS, and Linux systems. The editor automatically detects available system capabilities and provides the best possible user experience on each platform.

## Platform Support

### Windows
- **Full Advanced Mode**: Complete cursor control and command history
- **Technology**: Uses `msvcrt` module for direct keyboard input
- **Features**:
  - ✅ Real-time cursor movement (LEFT/RIGHT arrows)
  - ✅ Command history navigation (UP/DOWN arrows)
  - ✅ In-line character insertion and deletion
  - ✅ BACKSPACE and DELETE key support
  - ✅ Line editing without re-typing

### macOS / Linux
- **Advanced Mode**: Full cursor control using termios
- **Technology**: Uses `termios` and `tty` modules for raw terminal input
- **Features**:
  - ✅ Real-time cursor movement (LEFT/RIGHT arrows)
  - ✅ Command history navigation (UP/DOWN arrows)
  - ✅ In-line character insertion and deletion
  - ✅ BACKSPACE and DELETE key support
  - ✅ Line editing without re-typing

### Unix-like Systems (Fallback)
- **Readline Mode**: Command history with basic line editing
- **Technology**: Uses Python `readline` module
- **Features**:
  - ✅ Command history navigation (UP/DOWN arrows)
  - ✅ Basic line editing capabilities
  - ✅ Tab completion support
  - ❌ Limited in-line cursor movement

### All Platforms (Ultimate Fallback)
- **Basic Mode**: Simple line-by-line input
- **Technology**: Standard Python `input()` function
- **Features**:
  - ✅ Basic command entry
  - ✅ All BASIC language features
  - ❌ No command history
  - ❌ No cursor movement

## Automatic Platform Detection

The editor automatically detects and selects the best available input method:

```python
def edit_line(self) -> str:
    """Edit a line with platform-appropriate terminal support"""
    try:
        if self.has_msvcrt and os.name == 'nt':
            # Windows: Use msvcrt for full cursor control
            return self.advanced_input()
        elif self.has_termios and os.name != 'nt':
            # Unix-like systems: Use termios for full cursor control
            return self.unix_advanced_input()
        elif self.has_readline and os.name != 'nt':
            # Unix-like systems: Use readline for basic history support
            return self.readline_input()
        else:
            # Fallback: Basic input
            return self.simple_input()
    except (KeyboardInterrupt, EOFError):
        return ""
```

## Key Bindings

### Windows & Unix Advanced Mode
| Key | Action |
|-----|--------|
| ↑ (Up Arrow) | Previous command in history |
| ↓ (Down Arrow) | Next command in history |
| ← (Left Arrow) | Move cursor left |
| → (Right Arrow) | Move cursor right |
| BACKSPACE | Delete character before cursor |
| DELETE | Delete character at cursor |
| ENTER | Execute/store command |
| Ctrl+C | Interrupt (exit to prompt) |

### Unix Readline Mode
| Key | Action |
|-----|--------|
| ↑ (Up Arrow) | Previous command in history |
| ↓ (Down Arrow) | Next command in history |
| ENTER | Execute/store command |
| Ctrl+C | Interrupt (exit to prompt) |

### Basic Mode
| Key | Action |
|-----|--------|
| ENTER | Execute/store command |
| Ctrl+C | Interrupt (exit to prompt) |

## Implementation Details

### Windows Implementation (msvcrt)
```python
def advanced_input(self) -> str:
    """Advanced input with cursor control (Windows)"""
    import msvcrt
    
    line = ""
    cursor_pos = 0
    print("BASIC> ", end="", flush=True)
    
    while True:
        char = msvcrt.getch()
        
        if char == b'\r':  # Enter
            print()
            return line
        elif char == b'\x08':  # Backspace
            # Handle backspace logic
        elif char == b'\xe0':  # Extended key
            char2 = msvcrt.getch()
            # Handle arrow keys and delete
        # ... more key handling
```

### Unix Implementation (termios)
```python
def unix_advanced_input(self) -> str:
    """Advanced input for Unix-like systems using termios"""
    import termios
    import tty
    import sys
    
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    
    try:
        tty.setraw(sys.stdin.fileno())
        # Handle raw keyboard input
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
```

### Readline Implementation
```python
def readline_input(self) -> str:
    """Input using readline for Unix-like systems with history support"""
    import readline
    
    # Sync history with readline
    readline.clear_history()
    for cmd in self.history:
        readline.add_history(cmd)
    
    return input("BASIC> ")
```

## Testing Cross-Platform Features

Use the included test script to verify platform capabilities:

```bash
python test_crossplatform.py
```

This will show:
- Platform detection results
- Available input methods
- Selected editor mode
- Feature availability
- Basic functionality tests

## Error Handling

The editor includes robust error handling for cross-platform compatibility:

- **Module Import Errors**: Graceful fallback when platform-specific modules aren't available
- **Terminal Errors**: Automatic fallback to simpler input methods
- **Keyboard Interrupts**: Proper handling of Ctrl+C across all platforms
- **Terminal Restoration**: Ensures terminal settings are restored on Unix systems

## Development Notes

### Adding New Platform Support
To add support for new platforms:

1. Add platform detection in `__init__`:
```python
try:
    import new_platform_module
    self.has_new_platform = True
except ImportError:
    self.has_new_platform = False
```

2. Implement platform-specific input method:
```python
def new_platform_input(self) -> str:
    # Platform-specific implementation
    pass
```

3. Update `edit_line()` method to include new platform.

### Testing on Different Platforms
- **Windows**: Test with Windows Terminal, Command Prompt, PowerShell
- **macOS**: Test with Terminal.app, iTerm2
- **Linux**: Test with various terminal emulators (GNOME Terminal, Konsole, etc.)

## Troubleshooting

### Common Issues

**Issue**: Arrow keys not working on Linux/macOS
**Solution**: Ensure your terminal supports ANSI escape sequences. Most modern terminals do.

**Issue**: History not persisting
**Solution**: Check if `readline` module is available. Install with `pip install readline` if needed.

**Issue**: Cursor movement not working
**Solution**: The editor will fall back to readline or basic mode automatically.

**Issue**: Terminal settings corrupted on Unix
**Solution**: The editor should restore settings automatically. If not, use `reset` command in terminal.

## Future Enhancements

Potential improvements for cross-platform support:
- [ ] Support for additional terminal emulators
- [ ] Customizable key bindings
- [ ] Support for terminal themes and colors
- [ ] Mouse support where available
- [ ] Clipboard integration (copy/paste)
- [ ] Multi-line editing capabilities

## Compatibility Matrix

| Platform | Advanced Mode | History | Cursor Control | Status |
|----------|---------------|---------|----------------|---------|
| Windows 10/11 | ✅ | ✅ | ✅ | Fully Supported |
| macOS 10.14+ | ✅ | ✅ | ✅ | Fully Supported |
| Ubuntu 18.04+ | ✅ | ✅ | ✅ | Fully Supported |
| Debian 10+ | ✅ | ✅ | ✅ | Fully Supported |
| CentOS 7+ | ✅ | ✅ | ✅ | Fully Supported |
| Alpine Linux | ✅ | ✅ | ✅ | Fully Supported |
| FreeBSD | ✅ | ✅ | ✅ | Expected to work |
| Other Unix | 🟡 | ✅ | 🟡 | Readline fallback |

Legend:
- ✅ Fully Supported
- 🟡 Limited Support  
- ❌ Not Supported
