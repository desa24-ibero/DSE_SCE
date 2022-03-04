$PBExportHeader$w_desbloqueo_cuenta_uia.srw
forward
global type w_desbloqueo_cuenta_uia from w_main
end type
type rb_bloquear from u_rb within w_desbloqueo_cuenta_uia
end type
type rb_desbloquear from u_rb within w_desbloqueo_cuenta_uia
end type
type cb_1 from u_cb within w_desbloqueo_cuenta_uia
end type
type tab_datos_alumno from tab within w_desbloqueo_cuenta_uia
end type
type tabpage_academicos from userobject within tab_datos_alumno
end type
type st_3 from statictext within tabpage_academicos
end type
type dw_academicos from u_dw within tabpage_academicos
end type
type tabpage_academicos from userobject within tab_datos_alumno
st_3 st_3
dw_academicos dw_academicos
end type
type tabpage_personales from userobject within tab_datos_alumno
end type
type dw_personal from u_dw within tabpage_personales
end type
type tabpage_personales from userobject within tab_datos_alumno
dw_personal dw_personal
end type
type tabpage_internet from userobject within tab_datos_alumno
end type
type dw_internet from u_dw within tabpage_internet
end type
type tabpage_internet from userobject within tab_datos_alumno
dw_internet dw_internet
end type
type tab_datos_alumno from tab within w_desbloqueo_cuenta_uia
tabpage_academicos tabpage_academicos
tabpage_personales tabpage_personales
tabpage_internet tabpage_internet
end type
type st_estatus_bloqueo from statictext within w_desbloqueo_cuenta_uia
end type
type dw_bloqueo_alumno from u_dw_captura within w_desbloqueo_cuenta_uia
end type
type uo_nombre from uo_nombre_alumno within w_desbloqueo_cuenta_uia
end type
end forward

global type w_desbloqueo_cuenta_uia from w_main
integer width = 4448
integer height = 2316
string title = "Accesos a Servicios en Línea"
string menuname = "m_menu"
windowstate windowstate = maximized!
rb_bloquear rb_bloquear
rb_desbloquear rb_desbloquear
cb_1 cb_1
tab_datos_alumno tab_datos_alumno
st_estatus_bloqueo st_estatus_bloqueo
dw_bloqueo_alumno dw_bloqueo_alumno
uo_nombre uo_nombre
end type
global w_desbloqueo_cuenta_uia w_desbloqueo_cuenta_uia

type variables
long il_num_tramites_inicial, il_num_tramites_final, il_cuenta= 0
u_pipeline_control iu_pipeline_control, iu_pipeline_control02
n_tr i_tr_origen, i_tr_destino
boolean ib_usuario_especial=false
integer ii_bloqueo_activo = 0
st_confirma_usuario ist_confirma_usuario
transaction itr_web

end variables

forward prototypes
public function integer wf_conectabd ()
end prototypes

public function integer wf_conectabd ();//wf_conectaBD
//Realiza las conexiones de origen y destino la conexion 
//destino ya existe y es la del usuario firmado
integer li_confirma, li_codigo_retorno
string ls_resultado


li_confirma = 1

IF li_confirma <> 1 THEN
	RETURN 0
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	if isvalid(i_tr_destino) then
		DESTROY i_tr_destino		
	end if	
   IF conecta_bd(i_tr_destino,gs_sweb, ist_confirma_usuario.usuario, ist_confirma_usuario.password)<>1 then
   	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
 		RETURN -1
	END IF
END IF
i_tr_origen = gtr_sce

il_num_tramites_inicial = f_obten_numero_tramites_web(9999, i_tr_destino)

//li_codigo_retorno = iu_pipeline_control.Start(i_tr_origen, i_tr_destino, dw_resultado)

if li_codigo_retorno <0 then
   ls_resultado= iu_pipeline_control.of_resultado(li_codigo_retorno)
	Messagebox("Error en Pipeline", ls_resultado,StopSign!)
	return -1
