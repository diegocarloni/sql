/* 3 - Informar todas as obras cadastradas no acervo, ordenada por data de publicacao */

SELECT ID_Obra, Data_Publicacao
FROM Obra
Order by Data_Publicacao ASC;

/* 4 - Informar a contagem de todas as obras cadastradas no acervo atualmente */

SELECT COUNT(ID_Obra) AS "Quantidade_obras_atual"
FROM Obra;

SELECT * FROM Estoque;

SELECT SUM(Quantidade_Livro) AS "Quantidade_obras_atual_Estoque"
FROM Estoque;

/* 5 - Informar quais datas ocorreram emprestimos de livros - retornar um registro para cada data */

DESC Emprestimo;

SELECT Data_Emprestimo
FROM Emprestimo
ORDER BY Data_Emprestimo;

SELECT Data_Emprestimo
FROM Emprestimo
GROUP BY Data_Emprestimo;

/* 6 - Informar todos os emprestimos que a recepcionista Alice Meire fez no horario das 8 hrs */

DESC Emprestimo;
DESC Funcionario;

SELECT ID_Funcionario, Nome_Funcionario
FROM Funcionario;

SELECT ID_Emprestimo
FROM Emprestimo
WHERE ID_Funcionario = 8 AND Hora_Emprestimo = '08:00:00';

/* 7 - Pesquisa de devolucao de livros entre as datas 29/03/2012 a 02/02/2013 */

DESC Devolucao;

SELECT ID_Devolucao, Data_Devolucao
FROM Devolucao
WHERE Data_Devolucao BETWEEN '2012-03-29' AND '2013-02-02';
	
	/* Outra forma*/

SELECT ID_Devolucao, Data_Devolucao
FROM Devolucao
WHERE Data_Devolucao >= '2012-03-29' AND Data_Devolucao <= '2013-02-02';

/* 8 - Reservas de livros com data maior ou igual 18/08/2011 */

DESC Reserva;

SELECT ID_Reserva, Data_Reserva
FROM Reserva
WHERE Data_Reserva >= '2011-08-18';

/* 9 - Devolucoes de livros com data menor 29/03/2012 */

DESC Devolucao;

SELECT ID_Devolucao, Data_Devolucao
FROM Devolucao
WHERE Data_Devolucao < '2012-03-29';

/* 10 - Obras existentes no acervo que tenham os titulos diferentes de 
'O Conde de Monte Cristo' e 'Filhos e Amantes' */

DESC Obra;

SELECT ID_Obra, Titulo_Obra
FROM Obra
WHERE Titulo_Obra <> 'O Conde de Monte Cristo' AND Titulo_Obra <> 'Filhos e Amantes';

/* 11 - Quantas Obras do genero ficcao exitem no acervo */

DESC Obra;

SELECT ID_Obra, Genero
FROM Obra
WHERE Genero = 'Ficção';

SELECT COUNT(Genero) AS "Quantidade_Obras_Ficção"
FROM Obra
WHERE Genero = 'Ficção';


/* 12 - Identificar qual livro tem maior quantidade em estoque */

DESC Estoque;

SELECT MAX(Quantidade_Livro) AS "Maior_qdd_estoque"
FROM Estoque;

SELECT ID_Estoque, Quantidade_Livro AS "Maior_qdd_estoque"
FROM Estoque
WHERE Quantidade_Livro = (SELECT MAX(Quantidade_Livro) 
FROM Estoque);

SELECT O.Titulo_Obra, E.Quantidade_Livro AS "Maior_qdd_estoque"
FROM Estoque E
INNER JOIN Obra O
ON E.ID_Estoque = O.ID_Obra
WHERE Quantidade_Livro = (SELECT MAX(Quantidade_Livro) 
FROM Estoque);

/* 13 - Identificar qual livro tem menor quantidade em estoque */

SELECT MIN(Quantidade_Livro) AS "Menor_qdd_estoque"
FROM Estoque;

SELECT ID_Estoque, Quantidade_Livro AS "Menor_qdd_estoque"
FROM Estoque
WHERE Quantidade_Livro = (SELECT MIN(Quantidade_Livro) 
FROM Estoque);

SELECT O.Titulo_Obra, E.Quantidade_Livro AS "Menor_qdd_estoque"
FROM Estoque E
INNER JOIN Obra O
ON E.ID_Estoque = O.ID_Obra
WHERE Quantidade_Livro = (SELECT MIN(Quantidade_Livro) 
FROM Estoque);

/* 14 - Identificar a quantidade de registros de usuarios */

DESC Usuario;

SELECT COUNT(ID_Usuario) AS "Registros_de_Usuarios"
FROM Usuario;

/* 15 - Identificar as obras com os maiores numeros de publicações agrupados por gênero */

DESC Obra;

SELECT ID_Obra, Numero_Publicacao, Genero
FROM Obra
ORDER BY Numero_Publicacao DESC;

SELECT MAX(Numero_Publicacao), Genero
FROM Obra
GROUP BY Genero
ORDER BY MAX(Numero_Publicacao) DESC;

/*Traz resultado errado*/

SELECT ID_Obra, MAX(Numero_Publicacao), Genero
FROM Obra
GROUP BY Genero
ORDER BY MAX(Numero_Publicacao) DESC;

CREATE VIEW Query AS
SELECT ID_Obra, MAX(Numero_Publicacao) AS 'MAX_PUB', Genero 
FROM Obra
GROUP BY Genero
ORDER BY MAX(Numero_Publicacao) DESC;

SELECT O.Titulo_Obra, O.ID_Obra, Q.MAX_PUB, O.Genero
FROM Query Q
INNER JOIN Obra O
ON (Q.MAX_PUB = O.Numero_Publicacao AND Q.Genero = O.Genero)
ORDER BY Q.MAX_PUB DESC;


/* 16 - Alterar a obra "Discurso do Método" para gênero político */

SELECT ID_Obra, Titulo_Obra, Genero 
FROM Obra
WHERE Titulo_Obra = "Discurso do Método";

UPDATE Obra
SET Genero = "Política"
WHERE ID_Obra = 29 OR Titulo_Obra = "Discurso do Método";

/* 17 - Alterar o bairro do usuario "Alberto Roberto" de 'IAPI' para 'Mooca' */

