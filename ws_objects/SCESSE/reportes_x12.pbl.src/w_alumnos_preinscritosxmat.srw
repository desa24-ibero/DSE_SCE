$PBExportHeader$w_alumnos_preinscritosxmat.srw
forward
global type w_alumnos_preinscritosxmat from w_ancestral
end type
type dw_alumnos_preinscritosxmat from uo_dw_captura within w_alumnos_preinscritosxmat
end type
type em_clave from editmask within w_alumnos_preinscritosxmat
end type
type em_grupo from editmask within w_alumnos_preinscritosxmat
end type
type mle_mensaje from multilineedit within w_alumnos_preinscritosxmat
end type
type cb_1 from commandbutton within w_alumnos_preinscritosxmat
end type
type st_1 from statictext within w_alumnos_preinscritosxmat
end type
type st_2 from statictext within w_alumnos_preinscritosxmat
end type
type uo_periodo from uo_periodo_variable_tipos within w_alumnos_preinscritosxmat
end type
type em_anio from editmask within w_alumnos_preinscritosxmat
end type
type gb_11 from groupbox within w_alumnos_preinscritosxmat
end type
end forward

global type w_alumnos_preinscritosxmat from w_ancestral
integer width = 3685
integer height = 2464
string title = "Alumnos Reinscritos"
string menuname = "m_menu"
boolean vscrollbar = true
dw_alumnos_preinscritosxmat dw_alumnos_preinscritosxmat
em_clave em_clave
em_grupo em_grupo
mle_mensaje mle_mensaje
cb_1 cb_1
st_1 st_1
st_2 st_2
uo_periodo uo_periodo
em_anio em_anio
gb_11 gb_11
end type
global w_alumnos_preinscritosxmat w_alumnos_preinscritosxmat

type variables
mailSession ms_sesion
transaction itr_web

STRING is_descripcion_periodo
integer ii_num_resize = 0
end variables

on w_alumnos_preinscritosxmat.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_alumnos_preinscritosxmat=create dw_alumnos_preinscritosxmat
this.em_clave=create em_clave
this.em_grupo=create em_grupo
this.mle_mensaje=create mle_mensaje
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.uo_periodo=create uo_periodo
this.em_anio=create em_anio
this.gb_11=create gb_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_alumnos_preinscritosxmat
this.Control[iCurrent+2]=this.em_clave
this.Control[iCurrent+3]=this.em_grupo
this.Control[iCurrent+4]=this.mle_mensaje
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.uo_periodo
this.Control[iCurrent+9]=this.em_anio
this.Control[iCurrent+10]=this.gb_11
end on

on w_alumnos_preinscritosxmat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_alumnos_preinscritosxmat)
destroy(this.em_clave)
destroy(this.em_grupo)
destroy(this.mle_mensaje)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.uo_periodo)
destroy(this.em_anio)
destroy(this.gb_11)
end on

event open;call super::open;
// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)


//if conecta_bd(itr_web,"SWEB", "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb, gs_usuario, gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
	return
else 
	dw_alumnos_preinscritosxmat.settransobject(itr_web)
end if


ms_sesion = CREATE mailSession
ms_sesion.mailLogon(mailNewSession!)

end event

event close;call super::close;if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

ms_sesion.mailLogoff( )
DESTROY ms_sesion
end event

event resize;call super::resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_alumnos_preinscritosxmat.height
	ll_height_win = this.height

	ll_height_tab = dw_alumnos_preinscritosxmat.height
	ll_width_tab = dw_alumnos_preinscritosxmat.width

	dw_alumnos_preinscritosxmat.width = newwidth - 50
	dw_alumnos_preinscritosxmat.height = newheight - 1200
	
	ll_height_tab_final = dw_alumnos_preinscritosxmat.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_alumnos_preinscritosxmat.width = newwidth - 200
	dw_alumnos_preinscritosxmat.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

