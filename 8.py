import re

def constant_folding(expr):
    # Find and evaluate constant expressions like 2+3, 5*4, etc.
    while True:
        new_expr = expr
        # Match patterns like: number operator number
        match = re.search(r'(\d+)\s*([+\-*/])\s*(\d+)', expr)
        if match:
            num1 = int(match.group(1))
            op = match.group(2)
            num2 = int(match.group(3))
            
            # Calculate result
            if op == '+':
                result = num1 + num2
            elif op == '-':
                result = num1 - num2
            elif op == '*':
                result = num1 * num2
            elif op == '/':
                result = num1 // num2
            
            # Replace the expression with result
            expr = expr.replace(match.group(0), str(result), 1)        
        # If no change, we're done
        if expr == new_expr:
            break
    
    return expr

# Test
print("Enter expression:")
line = input()
print("Optimized:", constant_folding(line))