DESC Usuario;

SELECT ID_Usuario, Nome_Usuario, Bairro
FROM Usuario; 

SELECT ID_Usuario, Nome_Usuario, Bairro
FROM Usuario
WHERE Nome_Usuario = "Alberto Roberto";

UPDATE Usuario
SET Bairro = "Mooca"
WHERE Nome_Usuario = "Alberto Roberto" OR ID_Usuario = 25;

SELECT ID_Usuario, Nome_Usuario, Bairro
FROM Usuario
WHERE Nome_Usuario = "Alberto Roberto";

/* 18 - Alterar a quantidade da obras 'Filho Nativo', 'Vidas Secas' e 'Dom Casmurro' 
(Retirar uma unidade de cada obra em estoque)*/

DESC Estoque;

SELECT E.ID_Estoque, E.ID_Obra, O.Titulo_Obra, E.Quantidade_Livro 
FROM Estoque E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
WHERE Titulo_Obra = 'Filho Nativo' OR Titulo_Obra = 'Vidas Secas' OR Titulo_Obra = 'Dom Casmurro';


UPDATE Estoque
SET Quantidade_Livro = (Quantidade_Livro - 1)
WHERE ID_Estoque = 18;
 
UPDATE Estoque
SET Quantidade_Livro = (Quantidade_Livro - 1)
WHERE ID_Estoque = 28; 

UPDATE Estoque
SET Quantidade_Livro = (Quantidade_Livro - 1)
WHERE ID_Estoque = 23;

/* 19 - Inserir dados de 5 usuarios */

DESC Usuario;

INSERT INTO Usuario VALUES ('31','Alfredo Tenttoni','Rua Amazonas 58','Pirai','65495421','02170251','29426487532');
INSERT INTO Usuario VALUES (32,'Cindy Crall','Rua Ipiranga 123','Vila Cristal',58466577,02182637,12214765549);
INSERT INTO Usuario VALUES (33,'Rubens Pardo','Avenida dos Mongos 51','Campo Grande',51848978,52412365,65458647298);
INSERT INTO Usuario VALUES (34,'Carlos Pracidelli','Travessa dos irmãos 48','Cotia',89457986,23124005,34125165175);
INSERT INTO Usuario VALUES (35,'Ernesto Coimbra','Avenida Ampére 414','Jardim Elvira',58442654,05728368,19310721435);

/* 20 - Verificar se existe duplicidade de usuarios */

DESC Usuario;

SELECT ID_Usuario, Nome_Usuario, CPF FROM Usuario ORDER BY Nome_Usuario; 

SELECT Nome_Usuario 
FROM Usuario 
GROUP BY Nome_Usuario
HAVING COUNT(Nome_Usuario) > 1;

SELECT CPF 
FROM Usuario 
GROUP BY CPF
HAVING COUNT(CPF) > 1;

/* 21 - Excluir registros dos usuarios duplicados*/

SELECT Nome_Usuario, ID_Usuario 
FROM Usuario 
GROUP BY Nome_Usuario
HAVING COUNT(Nome_Usuario) > 1;

DELETE FROM Usuario
WHERE ID_Usuario = 32;

DELETE FROM Usuario
WHERE ID_Usuario = 35; 

/* 22 - Inserir valor individual de cada obra -> Adc Valor_Livro na tabela Obra 
(Definir o tipo de dado e o valor de cada titulo) */

DESC Obra;

ALTER TABLE Obra
ADD Valor_Livro FLOAT(7,2); 

/*INSERT INTO Obra(Valor_Livro) VALUES (90.00);*/

UPDATE Obra
SET Valor_Livro = 90.00
WHERE ID_Obra = 1;

UPDATE Obra
SET Valor_Livro = 55.00
WHERE ID_Obra = 2;

UPDATE Obra
SET Valor_Livro = 20.00
WHERE ID_Obra = 3;

SELECT ID_Obra, Valor_Livro FROM Obra;

/* 23 - Modificar o tipo de dado do campo Multa_Atraso da tabela Devolução de Varchar(2) para Varchar(3) */

DESC Devolucao;

ALTER TABLE Devolucao
MODIFY COLUMN Multa_Atraso VARCHAR(3);

/* 24 - Modificar os registros do campo Multa_Atraso da tabela Devolução 0 para não e 1 para SIM */

UPDATE Devolucao
SET Multa_Atraso = 'Não'
WHERE Multa_Atraso = 0;

UPDATE Devolucao
SET Multa_Atraso = 'SIM'
WHERE Multa_Atraso = 1;

UPDATE Devolucao
SET Multa_Atraso = 'SIM'
WHERE ID_Devolucao = 28;

SELECT ID_Devolucao, Multa_Atraso FROM Devolucao;

/* 25 - Excluir o campo Valor_livro da tabela Obra */

ALTER TABLE Obra
DROP Valor_Livro;

/* 26 - Listar todos os livros que já foram emprestados 
e os nomes dos funcionarios que autorizaram o emprestimo */

DESC Emprestimo;

SELECT E.ID_Emprestimo, O.Titulo_Obra, F.Nome_Funcionario
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Funcionario F
ON E.ID_Funcionario = F.ID_Funcionario
WHERE E.Data_Emprestimo IS NOT NULL
ORDER BY O.Titulo_Obra;

SELECT E.ID_Emprestimo, O.Titulo_Obra
FROM Obra O
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra;

/* 27 - Listar todos os livros que já foram Devolvidos 
e o valor total de cada livro */

DESC Devolucao;
DESC Estoque;

SELECT D.ID_Devolucao, O.Titulo_Obra, E.Valor_Unitario
FROM Devolucao D
INNER JOIN Obra O
ON D.ID_Obra =  O.ID_Obra
INNER JOIN Estoque E
ON E.ID_Estoque = D.ID_Estoque
WHERE D.Data_Devolucao IS NOT NULL;

/* 28 - Listar todos os Usuarios que realizaram emprestimo com a data de entrega para o dia 21/08/2011 */

SELECT E.Data_Entrega, U.Nome_Usuario
FROM Emprestimo E
INNER JOIN Usuario U
ON E.ID_Usuario = U.ID_Usuario;

