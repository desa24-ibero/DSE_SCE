$PBExportHeader$w_cambio_periodo_primer_ingreso.srw
forward
global type w_cambio_periodo_primer_ingreso from w_main
end type
type st_periodo_establecido_destino from statictext within w_cambio_periodo_primer_ingreso
end type
type cb_establece_periodo_destino from u_cb within w_cambio_periodo_primer_ingreso
end type
type st_periodo_establecido_origen from statictext within w_cambio_periodo_primer_ingreso
end type
type cb_establece_periodo_origen from u_cb within w_cambio_periodo_primer_ingreso
end type
type uo_2 from uo_per_ani_visual within w_cambio_periodo_primer_ingreso
end type
type uo_1 from uo_per_ani_visual within w_cambio_periodo_primer_ingreso
end type
type st_2 from u_st within w_cambio_periodo_primer_ingreso
end type
type st_1 from u_st within w_cambio_periodo_primer_ingreso
end type
type cb_3 from u_cb within w_cambio_periodo_primer_ingreso
end type
type st_avance from u_st within w_cambio_periodo_primer_ingreso
end type
type st_procesamiento from u_st within w_cambio_periodo_primer_ingreso
end type
type cb_2 from u_cb within w_cambio_periodo_primer_ingreso
end type
type dw_cortes_cuentas from u_dw within w_cambio_periodo_primer_ingreso
end type
type gb_2 from groupbox within w_cambio_periodo_primer_ingreso
end type
type st_5 from statictext within w_cambio_periodo_primer_ingreso
end type
type st_6 from statictext within w_cambio_periodo_primer_ingreso
end type
type st_3 from statictext within w_cambio_periodo_primer_ingreso
end type
type st_4 from statictext within w_cambio_periodo_primer_ingreso
end type
end forward

global type w_cambio_periodo_primer_ingreso from w_main
integer width = 3835
integer height = 1712
string title = "Cambio de Periodo para Primer Ingreso"
st_periodo_establecido_destino st_periodo_establecido_destino
cb_establece_periodo_destino cb_establece_periodo_destino
st_periodo_establecido_origen st_periodo_establecido_origen
cb_establece_periodo_origen cb_establece_periodo_origen
uo_2 uo_2
uo_1 uo_1
st_2 st_2
st_1 st_1
cb_3 cb_3
st_avance st_avance
st_procesamiento st_procesamiento
cb_2 cb_2
dw_cortes_cuentas dw_cortes_cuentas
gb_2 gb_2
st_5 st_5
st_6 st_6
st_3 st_3
st_4 st_4
end type
global w_cambio_periodo_primer_ingreso w_cambio_periodo_primer_ingreso

type variables
string is_nombre_archivo= ""
n_cortes in_cortes
datetime ldtm_fecha_inicial, ldtm_fecha_final
integer ii_periodo_origen 
integer ii_anio_origen 
integer ii_periodo_destino 
integer ii_anio_destino
boolean ib_establece_origen  = false
boolean ib_establece_destino = false
end variables

forward prototypes
public function integer wf_carga_prerreq_alumnos ()
public function integer wf_corte_alumnos ()
end prototypes

public function integer wf_carga_prerreq_alumnos ();

RETURN 0

end function

public function integer wf_corte_alumnos ();// wf_corte_alumnos
//Efectua los cortes de los alumnos
integer li_return_carga
string ls_mensaje 
long ll_cuentas[], ll_row, ll_rows, ll_cuenta, ll_row2, ll_rows2
long ll_found, ll_row_insert
String  	Nivel, ls_nombre_completo
Long 	Plan, Carrera, ll_cve_mat
Integer li_carrera_plan, li_nombre_completo
Long ll_cve_carrera, ll_cve_plan
Integer ai_ya_puede_int, ai_ya_curso_int
Integer ai_ya_puede_ss, ai_ya_curso_ss
decimal ld_promedio
long ll_cve_flag_promedio
int li_corte_servicio_social
int li_corte_integracion
int li_corte_egresado, li_egresado

ll_rows = dw_cortes_cuentas.RowCount()

