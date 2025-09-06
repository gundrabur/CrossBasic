#!/usr/bin/env python3
"""
CrossBasic - A Cross-Platform BASIC Interpreter in Python
With support for basic BASIC commands and graphics functions

Author: Christian Moeller, September 2025
Version: 1.0
"""

import re
import math
import random
import sys
import os
from typing import Dict, List, Any, Optional, Union
from enum import Enum
import pygame
import threading
import time

class TokenType(Enum):
    """Token types for the lexer"""
    NUMBER = "NUMBER"
    STRING = "STRING"
    IDENTIFIER = "IDENTIFIER"
    KEYWORD = "KEYWORD"
    OPERATOR = "OPERATOR"
    DELIMITER = "DELIMITER"
    NEWLINE = "NEWLINE"
    EOF = "EOF"
    COMMENT = "COMMENT"

class Token:
    """Represents a token"""
    def __init__(self, type_: TokenType, value: str, line: int = 0, column: int = 0):
        self.type = type_
        self.value = value
        self.line = line
        self.column = column
    
    def __repr__(self):
        return f"Token({self.type}, {self.value!r})"

class BasicLexer:
    """Lexical analysis for BASIC code"""
    
    KEYWORDS = {
        'PRINT', 'LET', 'IF', 'THEN', 'ELSE', 'FOR', 'TO', 'STEP', 'NEXT',
        'WHILE', 'WEND', 'GOTO', 'GOSUB', 'RETURN', 'END', 'INPUT', 'DIM',
        'AND', 'OR', 'NOT', 'REM', 'DATA', 'READ', 'RESTORE', 'CLS', 'STOP',
        'RUN', 'LIST', 'NEW', 'SAVE', 'LOAD', 'POKE', 'PEEK', 'SYS',
        # Graphics commands
        'GRAPHICS', 'PLOT', 'LINE', 'CIRCLE', 'RECT', 'FILL', 'COLOR', 'PSET',
        'SCREEN', 'LOCATE', 'POINT', 'PAINT'
    }
    
    OPERATORS = {
        '+', '-', '*', '/', '^', '=', '<', '>', '<=', '>=', '<>', '!=',
        '(', ')', '[', ']', '{', '}', ',', ';', ':', '"', "'"
    }
    
    def __init__(self, text: str):
        self.text = text
        self.pos = 0
        self.line = 1
        self.column = 1
        self.tokens = []
    
    def error(self, message: str):
        """Error handling"""
        raise SyntaxError(f"Lexer Error at line {self.line}, column {self.column}: {message}")
    
    def peek(self, offset: int = 0) -> str:
        """Looks at the character at position pos + offset"""
        pos = self.pos + offset
        if pos >= len(self.text):
            return '\0'
        return self.text[pos]
    
    def advance(self) -> str:
        """Moves the pointer forward and returns the current character"""
        if self.pos >= len(self.text):
            return '\0'
        char = self.text[self.pos]
        self.pos += 1
        if char == '\n':
            self.line += 1
            self.column = 1
        else:
            self.column += 1
        return char
    
    def skip_whitespace(self):
        """Skips whitespace (except newlines)"""
        while self.peek() in ' \t\r':
            self.advance()
    
    def read_number(self) -> Token:
        """Liest eine Zahl (Integer oder Float)"""
        start_pos = self.pos
        has_dot = False
        
        while self.peek().isdigit() or (self.peek() == '.' and not has_dot):
            if self.peek() == '.':
                has_dot = True
            self.advance()
        
        value = self.text[start_pos:self.pos]
        return Token(TokenType.NUMBER, value, self.line, self.column)
    
    def read_string(self, quote_char: str) -> Token:
        """Reads a string"""
        value = ""
        self.advance()  # Skip opening quotation mark
        
        while self.peek() != quote_char and self.peek() != '\0':
            value += self.advance()
        
        if self.peek() == quote_char:
            self.advance()  # Skip closing quotation mark
        else:
            self.error(f"Unterminated string starting with {quote_char}")
        
        return Token(TokenType.STRING, value, self.line, self.column)
    
    def read_identifier(self) -> Token:
        """Reads an identifier or keyword"""
        start_pos = self.pos
        
        while (self.peek().isalnum() or self.peek() in '_$'):
            self.advance()
        
        value = self.text[start_pos:self.pos].upper()
        token_type = TokenType.KEYWORD if value in self.KEYWORDS else TokenType.IDENTIFIER
        
        return Token(token_type, value, self.line, self.column)
    
    def read_comment(self) -> Token:
        """Liest einen Kommentar (REM oder ')"""
        start_pos = self.pos
        
        while self.peek() != '\n' and self.peek() != '\0':
            self.advance()
        
        value = self.text[start_pos:self.pos]
        return Token(TokenType.COMMENT, value, self.line, self.column)
    
    def tokenize(self) -> List[Token]:
        """Zerlegt den Text in Tokens"""
        self.tokens = []
        
        while self.pos < len(self.text):
            char = self.peek()
            
            if char == '\0':
                break
            elif char in ' \t\r':
                self.skip_whitespace()
            elif char == '\n':
                self.tokens.append(Token(TokenType.NEWLINE, char, self.line, self.column))
                self.advance()
            elif char.isdigit():
                self.tokens.append(self.read_number())
            elif char in '"\'':
                self.tokens.append(self.read_string(char))
            elif char.isalpha() or char == '_':
                token = self.read_identifier()
                if token.value == 'REM':
                    # REM-Kommentar
                    self.tokens.append(self.read_comment())
                else:
                    self.tokens.append(token)
            elif char == '\'':
                # Kommentar mit Apostroph
                self.tokens.append(self.read_comment())
            elif char in self.OPERATORS:
                # Check two-character operators
                two_char = char + self.peek(1)
                if two_char in ['<=', '>=', '<>', '!=']:
                    self.advance()
                    self.advance()
                    self.tokens.append(Token(TokenType.OPERATOR, two_char, self.line, self.column))
                else:
                    self.tokens.append(Token(TokenType.OPERATOR, char, self.line, self.column))
                    self.advance()
            else:
                self.error(f"Unexpected character: {char}")
        
        self.tokens.append(Token(TokenType.EOF, "", self.line, self.column))
        return self.tokens

