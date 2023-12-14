#include <iostream>
#include <memory>
#include <cmath>
#include <ostream>

using namespace std;

// Item (a) : Defina uma struct ponto para representar um ponto no plano cartesiano
struct Ponto
{
    double x, y;
    Ponto(double x, double y) : x{x}, y{y} {}
    Ponto(Ponto &p) : x{p.x}, y{p.y} {}
    friend ostream &operator<<(ostream &saida, Ponto p)
    {
        saida << "(" << p.x << ", " << p.y << ")";
        return saida;
    }
};

// Item (b) : Escreva uma classe abstrata 'Figura' que possua as seguintes funções membros:

class Figura
{
public:
    virtual double area() = 0;
    virtual bool dentro(Ponto p) = 0;
    virtual void mover(double x, double y) = 0;
    virtual void imprimir() = 0;
};

// Item (c) : Escreva uma classe concreta 'Circulo' que implemente a interface acima
class Circulo : public Figura
{
    Ponto center;
    double radius;

public:
    Circulo(double x, double y, double raio) : center{x, y}, radius{raio} {}

    double area()
    {
        return M_PI * pow(radius, 2);
    }

    bool dentro(Ponto p)
    {
        return (sqrt(pow(center.x - p.x, 2) + pow(center.y - p.y, 2)) < radius);
    }

    void mover(double x, double y)
    {
        center.x += x;
        center.y += y;
    }

    Ponto centro()
    {
        return center;
    }

    double raio()
    {
        return radius;
    }

    void imprimir()
    {
        cout << "Circulo de raio " << radius << " e centro " << center << '\n';
    }
};

// Item (c) : Implemente uma classe abstrata "Retângulo".

class Retangulo : public Figura
{
    Ponto sup_esq, sup_dir, inf_esq, inf_dir;

public:
    Retangulo(Ponto p1, Ponto p2, Ponto p3, Ponto p4) : sup_esq{p1}, sup_dir{p2}, inf_esq{p3}, inf_dir{p4} {};
    virtual double base();
    virtual double altura();
    Ponto ponto_sup_esq()
    {
        return sup_esq;
    }
    Ponto ponto_sup_dir()
    {
        return sup_dir;
    }
    Ponto ponto_inf_esq()
    {
        return inf_esq;
    }
    Ponto ponto_inf_dir()
    {
        return inf_dir;
    }
};

int main()
{
    Circulo a{1., 2., 3};
    a.imprimir();
}