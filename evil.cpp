#include <iostream>
#include <stdio.h>
#include <string>

using namespace std;

//Global variables
string command = "", filename;

//Evil constants
const string BLOCK_BEGIN = "=>";
const char ID_IDENTIFIER = '.';
const char CLASS_IDENTIFIER = '#';

void getSource();
void parseSource();
void generateCSS();

int main(){
    getSource();
    parseSource();
    generateCSS();

    while(command != "end"){
        printf("evil -$: ");
        cin >> command;
    }

    return 0;
}

void getSource(){}
void parseSource(){}
void generateCSS(){}