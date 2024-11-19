/*
Read a string s1 (which contains only lowercase letters). 
Using an alphabet (defined in the data segment), determine 
and display the string s2 obtained by substitution of each 
letter of the string s1 with the corresponding letter in the 
given alphabet.

Example:
The alphabet:  OPQRSTUVWXYZABCDEFGHIJKLMN
The string s1: anaaremere
The string s2: OBOOFSASFS
*/

#include <stdio.h>
#include <string.h>

void getNewString(char *str);


int main() {
    char str[256];
    printf("Enter INPUT string: ");
    scanf("%s", str);
    getNewString(str);
    printf("Output STRING: %s\n", str);
}