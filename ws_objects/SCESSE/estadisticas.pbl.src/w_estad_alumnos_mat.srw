$PBExportHeader$w_estad_alumnos_mat.srw
forward
global type w_estad_alumnos_mat from window
end type
type st_1 from statictext within w_estad_alumnos_mat
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_alumnos_mat
end type
type uo_carrera from uo_carreras within w_estad_alumnos_mat
end type
type uo_coordinacion from uo_coordinaciones within w_estad_alumnos_mat
end type
type gb_carreras from groupbox within w_estad_alumnos_mat
end type
type gb_coordinacion from groupbox within w_estad_alumnos_mat
end type
type st_3 from statictext within w_estad_alumnos_mat
end type
type dw_estadisticas from datawindow within w_estad_alumnos_mat
end type
type cb_1 from commandbutton within w_estad_alumnos_mat
end type
type em_anio from editmask within w_estad_alumnos_mat
end type
type dw_1x from datawindow within w_estad_alumnos_mat
end type
type gb_8 from groupbox within w_estad_alumnos_mat
end type
type gb_11 from groupbox within w_estad_alumnos_mat
end type
type gb_20 from groupbox within w_estad_alumnos_mat
end type
type gb_1 from groupbox within w_estad_alumnos_mat
end type
end forward

global type w_estad_alumnos_mat from window
integer width = 3749
integer height = 2120
boolean titlebar = true
string title = "Estadística de Alumnos/Materias"
string menuname = "m_estad_alum_mat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_1 st_1
uo_periodo uo_periodo
uo_carrera uo_carrera
uo_coordinacion uo_coordinacion
gb_carreras gb_carreras
gb_coordinacion gb_coordinacion
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
end type
global w_estad_alumnos_mat w_estad_alumnos_mat

type variables
int periodo_x
end variables

forward prototypes
public function integer wf_genera_reporte (integer ai_periodo[], integer ai_anio, integer ai_cve_carrera, integer ai_cve_coordinacion, string as_tipo_periodo)
end prototypes

public function integer wf_genera_reporte (integer ai_periodo[], integer ai_anio, integer ai_cve_carrera, integer ai_cve_coordinacion, string as_tipo_periodo);


// Se validan los parámetros
IF ISNULL(ai_periodo) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar el periodo") 
	RETURN -1
END IF

IF ISNULL(ai_anio) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar el anio") 
	RETURN -1	
END IF

IF ISNULL(ai_cve_carrera) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar la clave de la carrera") 
	RETURN -1	
END IF

IF ISNULL(ai_cve_coordinacion) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar la clave de la coordinacion") 
	RETURN -1	
END IF

IF ISNULL(as_tipo_periodo) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar un tipo de periodo") 
	RETURN -1		
END IF


////select @periodo_actual = max(isnull(periodo,0)) from mat_inscritas
////select @anio_actual = max(isnull(anio,0)) from mat_inscritas


// Se recupera el año actual y los periodos actuales.
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodos_activos(gtr_sce) 

INTEGER le_pos 
INTEGER le_periodo
INTEGER le_anio

// Se hace ciclo para 
FOR le_pos = 1 TO luo_periodo_servicios.ids_periodos_activos.ROWCOUNT() STEP 1

	le_periodo = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "id_periodo") 
	le_anio = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "anio") 
	
	
	
	
	
NEXT















