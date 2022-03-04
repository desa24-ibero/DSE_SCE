$PBExportHeader$w_bajas_finanzas.srw
forward
global type w_bajas_finanzas from Window
end type
type st_materias_bloqueadas from statictext within w_bajas_finanzas
end type
type st_tipo_baja from statictext within w_bajas_finanzas
end type
type uo_anio_periodo from uo_per_ani within w_bajas_finanzas
end type
type uo_1 from uo_nombre_alumno_busqueda within w_bajas_finanzas
end type
type dw_mat_inscritas from datawindow within w_bajas_finanzas
end type
type dw_historico_baja_finanzas_por_cuenta from datawindow within w_bajas_finanzas
end type
end forward

global type w_bajas_finanzas from Window
int X=1056
int Y=484
int Width=3959
int Height=2196
boolean TitleBar=true
string Title="Bajas por Finanzas"
string MenuName="m_bajas_finanzas"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event inicia_proceso ( )
st_materias_bloqueadas st_materias_bloqueadas
st_tipo_baja st_tipo_baja
uo_anio_periodo uo_anio_periodo
uo_1 uo_1
dw_mat_inscritas dw_mat_inscritas
dw_historico_baja_finanzas_por_cuenta dw_historico_baja_finanzas_por_cuenta
end type
global w_bajas_finanzas w_bajas_finanzas

type variables
//0 en mat_inscritas 1 en el periodo gi_periodo, gi_anio
int ii_tipo_baja 
//int ii_tipo_reactivacion
end variables

forward prototypes
public subroutine cambiatipobaja (integer ai_baja)
public function integer baja ()
public function integer reactiva ()
end prototypes

event inicia_proceso;int li_i 
dw_historico_baja_finanzas_por_cuenta.Retrieve(long(uo_1.em_cuenta.text))
st_tipo_baja.text = "Materias Actualmente Inscritas "
if ii_tipo_baja = 0 then
	uo_anio_periodo.Visible = False
	li_i = dw_mat_inscritas.Retrieve(long(uo_1.em_cuenta.text))
	if ( li_i > 0) then
		dw_mat_inscritas.SetFilter("mat_inscritas_cve_condicion = 3")
		dw_mat_inscritas.Filter()
		if dw_mat_inscritas.RowCount() = li_i then
			//ii_tipo_reactivacion = 0
			st_tipo_baja.text = "Materias Actualmente Bloqueadas "
		elseif dw_mat_inscritas.RowCount() = 0 then
			//ii_tipo_reactivacion = 1
			st_tipo_baja.text = "Materias Actualmente Inscritas "
		else
			MessageBox("Atencion","El alumno no tiene todas sus materias inscritas bloqueadas")
			uo_1.em_cuenta.text = "0"
			event inicia_proceso()
		end if
		dw_mat_inscritas.SetFilter("mat_inscritas_cve_condicion IN (0,1,3)")
		dw_mat_inscritas.Filter()
	end if
else
	//ii_tipo_reactivacion = 1
	dw_mat_inscritas.Retrieve(long(uo_1.em_cuenta.text),gi_anio, gi_periodo)
	uo_anio_periodo.Visible = True
	st_tipo_baja.text = "Materias Cursadas durante el periodo de "
   choose case gi_periodo
		case 0
			st_tipo_baja.text += "Primavera de " +string(gi_anio)
		case 1
			st_tipo_baja.text += "Verano de " +string(gi_anio)
		case 2
			st_tipo_baja.text += "Otoño de " +string(gi_anio)
	end choose
end if
st_materias_bloqueadas.text = "Materias Bloqueadas : "+string(dw_historico_baja_finanzas_por_cuenta.RowCount())
st_tipo_baja.text += " : "+string(dw_mat_inscritas.RowCount())
end event

public subroutine cambiatipobaja (integer ai_baja);/*
 *		Nombre	cambiatipobaja
 *		Recibe	ai_baja
 *		Regresa	Nada, cambia la variable de instancia ii_tipo_baja segun el argumento que reciba
 *					ii_tipo_baja: 0 en mat_inscritas 1 en el periodo gi_periodo, gi_anio
 *					FMC20051999
 */
ii_tipo_baja = ai_baja
if ii_tipo_baja = 0 then
	dw_mat_inscritas.DataObject = "dw_mat_inscritas"
	dw_mat_inscritas.SetTransObject(gtr_sce)
	dw_mat_inscritas.SetFilter("mat_inscritas_cve_condicion IN (0,1,3)")
	uo_anio_periodo.Visible = False
