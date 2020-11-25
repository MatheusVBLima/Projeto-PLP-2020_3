:- initialization(main).
:- use_module(library(readutil)).

% bibliotecario(CPF,Nome).
bibliotecario("12345","Maria Madalena").

/*----------------------------------------------------------------------Menu Prévio & Opções-----------------------------------------------------------------*/
opcaoP(0) :- halt.
opcaoP(1) :- verificarBibliotecario().
opcaoP(2) :- verificarVisitante(),writeln("Visitante encontrado!"),menuOpcoesVisitante(); writeln("Não cadastrado").
opcaoP(3) :- cadastrarVisitante(),menuPrevio().
opcaoP(X) :- writeln("Opção inválida. Tente novamente."),menuPrevio().

menuPrevio() :-
	writeln("\nAdicione sempre um ponto ao final de cada escolha."), 
	writeln("0 - Sair"), 
	writeln("1 - Sou Bibliotecário(a);"),
	writeln("2 - Sou Visitante;"),
	writeln("3 - Faça seu cadastro,visitante;"),
	read(A),
	opcaoP(A).
/*-----------------------------------------------------------------------Menu Bibliotecário e Opções----------------------------------------------------------*/
opcaoA(0) :- halt.	
opcaoA(1) :- buscarLivro().
opcaoA(2) :- listarLivros().				
opcaoA(3) :- listarLivrosDisponiveis().	
opcaoA(4) :- listarLivrosAlugados().	
opcaoA(5) :- efetuarAluguel().
opcaoA(6) :- efetuarDevolucao().
opcaoA(7) :- listarSugestaoLivros().
opcaoA(8) :- visualizarCapacidade().
opcaoA(9) :- visualizarPorcentagemAlugados().
opcaoA(10) :- listarLivrosDoados().
opcaoA(11) :- cadastrarLivro().
opcaoA(X) :- writeln("Opcao invalida, tente outra!").

menuOpcoesBibliotecario() :- 
	writeln("\nAdicione sempre um ponto ao final de cada escolha."), 
	writeln("0 - Sair"),
	writeln("1 - Bucar livro;"), 
	writeln("2 - Listar todos os livros;"),
	writeln("3 - Listar livros disponíveis;"),
	writeln("4 - Listar livros alugados;"),
	writeln("5 - Efetuar Aluguel;"),
	writeln("6 - Efetuar Devolução;"),
	writeln("7 - Visualizar livros sugeridos;"),
	writeln("8 - Visualizar capacidade da biblioteca;"),
	writeln("9 - Visualizar porcentagem de livros alugados;"),
	writeln("10 - Visualizar doações;"),
	writeln("11 - Cadastrar novo livro no sistema;"),
	writeln("\nOpcao: "),
	writeln("\n"),
	read(A),
	opcaoB(A),
	menuOpcoesBibliotecario().
/*-----------------------------------------------------------------------Menu Visitante e Opções----------------------------------------------------------*/
opcaoB(0) :- halt.	
opcaoB(1) :- buscarLivro().
opcaoB(2) :- listarLivros().				
opcaoB(3) :- listarLivrosDisponiveis().	
opcaoB(4) :- listarLivrosAlugados().	
opcaoB(5) :- enviarSugestaoLivro().
opcaoB(6) :- fazerDoacaoLivro().
opcaoB(7) :- fazerResenhaLivro().
opcaoB(X) :- writeln("Opcao invalida, tente outra!").

menuOpcoesVisitante() :- 
	writeln("\nAdicione sempre um ponto ao final de cada escolha."), 
	writeln("0 - Sair;"),
	writeln("1 - Bucar livro;"), 
	writeln("2 - Listar todos os livros;"),
	writeln("3 - Listar livros disponíveis;"),
	writeln("4 - Listar livros alugados;"),
	writeln("5 - Enviar sugestão de livro;"),
	writeln("6 - Fazer doação;"),
	writeln("7 - Fazer resenha de livro;"),
	writeln("\nOpcao: "),
	writeln("\n"),
	read(A),
	opcaoB(A),
	menuOpcoesVisitante().
/*-------------------------------------------------------------------------------------Main-------------------------------------------------------------------*/
main :-
	writeln("Bem-vindo!"),
	menuPrevio().
/*-------------------------------------------------------------------------------------Funções Visitantes-------------------------------------------------------------------*/
cadastrarVisitante() :-
	writeln("Digite seu nome e CPF [nome-cpf]: "),
	read(C),
    open('Dados/visitantes.txt',append,File),
    formataVisitante(S,C),
    writeln(File,S),
    close(File).

verificarVisitante() :-
	writeln("Digite seu CPF: "),
	read(C),
    lerArquivo(Visitantes),
    encontrado(Visitantes,C).

formataVisitante(Out,L) :-
    format(string(Out),'~s',L).

lerArquivo(Result) :-
    open('Dados/visitantes.txt',read,Str),
    read_stream_to_codes(Str,Visitantes),
    atom_string(Visitantes,Visitantes1),
    split_string(Visitantes1,"\n","",Result).

encontrado([''],_).
encontrado([X|T],Cpf) :- 
    split_string(X,"-","",X1),
    target(X1,Cpf); encontrado(T,Cpf).

target([_|T],C) :- 
    nth0(0,T,E),
    E == C.
/*--------------------------------------------------------------------Funções Bibliotecario(a)---------------------------------------------------------------*/
verificarBibliotecario() :-
	writeln("Digite seu CPF: "),
	read(C),
	call(bibliotecario(C,Nome)),
	writeln("Usuário cadastrado."),writeln("Bem-vindo ao SGB"),nl,menuOpcoesBibliotecario;writeln("Usuário não cadastrado."),nl,menuPrevio.
/*--------------------------------------------------------------------Funções Livros-------------------------------------------------------------------------*/
cadastrarLivro() :- halt.

buscarLivro() :- halt.

listarLivros() :- halt.

listarLivrosAlugados() :- halt.

listarSugestaoLivros() :- halt.

listarLivrosDoados() :- halt.

enviarSugestaoLivro() :- writeln("Escreva sua sugestão[seu nome-livro]:"),
	read(C),
    open('Dados/sugestoes.txt',append,File),
    formataSugestao(S,C),
    writeln(File,S),
    close(File).

formataSugestao(Out,L) :-
    format(string(Out),'~s',L).	

fazerDoacaoLivro() :- halt.

fazerResenhaLivro :- halt.

/*-------------------------------------------------------------------Funções Acervo Biblioteca----------------------------------------------------------------*/
efetuarAluguel(Codigo) :- halt.

efetuarDevolucao() :- halt.

visualizarCapacidade() :- halt.

visualizarPorcentagemAlugados() :- halt.




	  





