#include <exception>
#include <iostream>
#include <memory>

using namespace std;

template <typename T>
class Conjunto
{
    struct Noh
    {
        T val;
        unique_ptr<Noh> prox;
        Noh(T inicial, unique_ptr<Noh> proximo) : val{inicial}, prox{move(proximo)} {}
        ~Noh(){};
    };
    unique_ptr<Noh> first;

public:
    Conjunto() : first{nullptr} {}
    ~Conjunto() {}
    void inserir(T elem)
    {
        /* unique_ptr<Noh> novo{new Noh{elem, move(first)}};
        first = move(novo); */
        first = make_unique<Noh>(elem, move(first));
    }

    bool pertence(T elem)
    {
        Noh *p = first.get();
        while (p != nullptr)
        {
            if (p->val == elem)
                return true;
            p = (p->prox).get();
        }
        return false;
    }

    void remover(T elem)
    {
        Noh *atual = first.get();
        Noh *anterior = nullptr;

        while (atual != nullptr && atual->val != elem)
        {
            anterior = atual;
            atual = (atual->prox).get();
        }

        if (atual == nullptr)
        {
            throw runtime_error("Elemento não encontrado no conjunto");
        }

        // Aqui, temos certeza de que o elemento foi encontrado.

        // Anterior == nullptr -> queremos remover o primeiro
        if (anterior == nullptr)
        {
            unique_ptr<Noh> temp = move(first);
            first = move(temp->prox);
        }
        else
        {
            unique_ptr<Noh> temp = move(anterior->prox);
            // Agora, 'toda' a lista está em temp, o primeiro elemento é o que queremos remover
            anterior->prox = move(temp.get()->prox);
        }
    }
};

int main()
{
    try
    {
        Conjunto<int> c;

        auto percorrer = [&]()
        {
            for (int i = -1; i < 6; ++i)
            {
                cout << i << " pertence?: " << c.pertence(i) << '\n';
            }
        };

        percorrer();

        for (int i = 0; i < 5; ++i)
            c.inserir(i);

        percorrer();

        c.remover(1);
        c.remover(3);
        percorrer();

        c.remover(0);
        c.remover(4);
        percorrer();
        cout << "Rodou até aqui\n";

        c.remover(2);
        cout << "Rodou até aqui\n";
        percorrer();
    }
    catch (const exception &e)
    {
        cerr << "Exceção: " << e.what() << '\n';
        return 1;
    }
}