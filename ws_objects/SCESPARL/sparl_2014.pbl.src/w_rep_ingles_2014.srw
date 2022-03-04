$PBExportHeader$w_rep_ingles_2014.srw
forward
global type w_rep_ingles_2014 from w_ancestral
end type
type dw_1 from datawindow within w_rep_ingles_2014
end type
type st_status_1 from statictext within w_rep_ingles_2014
end type
type dw_prom_cred_sem from datawindow within w_rep_ingles_2014
end type
type st_status_2 from statictext within w_rep_ingles_2014
end type
type cb_1 from commandbutton within w_rep_ingles_2014
end type
type dw_cortes from uo_dw_reporte within w_rep_ingles_2014
end type
type p_ibero from picture within w_rep_ingles_2014
end type
type st_sistema from statictext within w_rep_ingles_2014
end type
end forward

global type w_rep_ingles_2014 from w_ancestral
integer width = 3877
integer height = 2672
string title = "Reporte de Cortes de Inglés"
string menuname = "m_menu"
long backcolor = 16777215
event agrega ( string linea )
dw_1 dw_1
st_status_1 st_status_1
dw_prom_cred_sem dw_prom_cred_sem
st_status_2 st_status_2
cb_1 cb_1
dw_cortes dw_cortes
p_ibero p_ibero
st_sistema st_sistema
end type
global w_rep_ingles_2014 w_rep_ingles_2014

type variables
long i_lo_renglon
end variables

event agrega(string linea);int in_a
long lo_cuenta,lo_semestre,lo_carrera
string st_nom,st_apa,st_ama

in_a=Pos (linea, "	")
lo_cuenta=long(Left (linea, in_a))

  SELECT alumnos.nombre, alumnos.apaterno, alumnos.amaterno  
    INTO :st_nom, :st_apa, :st_ama  
    FROM alumnos  
   WHERE alumnos.cuenta = :lo_cuenta
	USING gtr_sce;
	
	if isnull(st_nom) then
		st_nom=""
	end if
	
	if isnull(st_apa) then
		st_apa=""
	else
		st_apa=st_apa+' '
	end if

	if isnull(st_ama) then
		st_ama=""
	else
		st_ama=st_ama+' '
	end if
	
	SELECT v_sce_carreras_cursadas.cve_carrera  
    INTO :lo_carrera  
    FROM v_sce_carreras_cursadas  
   WHERE v_sce_carreras_cursadas.vigente = 1
	and v_sce_carreras_cursadas.cuenta = :lo_cuenta
	USING gtr_sce;

linea=mid(linea,in_a+1)
lo_semestre=long(linea)

i_lo_renglon=i_lo_renglon+1
dw_1.scrolltorow(i_lo_renglon)

dw_1.object.cuenta[i_lo_renglon]=lo_cuenta
dw_1.object.carrera[i_lo_renglon]=lo_carrera
dw_1.object.nombre[i_lo_renglon]=st_apa+st_ama+st_nom
dw_1.object.semestre[i_lo_renglon]=lo_semestre

/* Formato: 

27934	4
29847	5
46157	12
48011	2
50385	6
55519	2

*/
end event

on w_rep_ingles_2014.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.st_status_1=create st_status_1
this.dw_prom_cred_sem=create dw_prom_cred_sem
this.st_status_2=create st_status_2
this.cb_1=create cb_1
this.dw_cortes=create dw_cortes
this.p_ibero=create p_ibero
this.st_sistema=create st_sistema
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_status_1
this.Control[iCurrent+3]=this.dw_prom_cred_sem
this.Control[iCurrent+4]=this.st_status_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_cortes
this.Control[iCurrent+7]=this.p_ibero
this.Control[iCurrent+8]=this.st_sistema
end on

on w_rep_ingles_2014.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_status_1)
destroy(this.dw_prom_cred_sem)
destroy(this.st_status_2)
destroy(this.cb_1)
destroy(this.dw_cortes)
destroy(this.p_ibero)
destroy(this.st_sistema)
end on

type p_uia from w_ancestral`p_uia within w_rep_ingles_2014
boolean visible = false
end type

type dw_1 from datawindow within w_rep_ingles_2014
event constructor pbm_constructor
integer x = 384
integer y = 1436
integer width = 3355
integer height = 1024
integer taborder = 30
string dataobject = "d_rep_ingles"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;m_menu.dw = this

DataWindowChild carr
getchild("carrera",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

type st_status_1 from statictext within w_rep_ingles_2014
integer x = 384
integer y = 348
integer width = 3360
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_prom_cred_sem from datawindow within w_rep_ingles_2014
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
event constructor pbm_constructor
integer x = 384
integer y = 992
integer width = 3355
integer height = 432
integer taborder = 11
string dataobject = "d_prom_cred_sem_2014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;/*
DESCRIPCIÓN: Carga los datos
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
st_status_2.text='Terminada la Carga'

end event

event retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cada vez que se carga un renglón
				 (para mostrar que no te has trabado)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status_2.text='Cargando '+string(row)
end event

type st_status_2 from statictext within w_rep_ingles_2014
integer x = 384
integer y = 896
integer width = 3355
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rep_ingles_2014
event clicked pbm_bnclicked
integer x = 73
integer y = 1168
integer width = 229
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga"
end type

event clicked;long lo_bytes_read
string st_s
int in_lee_file

in_lee_file = FileOpen("ingles.txt",LineMode!, Read!, LockReadWrite!)
FileRead(in_lee_file, st_s)

for i_lo_renglon=1 to long(st_s)
	dw_1.insertrow(i_lo_renglon)
	dw_1.scrolltorow(i_lo_renglon)
next

i_lo_renglon=0

lo_bytes_read = FileRead(in_lee_file, st_s)
DO UNTIL lo_bytes_read=-100
	if lo_bytes_read>0 then
		event agrega(st_s)
	end if
	lo_bytes_read = FileRead(in_lee_file, st_s)
LOOP	
FileClose(in_lee_file)

dw_1.Sort()
dw_1.GroupCalc()
end event

type dw_cortes from uo_dw_reporte within w_rep_ingles_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 384
integer y = 444
integer width = 3355
integer height = 428
integer taborder = 10
string dataobject = "d_cortes_2014"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;/*
DESCRIPCIÓN: Evento en el que se localiza la variable dw en el menu y se asigna el valor de este objeto	.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/

end event

event retrieveend;call super::retrieveend;/*
DESCRIPCIÓN: Carga los datos de los que cursaron materias en el semestre (Academicos)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
st_status_1.text='Terminada la Carga'
dw_prom_cred_sem.retrieve('?')
end event

event retrieverow;call super::retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cad vez que se carga un renglón
				 (para mostrar que no te has trabado)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status_1.text='Cargando '+string(row)
end event

type p_ibero from picture within w_rep_ingles_2014
integer x = 59
integer y = 44
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_sistema from statictext within w_rep_ingles_2014
integer x = 805
integer y = 128
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

