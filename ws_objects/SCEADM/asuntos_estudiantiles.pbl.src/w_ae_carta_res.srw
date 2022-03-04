$PBExportHeader$w_ae_carta_res.srw
forward
global type w_ae_carta_res from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_ae_carta_res
end type
type uo_1 from uo_ver_per_ani within w_ae_carta_res
end type
type dw_1 from uo_dw_reporte within w_ae_carta_res
end type
end forward

global type w_ae_carta_res from Window
int X=834
int Y=362
int Width=3635
int Height=1965
boolean TitleBar=true
string Title="Emisión de Cartas de Invitación Asuntos Estudiantiles"
string MenuName="m_menu"
long BackColor=30976088
event type long num_folios ( integer min_max )
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_ae_carta_res w_ae_carta_res

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

on w_ae_carta_res.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_1,&
this.dw_1}
end on

on w_ae_carta_res.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_ae_carta_res
int X=1243
int Y=16
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_ae_carta_res
int X=0
int Y=0
int Width=1243
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_ae_carta_res
int X=18
int Y=202
int Width=3522
int Height=1581
int TabOrder=0
string DataObject="dw_ae_carta_res"
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

mensa_1= 	ProfileString ("invita_alumno.txt", "mensajes", "mensa_1_1","")+'~n~r'+&
				ProfileString ("invita_alumno.txt", "mensajes", "mensa_1_2","")+'~n~r'+&
				ProfileString ("invita_alumno.txt", "mensajes", "mensa_1_3","")+'~n~r'				
mensa_2= ProfileString ("invita_alumno.txt", "mensajes", "mensa_2_1","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_2_2","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_2_3","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_4_1","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_4_2","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_4_3","")+'~n~r'
mensa_3= ProfileString ("invita_alumno.txt", "mensajes", "mensa_3_1","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_3_2","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_3_3","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_4_1","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_4_2","")+'~n~r'+&
			ProfileString ("invita_alumno.txt", "mensajes", "mensa_4_3","")+'~n~r'
mensa_4= ProfileString ("invita_alumno.txt", "mensajes", "mensa_5_1","")+'~n~r'

IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_ae_carta_res"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_ae_carta_res_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
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

event primero()
return retrieve(gi_periodo,gi_anio,mensa_1,mensa_2,mensa_3,mensa_4)

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

