$PBExportHeader$w_carta_res.srw
$PBExportComments$Permite elegir que folios se imprimirán las cartas de resultados, los ordena alfabéticamente
forward
global type w_carta_res from Window
end type
type ddlb_opcion from dropdownlistbox within w_carta_res
end type
type dw_2 from datawindow within w_carta_res
end type
type uo_1 from uo_ver_per_ani within w_carta_res
end type
type em_max from editmask within w_carta_res
end type
type em_min from editmask within w_carta_res
end type
type dw_1 from uo_dw_reporte within w_carta_res
end type
end forward

global type w_carta_res from Window
int X=833
int Y=361
int Width=3635
int Height=1965
boolean TitleBar=true
string Title="Emisión de Cartas de Resultados"
string MenuName="m_menu"
long BackColor=30976088
event type long num_folios ( integer min_max )
ddlb_opcion ddlb_opcion
dw_2 dw_2
uo_1 uo_1
em_max em_max
em_min em_min
dw_1 dw_1
end type
global w_carta_res w_carta_res

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

on w_carta_res.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.ddlb_opcion=create ddlb_opcion
this.dw_2=create dw_2
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.dw_1=create dw_1
this.Control[]={ this.ddlb_opcion,&
this.dw_2,&
this.uo_1,&
this.em_max,&
this.em_min,&
this.dw_1}
end on

on w_carta_res.destroy
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

type ddlb_opcion from dropdownlistbox within w_carta_res
int X=3082
int Y=109
int Width=398
int Height=229
int TabOrder=20
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"NORMAL",&
"DIFERIDOS"}
end type

type dw_2 from datawindow within w_carta_res
event constructor pbm_constructor
event losefocus pbm_dwnkillfocus
event actualiza ( )
event carga ( )
int X=3141
int Y=5
int Width=247
int Height=101
int TabOrder=10
string DataObject="dw_varios"
boolean LiveScroll=true
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

type uo_1 from uo_ver_per_ani within w_carta_res
int X=1
int Y=1
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_carta_res
int X=2643
int Y=33
int Width=339
int Height=101
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_carta_res
int X=2295
int Y=33
int Width=339
int Height=101
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type dw_1 from uo_dw_reporte within w_carta_res
int X=19
int Y=201
int Width=3521
int Height=1581
int TabOrder=0
string DataObject="dw_carta_res"
boolean HScrollBar=true
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

