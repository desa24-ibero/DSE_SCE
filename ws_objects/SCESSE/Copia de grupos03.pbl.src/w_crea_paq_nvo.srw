$PBExportHeader$w_crea_paq_nvo.srw
forward
global type w_crea_paq_nvo from window
end type
type dw_mini_horario_aux from datawindow within w_crea_paq_nvo
end type
type dw_imprime_horario from datawindow within w_crea_paq_nvo
end type
type cb_1 from commandbutton within w_crea_paq_nvo
end type
type rb_todas_materias from radiobutton within w_crea_paq_nvo
end type
type rb_materias_primer_semestre from radiobutton within w_crea_paq_nvo
end type
type cb_filtra_carrera from commandbutton within w_crea_paq_nvo
end type
type st_1 from statictext within w_crea_paq_nvo
end type
type dw_horario_paquete_visual from datawindow within w_crea_paq_nvo
end type
type st_carrera from statictext within w_crea_paq_nvo
end type
type st_periodo from statictext within w_crea_paq_nvo
end type
type uo_per_ani_i from uo_per_ani within w_crea_paq_nvo
end type
type dw_3 from datawindow within w_crea_paq_nvo
end type
type dw_2 from datawindow within w_crea_paq_nvo
end type
type dw_1 from datawindow within w_crea_paq_nvo
end type
type dw_4 from datawindow within w_crea_paq_nvo
end type
type cb_actualiza_periodo from commandbutton within w_crea_paq_nvo
end type
type uo_carreras_i from uo_carreras within w_crea_paq_nvo
end type
end forward

global type w_crea_paq_nvo from window
boolean visible = false
integer x = 5
integer y = 12
integer width = 4658
integer height = 2916
boolean titlebar = true
string title = "Creación de Horarios"
string menuname = "m_menu"
long backcolor = 67108864
dw_mini_horario_aux dw_mini_horario_aux
dw_imprime_horario dw_imprime_horario
cb_1 cb_1
rb_todas_materias rb_todas_materias
rb_materias_primer_semestre rb_materias_primer_semestre
cb_filtra_carrera cb_filtra_carrera
st_1 st_1
dw_horario_paquete_visual dw_horario_paquete_visual
st_carrera st_carrera
st_periodo st_periodo
uo_per_ani_i uo_per_ani_i
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
dw_4 dw_4
cb_actualiza_periodo cb_actualiza_periodo
uo_carreras_i uo_carreras_i
end type
global w_crea_paq_nvo w_crea_paq_nvo

type variables
string salones[]
int num_salones
integer ii_insertando

integer ii_periodo 
integer ii_anio 

integer ii_semestre_ideal = 1, ii_cve_plan = 6

long il_cve_coordinacion, il_cve_carrera
string is_carrera

Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original
//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"


end variables

forward prototypes
public subroutine wf_actualiza_horario ()
public function long wf_ultimo_paquete_insertado (long al_cve_carrera)
end prototypes

public subroutine wf_actualiza_horario ();//wf_actualiza_horario
//Actualiza el horario visual

integer li_periodo, li_anio, li_num_paq
string ls_array_horario[7,15], ls_elemento_array, ls_horario, ls_carrera
long ll_currentrow, ll_rowcount
long ll_dia_actual
long ll_hora_actual, ll_hora_sig
long ll_row_actual, ll_hora_relativa, ll_factor_hora, ll_dia_relativo, ll_factor_dia
long  ll_hora_menor = 7, ll_hora_mayor = 21, ll_cve_dia_menor = 1, ll_cve_dia_mayor =6, ll_indice_horario =7, ll_indice_dia =1 
long ll_cve_carrera
integer li_actualiza_horario

li_anio = ii_anio
li_periodo = ii_periodo

ll_rowcount = dw_1.RowCount()

if  ll_rowcount > 0 then

	ll_currentrow = dw_1.GetRow()

	if ll_currentrow >0 then

		li_num_paq = dw_1.object.num_paq[ll_currentrow]
		
		li_actualiza_horario = f_actualiza_horario(ii_periodo, ii_anio, li_num_paq, dw_horario_paquete_visual,false)
		return
		
	end if
end if


end subroutine

public function long wf_ultimo_paquete_insertado (long al_cve_carrera);//wf_ultimo_paquete_insertado
//Recibe
//	long	al_cve_carrera	
long ll_row_actual= 1, ll_row_anterior = 0, ll_num_rows

ll_num_rows = dw_1.RowCount()
ll_row_actual = dw_1.Find("clv_carr ="+string(al_cve_carrera), 1, ll_num_rows)

do while ll_row_actual >0
	ll_row_anterior = ll_row_actual
	IF ll_row_actual >= ll_num_rows THEN EXIT
	ll_row_actual = dw_1.Find("clv_carr ="+string(al_cve_carrera), ll_row_anterior + 1, ll_num_rows)
loop

return ll_row_anterior





end function

on w_crea_paq_nvo.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_mini_horario_aux=create dw_mini_horario_aux
this.dw_imprime_horario=create dw_imprime_horario
this.cb_1=create cb_1
this.rb_todas_materias=create rb_todas_materias
this.rb_materias_primer_semestre=create rb_materias_primer_semestre
this.cb_filtra_carrera=create cb_filtra_carrera
this.st_1=create st_1
this.dw_horario_paquete_visual=create dw_horario_paquete_visual
this.st_carrera=create st_carrera
this.st_periodo=create st_periodo
this.uo_per_ani_i=create uo_per_ani_i
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_4=create dw_4
this.cb_actualiza_periodo=create cb_actualiza_periodo
this.uo_carreras_i=create uo_carreras_i
this.Control[]={this.dw_mini_horario_aux,&
this.dw_imprime_horario,&
this.cb_1,&
this.rb_todas_materias,&
this.rb_materias_primer_semestre,&
this.cb_filtra_carrera,&
this.st_1,&
this.dw_horario_paquete_visual,&
this.st_carrera,&
this.st_periodo,&
this.uo_per_ani_i,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.dw_4,&
this.cb_actualiza_periodo,&
this.uo_carreras_i}
end on

