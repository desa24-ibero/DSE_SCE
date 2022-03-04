$PBExportHeader$w_crea_paq.srw
$PBExportComments$Ventana con la que se generan los paquetes de materias para primer ingreso
forward
global type w_crea_paq from Window
end type
type uo_1 from uo_per_ani within w_crea_paq
end type
type dw_4 from datawindow within w_crea_paq
end type
type dw_3 from datawindow within w_crea_paq
end type
type dw_2 from datawindow within w_crea_paq
end type
type dw_1 from datawindow within w_crea_paq
end type
end forward

global type w_crea_paq from Window
int X=4
int Y=6
int Width=3617
int Height=1990
boolean TitleBar=true
string Title="Creación de Horarios"
string MenuName="m_menu"
long BackColor=10789024
uo_1 uo_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_crea_paq w_crea_paq

type variables
string salones[]
int num_salones
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_crea_paq.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.uo_1,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1}
end on

on w_crea_paq.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;x = 1
y = 1
end event

type uo_1 from uo_per_ani within w_crea_paq
int X=0
int Y=0
int TabOrder=1
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_4 from datawindow within w_crea_paq
event carga ( integer carr,  integer plan )
int X=1997
int Y=1853
int Width=1510
int Height=541
string DataObject="dw_prerreq"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event carga;retrieve(carr,plan)

end event

event retrieveend;long cont1,cont2

FOR cont1=1 TO rowcount
	FOR cont2=1 TO dw_3.rowcount()
		IF dw_3.object.area_mat_cve_mat[cont2] = object.cve_mat[cont1] THEN
			dw_3.deleterow(cont2)
			cont2=dw_3.rowcount()+1
		END IF
	NEXT
NEXT

end event

event constructor;dw_4.settransobject(gtr_sce)
end event

type dw_3 from datawindow within w_crea_paq
event carga ( integer carr,  integer plan )
int X=2176
int Y=6
int Width=1419
int Height=1018
string DataObject="dw_mat_1_sem"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event carga;retrieve(carr,plan)

end event

event doubleclicked;if row>0 then
	dw_2.event carga(object.area_mat_cve_mat[row])
end if
end event

event constructor;dw_3.settransobject(gtr_sce)
end event

type dw_2 from datawindow within w_crea_paq
event actualiza ( )
event carga ( long clv_mat )
int Y=170
int Width=2161
int Height=861
string DataObject="dw_matxpaq"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event actualiza;dw_1.event actualiza()
AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
	if update(true) = 1 then		
		commit using gtr_sce;
	else
		rollback using gtr_sce;
		messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	end if
end if
end event

event carga;dw_2.event actualiza()
retrieve(clv_mat,gi_periodo,gi_anio)
end event

event constructor;dw_2.settransobject(gtr_sce)
end event

type dw_1 from datawindow within w_crea_paq
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event carga ( )
int Y=1037
int Width=3599
int Height=781
string DataObject="dw_paquetes"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event primero;/*Ve al primer renglón*/
setcolumn(1)
setfocus()
scrolltorow(1)
end event

event anterior;/*Ve al renglón anterior*/
setcolumn(1)
setfocus()
if getrow()>1 then
	scrolltorow(getrow()-1)
end if

end event

event siguiente;/*Ve al siguiente renglón*/
setcolumn(1)
setfocus()
if getrow()<rowcount() then
	scrolltorow(getrow()+1)
end if
end event

event ultimo;/*Ve al último renglón*/
setcolumn(1)
setfocus()
scrolltorow(rowcount())
end event

event actualiza;AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
	if update(true) = 1 then		
		commit using gtr_sadm;
	else
		rollback using gtr_sadm;
		messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	end if
end if
end event

event nuevo;insertrow(0)
scrolltorow(rowcount())
setfocus()
object.cupo[getrow()]=0
object.inscritos[getrow()]=0
end event

event borra;long cont
/*Borra el renglón actual*/

cont=object.num_paq[getrow()]

UPDATE dbo.grupos
SET primer_sem = 0
WHERE ( dbo.grupos.periodo = :gi_periodo ) AND
		( dbo.grupos.anio = :gi_anio ) AND  
		( dbo.grupos.primer_sem = :cont )
USING gtr_sce;
commit using gtr_sce;

for cont=dw_3.rowcount() to 1 step -1
	dw_3.deleterow(cont)
next
setfocus()
deleterow(getrow())
event actualiza()
end event

event carga;retrieve()

end event

event constructor;dw_1.settransobject(gtr_sadm)

DataWindowChild carr,plan

getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

getchild("clv_plan",plan)
plan.settransobject(gtr_sce)
plan.retrieve()

dw_1.event carga()

m_menu.dw = this
end event

event itemchanged;int cont,columna

columna = getcolumn()

if (columna=2 or columna=3) then
	dw_3.event carga(object.clv_carr[row],object.clv_plan[row])
	dw_4.event carga(object.clv_carr[row],object.clv_plan[row])
end if
end event

event rowfocuschanged;if (currentrow>0 and rowcount()>0) then
	dw_3.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow])
	dw_4.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow])
end if
end event

event getfocus;setcolumn(1)
end event

