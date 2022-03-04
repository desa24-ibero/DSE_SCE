USE [web_bd]
GO
/****** Object:  UserDefinedFunction [dbo].[se3_sepe2_getHorasPromProf]    Script Date: 29/9/2017 12:28:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================================================================
-- Author:¿?
-- Create date: 19/10/2012
-- Description:	Obtiene las horas promedio de clase impartidas por un profesor, en un periodo determinado
-- ===========================================================================================================
ALTER FUNCTION [dbo].[se3_sepe2_getHorasPromProf](@cve_prof Int, @pIni Char(5), @pFin Char(5), @veranos TinyInt)
RETURNS Decimal(12, 2)
AS
BEGIN
		
	Declare @periodos Table(periodo Tinyint, anio Int, desc_periodo nVarChar(35));
	Declare @horas Table(cve_profesor Int, horas_reales Decimal(12, 2));
	Declare @semestres Table(cve_profesor Int, sem SmallInt);
	Declare @rt Decimal(12, 2);
	
	Insert Into @periodos
	Select		c.periodo, c.anio,
				-- MALH 29/09/2017 SE AGREGA CONSULTA
				(SELECT descripcion FROM controlescolar_bd.dbo.periodo WHERE periodo = c.periodo) + ' - ' + Cast(c.anio As varChar) AS desc_periodo
				/*-- MALH 29/09/2017 SE COMENTA
				Case
					When c.periodo = 0 Then 'Primavera' + ' - ' + Cast(c.anio As varChar)
					WHEN c.periodo = 1 Then 'Verano' + ' - ' + Cast(c.anio As varChar)
					WHEN c.periodo = 2 Then 'Otoño' + ' - ' + Cast(c.anio As varChar)				
				End As desc_periodo
				*/
	From		v_www_calendario c
	Where		c.cve_evento = 1
				And Cast(c.anio As Char(4)) + Cast(c.periodo As Char(1)) Between @pIni And @pFin			
				And c.periodo != Case When @veranos = 1 Then -1 Else 1 End			

	Insert Into @horas
	Select		tab.cve_profesor, 
				Sum(tab.horas_reales) As horas_reales
	From		(
					Select	hst.cve_profesor, mat.horas_reales,
							hst.periodo, hst.anio, tmp.desc_periodo
					From	ec_hist_grupos As hst
							Inner Join v_www_materias_1 As mat On hst.cve_mat = mat.cve_mat
							Inner Join @periodos AS tmp On hst.anio = tmp.anio And hst.periodo = tmp.periodo
					Where	hst.cve_profesor = @cve_prof
							And hst.tipo = 0
					Union All
					Select	grup.cve_profesor, mat1.horas_reales, grup.periodo,
							grup.anio, tmp1.desc_periodo
					From	ec_grupos As grup
							Inner Join v_www_materias_1 As mat1 On grup.cve_mat = mat1.cve_mat
							Inner Join @periodos As tmp1 On grup.anio = tmp1.anio And grup.periodo = tmp1.periodo
					Where	grup.cve_profesor = @cve_prof
							And grup.tipo = 0
				)As tab
	Group By	tab.cve_profesor, tab.horas_reales

	Insert Into @semestres
	Select		tab1.cve_profesor, Count(*) As sem
	From		(
					Select	Distinct grup.cve_profesor, grup.anio, grup.periodo
					FROM	ec_grupos As grup 
							Inner Join @periodos As tmp On grup.anio = tmp.anio And grup.periodo = tmp.periodo
					Where	grup.cve_profesor = @cve_prof
							And grup.tipo = 0
					Union All                                                    
					Select	Distinct hst.cve_profesor, hst.anio, hst.periodo
					From	ec_hist_grupos As hst 
							Inner Join @periodos As tmp1 On hst.anio = tmp1.anio And hst.periodo = tmp1.periodo
					Where	hst.cve_profesor = @cve_prof
							And hst.tipo = 0
				)As tab1
	Group By	tab1.cve_profesor

	SELECT		@rt = Cast(Round(Sum((Cast(hrs.horas_reales As Decimal(12,2)) / sm.sem)), 2 )As Decimal(12,2))
	From		@semestres As sm 
				Inner Join @horas As hrs On sm.cve_profesor = hrs.cve_profesor
	Group By	sm.cve_profesor
            
	Return IsNull(@rt, 0.00)

END
GO

GRANT EXECUTE ON [dbo].[se3_sepe2_getHorasPromProf] TO public
GO