on w_crea_paq_nvo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_mini_horario_aux)
destroy(this.dw_imprime_horario)
destroy(this.cb_1)
destroy(this.rb_todas_materias)
destroy(this.rb_materias_primer_semestre)
destroy(this.cb_filtra_carrera)
destroy(this.st_1)
destroy(this.dw_horario_paquete_visual)
destroy(this.st_carrera)
destroy(this.st_periodo)
destroy(this.uo_per_ani_i)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_4)
destroy(this.cb_actualiza_periodo)
destroy(this.uo_carreras_i)
end on

event open;x = 1
y = 1
gtr_sadm = gtr_sce
long ll_row
int li_retorno, li_periodo, li_anio, li_coord_usuario, li_cve_carrera
string ls_carrera
int li_chk

//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,"SCE",gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return



//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), "SCE")
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//Cambio por Ajustes en Línea
//1)<-

//Habilita la seguridad para la ventana actual

/**/gnv_app.inv_security.of_SetSecurity(this)
                                                                            
li_retorno = f_obten_periodo(li_periodo, li_anio, 4)

li_coord_usuario = f_obten_coord_de_usuario(gs_usuario)
li_cve_carrera = f_obten_carrera_de_coord(li_coord_usuario, ls_carrera)
il_cve_coordinacion = li_coord_usuario
il_cve_carrera = li_cve_carrera
is_carrera = ls_carrera

uo_carreras_i.visible = true
st_carrera.text =  ls_carrera
////li_coord_usuario = uo_1.ii_cve_coordinacion
////ii_coord_usuario = li_coord_usuario

if li_retorno = -1 then
	MessageBox("Error en calendario", "No es posible leer el periodo de carga de coordinadores",StopSign!)
	if li_coord_usuario <> 9999 then
		close(this	)
	end if
end if

//si el usuario es coordinador, no puede modificar el periodo
if li_coord_usuario <> 9999 then
	uo_carreras_i.visible= false
	cb_actualiza_periodo.visible= false
	cb_actualiza_periodo.event clicked()
	st_carrera.visible = true
	cb_filtra_carrera.visible = false 
	uo_per_ani_i.visible = false 
	dw_1.Object.clv_carr.Protect=1
	dw_1.Object.clv_plan.Protect=1
else
	uo_carreras_i.visible= true
	cb_actualiza_periodo.visible= true
	cb_actualiza_periodo.event clicked()
	st_carrera.visible = false
	cb_filtra_carrera.visible = true 
	uo_per_ani_i.visible = true
	dw_1.Object.clv_carr.Protect=0
	dw_1.Object.clv_plan.Protect=0
end if

gi_anio=li_anio
gi_periodo=li_periodo

ii_anio=li_anio
ii_periodo=li_periodo

uo_per_ani_i.em_ani.text = string(gi_anio)
uo_per_ani_i.em_per.text = string(gi_periodo)

//ll_row= dw_1.InsertRow(0)
//dw_1.ScrollToRow(ll_row) 
////cb_1.TriggerEvent(Clicked!)

//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase
dw_1.SetTransObject(gtr_sce)
dw_2.SetTransObject(gtr_sce)
dw_3.SetTransObject(gtr_sce)
dw_4.SetTransObject(gtr_sce)

dw_horario_paquete_visual.SetTransObject(gtr_sce)
dw_imprime_horario.SetTransObject(gtr_sce)
dw_mini_horario_aux.SetTransObject(gtr_sce)

f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

//Cambio por Ajustes en Línea
//2)<-

uo_carreras_i.event constructor()

cb_actualiza_periodo.event clicked()

dw_1.event carga(il_cve_carrera)


end event

event close;//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,"SCE",gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), "SCE")
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//f_obten_titulo_ajustes(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)
//Cambio por Ajustes en Línea
//3)<-

end event

type dw_mini_horario_aux from datawindow within w_crea_paq_nvo
boolean visible = false
integer x = 2775
integer y = 240
integer width = 686
integer height = 400
integer taborder = 90
string dataobject = "d_horario_visual_paquete_ext_2"
boolean resizable = true
boolean livescroll = true
end type

event constructor;this.SetTransObject(gtr_sce)
end event

type dw_imprime_horario from datawindow within w_crea_paq_nvo
boolean visible = false
integer x = 1915
integer y = 1620
integer width = 1595
integer height = 400
integer taborder = 80
string title = "none"
string dataobject = "d_composite_horario_1_ingreso"
boolean resizable = true
boolean livescroll = true
end type

event constructor;this.settransobject(gtr_sce)
end event

type cb_1 from commandbutton within w_crea_paq_nvo
integer x = 1915
integer y = 1488
integer width = 535
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Horario Actual"
end type

event clicked;integer li_confirmacion, ll_num_rows, ll_row_actual, li_num_paq, li_horario, li_retrieve, li_retrieve2
DataWindowChild dw_mini_horario, dw_encabezado, dw_pie
integer rtncode, rtncode2, rtncode3, li_materias_abiertas, li_materias_1s
string ls_mensaje
blob lb_definicion
  
		  
li_confirmacion = MessageBox("Impresión","¿Desea imprimir el paquete actual?",Question!,YesNo!)

