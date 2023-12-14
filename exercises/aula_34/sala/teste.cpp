#include <iostream>
using namespace std;

struct Contador
{
    int c;
    Contador operator()(int a)
    {
        Contador k;
        k.c = a;
        return k;
    }
};
int main()
{
    Contador c = c(2);
    cout << c.c << '\n';
}
