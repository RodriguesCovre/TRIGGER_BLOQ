
--TRIGGER PRA BLOQUEAR USUARIO QUANDO DEMITIDO
CREATE OR REPLACE TRIGGER TGF_BLOQ_USU    
AFTER UPDATE OF DATE_DEMISS ON FUNCIONARIO
FOR EACH ROW
BEGIN
    IF (:NEW.DATE_DEMISS IS NOT NULL) THEN
    
        UPDATE USUARIOS SET SITUACAO='B' --BLOQUEIA
		WHERE MATRICULA=:OLD.MATRICULA
        AND COD_EMPRESA=:OLD.COD_EMPRESA;
        
    END IF;
    
END;

--testando a trigger
SELECT * FROM FUNCIONARIO
WHERE COD_EMPRESA='1'
AND MATRICULA='11';

SELECT * FROM USUARIOS
WHERE COD_EMPRESA='1'
AND MATRICULA='11';
--update teste trigger 

UPDATE FUNCIONARIO SET DATE_DEMISS=SYSDATE
WHERE COD_EMPRESA='1'
AND MATRICULA='11';
COMMIT;


SELECT * FROM USUARIOS
WHERE COD_EMPRESA='1'
AND MATRICULA='11';