SELECT E.Data_Entrega, U.Nome_Usuario
FROM Emprestimo E
INNER JOIN Usuario U
ON E.ID_Usuario = U.ID_Usuario
WHERE E.Data_Entrega = '2011-08-21';

/* 29 - Listar todos as obras que tiveram a data de publicacao menor que 04/03/2013, com a quantidade 
de cada livro e o seu valor */

SELECT Data_Publicacao, Titulo_Obra
FROM Obra;

SELECT O.Data_Publicacao, O.Titulo_Obra, E.Quantidade_Livro, E.Valor_Unitario
FROM Obra O
INNER JOIN Estoque E
ON O.ID_Obra = E.ID_Obra
WHERE O.Data_Publicacao < '2013-03-04'
ORDER BY O.Data_Publicacao;

/* 30 - Listar todos os funcionarios, com seus respectivos cargos e salarios */

DESC Funcionario;
DESC Cargo;

SELECT F.Nome_Funcionario, C.Nome_Cargo, C.Salario
FROM Funcionario F
INNER JOIN Cargo C
ON F.ID_Cargo = C.ID_Cargo;

/* 31 - Listar todos os livros com os nomes dos autores, nomes das editoras e qdd de livros em estoque */

SELECT O.Titulo_Obra, A.Nome_Autor, E.Nome_Editora, Es.Quantidade_Livro
FROM Obra O
INNER JOIN Autor A
ON O.ID_Autor = A.ID_Autor
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora
INNER JOIN Estoque Es 
ON Es.ID_Obra = O.ID_Obra;

/* 32 - Lista de todos os funcionarios da biblioteca e seus respectivos departamentos */

DESC Departamento;

SELECT F.Nome_Funcionario, D.Nome_Departamento
FROM Funcionario F
INNER JOIN Departamento D 
ON F.ID_Departamento = D.ID_Departamento; 

/* 33 - Criar uma Visão que retorne o livro e o valor dele */

SELECT O.Titulo_Obra, E.Valor_Unitario
FROM Obra O
INNER JOIN Estoque E
ON E.ID_Obra = O.ID_Obra;

CREATE VIEW Livro_Preço AS 
SELECT O.Titulo_Obra, E.Valor_Unitario
FROM Obra O
INNER JOIN Estoque E
ON E.ID_Obra = O.ID_Obra;

SELECT * FROM Livro_Preço;

/* 34 - Listar cod do livro, nome do livro cujo valor do livro seja maior que R$ 90,00 */

SELECT E.ID_Obra, O.Titulo_Obra, E.Valor_Unitario
FROM Obra O
INNER JOIN Estoque E 
ON E.ID_Obra = O.ID_Obra;

SELECT E.ID_Obra, O.Titulo_Obra, E.Valor_Unitario
FROM Obra O
INNER JOIN Estoque E 
ON E.ID_Obra = O.ID_Obra
WHERE E.Valor_Unitario > '90'
ORDER BY O.ID_Obra;

/* 35 - Atualizar o salario do auxiliar financeiro para 12% sobre seu salario atual */

UPDATE Cargo
SET Salario = (Salario*1.12)
Where Nome_Cargo = 'Auxiliar Financeiro' OR ID_Cargo = 9;

UPDATE Cargo
SET Salario = (1904 - (1700*0.12))
Where ID_Cargo = 9;

SELECT * FROM Cargo;

/* 36 - Atualizar a data de admissao da funcionaria Alice Meire pra ultimo dia do mes atual (31/10/2021) */

SELECT Nome_Funcionario, Data_Admissao
FROM Funcionario
WHERE Nome_Funcionario = 'Alice Meire';

UPDATE Funcionario
SET Data_Admissao = '1966-10-31'
WHERE Nome_Funcionario = 'Alice Meire';

    SELECT Nome_Funcionario, Data_Admissao
    FROM Funcionario
    WHERE Nome_Funcionario = 'Alice Meire';

/* 37 - Mostrar todos os dados da tabela obra */

SELECT * FROM Obra;

/* 38 - Listar todos os funcionarios da biblioteca com cod, nome e departamento,
 classificando a ordem pelo nome */

SELECT F.ID_Funcionario, F.Nome_Funcionario, D.Nome_Departamento
FROM Funcionario F
INNER JOIN Departamento D 
ON F.ID_Departamento = D.ID_Departamento
ORDER BY F.Nome_Funcionario; 

/* 39 - Listar quantidade de logradouro de usuarios agrupados por numero do CEP */

SELECT COUNT(Logradouro)
FROM Usuario;

SELECT COUNT(Logradouro)
FROM Usuario
GROUP BY CEP;

SELECT COUNT(Logradouro), Logradouro, ID_Usuario, CEP
FROM Usuario
GROUP BY CEP
ORDER BY CEP;

SELECT Logradouro
FROM Usuario 
GROUP BY CEP
HAVING COUNT(CEP) > 1;

/* 40 - Listar quantidade de endereços agrupados por usuario */

SELECT Nome_Usuario, Logradouro
FROM Usuario
ORDER BY Nome_Usuario;

SELECT COUNT(Logradouro)
FROM Usuario
GROUP BY Nome_Usuario;

SELECT Logradouro
FROM Usuario 
GROUP BY Nome_Usuario
HAVING COUNT(Nome_Usuario) > 1;

/* 41 - Lista dos funcionarios da recepcao que nao prestaram atendimento até o presente momento */
/* INNER QUERY                                     
                                                    REVISAR                                      */
SELECT Nome_Departamento 
FROM Departamento
WHERE ID_Departamento = '7' OR Nome_Departamento = 'Recepção';

SELECT F.Nome_Funcionario, E.ID_Emprestimo
FROM Funcionario F
LEFT JOIN Emprestimo E
ON F.ID_Funcionario = E.ID_Funcionario
WHERE F.ID_Cargo = 12 AND E.ID_Emprestimo IS NULL;


SELECT F.Nome_Funcionario
FROM Funcionario F
LEFT JOIN Emprestimo E
ON F.ID_Funcionario = E.ID_Funcionario
INNER JOIN Departamento DP
ON DP.ID_Departamento = F.ID_Departamento
WHERE DP.ID_Departamento = 7 AND
F.ID_Funcionario <> '11' AND F.ID_Funcionario <> '8' AND F.ID_Funcionario <> '1';


