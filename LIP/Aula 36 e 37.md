#### Ponteiro Esperto
- Esse tipo criado garante que a desalocação de algum objeto ocorra.
```cpp
#include <iostream>
using namespace std;

struct PE
{
	int *pi;

	PE_int (int *ponteiro) : pi{ponteiro} { }

	~PE_int() 
	{
	cout << "Vai desalocar " << pi << '\n';
	delete pi;
	}
}

int main ()
{
	PE pe { new int };
	int &i = *(pe.pi);
	int i = 5;
	cout << "i: " << i << '\n';
}
```

- Podemos observar que, da forma acima, cada vez que fossemos trabalhar com um tipo diferente, precisaríamos de uma estrutura gerenciadora para esse tipo. 

##### Bagagem para polimorfismo 

- Um exemplo para funções
```cpp
template <typename T>
double soma (T *v, int n)
{
	T s{};
	for (int i = 0; i < n; ++i)
		s += v[i]
	return s;
}

int main ()
{
	int vi[3] = {10, 20, 30};
	int vl[3] = {0.1, 0.2, 0.3};
	double a = /* <int> */soma(vi, 3);
	double b =  /* double */soma(vl, 3)
}
```

- Um exemplo para tipos
```cpp
#include <iostream>
#include <string>
using namespace std;

template<typename T, typename U>
struct Par
{
	T x;
	U y;
};

int main ()
{
	Par <int, string> p {10, string{"Olá"}};
	cout << "p.x: " << p.x << '\n';
	cout << "p.y: " << p.y << '\n';
}
```

#### Ponteiro Esperto Genérico
```cpp
#include <iostream>
using namespace std;

template <typename T>
struct PE
{
	T *p;

	PE(T *ponteiro) : p{ponteiro} { }

	~PE() 
	{
	cout << "Vai desalocar " << p << '\n';
	delete p;
	}
}

int main ()
{
	PE pe { new int };
	int &i = *(pe.p);
	int i = 5;
	cout << "i: " << i << '\n';
}
```

#### Transferência de "posse"
- Em alguns contextos, podemos querer declarar um ponteiro esperto, mas só fazer ele ser 'destruído' em outra função.
- Passar a posse de p1 para p2 significa que p1 apontará para nulo, e p2 apontará para onde p1 apontava.

```cpp
#include <iostream>
using namespace std;

template <typename T>
struct PE
{
	T *p;

	PE () : p {nullptr} {};
	PE (T *ponteiro) : p{ponteiro} { }

	void operator = (PE<T> &outro)
	{
		// Isso está errado... mais detalhes lá em baixo!
		p = outro.p;
		outro.p = nullptr;
	}

	~PE() 
	{
	cout << "Vai desalocar " << p << '\n';
	delete p;
	}
}

int main()
{
	PE p1 { new int };

	PE<int> p2;
	p2 = p1;

	cout << "Inteiro com p1: " << p1.p << '\n';
	cout << "Inteiro com p2: " << p2.p << '\n';
}
```

- O caso acima não é realmente útil. Vamos para um exemplo onde possamos querer aplicar essa técnica.  Mas antes disso, vamos examinar `rvalue references`

#### `rvalue references`

- Em C++, uma expressão/valor tem um **tipo** e uma **categoria**.

```cpp
#include <iostream>
using namespace std;

int main ()
{
	int i = 0;
	int &ri = i; // Isso pode!;
	int &ri = 10; // Isso não pode! 10 é um rvalue
}
```

- `rvalues` tipicamente não podem ser modificados, por isso não faz sentido declarar uma referência para um valor dessa categoria.
- Às vezes queremos usar a referência para  um `rvalue`, sabendo que não vamos alterar.

```cpp
struct T
{
	int i;
};
T operator + (T a, T b)
{
	return T {a.i + b.i};
}
```

- Por padrão, quando recebemos algo por argumento, é feita uma cópia. Em alguns casos, a cópia pode ser muito custosa! Nesse sentido, vale a pena passar uma referência em vez do próprio objeto.
```cpp
T operator + (T &a, T &b)
{
	return T {a.i + b.i};
}
```

- O problema é que, da forma como estamos fazendo acima (`&a`), a só pode ser um `lvalue`,  já que uma referência só existe para valores que podem ser alterados.
- A maneira para resolver isso, é fazer uma referência para `const`, podendo assim, fazer uma referência para um `lvalue`.

