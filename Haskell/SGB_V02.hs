import System.IO
import Data.List
import Data.List.Split
import System.Directory
import Text.Printf
-- //////////////////////////////////////  DATA  //////////////////////////////////////

data Livro = Livro {
	indice :: Integer,
	nome :: String,
	genero :: String,
	ano :: String,
    autor :: String
} deriving (Show)

data Bibliotecario = Bibliotecario {  
    nomeB :: String,
    cpfB :: String
} deriving(Show)

data Visitante = Visitante{nomeV :: String, cpfV :: String} deriving (Show)



-- //////////////////////////////////////  Conjuntos Iniciais //////////////////////////////////////
bibliotecarioCadastrado :: [Bibliotecario]  
bibliotecarioCadastrado = [Bibliotecario {nomeB = "Maria da Penha",cpfB = "12345"}]

livrosCadastrados :: [Livro]
livrosCadastrados = [Livro {indice = 1, nome = "Fahrenheit 451", genero = "distopia", ano = "1953", autor = "Ray Bradbury"},
					 Livro {indice = 2, nome = "1984", genero = "distopia", ano = "1949", autor = "George Orwell"},
					 Livro {indice = 3, nome = "O Iluminado", genero = "terror", ano = "1977", autor = "Stephen King"},
					 Livro {indice = 4, nome = "Doutor Sono", genero = "terror", ano = "2013", autor = "Stephen King"},
					 Livro {indice = 5, nome = "A peste", genero = "filosofia", ano = "1947", autor = "Albert Camus"},
					 Livro {indice = 6, nome = "Cem anos de solidão", genero = "realismo mágico", ano = "2001", autor = "Gabriel García Márquez"},
					 Livro {indice = 7, nome = "O Gene Egoísta", genero = "Biologia", ano = "1976", autor = "Richard Dawkins"}]
-- //////////////////////////////////////  MENU  //////////////////////////////////////

main :: IO ()
main = do
    menuPrint
    menuPrevio


menuPrint :: IO ()
menuPrint = do
	putStrLn "Bem-vindo!"

diferenciaUsuario :: Int -> IO()  
diferenciaUsuario opcao 
                    | opcao == 1 = do {verificaBibliotecario} 
                    | opcao == 2 = do {verificaVisitante}
                    | opcao == 3 = do {fazerCadastroVisitante;menuPrevio} 
                    | opcao == 0 = do putStrLn "Fim do Programa"
                    | otherwise =  do {putStrLn "Opcao invalida, Porfavor escolha uma opcao valida" ; menuPrevio}

menuPrevio :: IO()  
menuPrevio = do
    putStrLn "0 - Sair" 
    putStrLn "1 - Sou Bibliotecário(a)"   
    putStrLn "2 - Sou Visitante"
    putStrLn "3 - Faça seu cadastro, visitante." 
    putStrLn "\nOpcao: "
    opcao <- getLine
    if (read opcao) == 0 then putStrLn("Fim do Programa") else do diferenciaUsuario (read opcao)


menuOpcaoBibliotecario :: IO ()  
menuOpcaoBibliotecario = do
    putStrLn "0 - Sair."
    putStrLn "1 - Buscar Livro." 
    putStrLn "2 - Listar todos os livros."  
    putStrLn "3 - Listar livros disponiveis." 
    putStrLn "4 - Listar livros alugados." 
    putStrLn "5 - Efetuar Aluguel." 
    putStrLn "6 - Efetuar Devolução." 
    putStrLn "7 - Listar livros por genero." 
    putStrLn "8 - Visualizar sugestões de livro." 
    putStrLn "9 - Visualizar capacidade da biblioteca."
    putStrLn "10 - Visualizar porcentagem de livros alugados."
    putStrLn "11 - Visualizar doações." 
    putStrLn "12 - Cadastrar Livro."   
    putStrLn "\nOpcao: "
    opcao <- getLine
    if (read opcao) == 0 then putStrLn("Fim do Programa") else do opcaoEscolhidaBibliotecario (read opcao)

