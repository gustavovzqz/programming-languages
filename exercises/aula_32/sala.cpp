#include <iostream>
using namespace std; // Não usar de maneira desregrada.
int main()
{
    int i = 10;

    int &ri = i;

    ri = 5;
    cout << "i: " << i << '\n';
}
