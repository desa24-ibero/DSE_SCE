$PBExportHeader$w_rep_prom_2014.srw
forward
global type w_rep_prom_2014 from w_ancestral
end type
type cb_1 from commandbutton within w_rep_prom_2014
end type
type st_status_1 from statictext within w_rep_prom_2014
end type
type st_status_2 from statictext within w_rep_prom_2014
end type
type dw_prom_cred_sem from datawindow within w_rep_prom_2014
end type
type dw_1 from datawindow within w_rep_prom_2014
end type
type dw_cortes from uo_dw_reporte within w_rep_prom_2014
end type
type em_usuario from editmask within w_rep_prom_2014
end type
type em_fecha_1 from editmask within w_rep_prom_2014
end type
type em_fecha_2 from editmask within w_rep_prom_2014
end type
type dw_rep_prom_1 from datawindow within w_rep_prom_2014
end type
type dw_rep_banderas from datawindow within w_rep_prom_2014
end type
type uo_1 from uo_per_ani within w_rep_prom_2014
end type
type st_1 from statictext within w_rep_prom_2014
end type
type st_2 from statictext within w_rep_prom_2014
end type
type st_3 from statictext within w_rep_prom_2014
end type
type p_ibero from picture within w_rep_prom_2014
end type
type st_sistema from statictext within w_rep_prom_2014
end type
end forward

global type w_rep_prom_2014 from w_ancestral
integer width = 5189
integer height = 3348
string title = "Reporte de Cortes de Puntaje"
string menuname = "m_menu"
long backcolor = 16777215
cb_1 cb_1
st_status_1 st_status_1
st_status_2 st_status_2
dw_prom_cred_sem dw_prom_cred_sem
dw_1 dw_1
dw_cortes dw_cortes
em_usuario em_usuario
em_fecha_1 em_fecha_1
em_fecha_2 em_fecha_2
dw_rep_prom_1 dw_rep_prom_1
dw_rep_banderas dw_rep_banderas
uo_1 uo_1
st_1 st_1
st_2 st_2
st_3 st_3
p_ibero p_ibero
st_sistema st_sistema
end type
global w_rep_prom_2014 w_rep_prom_2014

type variables

end variables

on w_rep_prom_2014.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.st_status_1=create st_status_1
this.st_status_2=create st_status_2
this.dw_prom_cred_sem=create dw_prom_cred_sem
this.dw_1=create dw_1
this.dw_cortes=create dw_cortes
this.em_usuario=create em_usuario
this.em_fecha_1=create em_fecha_1
this.em_fecha_2=create em_fecha_2
this.dw_rep_prom_1=create dw_rep_prom_1
this.dw_rep_banderas=create dw_rep_banderas
this.uo_1=create uo_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.p_ibero=create p_ibero
this.st_sistema=create st_sistema
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_status_1
this.Control[iCurrent+3]=this.st_status_2
this.Control[iCurrent+4]=this.dw_prom_cred_sem
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_cortes
this.Control[iCurrent+7]=this.em_usuario
this.Control[iCurrent+8]=this.em_fecha_1
this.Control[iCurrent+9]=this.em_fecha_2
this.Control[iCurrent+10]=this.dw_rep_prom_1
this.Control[iCurrent+11]=this.dw_rep_banderas
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.p_ibero
this.Control[iCurrent+17]=this.st_sistema
end on

on w_rep_prom_2014.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_status_1)
destroy(this.st_status_2)
destroy(this.dw_prom_cred_sem)
destroy(this.dw_1)
destroy(this.dw_cortes)
destroy(this.em_usuario)
destroy(this.em_fecha_1)
destroy(this.em_fecha_2)
destroy(this.dw_rep_prom_1)
destroy(this.dw_rep_banderas)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.p_ibero)
destroy(this.st_sistema)
end on

event open;call super::open;dw_cortes.settransobject(gtr_sce)
dw_prom_cred_sem.settransobject(gtr_sce)
dw_rep_prom_1.settransobject(gtr_sce)
dw_rep_banderas.settransobject(gtr_sce)

periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_rep_prom_2014
boolean visible = false
end type

type cb_1 from commandbutton within w_rep_prom_2014
event clicked pbm_bnclicked
integer x = 370
integer y = 1064
integer width = 704
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carga"
end type

event clicked;dw_cortes.retrieve('?')
end event

type st_status_1 from statictext within w_rep_prom_2014
integer x = 1490
integer y = 12
integer width = 2350
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_status_2 from statictext within w_rep_prom_2014
integer x = 1490
integer y = 556
integer width = 2350
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

type dw_prom_cred_sem from datawindow within w_rep_prom_2014
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
event constructor pbm_constructor
integer x = 1490
integer y = 648
integer width = 2350
integer height = 432
string dataobject = "d_prom_cred_sem_2014"
boolean hscrollbar = true
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
dw_rep_prom_1.retrieve(em_usuario.text,date(em_fecha_1.text),date(em_fecha_2.text))
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

type dw_1 from datawindow within w_rep_prom_2014
event constructor pbm_constructor
integer x = 37
integer y = 1216
integer width = 3803
integer height = 1412
string dataobject = "d_rep_prom"
boolean hscrollbar = true
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

type dw_cortes from uo_dw_reporte within w_rep_prom_2014
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 1490
integer y = 108
integer width = 2350
integer height = 440
integer taborder = 0
string dataobject = "d_cortes_2014"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

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