```cpp
T operator + (const T &a, const T &b)
{
	return T {a.i + b.i};
}
```

- Uma coisa importante:

```cpp
int i = 10; 
const int &ri = 10;
```
- As duas expressões acima são diferentes! O 10 da primeira expressão será desaparecido, e só foi utilizado para inicializar **i**. Na segunda expressão, como se trata de uma referência, o 10 será mantido na memória até que a referência seja destruída.

```cpp
struct MeuVet
{
	int tam;
	double *v;
	
	MeuVet (const MeuVet &outro) : tam{outro.tam}, v{new double [outro.tam]}
	{
		for (int i =0; i < tam; ++i)
			v[i] = outro.v[i];
	}
	
	MeuVet (int tamanho) : tam{tamanho}, v{new double [tam]}
	
	~MeuVet() {delete[] v;}
};

struct Erro {};

MeuVet operator + (const MeuVet &a, const MeuVet&b)
{
	if (a.tam != b.tam) throw Erro{}
	
	MeuVet c {a.tam};
	
	for (int i = 0; i < a.tam; ++i)
	{
		c.v[i] = a.v[i] + b.v[i];
	}
	return c;
}

int main()
{
	MeuVet v{10}, w{10};
	
	MeuVet soma{v + w};
}
```
- O problema do que está escrito acima é: ineficiência! Quando fazemos isso, somamos v com o w, criando o vetor soma (**s**). Depois disso, o vetor s é **copiado** para a variável que desejamos.

- Para soluciona o problema, chegamos em `rvalues references`.

```cpp
int main()
{
	int &&ri = 5; // rvalue reference, não precisamos do const já que ele pode 
				  // sim ser alterado!
}
```

#### Voltando para nossos camaradas espertos
- Com a bagagem de `rvalue references`, agora podemos fazer construtores que recebem outros ponteiros espertos diretamente.

```cpp
#include <iostream>
using namespace std;

template <typename T>
struct PE
{
	T *p;

	PE () : p {nullptr} {};
	PE (T *ponteiro) : p{ponteiro} { }
	
	// Linhas adicionadas em relação ao programa anterior
	PE (PE<T> &outro) : p {outro.p} // Usado quando recebemos um lvalue
	{
		outro.p = nullptr;
	}
	
	PE (PE<T> &&outro) : p {outro.p} // Usandos quando recebemos um rvalue
	{
		outro.p = nullptr;
	}
	PE<T>& operator = (PE<T> &outro)
	{
		if (this != outro)
		{
			delete p;
			p = outro.p;
			outro.p = nullptr;
		}
		return *this;
	}
	// Fim das linhas alteradas ...
	
	~PE() 
	{
	cout << "Vai desalocar " << p << '\n';
	delete p;
	}
}

int main()
{
	PE p1 { new int };

	PE<int> p2; 
	p2 = p1;
	
	cout << "Inteiro com p1: " << p1.p << '\n';
	cout << "Inteiro com p2: " << p2.p << '\n';
}
```

- Adicionamos os construtores que recebem outros ponteiros, usando `rvalues referenes`
- Alteramos o operador de igualdade, já que antes nós não deletávamos o que era apontado por **p** antes (ficava perdido).
- Com a segunda mudança, precisamos checar se o operador não está sendo usada no contexto `p = p`, o que seria problemático por que **p** seria desalocado.

--- 
#### Tudo já estava pronto.
- Depois de mostrar como se faz, o que vimos antes está na biblioteca padrão. é o `unique_ptr` incluído em `memory` na biblioteca padrão.
```cpp
#include <iostream>
#include <memory>
using namespace std
struct T
{
	int i;
	
	T(int inicial) : i {inicial} {}
	~T() {}
}
int main ()
{
	unique_ptr<T> p1 { new T {10} };
	
	unique_ptr<T> p2 { move(p1) };
}
```

- Note que no nosso ponteiro esperto, podemos usar `p1 = p2`. No caso acima, não conseguimos, o objeto não deixa. Para conseguir, precisamos explicitar que queremos isso, então, usamos move(p) para mudar sua categoria (só há construtor para `rvalue reference`)