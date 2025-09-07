#!/usr/bin/env python3
"""
Interactive demonstration of line overwrite functionality
"""

import sys
import os
sys.path.insert(0, os.path.dirname(__file__))

from crossbasic import BasicEditor, BasicInterpreter

def demo_overwrite_interactive():
    """Interactive demo of line overwrite functionality"""
    print("CrossBasic Line Overwrite Feature Demo")
    print("=" * 40)
    print()
    print("This demo shows how the line editor handles overwriting existing lines.")
    print("You can run this demo and then try the actual editor to see it in action.")
    print()
    
    interpreter = BasicInterpreter()
    
    steps = [
        {
            'description': "Step 1: Adding initial program lines",
            'commands': [
                '10 PRINT "Original line 10"',
                '20 PRINT "Original line 20"',
                '30 END'
            ]
        },
        {
            'description': "Step 2: Listing the program",
            'commands': ['LIST']
        },
        {
            'description': "Step 3: Running the original program",
            'commands': ['RUN']
        },
        {
            'description': "Step 4: Overwriting existing lines",
            'commands': [
                '10 PRINT "OVERWRITTEN line 10"',
                '20 PRINT "OVERWRITTEN line 20"'
            ]
        },
        {
            'description': "Step 5: Adding a new line",
            'commands': ['25 PRINT "NEW line 25"']
        },
        {
            'description': "Step 6: Listing the updated program",
            'commands': ['LIST']
        },
        {
            'description': "Step 7: Running the updated program",
            'commands': ['RUN']
        }
    ]
    
    for step in steps:
        print(f"\n{step['description']}:")
        print("-" * 30)
        
        for command in step['commands']:
            if command == 'LIST':
                print("BASIC> list")
                interpreter.list_program()
            elif command == 'RUN':
                print("BASIC> run")
                interpreter.run()
            else:
                print(f"BASIC> {command}")
                
                # Clear operation results to get fresh feedback
                interpreter.clear_operation_results()
                
                if interpreter.load_program(command):
                    # Extract line number to show operation result
                    try:
                        from crossbasic import BasicLexer, TokenType
                        lexer = BasicLexer(command)
                        tokens = lexer.tokenize()
                        if tokens and tokens[0].type == TokenType.NUMBER:
                            line_number = int(tokens[0].value)
                            operation = interpreter.get_last_line_operation(line_number)
                            if operation == 'overwritten':
                                print(f"Line {line_number} overwritten")
                            elif operation == 'added':
                                print(f"Line {line_number} added to program")
                            else:
                                print("Line processed")
                        else:
                            print("Command processed")
                    except:
                        print("Command processed")
                else:
                    print("Error processing command")
        
        # Pause between steps
        if step != steps[-1]:  # Don't pause after the last step
            input("\nPress Enter to continue to the next step...")
    
    print("\n" + "=" * 40)
    print("Demo completed!")
    print()
    print("Key points demonstrated:")
    print("✓ New lines are added with 'Line X added to program'")
    print("✓ Existing lines are replaced with 'Line X overwritten'")
    print("✓ Program maintains proper line order")
    print("✓ Overwritten lines completely replace the original")
    print("✓ LIST and RUN commands show the current state")
    print()
    print("Try it yourself:")
    print("1. Run: python crossbasic.py")
    print("2. Enter some numbered lines")
    print("3. Re-enter the same line numbers with different content")
    print("4. Watch for the 'overwritten' vs 'added' messages!")

if __name__ == "__main__":
    demo_overwrite_interactive()