SELECT F.Nome_Funcionario
FROM Funcionario F
LEFT JOIN Devolucao D
ON D.ID_Funcionario = F.ID_Funcionario
INNER JOIN Departamento DP
ON DP.ID_Departamento = F.ID_Departamento
WHERE DP.ID_Departamento = 7 AND
F.ID_Funcionario <> '11' AND F.ID_Funcionario <> '8' AND F.ID_Funcionario <> '1';


SELECT F.Nome_Funcionario
FROM Funcionario F
LEFT JOIN Reserva R 
ON R.ID_Funcionario = F.ID_Funcionario
INNER JOIN Departamento DP
ON DP.ID_Departamento = F.ID_Departamento
WHERE DP.ID_Departamento = 7 AND
F.ID_Funcionario <> '11' AND F.ID_Funcionario <> '8' AND F.ID_Funcionario <> '1';


SELECT F.Nome_Funcionario
FROM Funcionario F
INNER JOIN Emprestimo E
ON F.ID_Funcionario = E.ID_Funcionario
INNER JOIN Devolucao D
ON D.ID_Funcionario = F.ID_Funcionario
INNER JOIN Reserva R 
ON R.ID_Funcionario = F.ID_Funcionario
INNER JOIN Departamento DP
ON DP.ID_Departamento = F.ID_Departamento
WHERE F.ID_Funcionario <> '11' AND F.ID_Funcionario <> '8' AND F.ID_Funcionario <> '1';


DESC Funcionario;

SELECT * FROM Funcionario;

INSERT INTO Funcionario VALUES ('50','12','7','Fernando Juca','2021-08-23', '9999-01-01');


SELECT F.ID_Funcionario, F.Nome_Funcionario, D.Nome_Departamento, D.ID_Departamento, C.Nome_Cargo, C.ID_Cargo
FROM Funcionario F
INNER JOIN Departamento D 
ON F.ID_Departamento = D.ID_Departamento
INNER JOIN Cargo C
ON C.ID_Cargo = D.ID_Cargo;

/* 42 - Busca de informacoes de todas as obras que foram reservadas 
no dia 18/08/2011 as 15:00 e o nome do responsavel pela reserva */

DESC Obra;

SELECT O.Titulo_Obra, R.Data_Reserva, R.Hora_Reserva
FROM Obra O
INNER JOIN Reserva R
ON R.ID_Obra = O.ID_Obra;

SELECT O.Titulo_Obra, R.Data_Reserva, R.Hora_Reserva, F.Nome_Funcionario
FROM Obra O
INNER JOIN Reserva R
ON R.ID_Obra = O.ID_Obra
INNER JOIN Funcionario F
ON F.ID_Funcionario = R.ID_Funcionario;

SELECT O.Titulo_Obra, R.Data_Reserva, R.Hora_Reserva, F.Nome_Funcionario
FROM Obra O
INNER JOIN Reserva R
ON R.ID_Obra = O.ID_Obra
INNER JOIN Funcionario F
ON F.ID_Funcionario = R.ID_Funcionario
WHERE Data_Reserva = '2011-08-18' AND Hora_Reserva = '15:00:00';

/* 43 - Informacoes de quando a usuaria Emily Mall e Whitney Cinse pegaram livro emprestado
qual livro foi pego, e o valor unitario dos livros pegos */

SELECT U.Nome_Usuario, E.Data_Emprestimo, E.Hora_Emprestimo, O.Titulo_Obra, Es.Valor_Unitario
FROM Emprestimo E
INNER JOIN Usuario U
ON E.ID_Usuario = U.ID_Usuario
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Estoque Es
ON Es.ID_Obra = E.ID_Obra;

SELECT U.Nome_Usuario, E.Data_Emprestimo, E.Hora_Emprestimo, O.Titulo_Obra, Es.Valor_Unitario
FROM Emprestimo E
INNER JOIN Usuario U
ON E.ID_Usuario = U.ID_Usuario
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Estoque Es
ON Es.ID_Obra = E.ID_Obra
WHERE U.Nome_Usuario = 'Emily Mall' OR U.Nome_Usuario = 'Whitney Cinse';

/* 44 - Relacionar a primeira pessoa que reservou(Reserva), pegou emprestado(Emprestimo) e 
entregou(Devolucao) um livro e as respectivas informacoes dos usuarios (completa)  */

SELECT MIN(R.Data_Reserva), MIN(R.Hora_Reserva)
FROM Reserva R;

SELECT MIN(E.Data_Emprestimo), MIN(E.Hora_Emprestimo)
FROM Emprestimo E;

SELECT MIN(D.Data_Devolucao), MIN(D.Hora_Devolucao)
FROM Devolucao D;

SELECT U.Nome_Usuario, R.Data_Reserva
FROM Usuario U
INNER JOIN Reserva R
ON U.ID_Usuario = R.ID_Usuario
ORDER BY R.Data_Reserva ASC, R.Hora_Reserva LIMIT 1;

SELECT U.Nome_Usuario, E.Data_Emprestimo
FROM Usuario U
INNER JOIN Emprestimo E
ON U.ID_Usuario =  E.ID_Usuario
ORDER BY E.Data_Emprestimo ASC, E.Hora_Emprestimo LIMIT 1;

SELECT U.Nome_Usuario, D.Data_Devolucao
FROM Usuario U
INNER JOIN Devolucao D
ON U.ID_Usuario = D.ID_Usuario
ORDER BY D.Data_Devolucao ASC, D.Hora_Devolucao LIMIT 1;

SELECT U.Nome_Usuario, R.Data_Reserva, E.Data_Emprestimo, D.Data_Devolucao
FROM Usuario U
INNER JOIN Reserva R
ON U.ID_Usuario = R.ID_Usuario
INNER JOIN Emprestimo E
ON U.ID_Usuario =  E.ID_Usuario
INNER JOIN Devolucao D
ON U.ID_Usuario = D.ID_Usuario
ORDER BY R.Data_Reserva ASC, R.Hora_Reserva, 
         E.Data_Emprestimo ASC, E.Hora_Emprestimo,
         D.Data_Devolucao ASC, D.Hora_Devolucao
         LIMIT 1;

