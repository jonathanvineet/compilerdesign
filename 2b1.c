#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define SIZE 50

// Structure for each symbol entry
typedef struct SymbolTableEntry {
    char id[50];
    char type[10];
    int scope;
    int value;
    void *address;
    struct SymbolTableEntry *next;
} SymbolTableEntry;

SymbolTableEntry *symbolTable[SIZE];

// Hash function
int hash(char *id) {
    int h = 0;
    while (*id)
        h = (h + *id++) % SIZE;
    return h;
}

// Insert a new symbol
void insert(char *id, char *type, int scope, int value) {
    int index = hash(id);
    SymbolTableEntry *newEntry = (SymbolTableEntry *)malloc(sizeof(SymbolTableEntry));
    strcpy(newEntry->id, id);
    strcpy(newEntry->type, type);
    newEntry->scope = scope;
    newEntry->value = value;
    newEntry->address = (void *)newEntry; // store its memory address
    newEntry->next = symbolTable[index];
    symbolTable[index] = newEntry;
    printf("✅ Inserted '%s' into table.\n", id);
}

// Search for a symbol
SymbolTableEntry *search(char *id) {
    int index = hash(id);
    SymbolTableEntry *entry = symbolTable[index];
    while (entry) {
        if (strcmp(entry->id, id) == 0)
            return entry;
        entry = entry->next;
    }
    return NULL;
}

// Modify a symbol’s value
void modify(char *id, int newValue) {
    SymbolTableEntry *entry = search(id);
    if (entry) {
        entry->value = newValue;
        printf("✏️ Modified '%s' value to %d.\n", id, newValue);
    } else {
        printf("❌ '%s' not found.\n", id);
    }
}

// Delete a symbol
void deleteSymbol(char *id) {
    int index = hash(id);
    SymbolTableEntry *entry = symbolTable[index], *prev = NULL;

    while (entry && strcmp(entry->id, id) != 0) {
        prev = entry;
        entry = entry->next;
    }

    if (!entry) {
        printf("❌ '%s' not found.\n", id);
        return;
    }

    if (prev)
        prev->next = entry->next;
    else
        symbolTable[index] = entry->next;

    free(entry);
    printf("🗑️ Deleted '%s' from table.\n", id);
}

// Display all entries
void display() {
    printf("\n--- SYMBOL TABLE ---\n");
    printf("%-15s %-10s %-10s %-10s %-15s\n", "Identifier", "Type", "Scope", "Value", "Address");
    printf("--------------------------------------------------------------------\n");

    for (int i = 0; i < SIZE; i++) {
        SymbolTableEntry *entry = symbolTable[i];
        while (entry) {
            printf("%-15s %-10s %-10d %-10d %p\n",
                   entry->id, entry->type, entry->scope, entry->value, entry->address);
            entry = entry->next;
        }
    }
    printf("--------------------------------------------------------------------\n");
}

// Process semicolon-separated commands
void processCommands(char *input) {
    char *command = strtok(input, ";");
    while (command) {
        char id[50], type[10];
        int scope, value;

        if (sscanf(command, " insert %s %s %d %d", id, type, &scope, &value) == 4)
            insert(id, type, scope, value);
        else if (sscanf(command, " search %s", id) == 1) {
            SymbolTableEntry *e = search(id);
            if (e)
                printf("✅ Found '%s' (Type=%s, Scope=%d, Value=%d, Address=%p)\n",
                       e->id, e->type, e->scope, e->value, e->address);
            else
                printf("❌ '%s' not found.\n", id);
        }
        else if (sscanf(command, " modify %s %d", id, &value) == 2)
            modify(id, value);
        else if (sscanf(command, " delete %s", id) == 1)
            deleteSymbol(id);
        else if (strstr(command, "display"))
            display();
        else if (strlen(command) > 1)
            printf("⚠️ Unknown command: %s\n", command);

        command = strtok(NULL, ";");
    }
}

int main() {
    for (int i = 0; i < SIZE; i++)
        symbolTable[i] = NULL;

    char input[1000];
    printf("Enter commands (semicolon-separated):\n");
    fgets(input, sizeof(input), stdin);

    processCommands(input);
    return 0;
}