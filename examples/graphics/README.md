# Graphics Programs

These programs demonstrate CrossBasic's powerful graphics capabilities.

## 📁 Programs

### `graphics_demo.bas` - Basic Graphics Commands
**Purpose**: Introduction to CrossBasic graphics
**Learning Goals**:
- Open graphics window with `GRAPHICS`
- Basic drawing commands
- Color management with `COLOR`
- Understand coordinate systems

**Usage**:
```bash
CrossBasic> load examples/graphics/graphics_demo.bas
CrossBasic> run
```

**What gets drawn**:
- Point circle using trigonometric functions
- Filled circle with `CIRCLE`
- Coordinate axes with `LINE`
- Various colors

**What you'll learn**:
- `GRAPHICS` - Initialize graphics window
- `PLOT X, Y` - Draw points
- `CIRCLE X, Y, RADIUS` - Draw circles
- `LINE X1, Y1 TO X2, Y2` - Draw lines
- `COLOR N` - Set colors (0-9)

---

### `pattern_demo.bas` - Complex Graphical Patterns
**Purpose**: Advanced graphics programming
**Learning Goals**:
- Complex algorithms for graphics
- Nested loops for patterns
- Mathematical functions in graphics
- Performance optimization

**Usage**:
```bash
CrossBasic> load examples/graphics/pattern_demo.bas
CrossBasic> run
```

**What gets drawn**:
- **Checkerboard pattern**: Algorithmically generated
- **Spiral**: Mathematical curve with changing radius
- **Geometric shapes**: Rectangles and patterns

**What you'll learn**:
- `RECT X, Y, WIDTH, HEIGHT` - Draw rectangles
- Mathematical patterns with `COS` and `SIN`
- Conditional color selection based on algorithms
- Complex loop structures

---

### `lissajous_simple.bas` - Interactive Lissajous Curves
**Purpose**: Mathematical curve visualization with step-by-step demonstration
**Learning Goals**:
- Understanding parametric equations
- Frequency ratio effects on curve shapes
- Interactive program flow
- Mathematical art generation

**Usage**:
```bash
CrossBasic> load examples/graphics/lissajous_simple.bas
CrossBasic> run
```

**What gets drawn**:
- **1:1 ratio**: Perfect circle
- **1:2 ratio**: Classic figure-8 pattern
- **2:3 ratio**: Complex looping curve
- **3:4 ratio**: Intricate woven pattern
- **Comparison view**: All patterns side by side

**What you'll learn**:
- Parametric equations: X = sin(A*t), Y = sin(B*t)
- How frequency ratios create different patterns
- Interactive program flow with user input
- Mathematical visualization techniques

---

### `lissajous_demo.bas` - Advanced Lissajous Patterns
**Purpose**: Multiple Lissajous curves with different parameters
**Learning Goals**:
- Advanced mathematical graphics
- Multiple curve overlays
- Phase shift effects
- Animation concepts

**Usage**:
```bash
CrossBasic> load examples/graphics/lissajous_demo.bas
CrossBasic> run
```

**What gets drawn**:
- **3:2 frequency ratio**: Red harmonic pattern
- **5:4 ratio with phase**: Green shifted curve
- **7:5 ratio**: Blue complex pattern
- **Animated 4:3**: Yellow morphing curve
- **Decorative elements**: Axes and reference circles

**What you'll learn**:
- Advanced parametric equations
- Phase shift effects in curves
- Multi-curve composition
- Animation through parameter variation

---

### `lissajous_gallery.bas` - Complete Lissajous Gallery
**Purpose**: Comprehensive display of various Lissajous patterns
**Learning Goals**:
- Pattern gallery creation
- Advanced mathematical visualization
- Multi-pattern layout design
- Complex animation sequences

**Usage**:
```bash
CrossBasic> load examples/graphics/lissajous_gallery.bas
CrossBasic> run
```

**What gets drawn**:
- **Figure-8**: Simple 1:2 harmonic in top-left
- **Three-leaf rose**: 3:1 complex oscillation in top-right
- **Complex knot**: 5:3 intricate weaving in bottom-left
- **Spirograph-like**: 7:4 with phase shift in bottom-right
- **Animated center**: Morphing pattern with changing parameters
- **Decorative frames**: Borders and coordinate references