event constructor;/*
DESCRIPCIÓN: Evento en el que se localiza la variable dw en el menu y se asigna el valor de este objeto	.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/

end event

type em_usuario from editmask within w_rep_prom_2014
integer x = 37
integer y = 676
integer width = 425
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "usuario"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxx"
string displaydata = ""
end type

type em_fecha_1 from editmask within w_rep_prom_2014
integer x = 37
integer y = 792
integer width = 425
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_2 from editmask within w_rep_prom_2014
integer x = 37
integer y = 908
integer width = 425
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type dw_rep_prom_1 from datawindow within w_rep_prom_2014
integer x = 3867
integer y = 648
integer width = 923
integer height = 440
boolean bringtotop = true
string dataobject = "d_rep_prom_1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

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

event retrieveend;/*
DESCRIPCIÓN: Carga los datos
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
st_status_2.text='Terminada la Carga'
dw_rep_banderas.retrieve(3,em_usuario.text,date(em_fecha_1.text),date(em_fecha_2.text))
end event

type dw_rep_banderas from datawindow within w_rep_prom_2014
integer x = 3867
integer y = 108
integer width = 923
integer height = 440
boolean bringtotop = true
string dataobject = "d_rep_banderas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieverow;/*
DESCRIPCIÓN: Despliega un mensaje cada vez que se carga un renglón
				 (para mostrar que no te has trabado)
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

st_status_1.text='Cargando '+string(row)
end event

event retrieveend;/*
DESCRIPCIÓN: Carga los datos
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long lo_cuenta,lo_carrera,lo_flag_ant,lo_flag_nvo,renglon,ll_found
real re_prom_ant,re_prom_nvo
string st_nom,st_apa,st_ama

st_status_1.text='Terminada la Carga'

dw_cortes.setfilter("banderas_cve_flag_promedio=2")
dw_cortes.filter()

for renglon=1 to dw_cortes.rowcount()
	dw_1.insertrow(renglon)
	dw_1.scrolltorow(renglon)
	st_status_1.text='Agregando el renglón '+string(renglon)
next

CHOOSE CASE gi_periodo
	CASE 0
		dw_1.object.titulo.text='PRIMAVERA '+string(gi_anio)
	CASE 1
		dw_1.object.titulo.text='VERANO '+string(gi_anio)
	CASE 2
		dw_1.object.titulo.text='OTOÑO '+string(gi_anio)
END CHOOSE

st_status_1.text='Preparando Reporte'

FOR renglon=1 TO dw_cortes.rowcount()

	lo_cuenta=dw_cortes.object.banderas_cuenta[renglon]
	st_status_2.text='Leyendo la cuenta '+string(lo_cuenta)
	
	  SELECT alumnos.nombre, alumnos.apaterno, alumnos.amaterno  
		 INTO :st_nom,:st_apa,:st_ama  
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
	
	ll_found = dw_prom_cred_sem.Find("academicos_cuenta ="+string(lo_cuenta),1,dw_prom_cred_sem.RowCount( ))
	if ll_found>0 then
		lo_carrera=dw_prom_cred_sem.object.academicos_cve_carrera[ll_found]
		re_prom_nvo=dw_prom_cred_sem.object.academicos_promedio[ll_found]
		re_prom_ant=re_prom_nvo
		dw_prom_cred_sem.deleterow(ll_found)
	end if

	ll_found = dw_rep_prom_1.Find("cuenta ="+string(lo_cuenta),1,dw_rep_prom_1.RowCount( ))
	if ll_found>0 then
		re_prom_ant=dw_rep_prom_1.object.compute_0002[ll_found]
		dw_rep_prom_1.deleterow(ll_found)
	end if
		
	
	lo_flag_nvo=dw_cortes.object.banderas_cve_flag_promedio[renglon]
	lo_flag_ant=lo_flag_nvo
	
	ll_found = dw_rep_banderas.Find("cuenta ="+string(lo_cuenta),1,dw_rep_banderas.RowCount( ))
	if ll_found>0 then
		lo_flag_ant=dw_rep_banderas.object.anterior[ll_found]
		dw_rep_banderas.deleterow(ll_found)
	end if
	
	dw_1.scrolltorow(renglon)
		
	dw_1.object.cuenta[renglon]=lo_cuenta
	dw_1.object.carrera[renglon]=lo_carrera
	dw_1.object.nombre[renglon]=st_apa+st_ama+st_nom
	dw_1.object.prom_ant[renglon]=re_prom_ant
	dw_1.object.prom_nvo[renglon]=re_prom_nvo
	dw_1.object.flag_ant[renglon]=lo_flag_ant
	dw_1.object.flag_nvo[renglon]=lo_flag_nvo
	
NEXT



dw_1.Sort()
dw_1.GroupCalc()
end event

type uo_1 from uo_per_ani within w_rep_prom_2014
integer x = 101
integer y = 448
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_1 from statictext within w_rep_prom_2014
integer x = 503
integer y = 792
integer width = 891
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Fecha inicio cortes: dd/mm/aaaa"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_prom_2014
integer x = 503
integer y = 908
integer width = 891
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Fecha fin cortes: dd/mm/aaaa"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rep_prom_2014
integer x = 503
integer y = 676
integer width = 891
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Usuario que realizó cortes"
boolean focusrectangle = false
end type

type p_ibero from picture within w_rep_prom_2014
integer x = 41
integer y = 36
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_sistema from statictext within w_rep_prom_2014
integer x = 786
integer y = 120
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

