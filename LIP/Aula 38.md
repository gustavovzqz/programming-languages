## Um breve resumo

- Atribuição de diferentes referências
```cpp
int i = 10;
int &ri = i; // Se vincula a lvalue
int &r2 = 10 // Erro, não se vincula a rvalue
cont int &r3 = 10 // Se vincula a lvalue e a rvlaue para leitura
int &&r3 = 10 // Se vincula a rvalue mas não a lvalue
```
---

- Funções especiais
```cpp
#include <iostream>
#include <memory>
using namespace std;
struct T
{
	int tam;
	double *v;
	
	// Construtor padrão, não recebe argumentos
	T () : tam{1}, v {new double [tam]}
	{
		cout << "Construtor padrão para " << this << '\n';
	}
	
	// Construtor "comum": recebe argumentos (que não são T)
	T (int tamanho) : tam{tamanho}, v{new double [tam]}
	{
		cout << "Construtor comum para " << this << '\n';
	}
	// Construtor de cópia
	T(const T & origem) : tam{origem.tam}, v {new double [tam]}
	{
		for (int i = 0; i < tam; ++i) v[i] = origem.v[i]
		cout << "Construtor de cópia para " << this << '\n';
	}
	
	// Construtor de movimento: parâmetro de tipo "T &&"
	T (T && origem) : tam {orige.tam}, v{origem.v}
	{
		cout << "Construtor de movimento para " << this << '\n';
		origem.v = nullptr;
	}
	// Destrutor padrão
	~T()
	{
		cout << "Destrutor para " << this << '\n';
		delete[] v;
	}

	// Atribuição de cópia: recebe "const T &"" e retorna "T &".
	T& operator = (const T & origem)
	{
		cout << "Atribuição de cópia para " << this << '\n';
		delete[] v;
		tam = origem.tam;
		v = new double[tam];
		for (int i = 0; i < tam; ++i) v[i] = origem.v[i];
		return *this;
	}

	// Atribuição de movimento: Recebe T && e retorna T&
	T& operator = (T && origem)
	{
		cout << "Atribuição de movimento para " << this << '\n';
		delete[] v;
		tam = origem.tam;
		v = origem.v;
		origem.v = nullptr;
		
		return *this;
	}
}; // struct T

int main()
{
	// Padrão
	T x; 
	// Com tamanho fixo
	T y {2}; 
	// Costrutor por cópia
	T z {y}; 
	
	// Move para transformar o Z em uma rvalue reference e chamar o construtor
	// de cópia
	T z2 {move(z)};

	// Atribuição por cópia
	x = z2;
	
	// Atribuição por movimento
	z = move(x)
}
```

---

- Ponteiros espertos

```cpp
#include <iostream>
#include <memory>
using namespace std;

struct X
{
	int i;
	X (int valor_inicial) : i{valor_inicial}
	{
		cout << "Construtor para i = " << i << '\n';
	}
	~X()
	{
		cout << "Destrutor para i = " << i << '\n';
	}
};

void f(unique_ptr<x> p)
{
	cout << "f executando\n";
}

int main()
{
	unique_PTR<X> up { new X{10}};
	
	unique_PTR<X> p2 = up; // Não comipla (move-only)
	
	unique_PTR<X> p2 = move(up); // Agora compila (vira rvalue)

	f(move(up))
	// O recurso que up tem deixará de ser dele e será parte do argumento da
	// função.
}
```

## Shared Pointer
- Quando um ponteiro esperto é desconstruído, o objeto apontado por ele também é destruído. Mas, é o caso que em alguns momentos um objeto pode ser referenciado por vários ponteiros, e deletar o objeto referenciado por eles pode ser um desastre.
- Nesse caso, mantemos um contador de referências, apagando o objeto somente quando não é mais apontado por ninguém.
- O `uniqueptr` só tem espaço de um ponteiro, enquanto `shared_ptr` não é tão eficiente.
```cpp
#include <iostream>
#include <memory>
using namespace std;

// Assuma o tipo X como o declarado anteriormente
int main()
{

	{
		shared_ptr<X> p1 {new X{10}};
		{
			shared_ptr<X> p2 { p1 };
			{
				shared_ptr<X> p3 = p2;
			}
		}
	}
	
}
```

- O código acima está uma bagunça, mas dá pra entender o que acontece intuitivamente :D.

## Atenção! 

- Quando trabalhamos com ponteiros espertos, precisamos tomar cuidado que o objeto apontado não seja deletado de forma não esperada, já que isso pode causar erros.
```cpp
#include <iostream>
#include <memory
using namespace std;

int main()
{
	int i = 10;
	
	unique_ptr<int> up {&i}; // Não! Vai tentar desalocar variável automática!
	
	int *pi = new int{20};
	unique_ptr<int> p1 {pi};
	unique_ptr<int> p2 {pi}; // Não! Double free!
	
	int *pd = new double {0.1};
	
	shared_ptr<double> pd1 {pd};
	shared_ptr<double> pd2 {pd}; // Não ! double free
	
	// O correto é fazer o seguinte:
	shared_ptr<double> pd2 {pd1}; // Ok
}
```

## Para além da memória

- O `unique_ptr`  e o `shared_ptr` aceita como argumento o que é para ele fazer na desconstrução! Isso nos dá a possibilidade de gerir recursos de forma esperta, fechando banco de dados, fechando arquivos, destravando travas concorrentes...

```cpp
#include <iostream>
#include <memory>

using namespace std;

struct MeuFinalizador
{
	// Precisa do operador abaixo
	void operator () (int *p) // Precisa recebe como argumento um ponteiro para 
							  // o que eu estou apontando em unique_ptr
	{
		cout << "Estou finalizando o recurso " 
		<< "e poderia fazer outras coisas" << '\n';
	}
}

int main()
{
	unique_ptr<int,MeuFinalizador> up {new int {10}};
}
```