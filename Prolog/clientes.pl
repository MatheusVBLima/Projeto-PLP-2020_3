:- use_module(library(readutil)).


get_cpf(Cliente,Cpf) :- nth0(1,Cliente,Cpf).
get_nome(CLiente,nome) :- nth(0,CLiente,nome).


formataVisitante(Out,L) :-
    format(string(Out),'~s',L).

getCPF(Cliente,CPF) :- nth0(1,Cliente,CPF).

cadastrarVisitante(C) :-
    open('/home/caiohrgm/Documentos/CompUFCG/RAE/PLP/Haskell/Projeto SGB - Haskell/Projeto-PLP-2020_3/Prolog/Dados/visitantes.txt',append,File),
    formataVisitante(S,C),
    writeln(File,S),
    close(File).

target([H|T],Flag) :- H == Flag.

encontrado([],[]).
encontrado([X|T],Cpf,Visitante) :- 
    split_string(X,"-","",X1),
    target(X1,Cpf),
    Visitante = X1,!.
encontrado([X|T],Cpf,Visitante) :- encontrado(T,Cpf,Visitante).

verificaVisitante(Cpf,Visitante) :-
    lerArquivo(Visitantes),
    encontrado(Visitantes,Cpf,Visitante).

lerArquivo(Result) :-
    open('/home/caiohrgm/Documentos/CompUFCG/RAE/PLP/Haskell/Projeto SGB - Haskell/Projeto-PLP-2020_3/Prolog/Dados/visitantes.txt',read,Str),
    read_stream_to_codes(Str,Visitantes),
    atom_string(Visitantes,Visitantes1),
    split_string(Visitantes1,"\n","",Result).

main :- 
    /*writeln('Digite seu nome e CPF[nome-cpf]: '),
    read(X),
    cadastrarVisitante(X),*/
    writeln("Digite um CPF para procurar:"),
    read(Y),
    verificaVisitante(Y,V),writeln("Visitante encontrado"),nl,halt; writeln("Visitante não cadastrado"),nl,halt.
