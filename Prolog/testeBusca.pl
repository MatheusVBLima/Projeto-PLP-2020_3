:- use_module(library(readutil)).

verificaVisitante(Cpf) :-
    lerArquivo(Visitantes),
    encontrado(Visitantes,Cpf).

lerArquivo(Result) :-
    open('/home/caiohrgm/Documentos/CompUFCG/RAE/PLP/Haskell/Projeto SGB - Haskell/Projeto-PLP-2020_3/Prolog/Dados/visitantes.txt',read,Str),
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

main :-
    read(E),
    verificaVisitante(E),writeln("Achou"),nl,halt;writeln("Não achou"),nl,halt.