menuOpcaoVisitante :: IO()
menuOpcaoVisitante = do
    putStrLn "0 - Sair."
    putStrLn "1 - Buscar Livro." 
    putStrLn "2 - Listar todos os livros."  
    putStrLn "3 - Listar livros disponiveis." 
    putStrLn "4 - Listar livros por genero." 
    putStrLn "5 - Enviar sugestão de livro."
    putStrLn "6 - Fazer doação."
    putStrLn "7 - Fazer devolução com avaliação."
    putStrLn "\nOpcao: "
    opcao <- getLine
    if (read opcao) == 0 then putStrLn("Fim do Programa") else do opcaoEscolhidaVisitante (read opcao)

menuListagem :: IO()
menuListagem = do
    putStrLn "0 - Voltar para o menu principal" 
    putStrLn "1 - Descobrir mais informações sobre um livro"
    putStr "\nOpção: "
    opcao <- getLine
    if (read opcao) == 1
        then do
            visualizarInfoLivro
    else if (read opcao) /= 0 
        then do
            putStrLn "==> Opção inválida"
    else
        putStr ""
    printEspaco

-- //////////////////////////////////////  ESCOLHER OPÇÃO  //////////////////////////////////////
verificaBibliotecario :: IO()  
verificaBibliotecario = do 
    putStr"Digite seu CPF: "
    cpf <- getLine
    let check = verificaBibliotecarioCadastrado (bibliotecarioCadastrado) (cpf)
    if check == True 
        then do {putStrLn "Autorizado com sucesso.\n\n"; menuOpcaoBibliotecario}
    else do {putStrLn "Você não está cadastrado no sistema.\n\n"; menuPrevio}

opcaoEscolhidaBibliotecario :: Int -> IO()
opcaoEscolhidaBibliotecario opcao 
                    | opcao == 1 = do {buscarLivro;menuOpcaoBibliotecario}
                    | opcao == 2 = do {imprimeLivros ; menuListagem; menuOpcaoBibliotecario} 
                    | opcao == 3 = do {imprimeDisponiveis ; menuOpcaoBibliotecario}
                    | opcao == 4 = do {imprimeAlugados ; menuOpcaoBibliotecario}
                    | opcao == 5 = do {realizarAluguel ; menuOpcaoBibliotecario}
                    | opcao == 6 = do {realizarDevolucao ; menuOpcaoBibliotecario}
                    | opcao == 7 = do {imprimeListarLivrosPorGenero; menuOpcaoBibliotecario}     
                    | opcao == 8 = do {visualizarSugestoes; menuOpcaoBibliotecario}
                    | opcao == 9 = do {capacidadeBiblioteca; menuOpcaoBibliotecario}
                    | opcao == 10 = do {porcentagemAlugados; menuOpcaoBibliotecario}
                    | opcao == 11 = do {visualizarDoacoes; menuOpcaoBibliotecario}
                    | opcao == 12 = do {cadastrarLivro; menuOpcaoBibliotecario} 
                    | opcao == 0 = do {putStrLn "Fim do Programa.\n"}   
                    | otherwise =  do {putStrLn "Opcao invalida, Porfavor escolha uma opcao valida" ; menuOpcaoBibliotecario}

opcaoEscolhidaVisitante :: Int -> IO()
opcaoEscolhidaVisitante opcao 
                    | opcao == 1 = do {buscarLivro;menuOpcaoVisitante}
                    | opcao == 2 = do {imprimeLivros ; menuListagem; menuOpcaoVisitante} 
                    | opcao == 3 = do {imprimeDisponiveis ; menuOpcaoVisitante}
                    | opcao == 4 = do {imprimeListarLivrosPorGenero; menuOpcaoVisitante}    
                    | opcao == 5 = do {enviarSugestao; menuOpcaoVisitante}  
                    | opcao == 6 = do {fazerDoacao; menuOpcaoVisitante}
                    | opcao == 7 = do {realizarDevolucao;menuOpcaoVisitante} 
                    | opcao == 0 = do {putStrLn "Fim do Programa.\n"}  
                    | otherwise =  do {putStrLn "Opcao invalida, Porfavor escolha uma opcao valida" ; menuOpcaoVisitante}

