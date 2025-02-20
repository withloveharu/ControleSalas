CREATE TABLE Sala (
    IdSala INT AUTO_INCREMENT PRIMARY KEY,
    NomeSala VARCHAR(255),
    Capacidade INT,
    Tipo VARCHAR(255)
);

CREATE TABLE Responsavel (
    IdResponsavel INT AUTO_INCREMENT PRIMARY KEY,    
    NomeProfessor VARCHAR(255)
);

CREATE TABLE Materia (
    IdMateria INT AUTO_INCREMENT PRIMARY KEY,
    NomeMateria VARCHAR(255)
);

CREATE TABLE Aula (
	IdAula INT AUTO_INCREMENT PRIMARY KEY,
    IdSala INT,
    Data DATE,
    Turno VARCHAR(10),
    IdResponsavel INT,
    IdMateria INT,
    FOREIGN KEY (IdSala) REFERENCES Sala(IdSala),
    FOREIGN KEY (IdResponsavel) REFERENCES Responsavel(IdResponsavel),
    FOREIGN KEY (IdMateria) REFERENCES Materia(IdMateria)
);


DELIMITER //

	

CREATE PROCEDURE AddMateria(IN nomeMateria VARCHAR(255))
BEGIN
    INSERT INTO Materia (NomeMateria) VALUES (nomeMateria);
END //

DELIMITER ;

#^ ex CALL AddMateria('Matemática'); ^


DELIMITER //

CREATE PROCEDURE AddResponsavel(IN nomeProfessor VARCHAR(255))
BEGIN
    INSERT INTO Responsavel (NomeProfessor) VALUES (nomeProfessor);
END //

DELIMITER ;

#^ ex CALL AddResponsavel('Prof. João Silva'); ^


DELIMITER //

CREATE PROCEDURE AddSala(IN nomeSala VARCHAR(255), IN capacidade INT, IN tipo VARCHAR(255))
BEGIN
    INSERT INTO Sala (NomeSala, Capacidade, Tipo) VALUES (nomeSala, capacidade, tipo);
END //

DELIMITER ;

#^ ex CALL AddSala('Sala 101', 30, 'Laboratório'); ^

#######################################################################
#                               Remover das tabelas:
#                          materias , responsavel , sala
#######################################################################


DELIMITER //


CREATE PROCEDURE RemoveMateria(IN id INT)
BEGIN
    DELETE FROM Materia WHERE IdMateria = id;
END //

DELIMITER ;
#^CALL RemoveMateria(1);  -- Substitua 1 pelo ID da matéria que deseja remover ^


DELIMITER //

CREATE PROCEDURE RemoveResponsavel(IN id INT)
BEGIN
    DELETE FROM Responsavel WHERE IdResponsavel = id;
END //

DELIMITER ;
#^ CALL RemoveResponsavel(1);  -- Substitua 1 pelo ID do responsável que deseja remover ^

DELIMITER //

CREATE PROCEDURE RemoveSala(IN id INT)
BEGIN
    DELETE FROM Sala WHERE IdSala = id;
END //

DELIMITER ;
#^ CALL RemoveSala(1);  -- Substitua 1 pelo ID da sala que deseja remover ^



#######################################################################
#                               Ver as tabelas:
#                          materias , responsavel , sala
#                       vou precisar dos IDS aqui pra poder remover
#                       usando os Remove por isso to fazendo as view :p
#######################################################################
CREATE VIEW ViewMaterias AS
SELECT 
    IdMateria, 
    NomeMateria 
FROM 
    Materia;

CREATE VIEW ViewResponsaveis AS
SELECT 
    IdResponsavel, 
    NomeProfessor 
FROM 
    Responsavel;

CREATE VIEW ViewSalas AS
SELECT 
    IdSala, 
    NomeSala, 
    Capacidade,
    Tipo
FROM 
    Sala;

#Views ^
#######################################################################
#Agora as procedures de verdade usando as views que criamos
#######################################################################
DELIMITER //

CREATE PROCEDURE GetMaterias()
BEGIN
    SELECT * FROM ViewMaterias;
END //

DELIMITER ;
#^CALL GetMaterias();^


DELIMITER //

CREATE PROCEDURE GetResponsaveis()
BEGIN
    SELECT * FROM ViewResponsaveis;
END //

DELIMITER ;
#^CALL GetResponsaveis();^


DELIMITER //

CREATE PROCEDURE GetSalas()
BEGIN
    SELECT * FROM ViewSalas;
END //

DELIMITER ;
#^CALL GetSalas();^


################testando aqui para ver se tudo está correto################
#      CALL AddMateria('Matemática');
#       CALL AddMateria('Física');
#       CALL AddMateria('Química');
#       CALL AddResponsavel('Prof. João Silva');
#       CALL AddResponsavel('Prof. Maria Souza');
#       CALL AddResponsavel('Prof. Carlos Mendes');
#       CALL AddSala('Sala 101', 30, 'Laboratório');
#       CALL AddSala('Sala 102', 25, 'Estúdio');
#       CALL AddSala('Sala 103', 40, 'Sala normal');
#
#       SET SQL_SAFE_UPDATES = 0;
#
#       CALL GetMaterias();
#       CALL GetResponsaveis();
#       CALL GetSalas();
#
#       CALL RemoveMateria(1);
#       CALL RemoveMateria(2);
#       CALL RemoveMateria(3);
#
#       CALL RemoveResponsavel(1);
#       CALL RemoveResponsavel(2);
#       CALL RemoveResponsavel(3);
#
#       CALL RemoveSala(1);
#       CALL RemoveSala(2);
#       CALL RemoveSala(3);
#
#       CALL GetMaterias();
#       CALL GetResponsaveis();
#       CALL GetSalas();
#
#	   SET SQL_SAFE_UPDATES = 1;
