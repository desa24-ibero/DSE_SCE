$PBExportHeader$w_formato5.srw
forward
global type w_formato5 from Window
end type
type dw_formato5 from datawindow within w_formato5
end type
type uo_nom_alu from uo_nombre_alumno within w_formato5
end type
type rb_revision from radiobutton within w_formato5
end type
type rb_certificado from radiobutton within w_formato5
end type
type gb_1 from groupbox within w_formato5
end type
end forward

global type w_formato5 from Window
int X=834
int Y=362
int Width=3515
int Height=1882
boolean TitleBar=true
string Title="CERTIFICADO GLOBAL O REVISION DE ESTUDIOS        FORMATO 5"
string MenuName="m_simplificacionadministrativa"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event inicia_proceso ( )
dw_formato5 dw_formato5
uo_nom_alu uo_nom_alu
rb_revision rb_revision
rb_certificado rb_certificado
gb_1 gb_1
end type
global w_formato5 w_formato5

event inicia_proceso;long ll_cuenta, ll_numero, ll_numeracion
int li_tipo
int li_certificado
ll_cuenta = Message.LongParm
if rb_certificado.checked = true then li_certificado = 1
if uo_nom_alu.em_cuenta.text <> " " then
	openwithparm(w_control_sep,ll_cuenta)
	ll_numero = Message.DoubleParm
	messagebox("",string(ll_numero))
	li_tipo = truncate(ll_numero/100000000,0)
	ll_numero = mod(ll_numero,100000000)
	choose case li_tipo
		case 1
			ll_numeracion = 0
		case 2
			ll_numeracion = 0
		case 3
			ll_numeracion = 1
		case 4
			ll_numeracion = 2
		case 5
			ll_numeracion = 2
		case 6
			ll_numeracion = 2
		case else
			ll_numeracion = -1
				end choose
	if ll_numeracion = -1 then
		ll_numero = (li_tipo*100000000) + ll_numero - 1000000000
	else
		ll_numero += (ll_numeracion*100000000)
	end if
	messagebox("",string(ll_numero)+"-"+string(li_tipo)+"-"+string(ll_numeracion))
	if ll_numero > 0 then
		dw_formato5.Event carga(ll_numero,li_certificado)
		if dw_formato5.RowCount() = 0 then
			if (	messagebox("Aviso", "¿Desea insertar un registro para la cuenta "+&
					string(ll_cuenta)+"-"+string(obten_digito(ll_cuenta))+"?",&
					Question!,OkCancel!,1) = 1 ) then
						dw_formato5.Event Nuevo(ll_cuenta,ll_numero,li_tipo)
						dw_formato5.Event carga(ll_numero,li_certificado)
			end if
		end if
	end if
end if
end event

on w_formato5.create
if this.MenuName = "m_simplificacionadministrativa" then this.MenuID = create m_simplificacionadministrativa
this.dw_formato5=create dw_formato5
this.uo_nom_alu=create uo_nom_alu
this.rb_revision=create rb_revision
this.rb_certificado=create rb_certificado
this.gb_1=create gb_1
this.Control[]={this.dw_formato5,&
this.uo_nom_alu,&
this.rb_revision,&
this.rb_certificado,&
this.gb_1}
end on

on w_formato5.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_formato5)
destroy(this.uo_nom_alu)
destroy(this.rb_revision)
destroy(this.rb_certificado)
destroy(this.gb_1)
end on

event open;//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)
x = 1
y = 1
if rb_certificado.enabled then
	rb_certificado.checked = true
else
	rb_revision.checked = true
end if



end event

type dw_formato5 from datawindow within w_formato5
event type integer nuevo ( long al_cuenta,  long al_numero,  integer ai_tipo )
event actualiza ( )
event type integer carga ( long al_cuenta,  integer ai_certificado )
int X=59
int Y=688
int Width=3405
int Height=966
int TabOrder=10
string DataObject="d_formato5_ver2"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event nuevo;int li_ciclos_cursados
DataStore lds_carreraalumno
lds_carreraalumno = Create DataStore
lds_carreraalumno.DataObject = "d_carreraalumno"
lds_carreraalumno.SetTrans(gtr_sce)
lds_carreraalumno.retrieve(al_cuenta)
if lds_carreraalumno.RowCount() = 1 then
	ScrollToRow(insertrow(0))
	SetItem(GetRow(),"control_sep_numero",al_numero)
	SetItem(GetRow(),"control_sep_cuenta",al_cuenta)
	SetItem(GetRow(),"control_sep_fecha_emision",Today())
	SetItem(GetRow(),"control_sep_cve_carrera",lds_carreraalumno.getitemnumber(1,"academicos_cve_carrera"))
	SetItem(GetRow(),"control_sep_cve_plan",lds_carreraalumno.getitemnumber(1,"academicos_cve_plan"))
	li_ciclos_cursados = obten_ciclos(al_cuenta,&
								lds_carreraalumno.getitemnumber(1,"academicos_cve_carrera"),&
								lds_carreraalumno.getitemnumber(1,"academicos_cve_plan"),&
								lds_carreraalumno.getitemnumber(1,"academicos_cve_subsistema"))
	if li_ciclos_cursados= 0 then
		li_ciclos_cursados = f_obten_sem_cursados(al_cuenta)
	end if
	SetItem(GetRow(),"control_sep_ciclos_cursados",li_ciclos_cursados)
	SetItem(GetRow(),"control_sep_cve_doc_control_sep",ai_tipo)
	Event Actualiza()	
else
	Messagebox("Error", "Error al consultar la carrera del alumno")
end if
Destroy lds_carreraalumno
return 0
end event

event actualiza;if Update() = 1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
else
		rollback using gtr_sce;
		MessageBox("Atención","No se han guardado los cambios")
end if
end event

event carga;return retrieve(al_cuenta,ai_certificado)
end event

event constructor;SetTrans(gtr_sce)
m_simplificacionadministrativa.dw = this
end event

type uo_nom_alu from uo_nombre_alumno within w_formato5
int X=40
int Y=269
int Height=493
int TabOrder=30
boolean Enabled=true
end type

on uo_nom_alu.destroy
call uo_nombre_alumno::destroy
end on

type rb_revision from radiobutton within w_formato5
int X=801
int Y=134
int Width=662
int Height=77
string Text="Revision de Estudios"
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_certificado from radiobutton within w_formato5
int X=183
int Y=134
int Width=549
int Height=77
string Text="Certificado Global"
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_formato5
int X=66
int Y=45
int Width=1445
int Height=205
int TabOrder=20
string Text="Tipo de documento"
BorderStyle BorderStyle=StyleLowered!
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

