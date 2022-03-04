$PBExportHeader$w_acep-recha.srw
$PBExportComments$Ventana para visualizar al reporte de los aspirantes aceptados-rechazados-inscritos
forward
global type w_acep-recha from Window
end type
type dw_2 from datawindow within w_acep-recha
end type
type dw_1 from uo_dw_reporte within w_acep-recha
end type
type uo_1 from uo_ver_per_ani within w_acep-recha
end type
end forward

global type w_acep-recha from Window
int X=833
int Y=361
int Width=3242
int Height=1957
boolean TitleBar=true
string Title="Estadística Aceptados-Rechazados"
string MenuName="m_menu"
long BackColor=30976088
dw_2 dw_2
dw_1 dw_1
uo_1 uo_1
end type
global w_acep-recha w_acep-recha

on w_acep-recha.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_2=create dw_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.dw_2,&
this.dw_1,&
this.uo_1}
end on

on w_acep-recha.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type dw_2 from datawindow within w_acep-recha
int X=3306
int Y=361
int Width=567
int Height=361
string DataObject="dw_fol_camb_carr"
boolean LiveScroll=true
end type

event constructor;settransobject(gtr_sadm)
end event

type dw_1 from uo_dw_reporte within w_acep-recha
int X=14
int Y=193
int Width=3187
int Height=1569
int TabOrder=0
string DataObject="dw_acep-recha"
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event carga;object.st_1.text='Estadística Aceptados-Rechazados:  '+tit1
event primero()
return retrieve()
end event

event retrieveend;call super::retrieveend;dw_2.retrieve(gi_version,gi_periodo,gi_anio)
int carr_act,carr_ant,fol,cont_1,cont_2,status
int sum1=0,sum2=0,sum3=0,sum4=0

for cont_1=1 to dw_2.rowcount()
	fol=dw_2.object.folio[cont_1]
	status=dw_2.object.aspiran_status[cont_1]

	SELECT bita_carr.carr_act
	INTO :carr_act
	FROM bita_carr
	WHERE ( bita_carr.folio = :fol ) AND
		( bita_carr.clv_ver = :gi_version ) AND
		( bita_carr.clv_per = :gi_periodo ) AND
		( bita_carr.anio = :gi_anio )
	ORDER BY bita_carr.fecha DESC
	USING gtr_sce;
	
	SELECT bita_carr.carr_ant
	INTO :carr_ant
	FROM bita_carr
	WHERE ( bita_carr.folio = :fol ) AND
		( bita_carr.clv_ver = :gi_version ) AND
		( bita_carr.clv_per = :gi_periodo ) AND
		( bita_carr.anio = :gi_anio )
	ORDER BY bita_carr.fecha DESC
	USING gtr_sce;
	
	//messagebox(string(fol)+' '+string(status),string(carr_ant)+' '+string(carr_act))
		
		for cont_2=1 to rowcount
				
			if object.clv_carr[cont_2]=carr_act then
				object.r_1[cont_2].object.compute_0001[1]=object.r_1[cont_2].object.compute_0001[1]+1
				if status=1 then
					object.r_2[cont_2].object.compute_0001[1]=object.r_2[cont_2].object.compute_0001[1]+1
				else
					object.r_3[cont_2].object.compute_0001[1]=object.r_3[cont_2].object.compute_0001[1]+1
				end if
			else
				if object.clv_carr[cont_2]=carr_ant then
					object.r_1[cont_2].object.compute_0001[1]=object.r_1[cont_2].object.compute_0001[1] -1
					if status=1 then
						object.r_2[cont_2].object.compute_0001[1]=object.r_2[cont_2].object.compute_0001[1] -1
					else
						object.r_3[cont_2].object.compute_0001[1]=object.r_3[cont_2].object.compute_0001[1] -1
					end if
				end if
			end if
		next

next

FOR cont_1=1 TO rowcount
	sum1=sum1+object.r_1[cont_1].object.compute_0001[1]
	sum2=sum2+object.r_2[cont_1].object.compute_0001[1]
	sum3=sum3+object.r_3[cont_1].object.compute_0001[1]
	sum4=sum4+object.r_4[cont_1].object.compute_0001[1]
NEXT

object.st_r_1.text=string(sum1)
object.st_r_2.text=string(sum2)
object.st_r_3.text=string(sum3)
object.st_r_4.text=string(sum4)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_acep-recha
int X=69
int Y=17
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

