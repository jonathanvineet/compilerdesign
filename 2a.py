# symbol_table.py
# Run: python3 2a.py

# Dictionary to store symbols: {name: [type, scope, value]}
table = {}

def insert(name, typ="int", scope=1, value=0):
    if name in table:
        print(f"{name} already present, updating.")
    table[name] = [typ, scope, value]
    print(f"Inserted {name}.")

def display():
    if not table:
        print("Symbol table empty.")
        return
    print(f"{'Id':<10}{'Type':<8}{'Scope':<6}{'Value':<8}")
    for name, data in table.items():
        print(f"{name:<10}{data[0]:<8}{data[1]:<6}{data[2]:<8}")

# Demo
insert("a")
insert("b")
insert("c", value=10)
display()