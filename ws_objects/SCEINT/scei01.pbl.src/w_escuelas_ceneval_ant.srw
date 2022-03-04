$PBExportHeader$w_escuelas_ceneval_ant.srw
$PBExportComments$Ligar escuelas con catalogo ceneval
forward
global type w_escuelas_ceneval_ant from w_ancestral
end type
type dw_ceneval from uo_dw_captura within w_escuelas_ceneval_ant
end type
type dw_escuelas from uo_dw_captura within w_escuelas_ceneval_ant
end type
type cb_1 from commandbutton within w_escuelas_ceneval_ant
end type
end forward

global type w_escuelas_ceneval_ant from w_ancestral
int Width=3598
int Height=2161
boolean TitleBar=true
string Title="Registro de Preinscritos"
string MenuName="m_menu"
dw_ceneval dw_ceneval
dw_escuelas dw_escuelas
cb_1 cb_1
end type
global w_escuelas_ceneval_ant w_escuelas_ceneval_ant

event open;call super::open;/*
DESCRIPCIÓN: Liga los dw a sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 19 Junio 1998
MODIFICACIÓN:
*/
dw_ceneval.settransobject(gtr_sce)
dw_escuelas.settransobject(gtr_sce)
end event

on w_escuelas_ceneval_ant.create
int iCurrent
call w_ancestral::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_ceneval=create dw_ceneval
this.dw_escuelas=create dw_escuelas
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_ceneval
this.Control[iCurrent+2]=dw_escuelas
this.Control[iCurrent+3]=cb_1
end on

on w_escuelas_ceneval_ant.destroy
call w_ancestral::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_ceneval)
destroy(this.dw_escuelas)
destroy(this.cb_1)
end on

type p_uia from w_ancestral`p_uia within w_escuelas_ceneval_ant
int X=5
end type

type dw_ceneval from uo_dw_captura within w_escuelas_ceneval_ant
event constructor pbm_constructor
event type integer actualiza ( )
int X=1
int Y=1089
int Width=3548
int Height=865
int TabOrder=0
string DataObject="dw_ceneval_ant"
end type

event constructor;/*
DESCRIPCIÓN: Evita el código: triggerevent("asigna_dw_menu")
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

triggerevent("inicia_transaction_object")
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event doubleclicked;call super::doubleclicked;long renglon
if row<>0 then
	renglon=dw_escuelas.getrow()
	dw_escuelas.object.cve_mun_loc[renglon]=object.ceneval_cve_mun_loc[row]
	dw_escuelas.object.cve_sep[renglon]=object.ceneval_cve_sep[row]
	dw_escuelas.object.cene_1[renglon]=object.ceneval_cene_1[row]
	dw_escuelas.object.cene_2[renglon]=object.ceneval_cene_2[row]
	dw_escuelas.object.cene_3[renglon]=object.ceneval_cene_3[row]
	if dw_escuelas.event actualiza_np()=1 then
		dw_ceneval.reset()
		dw_escuelas.retrieve()
	end if
end if
end event

type dw_escuelas from uo_dw_captura within w_escuelas_ceneval_ant
event type integer carga ( )
int X=1
int Y=9
int Width=3557
int Height=1001
int TabOrder=0
boolean BringToTop=true
string DataObject="dw_escuelas_ant"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event itemfocuschanged;call super::itemfocuschanged;//string nombre[],escuela
//long a,cont
//if row<>0 then
//	
//	escuela=object.escuela[row]
//
//a=pos(escuela,' ')
//cont=1
//DO UNTIL a=0
//	nombre[cont]='%'+left(escuela,a -1)+'%'
//	escuela=mid(escuela,a +1)
//	a=pos(escuela,' ')
//	messagebox(nombre[cont],"")
//	cont++
//LOOP
//	nombre[cont]='%'+escuela+'%'
//	messagebox(nombre[cont],"")
//	
//	dw_ceneval.retrieve(nombre)
//end if

string nombre,escuela
long a,net

if row<>0 then
	
	escuela=object.escuela[row]
	
	a=pos(escuela,' ')
	DO UNTIL a=0
		nombre=left(escuela,a -1)
		escuela=mid(escuela,a +1)
		a=pos(escuela,' ')
		Net = MessageBox("¿Hago la búsqueda con...",nombre+'?',Question!, YesNo!, 1)
		IF Net = 1 THEN 
			dw_ceneval.retrieve('%'+nombre+'%',object.cene_1[row],object.cene_2[row],object.cene_3[row])
			return
		END IF
	LOOP
		nombre=escuela
		dw_ceneval.retrieve('%'+nombre+'%',object.cene_1[row],object.cene_2[row],object.cene_3[row])
end if
end event

event doubleclicked;call super::doubleclicked;string nombre,escuela
long a,net

if row<>0 then
	
	escuela=object.escuela[row]
	
	a=pos(escuela,' ')
	DO UNTIL a=0
		nombre=left(escuela,a -1)
		escuela=mid(escuela,a +1)
		a=pos(escuela,' ')
		Net = MessageBox("¿Hago la búsqueda con...",nombre+'?',Question!, YesNo!, 1)
		IF Net = 1 THEN 
			dw_ceneval.retrieve('%'+nombre+'%',object.cene_1[row],object.cene_2[row],object.cene_3[row])
			return
		END IF
	LOOP
		nombre=escuela
		dw_ceneval.retrieve('%'+nombre+'%',object.cene_1[row],object.cene_2[row],object.cene_3[row])
end if
end event

type cb_1 from commandbutton within w_escuelas_ceneval_ant
int X=1180
int Y=1013
int Width=247
int Height=73
int TabOrder=1
boolean BringToTop=true
string Text="Carga"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_ceneval.reset()
dw_escuelas.retrieve()
end event

