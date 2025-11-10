# tac_to_asm.py
# Run: python3 7..py
print("Enter intermediate code (format: a=b+c), press Enter to end:")
while True:
    line = input().strip()
    if line == "":
        break
    
    lhs, rhs = line.split('=')
    
    # Replace operators with spaces to split
    for op in ['+', '-', '*', '/']:
        rhs = rhs.replace(op, f' {op} ')
    
    parts = rhs.split()
    
    opr_map = {'+': "ADD", '-': "SUB", '*': "MUL", '/': "DIV"}
    
    print(f"MOV R0,{parts[0]}")
    
    for i in range(1, len(parts), 2):
        op = parts[i]
        operand = parts[i+1]
        print(f"{opr_map[op]} R0,{operand}")
    
    print(f"MOV {lhs},R0")
