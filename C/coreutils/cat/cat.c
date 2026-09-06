#include <stdio.h>

int main (int argc, char *argv[]) {
    // Check if filename is valid
    if (argc < 2) {
        printf("Usage %s <filename>\n", argv[0]);
        return 1;
    }

    // Open the file
    FILE *fp = fopen(argv[1], "r");

    // Checking if file is null
    if (fp == NULL) {
        printf("Error, cannot read file\n");
        return 1;
    }

    // Reading the file
    int ch;
    while ((ch = fgetc(fp)) != EOF) {
        putchar(ch);
    }

    fclose(fp);

    return 0;
}
