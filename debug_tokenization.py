#!/usr/bin/env python3
"""
Debug test for is_line_number_only
"""
from crossbasic import BasicEditor, BasicInterpreter, BasicLexer, TokenType

def debug_tokenization():
    print("Debug tokenization for line number only")
    print("=" * 50)
    
    test_cases = ["10", "20", "100"]
    
    for test_case in test_cases:
        print(f"\nTesting: '{test_case}'")
        try:
            lexer = BasicLexer(test_case)
            tokens = lexer.tokenize()
            print(f"  Tokens: {tokens}")
            print(f"  Number of tokens: {len(tokens)}")
            
            if tokens:
                print(f"  First token type: {tokens[0].type}")
                print(f"  First token value: {tokens[0].value}")
                print(f"  Is NUMBER type: {tokens[0].type == TokenType.NUMBER}")
                
                if len(tokens) == 1 and tokens[0].type == TokenType.NUMBER:
                    first_token = tokens[0].value
                    print(f"  Contains dot: {'.' in first_token}")
                    if '.' not in first_token:
                        print(f"  Would return: True, {int(first_token)}")
                    else:
                        print(f"  Would return: False (contains dot)")
                else:
                    print(f"  Would return: False (wrong token count or type)")
        except Exception as e:
            print(f"  Exception: {e}")
            print(f"  Would return: False (exception)")

if __name__ == "__main__":
    debug_tokenization()