else 
	il_num_tramites_final = f_obten_numero_tramites_web(9999,i_tr_destino)	

//	li_codigo_retorno = iu_pipeline_control02.Start(i_tr_origen, i_tr_destino, dw_resultado)

	if li_codigo_retorno <0 then
	   ls_resultado= iu_pipeline_control02.of_resultado(li_codigo_retorno)
		Messagebox("Error en Pipeline", ls_resultado,StopSign!)
		return -1
	else 
	   IF desconecta_bd(i_tr_destino)<>1 then
   		MessageBox("Error al desconectar", "No es posible desconectarse de la base del WEB", StopSign!)
	 		RETURN -1
		END IF
	end if 
end if



return 0
end function

on w_desbloqueo_cuenta_uia.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.rb_bloquear=create rb_bloquear
this.rb_desbloquear=create rb_desbloquear
this.cb_1=create cb_1
this.tab_datos_alumno=create tab_datos_alumno
this.st_estatus_bloqueo=create st_estatus_bloqueo
this.dw_bloqueo_alumno=create dw_bloqueo_alumno
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_bloquear
this.Control[iCurrent+2]=this.rb_desbloquear
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.tab_datos_alumno
this.Control[iCurrent+5]=this.st_estatus_bloqueo
this.Control[iCurrent+6]=this.dw_bloqueo_alumno
this.Control[iCurrent+7]=this.uo_nombre
end on

on w_desbloqueo_cuenta_uia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_bloquear)
destroy(this.rb_desbloquear)
destroy(this.cb_1)
destroy(this.tab_datos_alumno)
destroy(this.st_estatus_bloqueo)
destroy(this.dw_bloqueo_alumno)
destroy(this.uo_nombre)
end on

event open;call super::open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial

x=1
y=1

//dw_resultado.SettransObject(gtr_sce)

