$PBExportHeader$w_alumnos_inscritos_previamente.srw
forward
global type w_alumnos_inscritos_previamente from w_main
end type
type cbx_fec_nac from checkbox within w_alumnos_inscritos_previamente
end type
type cbx_sexo from checkbox within w_alumnos_inscritos_previamente
end type
type cbx_nombre from checkbox within w_alumnos_inscritos_previamente
end type
type cbx_materno from checkbox within w_alumnos_inscritos_previamente
end type
type cbx_paterno from checkbox within w_alumnos_inscritos_previamente
end type
type cbx_por_fecha from checkbox within w_alumnos_inscritos_previamente
end type
type dw_fecha_examen from datawindow within w_alumnos_inscritos_previamente
end type
type uo_1 from uo_ver_per_ani within w_alumnos_inscritos_previamente
end type
type dw_reporte from uo_dw_reporte within w_alumnos_inscritos_previamente
end type
type gb_1 from groupbox within w_alumnos_inscritos_previamente
end type
end forward

global type w_alumnos_inscritos_previamente from w_main
integer x = 832
integer y = 364
integer width = 5294
integer height = 2412
string title = "Alumnos Inscritos Previamente"
string menuname = "m_menu"
long backcolor = 67108864
boolean ib_disableclosequery = true
cbx_fec_nac cbx_fec_nac
cbx_sexo cbx_sexo
cbx_nombre cbx_nombre
cbx_materno cbx_materno
cbx_paterno cbx_paterno
cbx_por_fecha cbx_por_fecha
dw_fecha_examen dw_fecha_examen
uo_1 uo_1
dw_reporte dw_reporte
gb_1 gb_1
end type
global w_alumnos_inscritos_previamente w_alumnos_inscritos_previamente

type variables
transaction itr_admision_web


end variables

forward prototypes
public function integer f_recupera_fechas ()
public function datawindowchild f_inicializa_dwc (string as_columna)
end prototypes

public function integer f_recupera_fechas ();DataWindowChild ldwc_fechas
Long ll_resultado, ll_count
String ls_campo

dw_fecha_examen.Reset()
dw_fecha_examen.InsertRow(0)
ldwc_fechas = f_inicializa_dwc("id_examen")

ldwc_fechas.SetTransObject(itr_admision_web) 
ll_count = ldwc_fechas.Retrieve(gi_version,gi_periodo, gi_anio)

RETURN ll_count



end function

public function datawindowchild f_inicializa_dwc (string as_columna);DataWindowChild ldwc_fechas
Long ll_resultado

ll_resultado = dw_fecha_examen.GetChild(as_columna, ldwc_fechas) 

IF ll_resultado = -1 THEN 
	MessageBox("Error", "Not a DataWindowChild: " + as_columna)
END IF

RETURN ldwc_fechas

end function

on w_alumnos_inscritos_previamente.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_fec_nac=create cbx_fec_nac
this.cbx_sexo=create cbx_sexo
this.cbx_nombre=create cbx_nombre
this.cbx_materno=create cbx_materno
this.cbx_paterno=create cbx_paterno
this.cbx_por_fecha=create cbx_por_fecha
this.dw_fecha_examen=create dw_fecha_examen
this.uo_1=create uo_1
this.dw_reporte=create dw_reporte
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_fec_nac
this.Control[iCurrent+2]=this.cbx_sexo
this.Control[iCurrent+3]=this.cbx_nombre
this.Control[iCurrent+4]=this.cbx_materno
this.Control[iCurrent+5]=this.cbx_paterno
this.Control[iCurrent+6]=this.cbx_por_fecha
this.Control[iCurrent+7]=this.dw_fecha_examen
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.dw_reporte
this.Control[iCurrent+10]=this.gb_1
end on

on w_alumnos_inscritos_previamente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_fec_nac)
destroy(this.cbx_sexo)
destroy(this.cbx_nombre)
destroy(this.cbx_materno)
destroy(this.cbx_paterno)
destroy(this.cbx_por_fecha)
destroy(this.dw_fecha_examen)
destroy(this.uo_1)
destroy(this.dw_reporte)
destroy(this.gb_1)
end on

event open;Integer li_conexion 

dw_reporte.dataobject = "dw_alumnos_inscritos_previamente"
dw_reporte.settransobject(gtr_sadm)

li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
IF li_conexion <>1 THEN
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	CLOSE(This)
END IF

end event

event close;call super::close;IF isvalid(itr_admision_web) THEN
	DISCONNECT USING itr_admision_web;
END IF
end event

type cbx_fec_nac from checkbox within w_alumnos_inscritos_previamente
integer x = 3643
integer y = 72
integer width = 608
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Fecha Nacimiento"
boolean checked = true
end type

type cbx_sexo from checkbox within w_alumnos_inscritos_previamente
integer x = 4617
integer y = 72
integer width = 270
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Sexo"
end type

