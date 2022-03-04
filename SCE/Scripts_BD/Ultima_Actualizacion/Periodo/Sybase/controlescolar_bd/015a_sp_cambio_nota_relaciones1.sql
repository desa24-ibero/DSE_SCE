IF OBJECT_ID ('dbo.sp_cambio_nota_relaciones1') IS NOT NULL
	DROP PROCEDURE dbo.sp_cambio_nota_relaciones1
GO

CREATE PROCEDURE dbo.sp_cambio_nota_relaciones1

/*-------------------ESTRATEGIA TECNOLOGICA SA DE CV-------------

** DESCRIPCION:

** Para una cuenta, este proceso crea un set de datos que lista

** todas las materias de intercambio (Parent) contra todas las

** materias que ha cursado o esté cursando un alumno (children)

** y las relaciona por su seriación.

** 

** AUTOR: Magallanes Morales, Sergio Antonio.

----------------------------------------------------------------*/

@arg_iCuenta int,

@arg_sAnio varchar(4)= "%",

@arg_sPeriodo varchar(1) = "%"

AS

DECLARE @iCarrera int

DECLARE @iPlan int

DECLARE @iParent int

DECLARE @iChild int

DECLARE @iPrerrequisito int

DECLARE @sEnlace varchar(1)

DECLARE @iOrden int

DECLARE @sParents varchar(255)

BEGIN

/*------------------------------------------------------*/

/* Creamos la tabla de materias (Master).		*/

/*------------------------------------------------------*/

	CREATE TABLE #Master(

	cuenta int,

	cve_mat int,

	gpo varchar(2) null,

	anio int null,

	periodo int null,

	calificacion varchar(2) null)



	CREATE INDEX IMaster

   	ON #Master (cuenta, cve_mat)



/*------------------------------------------------------*/

/* Llenamos con todas las materias que el alumno haya	*/

/* cursado o este cursando.				*/

/*------------------------------------------------------*/

	INSERT INTO #Master

	SELECT

		a.cuenta,

		a.cve_mat,

		a.gpo,

		a.anio,

		a.periodo,

		"" as calificacion

	FROM

		dbo.mat_inscritas a

	WHERE 

		(a.cuenta = @arg_iCuenta)

	UNION

	SELECT 

		b.cuenta,

		b.cve_mat,

		b.gpo,

		b.anio,

		b.periodo,

		b.calificacion

	FROM

		dbo.historico_intercambio b

	WHERE 

		(b.cuenta = @arg_iCuenta)

	UNION

	SELECT 

		c.cuenta,

		c.cve_mat,

		c.gpo,

		c.anio,

		c.periodo,

		c.calificacion

	FROM

		dbo.historico c

	WHERE 

		(c.cuenta = @arg_iCuenta)



/*------------------------------------------------------*/

/* Creamos la tabla de trabajo.				*/

/*------------------------------------------------------*/

	CREATE TABLE #Parent_Child

	(id_parent int, id_child int, parents varchar(255))



	CREATE INDEX IParent_Child

   	ON #Parent_Child (id_parent, id_child)

	

/*------------------------------------------------------*/

/* Buscamos la carrera y el plan de estudios de la tabla*/

/* academicos.						*/

/*------------------------------------------------------*/

	SELECT

		@iCarrera = a.cve_carrera,

		@iPlan = a.cve_plan

	FROM

		academicos a 

	WHERE

		a.cuenta = @arg_iCuenta



/*------------------------------------------------------*/

/* Buscamos todas las materias de intercambio (Parents)	*/

/* que un alumno haya cursado o este cursando para un	*/

/* año y periodo determinado.				*/

/*------------------------------------------------------*/

	DECLARE Parents_crsr CURSOR FOR

	SELECT

		a.cve_mat

	FROM

		dbo.mat_inscritas a

	WHERE 

		(a.cuenta = @arg_iCuenta) AND  

		(a.cve_condicion = 0) AND  

		(a.gpo = 'ZZ') AND  

		(CONVERT(varchar(4),a.anio) LIKE @arg_sAnio) AND  

		(CONVERT(varchar(1),a.periodo) LIKE @arg_sPeriodo)  

	UNION

	SELECT 

		b.cve_mat

	FROM

		dbo.historico_intercambio b

	WHERE 

		(b.cuenta = @arg_iCuenta) AND  

		(b.gpo = 'ZZ') AND  

		(CONVERT(varchar(4),b.anio) LIKE @arg_sAnio) AND  

		(CONVERT(varchar(1),b.periodo) LIKE @arg_sPeriodo)  

	UNION

	SELECT 

		c.cve_mat

	FROM

		dbo.historico c

	WHERE 

		(c.cuenta = @arg_iCuenta) AND  

		(c.gpo = 'ZZ') AND  

		(CONVERT(varchar(4),c.anio) LIKE @arg_sAnio) AND  

		(CONVERT(varchar(1),c.periodo) LIKE @arg_sPeriodo)



	OPEN Parents_crsr



	FETCH Parents_crsr

	INTO 

		@iParent



	WHILE @@sqlstatus = 0

	BEGIN