SELECT * FROM Usuario U
INNER JOIN(
SELECT R.Data_Reserva, E.Data_Emprestimo, D.Data_Devolucao, R.ID_Usuario
FROM Reserva R
INNER JOIN Emprestimo E
ON R.ID_Usuario =  E.ID_Usuario
INNER JOIN Devolucao D
ON E.ID_Usuario = D.ID_Usuario
ORDER BY R.Data_Reserva ASC, R.Hora_Reserva, 
         E.Data_Emprestimo ASC, E.Hora_Emprestimo,
         D.Data_Devolucao ASC, D.Hora_Devolucao
         LIMIT 1) AS VW
ON VW.ID_Usuario = U.ID_Usuario;

/* 45 - Quantas obras cada editora tem na biblioteca */

SELECT O.ID_Editora, E.Nome_Editora
FROM Obra O
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora;

SELECT O.ID_Editora, E.Nome_Editora, COUNT(E.Nome_Editora) AS 'Qdd_obras_por_editora'
FROM Obra O
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora
GROUP BY O.ID_Editora
HAVING COUNT(E.Nome_Editora);

SELECT E.Nome_Editora, COUNT(E.Nome_Editora) AS 'Qdd_obras_por_editora'
FROM Obra O
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora
GROUP BY O.ID_Editora
HAVING COUNT(O.ID_Editora);

SELECT E.Nome_Editora, COUNT(E.Nome_Editora) AS 'Qdd_obras_por_editora'
FROM Obra O
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora
GROUP BY E.Nome_Editora
HAVING COUNT(E.Nome_Editora);

SELECT E.Nome_Editora, COUNT(E.Nome_Editora) AS 'Qdd_obras_por_editora'
FROM Obra O
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora
GROUP BY E.Nome_Editora
HAVING COUNT(O.ID_Editora);



/* 46 - Mostrar todos os livros que nao foram devolvidos antes do dia 03/02/2013
		quantidade de dias em atraso e para cada dia aplicar multa de R$ 5 e mostrar o nome do
		usuario e do livro pego e o total a receber pela biblioteca  


		FALTA FAZER A DIFERENCA DE DIAS (03/02/2013 - 02/02/2013) = 1 DIA E O CALCULO DA MULTA*/


SELECT E.ID_Emprestimo, E.Data_Entrega, D.Data_Devolucao, D.ID_Devolucao, O.Titulo_Obra, U.Nome_Usuario
FROM Emprestimo E
LEFT JOIN Devolucao D
ON E.ID_Emprestimo = D.ID_Emprestimo
INNER JOIN Obra O
ON O.ID_Obra = E.ID_Obra
INNER JOIN Usuario U
ON U.ID_Usuario = E.ID_Usuario;

SELECT E.ID_Emprestimo, E.Data_Entrega, D.Data_Devolucao, D.ID_Devolucao, O.Titulo_Obra, U.Nome_Usuario
FROM Emprestimo E
LEFT JOIN Devolucao D
ON E.ID_Emprestimo = D.ID_Emprestimo
INNER JOIN Obra O
ON O.ID_Obra = E.ID_Obra
INNER JOIN Usuario U
ON U.ID_Usuario = E.ID_Usuario
WHERE D.ID_Devolucao IS NULL; 

SELECT E.ID_Emprestimo,E.Data_Entrega, '2013-02-03' AS 'Data_Ex', D.Data_Devolucao, O.Titulo_Obra, U.Nome_Usuario, '1' AS 'dias_atraso', '5' AS 'Multa_dia', (1*5) AS 'Total_multa'
FROM Emprestimo E
LEFT JOIN Devolucao D
ON E.ID_Emprestimo = D.ID_Emprestimo
INNER JOIN Obra O
ON O.ID_Obra = E.ID_Obra
INNER JOIN Usuario U
ON U.ID_Usuario = E.ID_Usuario
WHERE ID_Devolucao IS NULL AND E.Data_Entrega < '2013-02-03'; 

SELECT E.ID_Emprestimo,E.Data_Entrega, '2013-02-03' AS 'Data_Ex', D.Data_Devolucao, O.Titulo_Obra, U.Nome_Usuario, ('Data_Ex' - E.Data_Entrega) AS 'dias_atraso', '5' AS 'Multa_dia', (1*5) AS 'Total_multa'
FROM Emprestimo E
LEFT JOIN Devolucao D
ON E.ID_Emprestimo = D.ID_Emprestimo
INNER JOIN Obra O
ON O.ID_Obra = E.ID_Obra
INNER JOIN Usuario U
ON U.ID_Usuario = E.ID_Usuario
WHERE ID_Devolucao IS NULL AND E.Data_Entrega < '2013-02-03';


/* 47- Listar todos os Usuarios que morem numa avenida. Exibir o nome e logradouro em ordem de cpf
do maior para o menor */

SELECT ID_Usuario, Logradouro, Nome_Usuario, CPF
FROM Usuario
WHERE Logradouro LIKE 'Avenida%'
ORDER BY CPF DESC;

/* 48- Listar todos os livros que foram emprestados mais de uma vez entre os anos de 2011 ate 2013
agrupados pelo nome do livro */

SELECT ID_Obra, Data_Emprestimo
FROM Emprestimo
ORDER BY ID_Obra;

SELECT ID_Obra
FROM Emprestimo 
GROUP BY ID_Obra
HAVING COUNT(ID_Obra) > 1;

SELECT ID_Obra, Data_Emprestimo
FROM Emprestimo
WHERE ID_Obra = 27;


SELECT E.ID_Obra, O.Titulo_Obra, COUNT(E.ID_Obra) AS 'Qdd_emprestimos'
FROM Obra O
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra
WHERE (E.Data_Emprestimo BETWEEN '2011-01-01' AND '2013-12-31')
GROUP BY O.Titulo_Obra
HAVING COUNT(E.ID_Obra) > 1; 


/* 49- Verificar o valor medio dos livros e verificar quais sao os que estao abaixo dessa media, 
referente a devolucao e emprestimo */

SELECT Valor_Unitario
FROM Estoque;

