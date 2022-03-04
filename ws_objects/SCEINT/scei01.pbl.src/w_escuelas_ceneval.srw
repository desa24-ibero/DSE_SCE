$PBExportHeader$w_escuelas_ceneval.srw
$PBExportComments$Ligar escuelas con catalogo ceneval
forward
global type w_escuelas_ceneval from w_ancestral
end type
type dw_ceneval from uo_dw_captura within w_escuelas_ceneval
end type
type dw_escuelas from uo_dw_captura within w_escuelas_ceneval
end type
type cb_1 from commandbutton within w_escuelas_ceneval
end type
end forward

global type w_escuelas_ceneval from w_ancestral
integer width = 3598
integer height = 2096
string title = "Ligar Catalogo Escuelas Ceneval"
string menuname = "m_menu"
dw_ceneval dw_ceneval
dw_escuelas dw_escuelas
cb_1 cb_1
end type
global w_escuelas_ceneval w_escuelas_ceneval

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

on w_escuelas_ceneval.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_ceneval=create dw_ceneval
this.dw_escuelas=create dw_escuelas
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ceneval
this.Control[iCurrent+2]=this.dw_escuelas
this.Control[iCurrent+3]=this.cb_1
end on

on w_escuelas_ceneval.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_ceneval)
destroy(this.dw_escuelas)
destroy(this.cb_1)
end on

type p_uia from w_ancestral`p_uia within w_escuelas_ceneval
integer x = 5
end type

type dw_ceneval from uo_dw_captura within w_escuelas_ceneval
event constructor pbm_constructor
event type integer actualiza ( )
integer x = 0
integer y = 1044
integer width = 3525
integer height = 828
integer taborder = 0
string dataobject = "dw_ceneval"
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
//	dw_escuelas.object.cve_mun_loc[renglon]=object.ceneval_cve_mun_loc[row]
	dw_escuelas.object.cve_sep[renglon]=object.ccodigo[row]
	dw_escuelas.object.cceneval[renglon]=object.ccodigo[row]
	if dw_escuelas.event actualiza_np()=1 then
		dw_ceneval.reset()
		dw_escuelas.retrieve()
	end if
end if
end event

type dw_escuelas from uo_dw_captura within w_escuelas_ceneval
event type integer carga ( )
integer x = 0
integer y = 8
integer width = 3525
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_escuelas"
boolean hscrollbar = true
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
			dw_ceneval.retrieve('%'+nombre+'%')
			return
		END IF
	LOOP
	Net = MessageBox("¿Hago la búsqueda con...",escuela+'?',Question!, YesNo!, 1)
	IF Net = 1 THEN 
		dw_ceneval.retrieve('%'+escuela+'%')
		return
	END IF

	nombre=escuela
	dw_ceneval.retrieve('%'+nombre+'%')
end if
end event

event doubleclicked;call super::doubleclicked;string nombre,escuela
long a,net, li_lon_escuela

if row<>0 then
	
	escuela=object.escuela[row]
	
	a=pos(escuela,' ')
	DO UNTIL a=0 
		nombre=left(escuela,a -1)
		escuela=mid(escuela,a +1)
		a=pos(escuela,' ')
		Net = MessageBox("¿Hago la búsqueda con...",nombre+'?',Question!, YesNo!, 1)
		IF Net = 1 THEN 
			dw_ceneval.retrieve('%'+nombre+'%')
			return
		END IF
	LOOP
	Net = MessageBox("¿Hago la búsqueda con...",escuela+'?',Question!, YesNo!, 1)
	IF Net = 1 THEN 
		dw_ceneval.retrieve('%'+escuela+'%')
		return
	END IF
	nombre=escuela
	dw_ceneval.retrieve('%'+nombre+'%')
end if
end event

type cb_1 from commandbutton within w_escuelas_ceneval
integer x = 1655
integer y = 940
integer width = 247
integer height = 72
integer taborder = 1
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga"
end type

event clicked;dw_ceneval.reset()
dw_escuelas.retrieve()
end event