//if conecta_bd(itr_web,gs_web_desb, "scedesbloqueo","ventdesb06")<>1 then
if conecta_bd(itr_web,gs_web_desb,gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_bloqueo_alumno.SetTransObject(itr_web)
end if

IF IsValid(This) THEN 
	ib_usuario_especial = f_usuario_especial(gs_usuario) 
	
	IF ib_usuario_especial THEN 
		MessageBox("Bienvenido", "Su usuario es de acceso especial", Information!)
	END IF
END IF
end event

event close;call super::close;if isvalid(iu_pipeline_control) then
	destroy iu_pipeline_control
end if


if isvalid(iu_pipeline_control02) then
	destroy iu_pipeline_control02
end if


if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if
end event

event doubleclicked;call super::doubleclicked;long cuentalocal
int carrera,plan
//char nivel

 
long ll_row, ll_cuenta

ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

if f_alumno_restringido (ll_cuenta) then
	if ib_usuario_especial then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		il_cuenta = 0
		return		
	end if
end if

il_cuenta = ll_cuenta

dw_bloqueo_alumno.event  carga()

tab_datos_alumno.SelectTab(1)

tab_datos_alumno.tabpage_academicos.dw_academicos.SetTransObject(gtr_sce)		
tab_datos_alumno.tabpage_academicos.dw_academicos.Retrieve(il_cuenta)


end event

type rb_bloquear from u_rb within w_desbloqueo_cuenta_uia
integer x = 1943
integer y = 1896
integer width = 416
integer height = 68
string text = "Bloquear"
end type

event clicked;call super::clicked;ii_bloqueo_activo = 1
end event

type rb_desbloquear from u_rb within w_desbloqueo_cuenta_uia
integer x = 1463
integer y = 1896
integer width = 416
integer height = 68
string text = "Desbloquear"
boolean checked = true
end type

event clicked;call super::clicked;ii_bloqueo_activo = 0
end event

type cb_1 from u_cb within w_desbloqueo_cuenta_uia
integer x = 1655
integer y = 2012
integer width = 494
integer taborder = 50
string text = "Actualizar Bloqueo"
end type

event clicked;call super::clicked;long ll_rows, ll_row
integer li_bloqueo_activo = 0

ll_rows = dw_bloqueo_alumno.RowCount()
ll_row = dw_bloqueo_alumno.GetRow()

IF ll_rows >0 THEN
	dw_bloqueo_alumno.SetItem(ll_row, "bloqueo_uia_bloqueo_activo", ii_bloqueo_activo)
	IF dw_bloqueo_alumno.Update()= 1 THEN
		COMMIT USING itr_web;
		MessageBox("Actualización Exitoso", "Se ha actualizado exitosamente",Information!)
	ELSE
		ROLLBACK USING itr_web;		
		MessageBox("Error de Actualización", "No se ha podido actualizar correctamente",StopSign!)
	END IF
	dw_bloqueo_alumno.event carga()
ELSE
	MessageBox("Sin Bloqueos", "No es necesario actualizar",Information!)
END IF

end event

type tab_datos_alumno from tab within w_desbloqueo_cuenta_uia
integer x = 50
integer y = 904
integer width = 3867
integer height = 936
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_academicos tabpage_academicos
tabpage_personales tabpage_personales
tabpage_internet tabpage_internet
end type

on tab_datos_alumno.create
this.tabpage_academicos=create tabpage_academicos
this.tabpage_personales=create tabpage_personales
this.tabpage_internet=create tabpage_internet
this.Control[]={this.tabpage_academicos,&
this.tabpage_personales,&
this.tabpage_internet}
end on

on tab_datos_alumno.destroy
destroy(this.tabpage_academicos)
destroy(this.tabpage_personales)
destroy(this.tabpage_internet)
end on

event selectionchanging;integer li_indice

li_indice = newindex

choose case li_indice
	case 1
		tab_datos_alumno.tabpage_academicos.dw_academicos.SetTransObject(gtr_sce)		
		tab_datos_alumno.tabpage_academicos.dw_academicos.Retrieve(il_cuenta)
	case 2
		tab_datos_alumno.tabpage_personales.dw_personal.SetTransObject(gtr_sce)		
		tab_datos_alumno.tabpage_personales.dw_personal.Retrieve(il_cuenta)
	case 3
		tab_datos_alumno.tabpage_internet.dw_internet.SetTransObject(itr_web)		
		tab_datos_alumno.tabpage_internet.dw_internet.Retrieve(il_cuenta)
end choose





end event

type tabpage_academicos from userobject within tab_datos_alumno
integer x = 18
integer y = 100
integer width = 3831
integer height = 820
long backcolor = 79741120
string text = "Académicos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_3 st_3
dw_academicos dw_academicos
end type

on tabpage_academicos.create
this.st_3=create st_3
this.dw_academicos=create dw_academicos
this.Control[]={this.st_3,&
this.dw_academicos}
end on

on tabpage_academicos.destroy
destroy(this.st_3)
destroy(this.dw_academicos)
end on

type st_3 from statictext within tabpage_academicos
integer x = 32
integer y = 716
integer width = 1289
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Dé dobleclick sobre una materia, para consultar al profesor."
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_academicos from u_dw within tabpage_academicos
integer x = 32
integer y = 24
integer width = 3744
integer height = 680
integer taborder = 40
string dataobject = "d_academicos_bloqueo_uia"
end type

event doubleclicked;call super::doubleclicked;long ll_periodo, ll_anio
long ll_cve_mat, ll_cve_profesor
string ls_gpo, ls_materia, ls_apaterno, ls_amaterno, ls_nombre, ls_mensaje, ls_nombre_completo
string ls_titulo
if this.rowcount()>0 then
	if row >0 then
		ll_cve_mat = this.GetItemNumber(row, "mat_inscritas_cve_mat")
		ls_gpo = this.GetItemString(row, "mat_inscritas_gpo")
		ll_periodo = this.GetItemNumber(row, "mat_inscritas_periodo")
		ll_anio = this.GetItemNumber(row, "mat_inscritas_anio")
		ls_materia = this.GetItemString(row, "materias_materia")
		ll_cve_profesor = f_obten_profesor_grupo(ll_cve_mat, ls_gpo, ll_periodo, ll_anio)
		ls_nombre_completo = f_obten_nombre_profesor(ll_cve_profesor,	ls_apaterno, ls_amaterno, ls_nombre)
	//	ls_nombre_completo = ls_apaterno +" "+ ls_amaterno +" "+ ls_nombre
		ls_titulo= "Materia: ["+string(ll_cve_mat)+"-"+ls_gpo+"] "+ls_materia
		ls_mensaje= "~n"+"Profesor: "+ls_nombre_completo
		MessageBox(ls_titulo, ls_mensaje, Information! )
	end if
end if


end event

type tabpage_personales from userobject within tab_datos_alumno
integer x = 18
integer y = 100
integer width = 3831
integer height = 820
long backcolor = 79741120
string text = "Personales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_personal dw_personal
end type

on tabpage_personales.create
this.dw_personal=create dw_personal
this.Control[]={this.dw_personal}
end on

on tabpage_personales.destroy
destroy(this.dw_personal)
end on

type dw_personal from u_dw within tabpage_personales
integer x = 32
integer y = 24
integer width = 3744
integer height = 680
integer taborder = 40
string dataobject = "d_personal_bloqueo_uia"
end type

type tabpage_internet from userobject within tab_datos_alumno
integer x = 18
integer y = 100
integer width = 3831
integer height = 820
long backcolor = 79741120
string text = "Internet"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_internet dw_internet
end type

on tabpage_internet.create
this.dw_internet=create dw_internet
this.Control[]={this.dw_internet}
end on

on tabpage_internet.destroy
destroy(this.dw_internet)
end on

type dw_internet from u_dw within tabpage_internet
integer x = 32
integer y = 24
integer width = 3744
integer height = 680
integer taborder = 40
string dataobject = "d_internet_bloqueo_uia"
end type

type st_estatus_bloqueo from statictext within w_desbloqueo_cuenta_uia
boolean visible = false
integer x = 1061
integer y = 832
integer width = 1687
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "EL ALUMNO NO CUENTA CON BLOQUEOS"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_bloqueo_alumno from u_dw_captura within w_desbloqueo_cuenta_uia
boolean visible = false
integer x = 503
integer y = 480
integer width = 2802
integer height = 344
integer taborder = 50
string dataobject = "d_bloqueo_uia"
borderstyle borderstyle = stylebox!
end type

event carga;long ll_rows, ll_bloqueo_activo, ll_x = 0, ll_y = 0
string ls_mensaje= ""
//CENTER
//X 1061
//Y 616
//BELOW
//X 1061
//Y 832

ll_rows = this.Retrieve(il_cuenta)

if ll_rows>0 then
	this.visible = true
	st_estatus_bloqueo.visible = true
	ll_bloqueo_activo = this.getitemNumber(1,"bloqueo_uia_bloqueo_activo")
	IF ll_bloqueo_activo = 1 THEN
		ls_mensaje = "EL ALUMNO ESTA BLOQUEADO"
	ELSE
		ls_mensaje = "EL ALUMNO ESTA DESBLOQUEADO"		
	END IF
	ll_x = 1061 
	ll_y = 832
else
	this.visible = false
	st_estatus_bloqueo.visible = true
	ls_mensaje = "EL ALUMNO NO CUENTA CON BLOQUEOS"
	ll_x = 1061 
	ll_y = 616
end if

st_estatus_bloqueo.text = ls_mensaje
st_estatus_bloqueo.x = ll_x
st_estatus_bloqueo.y = ll_y
return ll_rows
end event

type uo_nombre from uo_nombre_alumno within w_desbloqueo_cuenta_uia
integer x = 55
integer y = 16
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