class BasicParser:
    """Parser for BASIC syntax"""
    
    def __init__(self, tokens: List[Token]):
        self.tokens = tokens
        self.pos = 0
        self.current_token = self.tokens[0] if tokens else Token(TokenType.EOF, "")
    
    def error(self, message: str):
        """Error handling"""
        raise SyntaxError(f"Parser Error at line {self.current_token.line}: {message}")
    
    def advance(self):
        """Moves to the next token"""
        if self.pos < len(self.tokens) - 1:
            self.pos += 1
            self.current_token = self.tokens[self.pos]
    
    def peek(self, offset: int = 1) -> Token:
        """Schaut auf das Token an Position pos + offset"""
        pos = self.pos + offset
        if pos >= len(self.tokens):
            return Token(TokenType.EOF, "")
        return self.tokens[pos]
    
    def match(self, *token_types: TokenType) -> bool:
        """Checks if the current token matches one of the given types"""
        return self.current_token.type in token_types
    
    def consume(self, token_type: TokenType, message: str = "") -> Token:
        """Konsumiert ein Token des angegebenen Typs"""
        if self.current_token.type == token_type:
            token = self.current_token
            self.advance()
            return token
        else:
            self.error(message or f"Expected {token_type}, got {self.current_token.type}")
    
    def parse_program(self) -> Dict[int, Any]:
        """Parses a complete BASIC program"""
        program = {}
        program_lines = []  # Store lines in original order for LIST command
        line_position = 0   # Track position in file
        
        while not self.match(TokenType.EOF):
            if self.match(TokenType.NEWLINE):
                self.advance()
                continue
            
            line = self.parse_line()
            if line:
                line_number, statement, had_line_number = line
                
                # For LIST command: store in order with display info
                program_lines.append({
                    'statement': statement,
                    'line_number': line_number if had_line_number else None,
                    'had_line_number': had_line_number,
                    'position': line_position
                })
                
                # For execution: store numbered lines in program dict
                if had_line_number:
                    program[line_number] = (statement, True, line_position)
                
                line_position += 1
        
        # Store the ordered lines for LIST command
        program['__lines__'] = program_lines
        return program
    
    def parse_line(self) -> Optional[tuple]:
        """Parses a line with optional line number"""
        line_number = None
        had_line_number = False
        
        # Check line number
        if self.match(TokenType.NUMBER):
            line_number = int(self.current_token.value)
            had_line_number = True
            self.advance()
        
        # Statement parsen
        statement = self.parse_statement()
        
        # Newline oder EOF erwarten
        if self.match(TokenType.NEWLINE):
            self.advance()
        elif not self.match(TokenType.EOF):
            self.error("Expected newline or end of file")
        
        if statement:
            return (line_number or 0, statement, had_line_number)
        return None
    
    def parse_statement(self):
        """Parst ein Statement"""
        if self.match(TokenType.COMMENT):
            comment = self.current_token.value
            self.advance()
            return ('COMMENT', comment)
        
        if not self.match(TokenType.KEYWORD, TokenType.IDENTIFIER):
            return None
        
        keyword = self.current_token.value
        self.advance()
        
        if keyword == 'PRINT':
            return self.parse_print()
        elif keyword == 'LET':
            return self.parse_let()
        elif keyword == 'INPUT':
            return self.parse_input()
        elif keyword == 'IF':
            return self.parse_if()
        elif keyword == 'FOR':
            return self.parse_for()
        elif keyword == 'NEXT':
            return self.parse_next()
        elif keyword == 'WHILE':
            return self.parse_while()
        elif keyword == 'WEND':
            return ('WEND',)
        elif keyword == 'GOTO':
            return self.parse_goto()
        elif keyword == 'GOSUB':
            return self.parse_gosub()
        elif keyword == 'RETURN':
            return ('RETURN',)
        elif keyword == 'END':
            return ('END',)
        elif keyword == 'CLS':
            return ('CLS',)
        elif keyword == 'GRAPHICS':
            return self.parse_graphics()
        elif keyword == 'PLOT':
            return self.parse_plot()
        elif keyword == 'LINE':
            return self.parse_line_graphics()
        elif keyword == 'CIRCLE':
            return self.parse_circle()
        elif keyword == 'RECT':
            return self.parse_rect()
        elif keyword == 'COLOR':
            return self.parse_color()
        elif keyword == 'PSET':
            return self.parse_pset()
        else:
            # Possibly an assignment without LET
            if self.match(TokenType.OPERATOR) and self.current_token.value == '=':
                self.pos -= 1  # Back to variable name
                self.current_token = self.tokens[self.pos]
                return self.parse_assignment()
            else:
                self.error(f"Unknown statement: {keyword}")
    
    def parse_print(self):
        """Parses PRINT statement"""
        items = []
        separators = []
        
        if not self.match(TokenType.NEWLINE, TokenType.EOF):
            items.append(self.parse_expression())
            
            while self.match(TokenType.OPERATOR) and self.current_token.value in [',', ';']:
                sep = self.current_token.value
                separators.append(sep)
                self.advance()
                if not self.match(TokenType.NEWLINE, TokenType.EOF):
                    items.append(self.parse_expression())
        
        return ('PRINT', items, separators)
    
    def parse_let(self):
        """Parst LET-Statement"""
        return self.parse_assignment()
    
    def parse_assignment(self):
        """Parst Zuweisung"""
        var_name = self.consume(TokenType.IDENTIFIER, "Expected variable name").value
        if not (self.match(TokenType.OPERATOR) and self.current_token.value == '='):
            self.error("Expected '='")
        self.advance()
        expr = self.parse_expression()
        return ('LET', var_name, expr)
    
    def parse_input(self):
        """Parst INPUT-Statement"""
        prompt = ""
        
        # Optionaler Prompt-Text
        if self.match(TokenType.STRING):
            prompt = self.current_token.value
            self.advance()
            if self.match(TokenType.OPERATOR) and self.current_token.value in [',', ';']:
                self.advance()
        
        var_name = self.consume(TokenType.IDENTIFIER, "Expected variable name").value
        return ('INPUT', prompt, var_name)
    
    def parse_if(self):
        """Parst IF-Statement"""
        condition = self.parse_expression()
        if not (self.match(TokenType.KEYWORD) and self.current_token.value == 'THEN'):
            self.error("Expected THEN")
        self.advance()
        
        then_stmt = self.parse_statement()
        else_stmt = None
        
        if self.match(TokenType.KEYWORD) and self.current_token.value == 'ELSE':
            self.advance()
            else_stmt = self.parse_statement()
        
        return ('IF', condition, then_stmt, else_stmt)
    
    def parse_for(self):
        """Parst FOR-Statement"""
        var_name = self.consume(TokenType.IDENTIFIER, "Expected variable name").value
        if not (self.match(TokenType.OPERATOR) and self.current_token.value == '='):
            self.error("Expected '='")
        self.advance()
        
        start_expr = self.parse_expression()
        
        if not (self.match(TokenType.KEYWORD) and self.current_token.value == 'TO'):
            self.error("Expected TO")
        self.advance()
        
        end_expr = self.parse_expression()
        
        step_expr = ('NUMBER', 1)
        if self.match(TokenType.KEYWORD) and self.current_token.value == 'STEP':
            self.advance()
            step_expr = self.parse_expression()
        
        return ('FOR', var_name, start_expr, end_expr, step_expr)
    
    def parse_next(self):
        """Parst NEXT-Statement"""
        var_name = None
        if self.match(TokenType.IDENTIFIER):
            var_name = self.current_token.value
            self.advance()
        return ('NEXT', var_name)
    
    def parse_while(self):
        """Parst WHILE-Statement"""
        condition = self.parse_expression()
        return ('WHILE', condition)
    
    def parse_goto(self):
        """Parst GOTO-Statement"""
        line_number = self.consume(TokenType.NUMBER, "Expected line number").value
        return ('GOTO', int(line_number))
    
    def parse_gosub(self):
        """Parst GOSUB-Statement"""
        line_number = self.consume(TokenType.NUMBER, "Expected line number").value
        return ('GOSUB', int(line_number))
    
    def parse_graphics(self):
        """Parst GRAPHICS-Statement"""
        mode = 0
        if self.match(TokenType.NUMBER):
            mode = int(self.current_token.value)
            self.advance()
        return ('GRAPHICS', mode)
    
    def parse_plot(self):
        """Parst PLOT-Statement"""
        x = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        y = self.parse_expression()
        return ('PLOT', x, y)
    
    def parse_line_graphics(self):
        """Parst LINE-Statement"""
        x1 = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        y1 = self.parse_expression()
        if not (self.match(TokenType.KEYWORD) and self.current_token.value == 'TO'):
            self.error("Expected TO")
        self.advance()
        x2 = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        y2 = self.parse_expression()
        return ('LINE', x1, y1, x2, y2)
    
    def parse_circle(self):
        """Parst CIRCLE-Statement"""
        x = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        y = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        radius = self.parse_expression()
        return ('CIRCLE', x, y, radius)
    
    def parse_rect(self):
        """Parst RECT-Statement"""
        x = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        y = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        width = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        height = self.parse_expression()
        return ('RECT', x, y, width, height)
    
    def parse_color(self):
        """Parst COLOR-Statement"""
        color = self.parse_expression()
        return ('COLOR', color)
    
    def parse_pset(self):
        """Parst PSET-Statement"""
        x = self.parse_expression()
        self.consume(TokenType.OPERATOR, "Expected ','")
        y = self.parse_expression()
        return ('PSET', x, y)
    
    def parse_expression(self):
        """Parses an expression (with operator precedence)"""
        return self.parse_or()
    
    def parse_or(self):
        """Parst OR-Ausdruck"""
        left = self.parse_and()
        
        while self.match(TokenType.KEYWORD) and self.current_token.value == 'OR':
            op = self.current_token.value
            self.advance()
            right = self.parse_and()
            left = ('BINOP', left, op, right)
        
        return left
    
    def parse_and(self):
        """Parst AND-Ausdruck"""
        left = self.parse_equality()
        
        while self.match(TokenType.KEYWORD) and self.current_token.value == 'AND':
            op = self.current_token.value
            self.advance()
            right = self.parse_equality()
            left = ('BINOP', left, op, right)
        
        return left
    
    def parse_equality(self):
        """Parses equality/comparison expressions"""
        left = self.parse_relational()
        
        while (self.match(TokenType.OPERATOR) and 
               self.current_token.value in ['=', '<>', '!=']):
            op = self.current_token.value
            self.advance()
            right = self.parse_relational()
            left = ('BINOP', left, op, right)
        
        return left
    
    def parse_relational(self):
        """Parst Vergleichsoperatoren"""
        left = self.parse_addition()
        
        while (self.match(TokenType.OPERATOR) and 
               self.current_token.value in ['<', '>', '<=', '>=']):
            op = self.current_token.value
            self.advance()
            right = self.parse_addition()
            left = ('BINOP', left, op, right)
        
        return left
    
    def parse_addition(self):
        """Parst Addition und Subtraktion"""
        left = self.parse_multiplication()
        
        while (self.match(TokenType.OPERATOR) and 
               self.current_token.value in ['+', '-']):
            op = self.current_token.value
            self.advance()
            right = self.parse_multiplication()
            left = ('BINOP', left, op, right)
        
        return left
    
    def parse_multiplication(self):
        """Parst Multiplikation und Division"""
        left = self.parse_power()
        
        while (self.match(TokenType.OPERATOR) and 
               self.current_token.value in ['*', '/']):
            op = self.current_token.value
            self.advance()
            right = self.parse_power()
            left = ('BINOP', left, op, right)
        
        return left
    
    def parse_power(self):
        """Parst Potenzierung"""
        left = self.parse_unary()
        
        if self.match(TokenType.OPERATOR) and self.current_token.value == '^':
            op = self.current_token.value
            self.advance()
            right = self.parse_power()  # Rechtsassoziativ
            left = ('BINOP', left, op, right)
        
        return left
    
    def parse_unary(self):
        """Parses unary operators"""
        if self.match(TokenType.OPERATOR) and self.current_token.value in ['+', '-']:
            op = self.current_token.value
            self.advance()
            expr = self.parse_unary()
            return ('UNOP', op, expr)
        elif self.match(TokenType.KEYWORD) and self.current_token.value == 'NOT':
            op = self.current_token.value
            self.advance()
            expr = self.parse_unary()
            return ('UNOP', op, expr)
        
        return self.parse_primary()
    
    def parse_primary(self):
        """Parses primary expressions"""
        if self.match(TokenType.NUMBER):
            value = self.current_token.value
            self.advance()
            if '.' in value:
                return ('NUMBER', float(value))
            else:
                return ('NUMBER', int(value))
        
        elif self.match(TokenType.STRING):
            value = self.current_token.value
            self.advance()
            return ('STRING', value)
        
        elif self.match(TokenType.IDENTIFIER):
            name = self.current_token.value
            self.advance()
            
            # Check function call
            if self.match(TokenType.OPERATOR) and self.current_token.value == '(':
                self.advance()
                args = []
                
                if not (self.match(TokenType.OPERATOR) and self.current_token.value == ')'):
                    args.append(self.parse_expression())
                    while (self.match(TokenType.OPERATOR) and self.current_token.value == ','):
                        self.advance()
                        args.append(self.parse_expression())
                
                self.consume(TokenType.OPERATOR, "Expected ')'")
                return ('FUNCTION', name, args)
            else:
                return ('VARIABLE', name)
        
        elif self.match(TokenType.OPERATOR) and self.current_token.value == '(':
            self.advance()
            expr = self.parse_expression()
            self.consume(TokenType.OPERATOR, "Expected ')'")
            return expr
        
        else:
            self.error(f"Unexpected token: {self.current_token}")

