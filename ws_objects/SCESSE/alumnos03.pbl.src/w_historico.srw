$PBExportHeader$w_historico.srw
$PBExportComments$Esta ventana es de consulta se despliega todas las materias anteriores incritas,calificacion,periodo,anio etc. de la tabla de historico. Juan Campos Nov-1996
forward
global type w_historico from window
end type
type cb_imprime from commandbutton within w_historico
end type
type em_cuentaaux from editmask within w_historico
end type
type uo_nombre from uo_nombre_alumno within w_historico
end type
type dw_historico from datawindow within w_historico
end type
type dw_1 from datawindow within w_historico
end type
end forward

global type w_historico from window
integer x = 5
integer y = 4
integer width = 3625
integer height = 3152
boolean titlebar = true
string title = "HISTORIA ACADÉMICA"
string menuname = "m_historico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 27291696
cb_imprime cb_imprime
em_cuentaaux em_cuentaaux
uo_nombre uo_nombre
dw_historico dw_historico
dw_1 dw_1
end type
global w_historico w_historico

on w_historico.create
if this.MenuName = "m_historico" then this.MenuID = create m_historico
this.cb_imprime=create cb_imprime
this.em_cuentaaux=create em_cuentaaux
this.uo_nombre=create uo_nombre
this.dw_historico=create dw_historico
this.dw_1=create dw_1
this.Control[]={this.cb_imprime,&
this.em_cuentaaux,&
this.uo_nombre,&
this.dw_historico,&
this.dw_1}
end on

on w_historico.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_imprime)
destroy(this.em_cuentaaux)
destroy(this.uo_nombre)
destroy(this.dw_historico)
destroy(this.dw_1)
end on

event open;// Juan Campos. Feb-1997.

this.x = 1
this.y = 1

//m_historico.m_elijaunorden.m_por_clave.Checked = False
//m_historico.m_elijaunorden.m_por_periodo.Checked = True

dw_historico.SetTransObject(gtr_sce)
dw_1.SetTransObject(gtr_sce)
 
end event

event doubleclicked;// Juan Campos. Nov-1997.

long ll_row, ll_cuenta


ll_row = uo_nombre.dw_nombre_alumno.GetRow()
ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

if f_alumno_restringido (ll_cuenta) then
	if f_usuario_especial(gs_usuario) then
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

		return		
	end if
end if

m_historico.m_tipodeconsulta.enabled = True
m_historico.m_revision.enabled = true
m_historico.m_elijaunorden.m_por_periodo.Checked = true
m_historico.m_tipodeconsulta.m_acreditadas.Checked = false
m_historico.m_tipodeconsulta.m_bajas.Checked = false
m_historico.m_tipodeconsulta.m_historico1.Checked = True
m_historico.m_tipodeconsulta.m_incompletas.Checked = false
m_historico.m_tipodeconsulta.m_reprobadas.Checked = false
m_historico.m_tipodeconsulta.m_revalidadas.Checked = false

em_cuentaaux.text=this.uo_nombre.em_cuenta.text 

if this.dw_historico.retrieve(long(this.uo_nombre.em_cuenta.text),"5","9","10","AC","NA","RE","IN","BA","BJ","E","MB","B","S") = 0 then
  MessageBox("Aviso","No se encontró información con esta cuenta")
Else
  this.dw_1.retrieve(long(this.uo_nombre.em_cuenta.text),"5","9","10","AC","NA","RE","IN","BA","BJ","E","MB","B","S")  
end if  
 

end event

type cb_imprime from commandbutton within w_historico
integer x = 3264
integer y = 204
integer width = 265
integer height = 108
integer taborder = 11
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime"
end type

event clicked;// Juan Campos Sánchez. 	Feb-1998.

If dw_1.retrieve(long(w_historico.uo_nombre.em_cuenta.text),"5","9","10","AC","NA","RE","IN","BA","BJ","E","MB","B","S")  = 0 Then
  Messagebox("No hay datos para imprimir","",StopSign!)	
Else
	dw_1.print()
End if
end event

type em_cuentaaux from editmask within w_historico
boolean visible = false
integer x = 631
integer y = 1760
integer width = 274
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type uo_nombre from uo_nombre_alumno within w_historico
integer x = 9
integer y = 12
integer width = 3241
integer height = 424
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type dw_historico from datawindow within w_historico
integer x = 9
integer y = 420
integer width = 3502
integer height = 1308
integer taborder = 20
string dataobject = "dw_historico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;long ll_cuenta
long ll_cve_mat
string ls_gpo
integer li_periodo
long li_anio
integer li_materia_en_intercambio_temp
long ll_row

FOR ll_row = 1 TO rowcount
	ls_gpo = this.GetItemString(ll_row,"historico_gpo")

	if ls_gpo = "ZZ" then

		ll_cuenta = this.GetItemNumber(ll_row,"historico_cuenta")
		ll_cve_mat = this.GetItemNumber(ll_row,"historico_cve_mat")
		li_periodo = this.GetItemNumber(ll_row,"historico_periodo")
		li_anio = this.GetItemNumber(ll_row,"historico_anio")
	
		li_materia_en_intercambio_temp = f_materia_en_intercambio_temp(ll_cuenta, ll_cve_mat, ls_gpo, li_periodo, li_anio)
	
		if li_materia_en_intercambio_temp = 1 then
			this.SetItem(ll_row,"hti", li_materia_en_intercambio_temp)
		end if

	end if
NEXT



string ls_filtro_intercambio

ls_filtro_intercambio = "hti = 0"

this.SetFilter(ls_filtro_intercambio)

this.Filter( )


end event

type dw_1 from datawindow within w_historico
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
integer x = 5
integer y = 2204
integer width = 3534
integer height = 1136
integer taborder = 40
string dataobject = "dw_historico_rep2"
boolean livescroll = true
end type

event constructor;m_historico.dw = this

end event

event retrieveend;
long ll_cuenta
long ll_cve_mat
string ls_gpo
integer li_periodo
long li_anio
integer li_materia_en_intercambio_temp
long ll_row

FOR ll_row = 1 TO rowcount
	ls_gpo = this.GetItemString(ll_row,"historico_gpo")

	if ls_gpo = "ZZ" then

		ll_cuenta = this.GetItemNumber(ll_row,"historico_cuenta")
		ll_cve_mat = this.GetItemNumber(ll_row,"historico_cve_mat")
		li_periodo = this.GetItemNumber(ll_row,"historico_periodo")
		li_anio = this.GetItemNumber(ll_row,"historico_anio")
	
		li_materia_en_intercambio_temp = f_materia_en_intercambio_temp(ll_cuenta, ll_cve_mat, ls_gpo, li_periodo, li_anio)
	
		if li_materia_en_intercambio_temp = 1 then
			this.SetItem(ll_row,"hti", li_materia_en_intercambio_temp)
		end if

	end if
NEXT



string ls_filtro_intercambio

ls_filtro_intercambio = "hti = 0"

this.SetFilter(ls_filtro_intercambio)

this.Filter( )


end event

