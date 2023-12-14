#include <iostream>
using namespace std;

struct lista
{
    double num;
    lista *prox;
};

struct Pilha
{
    lista v;

    void inicializar()
    {
        v = nullptr;
    };

    void finalizar()
    {
        delete v;
    };

    bool vazia()
    {
        return (v == nullptr);
    }

    void empilhar(double x)
    {
        if (v == nullptr)
            *v = {x, nullptr};
        lista *ptr = v;
        *v = {x, ptr};
    }

    double consultar()
    {
        return v->num;
    }

    double desempilhar()
    {
        double n = v->num;
        v = v->prox;
        return n;
    }
};

int main()
{
    Pilha v;
    v.inicializar();
    v.empilhar(2);
    cout << v.consultar() << '\n';
    return 0;
}