class GraphicsEngine:
    """Graphics module with Pygame"""
    
    def __init__(self, width: int = 800, height: int = 600):
        self.width = width
        self.height = height
        self.screen = None
        self.running = False
        self.current_color = (255, 255, 255)  # White
        self.background_color = (0, 0, 0)     # Black
        
        # Color palette
        self.colors = {
            0: (0, 0, 0),       # Black
            1: (255, 255, 255), # White
            2: (255, 0, 0),     # Red
            3: (0, 255, 0),     # Green
            4: (0, 0, 255),     # Blue
            5: (255, 255, 0),   # Yellow
            6: (255, 0, 255),   # Magenta
            7: (0, 255, 255),   # Cyan
            8: (128, 128, 128), # Grau
            9: (255, 128, 0),   # Orange
        }
    
    def init_graphics(self, mode: int = 0):
        """Initializes the graphics system"""
        if not self.running:
            pygame.init()
            self.screen = pygame.display.set_mode((self.width, self.height))
            pygame.display.set_caption("CrossBasic Graphics")
            self.screen.fill(self.background_color)
            pygame.display.flip()
            self.running = True
    
    def _handle_events(self):
        """Handle pygame events - must be called from main thread on macOS"""
        if self.running:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    self.running = False
    
    def close(self):
        """Closes the graphics window"""
        if self.running:
            self.running = False
            # Quit pygame
            try:
                pygame.display.quit()
                pygame.quit()
            except:
                pass  # Ignore errors when closing
            self.screen = None
    
    def reset(self):
        """Completely resets the graphics window"""
        # Close old window
        if self.running:
            self.close()
        
        # Kurz warten damit Pygame richtig cleanup macht
        import time
        time.sleep(0.1)
        
        # Neues Fenster öffnen
        self.init_graphics()
    
    def clear_screen(self):
        """Löscht den Bildschirm"""
        if self.screen:
            self._handle_events()  # Handle events on main thread
            self.screen.fill(self.background_color)
            pygame.display.flip()
    
    def set_color(self, color_index: int):
        """Setzt die aktuelle Farbe"""
        if color_index in self.colors:
            self.current_color = self.colors[color_index]
    
    def plot_point(self, x: int, y: int):
        """Zeichnet einen Punkt"""
        if self.screen:
            self._handle_events()  # Handle events on main thread
            pygame.draw.circle(self.screen, self.current_color, (int(x), int(y)), 1)
            pygame.display.flip()
    
    def draw_line(self, x1: int, y1: int, x2: int, y2: int):
        """Zeichnet eine Linie"""
        if self.screen:
            self._handle_events()  # Handle events on main thread
            pygame.draw.line(self.screen, self.current_color, 
                           (int(x1), int(y1)), (int(x2), int(y2)))
            pygame.display.flip()
    
    def draw_circle(self, x: int, y: int, radius: int):
        """Zeichnet einen Kreis"""
        if self.screen:
            self._handle_events()  # Handle events on main thread
            pygame.draw.circle(self.screen, self.current_color, 
                             (int(x), int(y)), int(radius), 1)
            pygame.display.flip()
    
    def draw_rect(self, x: int, y: int, width: int, height: int):
        """Zeichnet ein Rechteck"""
        if self.screen:
            self._handle_events()  # Handle events on main thread
            pygame.draw.rect(self.screen, self.current_color, 
                           (int(x), int(y), int(width), int(height)), 1)
            pygame.display.flip()