//SELECT @periodo_actual = pp.periodo, @anio_actual = pp.anio
//FROM periodos_por_procesos pp, periodo p
//WHERE pp.cve_proceso = 0
//AND pp.periodo = p.periodo
//AND p.tipo = @tipo_periodo 
//
//
//
//if (@anio > @anio_actual) 
//
//begin
//	select @num_error = 20000, @mensaje_error = "El anio escrito no es permitido, por ser futuro"
//	Goto EtiquetaError
//end 
//
//if (@anio = @anio_actual) and (@periodo > @periodo_actual) 
//begin
//	select @num_error = 20000, @mensaje_error = "El periodo escrito no es permitido, por ser futuro"
//	Goto EtiquetaError
//end 
//
//if @periodo=@periodo_actual and @anio=@anio_actual
//	begin
//	 SELECT  carreras.cve_carrera,   
//				 carreras.carrera,   
//				 coordinaciones.cve_coordinacion,   
//				 coordinaciones.coordinacion,   
//				 numero= COUNT(*)  
//		 FROM  academicos,   
//				 carreras,   
//				 coordinaciones,   
//				 mat_inscritas,
//				 materias  
//		WHERE (  academicos.cve_carrera =  carreras.cve_carrera ) and  
//				(  coordinaciones.cve_coordinacion =  materias.cve_coordinacion ) and  
//				(  mat_inscritas.cve_mat =  materias.cve_mat ) and  
//				(  academicos.cuenta =  mat_inscritas.cuenta ) and
//				(  carreras.cve_carrera = @cve_carrera or
//					@cve_carrera = 9999 ) and
//				(  coordinaciones.cve_coordinacion = @cve_coordinacion or
//					@cve_coordinacion = 9999 ) and
//				(  mat_inscritas.periodo = @periodo ) and
//				(  mat_inscritas.anio = @anio) and
//				(  mat_inscritas.cve_condicion in (0))
//		GROUP BY   carreras.cve_carrera,   
//				 carreras.carrera,   
//				 coordinaciones.cve_coordinacion,   
//				 coordinaciones.coordinacion
//	end
//else
//	begin
//	
//	 SELECT  carreras.cve_carrera,   
//				 carreras.carrera,   
//				 coordinaciones.cve_coordinacion,   
//				 coordinaciones.coordinacion,   
//				 numero= COUNT(*)  
//		 FROM  academicos,   
//				 carreras,   
//				 coordinaciones,   
//				 historico,
//				 materias  
//		WHERE (  academicos.cve_carrera =  carreras.cve_carrera ) and  
//				(  coordinaciones.cve_coordinacion =  materias.cve_coordinacion ) and  
//				(  historico.cve_mat =  materias.cve_mat ) and  
//				(  academicos.cuenta =  historico.cuenta ) and
//				(  carreras.cve_carrera = @cve_carrera or
//					@cve_carrera = 9999 ) and
//				(  coordinaciones.cve_coordinacion = @cve_coordinacion or
//					@cve_coordinacion = 9999 ) and
//				(  historico.periodo = @periodo) and
//				(  historico.anio = @anio) 
//		GROUP BY   carreras.cve_carrera,   
//				 carreras.carrera,   
//				 coordinaciones.cve_coordinacion,   
//				 coordinaciones.coordinacion
//	end
//
//Fin:
//
//EtiquetaCorrecto:
//	Commit Transaction
//	return 0
//EtiquetaError:
//	raiserror @num_error,  @mensaje_error
//	Rollback Transaction
//	return -1
//
//;



RETURN 0






