$PBExportHeader$w_documentos.srw
$PBExportComments$Despliegue de documentos que adeuda un alumno (Acta de Nac.,Cert. de Sec., Cert. de Bach., ...)
forward
global type w_documentos from window
end type
type st_replica from statictext within w_documentos
end type
type uo_nombre_adm from uo_nombre_alumno_adm within w_documentos
end type
type rb_alumno from radiobutton within w_documentos
end type
type rb_aspirante from radiobutton within w_documentos
end type
type cb_imprime_recibo from commandbutton within w_documentos
end type
type em_campo from editmask within w_documentos
end type
type r_2 from rectangle within w_documentos
end type
type dw_adeuda from datawindow within w_documentos
end type
type uo_nombre from uo_nombre_alumno within w_documentos
end type
type dw_doc from datawindow within w_documentos
end type
type dw_telefono from datawindow within w_documentos
end type
type r_1 from rectangle within w_documentos
end type
type st_1 from statictext within w_documentos
end type
type gb_tipo from groupbox within w_documentos
end type
end forward

global type w_documentos from window
integer x = 5
integer y = 4
integer width = 3698
integer height = 2436
boolean titlebar = true
string title = "Documentos"
string menuname = "m_documentos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 10789024
st_replica st_replica
uo_nombre_adm uo_nombre_adm
rb_alumno rb_alumno
rb_aspirante rb_aspirante
cb_imprime_recibo cb_imprime_recibo
em_campo em_campo
r_2 r_2
dw_adeuda dw_adeuda
uo_nombre uo_nombre
dw_doc dw_doc
dw_telefono dw_telefono
r_1 r_1
st_1 st_1
gb_tipo gb_tipo
end type
global w_documentos w_documentos

event open;//g_nv_security.fnv_secure_window (this)

if isnull(gi_numsadm) OR not (isvalid(gtr_sadm)) then gi_numsadm = 0
if gi_numsadm <= 0 then
	if conecta_bd(gtr_sadm,gs_sadm,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numsadm++

uo_nombre_adm.dw_nombre_alumno.SetTransObject(gtr_sadm)
dw_telefono.settransobject(gtr_sce)
dw_doc.settransobject(gtr_sce)
dw_adeuda.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event doubleclicked;dw_telefono.retrieve(long(uo_nombre.em_cuenta.text))

dw_doc.retrieve(long(uo_nombre.em_cuenta.text)) 

dw_adeuda.retrieve(long(uo_nombre.em_cuenta.text))

if keydown(keyenter!) or keydown(keyTab!) Then em_campo.setfocus()


end event

on w_documentos.create
if this.MenuName = "m_documentos" then this.MenuID = create m_documentos
this.st_replica=create st_replica
this.uo_nombre_adm=create uo_nombre_adm
this.rb_alumno=create rb_alumno
this.rb_aspirante=create rb_aspirante
this.cb_imprime_recibo=create cb_imprime_recibo
this.em_campo=create em_campo
this.r_2=create r_2
this.dw_adeuda=create dw_adeuda
this.uo_nombre=create uo_nombre
this.dw_doc=create dw_doc
this.dw_telefono=create dw_telefono
this.r_1=create r_1
this.st_1=create st_1
this.gb_tipo=create gb_tipo
this.Control[]={this.st_replica,&
this.uo_nombre_adm,&
this.rb_alumno,&
this.rb_aspirante,&
this.cb_imprime_recibo,&
this.em_campo,&
this.r_2,&
this.dw_adeuda,&
this.uo_nombre,&
this.dw_doc,&
this.dw_telefono,&
this.r_1,&
this.st_1,&
this.gb_tipo}
end on

on w_documentos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.uo_nombre_adm)
destroy(this.rb_alumno)
destroy(this.rb_aspirante)
destroy(this.cb_imprime_recibo)
destroy(this.em_campo)
destroy(this.r_2)
destroy(this.dw_adeuda)
destroy(this.uo_nombre)
destroy(this.dw_doc)
destroy(this.dw_telefono)
destroy(this.r_1)
destroy(this.st_1)
destroy(this.gb_tipo)
end on

event closequery;int resp
if dw_doc.modifiedcount() > 0 or dw_doc.deletedcount() > 0 or dw_adeuda.modifiedcount() > 0 or dw_adeuda.deletedcount() > 0 then
	resp = messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesnocancel!)
	choose case resp
		case 1 
			m_documentos.m_registro.m_actualiza.triggerevent(clicked!)			
		case 2
			dw_doc.resetupdate()
			dw_adeuda.resetupdate()
		case 3
			message.returnvalue = 1 
	end choose