-- //////////////////////////////////////  PRINTS  //////////////////////////////////////
imprimeLivros :: IO()
imprimeLivros = putStrLn ("\n\n\n" ++ (listarLivros livrosCadastrados) ++ "\n\n")


imprimeDisponiveis :: IO()
imprimeDisponiveis = do
    let todos = [1..toInteger(length livrosCadastrados)]
    alugados <- alugueis
    let disponiveis = todos \\ alugados
    printEspaco
    if disponiveis == []
        then putStrLn "Nao há livros disponíveis."
    else putStrLn (listarLivros (listarInteiroParaLivro disponiveis))
    printEspaco


imprimeAlugados :: IO()
imprimeAlugados = do
    let todos = [1..toInteger(length livrosCadastrados)]
    alugados <- alugueis
    printEspaco
    if alugados == []
        then putStrLn "Você não tem livros alugados."
    else putStrLn (listarLivros (listarInteiroParaLivro alugados))
    printEspaco


imprimeListarLivrosPorGenero :: IO()
imprimeListarLivrosPorGenero = do
    printEspaco
    putStrLn "==> Insira o nome do genero na qual você deseja filtrar: "
    genero <- getLine
    let livrosDoGenero = "\n==> Os livros que possuem esse genero são:\n" ++ unlines(listarLivrosPorGenero (livrosCadastrados ) ([]) ( genero ))
    if livrosDoGenero == "\n==> Os livros que possuem esse genero são:\n"
		then putStrLn "\nNão há livros desse gênero na biblioteca.\n"
	else
		putStrLn livrosDoGenero
    printEspaco

visualizarSugestoes :: IO()
visualizarSugestoes = do
    printEspaco
    putStrLn "==> Livros sugeridos para aquisição:\n"
    sugestoes <- readFile "sugestoes.txt"
    putStrLn sugestoes
    printEspaco

visualizarDoacoes :: IO()
visualizarDoacoes = do
    printEspaco
    putStrLn "==> Livros doados:\n"
    doacoes <- readFile "doacoes.txt"
    putStrLn doacoes
    printEspaco
-- //////////////////////////////////////  OPERAÇÕES  //////////////////////////////////////
fazerCadastroVisitante :: IO()
fazerCadastroVisitante = do
    putStrLn "Digite seu nome e CPF [nome-cpf]: "
    input1 <- getLine
    let x = geraVisitante (input1)
    cadastraVisitante x
   
buscarLivro :: IO()
buscarLivro = do
    putStr "Digite o nome do livro que procura: "
    nomeLivro <- getLine
    let check = verificaLivrosCadastrados (livrosCadastrados) (nomeLivro)
    if check == True then do {putStrLn "Livro encontrado.\n\n"}
        else do {putStrLn "Livro não consta no sistema.\n\n"}

realizarAluguel :: IO()
realizarAluguel = do
    printEspaco
    putStrLn "==> Digite o codigo do livro que deseja alugar: "
    indice <- getLine
    disponivel <- estaDisponivel (read indice)
    if (disponivel && ((read indice) > 0) && ((read indice) < length livrosCadastrados))
        then do 
            adicionaAluguel (read indice)
            putStrLn "==> Livro alugado com sucesso"
    else putStrLn "==> Livro não disponível para aluguel"
    printEspaco
    
realizarDevolucao :: IO()
realizarDevolucao = do
    printEspaco
    putStrLn "==> Digite o codigo do livro que deseja devolver: "
    indice <- getLine
    disponivel <- estaDisponivel (read indice)
    if ((not disponivel) && ((read indice) > 0) && ((read indice) < length livrosCadastrados))
        then do
            removerAluguel (read indice)
            putStrLn "==> Livros devolvido com sucesso."
            putStrLn "==> Deseja adicionar uma nota? Digite Sim ou Não"
            entrada <- getLine
            if(entrada == "Sim")
                then do
                    avaliarLivro
            else if(entrada == "Nao")
                then do
                    putStrLn "==> Operação finalizada."
            else
                putStrLn "==> Opção inválida"

    else
        putStrLn "==> Este livro não foi alugado."
    printEspaco