FOR ll_row = 1 TO ll_rows
	
	st_procesamiento.text = string(ll_row)+"/"+string(ll_rows)
	dw_cortes_cuentas.ScrollToRow(ll_row)
	ll_cuenta = dw_cortes_cuentas.GetItemNumber(ll_row, "cuenta")
	ll_cve_carrera = dw_cortes_cuentas.GetItemNumber(ll_row, "cve_carrera")
	ll_cve_plan = dw_cortes_cuentas.GetItemNumber(ll_row, "cve_plan")

//	IF cbx_egresado.Checked THEN
		li_corte_egresado = in_cortes.of_corte_egresado(  ll_cuenta, ll_cve_carrera, ll_cve_plan, gi_periodo, gi_anio, li_egresado )
		IF li_corte_egresado = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_egresado",1)
			dw_cortes_cuentas.SetItem(ll_row, "egresad",li_egresado)
			IF li_egresado = 1 THEN
				dw_cortes_cuentas.SetItem(ll_row, "periodo_egre",gi_periodo)
				dw_cortes_cuentas.SetItem(ll_row, "anio_egre",gi_anio)
			END IF
		END IF
//	END IF
	
NEXT


RETURN 0

end function

on w_cambio_periodo_primer_ingreso.create
int iCurrent
call super::create
this.st_periodo_establecido_destino=create st_periodo_establecido_destino
this.cb_establece_periodo_destino=create cb_establece_periodo_destino
this.st_periodo_establecido_origen=create st_periodo_establecido_origen
this.cb_establece_periodo_origen=create cb_establece_periodo_origen
this.uo_2=create uo_2
this.uo_1=create uo_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_3=create cb_3
this.st_avance=create st_avance
this.st_procesamiento=create st_procesamiento
this.cb_2=create cb_2
this.dw_cortes_cuentas=create dw_cortes_cuentas
this.gb_2=create gb_2
this.st_5=create st_5
this.st_6=create st_6
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_periodo_establecido_destino
this.Control[iCurrent+2]=this.cb_establece_periodo_destino
this.Control[iCurrent+3]=this.st_periodo_establecido_origen
this.Control[iCurrent+4]=this.cb_establece_periodo_origen
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.st_avance
this.Control[iCurrent+11]=this.st_procesamiento
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.dw_cortes_cuentas
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.st_4
end on

on w_cambio_periodo_primer_ingreso.destroy
call super::destroy
destroy(this.st_periodo_establecido_destino)
destroy(this.cb_establece_periodo_destino)
destroy(this.st_periodo_establecido_origen)
destroy(this.cb_establece_periodo_origen)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.st_avance)
destroy(this.st_procesamiento)
destroy(this.cb_2)
destroy(this.dw_cortes_cuentas)
destroy(this.gb_2)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_3)
destroy(this.st_4)
end on

event open;call super::open;x=1
y=1
dw_cortes_cuentas.SetTransObject(gtr_sce)
IF not isvalid(in_cortes) THEN
	in_cortes = CREATE n_cortes
END IF
end event

event close;call super::close;IF isvalid(in_cortes) THEN
	DESTROY in_cortes 
END IF
end event

type st_periodo_establecido_destino from statictext within w_cambio_periodo_primer_ingreso
integer x = 2574
integer y = 468
integer width = 722
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_establece_periodo_destino from u_cb within w_cambio_periodo_primer_ingreso
integer x = 1723
integer y = 460
integer width = 617
integer taborder = 60
boolean bringtotop = true
string text = "Establece Periodo Destino"
end type

event clicked;call super::clicked;string ls_periodo, ls_anio, ls_periodo_anio
long ll_total_items_origen, ll_total_items_destino

ii_periodo_origen = uo_2.of_obten_periodo()
ii_anio_origen = uo_2.of_obten_anio()

CHOOSE CASE ii_periodo_origen
	CASE 0
		ls_periodo= "PRIMAVERA"
	CASE 1
		ls_periodo= "VERANO"
	CASE 2
		ls_periodo= "OTOÑO"
	CASE ELSE 
		ls_periodo= "ERROR GRAVE"		
END CHOOSE

ls_periodo_anio = ls_periodo + " "+ STRING(ii_anio_origen) 

st_periodo_establecido_destino.text = ls_periodo_anio

ib_establece_destino = true
end event