else
	dw_mat_inscritas.DataObject = "d_historico_porcuentaanioper"
	dw_mat_inscritas.SetTransObject(gtr_sce)
	dw_mat_inscritas.SetFilter("")
	uo_anio_periodo.Visible = True
end if
if long(uo_1.em_cuenta.text) > 0 then event inicia_proceso()

end subroutine

public function integer baja ();int li_i,li_tot
if dw_mat_inscritas.RowCount() = 0 then
	MessageBox("Atención","No hay algo que dar de baja")
	return 0
elseif dw_mat_inscritas.RowCount() > 0 then
	li_tot = dw_mat_inscritas.RowCount()
	for li_i = 1 to li_tot
		if ii_tipo_baja = 0 then //materias inscritas
			dw_mat_inscritas.SetItem(li_i,"mat_inscritas_cve_condicion",3)
		else
			dw_historico_baja_finanzas_por_cuenta.InsertRow(li_i)
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"cuenta",dw_mat_inscritas.GetItemNumber(1,"cuenta"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"cve_mat",dw_mat_inscritas.GetItemNumber(1,"cve_mat"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"gpo",dw_mat_inscritas.GetItemString(1,"gpo"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"periodo",dw_mat_inscritas.GetItemNumber(1,"periodo"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"anio",dw_mat_inscritas.GetItemNumber(1,"anio"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"cve_carrera",dw_mat_inscritas.GetItemNumber(1,"cve_carrera"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"cve_plan",dw_mat_inscritas.GetItemNumber(1,"cve_plan"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"calificacion",dw_mat_inscritas.GetItemString(1,"calificacion"))
			dw_historico_baja_finanzas_por_cuenta.SetItem(li_i,"observacion",dw_mat_inscritas.GetItemNumber(1,"observacion"))
			dw_mat_inscritas.DeleteRow(1)
		end if
	next
	if dw_mat_inscritas.Update() = 1 AND dw_historico_baja_finanzas_por_cuenta.Update() = 1 then
		commit using gtr_sce;
	else
		rollback;
		MessageBox("Atención","Los cambios no se guardaron")
		li_i = -1
	end if
	event inicia_proceso()
	return li_i
else
	MessageBox("Error de comunicacion","Error al dar de baja las materias")
	return -1
end if

end function

public function integer reactiva ();/*
 *		Nombre	reactiva
 *		Recibe	Nada
 *		Regresa	El numero de materias que reactivo
 *					-1 Error de comunicacion
 *					FMC20051999
 */

int li_a, li_tot
if (((dw_historico_baja_finanzas_por_cuenta.RowCount() = 0) and (ii_tipo_baja = 1))&
	OR ((dw_mat_inscritas.RowCount() = 0) and (ii_tipo_baja = 0))) then
	MessageBox("Atención","No hay algo que reactivar")
	return 0
else
	if (ii_tipo_baja = 1) then
		li_tot = dw_historico_baja_finanzas_por_cuenta.RowCount()
		for li_a = 1 to li_tot
			dw_mat_inscritas.InsertRow(li_a)
			dw_mat_inscritas.SetItem(li_a,"cuenta",dw_historico_baja_finanzas_por_cuenta.GetItemNumber(1,"cuenta"))
			dw_mat_inscritas.SetItem(li_a,"cve_mat",dw_historico_baja_finanzas_por_cuenta.GetItemNumber(1,"cve_mat"))
			dw_mat_inscritas.SetItem(li_a,"gpo",dw_historico_baja_finanzas_por_cuenta.GetItemString(1,"gpo"))
			dw_mat_inscritas.SetItem(li_a,"periodo",dw_historico_baja_finanzas_por_cuenta.GetItemNumber(1,"periodo"))
			dw_mat_inscritas.SetItem(li_a,"anio",dw_historico_baja_finanzas_por_cuenta.GetItemNumber(1,"anio"))
			dw_mat_inscritas.SetItem(li_a,"cve_carrera",dw_historico_baja_finanzas_por_cuenta.GetItemNumber(1,"cve_carrera"))
			dw_mat_inscritas.SetItem(li_a,"cve_plan",dw_historico_baja_finanzas_por_cuenta.GetItemNumber(1,"cve_plan"))
			dw_mat_inscritas.SetItem(li_a,"calificacion",dw_historico_baja_finanzas_por_cuenta.GetItemString(1,"calificacion"))
			dw_mat_inscritas.SetItem(li_a,"observacion",dw_historico_baja_finanzas_por_cuenta.GetItemNumber(1,"observacion"))
			dw_historico_baja_finanzas_por_cuenta.DeleteRow(1)
		next
	else
		for li_a = 1 to dw_mat_inscritas.RowCount()
			if dw_mat_inscritas.GetItemString(li_a,"mat_inscritas_calificacion") = "BA" then
				dw_mat_inscritas.SetItem(li_a,"mat_inscritas_cve_condicion",1)
			else
				dw_mat_inscritas.SetItem(li_a,"mat_inscritas_cve_condicion",0)
			end if
		next
	end if
	if dw_mat_inscritas.Update() = 1 AND dw_historico_baja_finanzas_por_cuenta.Update() = 1 then
		commit using gtr_sce;
	else
		rollback;
		MessageBox("Atención","Los cambios no se guardaron")
		li_a = -1
	end if
	event inicia_proceso()
	return li_a
end if


end function

on w_bajas_finanzas.create
if this.MenuName = "m_bajas_finanzas" then this.MenuID = create m_bajas_finanzas
this.st_materias_bloqueadas=create st_materias_bloqueadas
this.st_tipo_baja=create st_tipo_baja
this.uo_anio_periodo=create uo_anio_periodo
this.uo_1=create uo_1
this.dw_mat_inscritas=create dw_mat_inscritas
this.dw_historico_baja_finanzas_por_cuenta=create dw_historico_baja_finanzas_por_cuenta
this.Control[]={this.st_materias_bloqueadas,&
this.st_tipo_baja,&
this.uo_anio_periodo,&
this.uo_1,&
this.dw_mat_inscritas,&
this.dw_historico_baja_finanzas_por_cuenta}
end on

on w_bajas_finanzas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_materias_bloqueadas)
destroy(this.st_tipo_baja)
destroy(this.uo_anio_periodo)
destroy(this.uo_1)
destroy(this.dw_mat_inscritas)
destroy(this.dw_historico_baja_finanzas_por_cuenta)
end on

event open;x=1
y=1
CambiaTipoBaja(0)

end event

type st_materias_bloqueadas from statictext within w_bajas_finanzas
int X=151
int Y=732
int Width=439
int Height=600
boolean Enabled=false
string Text="Materias Bloqueadas"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=10789024
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_tipo_baja from statictext within w_bajas_finanzas
int X=151
int Y=1372
int Width=439
int Height=600
boolean Enabled=false
string Text="Materias Actualmente Inscritas "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=10789024
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_anio_periodo from uo_per_ani within w_bajas_finanzas
int X=2162
int Y=516
int TabOrder=20
boolean Visible=false
boolean Enabled=true
long BackColor=1090519039
end type

on uo_anio_periodo.destroy
call uo_per_ani::destroy
end on

event constructor;DataStore lds_anioperiodo_mat_inscritas
lds_anioperiodo_mat_inscritas = Create DataStore
lds_anioperiodo_mat_inscritas.DataObject = "d_anioperiodo_mat_inscritas"
lds_anioperiodo_mat_inscritas.SetTransObject(gtr_sce)
if lds_anioperiodo_mat_inscritas.Retrieve() = 1 then
	gi_anio = lds_anioperiodo_mat_inscritas.GetItemNumber(1,"anio")
	gi_periodo = lds_anioperiodo_mat_inscritas.GetItemNumber(1,"periodo") 
else
	MessageBox("Error de comunicación","Error en la consulta de periodo y anio")
end if
Destroy lds_anioperiodo_mat_inscritas

end event

type uo_1 from uo_nombre_alumno_busqueda within w_bajas_finanzas
int X=183
int Y=76
int TabOrder=10
boolean Enabled=true
end type

on uo_1.destroy
call uo_nombre_alumno_busqueda::destroy
end on

type dw_mat_inscritas from datawindow within w_bajas_finanzas
int X=663
int Y=1356
int Width=2491
int Height=620
int TabOrder=30
string DataObject="dw_mat_inscritas"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
end event

type dw_historico_baja_finanzas_por_cuenta from datawindow within w_bajas_finanzas
int X=663
int Y=720
int Width=2491
int Height=620
int TabOrder=20
string DataObject="d_historico_bajas_finanzas_porcuenta"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
end event

