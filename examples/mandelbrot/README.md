# Mandelbrot Set in CrossBasic

This collection contains multiple BASIC programs that draw the famous **Mandelbrot Set** using CrossBasic's graphics functions.

## 🎨 The Mandelbrot Set

The Mandelbrot set is one of the most famous fractals in mathematics. It consists of all complex numbers `c` for which the sequence:

```
z(n+1) = z(n)² + c
```

remains bounded when starting with `z(0) = 0`.

## 📂 Available Programs

### 1. `mandelbrot.bas` - Basic Version
- **Purpose**: Simple, complete Mandelbrot implementation
- **Resolution**: 800x600 pixels (every 2nd pixel)
- **Iterations**: 50
- **Range**: Classic full view (-2.5 to 1.5)
- **Features**: 
  - Basic color palette
  - Progress display
  - Well commented

### 2. `mandelbrot_hd.bas` - High-Resolution Version
- **Purpose**: Detailed representation with improved quality
- **Resolution**: 400x300 pixels (every 2nd pixel)
- **Iterations**: 100
- **Range**: Zoom on interesting area (-0.8 to -0.4)
- **Features**:
  - Extended color palette (7 colors)
  - Coordinate system overlay
  - Centered display
  - Detailed explanations

### 3. `mandelbrot_explorer.bas` - Interactive Version
- **Purpose**: Explores various interesting regions
- **Resolution**: 600x400 pixels (every 2nd pixel)
- **Iterations**: 80
- **Regions**:
  1. **Full View** - Classic Mandelbrot set
  2. **Seahorse Valley** - Seahorse-like structures
  3. **Elephant Valley** - Elephant-like forms
  4. **Lightning** - Lightning-like branches
  5. **Spiral** - Spiral patterns
- **Features**:
  - User selection of region
  - Repeatable execution
  - GOSUB/RETURN structure

### 4. `mandelbrot_lernen.bas` - Educational Version
- **Purpose**: Step-by-step explanation of the mathematics
- **Resolution**: 200x150 pixels (every 3rd pixel)
- **Iterations**: 30
- **Range**: Classic full view
- **Features**:
  - Detailed mathematical explanations
  - Example calculation for one point
  - Step-by-step demonstration
  - Color interpretation

## 🚀 Usage

### Quick Start
```bash
# Start CrossBasic (from main directory)
python crossbasic.py

# In the interpreter:
CrossBasic> load examples/mandelbrot/mandelbrot.bas
CrossBasic> run
```

### Recommended Order
1. **Beginners**: `examples/mandelbrot/mandelbrot_lernen.bas` - Understand the mathematics
2. **Standard**: `examples/mandelbrot/mandelbrot.bas` - Classic implementation
3. **Quality**: `examples/mandelbrot/mandelbrot_hd.bas` - Best image quality
4. **Exploration**: `examples/mandelbrot/mandelbrot_explorer.bas` - Different regions

## 🎨 Color Coding

All programs use similar color logic:

- **Black (0)**: Point belongs to Mandelbrot set
- **White (1)**: Very fast divergence (1-5 iterations)
- **Red (2)**: Fast divergence (5-10 iterations)
- **Green (3)**: Medium divergence (10-20 iterations)
- **Blue (4)**: Slow divergence (20-30 iterations)
- **Yellow (5)**: Very slow divergence (30+ iterations)

## 🔧 Technical Details

### Algorithm
```basic
FOR PIXELX = 0 TO WIDTH
  FOR PIXELY = 0 TO HEIGHT
    CX = XMIN + PIXELX * XSTEP
    CY = YMIN + PIXELY * YSTEP
    
    ZX = 0: ZY = 0
    FOR ITER = 1 TO MAX_ITER
      ZX_NEW = ZX * ZX - ZY * ZY + CX
      ZY_NEW = 2 * ZX * ZY + CY
      
      IF ZX_NEW * ZX_NEW + ZY_NEW * ZY_NEW > 4 THEN
        EXIT (Point diverges)
      END IF
      
      ZX = ZX_NEW: ZY = ZY_NEW
    NEXT ITER
    
    COLOR = COLOR_BASED_ON_ITER
    PSET PIXELX, PIXELY
  NEXT PIXELY
NEXT PIXELX
```

### Performance Optimizations
- **Step Sampling**: Only every 2nd-3rd pixel is calculated
- **Early Exit**: Divergence test at |z| > 2
- **Moderate Resolution**: Balanced between quality and speed
- **Limited Iterations**: 30-100 depending on version

## 🎓 Learning Objectives

These programs demonstrate:
- **Complex Mathematics** in BASIC
- **Nested Loops** for 2D iteration
- **Graphics Programming** with PSET/COLOR
- **Algorithmic Art** and fractals
- **Performance Optimization** in interpreted languages
- **User Interaction** and menu systems

## 🔬 Mathematical Background

### What is the Mandelbrot Set?
The Mandelbrot set is defined as the set of all complex numbers `c` for which the sequence:

```
z₀ = 0
z₁ = z₀² + c = c
z₂ = z₁² + c = c² + c
z₃ = z₂² + c = (c² + c)² + c
...
```

remains bounded (doesn't diverge to infinity).

### Escape Velocity
Points outside the set diverge at different speeds:
- **Fast Divergence** → Bright colors
- **Slow Divergence** → Dark colors
- **No Divergence** → Black (belongs to the set)

### Complex Numbers in BASIC
Since BASIC has no native complex numbers, we use:
- `CX`, `ZX` = Real part
- `CY`, `ZY` = Imaginary part
- `(a + bi)² = (a² - b²) + (2ab)i`

## 🚀 Extension Possibilities

- **Higher Resolution**: Smaller STEP values
- **More Colors**: Extended color palettes
- **Zoom Feature**: Interactive zooming
- **Julia Sets**: Related fractals
- **Animation**: Time-dependent parameters
- **Different Escape Criteria**: |z| > 4, 8, etc.

## 📈 Benchmark Results

Typical runtimes on modern systems:
- `mandelbrot_lernen.bas`: ~10-30 seconds
- `mandelbrot.bas`: ~2-5 minutes  
- `mandelbrot_hd.bas`: ~3-8 minutes
- `mandelbrot_explorer.bas`: ~1-4 minutes (per region)

## 🎨 Region Gallery

### Full View
- **Range**: -2.5 ≤ x ≤ 1.5, -1.5 ≤ y ≤ 1.5
- **Shows**: Complete Mandelbrot set
- **Characteristics**: Cardioid, main bulb, antennas

### Seahorse Valley  
- **Range**: -0.75 ≤ x ≤ -0.73, 0.095 ≤ y ≤ 0.115
- **Shows**: Seahorse-like structures
- **Characteristics**: Self-similar spirals

### Elephant Valley
- **Range**: 0.25 ≤ x ≤ 0.26, 0.0 ≤ y ≤ 0.01  
- **Shows**: Elephant-like forms
- **Characteristics**: Large bulbous structures

### Lightning
- **Range**: -1.775 ≤ x ≤ -1.76, -0.01 ≤ y ≤ 0.005
- **Shows**: Lightning-like branches  
- **Characteristics**: Delicate dendritic structures

### Spiral
- **Range**: -0.16 ≤ x ≤ -0.14, 1.025 ≤ y ≤ 1.045
- **Shows**: Spiral patterns
- **Characteristics**: Concentric swirls

---

**Have fun exploring the infinite beauty of the Mandelbrot set! 🌟**
