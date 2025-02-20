#Procedures complicadas de verdede agora ^-^


#######################################################################
#Inserir na tabela aula
#######################################################################

DELIMITER //

CREATE PROCEDURE AddAula(
    IN idSala INT,
    IN data DATE,
    IN turno VARCHAR(10),
    IN idResponsavel INT,
    IN idMateria INT
)
BEGIN
    INSERT INTO Aula (IdSala, Data, Turno, IdResponsavel, IdMateria)
    VALUES (idSala, data, turno, idResponsavel, idMateria);
END //

DELIMITER ;

#Como usar ( esse é complicado )

#CALL AddAula(
#    8,               -- IdSala
#    '2024-08-01',    -- Data
#    'Manhã',         -- Turno
#    15,               -- IdResponsavel
#    50                -- IdMateria
#);

#######################################################################
#deletar na tabela aula
#######################################################################

DELIMITER //

CREATE PROCEDURE RemoveAula(  IN id INT)
BEGIN
    DELETE FROM Aula WHERE id = idAula;
END //

DELIMITER ;


#######################################################################
#view em todas as tabelas aulas socorro socorro socorro socorrooo
#######################################################################

CREATE VIEW ViewAulas AS
SELECT 
	a.IdAula,
    a.IdSala, 
    s.NomeSala,
    s.Capacidade,
    s.Tipo,
    a.Data, 
    a.Turno, 
    r.NomeProfessor AS Responsavel,
    m.NomeMateria AS Materia
FROM 
    Aula a
JOIN 
    Sala s ON a.IdSala = s.IdSala
JOIN 
    Responsavel r ON a.IdResponsavel = r.IdResponsavel
JOIN 
    Materia m ON a.IdMateria = m.IdMateria;
		

    
#######################################################################
#procedures chamando as view
#######################################################################

DELIMITER //

CREATE PROCEDURE GetAulas()
BEGIN
    SELECT * FROM ViewAulas;
END //

DELIMITER ;
#CALL GetAulas();