if li_confirmacion<>1 then
	MessageBox("Aviso","Se CANCELO la impresión",Information!)
	return
end if

ll_num_rows= dw_1.RowCount()

if ll_num_rows>0 then
	SetPointer(HourGlass!)
	ll_row_actual = dw_1.GetRow()
	li_num_paq = dw_1.GetItemNumber(ll_row_actual,"num_paq")
	if li_num_paq <= 0 then
		MessageBox("Paquete Inválido","Favor de actualizar el paquete antes de imprimir",Stopsign!)
		return			
	end if

	rtncode = dw_imprime_horario.GetChild('dw_encabezado', dw_encabezado)

	IF rtncode = -1 THEN 
		MessageBox("Error", "No es posible generar el horario del paquete (encabezado)")
		return
	end if
	
	dw_encabezado.SetTransObject(gtr_sce)
	li_retrieve = dw_encabezado.Retrieve(li_num_paq, ii_periodo, ii_anio)

	rtncode2 = dw_imprime_horario.GetChild('dw_mini_horario', dw_mini_horario)

	IF rtncode2 = -1 THEN 
		MessageBox("Error", "No es posible generar el horario del paquete (horario)")
		return
	end if

	rtncode3 = dw_imprime_horario.GetChild('dw_pie', dw_pie)

	IF rtncode3 = -1 THEN 
		MessageBox("Error", "No es posible generar el horario del paquete (pie)")
		return
	end if
	
	dw_pie.SetTransObject(gtr_sce)
	li_retrieve2 = dw_pie.Retrieve(li_num_paq, ii_periodo, ii_anio)

	li_horario = f_actualiza_horario(ii_periodo,ii_anio,li_num_paq,dw_mini_horario_aux,true)
	if li_horario <> 0 then
		MessageBox("Paquete Inválido","No es posible generar el horario del paquete",Stopsign!)
		return			
	end if

	dw_mini_horario_aux.ShareData(dw_mini_horario)
//	li_horario = f_actualiza_horario_child(ii_periodo,ii_anio,li_num_paq,dw_mini_horario)
//	if li_horario <> 0 then
//		MessageBox("Paquete Inválido","No es posible generar el horario del paquete",Stopsign!)
//		return			
//	end if

	li_materias_abiertas= f_obten_materias_abiertas_1s(ii_periodo, ii_anio, li_num_paq)
	li_materias_1s = f_obten_materias_sem_id_1s(li_num_paq)

	ls_mensaje = "Se han asignado ["+string(li_materias_abiertas)+"] materias de un total de ["+string(li_materias_1s)+"] correspondientes al primer semestre."
	dw_imprime_horario.Object.t_mensaje.Text = ls_mensaje

	dw_imprime_horario.Print()
	SetPointer(Arrow!)
else
	MessageBox("Sin Paquetes","NO existen paquetes a imprimir",Stopsign!)
	return	
end if
end event

type rb_todas_materias from radiobutton within w_crea_paq_nvo
integer x = 933
integer y = 740
integer width = 1102
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todas las Materias (Sin prerrequisitos)"
end type

event clicked;long ll_cve_carrera, ll_cve_plan, ll_getrow, ll_rowcount
integer li_anio, li_periodo, li_num_paq

li_anio = ii_anio
li_periodo = ii_periodo
ll_getrow = dw_1.Getrow()
ll_rowcount = dw_1.rowcount()

if  (ll_getrow>0 and ll_rowcount>0) then
	
	ll_cve_carrera = dw_1.object.clv_carr[ll_getrow]
	ll_cve_plan = dw_1.object.clv_plan[ll_getrow]
	li_num_paq = dw_1.object.num_paq[ll_getrow]
	
	if (ll_getrow>0 and ll_rowcount>0) then
		dw_3.event carga(ll_cve_carrera,ll_cve_plan, li_periodo, li_anio, ii_semestre_ideal)
		dw_4.event carga(ll_cve_carrera,ll_cve_plan)
		dw_2.event carga(9999,li_num_paq)
	end if
	
end if

end event

type rb_materias_primer_semestre from radiobutton within w_crea_paq_nvo
integer x = 41
integer y = 740
integer width = 859
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materias de Primer Semestre"
boolean checked = true
end type

event clicked;long ll_cve_carrera, ll_cve_plan, ll_getrow, ll_rowcount
integer li_anio, li_periodo, li_num_paq

li_anio = ii_anio
li_periodo = ii_periodo
ll_getrow = dw_1.Getrow()
ll_rowcount = dw_1.rowcount()

if  (ll_getrow>0 and ll_rowcount>0) then
	
	ll_cve_carrera = dw_1.object.clv_carr[ll_getrow]
	ll_cve_plan = dw_1.object.clv_plan[ll_getrow]
	li_num_paq = dw_1.object.num_paq[ll_getrow]
	
	if (ll_getrow>0 and ll_rowcount>0) then
		dw_3.event carga(ll_cve_carrera,ll_cve_plan, li_periodo, li_anio, ii_semestre_ideal)
		dw_4.event carga(ll_cve_carrera,ll_cve_plan)
		dw_2.event carga(9999,li_num_paq)
	end if
	
end if


end event

type cb_filtra_carrera from commandbutton within w_crea_paq_nvo
integer x = 1509
integer y = 104
integer width = 251
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtra"
end type

event clicked;long ll_cve_carrera, ll_rows

