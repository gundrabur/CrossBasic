# CrossBasic Color Features

CrossBasic now supports a unified 16-color system for both text output and graphics. The same color palette is used consistently across all display modes.

## Unified Color Commands

### Text Colors
- `TEXTCOLOR <number>` - Sets foreground (text) color (0-15)
- `TEXTBG <number>` - Sets background color (0-15)  
- `RESETCOLOR` - Resets text colors to default (white on black)

### Graphics Colors
- `COLOR <number>` - Sets graphics drawing color (0-15)
- Used with `PLOT`, `LINE`, `CIRCLE`, `RECT`, `PSET` commands

## Unified Color Palette (0-15)

Both text and graphics use the same 16-color palette:

| Number | Color         | RGB Values    | Number | Color           | RGB Values    |
|--------|---------------|---------------|--------|-----------------|---------------|
| 0      | Black         | (0,0,0)       | 8      | Dark Gray       | (128,128,128) |
| 1      | White         | (255,255,255) | 9      | Light Red       | (255,128,128) |
| 2      | Red           | (255,0,0)     | 10     | Light Green     | (128,255,128) |
| 3      | Green         | (0,255,0)     | 11     | Light Blue      | (128,128,255) |
| 4      | Blue          | (0,0,255)     | 12     | Light Yellow    | (255,255,128) |
| 5      | Yellow        | (255,255,0)   | 13     | Light Magenta   | (255,128,255) |
| 6      | Magenta       | (255,0,255)   | 14     | Light Cyan      | (128,255,255) |
| 7      | Cyan          | (0,255,255)   | 15     | Bright White    | (255,255,255) |

## Example Programs

### color_demo.bas
A comprehensive demonstration of the text color features showing:
- Foreground colors (text colors)
- Background colors 
- Color reset functionality

### graphics_color_demo.bas
A comprehensive demonstration of the graphics color features showing:
- All 16 colors in graphics mode
- Color palette grid display
- Various colored shapes (rectangles, circles, lines)

### rainbow_demo.bas
A fun demonstration combining text colors in an artistic display.

To run any demo:
```
load examples/color_demo.bas
run
```

## Cross-Platform Compatibility

### Text Colors
- **Windows**: Works in Command Prompt, PowerShell, and Windows Terminal
- **Linux**: Works in most terminal emulators (xterm, gnome-terminal, konsole, etc.)
- **macOS**: Works in Terminal.app and iTerm2
- **Fallback**: Gracefully degrades on terminals without color support

### Graphics Colors  
- **All Platforms**: Works wherever Pygame is supported
- **Graphics Window**: 800x600 resolution with full 16-color support
- **Always On Top**: Graphics window stays visible during program execution

## Example Programs

### Text Colors
```basic
10 TEXTCOLOR 2
20 PRINT "This is red text"
30 TEXTCOLOR 3  
40 PRINT "This is green text"
50 TEXTBG 4
60 PRINT "This has blue background"
70 RESETCOLOR
80 PRINT "Back to normal"
90 END
```

### Graphics Colors
```basic
10 GRAPHICS
20 COLOR 2
30 CIRCLE 100, 100, 50
40 COLOR 3
50 RECT 200, 75, 100, 50
60 COLOR 4
70 LINE 350, 75 TO 450, 125
80 END
```

### Combined Example
```basic
10 PRINT "Starting graphics demo..."
20 TEXTCOLOR 2
30 PRINT "Opening graphics window"
40 GRAPHICS
50 FOR I = 0 TO 15
60   COLOR I
70   CIRCLE 400, 300, 20 + I * 5
80 NEXT I
90 RESETCOLOR
100 PRINT "Demo complete!"
110 END
```