type st_periodo_establecido_origen from statictext within w_cambio_periodo_primer_ingreso
integer x = 2574
integer y = 104
integer width = 722
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_establece_periodo_origen from u_cb within w_cambio_periodo_primer_ingreso
integer x = 1723
integer y = 112
integer width = 594
integer taborder = 50
boolean bringtotop = true
string text = "Establece Periodo Origen"
end type

event clicked;call super::clicked;string ls_periodo, ls_anio, ls_periodo_anio
long ll_total_items_origen, ll_total_items_destino

ii_periodo_origen = uo_1.of_obten_periodo()
ii_anio_origen = uo_1.of_obten_anio()

CHOOSE CASE ii_periodo_origen
	CASE 0
		ls_periodo= "PRIMAVERA"
	CASE 1
		ls_periodo= "VERANO"
	CASE 2
		ls_periodo= "OTOÑO"
	CASE ELSE 
		ls_periodo= "ERROR GRAVE"		
END CHOOSE

ls_periodo_anio = ls_periodo + " "+ STRING(ii_anio_origen) 

st_periodo_establecido_origen.text = ls_periodo_anio
ib_establece_origen= true
end event

type uo_2 from uo_per_ani_visual within w_cambio_periodo_primer_ingreso
integer x = 347
integer y = 420
integer taborder = 50
boolean enabled = true
end type

on uo_2.destroy
call uo_per_ani_visual::destroy
end on

type uo_1 from uo_per_ani_visual within w_cambio_periodo_primer_ingreso
integer x = 347
integer y = 80
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani_visual::destroy
end on

type st_2 from u_st within w_cambio_periodo_primer_ingreso
integer x = 73
integer y = 472
integer width = 247
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Destino"
end type

type st_1 from u_st within w_cambio_periodo_primer_ingreso
integer x = 73
integer y = 132
integer width = 247
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Origen"
end type

type cb_3 from u_cb within w_cambio_periodo_primer_ingreso
integer x = 3593
integer y = 708
integer width = 87
integer taborder = 50
boolean enabled = false
string text = "..."
end type

event clicked;call super::clicked;IF not isnull(ldtm_fecha_inicial) AND &
   not isnull(ldtm_fecha_final) THEN
	MessageBox("Periodo de Ejecución","Inicio: ["+string(ldtm_fecha_inicial,"dd/mm/yyyy hh:mm:ss")+"]~n"+&
												 "Fin   : ["+string(ldtm_fecha_final,"dd/mm/yyyy hh:mm:ss")+"]")
END IF

end event

type st_avance from u_st within w_cambio_periodo_primer_ingreso
integer x = 3035
integer y = 724
integer width = 192
string text = "Avance:"
end type

type st_procesamiento from u_st within w_cambio_periodo_primer_ingreso
integer x = 3227
integer y = 712
integer width = 352
integer height = 92
string text = ""
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from u_cb within w_cambio_periodo_primer_ingreso
integer x = 1518
integer y = 712
integer width = 649
integer taborder = 40
string text = "Corte de Cambio de Periodo"
end type

event clicked;call super::clicked;integer li_res_cortes, li_confirmacion, li_adeuda_primer_ingreso
long	ll_rowcount, ll_row, ll_cuenta
integer li_periodo_origen, li_anio_origen, li_periodo_destino, li_anio_destino
string ls_digito


if not ib_establece_origen then
	MessageBox("Establecer Origen", "Favor de establecer el periodo de origen",StopSign!)			
	return	
end if

if not ib_establece_destino then
	MessageBox("Establecer Destino", "Favor de establecer el periodo destino",StopSign!)			
	return	
end if

li_periodo_origen = uo_1.of_obten_periodo()
li_anio_origen = uo_1.of_obten_anio()

li_periodo_destino = uo_2.of_obten_periodo()
li_anio_destino = uo_2.of_obten_anio()


IF li_anio_origen > li_anio_destino THEN
	MessageBox("Error de año", "El año origen no puede ser mayor al año destino",StopSign!)			
	return
END IF

IF li_anio_origen = li_anio_destino THEN
	IF li_periodo_origen >= li_periodo_destino THEN
		MessageBox("Error de periodo", "El periodo origen no puede ser mayor ni igual al periodo destino en el mismo año",StopSign!)			
		return
	END IF
