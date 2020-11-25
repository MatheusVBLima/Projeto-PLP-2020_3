main :- lerArquivo(Sugestoes),formataVisitante(Out,L),writeln(Out).

formataVisitante(Out,L) :-
    format(string(Out),'~s',L).

lerArquivo(Result) :-
    open('Dados/sugestoes.txt',read,Str),
    read_stream_to_codes(Str,Sugestoes),
    atom_string(Sugestoes,Sugestoes1),
    split_string(Sugestoes1,"\n","",Result).