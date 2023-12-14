#include <iostream>

// Versão mais elegante no Obsidian.
double somar(double *v, int n)
{
    double aux = 0;

    for (int i = 0; i < n; ++i)
    {
        aux += *v;
        ++v;
    }
    return aux;
}

void inverter(double *v, int n)
{
    double aux;
    int i = 0, j = n - 1;
    while (i < j)
    {
        aux = *(v + i); // aux = 1
        *(v + i) = *(v + j);
        *(v + j) = aux;
        ++i;
        --j;
    }
}

int main()
{

    double v[10] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0};
    double *p = &(v[0]);
    double aux = somar(p, 10);

    std::cout << "Solução da primeira questão: " << aux << '\n';
    std::cout << "Solução da segunda questão: " << '\n';
    for (double *k = &(v[0]); k < &(v[10]); k++)
    {
        std::cout << *k << ' ';
    }
    std::cout << '\n';
    inverter(p, 10);
    for (double *k = &(v[0]); k < &(v[10]); k++)
    {
        std::cout << *k << ' ';
    }
}