class BasicInterpreter:
    """BASIC-Interpreter"""
    
    def __init__(self):
        self.variables = {}
        self.program = {}
        self.current_line = 0
        self.running = False
        self.call_stack = []
        self.for_stack = []
        self.while_stack = []
        self.graphics = GraphicsEngine()
        self.goto_executed = False  # Flag to track GOTO execution
        
        # Built-in functions
        self.builtin_functions = {
            'ABS': lambda x: abs(x),
            'INT': lambda x: int(x),
            'SQR': lambda x: math.sqrt(x),
            'SIN': lambda x: math.sin(x),
            'COS': lambda x: math.cos(x),
            'TAN': lambda x: math.tan(x),
            'RND': lambda x=None: random.random() if x is None else random.randint(1, int(x)),
            'LEN': lambda s: len(str(s)),
            'CHR': lambda x: chr(int(x)),
            'ASC': lambda s: ord(str(s)[0]) if str(s) else 0,
        }
    
    def error(self, message: str):
        """Fehlerbehandlung"""
        print(f"Runtime Error at line {self.current_line}: {message}")
        self.running = False
    
    def load_program(self, program_text: str):
        """Lädt ein BASIC-Programm"""
        try:
            lexer = BasicLexer(program_text)
            tokens = lexer.tokenize()
            parser = BasicParser(tokens)
            self.program = parser.parse_program()
            return True
        except Exception as e:
            print(f"Error loading program: {e}")
            return False
    
    def run(self):
        """Executes the loaded program"""
        if not self.program:
            print("No program loaded")
            return
        
        # Prüfen ob das Programm Grafik-Befehle enthält
        has_graphics = any(
            isinstance(stmt, tuple) and len(stmt) > 0 and 
            stmt[0] in ['GRAPHICS', 'PLOT', 'LINE', 'CIRCLE', 'RECT', 'COLOR', 'PSET', 'CLS']
            for key, value in self.program.items() 
            if key != '__lines__' and isinstance(value, tuple) and len(value) >= 3
            for stmt, _, _ in [value]  # Extract statement from tuple
        )
        
        # Grafikfenster zurücksetzen falls es bereits läuft und das Programm Grafik verwendet
        if has_graphics and self.graphics.running:
            print("Resetting graphics window...")
            self.graphics.reset()
        
        self.running = True
        numeric_keys = [k for k in self.program.keys() if isinstance(k, int)]
        self.current_line = min(numeric_keys) if numeric_keys else 0
        self.goto_executed = False  # Flag to track if GOTO was executed
        
        try:
            while self.running and self.current_line in self.program:
                if self.current_line == '__lines__':
                    # Skip the special __lines__ entry - this shouldn't happen since current_line should be numeric
                    numeric_keys = [k for k in self.program.keys() if isinstance(k, int) and k > self.current_line]
                    if numeric_keys:
                        self.current_line = min(numeric_keys)
                    else:
                        break
                    continue
                    
                statement, _, _ = self.program[self.current_line]  # Extract statement, ignore had_line_number and position
                self.goto_executed = False  # Reset flag before executing statement
                self.execute_statement(statement)
                
                if self.running and not self.goto_executed:
                    # Only advance to next line if GOTO wasn't executed
                    numeric_keys = [k for k in self.program.keys() if isinstance(k, int) and k > self.current_line]
                    if numeric_keys:
                        self.current_line = min(numeric_keys)
                    else:
                        break
        
        except KeyboardInterrupt:
            print("\nProgram interrupted")
        except Exception as e:
            self.error(str(e))
        finally:
            self.running = False
    
    def execute_statement(self, statement):
        """Executes a statement"""
        if not statement:
            return
        
        cmd = statement[0]
        
        if cmd == 'PRINT':
            self.execute_print(statement)
        elif cmd == 'LET':
            self.execute_let(statement)
        elif cmd == 'INPUT':
            self.execute_input(statement)
        elif cmd == 'IF':
            self.execute_if(statement)
        elif cmd == 'FOR':
            self.execute_for(statement)
        elif cmd == 'NEXT':
            self.execute_next(statement)
        elif cmd == 'WHILE':
            self.execute_while(statement)
        elif cmd == 'WEND':
            self.execute_wend(statement)
        elif cmd == 'GOTO':
            self.execute_goto(statement)
        elif cmd == 'GOSUB':
            self.execute_gosub(statement)
        elif cmd == 'RETURN':
            self.execute_return(statement)
        elif cmd == 'END':
            self.running = False
        elif cmd == 'CLS':
            self.execute_cls(statement)
        elif cmd == 'GRAPHICS':
            self.execute_graphics(statement)
        elif cmd == 'PLOT':
            self.execute_plot(statement)
        elif cmd == 'LINE':
            self.execute_line(statement)
        elif cmd == 'CIRCLE':
            self.execute_circle(statement)
        elif cmd == 'RECT':
            self.execute_rect(statement)
        elif cmd == 'COLOR':
            self.execute_color(statement)
        elif cmd == 'PSET':
            self.execute_pset(statement)
        elif cmd == 'COMMENT':
            pass  # Kommentare ignorieren
        else:
            self.error(f"Unknown command: {cmd}")
    
    def evaluate_expression(self, expr):
        """Wertet einen Ausdruck aus"""
        if not expr:
            return 0
        
        expr_type = expr[0]
        
        if expr_type == 'NUMBER':
            return expr[1]
        elif expr_type == 'STRING':
            return expr[1]
        elif expr_type == 'VARIABLE':
            var_name = expr[1]
            return self.variables.get(var_name, 0)
        elif expr_type == 'BINOP':
            left = self.evaluate_expression(expr[1])
            op = expr[2]
            right = self.evaluate_expression(expr[3])
            return self.apply_binary_operator(left, op, right)
        elif expr_type == 'UNOP':
            op = expr[1]
            operand = self.evaluate_expression(expr[2])
            return self.apply_unary_operator(op, operand)
        elif expr_type == 'FUNCTION':
            func_name = expr[1]
            args = [self.evaluate_expression(arg) for arg in expr[2]]
            return self.call_function(func_name, args)
        else:
            self.error(f"Unknown expression type: {expr_type}")
            return 0
    
    def apply_binary_operator(self, left, op, right):
        """Wendet einen binären Operator an"""
        try:
            if op == '+':
                return left + right
            elif op == '-':
                return left - right
            elif op == '*':
                return left * right
            elif op == '/':
                if right == 0:
                    self.error("Division by zero")
                    return 0
                return left / right
            elif op == '^':
                return left ** right
            elif op == '=':
                return 1 if left == right else 0
            elif op == '<>':
                return 1 if left != right else 0
            elif op == '!=':
                return 1 if left != right else 0
            elif op == '<':
                return 1 if left < right else 0
            elif op == '>':
                return 1 if left > right else 0
            elif op == '<=':
                return 1 if left <= right else 0
            elif op == '>=':
                return 1 if left >= right else 0
            elif op == 'AND':
                return 1 if left and right else 0
            elif op == 'OR':
                return 1 if left or right else 0
            else:
                self.error(f"Unknown binary operator: {op}")
                return 0
        except Exception as e:
            self.error(f"Error in binary operation: {e}")
            return 0
    
    def apply_unary_operator(self, op, operand):
        """Wendet einen unären Operator an"""
        try:
            if op == '+':
                return +operand
            elif op == '-':
                return -operand
            elif op == 'NOT':
                return 1 if not operand else 0
            else:
                self.error(f"Unknown unary operator: {op}")
                return 0
        except Exception as e:
            self.error(f"Error in unary operation: {e}")
            return 0
    
    def call_function(self, func_name, args):
        """Ruft eine eingebaute Funktion auf"""
        if func_name in self.builtin_functions:
            try:
                if args:
                    return self.builtin_functions[func_name](*args)
                else:
                    return self.builtin_functions[func_name]()
            except Exception as e:
                self.error(f"Error calling function {func_name}: {e}")
                return 0
        else:
            self.error(f"Unknown function: {func_name}")
            return 0
    
    def execute_print(self, statement):
        """Führt PRINT-Statement aus"""
        items = statement[1]
        separators = statement[2] if len(statement) > 2 else []
        
        output_parts = []
        for i, item in enumerate(items):
            value = self.evaluate_expression(item)
            output_parts.append(str(value))
            
            # Separator hinzufügen, falls vorhanden
            if i < len(separators):
                sep = separators[i]
                if sep == ';':
                    # Semikolon = keine Leerzeichen
                    pass
                elif sep == ',':
                    # Komma = Tabulator-ähnlich (mehrere Leerzeichen)
                    output_parts.append('    ')
                else:
                    output_parts.append(' ')
            else:
                # Standard-Separator zwischen Elementen
                if i < len(items) - 1:
                    output_parts.append(' ')
        
        print(''.join(output_parts))
    
    def execute_let(self, statement):
        """Führt LET-Statement aus"""
        var_name = statement[1]
        value = self.evaluate_expression(statement[2])
        self.variables[var_name] = value
    
    def execute_input(self, statement):
        """Executes INPUT statement"""
        prompt = statement[1]
        var_name = statement[2]
        
        if prompt:
            user_input = input(prompt + " ")
        else:
            user_input = input("? ")
        
        # Try to parse as number
        try:
            if '.' in user_input:
                value = float(user_input)
            else:
                value = int(user_input)
        except ValueError:
            value = user_input  # Treat as string
        
        self.variables[var_name] = value
    
    def execute_if(self, statement):
        """Führt IF-Statement aus"""
        condition = self.evaluate_expression(statement[1])
        then_stmt = statement[2]
        else_stmt = statement[3] if len(statement) > 3 else None
        
        if condition:
            if then_stmt:
                self.execute_statement(then_stmt)
        else:
            if else_stmt:
                self.execute_statement(else_stmt)
    
    def execute_for(self, statement):
        """Führt FOR-Statement aus"""
        var_name = statement[1]
        start_value = self.evaluate_expression(statement[2])
        end_value = self.evaluate_expression(statement[3])
        step_value = self.evaluate_expression(statement[4])
        
        self.variables[var_name] = start_value
        self.for_stack.append({
            'var': var_name,
            'end': end_value,
            'step': step_value,
            'line': self.current_line
        })
    
    def execute_next(self, statement):
        """Führt NEXT-Statement aus"""
        if not self.for_stack:
            self.error("NEXT without FOR")
            return
        
        for_info = self.for_stack[-1]
        var_name = for_info['var']
        end_value = for_info['end']
        step_value = for_info['step']
        for_line = for_info['line']
        
        # Variable erhöhen
        current_value = self.variables.get(var_name, 0)
        new_value = current_value + step_value
        self.variables[var_name] = new_value
        
        # Prüfen ob Schleife weiterlaufen soll
        if ((step_value > 0 and new_value <= end_value) or 
            (step_value < 0 and new_value >= end_value)):
            # Zurück zur FOR-Zeile
            self.current_line = for_line
        else:
            # Schleife beenden
            self.for_stack.pop()
    
    def execute_while(self, statement):
        """Führt WHILE-Statement aus"""
        condition = self.evaluate_expression(statement[1])
        if not condition:
            # Springe zum entsprechenden WEND
            self.find_matching_wend()
        else:
            self.while_stack.append(self.current_line)
    
    def execute_wend(self, statement):
        """Führt WEND-Statement aus"""
        if not self.while_stack:
            self.error("WEND without WHILE")
            return
        
        while_line = self.while_stack[-1]
        while_stmt, _, _ = self.program[while_line]  # Extract statement, ignore had_line_number and position
        condition = self.evaluate_expression(while_stmt[1])
        
        if condition:
            # Zurück zur WHILE-Zeile
            self.current_line = while_line
        else:
            # Schleife beenden
            self.while_stack.pop()
    
    def find_matching_wend(self):
        """Findet das entsprechende WEND zu einem WHILE"""
        while_count = 1
        current = self.current_line
        
        for line_num in sorted([k for k in self.program.keys() if isinstance(k, int)]):
            if line_num <= current:
                continue
            
            stmt, _, _ = self.program[line_num]  # Extract statement, ignore had_line_number and position
            if stmt[0] == 'WHILE':
                while_count += 1
            elif stmt[0] == 'WEND':
                while_count -= 1
                if while_count == 0:
                    self.current_line = line_num
                    return
        
        self.error("WHILE without matching WEND")
    
    def execute_goto(self, statement):
        """Executes GOTO statement"""
        target_line = statement[1]
        if target_line in self.program:
            self.current_line = target_line
            self.goto_executed = True  # Set flag to prevent automatic line advancement
        else:
            self.error(f"Line {target_line} not found")
    
    def execute_gosub(self, statement):
        """Executes GOSUB statement"""
        target_line = statement[1]
        if target_line in self.program:
            self.call_stack.append(self.current_line)
            self.current_line = target_line
            self.goto_executed = True  # Set flag to prevent automatic line advancement
        else:
            self.error(f"Line {target_line} not found")
    
    def execute_return(self, statement):
        """Führt RETURN-Statement aus"""
        if not self.call_stack:
            self.error("RETURN without GOSUB")
            return
        
        return_line = self.call_stack.pop()
        # Zur nächsten Zeile nach GOSUB gehen
        numeric_keys = [k for k in self.program.keys() if isinstance(k, int) and k > return_line]
        if numeric_keys:
            self.current_line = min(numeric_keys)
        else:
            self.running = False
    
    def execute_cls(self, statement):
        """Führt CLS-Statement aus"""
        if self.graphics.running:
            self.graphics.clear_screen()
        else:
            # Konsole löschen
            os.system('cls' if os.name == 'nt' else 'clear')
    
    def execute_graphics(self, statement):
        """Führt GRAPHICS-Statement aus"""
        mode = statement[1] if len(statement) > 1 else 0
        self.graphics.init_graphics(mode)
    
    def execute_plot(self, statement):
        """Führt PLOT-Statement aus"""
        x = self.evaluate_expression(statement[1])
        y = self.evaluate_expression(statement[2])
        self.graphics.plot_point(x, y)
    
    def execute_line(self, statement):
        """Führt LINE-Statement aus"""
        x1 = self.evaluate_expression(statement[1])
        y1 = self.evaluate_expression(statement[2])
        x2 = self.evaluate_expression(statement[3])
        y2 = self.evaluate_expression(statement[4])
        self.graphics.draw_line(x1, y1, x2, y2)
    
    def execute_circle(self, statement):
        """Führt CIRCLE-Statement aus"""
        x = self.evaluate_expression(statement[1])
        y = self.evaluate_expression(statement[2])
        radius = self.evaluate_expression(statement[3])
        self.graphics.draw_circle(x, y, radius)
    
    def execute_rect(self, statement):
        """Führt RECT-Statement aus"""
        x = self.evaluate_expression(statement[1])
        y = self.evaluate_expression(statement[2])
        width = self.evaluate_expression(statement[3])
        height = self.evaluate_expression(statement[4])
        self.graphics.draw_rect(x, y, width, height)
    
    def execute_color(self, statement):
        """Führt COLOR-Statement aus"""
        color = self.evaluate_expression(statement[1])
        self.graphics.set_color(int(color))
    
    def execute_pset(self, statement):
        """Führt PSET-Statement aus"""
        x = self.evaluate_expression(statement[1])
        y = self.evaluate_expression(statement[2])
        self.graphics.plot_point(x, y)
    
    def list_program(self):
        """Listet das Programm auf"""
        if '__lines__' in self.program:
            # Use the original order from the file
            for line_info in self.program['__lines__']:
                statement = line_info['statement']
                line_number = line_info['line_number']
                had_line_number = line_info['had_line_number']
                
                if had_line_number and line_number is not None:
                    # Show with line number if it originally had one
                    print(f"{line_number} {self.format_statement(statement)}")
                else:
                    # Show without line number if it originally didn't have one
                    print(self.format_statement(statement))
        else:
            # Fallback to old method if __lines__ is not available
            for line_num in sorted([k for k in self.program.keys() if k != '__lines__']):
                statement, had_line_number = self.program[line_num][:2]
                if had_line_number and line_num > 0:
                    print(f"{line_num} {self.format_statement(statement)}")
                else:
                    print(self.format_statement(statement))
    
    def format_statement(self, statement):
        """Formatiert ein Statement für die Ausgabe"""
        if not statement:
            return ""
        
        # Statement ist ein Tupel (z.B. ('PRINT', 'Hallo'))
        if isinstance(statement, tuple) and len(statement) > 0:
            command = statement[0]
            
            if command == 'PRINT':
                # PRINT Statement formatieren
                result = ['PRINT']
                if len(statement) > 1:
                    items = statement[1]
                    separators = statement[2] if len(statement) > 2 else []
                    
                    if isinstance(items, list) and len(items) > 0:
                        formatted_parts = []
                        for i, item in enumerate(items):
                            formatted_parts.append(self.format_expression(item))
                            if i < len(separators):
                                formatted_parts.append(separators[i])
                        
                        result.append(''.join(formatted_parts))
                    else:
                        result.append(self.format_expression(items))
                return ' '.join(result)
            
            elif command == 'LET':
                # LET Statement formatieren
                if len(statement) >= 3:
                    return f"LET {self.format_expression(statement[1])} = {self.format_expression(statement[2])}"
                return ' '.join(map(str, statement))
            
            elif command == 'IF':
                # IF Statement formatieren
                result = ['IF']
                if len(statement) > 1:
                    # Bedingung
                    result.append(self.format_expression(statement[1]))
                    result.append('THEN')
                    # THEN Teil
                    if len(statement) > 2 and statement[2] is not None:
                        then_part = statement[2]
                        if isinstance(then_part, tuple):
                            result.append(self.format_statement(then_part))
                        else:
                            result.append(self.format_expression(then_part))
                    # ELSE Teil
                    if len(statement) > 3 and statement[3] is not None:
                        result.append('ELSE')
                        else_part = statement[3]
                        if isinstance(else_part, tuple):
                            result.append(self.format_statement(else_part))
                        else:
                            result.append(self.format_expression(else_part))
                return ' '.join(result)
            
            elif command == 'FOR':
                # FOR Statement formatieren
                if len(statement) >= 4:
                    result = f"FOR {self.format_expression(statement[1])} = {self.format_expression(statement[2])} TO {self.format_expression(statement[3])}"
                    if len(statement) > 4:
                        result += f" STEP {self.format_expression(statement[4])}"
                    return result
                return ' '.join(map(str, statement))
            
            elif command in ['GOTO', 'GOSUB']:
                # GOTO/GOSUB Statement formatieren
                if len(statement) > 1:
                    return f"{command} {self.format_expression(statement[1])}"
                return command
            
            elif command in ['GRAPHICS', 'CLS', 'END', 'RETURN', 'WEND']:
                # Einfache Befehle
                return command
            
            elif command == 'COMMENT':
                # REM Kommentar formatieren
                if len(statement) > 1:
                    return f"REM {statement[1]}"
                return "REM"
            
            elif command == 'NEXT':
                # NEXT Statement
                if len(statement) > 1:
                    return f"NEXT {self.format_expression(statement[1])}"
                return "NEXT"
            
            else:
                # Allgemeine Formatierung für andere Befehle
                return ' '.join(map(str, statement))
        
        # Fallback für andere Datentypen
        return str(statement)
    
    def format_expression(self, expr):
        """Formatiert einen Ausdruck für die Ausgabe"""
        if isinstance(expr, tuple):
            if len(expr) == 2 and expr[0] in ['STRING', 'NUMBER', 'VARIABLE']:
                # Einfacher Wert
                if expr[0] == 'STRING':
                    return f'"{expr[1]}"'
                else:
                    return str(expr[1])
            elif len(expr) == 4 and expr[0] == 'BINOP':
                # Binärer Operator
                left = self.format_expression(expr[1])
                op = expr[2]
                right = self.format_expression(expr[3])
                return f"({left} {op} {right})"
            else:
                # Andere Tupel-Strukturen
                return str(expr)
        elif isinstance(expr, list):
            # Liste von Ausdrücken
            return ' '.join([self.format_expression(item) for item in expr])
        else:
            # Primitiver Wert
            return str(expr)

