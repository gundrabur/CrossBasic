# Fundamental BASIC Programs

These programs demonstrate the fundamental concepts of BASIC programming with CrossBasic.

## 📁 Programs

### `example1.bas` - Mathematics and Output
**Purpose**: Basics of BASIC programming
**Learning Goals**: 
- Define variables with `LET`
- Output with `PRINT`
- Mathematical calculations
- Built-in functions (`SQR`, `RND`)

**Usage**:
```bash
CrossBasic> load examples/basic/example1.bas
CrossBasic> run
```

**What you'll learn**:
- Variable assignment: `LET A = 10`
- Mathematical operations: `A + B`
- Function calls: `SQR(16)`
- Formatted output with semicolons

---

### `example2.bas` - Loops and Conditions
**Purpose**: Control structures in BASIC
**Learning Goals**:
- `FOR...NEXT` loops
- `IF...THEN...ELSE` conditions
- User input with `INPUT`
- Step sizes in loops

**Usage**:
```bash
CrossBasic> load examples/basic/example2.bas
CrossBasic> run
```

**What you'll learn**:
- Simple loops: `FOR I = 1 TO 10`
- Step loops: `FOR N = 2 TO 20 STEP 2`
- Conditional output: `IF X > 10 THEN...ELSE...`
- Interactive input

---

### `number_guessing.bas` - Interactive Game
**Purpose**: Complete interactive program
**Learning Goals**:
- Random numbers with `RND`
- Program loops with `GOTO`
- Implement game logic
- User interaction

**Usage**:
```bash
CrossBasic> load examples/basic/number_guessing.bas
CrossBasic> run
```

**Game Rules**:
- Computer picks number between 1-100
- You have 10 attempts
- Hints: "Too high" or "Too low"
- Win with correct number

**What you'll learn**:
- Random numbers: `INT(RND(100)) + 1`
- Program flow with `GOTO`
- Comparison operators
- Game logic programming

## 🎯 Recommended Learning Order

1. **Start**: `example1.bas` - Understand basics
2. **Build**: `example2.bas` - Learn control structures  
3. **Apply**: `number_guessing.bas` - Complete program

## 💡 Programming Tips

### Variables
```basic
LET NAME = "John"          ' String
LET AGE = 25              ' Integer
LET PI = 3.14159          ' Float
```

### Loops
```basic
' Simple loop
FOR I = 1 TO 10
    PRINT I
NEXT I

' Loop with step
FOR I = 0 TO 100 STEP 5
    PRINT I
NEXT I
```

### Conditions
```basic
IF AGE >= 18 THEN 
    PRINT "Adult"
ELSE 
    PRINT "Minor"
```

### Input/Output
```basic
INPUT "Your name: ", NAME
PRINT "Hello "; NAME
```

## 🔧 Technical Details

**Runtime**: All programs < 30 seconds
**Dependencies**: Only CrossBasic interpreter
**Platform**: All (Windows, macOS, Linux)

## 🚀 Advanced Programs

After these basics, you can continue with:
- **Graphics programs**: `../graphics/`
- **Mandelbrot fractals**: `../mandelbrot/`

---

**These programs form the foundation for all further CrossBasic development!** 📚