type p_uia from w_ancestral`p_uia within w_alumnos_preinscritosxmat
end type

type dw_alumnos_preinscritosxmat from uo_dw_captura within w_alumnos_preinscritosxmat
integer x = 0
integer y = 1132
integer width = 3557
integer height = 1132
integer taborder = 40
string dataobject = "d_alumnos_preinscritosxmat"
boolean hscrollbar = true
end type

event actualiza;/**/
return 0
end event

event borra;call super::borra;/**/

end event

event inicia_transaction_object();call super::inicia_transaction_object;
	tr_dw_propio =itr_web
end event

event carga;
/*
DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/



//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[], periodo_x[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo

PARENT.uo_periodo.of_recupera_periodos() 

periodo_x[] = le_periodo[]
is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 	

INTEGER le_anio
le_anio = INTEGER(em_anio.TEXT)

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	


event primero()
//return retrieve(gi_periodo,gi_anio,integer(em_clave.text),em_grupo.text)
return retrieve(periodo_x[],le_anio,integer(em_clave.text),em_grupo.text)






end event

type em_clave from editmask within w_alumnos_preinscritosxmat
integer x = 2107
integer y = 80
integer width = 247
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "#####"
string displaydata = ""
end type

type em_grupo from editmask within w_alumnos_preinscritosxmat
integer x = 2107
integer y = 192
integer width = 247
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = ""
end type

type mle_mensaje from multilineedit within w_alumnos_preinscritosxmat
integer x = 14
integer y = 444
integer width = 3209
integer height = 636
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type cb_1 from commandbutton within w_alumnos_preinscritosxmat
boolean visible = false
integer x = 2665
integer y = 156
integer width = 247
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Envía"
end type

event clicked;mailReturnCode mrc_estado
mailMessage mm_respuesta
long cont_1,cont_2
string correo

if dw_alumnos_preinscritosxmat.rowcount()=0 then
	return
end if

mm_respuesta.Subject = 'Aviso respecto a la materia '+em_clave.text+' '+em_grupo.text
mm_respuesta.NoteText = mle_mensaje.text
cont_2=0
FOR cont_1=1 TO dw_alumnos_preinscritosxmat.rowcount()
	setnull(correo)
	correo=dw_alumnos_preinscritosxmat.object.alumnos_fotografia[cont_1]
	IF not(isnull(correo)) THEN
		IF correo<>'' THEN
			cont_2=cont_2+1
			mm_respuesta.Recipient[cont_2].name = dw_alumnos_preinscritosxmat.object.alumnos_fotografia[cont_1]
			mm_respuesta.Recipient[cont_2].RecipientType = mailBCC! 
		END IF
	END IF
NEXT

mrc_estado = ms_sesion.mailSend ( mm_respuesta )
IF mrc_estado <> mailReturnSuccess! THEN
	messagebox("Correo no enviado","Favor de checar su software de correo.")
else
	messagebox("Correo enviado","")
END IF
end event

type st_1 from statictext within w_alumnos_preinscritosxmat
integer x = 1851
integer y = 96
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Clave: "
boolean focusrectangle = false
end type

type st_2 from statictext within w_alumnos_preinscritosxmat
integer x = 1851
integer y = 208
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Grupo: "
boolean focusrectangle = false
end type

type uo_periodo from uo_periodo_variable_tipos within w_alumnos_preinscritosxmat
integer x = 809
integer y = 40
integer taborder = 40
boolean bringtotop = true
long backcolor = 134217730
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type em_anio from editmask within w_alumnos_preinscritosxmat
integer x = 489
integer y = 92
integer width = 215
integer height = 80
integer taborder = 96
boolean bringtotop = true
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
periodo_actual(periodo,anio,gtr_sce)

this.text = string(anio)
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type gb_11 from groupbox within w_alumnos_preinscritosxmat
integer x = 443
integer y = 32
integer width = 315
integer height = 160
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 134217730
string text = "Año"
borderstyle borderstyle = styleraised!
end type