////
////
////
////
////
////
//////execute dbo.sp_alumnos_materia;1 @periodo = :periodo, @anio = :anio, @cve_carrera = :cve_carrera, @cve_coordinacion = :cve_coordinacion
////
////
////DROP PROCEDURE sp_alumnos_materia;
////
////create procedure sp_alumnos_materia @periodo				smallint = null,
////												@anio					smallint = null,
////												@cve_carrera		integer = null,
////												@cve_coordinacion integer = null, 
////												@tipo_periodo varchar(3) = null
////as
////declare
////	@fecha_hoy datetime, 
////	@mensaje_error varchar(50),
////	@num_error integer,
////	@periodo_actual integer,
////	@anio_actual integer
////
////Begin Transaction
////
////if @periodo in (null)
////
////begin
////	select @num_error = 20000, @mensaje_error = "Es necesario dar el periodo"
////	Goto EtiquetaError
////end 
////
////if @anio in (null)
////begin
////	select @num_error = 20000, @mensaje_error = "Es necesario dar el anio"
////	Goto EtiquetaError
////end
////
////if @cve_carrera in (null)
////begin
////	select @num_error = 20000, @mensaje_error = "Es necesario dar la clave de la carrera"
////	Goto EtiquetaError
////end 
////
////if @cve_coordinacion in (null)
////begin
////	select @num_error = 20000, @mensaje_error = "Es necesario dar la clave de la coordinacion"
////	Goto EtiquetaError
////end
////
////if @tipo_periodo in(null)
////begin
////	select @num_error = 20000, @mensaje_error = "Es necesario dar un tipo de periodo"
////	Goto EtiquetaError
////end
////
////
////
//////select @periodo_actual = max(isnull(periodo,0)) from mat_inscritas
//////select @anio_actual = max(isnull(anio,0)) from mat_inscritas
////
////SELECT @periodo_actual = pp.periodo, @anio_actual = pp.anio
////FROM periodos_por_procesos pp, periodo p
////WHERE pp.cve_proceso = 0
////AND pp.periodo = p.periodo
////AND p.tipo = @tipo_periodo 
////
////
////
////if (@anio > @anio_actual) 
////
////begin
////	select @num_error = 20000, @mensaje_error = "El anio escrito no es permitido, por ser futuro"
////	Goto EtiquetaError
////end 
////
////if (@anio = @anio_actual) and (@periodo > @periodo_actual) 
////begin
////	select @num_error = 20000, @mensaje_error = "El periodo escrito no es permitido, por ser futuro"
////	Goto EtiquetaError
////end 
////
////if @periodo=@periodo_actual and @anio=@anio_actual
////	begin
////	 SELECT  carreras.cve_carrera,   
////				 carreras.carrera,   
////				 coordinaciones.cve_coordinacion,   
////				 coordinaciones.coordinacion,   
////				 numero= COUNT(*)  
////		 FROM  academicos,   
////				 carreras,   
////				 coordinaciones,   
////				 mat_inscritas,
////				 materias  
////		WHERE (  academicos.cve_carrera =  carreras.cve_carrera ) and  
////				(  coordinaciones.cve_coordinacion =  materias.cve_coordinacion ) and  
////				(  mat_inscritas.cve_mat =  materias.cve_mat ) and  
////				(  academicos.cuenta =  mat_inscritas.cuenta ) and
////				(  carreras.cve_carrera = @cve_carrera or
////					@cve_carrera = 9999 ) and
////				(  coordinaciones.cve_coordinacion = @cve_coordinacion or
////					@cve_coordinacion = 9999 ) and
////				(  mat_inscritas.periodo = @periodo ) and
////				(  mat_inscritas.anio = @anio) and
////				(  mat_inscritas.cve_condicion in (0))
////		GROUP BY   carreras.cve_carrera,   
////				 carreras.carrera,   
////				 coordinaciones.cve_coordinacion,   
////				 coordinaciones.coordinacion
////	end
////else
////	begin
////	
////	 SELECT  carreras.cve_carrera,   
////				 carreras.carrera,   
////				 coordinaciones.cve_coordinacion,   
////				 coordinaciones.coordinacion,   
////				 numero= COUNT(*)  
////		 FROM  academicos,   
////				 carreras,   
////				 coordinaciones,   
////				 historico,
////				 materias  
////		WHERE (  academicos.cve_carrera =  carreras.cve_carrera ) and  
////				(  coordinaciones.cve_coordinacion =  materias.cve_coordinacion ) and  
////				(  historico.cve_mat =  materias.cve_mat ) and  
////				(  academicos.cuenta =  historico.cuenta ) and
////				(  carreras.cve_carrera = @cve_carrera or
////					@cve_carrera = 9999 ) and
////				(  coordinaciones.cve_coordinacion = @cve_coordinacion or
////					@cve_coordinacion = 9999 ) and
////				(  historico.periodo = @periodo) and
////				(  historico.anio = @anio) 
////		GROUP BY   carreras.cve_carrera,   
////				 carreras.carrera,   
////				 coordinaciones.cve_coordinacion,   
////				 coordinaciones.coordinacion
////	end
////
////Fin:
////
////EtiquetaCorrecto:
////	Commit Transaction
////	return 0
////EtiquetaError:
////	raiserror @num_error,  @mensaje_error
////	Rollback Transaction
////	return -1
////
////;
////
////GRANT ALL ON sp_alumnos_materia TO PUBLIC;
////
//// 
end function

