--------------------------------------------------------
-- Archivo creado  - martes-agosto-23-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table SEGUROMEDICO
--------------------------------------------------------

  CREATE TABLE "SEGUROMEDICO"."SEGUROMEDICO" 
   (	"IDSEGUROMEDICO" NUMBER(11,0) NOT NULL ENABLE, 
	"NIF" VARCHAR2(10 BYTE), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APE1" VARCHAR2(50 BYTE), 
	"EDAD" NUMBER(3,0), 
	"SEXO" VARCHAR2(20 BYTE), 
	"CASADO" NUMBER(1,0), 
	"NUMHIJOS" NUMBER(3,0), 
	"EMBARAZADA" NUMBER(1,0), 
	"COBERTURAOFTALMOLOGICA" NUMBER(1,0), 
	"COBERTURADENTAL" NUMBER(1,0), 
	"COBERTURAFECUNDACIONINVITRO" NUMBER(1,0), 
	"ENFERMEDADCORAZON" NUMBER(1,0), 
	"ENFERMEDADESTOMACAL" NUMBER(1,0), 
	"ENFERMEDADRINYONES" NUMBER(1,0), 
	"ENFERMEDADALERGIA" NUMBER(1,0), 
	"NOMBREALERGIA" VARCHAR2(50 BYTE), 
	 CONSTRAINT "SEGUROMEDICO_PK" PRIMARY KEY ("IDSEGUROMEDICO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE OR REPLACE TRIGGER "SEGUROMEDICO"."TIB_NEWREGISTRO" 
   before insert on "SEGUROMEDICO"."SEGUROMEDICO" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDSEGUROMEDICO" is null then 
         select SEC_NEWREGISTRO.nextval into :NEW."IDSEGUROMEDICO" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "SEGUROMEDICO"."TIB_NEWREGISTRO" ENABLE;

CREATE SEQUENCE  "SEGUROMEDICO"."SEC_NEWREGISTRO"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 9 NOCACHE  NOORDER  NOCYCLE ;

/* TABLA CUSTOMER */
CREATE TABLE "SEGUROMEDICO"."CUSTOMER" 
   (	"IDCUSTOMER" NUMBER NOT NULL ENABLE, 
	"NAME" VARCHAR2(255 BYTE), 
	 CONSTRAINT "CUSTOMER_PK" PRIMARY KEY ("IDCUSTOMER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

  CREATE OR REPLACE TRIGGER "SEGUROMEDICO"."TIB_NEWCUSTOMER" 
   before insert on "SEGUROMEDICO"."CUSTOMER" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDCUSTOMER" is null then 
         select SQ_CUSTOMER.nextval into :NEW."IDCUSTOMER" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "SEGUROMEDICO"."TIB_NEWCUSTOMER" ENABLE;


CREATE SEQUENCE  "SEGUROMEDICO"."SQ_CUSTOMER"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 ORDER  NOCYCLE ;

/* Tabla CUSTOMERDETAIL */

CREATE TABLE "SEGUROMEDICO"."CUSTOMERDETAIL" 
   (	"IDCUSTOMER" NUMBER NOT NULL ENABLE, 
	"IDDETAIL" NUMBER NOT NULL ENABLE, 
	"DESCRIPCION" VARCHAR2(50 BYTE), 
	 CONSTRAINT "CUSTOMERDETAIL_PK" PRIMARY KEY ("IDCUSTOMER", "IDDETAIL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "FK_CUS_CUSD" FOREIGN KEY ("IDCUSTOMER")
	  REFERENCES "SEGUROMEDICO"."CUSTOMER" ("IDCUSTOMER") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;




/* Procedimiento almacenado modificar secuencia*/
CREATE OR REPLACE PROCEDURE setSequence (seqname IN VARCHAR2, newnumber IN INTEGER) as
curr_val INTEGER;
curr_inc INTEGER;
curr_min INTEGER;
BEGIN
SELECT INCREMENT_BY, MIN_VALUE into curr_inc, curr_min from user_sequences where sequence_name = upper(seqname);
EXECUTE IMMEDIATE 'ALTER SEQUENCE ' ||seqname||' MINVALUE ' || LEAST((newnumber - curr_inc - 1) , curr_min) ;
EXECUTE IMMEDIATE 'SELECT ' ||seqname ||'.nextval FROM dual' INTO curr_val;
IF (newnumber - curr_val - curr_inc) != 0 THEN
EXECUTE IMMEDIATE 'ALTER SEQUENCE ' ||seqname||' INCREMENT BY '||(newnumber - curr_val - curr_inc);
END IF;
EXECUTE IMMEDIATE 'SELECT ' ||seqname ||'.nextval FROM dual' INTO curr_val;
EXECUTE IMMEDIATE 'ALTER SEQUENCE ' ||seqname||' INCREMENT BY ' || curr_inc;
END setSequence;
/