$PBExportHeader$w_cap_password_2013.srw
$PBExportComments$Despliegue de datos academicos de un alumno (Carrera, Semestre, Subsistema, Fecha de Ingreso, Fecha de Egreso,.....)
forward
global type w_cap_password_2013 from w_master_main
end type
type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cap_password_2013
end type
type sle_nip_1 from singlelineedit within w_cap_password_2013
end type
type sle_nip_2 from singlelineedit within w_cap_password_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_cap_password_2013
end type
end forward

global type w_cap_password_2013 from w_master_main
integer x = 5
integer y = 4
integer width = 4238
integer height = 2704
string title = "Captura y Cambio de NIP"
string menuname = "m_menu_constancias_2013"
boolean center = true
iuo_foto_alumno_blob iuo_foto_alumno_blob
sle_nip_1 sle_nip_1
sle_nip_2 sle_nip_2
uo_nombre uo_nombre
end type
global w_cap_password_2013 w_cap_password_2013

type variables
string is_lista_fotos[], is_filename = ""
//str_msgparm istr_msgparm
long il_cuenta,il_carrera
end variables

forward prototypes
public function integer wf_borra_fotos_sesion (string as_filename_excepcion)
end prototypes

public function integer wf_borra_fotos_sesion (string as_filename_excepcion);integer li_indice_lista, li_tamanio_lista
string ls_filename
boolean lb_deletefile

li_tamanio_lista = upperbound(is_lista_fotos)

for li_indice_lista =1 to li_tamanio_lista
	ls_filename = is_lista_fotos[li_indice_lista]
	if as_filename_excepcion <> ls_filename then
		if FileExists(ls_filename) then
			lb_deletefile = FileDelete(ls_filename)
			if not lb_deletefile then
				MessageBox("Error de eliminación","No es posible eliminar el archivo ["+ls_filename+"]",StopSign!)
				return -1
			end if
		end if
	end if
next
return 0
end function

on w_cap_password_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_constancias_2013" then this.MenuID = create m_menu_constancias_2013
this.iuo_foto_alumno_blob=create iuo_foto_alumno_blob
this.sle_nip_1=create sle_nip_1
this.sle_nip_2=create sle_nip_2
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.iuo_foto_alumno_blob
this.Control[iCurrent+2]=this.sle_nip_1
this.Control[iCurrent+3]=this.sle_nip_2
this.Control[iCurrent+4]=this.uo_nombre
end on

on w_cap_password_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.iuo_foto_alumno_blob)
destroy(this.sle_nip_1)
destroy(this.sle_nip_2)
destroy(this.uo_nombre)
end on

event close;if (desconecta_bd(gtr_scred) = 1) then
	//OK 
else
	MessageBox("Desconexión inválida","No es posible desconectarse de la base de datos de credenciales",StopSign!)
end if

wf_borra_fotos_sesion("")
end event

event open;call super::open;sle_nip_1.enabled=false
sle_nip_2.enabled=false
if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++
//dw_adeudos.settransobject(gtr_scob)

IF IsValid(This) THEN 
	IF (f_conecta_con_parametros_bd(gtr_sce, gtr_scred,1) = 1) THEN
		//OK 
	ELSE
		MessageBox("Acceso a fotos inválido","No es posible conectarse a la base de datos de credenciales",StopSign!)
	END IF
	
	uo_nombre.em_cuenta.text = " "
END IF
end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;string ls_filename
int li_indice_lista

il_cuenta = uo_nombre.of_obten_cuenta()
if il_cuenta > 0 then
	ls_filename = iuo_foto_alumno_blob.of_loadPhoto(il_cuenta,1, gtr_scred, 0)
	ls_filename = "photo_"+string(il_cuenta)+".jpg"
	is_filename = ls_filename
	sle_nip_1.enabled=true
	sle_nip_2.enabled=false

	sle_nip_1.setfocus()
else  
	is_filename = ""
end if




end event

type st_sistema from w_master_main`st_sistema within w_cap_password_2013
end type

type p_ibero from w_master_main`p_ibero within w_cap_password_2013
end type

type iuo_foto_alumno_blob from uo_foto_alumno_blob within w_cap_password_2013
event destroy ( )
integer x = 41
integer y = 328
integer width = 498
integer height = 492
borderstyle borderstyle = stylebox!
end type

on iuo_foto_alumno_blob.destroy
call uo_foto_alumno_blob::destroy
end on

type sle_nip_1 from singlelineedit within w_cap_password_2013
integer x = 965
integer y = 952
integer width = 626
integer height = 252
boolean bringtotop = true
integer textsize = -26
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 4
borderstyle borderstyle = styleraised!
end type

event getfocus;/*
DESCRIPCIÓN: Limpia el texto que se haya escrito antes.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
text=""
end event

event modified;/*
DESCRIPCIÓN: Al capturar el nip, habilita la segunda ventana para confirmarlo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
sle_nip_1.enabled=false
sle_nip_2.enabled=true

sle_nip_2.setfocus()
end event

type sle_nip_2 from singlelineedit within w_cap_password_2013
integer x = 1957
integer y = 952
integer width = 626
integer height = 252
boolean bringtotop = true
integer textsize = -26
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 4
borderstyle borderstyle = styleraised!
end type

event getfocus;/*
DESCRIPCIÓN: Limpia el texto que se haya escrito antes.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
text=""
end event

event modified;/*
DESCRIPCIÓN: Si concuerdan los nips y son válidos, actualízalos en la base de credenciales.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_nip
string ls_nip, ls_nip_plano, ls_error_text
integer li_nip_detectado, li_error_code

sle_nip_2.enabled=false
if sle_nip_1.text<>sle_nip_2.text then
	messagebox("Aviso","No concuerda la contraseña")
	sle_nip_1.enabled=true
else
	ll_nip=long(sle_nip_1.text)
	if ll_nip<=0 then
		messagebox("Aviso","La contraseña tiene que ser númerica")
		sle_nip_1.enabled=true
	else
		ls_nip=sle_nip_1.text
		ls_nip_plano = ls_nip
		li_nip_detectado = 1
//		consulta_sie(ls_nip)
		UPDATE nips
		SET nip2 = :ls_nip_plano
		WHERE nips.cuenta = :il_cuenta
		USING gtr_sce;
		ls_error_text =gtr_sce.sqlerrtext
		li_error_code =gtr_sce.SqlCode
		
		if li_error_code= -1 then
			rollback using gtr_sce;
			messagebox("Error en Cambio de NIP",ls_error_text)
		else
			commit using gtr_sce;
			messagebox("Aviso","Ha cambiado su contraseña")
		end if		
	end if
end if

end event

type uo_nombre from uo_nombre_alumno_2013 within w_cap_password_2013
event destroy ( )
integer x = 567
integer y = 328
integer taborder = 30
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_constancias_2013.objeto = this
end event

