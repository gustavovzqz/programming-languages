### Construtores e Destrutores
- Pode ser trabalhoso para o desenvolvedor liberar o espaço, manualmente, de uma estrutura definida.
```cpp
#include <iostream>
using namespace std;
int main()
{
	cout << "n: "; int n; cin >> n;
	double *v = new double [n];

	// usar "v"
	
	delete[] v;
}
```
- No caso acima, se uma exceção for lançada durante o uso de "v", a liberação da memória não ocorreria. Em diversos outros exemplos pode acontecer, como não liberando travas em programas concorrentes.

```cpp
#include <iostream>
using namespace std;
struct MeuTipo
{
	int tam;
	double *v;

	MeuTipo()
	{
		cout << "Construtor Padrão executando!\n";
		tam = 1;
		v = new double [tam]
	};

	MeuTipo(int tamanho)
	{
		cout << "Construtor Não-Padrão Executando!\n";
		tam = tamanho;
		v = new double [tam];
	}

	~MeuTipo()
	{
		cout << "Destrutor executando!\n";
		delete [] v;
	};
};

struct MeuErro {};

void f ()
	{
		MeuTipo a;
		throw MeuErro{}
	}
int main ()
{
	MeuTipo var;
	{
		MeuTipo var_interna {10};
	}

	MeuTipo *vet = new MeuTipo [2];
	cout << "Alocou...\n";
	delete[] vet;
	cout << "Fim de main\n";

	try
	{
		f();
	}
	catch (const MeuErro &e)
	{
		Cout << "Atenção: MeuErro detectado!\n";
	}
}
```


- Note que, no exemplo abaixo, os construtores de A e B são chamados primeiros que C, então o código não funciona, já que num não é visível.

```cpp
#include <iostream>

using namespace std;
struct A
{
	A(int a) { cout << a << "Cons A!\n"; }
};
struct B
{
	B(int a) { cout << a << "Cons B!\n"; }
};
struct C
{
	int num;
	A a{num};
	B b{num};
	C(int numero)
	{
		cout << "Cons C!\n";
		num = numero;
	};
};

  

int main()
{
	C c{2};
};
```

Para contornar o problema, no caso em que queremos inicializar os membros com valores específicos,  podemos passar uma lista de inicialização:
```cpp
	C(const C &outro) : tam {outro.tam}, v {new int[tam]}
	// Os membros internos serão inicializados com os argumentos respectivos
	
```

Construtor com cópia:

```cpp
struct C 
{
	int tam;
	int *v;
	C(int t) : tam{t}, v {new int [tam]}
	{
		for (int i = 0; i < tam; ++i) v[i] = i;
	}
	~C() 
	{
	cout << "Deletando...\n";
	delete[] v;
	}
};

int f (C param)
	{
		cout << "Executando f...\n";
	}

int main ()
	C c {3};
	f(c);
```

- O problema do código acima, é que ao chamar a função C, o construtor de cópia padrão é chamado. O construtor padrão apenas copia membro a membro.
- Logo depois, ele chama o destrutor, o destrutor dentro da função deleta o V! Que é o mesmo V do externo, já que ele só copiou o ponteiro! Precisamos criar um construtor de cópia que realmente copie!
```cpp
struct C 
{
	int tam;
	int *v;
	C(int t) : tam{t}, v {new int [tam]}
	{
		for (int i = 0; i < tam; ++i) v[i] = i;
	}
	~C() 
	{
	cout << "Deletando...\n";
	delete[] v;
	}
	C(const C &outro) : tam {outro.tam}, v {new int[tam] }
	{
		cout << "Construtor de cópia!\n";
		for (int i = 0; i < tam; ++i)
		{
			v[i] = outro.v[i];
		}
	}

};