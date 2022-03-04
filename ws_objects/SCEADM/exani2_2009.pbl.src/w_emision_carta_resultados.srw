$PBExportHeader$w_emision_carta_resultados.srw
$PBExportComments$Permite elegir que folios se imprimirán las cartas de resultados, los ordena alfabéticamente
forward
global type w_emision_carta_resultados from w_main
end type
type ddlb_opcion from dropdownlistbox within w_emision_carta_resultados
end type
type dw_2 from datawindow within w_emision_carta_resultados
end type
type uo_1 from uo_ver_per_ani within w_emision_carta_resultados
end type
type em_max from editmask within w_emision_carta_resultados
end type
type em_min from editmask within w_emision_carta_resultados
end type
type dw_1 from uo_dw_reporte within w_emision_carta_resultados
end type
end forward

global type w_emision_carta_resultados from w_main
integer x = 832
integer y = 360
integer width = 3634
integer height = 1964
string title = "Emisión de Cartas de Resultados"
string menuname = "m_menu"
long backcolor = 67108864
event type long num_folios ( integer min_max )
ddlb_opcion ddlb_opcion
dw_2 dw_2
uo_1 uo_1
em_max em_max
em_min em_min
dw_1 dw_1
end type
global w_emision_carta_resultados w_emision_carta_resultados

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

on w_emision_carta_resultados.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.ddlb_opcion=create ddlb_opcion
this.dw_2=create dw_2
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_opcion
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.em_max
this.Control[iCurrent+5]=this.em_min
this.Control[iCurrent+6]=this.dw_1
end on

on w_emision_carta_resultados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_opcion)
destroy(this.dw_2)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)
end event

type ddlb_opcion from dropdownlistbox within w_emision_carta_resultados
integer x = 3081
integer y = 108
integer width = 398
integer height = 228
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"NORMAL","DIFERIDOS"}
end type

type dw_2 from datawindow within w_emision_carta_resultados
event constructor pbm_constructor
event losefocus pbm_dwnkillfocus
event actualiza ( )
event carga ( )
integer x = 3141
integer y = 4
integer width = 247
integer height = 100
integer taborder = 30
string dataobject = "dw_varios"
boolean livescroll = true
end type

event losefocus;event actualiza()
end event

event actualiza;if ModifiedCount() > 0 Then
	/*Checa que los renglones cumplan con las reglas de validación*/
	if update(true) = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		commit using gtr_sadm;
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using gtr_sadm;
	end if
end if
end event

event carga;event actualiza()
retrieve(2)
end event

type uo_1 from uo_ver_per_ani within w_emision_carta_resultados
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_emision_carta_resultados
integer x = 2642
integer y = 32
integer width = 338
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_emision_carta_resultados
integer x = 2295
integer y = 32
integer width = 338
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type dw_1 from uo_dw_reporte within w_emision_carta_resultados
integer x = 18
integer y = 200
integer width = 3520
integer height = 1580
integer taborder = 0
string dataobject = "dw_carta_resultados"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild est
getchild("general_estado",est)
est.settransobject(gtr_sce)
est.retrieve()

DataWindowChild lug
getchild("general_lugar_nac",lug)
lug.settransobject(gtr_sce)
lug.retrieve()

DataWindowChild edo
getchild("general_edo_civil",edo)
edo.settransobject(gtr_sce)
edo.retrieve()

DataWindowChild bac
getchild("general_bachillera",bac)
bac.settransobject(gtr_sce)
bac.retrieve()

end event

event carga;int opcion
string mensa_1,mensa_2,mensa_3,mensa_4

mensa_1= ProfileString ("resultados.txt", "mensajes", "mensa_1_1","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_1_2","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_1_3","")+'~n~r'
mensa_2= ProfileString ("resultados.txt", "mensajes", "mensa_2_1","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_2_2","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_2_3","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_4_1","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_4_2","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_4_3","")+'~n~r'
mensa_3= ProfileString ("resultados.txt", "mensajes", "mensa_3_1","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_3_2","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_3_3","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_4_1","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_4_2","")+'~n~r'+&
			ProfileString ("resultados.txt", "mensajes", "mensa_4_3","")+'~n~r'
mensa_4= ProfileString ("resultados.txt", "mensajes", "mensa_5_1","")+'~n~r'

IF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=1
	mensa_4=mensa_2
else
	opcion=0
END IF

dw_2.event carga()
event primero()
return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text),&
	mensa_1,mensa_2,mensa_3,mensa_4,dw_2.object.valor[1],opcion)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

