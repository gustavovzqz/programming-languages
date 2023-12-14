#include <memory>
#include <iostream>
#include <cassert>
using namespace std;

/*
    Eu imagino que um exercício bom para a prova testaria nossas habilidades em:
    1) Tratar de ponteiros
    2) Gerenciar memória por meio de Construtores/Destrutores
    3) Habilidades com Classes

    Dessa forma, vejo como um bom problema:
    'Implemente uma Classe/Struct 'ListaEncadeada' que contenha as seguintes operações:
        1 ) push_back()
        2 ) pop()
        3 ) encontrar()
        ... )
    Usando unique_ptr!

    Seria uma questão parecida com a passada para casa, onde implementamos o conjunto, porém,
    a lista será genérica, e usaremos e implementaremos alguma classe usando ela (herança)"

*/
template <typename T>
class LinkedList
{
    struct Node
    {
        T data;
        unique_ptr<Node> next;
        Node(const T &value, unique_ptr<Node> proximo) : data{value}, next{move(proximo)} {}
    };

    unique_ptr<Node> first;
    Node *last;

public:
    LinkedList() : first{nullptr}, last{nullptr} {}
    ~LinkedList() {}

    void enqueue(T value)
    {
        if (empty())
        {
            unique_ptr<Node> newPtr{new Node{value, nullptr}};
            first = move(newPtr);
            last = first.get();
        }
        else
        {
            unique_ptr<Node> newPtr{new Node{value, nullptr}};
            last->next = move(newPtr);
            last = last->next.get();
        }
    }

    bool empty()
    {
        return (!first);
    }

    void dequeue()
    {
        if (empty())
            throw runtime_error("Erro! Desenfilando lista vazia.");
        // else
        
        unique_ptr<Node> newNode = move(first);
        first = move(newNode->next);
    }

    T peek()
    {
        return first->data;
    }
};

// Função de teste básica
void testLinkedList()
{
    LinkedList<int> lista;

    // Teste 1: Verificar se a lista está vazia inicialmente
    assert(lista.empty());
    // Teste 2: Adicionar elementos à lista e verificar a propriedade "empty"
    lista.enqueue(1);
    lista.enqueue(2);

    assert(!lista.empty());

    // Teste 3: Verificar se a função "peek" retorna o elemento correto
    assert(lista.peek() == 1);

    // Teste 4: Desenfileirar um elemento e verificar a propriedade "empty"
    lista.dequeue();
    assert(!lista.empty());

    // Teste 5: Verificar se a função "peek" retorna o próximo elemento correto
    assert(lista.peek() == 2);

    // Teste 6: Desenfileirar o último elemento e verificar a propriedade "empty"
    lista.dequeue();
    assert(lista.empty());
}

int main()
{
    testLinkedList();

    cout << "Todos os testes passaram com sucesso!" << endl;

    return 0;
}