ll_cve_carrera = uo_carreras_i.of_obten_cve_carrera()
il_cve_carrera = ll_cve_carrera
dw_1.event carga(ll_cve_carrera)

return

end event

type st_1 from statictext within w_crea_paq_nvo
integer x = 2482
integer y = 1112
integer width = 110
integer height = 64
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "=>"
boolean focusrectangle = false
end type

type dw_horario_paquete_visual from datawindow within w_crea_paq_nvo
integer x = 41
integer y = 1480
integer width = 1778
integer height = 784
integer taborder = 60
boolean titlebar = true
string title = "Horario"
string dataobject = "d_horario_visual_paquete_ext"
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(gtr_sce)
end event

type st_carrera from statictext within w_crea_paq_nvo
integer x = 50
integer y = 104
integer width = 1710
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_periodo from statictext within w_crea_paq_nvo
integer x = 567
integer width = 681
integer height = 76
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event constructor;ii_periodo = gi_periodo
ii_anio = gi_anio

end event

type uo_per_ani_i from uo_per_ani within w_crea_paq_nvo
integer x = 1824
integer y = 44
integer taborder = 1
boolean enabled = true
end type

on uo_per_ani_i.destroy
call uo_per_ani::destroy
end on

type dw_3 from datawindow within w_crea_paq_nvo
event carga ( integer a_cve_carrera,  integer a_cve_plan,  integer a_periodo,  integer a_anio,  integer a_sem_ideal )
integer x = 41
integer y = 844
integer width = 2437
integer height = 600
string dataobject = "d_grupos_materia_paq"
boolean vscrollbar = true
boolean livescroll = true
end type

event carga(integer a_cve_carrera, integer a_cve_plan, integer a_periodo, integer a_anio, integer a_sem_ideal);//Carga()
//Recibe:
//		a_cve_carrera 	integer
//		a_cve_plan 		integer
//		a_periodo 		integer
//		a_anio			integer
//		a_sem_ideal		integer

long ll_rows , a,b
string ls_datawindow_object = ""

if rb_materias_primer_semestre.checked then 
	ls_datawindow_object = 'd_grupos_materia_paq'
elseif rb_todas_materias.checked then 
	ls_datawindow_object = 'd_grupos_materia_paq_tot'
	a_sem_ideal = 9999
end if

this.dataobject = ls_datawindow_object
this.SetTransObject(gtr_sce)

ll_rows = retrieve(a_cve_carrera, a_cve_plan, a_periodo, a_anio, a_sem_ideal)

a= b

end event

event doubleclicked;long ll_renglon_paq, ll_renglon_actual, ll_registros_paq_mat
integer li_paquete,  li_inserta_paq_mat
long ll_cve_mat, ll_num_grupos

ll_renglon_paq = dw_1.GetRow()	

if this.RowCount()> 0 then
	li_paquete = dw_1.object.num_paq[ll_renglon_paq]

	ll_renglon_actual =this.GetRow()

	ll_cve_mat = this.object.cve_mat[ll_renglon_actual]
	ll_num_grupos = this.object.num_grupos[ll_renglon_actual]

	if ll_renglon_actual>0 then
//	ll_registros_paq_mat = dw_2.event carga(ll_cve_mat, li_paquete)
		if li_paquete = 0 then
			MessageBox ("Falta Actualizar el paquete", "Favor de actualizar el paquete antes de asignarle materias",Information!)
			return						
		end if
		if ll_registros_paq_mat = 0 then
			if ll_num_grupos = 0 then
				MessageBox ("Error", "No existen grupos disponibles de la materia ["+string(ll_cve_mat)+"]")
				return			
			end if
			ii_insertando = 1
			dw_2.event inserta_registro(li_paquete, ll_cve_mat)
			if li_inserta_paq_mat =-1 then
				MessageBox ("Error", "Error al insertar registro en datawindow de paquetes_materias")
				return
			else
//Comentado para probar si eliminando el mensaje e actualizar se acelera el proceso				
//				if dw_2.event actualiza() = 1 then
//					ii_insertando = 0
//					dw_2.SetFocus()
//				else
					dw_2.SetFocus()
					dw_2.Setcolumn("grupo")
					return
//				end if
			end if
		else
			MessageBox ("Error", "La materia seleccionada ya existe para ese numero de paquete")
		end if	
//	ll_registros_paq_mat = dw_2.event carga(9999, li_paquete)		
//	dw_2.event sel_registro(li_paquete, ll_cve_mat)
	end if
end if

return


end event

event constructor;dw_3.settransobject(gtr_sce)
end event

type dw_2 from datawindow within w_crea_paq_nvo
event type integer actualiza ( )
event type long carga ( long clv_mat,  integer a_num_paq )
event inserta_registro ( integer a_num_paq,  long a_clv_mat )
event sel_registro ( integer a_num_paq,  long a_clv_mat )
integer x = 2592
integer y = 844
integer width = 2016
integer height = 600
string dataobject = "d_paquetes_materias"
boolean vscrollbar = true
boolean livescroll = true
end type

event type integer actualiza(); //dw_1.event actualiza()
boolean lb_exito_actual
long ll_numrows, ll_indice
integer li_num_paq, li_codigo_sql, li_periodo, li_anio, li_primer_sem
long ll_cve_mat, ll_row
string ls_mensaje_sql, ls_grupo
long ll_cupo_grupo
ll_numrows = this.RowCount()

li_periodo = gi_periodo
li_anio = gi_anio

AcceptText()