type cbx_nombre from checkbox within w_alumnos_inscritos_previamente
integer x = 4279
integer y = 72
integer width = 320
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Nombre"
end type

type cbx_materno from checkbox within w_alumnos_inscritos_previamente
integer x = 3026
integer y = 72
integer width = 581
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Apellido Materno"
boolean checked = true
end type

type cbx_paterno from checkbox within w_alumnos_inscritos_previamente
integer x = 2414
integer y = 72
integer width = 581
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Apellido Paterno"
boolean checked = true
end type

type cbx_por_fecha from checkbox within w_alumnos_inscritos_previamente
integer x = 2414
integer y = 176
integer width = 654
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Por Fecha Examen:"
end type

event clicked;IF checked THEN 
	dw_fecha_examen.enabled = True
	f_recupera_fechas()
ELSE 
	dw_fecha_examen.enabled = False
	dw_fecha_examen.reset( )
END IF 

	
	
	
end event

type dw_fecha_examen from datawindow within w_alumnos_inscritos_previamente
integer x = 3072
integer y = 172
integer width = 1202
integer height = 100
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_ver_per_ani within w_alumnos_inscritos_previamente
integer x = 5
integer y = 8
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()

RETURN 

end event

type dw_reporte from uo_dw_reporte within w_alumnos_inscritos_previamente
integer x = 9
integer y = 328
integer width = 5230
integer height = 1868
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_alumnos_inscritos_previamente"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
end type

event carga;Long ll_id_examen, ll_cbx_paterno, ll_cbx_materno, ll_cbx_fec_nac, ll_cbx_nombre, ll_cbx_sexo, ll_count

// FECHA EXAMEN
IF cbx_por_fecha.checked THEN 
	ll_id_examen = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
	
	IF IsNull(ll_id_examen) OR ll_id_examen = 0 THEN 
		MessageBox("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
		RETURN -1
	END IF	
ELSE
	SetNull(ll_id_examen)
END IF

// PATERNO
IF cbx_paterno.checked THEN 
	ll_cbx_paterno = 1
END IF	

// MATERNO
IF cbx_materno.checked THEN 
	ll_cbx_materno = 1
END IF	

// FECHA NACIMIENTO
IF cbx_fec_nac.checked THEN 
	ll_cbx_fec_nac = 1
END IF	

// FECHA NOMBRE
IF cbx_nombre.checked THEN 
	ll_cbx_nombre = 1
END IF	

// FECHA NOMBRE
IF cbx_sexo.checked THEN 
	ll_cbx_sexo = 1
END IF	

dw_reporte.dataobject = "dw_alumnos_inscritos_previamente"
dw_reporte.setTransobject(gtr_sadm)
ll_count = dw_reporte.retrieve(gi_version, gi_periodo, gi_anio, ll_id_examen, ll_cbx_paterno, ll_cbx_materno, ll_cbx_fec_nac, ll_cbx_nombre, ll_cbx_sexo)

String ls_rownumber, ls_displayvalue

//ls_rownumber = string(dw_1.getrow())
ls_rownumber = "1"
ls_displayvalue = This.describe("Evaluate( 'lookupdisplay(num_cuentas) ', "+ls_rownumber+" )")

RETURN ll_count


end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event clicked;call super::clicked;String ls_sort_ant, ls_columna, ls_tipo_sort
Long ll_num_cuentas, ll_cuenta

IF Right(dwo.Name,2) = "_t"  THEN
	ls_columna = LEFT(dwo.Name, LEN(String(dwo.Name)) - 2)
	ls_sort_ant = THIS.Describe("Datawindow.Table.sort") 
	
	IF ls_columna = LEFT(ls_sort_ant, LEN(ls_sort_ant) - 2) THEN
		ls_tipo_sort = RIGHT(ls_sort_ant, 1)
		
		IF ls_tipo_sort = 'A' THEN 
			ls_tipo_sort = 'D' 
		ELSE 
			ls_tipo_sort = 'A' 
		END IF 
		
		This.SetSort(ls_columna + " " + ls_tipo_sort) 
	ELSE
		This.SetSort(ls_columna + " A") 
	END IF
	
	THIS.Sort() 
ELSE
	IF row > 0 AND Long(This.Object.DataWindow.HorizontalScrollSplit) = 0 THEN 
		THIS.SelectRow (0, FALSE)
		THIS.SelectRow (row, TRUE)
	ELSE
		THIS.SelectRow (0, FALSE)
	END IF
	
	IF dwo.Name = "muestra_ventana" THEN 
		ll_num_cuentas = THIS.getItemNumber(row, "num_cuentas")
		ll_cuenta = THIS.getItemNumber(row, "cuenta_alumno")

		IF ll_num_cuentas > 1 THEN 
			OpenWithParm(w_cuentas_reg_ant, ll_cuenta)
		END IF			
	END IF		
END IF


end event

type gb_1 from groupbox within w_alumnos_inscritos_previamente
integer x = 2345
integer width = 2889
integer height = 324
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
end type