/*------------------------------------------------------*/

/* Determinamos si la materia (Parent) es prerrequisito	*/

/* para otras materias (Child) que haya cursado o este 	*/

/* cursando el alumno.					*/

/*------------------------------------------------------*/

		DECLARE Children_crsr CURSOR FOR

		SELECT 

			a.cve_mat

		FROM

			prerrequisitos a

		WHERE

			a.cve_carrera = @iCarrera AND

			a.cve_plan = @iPlan AND

			a.cve_prerreq = @iParent



		OPEN Children_crsr



		FETCH Children_crsr

		INTO 

			@iChild



		IF @@sqlstatus = 2

			INSERT INTO #Parent_Child VALUES(@iParent,0,"")		



		WHILE @@sqlstatus = 0

		BEGIN

/*------------------------------------------------------*/

/* Buscamos los prerrequisitos de la materia (Child).	*/

/*------------------------------------------------------*/

			DECLARE Prerrequisitos_crsr CURSOR FOR

			SELECT 

				a.cve_prerreq,

				a.enlace,

				a.orden

			FROM

				prerrequisitos a

			WHERE

				a.cve_carrera = @iCarrera AND

				a.cve_plan = @iPlan AND

				a.cve_mat = @iChild

			ORDER BY 3



			OPEN Prerrequisitos_crsr



			FETCH Prerrequisitos_crsr

			INTO 

				@iPrerrequisito,

				@sEnlace,

				@iOrden



			SELECT @sParents = ""



			WHILE @@sqlstatus = 0

			BEGIN

				SELECT @sParents = @sParents + " " + CONVERT(varchar(255),@iPrerrequisito) + " " + @sEnlace



				FETCH Prerrequisitos_crsr

				INTO 

					@iPrerrequisito,

					@sEnlace,

					@iOrden

			END



			CLOSE Prerrequisitos_crsr

			DEALLOCATE CURSOR Prerrequisitos_crsr



			SELECT @sParents = LTRIM(@sParents)



			INSERT INTO #Parent_Child VALUES(@iParent,@iChild,@sParents)



			FETCH Children_crsr

			INTO 

				@iChild

		END

		

		CLOSE Children_crsr

		DEALLOCATE CURSOR Children_crsr



		FETCH Parents_crsr

		INTO 

			@iParent

	END



	CLOSE Parents_crsr

	DEALLOCATE CURSOR Parents_crsr



/*------------------------------------------------------*/

/* Set de datos.					*/

/*------------------------------------------------------*/

	SELECT

		b.cuenta as cuenta1,   

		b.cve_mat as cve_mat1,

		d.materia as materia1,

		b.gpo as gpo1,   

		b.anio as anio1,

		b.periodo as cve_periodo1,
		
		(SELECT UPPER(descripcion) FROM periodo WHERE periodo = b.periodo) AS periodo1, -- MALH 26/09/2017 SE AGREGA CONSULTA
		
		/* MALH 26/09/2017 SE COMENTA
		CASE b.periodo

			WHEN 0 then "PRIMAVERA"

			WHEN 1 then "VERANO"

			WHEN 2 then "OTOÑO"

			ELSE null

		END as periodo1,
		*/

		b.calificacion as calificacion1,

		a.id_parent,

		a.id_child,

		a.parents,

		c.cuenta as cuenta2,   

		c.cve_mat as cve_mat2,

		e.materia as materia2,

		c.gpo as gpo2,   

		c.anio as anio2,  

		c.periodo as cve_periodo2,

		(SELECT UPPER(descripcion) FROM periodo WHERE periodo = c.periodo) AS periodo2, -- MALH 26/09/2017 SE AGREGA CONSULTA

		/* MALH 26/09/2017 SE COMENTA
		CASE c.periodo

			WHEN 0 then "PRIMAVERA"

			WHEN 1 then "VERANO"

			WHEN 2 then "OTOÑO"

			ELSE null

		END as periodo2,
		*/

		c.calificacion as calificacion2

	FROM 

		#Parent_Child a,

		#Master b,

		#Master c,

		dbo.materias d,  

		dbo.materias e  

	WHERE

		b.cuenta = @arg_iCuenta AND

		c.cuenta = @arg_iCuenta AND

		a.id_parent = b.cve_mat AND

		a.id_child *= c.cve_mat AND

		b.cve_mat = d.cve_mat AND

		c.cve_mat *= e.cve_mat

END
GO

GRANT EXECUTE ON dbo.sp_cambio_nota_relaciones1 TO public
GO