SELECT AVG(Valor_Unitario) AS 'Valor_medio_livros(R$)'
FROM Estoque;

SELECT TRUNCATE (AVG(Valor_Unitario),2) AS 'Valor_medio_livros(R$)'
FROM Estoque;

SELECT E.ID_Obra, O.Titulo_Obra, E.Valor_Unitario
FROM Estoque E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
WHERE E.Valor_Unitario < (SELECT TRUNCATE (AVG(E.Valor_Unitario),2) AS 'Valor_medio_livros(R$)'
FROM Estoque E)
ORDER BY E.ID_Obra;

SELECT O.Titulo_Obra, E.Valor_Unitario AS 'Abaixo_valor_medio'
FROM Estoque E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Devolucao D
ON D.ID_Obra = O.ID_Obra
INNER JOIN Emprestimo Em
ON Em.ID_Obra = O.ID_Obra
WHERE E.Valor_Unitario < (SELECT TRUNCATE (AVG(E.Valor_Unitario),2) AS 'Valor_medio_livros(R$)'
FROM Estoque E)
ORDER BY Em.ID_Obra;

SELECT ID_Obra
from Devolucao
ORDER BY ID_Obra;

SELECT ID_Obra
from Emprestimo
ORDER BY ID_Obra;

/* 50 - Verificar qual a media do salario dos funcionarios e quem sao os que ganham mais que a media */

SELECT TRUNCATE(AVG(Salario),2)
FROM Cargo;

SELECT F.Nome_Funcionario, C.Salario
FROM Funcionario F
INNER JOIN Cargo C
ON F.ID_Cargo = C.ID_Cargo;

SELECT F.Nome_Funcionario, C.Salario
FROM Funcionario F
INNER JOIN Cargo C
ON F.ID_Cargo = C.ID_Cargo
WHERE C.Salario > (SELECT TRUNCATE(AVG(C.Salario),2)
FROM Cargo C);

/* 51 - Mostrar todos os usuarios com cadastro na biblioteca e os que nunca tiverem levado livro, 
mostrar o nome em letras maiusculas */

SELECT U.ID_Usuario AS 'Usu_cadastrado', U.Nome_Usuario, E.ID_Usuario AS 'Usu_emprestimo'  
FROM Usuario U
LEFT JOIN Emprestimo E
ON U.ID_Usuario = E.ID_Usuario;

SELECT UCASE (U.Nome_Usuario) AS 'Nomes_Cadastrados', U.ID_Usuario AS 'Usu_cadastrado', E.ID_Usuario AS 'Usu_emprestimo'  
FROM Usuario U
LEFT JOIN Emprestimo E
ON U.ID_Usuario = E.ID_Usuario
WHERE E.ID_Usuario IS NULL 
UNION 
SELECT LCASE (U.Nome_Usuario) AS 'Nomes_Cadastrados', U.ID_Usuario AS 'Usu_cadastrado', E.ID_Usuario AS 'Usu_emprestimo'  
FROM Usuario U
LEFT JOIN Emprestimo E
ON U.ID_Usuario = E.ID_Usuario
WHERE E.ID_Usuario IS NOT NULL; 

/* 52 - Verificar todos os usuarios que ja pegaram um livro e ordenar pelo CEP */

SELECT U.ID_Usuario AS 'Usu_cadastrado', U.Nome_Usuario, E.ID_Usuario AS 'Usu_emprestimo', U.CEP   
FROM Usuario U
LEFT JOIN Emprestimo E
ON U.ID_Usuario = E.ID_Usuario
WHERE E.ID_Usuario IS NOT NULL
ORDER BY U.CEP;

/* 53 - Listar todos os livros que ja foram reservados e emprestados, quantos estao disponiveis no momento
 e classificar por genero */

 SELECT R.ID_Obra, O.Titulo_Obra, Es.Quantidade_Livro AS 'Disponiveis_Momento', O.Genero
 FROM Reserva R
 INNER JOIN Obra O
 ON R.ID_Obra = O.ID_Obra
 INNER JOIN Emprestimo E
 ON E.ID_Obra = O.ID_Obra
 INNER JOIN Estoque Es
 ON Es.ID_Obra = O.ID_Obra
 ORDER BY O.Genero;

 /* 54 - Qual horario a biblioteca tem mais movimentacao e qual horario tem menos movimentacao
         avaliar todas as horas de devolucao, emprestimo e reserva  

         								  REFAZER                                       */

SELECT R.Hora_Reserva
FROM Reserva R;

SELECT R.Hora_Reserva
FROM Reserva R
WHERE Hora_Reserva BETWEEN '07:00:00' AND '19:00:00';

SELECT R.Hora_Reserva
FROM Reserva R
WHERE R.Hora_Reserva LIKE '15:%' AND (R.Hora_Reserva BETWEEN '07:00:00' AND '19:00:00');

SELECT R.Hora_Reserva
FROM Reserva R
GROUP BY Hora_Reserva
HAVING COUNT(Hora_Reserva)<=1;

SELECT R.Hora_Reserva
FROM Reserva R
GROUP BY Hora_Reserva
HAVING COUNT(Hora_Reserva)>2;

SELECT R.Hora_Reserva AS 'Maior_Movimento_Reserva'
FROM Reserva R
GROUP BY Hora_Reserva
HAVING COUNT(Hora_Reserva LIKE '15:%') > 3;



SELECT E.Hora_Emprestimo
FROM Emprestimo E;

SELECT E.Hora_Emprestimo
FROM Emprestimo E
WHERE Hora_Emprestimo BETWEEN '07:00:00' AND '19:00:00';

SELECT E.Hora_Emprestimo
FROM Emprestimo E
GROUP BY Hora_Emprestimo 
HAVING COUNT(Hora_Emprestimo)<=1;

SELECT E.Hora_Emprestimo AS 'Maior_Movimento_Emprestimo'
FROM Emprestimo E
GROUP BY Hora_Emprestimo 
HAVING COUNT(Hora_Emprestimo)>4;


SELECT D.Hora_Devolucao
FROM Devolucao D;

SELECT D.Hora_Devolucao
FROM Devolucao D
GROUP BY Hora_Devolucao
HAVING COUNT(Hora_Devolucao)<=1;