FOR ll_row = 1 TO ll_numrows
	ll_cve_mat = this.GetItemNumber(ll_row, "clv_mat")
	ls_grupo = this.GetItemString(ll_row, "grupo")
	if isnull(ls_grupo) or len(ls_grupo)= 0 then
		MessageBox("Grupo Inválido", "Favor de seleccionar un grupo para la materia ["+string(ll_cve_mat)+"]",StopSign!)
		ScrollToRow(ll_row)
		SetColumn("grupo")
		return -1
	end if
NEXT 


if update(true) = 1 then		
	commit using gtr_sadm;
	lb_exito_actual = true
else
	rollback using gtr_sadm;
	messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	lb_exito_actual = false
end if

if lb_exito_actual = false then
	return	-1
end if

if ii_insertando = 1 then
	return 1
end if

li_primer_sem= 1

for ll_indice = 1 to ll_numrows 
	li_num_paq = this.object.num_paq[ll_indice]
	ls_grupo = this.object.grupo[ll_indice]
	ll_cve_mat = this.object.clv_mat[ll_indice]

	UPDATE grupos
	SET primer_sem = :li_num_paq
	FROM grupos
	WHERE (grupos.periodo = :li_periodo ) AND
			(grupos.anio = :li_anio ) AND
			(grupos.gpo = :ls_grupo) AND
			(grupos.cve_mat = :ll_cve_mat) AND
			(grupos.cond_gpo = 1)    
	USING gtr_sce;
	
	li_codigo_sql = gtr_sce.SqlCode
	ls_mensaje_sql = gtr_sce.SqlErrText
	
	
	if li_codigo_sql <> -1 then
		commit using gtr_sce;
	else
		rollback using gtr_sce;
		messagebox("Error al actualizar grupos",ls_mensaje_sql)	
	end if	
	
	ll_cupo_grupo = f_obten_cupo_grupo(ll_cve_mat, ls_grupo, li_periodo, li_anio)
	this.SetItem(ll_indice, "cupo_grupo", ll_cupo_grupo)

next

return 1

//dw_1.event actualiza()
//AcceptText()
////if ModifiedCount()+DeletedCount() > 0 Then
//	if update(true) = 1 then		
//		commit using gtr_sce;
//	else
//		rollback using gtr_sce;
//		messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
//	end if
////end if

end event

event carga;long ll_num_rows
integer li_periodo, li_anio

li_periodo = gi_periodo
li_anio = gi_anio


//dw_2.event actualiza()
//retrieve(clv_mat,gi_periodo,gi_anio)
ll_num_rows = retrieve(clv_mat, a_num_paq, li_periodo, li_anio)

return ll_num_rows



end event

event inserta_registro(integer a_num_paq, long a_clv_mat);long ll_newrow, ll_row, ll_numrows, ll_cve_mat
integer li_anio, li_periodo
string ls_nombre_materia, ls_grupo

ll_numrows = this.RowCount()

FOR ll_row = 1 TO ll_numrows
	ll_cve_mat = this.GetItemNumber(ll_row, "clv_mat")
	if ll_cve_mat = a_clv_mat then
		MessageBox("Materia Repetida", "La materia ["+string(ll_cve_mat)+"] ya se encuentra dada de alta",StopSign!)
		ScrollToRow(ll_row)
		return 
	end if
NEXT 



li_anio = ii_anio
li_periodo = ii_periodo

ll_newrow = this.InsertRow(0)
this.ScrollToRow(ll_newrow)
this.SetItem(ll_newrow, "anio", li_anio)
this.SetItem(ll_newrow, "clv_per", li_periodo)
this.SetItem(ll_newrow, "num_paq", a_num_paq)
this.SetItem(ll_newrow, "clv_mat", a_clv_mat)

ls_nombre_materia = f_obten_nombre_materia(a_clv_mat)

this.SetItem(ll_newrow, "materia", ls_nombre_materia)

ii_insertando = 0  

this.event rowfocuschanged(ll_newrow)





end event

event sel_registro;long ll_reg_actual, ll_num_registros, ll_registro_sel

ll_num_registros= this.RowCount()
ll_registro_sel= ll_num_registros

for ll_reg_actual= 1 to ll_num_registros
	if this.object.num_paq[ll_reg_actual]= a_num_paq and &
		this.object.clv_mat[ll_reg_actual]= a_clv_mat then
			ll_registro_sel= ll_reg_actual
			Exit
	end if
next

this.SetFocus()
this.ScrollToRow(ll_registro_sel)
this.SetColumn(3)


end event

event constructor;dw_2.settransobject(gtr_sce)
end event

event doubleclicked;long li_num_paq, li_renglon_paquetes, li_renglon_actual, li_codigo_sql, li_delete
integer li_borrar
string ls_mensaje_sql
/*Borra el renglón actual*/
if this.RowCount()>0 then
	
	li_renglon_actual= this.GetRow()

	this.SelectRow(li_renglon_actual, TRUE)

	li_borrar = MessageBox("Eliminación", "Desea borrar el registro actual?",Question!,YesNo!)

	if li_borrar <>1 then 
		this.SelectRow(li_renglon_actual, FALSE)
		return
	end if


	setfocus()
	li_delete = this.DeleteRow(li_renglon_actual)
	if li_delete <> -1 then
		event actualiza()
	else
		MessageBox("Error", "Error al actualizar el datawindow de paquetes_materias")
	end if
end if

end event

