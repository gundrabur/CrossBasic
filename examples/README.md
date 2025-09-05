# CrossBasic Examples

This collection contains various BASIC programs that demonstrate the features of the CrossBasic interpreter.

## 📁 Directory Structure

### `/basic` - Fundamental BASIC Programs
Basic BASIC programming with variables, loops, and input/output.

- **`example1.bas`** - Mathematics and output
- **`example2.bas`** - Loops and conditions  
- **`number_guessing.bas`** - Interactive number guessing game

### `/graphics` - Graphics Programs
Programs that utilize CrossBasic's graphics functions.

- **`graphics_demo.bas`** - Basic graphics commands
- **`pattern_demo.bas`** - Complex graphical patterns

### `/mandelbrot` - Mandelbrot Fractals
Various implementations of the famous Mandelbrot set.

- **`mandelbrot.bas`** - Basic version
- **`mandelbrot_hd.bas`** - High-resolution version
- **`mandelbrot_simple.bas`** - Simple, fast version
- **`mandelbrot_explorer.bas`** - Interactive version with different regions
- **`mandelbrot_learning.bas`** - Educational version with explanations

## 🚀 Usage

### Running programs from the main directory:

```bash
# Start CrossBasic
python crossbasic.py

# Load an example program
CrossBasic> load examples/basic/example1.bas
CrossBasic> run

# Or a graphics program
CrossBasic> load examples/graphics/graphics_demo.bas
CrossBasic> run

# Or a Mandelbrot program
CrossBasic> load examples/mandelbrot/mandelbrot_hd.bas
CrossBasic> run
```

### Recommended order for beginners:

1. **Learn basics**: `examples/basic/beispiel1.bas`
2. **Understand loops**: `examples/basic/beispiel2.bas`
3. **Test interaction**: `examples/basic/zahlenraten.bas`
4. **Discover graphics**: `examples/graphics/grafik_demo.bas`
5. **Explore fractals**: `examples/mandelbrot/mandelbrot_lernen.bas`

## 📚 Learning Objectives

### Basic Programming (`/basic`)
- Variables and data types
- Input and output with `PRINT` and `INPUT`
- Control structures (`IF...THEN...ELSE`, `FOR...NEXT`)
- Mathematical calculations
- Interactive programs

### Graphics Programming (`/graphics`)
- Graphics window with `GRAPHICS`
- Drawing commands (`PLOT`, `LINE`, `CIRCLE`, `RECT`)
- Color management with `COLOR`
- Pixel-based graphics with `PSET`
- Coordinate systems

### Mathematical Programming (`/mandelbrot`)
- Complex numbers in BASIC
- Iterative algorithms
- Escape velocity tests
- Color coding of data
- Performance optimization

## 🎯 Difficulty Levels

### 🟢 Beginner
- `examples/basic/beispiel1.bas`
- `examples/basic/beispiel2.bas`
- `examples/graphics/grafik_demo.bas`

### 🟡 Intermediate
- `examples/basic/zahlenraten.bas`
- `examples/graphics/muster_demo.bas`
- `examples/mandelbrot/mandelbrot_einfach.bas`

### 🔴 Advanced
- `examples/mandelbrot/mandelbrot_hd.bas`
- `examples/mandelbrot/mandelbrot_explorer.bas`
- `examples/mandelbrot/mandelbrot_lernen.bas`

## 🔧 Technical Notes

### Path References
All programs are designed to be loaded from the main CrossBasic directory:
```
CrossBasic> load examples/[category]/[program].bas
```

### Performance
- **Fast programs**: `*_einfach.bas`, `beispiel*.bas`
- **Medium runtime**: `grafik_demo.bas`, `zahlenraten.bas`
- **Longer calculations**: `mandelbrot_hd.bas`, `muster_demo.bas`

### Dependencies
All programs require:
- Python 3.6+
- Pygame (for graphics programs)
- CrossBasic interpreter

## 📖 Detailed Documentation

For specific information see:
- **Mandelbrot programs**: `examples/mandelbrot/README.md`
- **Main documentation**: `../README.md`

## 🤝 Contributing

New example programs are welcome! Please:
1. Choose category (`basic`, `graphics`, or new category)
2. Comment program well
3. Update README
4. Test functionality

---

**Happy programming with CrossBasic!** 🎉