SELECT D.Hora_Devolucao AS 'Maior_Movimento_Devolucao'
FROM Devolucao D
GROUP BY Hora_Devolucao
HAVING COUNT(Hora_Devolucao)>4;




SELECT R.Hora_Reserva, Hora_Emprestimo, Hora_Devolucao
FROM Reserva R
INNER JOIN Emprestimo E
ON 
INNER JOIN Devolucao D
ON


 /* 55 - Quais sao os 3 autores que tem mais livros lidos no ano de 2012 e 2013
  e os 2 que tem menos obras lidas */

SELECT ID_Obra
FROM Emprestimo;


SELECT A.Nome_Autor, O.Titulo_Obra, A.ID_Autor, E.Data_Emprestimo
FROM Autor A
INNER JOIN Obra O
ON A.ID_Autor = O.ID_Autor
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra
WHERE E.Data_Emprestimo BETWEEN '2012-01-01' AND '2013-12-31';

SELECT A.Nome_Autor, A.ID_Autor, COUNT(A.ID_Autor) AS 'Maximo'
FROM Autor A
INNER JOIN Obra O
ON A.ID_Autor = O.ID_Autor
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra
WHERE E.Data_Emprestimo BETWEEN '2012-01-01' AND '2013-12-31'
GROUP BY A.ID_Autor 
ORDER BY Maximo DESC LIMIT 3;

SELECT A.Nome_Autor, A.ID_Autor, COUNT(A.ID_Autor) AS 'Minimo'
FROM Autor A
INNER JOIN Obra O
ON A.ID_Autor = O.ID_Autor
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra
WHERE E.Data_Emprestimo BETWEEN '2012-01-01' AND '2013-12-31'
GROUP BY A.ID_Autor 
ORDER BY Minimo ASC LIMIT 3;


/* 56 - Exibir lista de todos os livros por recepcionista e o total de emprestimos e devol que cada um fez
	
							FALTA SOMAR AS 2 QUERY'S  - FEITO !!!!                                     */

SELECT O.Titulo_Obra, E.ID_Emprestimo, F.Nome_Funcionario
FROM Obra O
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra
INNER JOIN Funcionario F
ON E.ID_Funcionario = F.ID_Funcionario
ORDER BY F.Nome_Funcionario;

SELECT F.Nome_Funcionario, COUNT(F.Nome_Funcionario) AS 'Total_Emprestimo'
FROM Obra O
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra
INNER JOIN Funcionario F
ON E.ID_Funcionario = F.ID_Funcionario
GROUP BY Nome_Funcionario;


SELECT O.Titulo_Obra, D.ID_Devolucao, F.Nome_Funcionario 
FROM Obra O
INNER JOIN Devolucao D
ON O.ID_Obra = D.ID_Obra
INNER JOIN Funcionario F
ON D.ID_Funcionario = F.ID_Funcionario
ORDER BY F.Nome_Funcionario;

SELECT F.Nome_Funcionario, COUNT(F.Nome_Funcionario) AS 'Total_Devolucao' 
FROM Obra O
INNER JOIN Devolucao D
ON O.ID_Obra = D.ID_Obra
INNER JOIN Funcionario F
ON D.ID_Funcionario = F.ID_Funcionario
GROUP BY Nome_Funcionario;

DROP VIEW Total_emp_recepcionista;

CREATE VIEW Total_emp_recepcionista AS
SELECT F.Nome_Funcionario, COUNT(F.Nome_Funcionario) AS 'Total_Emprestimo'
FROM Obra O
INNER JOIN Emprestimo E
ON O.ID_Obra = E.ID_Obra
INNER JOIN Funcionario F
ON E.ID_Funcionario = F.ID_Funcionario
GROUP BY Nome_Funcionario;

SELECT * FROM Total_emp_recepcionista;

DROP VIEW Total_dev_recepcionista;

CREATE VIEW Total_dev_recepcionista AS
SELECT F.Nome_Funcionario, COUNT(F.Nome_Funcionario) AS 'Total_Devolucao' 
FROM Obra O
INNER JOIN Devolucao D
ON O.ID_Obra = D.ID_Obra
INNER JOIN Funcionario F
ON D.ID_Funcionario = F.ID_Funcionario
GROUP BY Nome_Funcionario;

SELECT * FROM Total_dev_recepcionista;

SELECT TE.Nome_Funcionario, TE.Total_Emprestimo, TD.Total_Devolucao, (Total_Emprestimo + Total_Devolucao) AS 'Total_Atend_funcionario'
FROM Total_emp_recepcionista TE
INNER JOIN Total_dev_recepcionista TD
ON TE.Nome_Funcionario = TD.Nome_Funcionario;


/* 57 - Listar os usuarios que trabalham nas editoras por meio de endereco cadastrado
		mostrar nome, telefone e nome da editora que trabalha */

SELECT U.Nome_Usuario, U.Telefone, E.Nome_Editora 
FROM Usuario U
INNER JOIN Editora E
ON U.Logradouro = E.Logradouro;

/* 58 -  Criar uma visao que traga todos os livros e o preco da editora Leya */

SELECT Nome_Editora
FROM Editora
WHERE ID_Editora = 6 OR Nome_Editora = 'Leya';

SELECT O.Titulo_Obra, Es.Valor_Unitario, E.Nome_Editora
FROM Obra O
INNER JOIN Estoque Es
ON O.ID_Obra = Es.ID_Obra
INNER JOIN Editora E
ON E.ID_Editora = O.ID_Editora
WHERE E.Nome_Editora = 'Leya' OR E.ID_Editora = 6;

CREATE VIEW PRECOS_LEYA AS 
SELECT O.Titulo_Obra, Es.Valor_Unitario, E.Nome_Editora
FROM Obra O
INNER JOIN Estoque Es
ON O.ID_Obra = Es.ID_Obra
INNER JOIN Editora E
ON E.ID_Editora = O.ID_Editora
WHERE E.Nome_Editora = 'Leya' OR E.ID_Editora = 6;

SELECT * FROM PRECOS_LEYA;

/* 59 - A Editora saraiva aumentou em 16% o valor de seus livros, atualize os preços dos livros da editora
 na porcentagem designada 

 									PROCURAR ALTERNATIVA DE RESOLUCAO */

