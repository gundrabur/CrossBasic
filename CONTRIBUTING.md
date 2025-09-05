# Contributing to CrossBasic

Thank you for your interest in contributing to CrossBasic! This document provides guidelines for contributing to the project.

## 🤝 How to Contribute

### Reporting Issues
- Check existing issues first to avoid duplicates
- Use clear, descriptive titles
- Include steps to reproduce the issue
- Specify your operating system and Python version
- Include relevant code snippets or error messages

### Feature Requests
- Describe the feature clearly
- Explain why it would be useful
- Consider backward compatibility
- Provide examples of usage

### Code Contributions

#### Getting Started
1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/CrossBasic.git`
3. Create a new branch: `git checkout -b feature/your-feature-name`
4. Install dependencies: `pip install -r requirements.txt`

#### Development Guidelines
- Follow Python PEP 8 style guidelines
- Write clear, self-documenting code
- Add docstrings to new functions and classes
- Include comments for complex logic
- Test your changes thoroughly

#### Testing
- Run existing tests: `python test_crossbasic.py`
- Test your changes with example programs
- Ensure graphics programs work correctly
- Test on multiple platforms if possible

#### Adding New BASIC Commands
1. Add keyword to `BasicLexer.KEYWORDS`
2. Implement parser method in `BasicParser`
3. Add execution method in `BasicInterpreter`
4. Update documentation
5. Add example usage

#### Adding New Functions
1. Add function to `BasicInterpreter.builtin_functions`
2. Implement the function logic
3. Add documentation
4. Create test examples

#### Pull Requests
- Create clear, descriptive commit messages
- Reference related issues
- Include tests for new features
- Update documentation as needed
- Ensure all tests pass

## 📝 Code Style

### Python Code
```python
# Use descriptive variable names
def parse_expression(self):
    """Parse a mathematical expression."""
    # Implementation here
    pass

# Add type hints where appropriate
def evaluate_function(self, name: str, args: List[Any]) -> Any:
    """Evaluate a built-in function."""
    # Implementation here
    pass
```

### BASIC Code (Examples)
```basic
REM Use clear comments
10 PRINT "Hello World"  REM This prints a greeting
20 LET X = 10          REM Set variable X to 10
30 FOR I = 1 TO X      REM Loop from 1 to X
40   PRINT I          REM Print current number
50 NEXT I             REM End of loop
```

## 🎯 Areas for Contribution

### High Priority
- Array support (DIM statements)
- String functions (LEFT$, RIGHT$, MID$)
- File I/O operations (OPEN, CLOSE, INPUT#, PRINT#)
- Better error messages and debugging
- Performance optimizations

### Medium Priority
- Sound support (BEEP, PLAY)
- More graphics primitives
- Additional mathematical functions
- Enhanced graphics colors and modes
- Save/Load functionality

### Low Priority
- Syntax highlighting
- IDE integration
- Advanced debugging features
- Plugin system
- Web interface

## 🐛 Bug Reports

When reporting bugs, please include:

### System Information
- Operating System (Windows/macOS/Linux)
- Python version
- Pygame version
- CrossBasic version/commit

### Bug Description
- What you expected to happen
- What actually happened
- Steps to reproduce
- Relevant code or program files
- Error messages or screenshots

### Example Bug Report
```
**Bug Description**: Graphics window doesn't close properly on Windows

**Expected**: Graphics window should close when program ends
**Actual**: Window remains open and becomes unresponsive

**Steps to Reproduce**:
1. Load examples/graphics/grafik_demo.bas
2. Run the program
3. Wait for completion
4. Try to close graphics window

**System**: Windows 11, Python 3.11, Pygame 2.5.0
**Error**: No error message, window just becomes unresponsive
```

## 📚 Documentation

### Code Documentation
- Add docstrings to all public functions and classes
- Use clear, descriptive parameter names
- Include usage examples in docstrings
- Document any side effects or limitations

### README Updates
- Keep feature lists up to date
- Add new examples to the documentation
- Update installation instructions if needed
- Include screenshots for new graphics features

### Example Programs
- Comment your code clearly
- Include a brief description at the top
- Test thoroughly before submitting
- Add to appropriate examples subfolder

## 🌟 Recognition

Contributors will be:
- Listed in the contributors section
- Mentioned in release notes
- Given credit for significant features

## 📬 Contact

- Create an issue for questions
- Use discussions for general questions
- Tag maintainers for urgent issues

---

**Thank you for helping make CrossBasic better!** 🎉
