$PBExportHeader$w_rep_paq.srw
$PBExportComments$Reporte de inscritos con el paquete de materias que les corresponde.
forward
global type w_rep_paq from window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_paq
end type
type uo_1 from uo_ver_per_ani within w_rep_paq
end type
type dw_1 from uo_dw_reporte within w_rep_paq
end type
end forward

global type w_rep_paq from window
integer x = 832
integer y = 364
integer width = 3694
integer height = 1976
boolean titlebar = true
string title = "Reporte de Paquetes Asignados"
string menuname = "m_menu"
long backcolor = 30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_rep_paq w_rep_paq

type variables

end variables

on w_rep_paq.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_1,&
this.dw_1}
end on

on w_rep_paq.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_paq
integer x = 2290
integer y = 24
integer height = 136
integer taborder = 10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_rep_paq
integer x = 5
integer y = 8
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_rep_paq
integer x = 37
integer y = 204
integer width = 3611
integer height = 1568
integer taborder = 0
string dataobject = "dw_rep_paq"
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_rep_paq"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_rep_paq_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

event primero()
object.st_1.text=tit1
return retrieve(gi_version,gi_periodo,gi_anio)

end event

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

end event

event retrieveend;call super::retrieveend;int carr,fol,cont

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
	elseif gtr_sadm.SQLCode > 0 then
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

event retrieverow;call super::retrieverow;string ls_digito
long ll_cuenta

ll_cuenta = this.GetItemNumber(row,"general_cuenta")
IF ll_cuenta<>0 THEN
	ls_digito = obten_digito(ll_cuenta)
ELSE
	ls_digito = ""
END IF
this.SetItem(row,"digito", ls_digito)



end event

