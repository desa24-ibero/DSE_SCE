$PBExportHeader$w_cap_aplicadores.srw
forward
global type w_cap_aplicadores from Window
end type
type uo_1 from uo_ver_per_ani within w_cap_aplicadores
end type
type dw_1 from uo_dw_captura within w_cap_aplicadores
end type
end forward

global type w_cap_aplicadores from Window
int X=833
int Y=361
int Width=3671
int Height=1957
boolean TitleBar=true
string Title="Captura de Aplicadores"
string MenuName="m_menu"
long BackColor=30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_cap_aplicadores w_cap_aplicadores

type variables
DataWindowChild sal
end variables

on w_cap_aplicadores.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.uo_1,&
this.dw_1}
end on

on w_cap_aplicadores.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_cap_aplicadores
int X=1
int Y=17
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_cap_aplicadores
int X=23
int Y=201
int Width=3607
int Height=1557
int TabOrder=20
string DataObject="dw_cap_aplicadores"
end type

event constructor;call super::constructor;getchild("salon",sal)
sal.settransobject(gtr_sadm)
sal.retrieve(gi_version,gi_periodo,gi_anio)
end event

event doubleclicked;call super::doubleclicked;int numero
string nombre,apaterno,amaterno

if row>0 then
	numero=object.numero[row]
	SELECT profesor.nombre,profesor.apaterno,profesor.amaterno  
	INTO :nombre,:apaterno,:amaterno  
	FROM profesor  
	WHERE profesor.cve_profesor = :numero
	USING gtr_sce;
	object.nombre[row]=nombre
	object.apaterno[row]=apaterno
	object.amaterno[row]=amaterno
end if
	
	

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;getchild("salon",sal)
sal.settransobject(gtr_sadm)

sal.retrieve(gi_version,gi_periodo,gi_anio)

if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

event nuevo;long renglon
event actualiza()

if gi_version<>99 then
	setfocus()
	renglon=insertrow(0)
	scrolltorow(renglon)
	setcolumn(1)
	object.anio[renglon]=gi_anio
	object.clv_per[renglon]=gi_periodo
	object.clv_ver[renglon]=gi_version
end if
end event