event itemfocuschanged;//DataWindowChild grupo, cve_subsistema
//string ls_filtro, ls_filtro_1, ls_filtro_2, ls_carrera, ls_columna, ls_plan
//string ls_num_paq, ls_clv_mat, ls_anio, ls_periodo
//integer rtncode, li_num_paq, li_anio, li_periodo
//long ll_carrera, ll_grupo, ll_row
//long ll_clv_mat
//
//if ii_insertando = 1 then 
//	return
//end if
//
//if this.RowCount()>0 then
//
//	ll_row = this.GetRow()
//
//
////ls_columna =dwo.name
//
//	ls_columna =this.GetColumnName()
//
//
//	li_num_paq = this.object.num_paq[ll_row]
//	ll_clv_mat = this.object.clv_mat[ll_row]
//	li_anio = gi_anio
//	li_periodo = gi_periodo
//
//	ls_num_paq = string(li_num_paq)
//	ls_clv_mat = string(ll_clv_mat)
//	ls_anio = string(li_anio)
//	ls_periodo = string(li_periodo)
//
//
//	ls_filtro_1 = "cve_mat = "+ ls_clv_mat + " and periodo = "+ls_periodo+" and anio = "+ls_anio
//
//	rtncode = this.GetChild('grupo', grupo)
//
//	IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")
//
//	// Set the transaction object for the child
//	
//		grupo.SetTransObject(gtr_sce)
//		grupo.Retrieve(li_periodo, li_anio, ll_clv_mat)
//	
////	// Populate the child with all the posible values for grupo
////	if isnull(ls_carrera) then
////		ls_carrera = "0"
////	end if
////	
////	grupo.SetFilter(ls_filtro_1)
////	grupo.Filter()
////	grupo.Retrieve()
//
//end if
//






end event

event rowfocuschanged;DataWindowChild grupo, cve_subsistema
string ls_filtro, ls_filtro_1, ls_filtro_2, ls_carrera, ls_columna, ls_plan
string ls_num_paq, ls_clv_mat, ls_anio, ls_periodo
integer rtncode, li_num_paq, li_anio, li_periodo
long ll_carrera, ll_grupo, ll_row
long ll_clv_mat

if ii_insertando = 1 then 
	return
end if

ll_row = this.GetRow()

if ll_row>0 then

//ls_columna =dwo.name

	ls_columna =this.GetColumnName()


	li_num_paq = this.object.num_paq[ll_row]
	ll_clv_mat = this.object.clv_mat[ll_row]
	li_anio = gi_anio
	li_periodo = gi_periodo

	ls_num_paq = string(li_num_paq)
	ls_clv_mat = string(ll_clv_mat)
	ls_anio = string(li_anio)
	ls_periodo = string(li_periodo)


	ls_filtro_1 = "cve_mat = "+ ls_clv_mat + " and periodo = "+ls_periodo+" and anio = "+ls_anio

	rtncode = this.GetChild('grupo', grupo)

	IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

	// Set the transaction object for the child
	
		grupo.SetTransObject(gtr_sce)
		grupo.Retrieve(li_periodo, li_anio, ll_clv_mat)
	
//	// Populate the child with all the posible values for grupo
//	if isnull(ls_carrera) then
//		ls_carrera = "0"
//	end if
//	
//	grupo.SetFilter(ls_filtro_1)
//	grupo.Filter()
//	grupo.Retrieve()


end if





end event

event retrieveend;boolean lb_exito_actual
long ll_numrows, ll_indice
integer li_num_paq, li_codigo_sql, li_periodo, li_anio, li_primer_sem
long ll_cve_mat, ll_row
string ls_mensaje_sql, ls_grupo
long ll_cupo_grupo
ll_numrows = this.RowCount()

li_periodo = gi_periodo
li_anio = gi_anio


for ll_indice = 1 to ll_numrows 
	li_num_paq = this.object.num_paq[ll_indice]
	ls_grupo = this.object.grupo[ll_indice]
	ll_cve_mat = this.object.clv_mat[ll_indice]

	ll_cupo_grupo = f_obten_cupo_grupo(ll_cve_mat, ls_grupo, li_periodo, li_anio)
	this.SetItem(ll_indice, "cupo_grupo", ll_cupo_grupo)

next
end event

type dw_1 from datawindow within w_crea_paq_nvo
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event carga ( integer a_cve_carrera )
integer x = 41
integer y = 244
integer width = 2720
integer height = 484
string dataobject = "d_paquetes_1ing"
boolean vscrollbar = true
boolean livescroll = true
end type

event primero;/*Ve al primer renglón*/
setcolumn(1)
setfocus()
scrolltorow(1)
end event

event anterior;/*Ve al renglón anterior*/
setcolumn(1)
setfocus()
if getrow()>1 then
	scrolltorow(getrow()-1)
end if

end event

event siguiente;/*Ve al siguiente renglón*/
setcolumn(1)
setfocus()
if getrow()<rowcount() then
	scrolltorow(getrow()+1)
end if
end event

event ultimo;/*Ve al último renglón*/
setcolumn(1)
setfocus()
scrolltorow(rowcount())
end event

event actualiza();long ll_row, ll_row_actual , ll_row_actual2, ll_cve_carrera= 0, ll_cve_plan
DWItemStatus l_DWItemStatus
integer li_periodo, li_anio
AcceptText()
ll_row_actual = this.GetRow()
if ll_row_actual>0 then
	ll_cve_carrera = this.GetItemNumber(ll_row_actual,'clv_carr')
	ll_cve_plan = this.GetItemNumber(ll_row_actual,'clv_plan')
	if isnull(ll_cve_carrera) or isnull(ll_cve_plan) then
		messagebox("Error","Favor de capturar la carrera y el plan de estudios", StopSign!)	
		return
	end if
