$PBExportHeader$w_rep_cuenta.srw
$PBExportComments$Reporte de todos los números de cuenta de los inscritos. Ordenados por número de cuenta o por carrera
forward
global type w_rep_cuenta from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_cuenta
end type
type cb_1 from commandbutton within w_rep_cuenta
end type
type uo_1 from uo_ver_per_ani within w_rep_cuenta
end type
type cb_5 from commandbutton within w_rep_cuenta
end type
type dw_1 from uo_dw_reporte within w_rep_cuenta
end type
end forward

global type w_rep_cuenta from Window
int X=834
int Y=362
int Width=3694
int Height=1958
boolean TitleBar=true
string Title="Reporte de Números de Cuenta"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cb_1 cb_1
uo_1 uo_1
cb_5 cb_5
dw_1 dw_1
end type
global w_rep_cuenta w_rep_cuenta

type variables

end variables

on w_rep_cuenta.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cb_1=create cb_1
this.uo_1=create uo_1
this.cb_5=create cb_5
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.cb_1,&
this.uo_1,&
this.cb_5,&
this.dw_1}
end on

on w_rep_cuenta.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.cb_5)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_cuenta
int X=2289
int Y=22
int TabOrder=30
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cb_1 from commandbutton within w_rep_cuenta
int X=2981
int Y=35
int Width=358
int Height=109
int TabOrder=20
string Text="Por Carrera"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_rep_cuenta"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_rep_cuenta_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF
dw_1.event primero()
dw_1.retrieve(gi_version,gi_periodo,gi_anio,0)
end event

type uo_1 from uo_ver_per_ani within w_rep_cuenta
int X=4
int Y=6
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type cb_5 from commandbutton within w_rep_cuenta
int X=2651
int Y=35
int Width=249
int Height=109
int TabOrder=10
boolean BringToTop=true
string Text="Todos"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_rep_cuenta"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_rep_cuenta_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF
dw_1.event primero()
dw_1.retrieve(gi_version,gi_periodo,gi_anio,1)

end event

type dw_1 from uo_dw_reporte within w_rep_cuenta
int X=29
int Y=202
int Width=3613
int Height=1562
int TabOrder=0
string DataObject="dw_rep_cuenta"
end type

event retrieveend;int carr,fol,cont
SetPointer(HourGlass!)
for cont=rowcount to 1 step -1
	fol=object.aspiran_folio[cont]

	SELECT bita_carr.carr_act
	INTO :carr
	FROM bita_carr
	WHERE ( bita_carr.folio = :fol ) AND
		( bita_carr.clv_ver = :gi_version ) AND
		( bita_carr.clv_per = :gi_periodo ) AND
		( bita_carr.anio = :gi_anio )
	ORDER BY bita_carr.fecha DESC
	USING gtr_sadm;
	
	if gtr_sadm.SQLCode = 100 then
		//No modifiques la carrera leída de aspiran
	elseif gtr_sadm.SQLCode < 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
	else 
		object.aspiran_clv_carr[cont]=carr
	End If
next

sort()
GroupCalc( )
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;/**/

return 0
end event