avaliarLivro :: IO()
avaliarLivro = do
    printEspaco
    putStr "==> Digite o seu nome, o nome do livro e a avaliação: "
    avaliacao <- getLine
    appendFile "avaliacoes.txt" (avaliacao ++ "\n")
    printEspaco


enviarSugestao :: IO()
enviarSugestao = do
    printEspaco
    putStr "==> Digite o nome do livro que deseja sugerir: "
    nomeLivro <- getLine
    appendFile "sugestoes.txt" (nomeLivro ++ "\n")
    printEspaco


capacidadeBiblioteca :: IO()
capacidadeBiblioteca = do
    let livros = livrosCadastrados
    let max = 15
    let atual = quantidadeAtualLivros(livros) --Verificar como esta função deve receber a lista de livros
    let capacidade =  max-atual
    
    let str = show atual
    let str2 = show max

    if capacidade == 0 
        then putStrLn "Está biblioteca está em sua capacidade máxima.\n" 
    else print("Capacidade atual da biblioteca:"++ str ++"/"++str2++" livros.\n")


porcentagemAlugados :: IO()
porcentagemAlugados = do
    let livros = livrosCadastrados
    conteudo <- readFile "alugueis.txt"

    let linhas = lines conteudo
    let totalAlugados = contaAlugados(linhas)
    let totalCadastrados = quantidadeAtualLivros(livros)
    let porcentagem = divide(totalAlugados) (totalCadastrados)

    if totalAlugados == 0 then putStrLn "Não existem livros alugados no momento.\n"
        else printf "Porcentagem de livros atualmente alugados: %.2f%%\n" (porcentagem)

fazerDoacao :: IO()
fazerDoacao = do
    putStr "Digite o seu nome: "
    input <- getLine
    putStr "Digite as informações do livro que deseja doar [index-nome-genero-ano-autor]: "
    input2 <- getLine
    let x = geraLivro input2
    cadastraLivro x
    cadastraDoacao input x
    
cadastrarLivro :: IO()
cadastrarLivro = do
    putStr "Digite as informações do livro que deseja doar [index-nome-genero-ano-autor]: "
    input <- getLine
    let x = geraLivro input
    cadastraLivro x

-- //////////////////////////////////////  AUXILIARES  //////////////////////////////////////
-- //Auxiliares de Livro:--------------------------------------------------------------------
toStringLivro :: Livro -> String
toStringLivro (Livro {indice = i, nome = n, genero = g, ano = a, autor = d}) = show i ++ " - " ++ n     

listarLivros :: [Livro] -> String
listarLivros [] = ""
listarLivros (x:xs) = toStringLivro x ++ ['\n'] ++ listarLivros xs

alugueis :: IO [Integer]
alugueis = do
  conteudo <- readFile "alugueis.txt"
  let linhas = lines conteudo
  let numeros = fmap (read::String->Integer) linhas
  return numeros

adicionaAluguel :: Integer -> IO()
adicionaAluguel numero = do
    let conteudo = conteudoAdicionar numero
    appendFile "alugueis.txt" (conteudo)
    where
        conteudoAdicionar :: Integer -> String
        conteudoAdicionar numero
            | numero == (-1) = ""
            | otherwise = ((show numero) ++ "\n")

estaDisponivel :: Integer -> IO Bool
estaDisponivel indice = do
    alugados <- alugueis
    return $ estaDisponivel' indice alugados
    where
        estaDisponivel' :: Integer -> [Integer] -> Bool
        estaDisponivel' indice [] = True
        estaDisponivel' indice (a:as)  
            | indice == a = False           
            | otherwise = True && estaDisponivel' indice as