end if
l_DWItemStatus = this.GetItemStatus(ll_row_actual, 0, Primary!)
li_periodo = ii_periodo
li_anio = ii_anio

//if ModifiedCount()+DeletedCount() > 0 Then
	if dw_2.event actualiza() = 1 then
		if update(true) = 1 then		
			commit using gtr_sadm;
				messagebox("Información","Se ha almacenado correctamente", Information!)	
			wf_actualiza_horario()
		else
			rollback using gtr_sadm;
			messagebox("Información","Algunos datos están incorrectos, favor de corregirlos", StopSign!)	
		end if
	else
		messagebox("Información","Algunos datos están incorrectos, o faltan, favor de corregirlos", StopSign!)	
		ll_row = dw_2.GetRow()
		if ll_row>0 then
			dw_2.ScrollToRow(ll_row)
			dw_2.SetColumn("grupo")
		end if
	end if

	this.event carga(il_cve_carrera)
	if l_DWItemStatus = NewModified!	then
		ll_row_actual2 = wf_ultimo_paquete_insertado(ll_cve_carrera)
		this.ScrollToRow(ll_row_actual2)
		dw_3.event carga(object.clv_carr[ll_row_actual2],object.clv_plan[ll_row_actual2], li_periodo, li_anio, ii_semestre_ideal)
	else
		this.ScrollToRow(ll_row_actual)
	end if		
	this.SetColumn(1)
//	
//ll_row = this.GetRow()

//this.event rowfocuschanged(ll_row)
	
//end if
end event

event nuevo();long ll_num_paq = 0, ll_row
integer li_anio, li_periodo


insertrow(0)
scrolltorow(rowcount())
setfocus()
object.num_paq[getrow()]= ll_num_paq
object.cupo[getrow()]=0
object.inscritos[getrow()]=0

li_anio = gi_anio
li_periodo = gi_periodo
ll_row = getrow()
//Si es un coordinador no podrá elegir la carrera ni el plan del paquete
if il_cve_coordinacion <> 9999 then
	object.clv_carr[ll_row]= il_cve_carrera
	object.clv_plan[ll_row]= ii_cve_plan	
end if

ScrollToRow(ll_row)



end event

event borra();long cont, l_num_paq, li_codigo_sql, ll_renglon_paquetes, ll_rows_paq_mat, ll_row, ll_clv_mat
string ls_mensaje_sql, ls_grupo
integer li_respuesta, li_num_paq_max, li_num_paq
/*Borra el renglón actual*/

li_respuesta = MessageBox("Confirmacion","¿Esta seguro de querer borrar el paquete actual?", Question!, YesNO! )
if li_respuesta <> 1 then
	return	
end if

//Obtiene los renglones de paquetes_materias
ll_rows_paq_mat = dw_2.RowCount()
ll_row =1

//Obtiene el renglon actual del paquetes
cont=object.num_paq[getrow()]

li_num_paq=object.num_paq[getrow()]
ll_renglon_paquetes = dw_1.GetRow()


for ll_row=dw_2.rowcount() to 1 step -1
	
	ll_clv_mat =dw_2.object.clv_mat[ll_row]
	ls_grupo = dw_2.object.grupo[ll_row]

	SELECT max( paquetes_materias.num_paq)
	INTO :li_num_paq_max
	FROM  paquetes_materias
	WHERE  paquetes_materias.clv_mat = :ll_clv_mat
	AND	 paquetes_materias.grupo = :ls_grupo
	AND	 paquetes_materias.num_paq <> :li_num_paq
	AND	 paquetes_materias.clv_per = :ii_periodo
	AND	 paquetes_materias.anio = :ii_anio
	USING gtr_sadm;

	li_codigo_sql = gtr_sadm.SQLCode
	ls_mensaje_sql = gtr_sadm.SQLErrText
	
	if li_codigo_sql = 100 or isnull(li_num_paq_max) then
		
		UPDATE  grupos
		SET  primer_sem = 0
		WHERE (  grupos.periodo = :ii_periodo ) 
		AND	(  grupos.anio = :ii_anio ) 
		AND	(  grupos.cve_mat = :ll_clv_mat )
		AND	(  grupos.gpo = :ls_grupo )
		AND	(  grupos.primer_sem = :li_num_paq )
		USING gtr_sce;

		li_codigo_sql= gtr_sce.SqlCode
		ls_mensaje_sql= gtr_sce.SqlErrText

		if li_codigo_sql <> -1 then
			commit using gtr_sce;
		else
	 		MessageBox("Error al actualizar primer_sem de grupos", ls_mensaje_sql)
			rollback using gtr_sce;
			return
		end if

	end if

//	dw_2.deleterow(ll_row)
//	ll_row= ll_row +1
next

for cont=dw_2.rowcount() to 1 step -1
	dw_2.deleterow(cont)
next
setfocus()
deleterow(getrow())
event actualiza()



end event

event carga(integer a_cve_carrera);long ll_rows, ll_row

if isnull(a_cve_carrera) or a_cve_carrera= 0 then a_cve_carrera= il_cve_carrera
	
ll_rows = retrieve(a_cve_carrera)


ll_row = this.GetRow()

//this.event rowfocuschanged(ll_row)

end event

event constructor;this.SetRowFocusIndicator(Hand!)
dw_1.settransobject(gtr_sce)
dw_4.settransobject(gtr_sce)

DataWindowChild carr,plan

