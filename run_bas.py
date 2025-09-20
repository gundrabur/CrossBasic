#!/usr/bin/env python3
"""
CrossBasic File Runner - Wrapper script to run .bas files directly
"""

import sys
import os
from pathlib import Path

def main():
    if len(sys.argv) < 2:
        print("Usage: python run_bas.py <filename.bas>")
        sys.exit(1)
    
    filename = sys.argv[1]
    
    if not os.path.exists(filename):
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    
    # Import the CrossBasic interpreter
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    from crossbasic import BasicInterpreter
    
    try:
        # Read the BASIC file
        with open(filename, 'r') as f:
            program_text = f.read()
        
        # Create interpreter and load program
        interpreter = BasicInterpreter()
        
        print(f"Loading and running: {filename}")
        print("=" * 50)
        
        if interpreter.load_program(program_text):
            interpreter.run()
        else:
            print(f"Error: Could not load program from {filename}")
            sys.exit(1)
        
        # Keep graphics window open if it was used
        if interpreter.graphics.screen is not None:
            print("\nProgram finished. Graphics window will stay open.")
            print("Close the graphics window to exit.")
            # Simple wait loop for graphics window
            import pygame
            while interpreter.graphics.running:
                try:
                    for event in pygame.event.get():
                        if event.type == pygame.QUIT:
                            interpreter.graphics.running = False
                    pygame.time.wait(100)  # Small delay
                except:
                    break
        
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error running program: {e}")
        sys.exit(1)
    finally:
        # Cleanup
        try:
            interpreter.graphics.close()
        except:
            pass

if __name__ == "__main__":
    main()