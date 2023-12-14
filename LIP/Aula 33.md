### Durações de Armazenamento
- Em C++, existem 4 durações de armazenamento:

1. Automática: é a duração padrão para as variáveis locais, declaradas dentro de blocos. O objeto dura na memória até o fluxo da execução sair do bloco (mais interno) onde a variável foi declarada.
2. Estática: é a duração padrão para as variáveis declaradas fora de qualquer bloco. A variável existe durante toda a duração do programa.
3. Dinâmica: é a duração dos objetos alocados manualmente pelo programa, via "malloc", "new", etc. Dura do momento da alocação manual ao momento da desalocação manual.
4. Thread (não usaremos): é análoga à estática, mas para variáveis declaradas via "thread_local".

### Alocação Dinâmica

```cpp
#include <new>
#include <iostream>
using namespace std;
int main ()
{   // malloc ?
try
	{
	int *p = new(/*std::nothrow*/) int {100};
	cout << "*p: " << *p << '\n';
	*p = 10;
	cout << "*p: " << *p << '\n';
	delete p;
	}
	catch (const bad_alloc &e)
	{
	cerr<<"Falha de alocação de memória!\n";
	return 1;
	}
}
```

- Em C++, contrastando com o C, não usamos o malloc, apesar de existir. De forma simples, o new funciona melhor com classes, chamando o construtor na inicialização.
- Usamos o delete em vez de free
- O operador new retorna uma exceção no caso em que ocorre um erro. Para citar o erro, precisamos incluir a biblioteca new, apesar de não precisar dela para utilizar o new.
- O argumento opcional da biblioteca padrão `std::nothrow` faz que, em vez de retornar um erro, retorna um ponteiro para nulo (semelhante ao C)

### Alocando Vetores

```cpp
int main()
{
	try
		{
		int tam = 7;
		double *v = new double[tam] {-1, -2, -3};
		
		for (int i = 0; i < tam; ++i) v[i] = cout << v[i] << '\n';
		
		for (int i = 0; i < tam; ++i) v[i] = 1/10.0;
		
		for (int i = 0; i < tam; ++i) v[i] = cout << v[i] << '\n';
		
		delete[] v;
		}
	catch (const bad_alloc &e)
		{
		 ceer<< "Falha de alocação na memória!\n";
		 return 1;
		}
}
```

- Para declarar um vetor, usamos `new tipo [tam];`
- Para deletar, usamos `delete[] v`
- Se não inicializarmos um vetor {...}, o vetor não será inicializado.
- Se inicializarmos com algo, {1, 2} ... o resto que não foi inicializado é iniciado com zero. (ou com o construtor vazio padrão...)


##### Variable length array

```cpp
using namespace std;
int main ()
{
	int tam; cout << "tam: "; cin >> tam;
	int v[tam]; // Isso não era permitido...
	int i;
	for (int i = 0; i < tam; ++i) v[i] = i;
	for (int i = 0; i < tam; ++i) cout << v[i] << '\n';
}
```

-  A prática acima foi introduzida em C-99, mas foi tornada opcional para os compiladores novos, apesar de compilar na maioria dos casos.
- O vetor vai para a pilha de execução de funções, podendo estourar se um número grande for inicializado pelo usuário.

```cpp
#include <iostream>
using namespace std;

int main ()
	{
	int num_linhas = 2. num colunas = 3;
	double *v = new double [num_linhas * num_colunas];
	for (int i = 0; i < num_linhas; ++i)
		{
		for (int j = 0; j < num_colunas; ++j)
			{
			  v[i*num_colunas + j] = i*num_colunas + j;
			}
		}
		
	for (int i = 0; i < num_linhas; ++i)
		{
		cout << '[';
		for (int j = 0; j < num_colunas; ++j)
			{
			  cout << ' ' << v[i*num_colunas + j];
			}
			cout << "]\n";
		}
	delete[] v;
}
```

- Omitimos o `try catch por breviadade`
- A fórmula para calcular a linha da matriz é interessante, e vale a pena ser inspecionada.
#### Usando vetor de vetores


```cpp
int main()
	{
		int num_linhas = 2, num_colunas = 3;
		double** m = new double* [num_linhas]; // Vetor de ponteiros

		for(int i = 0; i < num_linhas; ++i)
		{
			m[i] = new double [num_colunas]; // Cada ponteiro é 
		}

		for(int i = 0; i < num_linhas; ++i)
		{
			delete[] m[i];
		}
		
		delete m;	
	}
```

Alguns detalhes importantes:
- Em C e C++, "a=b" é uma expressão cujo valor é aquele de "a" após a atribuição;
- ++i é equivalente a "i = i + 1"
- i++ é equivalente a "vi = i,  i = i +1, vi"
- Omitimos `try catch` novamente