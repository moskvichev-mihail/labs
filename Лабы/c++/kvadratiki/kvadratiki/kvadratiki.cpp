// kvadratiki.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <numeric>
#include <algorithm>
#include <fstream>

using namespace std;

int main()
{
	int num1, num2;
	ifstream inputFile("input.txt");
	ofstream outputFile("output.txt");
	inputFile >> num1 >> num2;
	outputFile << num1 << " " << num2 << endl;
	return 0;
}
