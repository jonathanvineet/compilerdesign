import sys
import re

# Define token patterns
patterns = [
    (r'\b(if|else|while|for|return|int|float|char|void|printf|struct|main)\b', "KEYWORD"),
    (r'[A-Za-z_][A-Za-z0-9_]*', "IDENT"),
    (r'\d+', "INT"),
    (r'[+\-*/=%{}();,<>]', "OP"),
    (r'"[^"]*"', "STRING"),
    (r'[ \t]+', None),  # Skip whitespace
    (r'\n', None),       # Skip newlines
]

def lex(text):
    pos = 0
    while pos < len(text):
        matched = False
        for pattern, token_type in patterns:
            match = re.match(pattern, text[pos:])
            if match:
                value = match.group(0)
                print(value + "\t=> " + token_type)
                pos += len(value)
                matched = True
                break
        if not matched:
            print("Unknown: " + text[pos])
            pos += 1

print("Enter C code (empty line to exit):")
while True:
    line = input()
    if line == "":
        break
    lex(line)