on w_estad_alumnos_mat.create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.st_1=create st_1
this.uo_periodo=create uo_periodo
this.uo_carrera=create uo_carrera
this.uo_coordinacion=create uo_coordinacion
this.gb_carreras=create gb_carreras
this.gb_coordinacion=create gb_coordinacion
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.uo_periodo,&
this.uo_carrera,&
this.uo_coordinacion,&
this.gb_carreras,&
this.gb_coordinacion,&
this.st_3,&
this.dw_estadisticas,&
this.cb_1,&
this.em_anio,&
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_1}
end on

on w_estad_alumnos_mat.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.uo_periodo)
destroy(this.uo_carrera)
destroy(this.uo_coordinacion)
destroy(this.gb_carreras)
destroy(this.gb_coordinacion)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1




THIS.uo_periodo.of_inicializa_servicio("H", "L", "L", "N", gtr_sce)
//of_inicializa_servicio( /*string as_orientacion*/, /*string as_tipo_descripcion*/, /*string as_case_descripciones*/, /*string as_solo_default*/, /*n_tr atr_sce */)
 
//// Se inicializa el objeto de servicios de periodo.
//THIS.uo_periodo.f_genera_periodo(gs_tipo_periodo, "H", "L", "L", gtr_sce)
//
//
//int periodo,anio
//periodo_actual_mat_insc(periodo,anio,gtr_sce)
//THIS.uo_periodo.f_selecciona_periodo(periodo, "L")


end event

type st_1 from statictext within w_estad_alumnos_mat
integer x = 2263
integer y = 508
integer width = 434
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "* Periodo Activo"
boolean focusrectangle = false
end type

type uo_periodo from uo_periodo_variable_tipos within w_estad_alumnos_mat
integer x = 434
integer y = 364
integer width = 1760
integer height = 200
integer taborder = 90
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_carrera from uo_carreras within w_estad_alumnos_mat
event destroy ( )
integer x = 1742
integer y = 136
integer taborder = 30
boolean border = false
long backcolor = 79741120
end type

on uo_carrera.destroy
call uo_carreras::destroy
end on

type uo_coordinacion from uo_coordinaciones within w_estad_alumnos_mat
event destroy ( )
integer x = 416
integer y = 140
integer taborder = 50
boolean border = false
long backcolor = 79741120
end type

on uo_coordinacion.destroy
call uo_coordinaciones::destroy
end on

type gb_carreras from groupbox within w_estad_alumnos_mat
integer x = 1710
integer y = 76
integer width = 1294
integer height = 224
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carreras"
borderstyle borderstyle = styleraised!
end type

type gb_coordinacion from groupbox within w_estad_alumnos_mat
integer x = 384
integer y = 80
integer width = 1294
integer height = 224
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coordinación"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_estad_alumnos_mat
integer x = 3081
integer y = 76
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_estadisticas from datawindow within w_estad_alumnos_mat
integer y = 624
integer width = 3589
integer height = 1212
integer taborder = 100
string dataobject = "d_alumnos_materias"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_estad_alum_mat.dw= this
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	Cont = string(rowcount)
	// Se actualiza el numero de datos traidos
//	Cont =string(dw_1z.object.cuantos[1])
	st_3.text='Total : '+Cont
else
	st_3.text='Total : '+Cont
end if

end event

type cb_1 from commandbutton within w_estad_alumnos_mat
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 220
integer width = 265
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;// Se recuperan los registros de la base de datos
long ll_renglon_uo
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel
string ls_anio, ls_nivel[], ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion
datetime ldttm_fecha_servidor

ll_row_carrera = parent.uo_carrera.dw_carreras.GetRow()
ll_cve_carrera = parent.uo_carrera.dw_carreras.object.cve_carrera[ll_row_carrera]
ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.object.cve_coordinacion[ll_row_coordinacion]

// Se validan los parámetros
IF ISNULL(li_periodo) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar el periodo") 
	RETURN -1
END IF

IF ISNULL(li_anio) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar el año") 
	RETURN -1	
END IF

