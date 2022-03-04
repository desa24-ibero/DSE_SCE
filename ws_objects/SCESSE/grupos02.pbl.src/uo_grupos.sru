$PBExportHeader$uo_grupos.sru
forward
global type uo_grupos from userobject
end type
type cbx_descuenta_sdu_se from checkbox within uo_grupos
end type
type rb_editar from radiobutton within uo_grupos
end type
type rb_insertar from radiobutton within uo_grupos
end type
type dw_1 from datawindow within uo_grupos
end type
end forward

global type uo_grupos from userobject
integer width = 3081
integer height = 312
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cbx_descuenta_sdu_se cbx_descuenta_sdu_se
rb_editar rb_editar
rb_insertar rb_insertar
dw_1 dw_1
end type
global uo_grupos uo_grupos

type variables
string is_estatus="Editar"
boolean ib_editando=false
boolean ib_desc_sdu_se=false
integer ii_periodo, ii_anio, ii_cve_coordinacion
string is_gpo= ""
long il_cve_mat
w_grupos_impartidos_nvo w_ventana

end variables

forward prototypes
public function boolean of_grupo_modificado ()
end prototypes

public function boolean of_grupo_modificado ();// of_grupo_modificado
// Regresa: boolean
// Indica si el registro actual se modificó, para obligar la validacion
// de los resultados y registrarlos

long ll_grupos_modificados, ll_grupos_borrados
long ll_horarios_modificados, ll_horarios_borrados, ll_suma_cambios
long ll_profesores_modificados, ll_profesores_borrados
long ll_grupos_aceptados
integer li_res_cambiar

ll_grupos_aceptados= w_ventana.dw_1.AcceptText()

ll_grupos_modificados= w_ventana.dw_1.modifiedcount()
ll_grupos_borrados= w_ventana.dw_1.deletedcount()

ll_horarios_modificados= w_ventana.dw_horario.modifiedcount()
ll_horarios_borrados= w_ventana.dw_horario.deletedcount()

ll_profesores_modificados= w_ventana.dw_profesor_auxiliar.modifiedcount()
ll_profesores_borrados= w_ventana.dw_profesor_auxiliar.deletedcount()

ll_suma_cambios =ll_grupos_modificados+ll_grupos_borrados+ll_horarios_modificados+ &
                 ll_horarios_borrados+ll_profesores_modificados+ll_profesores_borrados
					  
if ll_suma_cambios>0 then
	li_res_cambiar = messagebox("Grupo Modificado",&
	           "¿Desea cambiar de grupo SIN ALMACENAR los cambios del grupo["+ &
				    string(il_cve_mat)+"-"+is_gpo+"] ?",Question!, YesNo!)
	if li_res_cambiar	= 2 then
		return true
	else
		return false
	end if
else
	return false
end if



end function

on uo_grupos.create
this.cbx_descuenta_sdu_se=create cbx_descuenta_sdu_se
this.rb_editar=create rb_editar
this.rb_insertar=create rb_insertar
this.dw_1=create dw_1
this.Control[]={this.cbx_descuenta_sdu_se,&
this.rb_editar,&
this.rb_insertar,&
this.dw_1}
end on

on uo_grupos.destroy
destroy(this.cbx_descuenta_sdu_se)
destroy(this.rb_editar)
destroy(this.rb_insertar)
destroy(this.dw_1)
end on

event constructor;ii_periodo = gi_periodo
ii_anio = gi_anio

end event

type cbx_descuenta_sdu_se from checkbox within uo_grupos
boolean visible = false
integer x = 718
integer y = 220
integer width = 1362
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Descontar derecho y uso a Servicios Escolares"
boolean lefttext = true
end type

event clicked;if this.checked then
	ib_desc_sdu_se= true
else
	ib_desc_sdu_se= false
end if

end event

type rb_editar from radiobutton within uo_grupos
integer x = 2784
integer y = 32
integer width = 283
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Editar"
boolean checked = true
end type

event clicked;integer li_respuesta
long ll_row, ll_row_resultante
if is_estatus = "Insertar" then
	li_respuesta= MessageBox("Confirme la Edición", &
	            "¿Desea cancelar la captura actual?", Question!, YesNo!)
	if li_respuesta= 1 then
		ll_row = w_ventana.dw_1.GetRow()
		w_ventana.dw_1.DeleteRow(ll_row)
	else
		rb_insertar.Checked = true
		return
	end if