end if
end event

event activate;control_escolar.toolbarsheettitle="Documentos"
end event

event close;//close(this)

if gi_numsadm = 1 then
	if desconecta_bd(gtr_sadm) <> 1 then
		return
	end if
end if
gi_numsadm --



end event

type st_replica from statictext within w_documentos
integer x = 3328
integer y = 32
integer width = 110
integer height = 88
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;n_transfiere_sybase_sql ln_transfiere_sybase_sql
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
integer li_replica_activa, li_obten_parametros_replicacion
li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type uo_nombre_adm from uo_nombre_alumno_adm within w_documentos
boolean visible = false
integer x = 78
integer y = 32
integer width = 3241
integer height = 428
integer taborder = 20
boolean enabled = true
end type

on uo_nombre_adm.destroy
call uo_nombre_alumno_adm::destroy
end on

type rb_alumno from radiobutton within w_documentos
integer x = 2491
integer y = 1092
integer width = 283
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Alumno"
boolean checked = true
end type

event clicked;dw_adeuda.enabled = true
dw_doc.enabled = true
dw_telefono.enabled = true
uo_nombre.enabled = true
//r_1.enabled = true
//r_2.enabled = true
dw_adeuda.visible = true
dw_doc.visible = true
dw_telefono.visible = true
uo_nombre.visible = true
r_1.visible = true
r_2.visible = true

uo_nombre_adm.enabled = false
uo_nombre_adm.visible = false
end event

type rb_aspirante from radiobutton within w_documentos
integer x = 2862
integer y = 1088
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Aspirante"
end type

event clicked;dw_adeuda.enabled = false
dw_doc.enabled = false
dw_telefono.enabled = false
uo_nombre.enabled = false
//r_1.enabled = false
//r_2.enabled = false
dw_adeuda.visible = false
dw_doc.visible = false
dw_telefono.visible = false
uo_nombre.visible = false
r_1.visible = false
r_2.visible = false

uo_nombre_adm.enabled = true
uo_nombre_adm.visible = true
end event

type cb_imprime_recibo from commandbutton within w_documentos
integer x = 1399
integer y = 1056
integer width = 622
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Recibo"
end type

event clicked;long ll_cuenta
if rb_alumno.checked = true then
	ll_cuenta = long(uo_nombre.em_cuenta.text)
else
	ll_cuenta = long(uo_nombre_adm.em_cuenta.text)
end if
if ll_cuenta <> 0 then
	openwithparm(w_recibo_documentos,ll_cuenta)
else
	MessageBox("Aviso","No se puede generar el recibo de documentos de la cuenta 0")
end if
end event

type em_campo from editmask within w_documentos
boolean visible = false
integer x = 1024
integer y = 1056
integer width = 183
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 15793151
string text = " "
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = "Ä"
end type

event modified;// Captura rapida para documentos.
// Juan Campos Sánchez.   Abril-1998.

Integer	Reng,Campo,Doc[],i, Status = 0 // 0=Adeuda	 
Long		Cuenta,NumBusqueda
String	Nivel,Texto
 
Cuenta	= long(uo_nombre.em_cuenta.text)
Campo		= Integer(em_campo.text)
Nivel		= dw_telefono.GetItemString(dw_telefono.GetRow(),"academicos_nivel")

if (Nivel = 'L' and  (Campo = 1 or Campo = 2 or Campo = 3 or Campo = 4 or Campo = 5 or Campo = 6 or Campo = 7)) or &
	(Nivel = 'P' and  (Campo = 10 or Campo = 11 or Campo = 12 or Campo = 13 or Campo = 14 or Campo = 15 or Campo = 16)) Then
	// Campo de captura para nivel ok							
Else
	MessageBox("Error","El número de captura no corresponde con el nivel academico del alumno")
	Return
End if
    
CHOOSE CASE Campo
CASE 0 // Nunca entra. Falta Agregar para lic y post "campo = 0 or" en el if de arriba
	    // y definir Status 
	Status = 9 // ?= No Adeuda ojo definir este campo por que no existe en la tabla y por lo tanto en el data window
	if Nivel = 'L' Then
		// = 1 acta, = 2 cert secund  = 3 cert prepa
		Doc[1] = 1; Doc[2] = 2; Doc[3] =3
	Else
		// =4 copia certficada tit profesional. = 5 copia certficada cedula profesional
		Doc[1] = 4; Doc[2] = 5 
	End if	
