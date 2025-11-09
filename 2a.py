# symbol_table.py
# Run: python3 symbol_table.py

class Symbol:
    def __init__(self, identifier, typ, scope, value=0):
        self.id = identifier
        self.type = typ
        self.scope = scope
        self.value = value

class SymbolTable:
    def __init__(self):
        self.table = {}  # key -> Symbol

    def insert(self, identifier, typ="int", scope=1, value=0):
        if identifier in self.table:
            print(f"{identifier} already present, updating.")
        self.table[identifier] = Symbol(identifier, typ, scope, value)
        print(f"Inserted {identifier}.")

    def search(self, identifier):
        return self.table.get(identifier)

    def modify(self, identifier, value):
        s = self.search(identifier)
        if s:
            s.value = value
            print(f"Modified {identifier} -> {value}")
        else:
            print(f"{identifier} not found.")

    def delete(self, identifier):
        if identifier in self.table:
            del self.table[identifier]
            print(f"Deleted {identifier}.")
        else:
            print(f"{identifier} not found.")

    def display(self):
        if not self.table:
            print("Symbol table empty.")
            return
        print(f"{'Id':<10}{'Type':<8}{'Scope':<6}{'Value':<8}")
        for s in self.table.values():
            print(f"{s.id:<10}{s.type:<8}{s.scope:<6}{s.value:<8}")

def demo():
    st = SymbolTable()
    st.insert("a"); st.insert("b")
    st.insert("c", value=10); st.display()
    st.modify("a", 20); print("Search a:", vars(st.search("a")))
    st.delete("b"); st.display()

if __name__ == "__main__":
    demo()
