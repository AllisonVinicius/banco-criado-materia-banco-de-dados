
use cinema_aq;

delimiter $$

DROP PROCEDURE if exists build_name_list $$
  CREATE PROCEDURE build_name_list (inout  name_list varchar(4000))
  BEGIN
 
DECLARE v_finished INTEGER DEFAULT 0;

	DECLARE v_name varchar(100) DEFAULT "";
    

DECLARE name_cursor CURSOR FOR #cursor pegar coisas 
	SELECT  HORARIO FROM cinema_aq.HORARIO;

DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET v_finished = 1;
    
    OPEN name_cursor;
    
    get_name: LOOP
    
    
    FETCH name_cursor INTO v_name;
    
    IF v_finished = 1 THEN
      LEAVE get_name;
	END IF;
    
    SET name_list = CONCAT(v_name, ";", name_list);#concatenando STRING

    
    END LOOP get_name;
    
    CLOSE name_cursor;
    
    END$$
    delimiter ;
    
    set @name_list='';
    call build_name_list(@name_list);
    select @name_list;
    
    
    #alterar para trazer lista de horarios de filmes;
    
    
