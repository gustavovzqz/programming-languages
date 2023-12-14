#include <iostream>
#include <new>
using namespace std;
void troca(double *a, double *b)
{
    double aux = *b;
    *b = *a;
    *a = aux;
};

double *particao(double *j, double *k)
{
    double *pivot = j; // 4
    ++j;
    while (j <= k)
    {
        if (*j > *pivot && *k <= *pivot)
            troca(j, k);
        if (*j <= *pivot)
            ++j;
        if (*k > *pivot)
            --k;
    }
    troca(pivot, k);
    return k;
}

void quicksort(double *i, double *j)
{
    if (i >= j)
        return;
    double *k = particao(i, j);
    quicksort(i, k);
    quicksort(k + 1, j);
}

int main()
{
    int tam = 10;
    try
    {
        double *v = new double[tam]{12, 7, 14, 9, 10, 11, 5, 2, 8, 6};
        for (double *k = v; k < (v + tam); ++k)
        {
            cout << *k << " ";
        }
        cout << endl;

        // particao(v, v + tam - 1);
        quicksort(v, v + tam - 1);
        for (double *k = v; k < (v + tam); ++k)
        {
            cout << *k << " ";
        }
        cout << endl;
        delete[] v;
    }
    catch (const bad_alloc &e)
    {
        cerr << "Falha na alocação de memória!\n";
        return 1;
    }
    return 0;
}