END IF

IF li_periodo_origen =1 or  li_periodo_destino = 1 THEN
	MessageBox("Error de periodo", "El periodo origen y destino no pueden ser verano",StopSign!)			
	return
END IF


ll_rowcount = dw_cortes_cuentas.Retrieve(li_periodo_origen, li_anio_origen)

li_confirmacion = 	MessageBox("Confirmación", "¿Desea efectuar los cortes de los ["+string(ll_rowcount)+"] alumnos?",Question!, YesNo!)
SetPointer(HourGlass!)
cb_3.enabled = false
ldtm_fecha_inicial = fecha_servidor(gtr_sce)
IF li_confirmacion = 1 THEN
	
	if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password) = 0 then
		return
	end if

	if conecta_bd(gtr_sfeb,gs_sfeb,gs_usuario,gs_password) = 0 then
		return
	end if
	
	FOR ll_row= 1 TO ll_rowcount
		ll_cuenta = dw_cortes_cuentas.GetItemNumber(ll_row,"academicos_cuenta")
		ls_digito = dw_cortes_cuentas.GetItemString(ll_row,"v_sce_alumno_digito_digito")
		li_adeuda_primer_ingreso = f_adeuda_primer_ingreso(ll_cuenta, li_periodo_origen, li_anio_origen, gtr_scob, gtr_sfeb)
		if li_adeuda_primer_ingreso = -1 then
			MessageBox("Error de Corte", "Error al efectuar el corte del alumno ["+string(ll_cuenta)+ls_digito+"]",StopSign!)			
			Goto Desconexion
			return
		end if
		dw_cortes_cuentas.SetItem(ll_row, "adeuda_finanzas", li_adeuda_primer_ingreso)
		st_procesamiento.text = string(ll_row)+"/"+string(ll_rowcount)
		if li_adeuda_primer_ingreso = 1 then
			dw_cortes_cuentas.SetItem(ll_row, "academicos_periodo_ing", li_periodo_destino)
			dw_cortes_cuentas.SetItem(ll_row, "academicos_anio_ing", li_anio_destino)			
		end if
	NEXT
	
	IF li_res_cortes = 0 THEN
		MessageBox("Ejecución Exitosa", "Se ha efectuado el corte de los ["+string(ll_rowcount)+"] alumnos",Information!)
	ELSEIF li_adeuda_primer_ingreso = -1 THEN
		MessageBox("Error de Ejecución", "No es posible continuar con la ejecución de los cortes",StopSign!)
	END IF
ELSE
	MessageBox("Sin actualización", "No se han efectuado los cortes",Information!)
END IF
ldtm_fecha_final= fecha_servidor(gtr_sce)
cb_3.enabled = true

Desconexion:
if isvalid(gtr_scob) then
	if desconecta_bd(gtr_scob) = 0 then
		return
	end if
end if

if isvalid(gtr_scob) then
	if desconecta_bd(gtr_sfeb) = 0 then
		return
	end if
end if




end event

type dw_cortes_cuentas from u_dw within w_cambio_periodo_primer_ingreso
integer x = 178
integer y = 840
integer width = 3419
integer height = 680
integer taborder = 20
string dataobject = "d_cambio_periodo_primer_ingreso"
boolean hscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean righttoleft = true
end type

event dberror;MessageBox("Codigo ["+string(sqldbcode)+"]", sqlerrtext +"~n "+ sqlsyntax, StopSign!)

return 0
end event

type gb_2 from groupbox within w_cambio_periodo_primer_ingreso
integer x = 23
integer width = 1637
integer height = 636
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "Periodo de Ingreso"
end type

type st_5 from statictext within w_cambio_periodo_primer_ingreso
integer x = 1088
integer y = 252
integer width = 73
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "||"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_cambio_periodo_primer_ingreso
integer x = 1088
integer y = 316
integer width = 73
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "V"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_cambio_periodo_primer_ingreso
integer x = 526
integer y = 252
integer width = 73
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "||"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_cambio_periodo_primer_ingreso
integer x = 526
integer y = 316
integer width = 73
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "V"
alignment alignment = center!
boolean focusrectangle = false
end type

