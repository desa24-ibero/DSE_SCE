$PBExportHeader$w_documentos_2013.srw
forward
global type w_documentos_2013 from w_master_main
end type
type r_1 from rectangle within w_documentos_2013
end type
type dw_doc from uo_master_dw within w_documentos_2013
end type
type dw_telefono from uo_master_dw within w_documentos_2013
end type
type st_replica from statictext within w_documentos_2013
end type
type dw_adeuda from uo_master_dw within w_documentos_2013
end type
type r_2 from rectangle within w_documentos_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_documentos_2013
end type
type st_1 from statictext within w_documentos_2013
end type
type em_campo from editmask within w_documentos_2013
end type
type rb_alumno from radiobutton within w_documentos_2013
end type
type st_2 from statictext within w_documentos_2013
end type
end forward

global type w_documentos_2013 from w_master_main
integer width = 3529
integer height = 2712
string title = "Documentos"
string menuname = "m_documentos_2013"
r_1 r_1
dw_doc dw_doc
dw_telefono dw_telefono
st_replica st_replica
dw_adeuda dw_adeuda
r_2 r_2
uo_nombre uo_nombre
st_1 st_1
em_campo em_campo
rb_alumno rb_alumno
st_2 st_2
end type
global w_documentos_2013 w_documentos_2013

type variables
int ii_sw = 0
Datawindowchild dwc_periodo
end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();long ll_cuenta,banderas

ll_cuenta = uo_nombre.of_obten_cuenta()


banderas = dw_doc.getitemnumber(dw_doc.getrow(),"banderas_baja_documentos")

  UPDATE banderas  
     SET baja_documentos = :banderas  
   WHERE banderas.cuenta = :ll_cuenta    using gtr_sce;
	
if gtr_sce.sqlcode <> 0 then
	messagebox("Aviso","No se pudo guardar modificación sobre banderas.",stopsign!)
	return -1
end if

return 1
end function

on w_documentos_2013.create
int iCurrent
call super::create
if this.MenuName = "m_documentos_2013" then this.MenuID = create m_documentos_2013
this.r_1=create r_1
this.dw_doc=create dw_doc
this.dw_telefono=create dw_telefono
this.st_replica=create st_replica
this.dw_adeuda=create dw_adeuda
this.r_2=create r_2
this.uo_nombre=create uo_nombre
this.st_1=create st_1
this.em_campo=create em_campo
this.rb_alumno=create rb_alumno
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_1
this.Control[iCurrent+2]=this.dw_doc
this.Control[iCurrent+3]=this.dw_telefono
this.Control[iCurrent+4]=this.st_replica
this.Control[iCurrent+5]=this.dw_adeuda
this.Control[iCurrent+6]=this.r_2
this.Control[iCurrent+7]=this.uo_nombre
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_campo
this.Control[iCurrent+10]=this.rb_alumno
this.Control[iCurrent+11]=this.st_2
end on

on w_documentos_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.r_1)
destroy(this.dw_doc)
destroy(this.dw_telefono)
destroy(this.st_replica)
destroy(this.dw_adeuda)
destroy(this.r_2)
destroy(this.uo_nombre)
destroy(this.st_1)
destroy(this.em_campo)
destroy(this.rb_alumno)
destroy(this.st_2)
end on

event close;call super::close;if gi_numsadm = 1 then
	if desconecta_bd(gtr_sadm) <> 1 then
		return
	end if
end if
gi_numsadm --
end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;long ll_cuenta

ll_cuenta = uo_nombre.of_obten_cuenta()
//IF ISNULL(ll_cuenta) OR ll_cuenta = 0 THEN 
//	dw_telefono.INSERTROW(0)
//	dw_doc.INSERTROW(0)
//	dw_adeuda.INSERTROW(0)
//	RETURN 0
//END IF

dw_telefono.retrieve(ll_cuenta)

dw_doc.retrieve(ll_cuenta) 

dw_adeuda.retrieve(ll_cuenta)

if keydown(keyenter!) or keydown(keyTab!) Then em_campo.setfocus()
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)

