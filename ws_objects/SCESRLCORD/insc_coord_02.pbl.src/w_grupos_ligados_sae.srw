$PBExportHeader$w_grupos_ligados_sae.srw
forward
global type w_grupos_ligados_sae from window
end type
type cb_1 from commandbutton within w_grupos_ligados_sae
end type
type dw_grupos_ligados from datawindow within w_grupos_ligados_sae
end type
end forward

global type w_grupos_ligados_sae from window
integer width = 2030
integer height = 956
boolean titlebar = true
string title = "Horario de Grupos Ligados"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_grupos_ligados dw_grupos_ligados
end type
global w_grupos_ligados_sae w_grupos_ligados_sae

type variables
string is_gpo = '--'
end variables

event open;long ll_periodo, ll_anio, ll_cve_mat, ll_rows
st_grupo_ligado_sae lst_grupo_ligado_sae

dw_grupos_ligados.SetTransObject(SQLCA)

lst_grupo_ligado_sae = Message.PowerObjectParm

ll_cve_mat =	lst_grupo_ligado_sae.cve_mat 
ll_periodo =	lst_grupo_ligado_sae.periodo
ll_anio =	lst_grupo_ligado_sae.anio 

ll_rows = dw_grupos_ligados.Retrieve(ll_cve_mat, ll_periodo, ll_anio)
end event

on w_grupos_ligados_sae.create
this.cb_1=create cb_1
this.dw_grupos_ligados=create dw_grupos_ligados
this.Control[]={this.cb_1,&
this.dw_grupos_ligados}
end on

on w_grupos_ligados_sae.destroy
destroy(this.cb_1)
destroy(this.dw_grupos_ligados)
end on

event close;return
end event

type cb_1 from commandbutton within w_grupos_ligados_sae
integer x = 777
integer y = 752
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cerrar"
end type

event clicked;Close(parent)
end event

type dw_grupos_ligados from datawindow within w_grupos_ligados_sae
integer y = 4
integer width = 1989
integer height = 732
integer taborder = 10
string title = "Elija el Grupo Ligado (Teoría-Laboratorio) con doble-click"
string dataobject = "d_grupos_ligados_sae"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = StyleRaised!
end type

event doubleclicked;string ls_gpo
long ll_row
integer li_confirmacion
ll_row = row

if ll_row >0 then
	ls_gpo = this.GetItemString(ll_row, "grupos_gpo")
	is_gpo = ls_gpo
	li_confirmacion = MessageBox("Confirmación","¿Desea elegir al grupo ["+string(ls_gpo)+"] ?", Question!, YesNo!)
	if li_confirmacion = 1 then
		CloseWithReturn(w_grupos_ligados_sae, is_gpo )
	end if
end if


end event