removerAluguel :: Integer -> IO()
removerAluguel numero = do
    listaNova <- removeElemento numero
    removeFile "alugueis.txt"
    refazArquivo listaNova
    where
        refazArquivo :: [Integer] -> IO()
        refazArquivo [] = adicionaAluguel (-1)
        refazArquivo (a:as) = do
            adicionaAluguel a
            refazArquivo as

removeElemento :: Integer -> IO [Integer] -- Função auxiliar para remover removerAluguel
removeElemento numero = do
    numeros <- alugueis
    return $ removeElemento' numeros numero
    where
        removeElemento' :: [Integer] -> Integer -> [Integer]
        removeElemento' [] numero = []
        removeElemento' (a:as) numero
            | a == numero = [] ++ removeElemento' as numero
            | otherwise = [a] ++ removeElemento' as numero


verificaNomeLivro :: Livro -> String -> Bool  
verificaNomeLivro (Livro a b c d e) nomeLivro = 
    if b == nomeLivro then True 
        else False 

verificaLivrosCadastrados :: [Livro] -> String -> Bool
verificaLivrosCadastrados [] _ = False
verificaLivrosCadastrados(h:t) nomeL =
    if verificaNomeLivro (h) (nomeL) == True  then True
    else  verificaLivrosCadastrados t nomeL

listarInteiroParaLivro :: [Integer] -> [Livro]
listarInteiroParaLivro lista = do
    let disponiveis = sort lista
    listarInteiroParaLivro' disponiveis livrosCadastrados
    where
        listarInteiroParaLivro' :: [Integer] -> [Livro] -> [Livro]
        listarInteiroParaLivro' [] _ = []
        listarInteiroParaLivro' (a:as) (b:bs)
            | a == (indice b) = [b] ++ listarInteiroParaLivro' as bs
            | otherwise = [] ++ listarInteiroParaLivro' (a:as) bs

ehDoGenero:: Livro -> String -> Bool
ehDoGenero (Livro {indice = i, nome = n, genero = g, ano = a, autor = d}) gen = if g == gen then True else False


listarLivrosPorGenero:: [Livro] -> [String] -> String -> [String]
listarLivrosPorGenero [] arrayDoGenero _ = arrayDoGenero
listarLivrosPorGenero (cabeca:cauda) arrayDoGenero genero
	| ehDoGenero cabeca genero = arrayDoGenero ++ [toStringLivro cabeca] ++ listarLivrosPorGenero cauda arrayDoGenero genero
	| otherwise = listarLivrosPorGenero cauda arrayDoGenero genero

infoLivro :: Livro -> String  
infoLivro livro = "- Nome: " ++ (nome livro) ++ ['\n'] ++ "- Autor(a): " ++ (autor livro) ++ ['\n'] ++ "- Gênero: " ++ (genero livro) ++ ['\n'] ++ "- Ano de Lançamento: " ++ (ano livro) ++ ['\n'] 


visualizarInfoLivro:: IO()
visualizarInfoLivro = do
    putStrLn "==> Escolha o indice do livro que você deseja visualizar:"
    indice <- getLine
    let parseIndice = read (indice)
    let indiceNaLista = parseIndice-1

    if parseIndice > 0 && parseIndice < ( length livrosCadastrados )+1
        then putStrLn ( infoLivro ( livrosCadastrados !!  indiceNaLista  ) ) 
    else putStrLn "Livro não existente."


-- //Auxiliares do Bibliotecario e Biblioteca:--------------------------------------------------------------------
geraLivro :: String -> Livro
geraLivro livro =
    if livro /= "" then (Livro (read(dados !! 0)::Integer) (dados !! 1) (dados !! 2) (dados !! 3) (dados !! 4))
    else (Livro 0 "" "" "" "")
    where
        dados = splitOn "-" livro

formataLivro:: Livro -> String
formataLivro (Livro a b c d e) = (show a) ++ "-" ++ b ++ "-" ++ c ++ "-" ++ d ++ "-" ++ e ++ "\n"