if isnull(gi_numsadm) OR not (isvalid(gtr_sadm)) then gi_numsadm = 0
if gi_numsadm <= 0 then
	if conecta_bd(gtr_sadm,gs_sadm,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	else
		gi_numsadm++

		//uo_nombre_adm.dw_nombre_alumno.SetTransObject(gtr_sadm)
		dw_telefono.settransobject(gtr_sce)
		dw_doc.settransobject(gtr_sce)
		dw_adeuda.settransobject(gtr_sce)

		uo_nombre.em_cuenta.text = " "
	
		triggerevent(doubleclicked!)
		/**/gnv_app.inv_security.of_SetSecurity(this)
		
		//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
		f_dddw_converter(dw_telefono, dwc_periodo, "academicos_periodo_ing")
	end if
end if

end event

event ue_nuevo;call super::ue_nuevo;long ll_cuenta
int cont
long ll_newrow

ll_cuenta = uo_nombre.of_obten_cuenta()

ll_newrow = dw_adeuda.insertrow(0)
dw_adeuda.ScrollToRow(ll_newrow)
dw_adeuda.setitem(ll_newrow ,"cuenta",ll_cuenta)
end event

event ue_actualiza;call super::ue_actualiza;long ll_cuenta
int banderas,li_replica_activa,li_res

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if

if dw_doc.update(true) = 1 then
	if dw_adeuda.update(true) = 1 then
		commit using gtr_sce;
		//INICIO:Replica a Internet
		li_replica_activa = f_replica_Activa()
		if li_replica_activa = 1 then
			f_replica_internet(this,ll_cuenta)
			st_replica.text = 'A'
			st_replica.BackColor =RGB(0,255,0)
		else
			st_replica.text = 'I'
			st_replica.BackColor =RGB(255,0,0)
		end if
		//FIN:Replica a Internet
		messagebox("Información","Se han guardado los cambios")	
		triggerevent(doubleclicked!)
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
	end if
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
end if

uo_nombre.em_cuenta.setfocus()


end event

event ue_borra;call super::ue_borra;string ls_cuenta
int respuesta,cont,trash

ls_cuenta = string(uo_nombre.of_obten_cuenta())

respuesta = messagebox("Atención","Esta seguro de querer borrar el documento ~r seleccionado del alumno "+ls_cuenta+ ".",StopSign!,YesNo!,2)

if respuesta = 1 then
	dw_adeuda.deleterow(dw_adeuda.getrow())	
	if dw_adeuda.update() = 1 then
		commit using gtr_sce;
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
	end if
end if 
end event

event ue_imprime;call super::ue_imprime;str_pasa_cuenta lstr_pasa_cta

if rb_alumno.checked = true then
	lstr_pasa_cta.cuenta =long(uo_nombre.of_obten_cuenta())
	lstr_pasa_cta.tipo_alumno = 'A' //alumno
else
	lstr_pasa_cta.cuenta = long(uo_nombre.of_obten_cuenta())
	lstr_pasa_cta.tipo_alumno = 'S' //aspirante
end if
if lstr_pasa_cta.cuenta <> 0 then
	
	openwithparm(w_recibo_documentos_2013,lstr_pasa_cta)
	
	// Codigo agregado el 12/12/2018 a petición de Vargas Velasco Dinorah
	dw_doc.SETITEM(1, "disco_documentos_fecha_recepcion", f_fecha_servidor())	
	
	INTEGER le_flag

	le_flag = dw_doc.GETITEMNUMBER(1, "banderas_baja_documentos") 
	// Si esta bloqueado se solicita confirmación parea desbloquear automáticamente.
	IF le_flag = 1 THEN 
		IF MESSAGEBOX("Confirmación", "¿Desea que la cuenta sea Desbloqueada por Documentos?", QUESTION!, YesNo!) = 1 THEN 
			dw_doc.SETITEM(1, "banderas_baja_documentos", 0)	
		END IF
	END IF
else
	MessageBox("Aviso","No se puede generar el recibo de documentos de la cuenta 0")
end if   



end event

type st_sistema from w_master_main`st_sistema within w_documentos_2013
end type

type p_ibero from w_master_main`p_ibero within w_documentos_2013
end type

type r_1 from rectangle within w_documentos_2013
long linecolor = 128
integer linethickness = 3
long fillcolor = 16777215
integer x = 55
integer y = 648
integer width = 3209
integer height = 460
end type

type dw_doc from uo_master_dw within w_documentos_2013
integer x = 78
integer y = 868
integer width = 3090
integer height = 216
integer taborder = 20
string dataobject = "dw_documentos_doc_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event clicked;call super::clicked;idw_trabajo = this
m_documentos_2013.dw = this
end event

type dw_telefono from uo_master_dw within w_documentos_2013
integer x = 91
integer y = 660
integer width = 3040
integer height = 220
integer taborder = 0
string dataobject = "dw_tel_ing_doc_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

type st_replica from statictext within w_documentos_2013
integer x = 3301
integer y = 324
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

event constructor;integer li_replica_activa

li_replica_activa = f_replica_Activa()

if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type dw_adeuda from uo_master_dw within w_documentos_2013
integer x = 64
integer y = 1136
integer width = 3200
integer height = 1312
integer taborder = 60
string dataobject = "dw_documentos_adeuda_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event itemchanged;call super::itemchanged;// ItemChanged
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

idw_trabajo = this
	
end event

event constructor;call super::constructor;idw_trabajo = this
m_documentos_2013.dw = this
end event

event clicked;call super::clicked;idw_trabajo = this
m_documentos_2013.dw = this
end event

type r_2 from rectangle within w_documentos_2013
boolean visible = false
long linecolor = 128
integer linethickness = 4
long fillcolor = 16777215
integer x = 2267
integer y = 1136
integer width = 997
integer height = 136
end type

type uo_nombre from uo_nombre_alumno_2013 within w_documentos_2013
integer x = 46
integer y = 316
integer taborder = 10
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_documentos_2013.objeto = this
end event

type st_1 from statictext within w_documentos_2013
boolean visible = false
integer x = 96
integer y = 1156
integer width = 805
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "Campo de captura rapida:"
boolean focusrectangle = false
end type

type em_campo from editmask within w_documentos_2013
boolean visible = false
integer x = 960
integer y = 1140
integer width = 183
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 16777215
string text = " "
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = "Ä"
end type

event getfocus;em_campo.SelectText(1,Len(em_campo.Text))
end event

event modified;// Captura rapida para documentos.
// Juan Campos Sánchez.   Abril-1998.

Integer	Reng,Campo,Doc[],i, Status = 0 // 0=Adeuda	 
Long		Cuenta,NumBusqueda
String	Nivel,Texto
 
Cuenta	= long(uo_nombre.em_cuenta.text)
Campo		= Integer(em_campo.text)
Nivel		= dw_telefono.GetItemString(dw_telefono.GetRow(),"academicos_nivel")

//if (Nivel = 'L' and  (Campo = 1 or Campo = 2 or Campo = 3 or Campo = 4 or Campo = 5 or Campo = 6 or Campo = 7)) or &
if (Nivel <> 'P' and  (Campo = 1 or Campo = 2 or Campo = 3 or Campo = 4 or Campo = 5 or Campo = 6 or Campo = 7)) or &
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
	//if Nivel = 'L' Then
	if Nivel <> 'P' Then	
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

type rb_alumno from radiobutton within w_documentos_2013
boolean visible = false
integer x = 2350
integer y = 1184
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
string text = "Alumno"
boolean checked = true
end type

event clicked;dw_adeuda.enabled = true
dw_doc.enabled = true
dw_telefono.enabled = true
uo_nombre.enabled = true
dw_adeuda.visible = true
dw_doc.visible = true
dw_telefono.visible = true
uo_nombre.visible = true
ii_sw = 0
end event

type st_2 from statictext within w_documentos_2013
boolean visible = false
integer x = 2299
integer y = 1112
integer width = 192
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Tipo"
boolean focusrectangle = false
end type

