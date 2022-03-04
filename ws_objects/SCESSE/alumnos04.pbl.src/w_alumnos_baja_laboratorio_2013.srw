$PBExportHeader$w_alumnos_baja_laboratorio_2013.srw
forward
global type w_alumnos_baja_laboratorio_2013 from w_master_main
end type
type st_replica from statictext within w_alumnos_baja_laboratorio_2013
end type
type dw_alumno_baja_laboratorio from uo_master_dw within w_alumnos_baja_laboratorio_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_alumnos_baja_laboratorio_2013
end type
type st_estatus_registro from statictext within w_alumnos_baja_laboratorio_2013
end type
type r_1 from rectangle within w_alumnos_baja_laboratorio_2013
end type
end forward

global type w_alumnos_baja_laboratorio_2013 from w_master_main
integer width = 4439
integer height = 2724
string title = "Captura de Alumnos con Baja de Laboratorio"
string menuname = "m_menu_general_2013"
boolean clientedge = true
event double ( )
st_replica st_replica
dw_alumno_baja_laboratorio dw_alumno_baja_laboratorio
uo_nombre uo_nombre
st_estatus_registro st_estatus_registro
r_1 r_1
end type
global w_alumnos_baja_laboratorio_2013 w_alumnos_baja_laboratorio_2013

type variables
boolean ib_modificando=false
long il_cuenta

end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();//Revisa que los registros sean lógicos y no estén repetidos
long ll_rows, ll_row_actual, ll_row_buscado
integer ll_cve_laboratorio
string ls_busqueda_duplicado
ll_rows = idw_trabajo.RowCount()
for ll_row_actual=1  to ll_rows
	ll_cve_laboratorio= idw_trabajo.GetItemNumber(ll_row_actual, "cve_laboratorio")
	ls_busqueda_duplicado = 'cve_laboratorio = '+string(ll_cve_laboratorio)
	ll_row_buscado = idw_trabajo.find(ls_busqueda_duplicado,1, ll_rows)
	if ll_row_buscado <> 0 and ll_row_buscado <> ll_row_actual then
		idw_trabajo.ScrollToRow(ll_row_actual)	
		MessageBox("Aviso","Laboratorio Duplicado, ~rFavor de escribir un laboratorio distinto", StopSign!)
		return -1	
	end if
next

return 1


end function

on w_alumnos_baja_laboratorio_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.st_replica=create st_replica
this.dw_alumno_baja_laboratorio=create dw_alumno_baja_laboratorio
this.uo_nombre=create uo_nombre
this.st_estatus_registro=create st_estatus_registro
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_replica
this.Control[iCurrent+2]=this.dw_alumno_baja_laboratorio
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.st_estatus_registro
this.Control[iCurrent+5]=this.r_1
end on

on w_alumnos_baja_laboratorio_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_alumno_baja_laboratorio)
destroy(this.uo_nombre)
destroy(this.st_estatus_registro)
destroy(this.r_1)
end on

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())

dw_alumno_baja_laboratorio.retrieve(uo_nombre.of_obten_cuenta())

end event

event open;call super::open;dw_alumno_baja_laboratorio.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

event ue_actualiza;call super::ue_actualiza;//Long		Cuenta
//Integer	Row,i,Todos
Boolean  Hor_insc=False, Preinsc = False, Historic = False, lb_historico_actualizado
String	Nivel
Integer li_periodo, li_anio, li_rows,li_res,Row,i,li_replica_activa
datetime ldttm_fecha_servidor
long todos

if ib_modificando then
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if

	IF dw_alumno_baja_laboratorio.Update(True,True) = 1 Then 
		Commit using gtr_sce;
		
		//INICIO:Replica a Internet
		li_replica_activa = f_replica_Activa()
		if li_replica_activa = 1 then
			f_replica_internet(this,il_cuenta)
			st_replica.text = 'A'
			st_replica.BackColor =RGB(0,255,0)
		else
			st_replica.text = 'I'
			st_replica.BackColor =RGB(255,0,0)
		end if
		//FIN:Replica a Internet						
			
		messagebox("Información","Se han guardado los cambios")				
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if

end event

event activate;//
end event

event closequery;//
end event

event ue_nuevo;call super::ue_nuevo;long ll_ren

ll_ren = dw_alumno_baja_laboratorio.insertrow(0)

dw_alumno_baja_laboratorio.Setitem(ll_ren,'cuenta',il_cuenta)


end event

event ue_borra;call super::ue_borra;
if messagebox("Aviso","¿Esta seguro de querer borrar el campo actual?",Question!,YesNo!,2) = 1 then
	dw_alumno_baja_laboratorio.deleterow(dw_alumno_baja_laboratorio.getrow())
	ib_modificando = true
end if
end event

event close;if ib_modificando then
	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
		if wf_validar () <> 1 then 	
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return 
		else
			 triggerevent("ue_actualiza")
		end if
	end if
end if
end event

type st_sistema from w_master_main`st_sistema within w_alumnos_baja_laboratorio_2013
end type

type p_ibero from w_master_main`p_ibero within w_alumnos_baja_laboratorio_2013
end type

type st_replica from statictext within w_alumnos_baja_laboratorio_2013
integer x = 3342
integer y = 328
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

type dw_alumno_baja_laboratorio from uo_master_dw within w_alumnos_baja_laboratorio_2013
integer x = 1079
integer y = 700
integer width = 1303
integer height = 620
integer taborder = 40
string dataobject = "d_alumno_baja_laboratorio_2013"
boolean hscrollbar = false
end type

event itemchanged;ib_modificando = true
idw_trabajo = this

end event

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this

end event

event retrieveend;call super::retrieveend;integer li_baja_laboratorio 

li_baja_laboratorio = f_obten_baja_laboratorio(il_cuenta)

if li_baja_laboratorio= 1 then
		st_estatus_registro.Text = "BLOQUEADO"
		st_estatus_registro.TextColor = RGB(255,0,0)
elseif li_baja_laboratorio= 0 then
		st_estatus_registro.Text = "DESBLOQUEADO"
		st_estatus_registro.TextColor = RGB(0,128,0)
elseif li_baja_laboratorio= -1 then
		st_estatus_registro.Text = ""
		st_estatus_registro.TextColor = RGB(0,0,0)	
end if
end event

type uo_nombre from uo_nombre_alumno_2013 within w_alumnos_baja_laboratorio_2013
integer x = 101
integer y = 324
integer width = 3250
integer height = 320
integer taborder = 20
end type

event constructor;call super::constructor;m_menu_general_2013.objeto =this

end event

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type st_estatus_registro from statictext within w_alumnos_baja_laboratorio_2013
integer x = 1225
integer y = 1416
integer width = 987
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_alumnos_baja_laboratorio_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 1024
integer y = 672
integer width = 1399
integer height = 692
end type

