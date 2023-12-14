# Orientação a Objetos

```cpp
struct B
{
	int campo;
	
	void ler_campo ()
	{
		cout << "campo"; 
		cin >> campo;
	}
};

struct D
{
	B base; // Replica os dados de função de B.
	double outro;
}
```

- No exemplo acima, D não é aceitável onde se espera um B, ou seja, não tem o mesmo tipo.
## Herança

```cpp
#include
struct B
{
	int campo;
	
	void ler_campo ()
	{
		cout << "campo"; 
		cin >> campo;
	// Tem um detalhe aqui...
	}
};

struct D : public B // Assim que definimos herança!
{
	double outro;
};

int main ()
{
	B *base = new D;
	base ->ler_campo();
	cout << "Campo: " << base->campo << '\n';
	delete base;
}
```

##### Explicando o detalhe apontado no comentário...

```cpp
#include <iostream>
#include <string>
using namespace std;

struct Academico
{
	protected: // As classes tem visibilidade, o usuário não
	string nome;
	
	public:
	Academico(strinc nome_pessoa) : nome{nome_pessoa} {}
	virtual void descricao () // Método virtual, pode ser substituido.
	{
		cout << "Nome: " << nome '\n';
	}
	 
};

struct Estudante : /* public */ Academico
{
	private:
	int matricula;
	string curso_atual;
	void descricao() override // É uma boa prática escrever override
	{
		cout << "Estudante:\n"; 
		// cout << "Nome: " << nome;
		Academico::descricao(); // Chamando o método da superclasse
		cout << "\nMatrícula: " << matricula << '\n';
		cout << "Curso: " << curso_atual << '\n';
	}
	public:
	Estudante(string nome_est, int mat, string curso) : 
	Academico{nome_est}, // Chamamos o construtor da classe base, é inicializada
						// antes dos membros.
	matricula{mat}, curso_atual {curso_est} {}
}

struct Docente : /* public */ Academico
{
	private:
	int siape;
	string *turmas;
	int qtd_turmas
	
	public:
	Docente(string nome, int num_siape, string *v_turmas, tam_v) : 
	Academico{nome}, siape{num_siape}, turmas{v_turmas}, qtd_turmas{tam_v}
	{}
	void descricao() override
	{
		cout << "Docente:\n";
		Academico::descricao();
		cout << "Siape " << siape << '\n';
		cout << "Turmas:\n";
		
		for (int i = 0; i < qtd_turmas; ++i)
		{
			cout << turmas[i] << "  " << '\n';
		}
	}
	~Docente()
	{
		cout << "Apagando o vetor " << turmas << '\n';
		delete[] turmas;
	}
};

int main ()
{
	int tam = 2;
	Academico *aluno = new Estudante{"Rodrigo", 539105, "Ciência da Computação"};
	Academico *professor = new Docente {"Pablo", 2554198, new string [tam]
	{"CK0015 LiP I", "T10140 ED"}, tam}
	
	Academico * *v = new Academico*[tam] {aluno, professor};
	
	for (int i = 0; i < tam; ++i)
	{
		cout << '\n'; v[i] -> descricao();
	}
	
	for (int i = 0; i < tam; ++i)
	{
		delete v[i];
	}
	
	delete[] v;
}

```

- Definimos um método virtual em Acadêmico. Um método virtual pode ser reescrito nas classes derivadas.
- O termo public é omitido em Estudante já que estamos tratando de `structs`, onde os membros já são públicos por padrão.
- Quando construímos uma classe derivada, a parte dela que é herdada é inicializada primeiro, conforme a sintaxe vista acima.
- Use funções virtuais só quando precisar! Existe um custo associado em usar métodos virtuais que não é explicito.
- A sintaxe `Classe::Método()` é útil para se referir a métodos descritos na superclasse.
- Protected é tipo um "private" mas as classes herdadas podem ver:
  
#### Tá, mas qual é o detalhe?
- O detalhe que é precisávamos ter especificado que o destrutor de acadêmico é **Virtual**. Dessa maneira, os destrutores das classes bases podem atuar com liberdade!
- Ou seja, se uma classe é feita para ser herdada, o destrutor delas deve ser virtual.
--- 
#### Detalhando as diferenças de visibilidade para herança.
- Com relação a visibilidade dos membros
	`struct` : tudo `public` por padrão, incluindo herança.
	`class`  : tudo `private` por padrão, incluindo herança;

- Com relação à visibilidade da herança (suponha que D herda B):
	`private` :  Só D sabe que herda de B.
	`protected` : D e suas subclasses sabem que D herda de B.
	`public` : Todos sabem que D herda de B.

- Saber que D herda de B significa:
1. Poder acessar membros que D possui porque herdou de B.
2. Poder atribuir "D*" a "B*" normalmente.

- Na prática, as heranças `private` e `protected` são úteis quando a herança é um "detalhe de implementação" da subclasse, ao invés de uma característica a ser utilizada de fora.

## Classes Abstratas

```cpp
#include <iostream>
#include <memory>
using namespace std;

class Figura
{
	public:
	virtual double area() = 0; // VIRTUAL PURA!
};

class Retangulo : public Figura
{
	double base, altura;
	public:
	Retangulo (double b, double a) : base{b}, altura{a} {}
	double area() override
	{
		return base*altura
	}
};

int main()
{
	unique_ptr <Figura> fig {(Figura*) new Retangulo {2, 10}};
	cout << "Área: " << fig->area();
}
```

- O `= 0` em uma função indica que ela é virtual pura.