end if
is_estatus = "Editar"
ll_row_resultante = w_ventana.dw_1.TriggerEvent("carga")
dw_1.Enabled = true

end event

type rb_insertar from radiobutton within uo_grupos
integer x = 2784
integer y = 140
integer width = 283
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Insertar"
end type

event clicked;if is_estatus =  "Insertar" then
	return
end if

w_ventana.dw_1.TriggerEvent("nuevo")

end event

type dw_1 from datawindow within uo_grupos
integer x = 23
integer y = 12
integer width = 2761
integer height = 204
integer taborder = 10
string dataobject = "d_grupos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_row
this.SetTransObject(gtr_sce)
ll_row = this.InsertRow(0)
this.ScrollToRow(ll_row)
if isvalid(w_grupos_impartidos_nvo) then
	w_ventana  =  w_grupos_impartidos_nvo
end if
ii_cve_coordinacion = f_obten_coord_de_usuario(gs_usuario)

if ii_cve_coordinacion = 9999 then
	cbx_descuenta_sdu_se.enabled = true
	cbx_descuenta_sdu_se.visible = true
elseif ii_cve_coordinacion = -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar la coordinacion del usuario",StopSign!)
	if isvalid(w_ventana) then
		close(w_ventana)
	end if
else	
	cbx_descuenta_sdu_se.enabled = false
	cbx_descuenta_sdu_se.visible = false	
end if
  
end event

event itemchanged;string ls_columna, ls_gpo, ls_str_null, ls_nombre_materia
long ll_row_resultante
long ll_cve_mat, ll_long_null
if ib_editando then
	return 2
end if

SetNull(ll_long_null)
SetNull(ls_str_null)

this.AcceptText()

ib_editando=true

ls_columna = this.GetColumnName()

ll_cve_mat = this.Object.cve_mat[row]

if isnull(ll_cve_mat) then
	ll_cve_mat= 10000
end if

ls_gpo = this.Object.gpo[row]

if isnull(ls_gpo) then
	ls_gpo= ""
end if

//ll_cve_mat, ls_gpo, ii_periodo, ii_anio)
CHOOSE CASE ls_columna
	CASE "gpo"
		if	of_grupo_modificado() and is_estatus = "Editar"then
			this.SetText(string(is_gpo))
			ib_editando= false
			return 1
		end if
		if ll_cve_mat = 10000 then
			MessageBox("Materia Necesaria","Favor de elegir una materia antes de seleccionar el grupo.",StopSign!)
			this.SetText(string(is_gpo))
			SetColumn("cve_mat")
			ib_editando= false
			return 1
		end if
		if not f_grupo_valido(ls_gpo) then
			MessageBox("Grupo Invalido","El grupo escrito no corresponde a una cadena valida.",StopSign!)
			this.SetText(string(is_gpo))
			SetColumn("gpo")
			ib_editando= false
			return 1
			
		end if

		if ls_gpo <> "" then
			is_gpo= ls_gpo
		end if
	CASE "cve_mat"
		if	of_grupo_modificado() and is_estatus = "Editar" then
			this.SetText(string(il_cve_mat))
			ib_editando= false
			return 1
		end if
		if not(f_materia_valida(ll_cve_mat, ii_cve_coordinacion)) then
			MessageBox("Materia Inexistente", &
			           "La materia "+string(ll_cve_mat)+ " no existe registrada, o no pertenece a su coordinacion.",StopSign!)
			this.SetText(string(il_cve_mat))
			ib_editando= false
			ll_cve_mat = 10000
			return 1
		else
			if ll_cve_mat <> 10000 then		
				ls_nombre_materia = f_obten_nombre_materia(ll_cve_mat)
				this.object.st_nombre.text = ls_nombre_materia
				il_cve_mat = ll_cve_mat
			end if		
		end if
END CHOOSE
IF il_cve_mat <> 10000 AND is_gpo <> "" THEN
		ll_row_resultante = w_ventana.dw_1.TriggerEvent("carga")
END IF
ib_editando= false
RETURN 0


end event

event losefocus;integer li_aceptar
li_aceptar = AcceptText()

end event

event itemerror;RETURN 1
end event

