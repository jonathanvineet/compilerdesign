# optimizer.py
# Run: python3 optimizer.py

import re

def constant_folding(expr):
    def repl(m):
        try:
            return str(eval(m.group(0)))
        except:
            return m.group(0)
    prev = None
    while expr != prev:
        prev = expr
        expr = re.sub(r'\b\d+([*/+-]\d+)+\b', repl, expr)
    return expr

def strength_reduction(expr):
    m = re.match(r'(\w+)\s*=\s*(\w+)\s*\*\s*(\d+)', expr)
    if m:
        dst, var, n = m.group(1), m.group(2), int(m.group(3))
        return f"{dst} = " + " + ".join([var]*n)
    return expr

def copy_propagation(expr, assignments):
    for k,v in assignments.items():
        expr = re.sub(r'\b'+re.escape(k)+r'\b', f'({v})', expr)
    return expr

def demo():
    print("Const folding:", constant_folding("k = z + 15 + 5"))
    print("Strength reduction:", strength_reduction("p = q * 3"))
    print("Copy propagation:", copy_propagation("x = a + b", {"a":"5","b":"c"}))

if __name__ == "__main__":
    demo()
