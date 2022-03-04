$PBExportHeader$w_camb_carr.srw
$PBExportComments$Usa el dw_camb_carr y guarda los cambios en la bitácora bita_carr
forward
global type w_camb_carr from Window
end type
type dw_1 from uo_dw_captura_aux within w_camb_carr
end type
type dw_2 from datawindow within w_camb_carr
end type
type dw_1_ant from datawindow within w_camb_carr
end type
type uo_nombre from uo_nombre_aspirante within w_camb_carr
end type
end forward

global type w_camb_carr from Window
int X=5
int Y=5
int Width=3543
int Height=1437
boolean TitleBar=true
string Title="Cambia Carrera"
string MenuName="m_menu"
long BackColor=10789024
dw_1 dw_1
dw_2 dw_2
dw_1_ant dw_1_ant
uo_nombre uo_nombre
end type
global w_camb_carr w_camb_carr

type variables
string salones[]
int num_salones
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_camb_carr.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_1_ant=create dw_1_ant
this.uo_nombre=create uo_nombre
this.Control[]={ this.dw_1,&
this.dw_2,&
this.dw_1_ant,&
this.uo_nombre}
end on

on w_camb_carr.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_1_ant)
destroy(this.uo_nombre)
end on

event open;x = 1
y = 1

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = false
uo_nombre.cbx_nuevo.enabled = false
end event

event doubleclicked;dw_1.event cargar(long(uo_nombre.em_cuenta.text))

end event

type dw_1 from uo_dw_captura_aux within w_camb_carr
event cargar ( long folio )
int X=787
int Y=429
int Width=1948
int Height=185
int TabOrder=20
string DataObject="dw_camb_carr"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event cargar;call super::cargar;/*event actualiza()*/
dw_2.event carga(folio)
retrieve(folio,gi_version,gi_periodo,gi_anio)
end event

event constructor;m_menu.dw = this

DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
Settransobject(gtr_sce)
carr.retrieve()
dw_1.Modify("clv_carr.dddw.PercentWidth=128")
dw_1.Modify("clv_carr.dddw.VScrollBar= Yes")
dw_1.Modify("clv_carr.dddw.HScrollBar= Yes")
dw_1.Modify("clv_carr.dddw.UseAsBorder= Yes")

end event

event anterior;//event actualiza()
//uo_nombre.event anterior()
return 
end event

event itemchanged;call super::itemchanged;long columna,fol
int car_ant,car_act
datetime hoy

columna = getcolumn()

if columna=2 then

	hoy=datetime(today(),now())
	fol=object.folio[1]

	car_ant=object.clv_carr[1]
	car_act=integer(data)

//	car_ant=this.GetItemNumber(1, "clv_carr", Primary!, TRUE) 

	this.SetItem(row,2, car_act)		
	
	this.SetText(string(car_act))		

	INSERT INTO bita_carr
		( folio, clv_ver, clv_per, anio, fecha, carr_ant, carr_act, usuario )  
	VALUES ( :fol,:gi_version,:gi_periodo,:gi_anio,:hoy,:car_ant,:car_act,:gs_usuario) 
	using gtr_sadm;

	if gtr_sadm.SqlCode= -1 then
		rollback using gtr_sadm;
		MessageBox("Error al grabar bita_bachi",gtr_sadm.SQLErrText )
	else
		commit using gtr_sadm;
		dw_2.event carga(fol)
	end if
	
//	
//	if this.Update()<> -1 then
//		event cargar(fol)
//	end if
end if
end event

event primero;event actualiza()
uo_nombre.event primero()
end event

event siguiente;//event actualiza()
//uo_nombre.event siguiente()
return
end event

event ultimo;//event actualiza()
//uo_nombre.event ultimo()
return
end event

event actualiza;long ll_carrera, ll_folio

	ll_folio=object.folio[1]
	ll_carrera=object.clv_carr[1]

//	ll_folio=this.GetItemNumber(1, "folio", Primary!, FALSE) 
//	ll_carrera=this.GetItemNumber(1, "clv_carr", Primary!, FALSE) 
	
		MessageBox("Folio: "+String(ll_folio),"Carrera: "+string(ll_carrera) )
	
	UPDATE aspiran
	SET clv_carr = :ll_carrera
	WHERE clv_ver = :gi_version
	AND	clv_per = :gi_periodo
	AND	anio = :gi_anio
	AND 	folio = :ll_folio
	using gtr_sadm;

	if gtr_sadm.SqlCode= -1 then
		MessageBox("Error al grabar aspiran",gtr_sadm.SQLErrText )
		rollback using gtr_sadm;
	elseif gtr_sadm.SqlCode= 100 then
		MessageBox("No hay registros",gtr_sadm.SQLErrText )
	else
		commit using gtr_sadm;
	end if

return 0

end event

event actualiza_0_int;return 0
end event

event actualiza_np;return 0
end event

event carga;return 0
end event

event borra;return 
end event

event nuevo;return 
end event

event keyboard;return 
end event

type dw_2 from datawindow within w_camb_carr
event carga ( long folio )
int Y=625
int Width=3521
int Height=637
string DataObject="dw_bita_carr"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event carga;/*event actualiza()*/
retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

event constructor;m_menu.dw = this

DataWindowChild carr
getchild("carr_ant",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild carr2
getchild("carr_act",carr2)
carr2.settransobject(gtr_sce)
carr2.retrieve()
end event

type dw_1_ant from datawindow within w_camb_carr
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
int X=5
int Y=429
int Width=1948
int Height=185
boolean Visible=false
string DataObject="dw_camb_carr"
end type

event primero;event actualiza()
uo_nombre.event primero()
end event

event anterior;event actualiza()
uo_nombre.event anterior()
end event

event siguiente;event actualiza()
uo_nombre.event siguiente()
end event

event ultimo;event actualiza()
uo_nombre.event ultimo()
end event

event carga;/*event actualiza()*/
dw_2.event carga(folio)
return retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

event itemchanged;long columna,fol
int car_ant,car_act
datetime hoy

columna = getcolumn()

if columna=2 then

	hoy=datetime(today(),now())
	fol=object.folio[1]
	car_ant=object.clv_carr[1]
	car_act=integer(data)
	
	INSERT INTO bita_carr
		( folio, clv_ver, clv_per, anio, fecha, carr_ant, carr_act, usuario )  
	VALUES ( :fol,:gi_version,:gi_periodo,:gi_anio,:hoy,:car_ant,:car_act,:gs_usuario) 
	using gtr_sadm;
	commit using gtr_sadm;

	event carga(fol)
	
end if
end event

event constructor;//m_menu.dw = this

//DataWindowChild carr
//getchild("clv_carr",carr)
//carr.settransobject(gtr_sce)
//carr.retrieve()
end event

type uo_nombre from uo_nombre_aspirante within w_camb_carr
int X=142
int Y=1
int TabOrder=10
boolean Enabled=true
long BackColor=1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante::destroy
end on