def main():
    """Main function of the CrossBasic interpreter"""
    print("CrossBasic Interpreter v1.0")
    print("Cross-platform BASIC interpreter with graphics support")
    print("Type 'help' for help or 'quit' to exit")
    print()
    
    interpreter = BasicInterpreter()
    
    while True:
        try:
            command = input("CrossBasic> ").strip()
            
            if command.lower() in ['quit', 'exit', 'bye']:
                break
            elif command.lower() == 'help':
                print_help()
            elif command.lower() == 'new':
                interpreter = BasicInterpreter()
                print("Program cleared")
            elif command.lower() == 'list':
                interpreter.list_program()
            elif command.lower() == 'run':
                interpreter.run()
            elif command.lower().startswith('load '):
                filename = command[5:].strip()
                try:
                    with open(filename, 'r') as f:
                        program_text = f.read()
                    if interpreter.load_program(program_text):
                        print(f"Program loaded from {filename}")
                    else:
                        print(f"Error loading {filename}")
                except FileNotFoundError:
                    print(f"File {filename} not found")
                except Exception as e:
                    print(f"Error loading file: {e}")
            elif command.lower().startswith('save '):
                filename = command[5:].strip()
                print(f"Save functionality not yet implemented for {filename}")
            else:
                # Execute direct BASIC code
                if interpreter.load_program(command):
                    interpreter.run()
        
        except KeyboardInterrupt:
            print("\nUse 'quit' to exit")
        except Exception as e:
            print(f"Error: {e}")
    
    # Close graphics window
    interpreter.graphics.close()
    print("Goodbye!")