**What you'll learn**:
- Gallery-style program layout
- Multiple pattern positioning
- Advanced animation techniques
- Complex mathematical art creation

## 🎨 Graphics Commands Overview

### Initialization
```basic
GRAPHICS        ' Opens 800x600 graphics window
CLS            ' Clears the screen
```

### Drawing Commands
```basic
PLOT X, Y                    ' Draw point
PSET X, Y                    ' Set pixel
LINE X1, Y1 TO X2, Y2       ' Draw line
CIRCLE X, Y, RADIUS         ' Draw circle
RECT X, Y, WIDTH, HEIGHT    ' Draw rectangle
```

### Color Management
```basic
COLOR 0    ' Black
COLOR 1    ' White
COLOR 2    ' Red
COLOR 3    ' Green
COLOR 4    ' Blue
COLOR 5    ' Yellow
COLOR 6    ' Magenta
COLOR 7    ' Cyan
COLOR 8    ' Gray
COLOR 9    ' Orange
```

## 📐 Coordinate System

- **Origin**: Top left (0, 0)
- **X-Axis**: To the right (0 to 800)
- **Y-Axis**: Downward (0 to 600)
- **Unit**: Pixels

## 🎯 Recommended Learning Order

1. **Start**: `graphics_demo.bas` - Learn basic commands
2. **Mathematical basics**: `lissajous_simple.bas` - Interactive mathematical curves
3. **Advanced patterns**: `pattern_demo.bas` - Complex algorithms
4. **Mathematical art**: `lissajous_demo.bas` - Multiple Lissajous patterns
5. **Gallery showcase**: `lissajous_gallery.bas` - Complete pattern collection

## 💡 Programming Tips

### Drawing Circles
```basic
' Point-wise circle
FOR I = 0 TO 360 STEP 5
    X = 400 + 100 * COS(I * 3.14159 / 180)
    Y = 300 + 100 * SIN(I * 3.14159 / 180)
    PLOT X, Y
NEXT I

' Or simply
CIRCLE 400, 300, 100
```

### Lines and Patterns
```basic
' Horizontal line
LINE 0, 300 TO 800, 300

' Diagonal
LINE 0, 0 TO 800, 600

' Checkerboard
FOR X = 0 TO 800 STEP 40
    FOR Y = 0 TO 600 STEP 40
        IF (X/40 + Y/40) MOD 2 = 0 THEN COLOR 1 ELSE COLOR 0
        RECT X, Y, 40, 40
    NEXT Y
NEXT X
```

### Lissajous Curves
```basic
' Basic Lissajous curve (parametric equations)
FOR T = 0 TO 628 STEP 3
    X = 400 + 150 * SIN(3 * T / 100)
    Y = 300 + 150 * SIN(2 * T / 100)
    PSET X, Y
NEXT T

' With phase shift
PHASE = 1.57
FOR T = 0 TO 628 STEP 3
    X = 400 + 150 * SIN(5 * T / 100 + PHASE)
    Y = 300 + 150 * SIN(3 * T / 100)
    PSET X, Y
NEXT T
```

### Performance Tips
- Use `STEP` in loops for fewer points
- Limit the number of drawing operations
- Use simple mathematical operations

## 🔧 Technical Details

**Resolution**: 800x600 pixels
**Color Depth**: 10 basic colors (extensible)
**Backend**: Pygame
**Runtime**: 
- `graphics_demo.bas`: ~10-30 seconds
- `pattern_demo.bas`: ~1-3 minutes

## 🎨 Creative Possibilities

### Simple Projects
- Geometric shapes
- Simple animations (with loops)
- Mathematical curves (circles, spirals)
- Lissajous patterns and variations
- Pixel art

### Advanced Projects  
- Fractals (see `../mandelbrot/`)
- Complex Lissajous galleries
- Interactive mathematical visualizations
- Simulations
- Data visualization

## 🚀 Advanced Programs

After these graphics basics, we recommend:
- **Mandelbrot fractals**: `../mandelbrot/` - Mathematical art
- **Extended projects**: Your own creations!

---

**Create impressive graphics with CrossBasic!** 🎨