//getchild("clv_carr",carr)
//carr.settransobject(gtr_sce)
//carr.retrieve()
//
//getchild("clv_plan",plan)
//plan.settransobject(gtr_sce)
//plan.retrieve()

m_menu.dw = this
end event

event itemchanged;int cont,columna
int li_clv_carr, li_clv_plan, li_periodo, li_anio

li_periodo = gi_periodo
li_anio = gi_anio

columna = getcolumn()
if (columna=2) then
	li_clv_carr = integer(Data)
	li_clv_plan=object.clv_plan[row]
end if

if (columna=3)  then
	li_clv_plan = integer(Data)
	li_clv_carr=object.clv_carr[row]
end if

if (columna=2 or columna=3) then
	if not isnull(li_clv_carr) and not isnull(li_clv_plan)then
		dw_3.event carga(li_clv_carr,li_clv_plan,li_periodo, li_anio, ii_semestre_ideal )
		dw_4.event carga(li_clv_carr,li_clv_plan)
	end if
end if


//		dw_3.event carga(object.clv_carr[row],object.clv_plan[row])
//		dw_4.event carga(object.clv_carr[row],object.clv_plan[row])

end event

event rowfocuschanged;integer li_periodo, li_anio, li_num_paq
string ls_array_horario[7,15], ls_elemento_array, ls_horario
long ll_dia_actual
long ll_hora_actual, ll_hora_sig
long ll_row_actual, ll_hora_relativa, ll_factor_hora, ll_dia_relativo, ll_factor_dia
long  ll_hora_menor = 7, ll_hora_mayor = 21, ll_cve_dia_menor = 1, ll_cve_dia_mayor =6, ll_indice_horario =7, ll_indice_dia =1 

li_anio = ii_anio
li_periodo = ii_periodo

if (currentrow>0 and rowcount()>0) then
	dw_3.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow], li_periodo, li_anio, ii_semestre_ideal)
	dw_4.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow])
	dw_2.event carga(9999,object.num_paq[currentrow])
end if

wf_actualiza_horario()

//li_num_paq = object.num_paq[currentrow]
//
//f_genera_horario_paquete(li_num_paq, li_periodo, li_anio, false, ls_array_horario)
//
//	  ll_hora_menor = 7 
//	  ll_hora_mayor = 21  
//	  ll_cve_dia_menor = 1 
//	  ll_cve_dia_mayor =6 
//	  ll_indice_horario =7  
//	  ll_indice_dia =1 
//		
//	  ll_hora_relativa = 7  
//	  ll_factor_hora = 6  			
//	  ll_factor_dia = 1
//
//
//
//for ll_dia_actual=ll_cve_dia_menor to ll_cve_dia_mayor
////	ll_row_actual = dw_horario_paquete_visual.InsertRow(0)
//	for ll_hora_actual=ll_hora_menor to ll_hora_mayor
//		  ll_hora_relativa = ll_hora_actual - ll_factor_hora  
//		  ll_dia_relativo = ll_dia_actual + ll_factor_dia
//		  ll_hora_sig = ll_hora_actual +1
//		  ls_elemento_array = ls_array_horario[ll_dia_actual,ll_hora_relativa]
//		   if ll_hora_relativa > dw_horario_paquete_visual.RowCount() then
//				ll_row_actual = dw_horario_paquete_visual.InsertRow(0)			
//			end if	
//			if (ll_dia_actual = ll_cve_dia_menor) then
//				ls_horario = string(ll_hora_actual)+'-'+string(ll_hora_sig)
//			  dw_horario_paquete_visual.SetItem( ll_hora_relativa, ll_dia_actual,ls_horario)
//			end if
//		  dw_horario_paquete_visual.SetItem( ll_hora_relativa, ll_dia_relativo,ls_elemento_array)
//	next
//next
//
//
////
////if (ll_dia_actual = ll_cve_dia_menor) >
////	ls_horario = ll_hora_actual+'-'+ll_hora_sig	
////end if
					
					
					
					
end event

event getfocus;setcolumn(1)
end event

type dw_4 from datawindow within w_crea_paq_nvo
event carga ( integer carr,  integer plan )
boolean visible = false
integer x = 3799
integer y = 1944
integer width = 731
integer height = 536
boolean bringtotop = true
string dataobject = "dw_prerreq"
boolean vscrollbar = true
boolean livescroll = true
end type

event carga;retrieve(carr,plan)

end event

event retrieveend;long cont1,cont2

FOR cont1=1 TO rowcount
	FOR cont2=1 TO dw_3.rowcount()
		IF dw_3.object.cve_mat[cont2] = object.cve_mat[cont1] THEN
			dw_3.deleterow(cont2)
			cont2=dw_3.rowcount()+1
		END IF
	NEXT
NEXT

end event

event constructor;dw_4.settransobject(gtr_sce)
end event

type cb_actualiza_periodo from commandbutton within w_crea_paq_nvo
integer x = 3141
integer y = 72
integer width = 425
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Periodo"
end type

event clicked;long ll_row
int li_retorno, li_periodo, li_anio

ii_periodo =gi_periodo
ii_anio =gi_anio

choose case gi_periodo
	case 0
		st_periodo.text = "PRIMAVERA " + String(gi_anio)
	case 1
		st_periodo.text = "VERANO " + String(gi_anio)
	case 2
		st_periodo.text = "OTOÑO " + String(gi_anio)
end choose


end event

type uo_carreras_i from uo_carreras within w_crea_paq_nvo
integer x = 279
integer y = 76
integer width = 1234
integer height = 144
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on uo_carreras_i.destroy
call uo_carreras::destroy
end on