IF ISNULL(ll_cve_carrera) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar la clave de la carrera") 
	RETURN -1	
END IF

IF ISNULL(ll_cve_coordinacion) THEN 
	MESSAGEBOX("Aviso", "Es necesario dar la clave de la coordinacion") 
	RETURN -1	
END IF

//if rb_primavera.checked then
//	li_periodo= 0
//	ls_periodo = "Primavera"
//elseif rb_verano.checked then
//	li_periodo= 1
//	ls_periodo = "Verano"
//elseif rb_otonio.checked then
//	li_periodo= 2	
//	ls_periodo = "Otoño"
//else
//	MessageBox("Error", "Es necesario seleccionar un Periodo", StopSign!)
//	return
//end if

//**--****--****--****--****--****--****--****--**
//PARENT.uo_periodo.f_recupera_periodo(li_periodo, ls_periodo)
//IF PARENT.uo_periodo.ierror < 0 THEN 
//	MessageBox("Error", PARENT.uo_periodo.imensaje, StopSign!)
//	RETURN 
//END IF

ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)



// Se genera el reporte.
//**--****--****--****--****--****--****--****--****--****--****--****--**

INTEGER le_pos 
INTEGER le_anio 
INTEGER le_index
INTEGER le_periodo[] 
INTEGER le_row
INTEGER le_anio_activo
INTEGER le_periodo_activo
INTEGER le_periodo_temp

STRING ls_tipo_periodo
STRING ls_sql

// Se recupera el año actual y los periodos actuales.
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodos_activos(gtr_sce) 

PARENT.uo_periodo.of_recupera_periodos()

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	
	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
	ls_periodo_elegido = ls_periodo_elegido + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	le_periodo_temp = PARENT.uo_periodo.istr_periodos[le_index].periodo
	
	ls_tipo_periodo = PARENT.uo_periodo.istr_periodos[le_index].tipo 
	
	// Se valida que el periodo sea válido
	le_row = luo_periodo_servicios.ids_periodos_activos.FIND("tipo_periodo = '" + ls_tipo_periodo + "'", 0, luo_periodo_servicios.ids_periodos_activos.ROWCOUNT()) 
	IF le_row > 0 THEN 
		le_anio_activo = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_row, "anio")
		le_periodo_activo = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_row, "id_periodo")
		// Se verifica si se trata de un periodo válido		
		IF li_anio > le_anio_activo OR (li_anio = le_anio_activo AND le_periodo_temp > le_periodo_activo) THEN 
			MessageBox("Error", "El periodo " + PARENT.uo_periodo.istr_periodos[le_index].descripcion  + " no es permitido, por ser futuro", StopSign!)  
			return			
		END IF
	END IF
	
	// Se verifica si se trata del periodo activo para cada caso.
	IF le_periodo_activo = le_periodo_temp AND le_anio_activo = li_anio THEN 
	
		IF TRIM(ls_sql) <> "" THEN ls_sql = ls_sql + " UNION ALL "
		
		ls_sql = ls_sql + " SELECT  carreras.cve_carrera, " + & 
					 " carreras.carrera, " + &    
					 " coordinaciones.cve_coordinacion, " + &    
					 " coordinaciones.coordinacion, " + &    
					 " numero= COUNT(*) " + &   
			 " FROM  academicos, " + &    
					 " carreras, " + &    
					 " coordinaciones, " + &    
					 " mat_inscritas, " + & 
					" materias " + &   
			" WHERE (  academicos.cve_carrera =  carreras.cve_carrera ) and " + &   
					" (  coordinaciones.cve_coordinacion =  materias.cve_coordinacion ) and " + &   
					" (  mat_inscritas.cve_mat =  materias.cve_mat ) and " + &   
					" (  academicos.cuenta =  mat_inscritas.cuenta ) and " + & 
					" (  carreras.cve_carrera = " + STRING(ll_cve_carrera) + " or " + &
						STRING(ll_cve_carrera) + " = 9999 ) and " + &
					" (  coordinaciones.cve_coordinacion = " + STRING(ll_cve_coordinacion) + " or " + &
						STRING(ll_cve_coordinacion) + " = 9999 ) and " + & 
					" (  mat_inscritas.periodo = " + STRING(le_periodo_temp) + " ) and " + &
					" (  mat_inscritas.anio = " + STRING(li_anio) + ") and " + &
					" (  mat_inscritas.cve_condicion in (0)) " + & 
			" GROUP BY   carreras.cve_carrera, " + &    
					 " carreras.carrera, " + &    
					 " coordinaciones.cve_coordinacion, " + &    
					 " coordinaciones.coordinacion " 
	
	ELSE 
		
	 		IF TRIM(ls_sql) <> "" THEN ls_sql = ls_sql + " UNION ALL "
		
			ls_sql = ls_sql + " SELECT  carreras.cve_carrera, " + &    
					 " carreras.carrera, " + &   
					 " coordinaciones.cve_coordinacion, " + &   
					 " coordinaciones.coordinacion, " + &   
					 " numero= COUNT(*) " + &  
			 " FROM  academicos, " + &   
					 " carreras, " + &   
					 " coordinaciones, " + &   
					 " historico, " + &
					 " materias " + &  
			" WHERE (  academicos.cve_carrera =  carreras.cve_carrera ) and " + &  
					" (  coordinaciones.cve_coordinacion =  materias.cve_coordinacion ) and " + &  
					" (  historico.cve_mat =  materias.cve_mat ) and " + &  
					" (  academicos.cuenta =  historico.cuenta ) and " + &
					" (  carreras.cve_carrera = " + STRING(ll_cve_carrera) + " or " + &
						STRING(ll_cve_carrera) + " = 9999 ) and " + &
					" (  coordinaciones.cve_coordinacion = " + STRING(ll_cve_coordinacion)  + " or " + &
						STRING(ll_cve_coordinacion) + " = 9999 ) and " + &
					" (  historico.periodo = " + STRING(le_periodo_temp) + " ) and " + &
					" (  historico.anio = " + STRING(li_anio) + ")  " + &
			" GROUP BY   carreras.cve_carrera, " + &   
					 " carreras.carrera, " + &   
					 " coordinaciones.cve_coordinacion, " + &   
					 " coordinaciones.coordinacion " 		
	END IF
	
