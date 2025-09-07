#!/usr/bin/env python3
"""
Final validation of line deletion and ordering functionality
"""
from crossbasic import BasicEditor, BasicInterpreter

def final_validation():
    print("Final Validation: Line Deletion and Ordering")
    print("=" * 50)
    
    # Create interpreter and editor
    interpreter = BasicInterpreter()
    editor = BasicEditor(interpreter)
    
    print("1. Testing line addition and ordering:")
    
    # Add lines out of order
    print("   Adding line 30...")
    interpreter.load_program('30 PRINT "Line 30"')
    
    print("   Adding line 10...")
    interpreter.load_program('10 PRINT "Line 10"')
    
    print("   Adding line 20...")
    interpreter.load_program('20 PRINT "Line 20"')
    
    print("\n   Program after adding lines out of order:")
    interpreter.list_program()
    
    print("\n2. Testing line deletion:")
    
    # Test line number only detection
    is_only, line_num = editor.is_line_number_only("20")
    print(f"   is_line_number_only('20') = {is_only}, {line_num}")
    
    # Delete line 20
    print("   Deleting line 20...")
    success = interpreter.delete_line(20)
    print(f"   Deletion successful: {success}")
    
    print("\n   Program after deleting line 20:")
    interpreter.list_program()
    
    print("\n3. Testing addition of new line in middle:")
    
    print("   Adding line 15...")
    interpreter.load_program('15 PRINT "Line 15"')
    
    print("\n   Program after adding line 15:")
    interpreter.list_program()
    
    print("\n4. Testing deletion of non-existent line:")
    
    print("   Attempting to delete line 50...")
    success = interpreter.delete_line(50)
    print(f"   Deletion successful: {success}")
    
    print("\n   Final program state:")
    interpreter.list_program()
    
    print("\n5. Testing various line number only patterns:")
    test_cases = [
        ("10", True, 10),
        ("100", True, 100),
        ("10 PRINT \"hello\"", False, 0),
        ("PRINT \"hello\"", False, 0),
        ("10.5", False, 0),
        ("", False, 0),
        ("abc", False, 0)
    ]
    
    for test_input, expected_is_only, expected_line_num in test_cases:
        is_only, line_num = editor.is_line_number_only(test_input)
        status = "✓" if (is_only == expected_is_only and line_num == expected_line_num) else "✗"
        print(f"   {status} '{test_input}' -> {is_only}, {line_num} (expected: {expected_is_only}, {expected_line_num})")
    
    print("\n✅ Validation complete!")

if __name__ == "__main__":
    final_validation()