CASE 1
	Doc[1] = 1
CASE 2 
	Doc[1] = 1; Doc[2] = 2
CASE 3
	Doc[1] = 1; Doc[2] = 3
CASE 4
	Doc[1] = 1; Doc[2] = 2; Doc[3] = 3
CASE 5
	Doc[1] = 2 
CASE 6
	Doc[1] = 2;  Doc[2] = 3  
CASE 7
	Doc[1] = 3  
CASE 10
	Doc[1] = 1  
CASE 11
	Doc[1] = 1; Doc[2] = 4    
CASE 12
	Doc[1] = 1; Doc[2] = 5
CASE 13
	Doc[1] = 1; Doc[2] = 4; Doc[3] = 5
CASE 14
	Doc[1] = 4
CASE 15
	Doc[1] = 4; Doc[2] = 5
CASE 16
	Doc[1] = 5
CASE ELSE
	Return
END CHOOSE

For i=1 to UpperBound(Doc)
	Texto = "cve_documento = " +String(Doc[i])
	NumBusqueda = dw_adeuda.Find(Texto,1,dw_adeuda.RowCount( ))
	If NumBusqueda > 0 Then
		Reng = NumBusqueda
	Else
		Reng = dw_adeuda.InsertRow(0)
		dw_adeuda.ScrollToRow(Reng)
		dw_adeuda.setitem(Reng ,"cuenta",cuenta)
		dw_adeuda.setitem(Reng ,"cve_documento",Doc[i])
	End if
	dw_adeuda.setitem(Reng ,"cve_flag_documento",Status) //0=Adeuda
 	dw_adeuda.AcceptText( )
Next	

em_campo.text =""

end event

event getfocus;em_campo.SelectText(1,Len(em_campo.Text))
end event

type r_2 from rectangle within w_documentos
long linecolor = 15793151
integer linethickness = 3
long fillcolor = 10789024
integer x = 110
integer y = 1196
integer width = 3177
integer height = 620
end type

type dw_adeuda from datawindow within w_documentos
integer x = 146
integer y = 1216
integer width = 2930
integer height = 576
integer taborder = 60
string dataobject = "dw_documentos_adeuda"
boolean vscrollbar = true
boolean border = false
end type

event itemchanged;// ItemChanged
// No deberá permitir que se capture los tipos de documento
//(1) 	MICROFILMADO 
//(2)		ARCH S/MICRO
//
integer li_cve_flag_documento, li_cve_flag_documento_original


if dwo.name = "cve_flag_documento" and data <> '0'  then
	li_cve_flag_documento = Integer(data)
	li_cve_flag_documento_original= this.GetItemNumber(row,"cve_flag_documento",Primary!,TRUE)
	if (li_cve_flag_documento = 1 or li_cve_flag_documento = 2) then
		if not (li_cve_flag_documento_original = li_cve_flag_documento ) then
			MessageBox("TIPO DE DOCUMENTO NO PERMITIDO",&
				"No se permite registrar los tipos de documentos:~n(1) MICROFILMADO ~n(2) ARCH S/MICRO",StopSign!)
				object.cve_flag_documento[row]	=	li_cve_flag_documento_original
				return 1
		end if	
	end if
end if
	
end event

type uo_nombre from uo_nombre_alumno within w_documentos
integer x = 73
integer y = 32
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

event constructor;call super::constructor;m_documentos.objeto = this
end event

type dw_doc from datawindow within w_documentos
integer x = 183
integer y = 736
integer width = 2926
integer height = 256
integer taborder = 20
string dataobject = "dw_documentos_doc"
boolean border = false
end type

type dw_telefono from datawindow within w_documentos
integer x = 183
integer y = 480
integer width = 3072
integer height = 224
string dataobject = "dw_tel_ing_doc"
boolean border = false
boolean livescroll = true
end type

type r_1 from rectangle within w_documentos
long linecolor = 15793151
integer linethickness = 3
long fillcolor = 10789024
integer x = 91
integer y = 460
integer width = 3182
integer height = 576
end type

type st_1 from statictext within w_documentos
boolean visible = false
integer x = 110
integer y = 1072
integer width = 878
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
string text = "Campo de captura rapida:"
boolean focusrectangle = false
end type

type gb_tipo from groupbox within w_documentos
integer x = 2053
integer y = 1048
integer width = 1230
integer height = 132
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "tipo"
end type

