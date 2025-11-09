# tac_to_asm.py
# Run: python3 7..py
print("Enter intermediate code (format: a=b+c), press Enter to end:")
icode = []
while True:
    line = input().strip()
    if line == "":
        break
    icode.append(line)

for i, code in enumerate(icode):
    opr = {'+':"ADD", '-':"SUB", '*':"MUL", '/':"DIV"}[code[3]]
    print(f"MOV R{i},{code[2]}")
    print(f"{opr} R{i},{code[4]}")
    print(f"MOV {code[0]},R{i}")
