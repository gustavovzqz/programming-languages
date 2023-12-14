#include <iostream>
using namespace std;

template <typename T, typename U>
struct Dictionary
{

    struct Errr
    {
    };

    struct Node
    {
        U key;
        T value;
        Node *next;
        Node(T val, U k, Node *nxt) : value{val}, key{k}, next{nxt} {};
        ~Node() {}
    };

    Node *dic;

    Dictionary() : dic{nullptr} {};

    ~Dictionary()
    {
        Node *aux;
        while (dic != nullptr)
        {
            aux = dic->next;
            delete dic;
            dic = aux;
        }
    }

    void insert(T val, U k)
    {
        dic = new Node{val, k, dic};
    }

    void remove(U k)
    {

        Node *curr = dic;
        if (curr->key == k)
        {
            dic = curr->next;
            cout << "Deleting! " << curr->value << "\n";

            delete curr;
            cout << "Deleted!\n";
            return;
        }
        else
        {
            while (curr->next != nullptr)
            {
                if (curr->next->key = k)
                {
                    Node *aux = curr->next;
                    curr->next = curr->next->next;
                    cout << "Deleting! " << aux->value << '\n';
                    delete aux;
                    cout << "Deleted!\n";
                    return;
                }
            }
        }
        cout << "Nothing was deleted.\n";
    }

    T findByKey(U k)
    {
        Node *curr = dic;
        while (curr != nullptr)
        {
            if (curr->key == k)
                return curr->value;
            curr = curr->next;
        }
        throw Errr{};
    }
};

int main()
{
    Dictionary<int, string> dic;
    dic.insert(5, "pedro");
    cout << "Chave pedro: " << dic.findByKey("pedro") << '\n';
    dic.insert(2, "carlos");
    cout << "Chave carlos: " << dic.findByKey("carlos") << '\n';
}