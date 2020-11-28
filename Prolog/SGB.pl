:- initialization(main).
:- use_module(library(readutil)).

% bibliotecario(CPF,Nome).
bibliotecario("12345","Maria Madalena").

/*----------------------------------------------------------------------Menu Prévio & Opções-----------------------------------------------------------------*/
opcaoP(0) :- halt.
opcaoP(1) :- verificarBibliotecario(), menuOpcoesBibliotecario(); menuPrevio.
opcaoP(2) :- verificarVisitante(),writeln("Visitante encontrado!"),menuOpcoesVisitante(); writeln("Não cadastrado").
opcaoP(3) :- cadastrarVisitante(),menuPrevio().
opcaoP(_) :- writeln("Opção inválida. Tente novamente."),menuPrevio().

menuPrevio() :-
	writeln("\nBem-Vindo ao SGB."),
	writeln("\nAdicione sempre um ponto ao final de cada escolha."), 
	writeln("0 - Sair"), 
	writeln("1 - Sou Bibliotecário(a);"),
	writeln("2 - Sou Visitante;"),
	writeln("3 - Faça seu cadastro,visitante;"),
	read(P),
	opcaoP(P).
/*-----------------------------------------------------------------------Menu Bibliotecário e Opções----------------------------------------------------------*/
opcaoB(0) :- halt.	
opcaoB(1) :- buscarLivro(), menuOpcoesBibliotecario().
opcaoB(2) :- listarLivros(), menuOpcoesBibliotecario().				
opcaoB(3) :- listarLivrosDisponiveis(), menuOpcoesBibliotecario().
opcaoB(4) :- listarLivrosAlugados(), menuOpcoesBibliotecario().
opcaoB(5) :- efetuarAluguel(), menuOpcoesBibliotecario().
opcaoB(6) :- efetuarDevolucao(), menuOpcoesBibliotecario().
opcaoB(7) :- listarSugestaoLivros(), menuOpcoesBibliotecario().
opcaoB(8) :- visualizarCapacidade(), menuOpcoesBibliotecario().
opcaoB(9) :- visualizarPorcentagemAlugados(), menuOpcoesBibliotecario().
opcaoB(10) :- listarLivrosDoados(), menuOpcoesBibliotecario().
opcaoB(11) :- cadastrarLivro(), menuOpcoesBibliotecario().
opcaoB(_) :- writeln("Opcao invalida, tente outra!"), menuOpcoesBibliotecario().

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
	read(B),
	opcaoB(B).
/*-----------------------------------------------------------------------Menu Visitante e Opções----------------------------------------------------------*/
opcaoV(0) :- halt.	
opcaoV(1) :- buscarLivro(), menuOpcoesVisitante().	
opcaoV(2) :- listarLivros(), menuOpcoesVisitante().				
opcaoV(3) :- listarLivrosDisponiveis(), menuOpcoesVisitante().		
opcaoV(4) :- listarLivrosAlugados(), menuOpcoesVisitante().		
opcaoV(5) :- enviarSugestaoLivro(), menuOpcoesVisitante().	
opcaoV(6) :- fazerDoacaoLivro(), menuOpcoesVisitante().	
opcaoV(7) :- fazerResenhaLivro(), menuOpcoesVisitante().	
opcaoV(_) :- writeln("Opcao invalida, tente outra!").

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
	read(V),
	opcaoV(V).
/*-------------------------------------------------------------------------------------Main-------------------------------------------------------------------*/
main :-
	menuPrevio().
/*-------------------------------------------------------------------------------------Funções Visitantes-------------------------------------------------------------------*/
cadastrarVisitante() :-
	writeln("Digite seu nome e CPF [Nome - CPF]: "),
	read(C),
    open('Dados/visitantes.txt',append,File),
    formataGeral(S,C),
    writeln(File,S),
	writeln("Visitante cadastrado com sucesso!"),
    close(File).

verificarVisitante() :-
	writeln("Digite seu CPF: "),
	read(C),
	lerArquivoVisitantes(Visitantes),
    encontrado(Visitantes,C).
/*--------------------------------------------------------------------Funções Bibliotecario(a)---------------------------------------------------------------*/
verificarBibliotecario() :-
	writeln("Digite seu CPF: "),
	read(C),
	call(bibliotecario(C,_)),
	writeln("\n"),
	writeln("Funcionário registrado."), writeln("Bem-vindo ao SGB"),
	menuOpcoesBibliotecario; writeln("Usuário não cadastrado."),
	menuPrevio.
