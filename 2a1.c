#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

// Function to check if a character is an operator
int is_operator(char c) {
    char operators[] = {'+', '-', '*', '%', '/', '{', '}', '='};
    for (int i = 0; i < 8; i++) {
        if (c == operators[i])
            return 1;
    }
    return 0;
}

// Function to check whether a string is a keyword, variable, or constant
void check_token(char *str) {
    char keywords[][10] = {"if", "else", "while", "do", "for", "struct", "main", "void", "printf"};
    int isKeyword = 0;

    for (int j = 0; j < 9; j++) {
        if (strcmp(str, keywords[j]) == 0) {
            printf("%s is a keyword\n", str);
            isKeyword = 1;
            break;
        }
    }

    if (!isKeyword) {
        int isConstant = 1;
        for (int k = 0; str[k] != '\0'; k++) {
            if (!isdigit(str[k])) {
                isConstant = 0;
                break;
            }
        }

        if (isConstant)
            printf("%s is a constant\n", str);
        else
            printf("%s is a variable\n", str);
    }
}

int main() {
    FILE *f;
    char str[50];
    int c, i = 0;

    f = fopen("input.c", "r");
    if (f == NULL) {
        printf("❌ File not found!\n");
        return 1;
    } else {
        printf("✅ File read successfully.\n\n");
    }

    while ((c = fgetc(f)) != EOF) {
        if (!isspace(c) && !is_operator(c) && c != ';' && c != '(' && c != ')' && c != ',') {
            str[i++] = c;
        } else {
            if (i > 0) {
                str[i] = '\0';
                check_token(str);
                i = 0;
            }

            if (is_operator(c))
                printf("%c is an operator\n", c);
        }
    }

    fclose(f);
    return 0;
}