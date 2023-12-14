#include <iostream>
#include <new>
using namespace std;

struct Pilha
{
    int tam;
    double *v;
    int n;

    double consultar()
    {
        return v[n - 1];
    }

    double desempilhar()
    {
        return v[--n];
    }
    void empilhar(double x)
    {
        if (n == tam)
        {
            int novo_tam = 2 * tam;
            double *w = new double[novo_tam];
            for (int i = 0; i < n; ++i)
                w[i] = v[i];
            delete[] v;
            v = w;
            tam = novo_tam;
        };

        v[++n] = x;
    }

    void inicializar()
    {
        tam = 1;
        v = new double[tam];
        n = 0;
    }

    void finalizar()
    {
        delete[] v;
    }

    bool vazia()
    {
        return n == 0;
    }
};

int main()
{
    try
    {
        Pilha p;
        p.inicializar();
        p.empilhar(1);
        cout << p.consultar() << '\n';
    }
    catch (const bad_alloc &e)
    {
        cerr << "Falha na alocação\n";
    }
}