/*--------------------------------------------------------------------Funções Livros-------------------------------------------------------------------------*/
cadastrarLivro() :- 
    writeln("Digite o índice, nome, gênero, ano e autor do livro, tudo entre aspas, separado por '-' e com ponto no final do último dado: "),
    writeln("Exemplo: ['1- nome livro-terror-... .'] "),
    read(C),
    open('Dados/livros.txt',append,File),
	formataGeral(S,C),
    writeln(File,S),
	writeln("Livro cadastrado com sucesso"),
    close(File).

buscarLivro() :- 
    writeln("Digite o nome do livro: "),
    read(C),
    lerArquivoLivros(Livros),
    encontraLivro(Livros,C).
    
buscarLivroGenero() :- halt.

listarLivros() :- 
    lerArquivoLivros(L),
    writeln("Os livros da biblioteca são: "),
    writeln(L).

listarLivrosAlugados() :- 
	writeln("os livros que estão alugados são: "),
	lerArquivoAlugados(Alugados),
	writeln(Alugados).

listarSugestaoLivros() :- 
	writeln("os Livros sugeridos para aquisição são: "),
	lerArquivoSugestoes(Sugestoes),
	writeln(Sugestoes).

listarLivrosDoados() :- 
	writeln("os livros que foram doados são: "),
	lerArquivoDoados(Doados),
	writeln(Doados).

enviarSugestaoLivro() :- writeln("Escreva sua sugestão[Seu Nome - Nome do livro]:"),
	read(C),
    open('Dados/sugestoes.txt',append,File),
    formataGeral(S,C),
    writeln(File,S),
    close(File).

fazerDoacaoLivro() :- halt.

fazerResenhaLivro() :- 
	writeln("Digite seu nome, o nome do livro e sua resenha[Seu nome - Nome do Livro - Resenha]: "),
	read(C),
    open('Dados/resenhas.txt',append,File),
    formataGeral(S,C),
    writeln(File,S),
	writeln("Resenha cadastrada com sucesso."),
    close(File).
/*-------------------------------------------------------------------Funções Acervo Biblioteca----------------------------------------------------------------*/
efetuarAluguel() :- halt.

efetuarDevolucao() :- halt.

visualizarCapacidade() :- halt.

visualizarPorcentagemAlugados() :- halt.
/*-------------------------------------------------------------------Funções Auxiliares------------------------------------------------------------------*/
formataGeral(Out,L) :-
    format(string(Out),'~s',L).
/*---------------Visitantes------------*/
lerArquivoVisitantes(Result) :-
    open('Dados/visitantes.txt',read,Str),
    read_stream_to_codes(Str,Visitantes),
    atom_string(Visitantes,Visitantes1),
    split_string(Visitantes1,"\n","",Result).

encontraVisitante([''],_).
encontraVisitante([X|T],Cpf) :- 
    split_string(X,"-"," ",X1),
    targetVisitante(X1,Cpf); encontraVisitante(T,Cpf).

targetVisitante([_|T],C) :- 
    nth0(0,T,E),
    E == C.
/*----------------Livros-------------*/
lerArquivoLivros(Result) :-  
    open('Dados/livros.txt',read,Str),
    read_stream_to_codes(Str,Livros),
    atom_string(Livros,Livros1),
    split_string(Livros1,"\n","",Result).
    
lerArquivoDoados(Result) :-
    open('Dados/doacoes.txt',read,Str),
    read_stream_to_codes(Str,Doados),
    atom_string(Doados,Doados1),
    split_string(Doados1,"\n","",Result).
    
lerArquivoAlugados(Result) :-
    open('Dados/alugados.txt',read,Str),
    read_stream_to_codes(Str,Alugados),
    atom_string(Alugados,Alugados1),
    split_string(Alugados1,"\n","",Result).

encontraLivro([''],_).
encontraLivro([X|T],Nome) :- 
    split_string(X,"-"," ",X1),
    targetLivro(X1,Nome); encontraLivro(T,Nome).

targetLivro([_|T],C) :- 
    nth0(0,T,E),
    E == C.

lerArquivoSugestoes(Result) :-
    open('Dados/sugestoes.txt',read,Str),
    read_stream_to_codes(Str,Sugestoes),
    atom_string(Sugestoes,Sugestoes1),
    split_string(Sugestoes1,"\n","",Result).
    





