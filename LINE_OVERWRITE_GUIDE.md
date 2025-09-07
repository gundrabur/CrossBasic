# Line Overwrite Feature Documentation

## Overview
The CrossBasic Line Editor now supports overwriting existing program lines when you enter a line with an already existing line number. This feature makes it easy to modify and fix program lines without having to delete them first.

## How It Works

### Adding New Lines
When you enter a line with a line number that doesn't exist in the program:
```
BASIC> 10 PRINT "Hello World"
Line 10 added to program
```

### Overwriting Existing Lines
When you enter a line with a line number that already exists in the program:
```
BASIC> 10 PRINT "Hello Universe"
Line 10 overwritten
```

## Example Session

Here's a complete example demonstrating the line overwrite functionality:

```
BASIC> 10 PRINT "First version"
Line 10 added to program

BASIC> 20 PRINT "Second line"
Line 20 added to program

BASIC> 30 END
Line 30 added to program

BASIC> list
10 PRINT "First version"
20 PRINT "Second line"
30 END

BASIC> run
First version
Second line

BASIC> 10 PRINT "Updated version"
Line 10 overwritten

BASIC> 20 PRINT "Modified second line"
Line 20 overwritten

BASIC> list
10 PRINT "Updated version"
20 PRINT "Modified second line"
30 END

BASIC> run
Updated version
Modified second line
```

## Technical Details

### Implementation
- The editor checks if a line number already exists before adding a new line
- If the line number exists, it replaces the existing line completely
- If the line number doesn't exist, it adds the line as a new program line
- The `__lines__` list is properly maintained to avoid duplicates

### Feedback Messages
- **"Line X added to program"** - New line number added
- **"Line X overwritten"** - Existing line number replaced
- **"Error adding line to program"** - Syntax or other error occurred

### Program Structure
When lines are overwritten:
- The program maintains proper line number order
- All variables and program state remain unchanged
- The LIST command shows the updated program correctly
- The RUN command executes the modified program

## Use Cases

### Bug Fixing
Quickly fix errors in your program:
```
BASIC> 10 PRINT "Hello Wrold"    # Typo
Line 10 added to program

BASIC> run
Hello Wrold

BASIC> 10 PRINT "Hello World"    # Fix typo
Line 10 overwritten

BASIC> run
Hello World
```

### Program Development
Iteratively develop and refine your program:
```
BASIC> 10 FOR I = 1 TO 5
Line 10 added to program

BASIC> 20 PRINT I
Line 20 added to program

BASIC> 30 NEXT I
Line 30 added to program

BASIC> run
1
2
3
4
5

BASIC> 20 PRINT "Number:", I
Line 20 overwritten

BASIC> run
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
```

### Algorithm Refinement
Experiment with different implementations:
```
BASIC> 10 LET X = 5 * 5          # Simple calculation
Line 10 added to program

BASIC> 10 LET X = SQR(625)       # More sophisticated
Line 10 overwritten

BASIC> 10 LET X = 5 ^ 2          # Different approach
Line 10 overwritten
```

## Benefits

1. **Efficiency**: No need to delete lines before modifying them
2. **Natural Workflow**: Matches expectations from other BASIC interpreters
3. **Error Recovery**: Easy to fix mistakes without losing program structure
4. **Iterative Development**: Supports rapid prototyping and refinement
5. **Clear Feedback**: Always know whether you're adding or overwriting

## Compatibility

- ✅ **Backward Compatible**: Existing programs work unchanged
- ✅ **Cross-Platform**: Works on Windows, macOS, and Linux
- ✅ **File Operations**: Saved programs reflect the current state
- ✅ **All Commands**: Works with LIST, RUN, SAVE, LOAD

## Advanced Usage

### Replacing Multiple Lines
You can overwrite multiple lines in sequence:
```
BASIC> 10 PRINT "Old line 10"
Line 10 added to program

BASIC> 20 PRINT "Old line 20"
Line 20 added to program

BASIC> 10 PRINT "New line 10"
Line 10 overwritten

BASIC> 20 PRINT "New line 20"
Line 20 overwritten
```

### Inserting Between Existing Lines
You can add new lines between existing ones:
```
BASIC> 10 PRINT "Start"
Line 10 added to program

BASIC> 30 PRINT "End"
Line 30 added to program

BASIC> 20 PRINT "Middle"
Line 20 added to program

BASIC> list
10 PRINT "Start"
20 PRINT "Middle"
30 PRINT "End"
```

## Error Handling

If you try to overwrite a line with invalid syntax:
```
BASIC> 10 PRINT "Valid line"
Line 10 added to program

BASIC> 10 PRNT "Invalid syntax"
Syntax Error: Parser Error at line 1: Unknown statement: PRNT
```

The original line remains unchanged when syntax errors occur.

## Tips

1. **Use LIST frequently** to see your current program state
2. **Test with RUN** after making changes
3. **Use SAVE** to preserve your work
4. **Remember line numbers** are sorted automatically
5. **Check feedback messages** to confirm add vs. overwrite operations