cadastraLivro :: Livro -> IO()
cadastraLivro livro  = do
    let x  = formataLivro livro
    appendFile "livroscadastrados.txt" (x)

cadastraDoacao :: String -> Livro -> IO()
cadastraDoacao nome livro  = do
    let x  = formataLivro livro
    appendFile "doacoes.txt" $ nome++"-"++ x

quantidadeAtualLivros :: [Livro] -> Int
quantidadeAtualLivros [] = 0
quantidadeAtualLivros (x:xs) = 1 + quantidadeAtualLivros xs

contaAlugados :: [String] -> Int
contaAlugados [] = 0
contaAlugados (x:xs) = 1 + contaAlugados xs

verificaCPFBibliotecario :: Bibliotecario -> String -> Bool
verificaCPFBibliotecario (Bibliotecario a b) cpf = 
    if b == cpf then True 
        else False 

verificaBibliotecarioCadastrado :: [Bibliotecario] -> String -> Bool
verificaBibliotecarioCadastrado [] _ = False
verificaBibliotecarioCadastrado(h:t) cpf =
    if verificaCPFBibliotecario (h) (cpf) == True  then True
    else  verificaBibliotecarioCadastrado t cpf

-- //Auxiliares do Visitante:--------------------------------------------------------------------
cadastraVisitante:: Visitante -> IO()
cadastraVisitante visitante  = do
    visitantes <- lerArquivo
    let flag = checaVisitante visitantes (visitanteCpf visitante)
    if flag /= "" then putStrLn $ "Visitante já existe"
    else do
        appendFile "visitantes.txt" (formataVisitante visitante)


verificaVisitante :: IO() -- FAz a compração dos CPFs para autorizar o login do visistante;
verificaVisitante = do
    visitantes <- lerArquivo  -- Le o arquivo com os dados dos visitantes;
    putStr "Digite seu cpf: "
    input <- getLine
    let flag = checaVisitanteCPF visitantes input
    if flag == "" 
        then do {putStrLn "Você não está cadastrado no sistema.\n\n"; menuPrevio}
    else do  {putStrLn "Autorizado com sucesso.\n\n"; menuOpcaoVisitante}

visitanteCpf :: Visitante -> String
visitanteCpf (Visitante _ cpf) = cpf

visitanteNome :: Visitante -> String
visitanteNome (Visitante nome _) = nome

visitanteMostraVisitante::Visitante->String
visitanteMostraVisitante (Visitante elem1 elem2) = "\nNOME: " ++ elem1 ++ "\nCPF: " ++ elem2

geraVisitante:: String -> Visitante
geraVisitante visitante  =
    if visitante /= "" then (Visitante (dados !! 0) (dados !! 1))
    else (Visitante "" "")
    where
        dados = splitOn "-" visitante

formataVisitante :: Visitante -> String 
formataVisitante (Visitante a b) = a ++ "-" ++ b ++ "\n"

isVisitante :: [String]->String->String
isVisitante [] key = ""
isVisitante (x:xs) key =
    if (splitOn "-" x !! 0) == key then x
    else isVisitante xs key

checaVisitante :: String -> String -> String
checaVisitante visitantes cpf = do
    encontrado
    where
        encontrado = isVisitante (splitOn "\n" visitantes) cpf

procuraCPF :: [String] -> String -> String
procuraCPF [] _ = ""
procuraCPF (x:xs) key =
    if str == key then x
    else procuraCPF xs key
    where
        str = splitOn "-" x !! 1

checaVisitanteCPF :: String -> String -> String
checaVisitanteCPF visitantes cpf = do
    encontrado
    where
        encontrado = procuraCPF (splitOn "\n" visitantes) cpf
-- //Auxiliares Outros:--------------------------------------------------------------------
lerArquivo ::IO String
lerArquivo = readFile "visitantes.txt"

printEspaco :: IO()
printEspaco = putStrLn "\n\n\n"

divide :: Int -> Int -> Float
divide x y = (a/b)*100
    where   
        a = fromIntegral x :: Float
        b = fromIntegral y :: Float
