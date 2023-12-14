#include <iostream>
#include <string>
using namespace std;

class Comum
{
public:
    char c;

public:
    Comum(char vc) : c{vc} {}
    virtual ~Comum()
    {
        cout << "Destrutor de C com c = " << c << '\n';
    }
};

class B1 : public Comum
{
    int i;

public:
    virtual void fvb1() = 0;
    B1(int v1) : Comum{'!'}, i{v1} {};
    virtual ~B1()
    {
        cout << "Destrutor de B1 com i = " << i << '\n';
    }
};

class B2 : public Comum
{
    double d;

public:
    virtual void fvb2() = 0;
    B2(double d1) : Comum{'@'}, d{d1} {};
    virtual ~B2()
    {
        cout << "Destrutor de B2 com d = " << d << '\n';
    }
};

class D : public B1, public B2
{
    string s;

public:
    D(string vs) : B1{10}, B2{0.1}, s{vs} {};

    void fvb1() override
    {
        cout << "fvb1 em D\n";
    }

    void fvb2() override
    {
        cout << "fvb2 em D\n";
    }

    ~D() override
    {
        cout << "Destrutor de D com s = " << s << '\n';
        cout << "B1::c: " << B1::c << "B2::c: " << B2::c << '\n';
    } // Padrão
};

int main()
{
    B1 *pb1 = new D{"primeiro"};
    pb1->fvb1();

    B2 *pb2 = new D{"segundo"};
    pb2->fvb2();

    D d{"terceiro"};
    d.fvb1();
    d.fvb2();
    cout << "\n\n\n";
    cout << "imprimindo o caba: " << pb1->c << '\n';
    delete pb2;
    delete pb1;
}