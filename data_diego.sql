set global local_infile=1;
set global local_infile=true;

SHOW DATABASES;

USE BIBLIOTECA;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Editora.csv" INTO TABLE Editora
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Editora, Nome_Editora, Logradouro, Cidade);

SELECT*FROM EDITORA;


LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Autor.csv" INTO TABLE Autor
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Autor, Nome_Autor);

SELECT*FROM AUTOR;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Obra.csv" INTO TABLE Obra
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Obra, ID_Editora, ID_Autor, Titulo_Obra, Numero_Publicacao, Genero, @Data_Publicacao)
set Data_Publicacao = STR_TO_DATE(@Data_Publicacao,'%d/%m/%Y');

SELECT*FROM OBRA;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Estoque.csv" INTO TABLE Estoque
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Estoque, ID_Obra, Quantidade_Livro , Valor_Unitario);

SELECT*FROM ESTOQUE;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Usuario.csv" INTO TABLE Usuario
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Usuario, Nome_Usuario, Logradouro, Bairro, @Telefone, @CEP, @CPF)
set Telefone = replace(@Telefone, '-', ''), 
CEP = replace(@CEP, '-', ''),
CPF = replace(replace(@CPF, '-', ''), '.', '');

SELECT*FROM USUARIO;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Cargo.csv" INTO TABLE Cargo
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Cargo, Nome_Cargo, Salario);

SELECT*FROM CARGO;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Departamento.csv" INTO TABLE Departamento
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Departamento, ID_Cargo, Nome_Departamento);

SELECT*FROM DEPARTAMENTO;


LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Funcionario.csv" INTO TABLE Funcionario
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Funcionario, Nome_Funcionario, ID_Departamento, @Data_Admissao, @Data_Demissao, ID_Cargo)
set Data_Admissao = STR_TO_DATE(@Data_Admissao,'%d/%m/%Y'),
Data_Demissao = STR_TO_DATE(@Data_Demissao,'%d/%m/%Y');

SELECT*FROM Funcionario;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Emprestimo.csv" INTO TABLE Emprestimo
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Emprestimo, ID_Funcionario, ID_Usuario, ID_Estoque, ID_Obra, @Data_Emprestimo, Hora_Emprestimo, @Data_Entrega)
set Data_Emprestimo = STR_TO_DATE(@Data_Emprestimo,'%d/%m/%Y'),
Data_Entrega = STR_TO_DATE(@Data_Entrega,'%d/%m/%Y');

SELECT*FROM Emprestimo;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Devolucao.csv" INTO TABLE Devolucao
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Devolucao, ID_Funcionario, ID_Emprestimo, ID_Usuario, ID_Estoque, ID_Obra, @Data_Devolucao, Hora_Devolucao, Multa_Atraso)
set Data_Devolucao = STR_TO_DATE(@Data_Devolucao,'%d/%m/%Y');

SELECT*FROM Devolucao;

LOAD DATA LOCAL INFILE "C:/Users/Diego/Desktop/LEEGA/Esteira_de_conhecimento_SQL/Reserva.csv" INTO TABLE Reserva
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID_Reserva, ID_Emprestimo,  ID_Funcionario, ID_Usuario, ID_Estoque, ID_Obra, Status_Livro, @Data_Reserva, Hora_Reserva)
set Data_Reserva = STR_TO_DATE(@Data_Reserva,'%d/%m/%Y');

SELECT*FROM Reserva;