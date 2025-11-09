# lexer_simple.py
# Run: python3 lexer_simple.py input.c

import sys
import re

token_spec = [
    ("KEYWORD", r'\b(if|else|while|for|return|int|float|char|void|printf|struct|main)\b'),
    ("IDENT",   r'[A-Za-z_][A-Za-z0-9_]*'),
    ("INT",     r'\b\d+\b'),
    ("OP",      r'[+\-*/=%{}();,<>]'),
    ("STRING",  r'"[^"]*"'),
    ("SKIP",    r'[ \t]+'),
    ("NEWL",    r'\n'),
    ("MISMATCH",r'.'),
]
tok_regex = '|'.join(f'(?P<{name}>{pat})' for name,pat in token_spec)

def lex(text):
    for mo in re.finditer(tok_regex, text):
        kind = mo.lastgroup
        value = mo.group()
        if kind=="SKIP" or kind=="NEWL": continue
        if kind=="MISMATCH":
            print("Unknown:", value)
        else:
            print(f"{value}\t=> {kind}")

if __name__=="__main__":
    if len(sys.argv) < 2:
        print("Enter C code (empty line to exit):")
        while True:
            try:
                line = input()
                if line.strip() == "":
                    break
                lex(line)
            except EOFError:
                break
    else:
        with open(sys.argv[1]) as f:
            text = f.read()
        lex(text)