UPDATE Estoque
SET Valor_Unitario = (Valor_Unitario*1.16)
WHERE ID_Obra = 14 OR ID_Obra = 20 OR ID_Obra = 30;
		

SELECT E.Nome_Editora, Es.Valor_Unitario, O.Titulo_Obra, O.ID_Obra
FROM Obra O 
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora
INNER JOIN Estoque Es
ON O.ID_Obra = Es.ID_Obra
WHERE E.Nome_Editora = 'Saraiva' OR E.ID_Editora = 3;		

 SELECT E.Nome_Editora
 FROM Editora E
 INNER JOIN Obra O
 ON E.ID_Editora = O.ID_Obra
 WHERE E.Nome_Editora = 'Saraiva' OR E.ID_Editora = 3;


/* 60 - Verificar quais obras foram publicadas menos vezes, mostrar qual é o autor, 
		a editora e nome da obra */

SELECT A.Nome_Autor, E.Nome_Editora, O.Titulo_Obra, O.Numero_Publicacao
FROM Obra O
INNER JOIN Autor A
ON O.ID_Autor = A.ID_Autor
INNER JOIN Editora E
ON O.ID_Editora = E.ID_Editora
ORDER BY O.Numero_Publicacao ASC;


/* 61 - Relacionar todos os Nomes e CPF dos usuarios que tenham o CPF iniciado pela sequencia de numeros 193, 
inibir o restante dos numeros por '*' porem mostrar os 2 ultimos numeros */

SELECT Nome_Usuario, concat(substr(CPF, 1,3), '******',
                            substr(CPF, 10,11)) AS CPF
FROM Usuario
WHERE CPF LIKE '193%'; 

/* 62 - Gerar um relatorio da media de livros que sao emprestados em cada ano.
		A media de livros por editora e por autor
		Fazer um calculo de 20% de aumento em 3 anos 

										PESQUISAR OUTRA RESOLUCAO  / ARRUMAR                        */

SELECT E.ID_Emprestimo, E.Data_Emprestimo, O.Titulo_Obra
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
ORDER BY E.Data_Emprestimo;

SELECT '2011' AS 'ANO', COUNT(E.Data_Emprestimo) AS 'Qdd_emprestimo', (COUNT(E.Data_Emprestimo)*1.2) AS 'Qdd_emprestimo_3anos'
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra 
WHERE E.Data_Emprestimo LIKE '2011%'
UNION
SELECT '2012' AS 'ANO', COUNT(E.Data_Emprestimo) AS 'Qdd_emprestimo', (COUNT(E.Data_Emprestimo)*1.2) AS 'Qdd_emprestimo_3anos'
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra 
WHERE E.Data_Emprestimo LIKE '2012%'
UNION
SELECT '2013' AS 'ANO', COUNT(E.Data_Emprestimo) AS 'Qdd_emprestimo',(COUNT(E.Data_Emprestimo)*1.2) AS 'Qdd_emprestimo_3anos'
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra 
WHERE E.Data_Emprestimo LIKE '2013%';

SELECT E.Data_Emprestimo, O.Titulo_Obra, Ed.Nome_Editora
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Editora Ed
ON Ed.ID_Editora = O.ID_Editora
ORDER BY Ed.Nome_Editora;

SELECT Ed.Nome_Editora, COUNT(Ed.Nome_Editora) AS 'Qdd_Emp_Editora',(COUNT(Ed.Nome_Editora)*1.2) AS 'Qdd_Emp_Editora_3anos'
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Editora Ed
ON Ed.ID_Editora = O.ID_Editora
INNER JOIN Autor A
ON A.ID_Autor = O.ID_Autor
GROUP BY Ed.Nome_Editora
ORDER BY Qdd_Emp_Editora DESC;

SELECT E.Data_Emprestimo, O.Titulo_Obra, Ed.Nome_Editora, A.Nome_Autor
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Editora Ed
ON Ed.ID_Editora = O.ID_Editora
INNER JOIN Autor A
ON A.ID_Autor = O.ID_Autor
ORDER BY A.Nome_Autor;

SELECT A.Nome_Autor, COUNT(A.Nome_Autor) AS 'Qdd_Emp_Autor',(COUNT(A.Nome_Autor)*1.2) AS 'Qdd_Emp_Autor_3anos'
FROM Emprestimo E
INNER JOIN Obra O
ON E.ID_Obra = O.ID_Obra
INNER JOIN Editora Ed
ON Ed.ID_Editora = O.ID_Editora
INNER JOIN Autor A
ON A.ID_Autor = O.ID_Autor
GROUP BY A.Nome_Autor
ORDER BY Qdd_Emp_Autor DESC;

/* 63 - Gerar um relatorio de Obras com a quantidade e valores unitarios que estao no estoque
		criando no excel, em formato de tabela dinamica com as seguintes informacoes 

			Selecionar os Títulos das Obras da Tabela Obra e 
			na tabela Estoque selecionar a quantidade e o valor unitario de cada Obra
			Somar o total geral, mostrar planilha e grafico no resultado final
		    */

SELECT (Quantidade_Livro * Valor_Unitario) AS 'Valor_Total_obra_Est'
FROM Estoque;

SELECT (E.Quantidade_Livro * E.Valor_Unitario) AS 'Valor_Total_obra_Est'
FROM Estoque E;

SELECT O.Titulo_Obra, E.Quantidade_Livro, E.Valor_Unitario, (E.Quantidade_Livro * E.Valor_Unitario) AS 'Valor_Total_obra_Est'
FROM Obra O
INNER JOIN Estoque E
ON E.ID_Obra =  O.ID_Obra;

CREATE VIEW Valor_em_Estoque AS
SELECT O.Titulo_Obra, E.Quantidade_Livro, E.Valor_Unitario, (E.Quantidade_Livro * E.Valor_Unitario) AS 'Valor_Total_obra_Est'
FROM Obra O
INNER JOIN Estoque E
ON E.ID_Obra =  O.ID_Obra;

SELECT * FROM Valor_em_Estoque;
	  
SELECT SUM(Valor_Total_obra_Est) AS 'Valor_Total_Geral_Estoque'
FROM Valor_em_Estoque;

	  