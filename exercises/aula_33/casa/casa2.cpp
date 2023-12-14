#include <new>
#include <iostream>
using namespace std;

int main()
{
    double k;
    int tam = 1;
    double *aux;
    double *v = new double[1];
    int n = 0;
    try
    {
        while (true)
        {
            cout << "Insira um número: ";
            cin >> k;
            if (k == -1)
                break;
            if (n == tam)
            {
                tam *= 2; // atualiza o tamanho antes da realocação
                aux = new double[tam]{};
                for (double *p = v, *p_aux = aux; p < v + n; ++p, ++p_aux)
                {
                    *p_aux = *p; // copia os elementos de v para aux
                }
                delete[] v;
                v = aux;
            }
            *(v + n) = k;
            ++n;

            for (double *p = v, *fim = v + tam; p < fim; ++p)
            {
                cout << *p << ' ';
            }
            cout << '\n';
        }
    }
    catch (const bad_alloc &e)
    {
        cerr << "Falha na alocação de memória!\n";
        return 1;
    }
    delete[] v;
    return 0;
}
