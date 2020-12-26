USE [master]
GO

IF ((SELECT COUNT(*) FROM sys.server_triggers WHERE name = 'trgBloquear_Login_Horario') > 0) DROP TRIGGER [trgBloquear_Login_Horario] ON ALL SERVER
GO

CREATE TRIGGER [trgBloquear_Login_Horario] ON ALL SERVER
FOR LOGON 
AS
BEGIN


    -- Elimina conexões dos usuários da lista --
    IF (ORIGINAL_LOGIN() NOT IN ('usuarioparabloqueio'))
        RETURN
    
-- Definir se conexões podem ser feitas final de semana -- 	 
	 --IF (DATEPART(WEEKDAY, GETDATE()) IN (0, 7))
  --  BEGIN
  --      PRINT 'Conexões aos fins de semana não são permitidas neste servidor'
  --      ROLLBACK
  --      RETURN
  --  END
 
    -- Defini horários de  bloqueio -- 
      IF (DATEPART(HOUR, GETDATE())  BETWEEN 8 AND 18)
    BEGIN
        PRINT 'Conexões  das 8h até as 18h não são permitidas neste servidor'
        ROLLBACK
        RETURN
    END
       

END
GO

ENABLE TRIGGER [trgBloquear_Login_Horario] ON ALL SERVER  
GO