NEXT 


//**--****--****--****--****--****--****--****--****--****--****--****--**
setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_periodo_elegido =ls_periodo +" "+ ls_anio

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

//dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_carrera, ll_cve_coordinacion, gs_tipo_periodo)
dw_estadisticas.SETTRANSOBJECT(gtr_sce) 
dw_estadisticas.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
dw_estadisticas.RETRIEVE(li_periodo, li_anio, ll_cve_carrera, ll_cve_coordinacion, gs_tipo_periodo)

//**--****--****--****--****--****--****--****--****--****--****--****--**



RETURN 0




end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_alumnos_mat
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 82
integer y = 124
integer width = 219
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
string displaydata = "`"
end type

event constructor;TabOrder = 0

int periodo,anio


periodo_actual_mat_insc(periodo,anio,gtr_sce)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño

//CHOOSE CASE periodo
//	CASE 0
//		periodo_x = 0
//		rb_primavera.checked = TRUE
//	CASE 1
//		periodo_x = 1
//      rb_verano.checked = TRUE
//	CASE 2
//		periodo_x = 2
//      rb_otonio.checked = TRUE
//
//END CHOOSE
this.text = string(anio)

//Deshabilitar los objetos que señalan el periodo
//this.enabled = FALSE
//rb_primavera.enabled = FALSE
//rb_verano.enabled = FALSE
//rb_otonio.enabled = FALSE
		

		
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type dw_1x from datawindow within w_estad_alumnos_mat
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 90
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_estad_alumnos_mat
integer x = 3150
integer y = 172
integer width = 329
integer height = 176
integer taborder = 120
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_alumnos_mat
integer x = 37
integer y = 64
integer width = 315
integer height = 160
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_estad_alumnos_mat
integer x = 379
integer y = 300
integer width = 1865
integer height = 288
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_estad_alumnos_mat
integer width = 3589
integer height = 612
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

