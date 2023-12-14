#include <iostream>
using namespace std;

struct Node
{
    double val;
    Node *prox;
    Node() : val{0}, prox{nullptr} {};
    Node(double num) : val{num}, prox{nullptr} { cout << "Calling node constructor\n"; }
    ~Node() { cout << "Calling node destructor\n"; }
};

struct Queue
{
    Node *first;
    void Enqueue(double num)
    {
        if (!first)
        {
            first = new Node{num};
        }
        else
        {
            Node *aux = first;
            while (aux->prox != nullptr)
                aux = aux->prox;
            // Aux is the last element of the list
            aux->prox = new Node{num};
        }
    };
    void Dequeue()
    {
        if (isNull())
        {
            cout << "Cannot dequeue: The queue is empty!";
            return;
        }

        Node *aux = first;
        first = first->prox;
        delete aux;
    };
    double Peek()
    {
        return first->val;
    };
    bool isNull()
    {
        return (!first);
    };
    Queue() : first{nullptr} {};
    ~Queue()
    {
        cout << "Calling Queue Destructor\n";
        while (first)
        {
            Node *aux = first->prox;
            delete first;
            first = aux;
        }
    };
};

int main()
{
    Queue a{};
    a.Enqueue(1);
    a.Enqueue(2);
    a.Enqueue(3);
    a.Enqueue(4);
    a.Enqueue(5);
    a.Enqueue(6);
    while (!a.isNull())
    {
        cout << a.Peek() << '\n';
        a.Dequeue();
    }
}