def print_help():
    """Shows help"""
    help_text = """
CrossBasic Interpreter - Commands:

Interpreter Commands:
    help          - Shows this help
    new           - Clears the current program
    list          - Shows the loaded program
    run           - Runs the program
    load <file>   - Loads a program from a file
    save <file>   - Saves the program (not yet implemented)
    quit/exit     - Exits the interpreter

BASIC Commands:
    PRINT <expr>  - Outputs a value
    LET var = expr - Assigns a value to a variable
    INPUT "text", var - Reads user input
    IF condition THEN statement [ELSE statement]
    FOR var = start TO end [STEP step]
    NEXT [var]
    WHILE condition
    WEND
    GOTO line
    GOSUB line
    RETURN
    END
    CLS          - Clears the screen

Graphics Commands:
    GRAPHICS [mode] - Initializes graphics mode
    PLOT x, y       - Draws a point
    LINE x1, y1 TO x2, y2 - Draws a line
    CIRCLE x, y, radius - Draws a circle
    RECT x, y, width, height - Draws a rectangle
    COLOR color     - Sets the drawing color (0-9)
    PSET x, y      - Sets a pixel

Built-in Functions:
    ABS(x), INT(x), SQR(x), SIN(x), COS(x), TAN(x)
    RND([x]), LEN(s), CHR(s), ASC(s)

Example Program:
    10 GRAPHICS
    20 FOR I = 0 TO 360 STEP 10
    30 X = 400 + 100 * COS(I * 3.14159 / 180)
    40 Y = 300 + 100 * SIN(I * 3.14159 / 180)
    50 PLOT X, Y
    60 NEXT I
    70 END
"""
    print(help_text)

if __name__ == "__main__":
    # Install pygame if needed
    try:
        import pygame
    except ImportError:
        print("Pygame is not installed. Install it with: pip install pygame")
        sys.exit(1)
    
    main()
