#include <iostream>
using namespace std;

template <typename T>

struct PE
{
    T *p;
    bool isVector;

    PE() : p{nullptr}, isVector{false} {};

    PE(T *pointer, bool vec) : p{pointer}, isVector{vec} {}

    // Como a cópia não faz sentido, tem o mesmo sentido que o de movimento
    PE(PE<T> &outro) : p{outro.p}, isVector{outro.isVector}
    {
        outro.p = nullptr;
    }

    PE(PE<T> &&outro) : p{outro.p}, isVector{outro.isVector}
    {
        outro.p = nullptr;
    }

    PE<T> &operator=(PE<T> &outro)
    {
        if (this != &outro) // Evitar caso *this = *this
        {
            if (isVector)
                delete[] p;
            else
                delete p;
            p = outro.p;
            isVector = outro.isVector;
            outro.p = nullptr;
        }
        return *this;
    }

    ~PE()
    {

        if (isVector)
        {
            cout << "Desalocando vetor!" << this << '\n';
            delete[] p;
        }
        else
        {
            cout << "Desalocando não-vetor!" << this << '\n';
            delete p;
        }
    }
};

int main()
{

    int *v = new int[3]{1, 2, 3};
    PE<int> p1 = {new int, false};
    PE<int> p2 = {v, true};
    p2 = p1;
}