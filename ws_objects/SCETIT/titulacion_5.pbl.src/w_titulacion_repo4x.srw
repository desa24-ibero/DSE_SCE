$PBExportHeader$w_titulacion_repo4x.srw
$PBExportComments$Esta ventana ofrece el reporte de Alumnos con reconocimiento para titulacion
forward
global type w_titulacion_repo4x from w_master_main_rep
end type
type tab_1 from tab within w_titulacion_repo4x
end type
type tabpage_general from userobject within tab_1
end type
type uo_nivel from uo_nivel_2013 within tabpage_general
end type
type rb_1 from radiobutton within tabpage_general
end type
type rb_2 from radiobutton within tabpage_general
end type
type rb_3 from radiobutton within tabpage_general
end type
type vsb_dw_certificado from vscrollbar within tabpage_general
end type
type cb_1 from commandbutton within tabpage_general
end type
type em_2 from editmask within tabpage_general
end type
type em_1 from editmask within tabpage_general
end type
type cb_3 from commandbutton within tabpage_general
end type
type cbx_1 from checkbox within tabpage_general
end type
type cbx_2 from checkbox within tabpage_general
end type
type st_1 from statictext within tabpage_general
end type
type dw_3 from datawindow within tabpage_general
end type
type gb_3 from groupbox within tabpage_general
end type
type gb_1 from groupbox within tabpage_general
end type
type gb_4 from groupbox within tabpage_general
end type
type gb_6 from groupbox within tabpage_general
end type
type gb_8 from groupbox within tabpage_general
end type
type vsb_dw_certificado2 from vscrollbar within tabpage_general
end type
type dw_2 from datawindow within tabpage_general
end type
type gb_2 from groupbox within tabpage_general
end type
type gb_7 from groupbox within tabpage_general
end type
type gb_5 from groupbox within tabpage_general
end type
type dw_1 from datawindow within tabpage_general
end type
type tabpage_general from userobject within tab_1
uo_nivel uo_nivel
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
vsb_dw_certificado vsb_dw_certificado
cb_1 cb_1
em_2 em_2
em_1 em_1
cb_3 cb_3
cbx_1 cbx_1
cbx_2 cbx_2
st_1 st_1
dw_3 dw_3
gb_3 gb_3
gb_1 gb_1
gb_4 gb_4
gb_6 gb_6
gb_8 gb_8
vsb_dw_certificado2 vsb_dw_certificado2
dw_2 dw_2
gb_2 gb_2
gb_7 gb_7
gb_5 gb_5
dw_1 dw_1
end type
type tabpage_individual from userobject within tab_1
end type
type uo_nivel_2 from uo_nivel_2013 within tabpage_individual
end type
type dw_2x from datawindow within tabpage_individual
end type
type cb_5x from commandbutton within tabpage_individual
end type
type rb_3x from radiobutton within tabpage_individual
end type
type rb_2x from radiobutton within tabpage_individual
end type
type rb_1x from radiobutton within tabpage_individual
end type
type cbx_2x from checkbox within tabpage_individual
end type
type st_1x from statictext within tabpage_individual
end type
type lb_1 from listbox within tabpage_individual
end type
type em_1x from editmask within tabpage_individual
end type
type cb_3x from commandbutton within tabpage_individual
end type
type gb_8x from groupbox within tabpage_individual
end type
type gb_7x from groupbox within tabpage_individual
end type
type gb_2x from groupbox within tabpage_individual
end type
type cb_4x from commandbutton within tabpage_individual
end type
type cb_1x from commandbutton within tabpage_individual
end type
type gb_3x from groupbox within tabpage_individual
end type
type gb_4x from groupbox within tabpage_individual
end type
type cb_2x from commandbutton within tabpage_individual
end type
type gb_5x from groupbox within tabpage_individual
end type
type gb_6x from groupbox within tabpage_individual
end type
type vsb_dw_certificadox from vscrollbar within tabpage_individual
end type
type gb_1x from groupbox within tabpage_individual
end type
type lb_2 from listbox within tabpage_individual
end type
type dw_1x from datawindow within tabpage_individual
end type
type tabpage_individual from userobject within tab_1
uo_nivel_2 uo_nivel_2
dw_2x dw_2x
cb_5x cb_5x
rb_3x rb_3x
rb_2x rb_2x
rb_1x rb_1x
cbx_2x cbx_2x
st_1x st_1x
lb_1 lb_1
em_1x em_1x
cb_3x cb_3x
gb_8x gb_8x
gb_7x gb_7x
gb_2x gb_2x
cb_4x cb_4x
cb_1x cb_1x
gb_3x gb_3x
gb_4x gb_4x
cb_2x cb_2x
gb_5x gb_5x
gb_6x gb_6x
vsb_dw_certificadox vsb_dw_certificadox
gb_1x gb_1x
lb_2 lb_2
dw_1x dw_1x
end type
type tab_1 from tab within w_titulacion_repo4x
tabpage_general tabpage_general
tabpage_individual tabpage_individual
end type
end forward

global type w_titulacion_repo4x from w_master_main_rep
integer x = 832
integer y = 364
integer width = 3835
integer height = 2548
string title = "Reporte de Alumnos Titulados con Reconocimiento"
string menuname = "m_titulacion2"
boolean resizable = true
tab_1 tab_1
end type
global w_titulacion_repo4x w_titulacion_repo4x

type variables
int carrerax
end variables

on w_titulacion_repo4x.create
int iCurrent
call super::create
if this.MenuName = "m_titulacion2" then this.MenuID = create m_titulacion2
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_titulacion_repo4x.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
tab_1.tabpage_general.dw_1.settransobject(gtr_sce)
tab_1.tabpage_general.dw_2.settransobject(gtr_sce)
tab_1.tabpage_general.dw_3.settransobject(gtr_sce)

tab_1.tabpage_individual.dw_1x.settransobject(gtr_sce)
tab_1.tabpage_individual.dw_2x.settransobject(gtr_sce)

/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1

/*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_titulacion2.m_registro.m_nuevo.disable( )
m_titulacion2.m_registro.m_actualiza.disable( )
m_titulacion2.m_registro.m_borraregistro.disable( )


tab_1.tabpage_general.uo_nivel.of_carga_control(gtr_sce) 
tab_1.tabpage_individual.uo_nivel_2.of_carga_control(gtr_sce)

end event

type st_sistema from w_master_main_rep`st_sistema within w_titulacion_repo4x
end type

type p_ibero from w_master_main_rep`p_ibero within w_titulacion_repo4x
end type

type tab_1 from tab within w_titulacion_repo4x
integer x = 5
integer y = 312
integer width = 3671
integer height = 1772
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 0
boolean fixedwidth = true
boolean raggedright = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_individual tabpage_individual
end type

on tab_1.create
this.tabpage_general=create tabpage_general
this.tabpage_individual=create tabpage_individual
this.Control[]={this.tabpage_general,&
this.tabpage_individual}
end on

on tab_1.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_individual)
end on

event selectionchanged;/* Se asignan los datawindows dependiendo del TAB al menu, para poder imprimirlos */
if newindex = 1 then
	 m_titulacion2.dw = tab_1.tabpage_general.dw_1
    m_titulacion2.dw2 = tab_1.tabpage_general.dw_3
	 tab_1.tabpage_general.gb_1.taborder =0
	 tab_1.tabpage_general.gb_2.taborder =0
	 tab_1.tabpage_general.gb_3.taborder =0
	 tab_1.tabpage_general.gb_4.taborder =0
	 tab_1.tabpage_general.gb_5.taborder =0
	 tab_1.tabpage_general.gb_6.taborder =0
	 tab_1.tabpage_general.gb_7.taborder =0
	 tab_1.tabpage_general.gb_8.taborder =0
end if
if newindex = 2 then
	 m_titulacion2.dw = tab_1.tabpage_individual.dw_1x
    m_titulacion2.dw2 = tab_1.tabpage_individual.dw_2x

	 tab_1.tabpage_individual.gb_1x.taborder=0
 	 tab_1.tabpage_individual.gb_2x.taborder=0
  	 tab_1.tabpage_individual.gb_3x.taborder=0
	 tab_1.tabpage_individual.gb_4x.taborder=0
	 tab_1.tabpage_individual.gb_5x.taborder=0
	 tab_1.tabpage_individual.gb_6x.taborder=0
	 tab_1.tabpage_individual.gb_7x.taborder=0
	 tab_1.tabpage_individual.gb_8x.taborder=0

end if

end event

type tabpage_general from userobject within tab_1
event create ( )
event destroy ( )
integer x = 128
integer y = 16
integer width = 3525
integer height = 1740
long backcolor = 16777215
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom045!"
long picturemaskcolor = 553648127
uo_nivel uo_nivel
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
vsb_dw_certificado vsb_dw_certificado
cb_1 cb_1
em_2 em_2
em_1 em_1
cb_3 cb_3
cbx_1 cbx_1
cbx_2 cbx_2
st_1 st_1
dw_3 dw_3
gb_3 gb_3
gb_1 gb_1
gb_4 gb_4
gb_6 gb_6
gb_8 gb_8
vsb_dw_certificado2 vsb_dw_certificado2
dw_2 dw_2
gb_2 gb_2
gb_7 gb_7
gb_5 gb_5
dw_1 dw_1
end type

on tabpage_general.create
this.uo_nivel=create uo_nivel
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.vsb_dw_certificado=create vsb_dw_certificado
this.cb_1=create cb_1
this.em_2=create em_2
this.em_1=create em_1
this.cb_3=create cb_3
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.st_1=create st_1
this.dw_3=create dw_3
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_6=create gb_6
this.gb_8=create gb_8
this.vsb_dw_certificado2=create vsb_dw_certificado2
this.dw_2=create dw_2
this.gb_2=create gb_2
this.gb_7=create gb_7
this.gb_5=create gb_5
this.dw_1=create dw_1
this.Control[]={this.uo_nivel,&
this.rb_1,&
this.rb_2,&
this.rb_3,&
this.vsb_dw_certificado,&
this.cb_1,&
this.em_2,&
this.em_1,&
this.cb_3,&
this.cbx_1,&
this.cbx_2,&
this.st_1,&
this.dw_3,&
this.gb_3,&
this.gb_1,&
this.gb_4,&
this.gb_6,&
this.gb_8,&
this.vsb_dw_certificado2,&
this.dw_2,&
this.gb_2,&
this.gb_7,&
this.gb_5,&
this.dw_1}
end on

on tabpage_general.destroy
destroy(this.uo_nivel)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.vsb_dw_certificado)
destroy(this.cb_1)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.cb_3)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_6)
destroy(this.gb_8)
destroy(this.vsb_dw_certificado2)
destroy(this.dw_2)
destroy(this.gb_2)
destroy(this.gb_7)
destroy(this.gb_5)
destroy(this.dw_1)
end on

type uo_nivel from uo_nivel_2013 within tabpage_general
integer x = 992
integer y = 80
integer taborder = 14
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type rb_1 from radiobutton within tabpage_general
integer x = 1577
integer y = 252
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Alfabetico"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type rb_2 from radiobutton within tabpage_general
integer x = 1943
integer y = 252
integer width = 283
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Cuenta"
boolean lefttext = true
end type

event clicked;TabOrder = 0
end event

type rb_3 from radiobutton within tabpage_general
integer x = 2249
integer y = 252
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Fecha"
boolean lefttext = true
end type

event clicked;TabOrder = 0
end event

type vsb_dw_certificado from vscrollbar within tabpage_general
event constructor pbm_constructor
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 3072
integer y = 400
integer width = 201
integer height = 156
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event constructor;visible=FALSE
TabOrder = 0
end event

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_1.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if


end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_1.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_1.ScrollToRow(scrollpos)

if dw_1.Rowcount()=0 then
	st_1.text='Actual : 0 / 0'	
else
   st_1.text='Actual : '+string(scrollpos)+' / '+string(dw_1.RowCount())	
end if

end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_1.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

type cb_1 from commandbutton within tabpage_general
event clicked pbm_bnclicked
integer x = 3040
integer y = 204
integer width = 265
integer height = 108
integer taborder = 4
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event clicked;date ldt_inicial, ldt_final
string ls_nivel, ls_inicial, ls_final
long ll_rows1, ll_rows3
SetNull(ls_nivel)

string ls_array_aux[]
integer li_result


//if uo_nivel.rb_licenciatura.Checked then
//	ls_nivel = "L"
//elseif uo_nivel.rb_posgrado.Checked then
//	ls_nivel = "P"
//elseif uo_nivel.rb_todos.Checked then
//	ls_nivel = "X"
//end if

li_result = tab_1.tabpage_general.uo_nivel.of_carga_arreglo_nivel( )
tab_1.tabpage_general.uo_nivel.of_obtiene_array(ls_array_aux[])

If UpperBound(ls_array_aux[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar al menos un nivel",StopSign!)
	return -1
End If


ls_inicial = em_1.text
ls_final = em_2.text
ldt_inicial = date(ls_inicial)
ldt_final = date(ls_final)

/*Se validan las fechas, y si son validas se mandan al datawindow */
if isdate(em_1.text) and isdate(em_2.text) then
	if date(em_2.text)>=date(em_1.text) then
			if (carrerax = 999) then
				carrerax=0
			end if	
			ll_rows1= dw_1.retrieve(ldt_inicial, ldt_final, carrerax, ls_array_aux[])
			ll_rows3= dw_3.retrieve(ldt_inicial, ldt_final, carrerax, ls_array_aux[])
/* Se ordenan al terminar de traer los datos */
			cb_3.triggerevent("clicked") 
	else
		messagebox(" Error ","Las fechas poseen un formato invalido, posiblemente la fecha inicial sea mayor a la fecha final",StopSign!)
	end if	
else	
     messagebox("Error","Las fechas poseen un formato invalido, favor de revisar",StopSign!)
end if
end event

event constructor;TabOrder = 3
end event

type em_2 from editmask within tabpage_general
integer x = 585
integer y = 144
integer width = 361
integer height = 84
integer taborder = 4
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

event constructor;TabOrder = 2
end event

type em_1 from editmask within tabpage_general
event constructor pbm_constructor
integer x = 114
integer y = 144
integer width = 361
integer height = 84
integer taborder = 3
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

event constructor;TabOrder = 1
end event

type cb_3 from commandbutton within tabpage_general
event clicked pbm_bnclicked
integer x = 2597
integer y = 124
integer width = 265
integer height = 92
integer taborder = 4
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ordenar"
end type

event clicked;/* Se verifica que opcion de Ordenamiento se requiere por medio de los checks*/

if (rb_1.checked=TRUE) then
   dw_1.setsort("alumnos_apaterno A, alumnos_amaterno A, alumnos_nombre A, carreras_carrera A")
	dw_1.sort()
   if (cbx_2.checked=TRUE) then
      dw_1.setsort("carreras_carrera A, alumnos_apaterno A, alumnos_amaterno A, alumnos_nombre A")
		dw_1.sort()
	end if	
end if

if (rb_2.checked=TRUE) then
   dw_1.setsort("titulacion_cuenta A")
	dw_1.sort()
	if (cbx_2.checked=TRUE) then
      dw_1.setsort("carreras_carrera A, titulacion_cuenta A")
		dw_1.sort()
	end if	
	
end if

if (rb_3.checked=TRUE) then
   dw_1.setsort("titulacion_fecha_examen A")
	dw_1.sort()
	if (cbx_2.checked=TRUE) then
      dw_1.setsort("carreras_carrera A, titulacion_fecha_examen A")
		dw_1.sort()
	end if	
end if

/*Se actualiza el scroll bar a la posicion UNO */
vsb_dw_certificado. event moved(1)
vsb_dw_certificado.position=1
end event

event constructor;TabOrder = 0
end event

type cbx_1 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 731
integer y = 336
integer width = 69
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean checked = true
boolean lefttext = true
end type

event clicked;/*Se verifica si son todas las carreras o una en especial, y se manda a carrera */
If (this.checked = TRUE) then
	carrerax=0
	dw_2.visible =FALSE
	vsb_dw_certificado2.visible=FALSE
	
else
	dw_2.visible =TRUE
	vsb_dw_certificado2.visible=TRUE
	carrerax=dw_2.object.cve_carrera[dw_2.getrow()]
end if	


end event

event constructor;TabOrder = 0
carrerax=0

end event

type cbx_2 from checkbox within tabpage_general
integer x = 1687
integer y = 144
integer width = 709
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Agrupación por Carrera "
boolean checked = true
boolean lefttext = true
end type

event clicked;TabOrder = 0
end event

type st_1 from statictext within tabpage_general
integer x = 2926
integer y = 68
integer width = 480
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type dw_3 from datawindow within tabpage_general
event constructor pbm_constructor
integer x = 9
integer y = 1900
integer width = 3493
integer height = 364
integer taborder = 5
string dataobject = "dw_tit_cuenta4"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
//m_titulacion2.dw2 = this
TabOrder = 0
end event

event dberror;return 0
end event

type gb_3 from groupbox within tabpage_general
integer x = 69
integer y = 68
integer width = 448
integer height = 188
integer taborder = 5
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "  Fecha Inicial "
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_general
integer x = 1536
integer y = 64
integer width = 1006
integer height = 268
integer taborder = 5
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = " Opciones de Ordenamiento "
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_general
integer x = 539
integer y = 68
integer width = 448
integer height = 188
integer taborder = 4
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "  Fecha Final "
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_general
integer x = 2971
integer y = 340
integer width = 393
integer height = 236
integer taborder = 7
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Movimiento"
borderstyle borderstyle = styleraised!
end type

type gb_8 from groupbox within tabpage_general
integer x = 2560
integer y = 68
integer width = 343
integer height = 164
integer taborder = 4
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type vsb_dw_certificado2 from vscrollbar within tabpage_general
event constructor pbm_constructor
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 2565
integer y = 468
integer width = 155
integer height = 108
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event constructor;visible=FALSE
TabOrder = 0
end event

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_2.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if


end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_2.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */

dw_2.ScrollToRow(scrollpos)

carrerax=dw_2.object.cve_carrera[dw_2.getrow()]
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_2.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

type dw_2 from datawindow within tabpage_general
event constructor pbm_constructor
event dberror pbm_dwndberror
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
event type integer carga ( string cuenta,  string carrera )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
integer x = 101
integer y = 444
integer width = 2693
integer height = 156
integer taborder = 4
string dataobject = "dw_titulacion_carrera"
boolean border = false
end type

event constructor;/*En cuanto se construya el dw_1...*/
settransobject(gtr_sce)

retrieve()
visible=FALSE
vsb_dw_certificado2.visible=FALSE
TabOrder = 0
end event

event dberror;return -1
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

//int Cont

/*Verifica si se bajo más de un dato*/
if rowcount>1 then
	/*Si es así, haz visible el VerticalScrollBar*/
	vsb_dw_certificado2.visible=TRUE
else
	vsb_dw_certificado2.visible=FALSE
end if

//for Cont=1 to Rowcount() 
//	setitem(Cont,"digito",obten_digito(long(getitemnumber(Cont,"titulacion_cuenta"))))
//next


	

end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado2.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado2.position=currentrow

end if


end event

event borra_renglon;/*Cuando se activa el evonto borra_renglon...*/

/*Pregunta para verificar que realmente se desea borrar el renglón*/
int respuesta
respuesta = messagebox("Atención","Esta seguro de querer borrar el campo actual.",StopSign!,YesNo!,2)

if respuesta = 1 then
	/*Si realmente se desea borrar, borra el renglón actual y verifica que se haya logrado*/
	if deleterow(getrow())	= 1 then
		/*Si se borro, llama a actualiza*/
		event actualiza()

	else
		/*De lo contrario avisa que no se pudo borrar el renglón*/
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif respuesta = 2 then
	/*Si no se quiere borrar el renglón, desecha los cambios hechos.*/
	rollback using gtr_sce;
end if

end event

event actualiza;/*Cuando se dispara el evento actualiza...*/
/*Si es asi, acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if dw_2.ModifiedCount()+dw_2.DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	int respuesta
	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if respuesta = 1 &
		then
			
			/*Checa que los renglones cumplan con las reglas de validación*/
			if update(true) = 1 then		
				/*Si es asi, guardalo en la tabla y avisa.*/
				commit using gtr_sce;
				messagebox("Información","Se han guardado los cambios")			
			else
				/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using gtr_sce;
				messagebox("Información",&
				"Algunos datos están incorrectos, favor de corregirlos. O bien trata de dar de Alta a una persona ya actualizada")
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if	
end if	
end event

event nuevo;/*Cuando se activa el evento nuevo...*/
long VarX

enabled=true
visible=true
/*Pon el foco dentro del DataWindow*/
SetFocus()


/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))




end event

event botonazo;/* Evento que controla el TAB */
IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=10 then
			setcolumn(1)
			SetFocus()
			return -1
		end if
	END IF
END IF

IF keyflags  = 0 THEN
	IF key = KeyEnter! THEN
		if update(true) = 1 then
			setcolumn(2)
			SetFocus()
		else
			return -1
		end if
	END IF
END IF

IF keyflags  = 1 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=1 then
			setcolumn(10)
			SetFocus()
			return -1
		end if	
	END IF
END IF

end event

type gb_2 from groupbox within tabpage_general
integer x = 73
integer y = 368
integer width = 2738
integer height = 256
integer taborder = 8
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "  Todas las Carreras          "
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within tabpage_general
integer x = 2930
integer y = 144
integer width = 475
integer height = 444
integer taborder = 3
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tabpage_general
integer width = 3465
integer height = 668
integer taborder = 5
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda "
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within tabpage_general
event constructor pbm_constructor
event dberror pbm_dwndberror
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
event type integer carga ( string cuenta,  string carrera )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
integer width = 3515
integer height = 1748
integer taborder = 5
string dataobject = "dw_titulacion_rep4"
end type

event constructor;/*En cuanto se construya el dw_1...*/
settransobject(gtr_sce)
//m_titulacion2.dw = this
TabOrder = 0

end event

event dberror;return 0
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

string Cont

/*Verifica si se bajo más de un dato*/
if rowcount>=1 then
	/*Si es así, haz visible el VerticalScrollBar*/
	Cont =string(rowcount)
	vsb_dw_certificado.visible=TRUE
	st_1.text='Total : '+Cont
else
	vsb_dw_certificado.visible=FALSE
	st_1.text='Total : '+Cont
end if

	

end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado.position=currentrow

end if


end event

event borra_renglon;/*Cuando se activa el evonto borra_renglon...*/

/*Pregunta para verificar que realmente se desea borrar el renglón*/
int respuesta
respuesta = messagebox("Atención","Esta seguro de querer borrar el campo actual.",StopSign!,YesNo!,2)

if respuesta = 1 then
	/*Si realmente se desea borrar, borra el renglón actual y verifica que se haya logrado*/
	if deleterow(getrow())	= 1 then
		/*Si se borro, llama a actualiza*/
		event actualiza()

	else
		/*De lo contrario avisa que no se pudo borrar el renglón*/
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif respuesta = 2 then
	/*Si no se quiere borrar el renglón, desecha los cambios hechos.*/
	rollback using gtr_sce;
end if

end event

event actualiza;/*Cuando se dispara el evento actualiza...*/
/*Si es asi, acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if dw_1.ModifiedCount()+dw_1.DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	int respuesta
	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if respuesta = 1 &
		then
			
			/*Checa que los renglones cumplan con las reglas de validación*/
			if update(true) = 1 then		
				/*Si es asi, guardalo en la tabla y avisa.*/
				commit using gtr_sce;
				messagebox("Información","Se han guardado los cambios")			
			else
				/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using gtr_sce;
				messagebox("Información",&
				"Algunos datos están incorrectos, favor de corregirlos. O bien trata de dar de Alta a una persona ya actualizada")
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if	
end if	
end event

event nuevo;/*Cuando se activa el evento nuevo...*/
long VarX

enabled=true
visible=true
/*Pon el foco dentro del DataWindow*/
SetFocus()


/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))




end event

event botonazo;/* Evento que controla el TAB */
IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=10 then
			setcolumn(1)
			SetFocus()
			return -1
		end if
	END IF
END IF

IF keyflags  = 0 THEN
	IF key = KeyEnter! THEN
		if update(true) = 1 then
			setcolumn(2)
			SetFocus()
		else
			return -1
		end if
	END IF
END IF

IF keyflags  = 1 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=1 then
			setcolumn(10)
			SetFocus()
			return -1
		end if	
	END IF
END IF

end event

type tabpage_individual from userobject within tab_1
integer x = 128
integer y = 16
integer width = 3525
integer height = 1740
long backcolor = 16777215
string text = "Individual"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
string picturename = "Move!"
long picturemaskcolor = 553648127
uo_nivel_2 uo_nivel_2
dw_2x dw_2x
cb_5x cb_5x
rb_3x rb_3x
rb_2x rb_2x
rb_1x rb_1x
cbx_2x cbx_2x
st_1x st_1x
lb_1 lb_1
em_1x em_1x
cb_3x cb_3x
gb_8x gb_8x
gb_7x gb_7x
gb_2x gb_2x
cb_4x cb_4x
cb_1x cb_1x
gb_3x gb_3x
gb_4x gb_4x
cb_2x cb_2x
gb_5x gb_5x
gb_6x gb_6x
vsb_dw_certificadox vsb_dw_certificadox
gb_1x gb_1x
lb_2 lb_2
dw_1x dw_1x
end type

on tabpage_individual.create
this.uo_nivel_2=create uo_nivel_2
this.dw_2x=create dw_2x
this.cb_5x=create cb_5x
this.rb_3x=create rb_3x
this.rb_2x=create rb_2x
this.rb_1x=create rb_1x
this.cbx_2x=create cbx_2x
this.st_1x=create st_1x
this.lb_1=create lb_1
this.em_1x=create em_1x
this.cb_3x=create cb_3x
this.gb_8x=create gb_8x
this.gb_7x=create gb_7x
this.gb_2x=create gb_2x
this.cb_4x=create cb_4x
this.cb_1x=create cb_1x
this.gb_3x=create gb_3x
this.gb_4x=create gb_4x
this.cb_2x=create cb_2x
this.gb_5x=create gb_5x
this.gb_6x=create gb_6x
this.vsb_dw_certificadox=create vsb_dw_certificadox
this.gb_1x=create gb_1x
this.lb_2=create lb_2
this.dw_1x=create dw_1x
this.Control[]={this.uo_nivel_2,&
this.dw_2x,&
this.cb_5x,&
this.rb_3x,&
this.rb_2x,&
this.rb_1x,&
this.cbx_2x,&
this.st_1x,&
this.lb_1,&
this.em_1x,&
this.cb_3x,&
this.gb_8x,&
this.gb_7x,&
this.gb_2x,&
this.cb_4x,&
this.cb_1x,&
this.gb_3x,&
this.gb_4x,&
this.cb_2x,&
this.gb_5x,&
this.gb_6x,&
this.vsb_dw_certificadox,&
this.gb_1x,&
this.lb_2,&
this.dw_1x}
end on

on tabpage_individual.destroy
destroy(this.uo_nivel_2)
destroy(this.dw_2x)
destroy(this.cb_5x)
destroy(this.rb_3x)
destroy(this.rb_2x)
destroy(this.rb_1x)
destroy(this.cbx_2x)
destroy(this.st_1x)
destroy(this.lb_1)
destroy(this.em_1x)
destroy(this.cb_3x)
destroy(this.gb_8x)
destroy(this.gb_7x)
destroy(this.gb_2x)
destroy(this.cb_4x)
destroy(this.cb_1x)
destroy(this.gb_3x)
destroy(this.gb_4x)
destroy(this.cb_2x)
destroy(this.gb_5x)
destroy(this.gb_6x)
destroy(this.vsb_dw_certificadox)
destroy(this.gb_1x)
destroy(this.lb_2)
destroy(this.dw_1x)
end on

type uo_nivel_2 from uo_nivel_2013 within tabpage_individual
integer x = 1129
integer y = 60
integer taborder = 12
end type

on uo_nivel_2.destroy
call uo_nivel_2013::destroy
end on

type dw_2x from datawindow within tabpage_individual
event constructor pbm_constructor
integer y = 1868
integer width = 3378
integer height = 204
integer taborder = 4
string dataobject = "dw_tit_cuenta4x"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
//m_titulacion2.dw2 = this
TabOrder = 0
end event

type cb_5x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
integer x = 1289
integer y = 452
integer width = 270
integer height = 124
integer taborder = 5
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ordenar"
end type

event clicked;/* Se verifica que opcion de Ordenamiento se requiere por medio de los checks*/

if (rb_1x.checked=TRUE) then
   dw_1x.setsort("alumnos_apaterno A, alumnos_amaterno A, alumnos_nombre A, carreras_carrera A")
	dw_1x.sort()
   if (cbx_2x.checked=TRUE) then
      dw_1x.setsort("carreras_carrera A, alumnos_apaterno A, alumnos_amaterno A, alumnos_nombre A")
		dw_1x.sort()
	end if	
end if

if (rb_2x.checked=TRUE) then
   dw_1x.setsort("titulacion_cuenta A")
	dw_1x.sort()
	if (cbx_2x.checked=TRUE) then
      dw_1x.setsort("carreras_carrera A, titulacion_cuenta A")
		dw_1x.sort()
	end if	
	
end if

if (rb_3x.checked=TRUE) then
   dw_1x.setsort("titulacion_fecha_examen A")
	dw_1x.sort()
	if (cbx_2x.checked=TRUE) then
      dw_1x.setsort("carreras_carrera A, titulacion_fecha_examen A")
		dw_1x.sort()
	end if	
end if

/*Se actualiza el scroll bar a la posicion UNO */
vsb_dw_certificadox. event moved(1)
vsb_dw_certificadox.position=1
end event

event constructor;TabOrder = 0
end event

type rb_3x from radiobutton within tabpage_individual
integer x = 768
integer y = 460
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Fecha"
boolean lefttext = true
end type

event clicked;TabOrder = 0
end event

type rb_2x from radiobutton within tabpage_individual
integer x = 448
integer y = 460
integer width = 283
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Cuenta"
boolean lefttext = true
end type

event clicked;TabOrder = 0
end event

type rb_1x from radiobutton within tabpage_individual
integer x = 91
integer y = 460
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Alfabetico"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type cbx_2x from checkbox within tabpage_individual
integer x = 238
integer y = 368
integer width = 709
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Agrupación por Carrera "
boolean checked = true
boolean lefttext = true
end type

event clicked;TabOrder = 0
end event

type st_1x from statictext within tabpage_individual
integer x = 2830
integer y = 48
integer width = 480
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type lb_1 from listbox within tabpage_individual
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 1746
integer y = 124
integer width = 544
integer height = 372
integer taborder = 3
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 15793151
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event invierte_seleccion;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items - Inverting each item
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, (Not this.State(ll_item)=1) )
	Next
//	//Number of selected items
//	Return this.TotalSelected()
End If

//Not a valid operation
//Return 0
end event

event selecciona_todo;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, True)
	Next
	//Number of selected items
//	Return li_totalitems
End If

//Not a valid operation
//Return 0
end event

event constructor;TabOrder = 0
end event

type em_1x from editmask within tabpage_individual
event modified pbm_enmodified
integer x = 169
integer y = 128
integer width = 475
integer height = 84
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###xxxxxx"
string displaydata = "Ä"
end type

event modified;string Cuenta
string Digito_X
string Digito
/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_1x*/
if keydown(keyenter!) then	
	Cuenta=this.text
	if (Cuenta <> '') then
   	  cb_1x.triggerevent("clicked")
	end if	
end if

end event

event constructor;TabOrder = 1
end event

type cb_3x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
integer x = 2903
integer y = 160
integer width = 347
integer height = 92
integer taborder = 3
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event clicked;/* Se le pasa el arreglo al datawindow*/
int Total
int contador
string Textito
long Number[]

string ls_nivel
SetNull(ls_nivel)
string ls_array_aux[]
integer li_result


//if uo_nivel_2.rb_licenciatura.Checked then
//	ls_nivel = "L"
//elseif uo_nivel_2.rb_posgrado.Checked then
//	ls_nivel = "P"
//elseif uo_nivel_2.rb_todos.Checked then
//	ls_nivel = "X"
//end if

li_result = tab_1.tabpage_individual.uo_nivel_2.of_carga_arreglo_nivel( )
tab_1.tabpage_individual.uo_nivel_2.of_obtiene_array(ls_array_aux[])

If UpperBound(ls_array_aux[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar al menos un nivel",StopSign!)
	return -1
End If

Total=lb_2.totalitems()


if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_2.text(contador)
		Number[contador]=long(Textito)
   	
	NEXT
	dw_1x.retrieve(Number, ls_array_aux[])
	dw_2x.retrieve(Number,ls_array_aux[])
	cb_5x.triggerevent("clicked") 
end if
end event

event constructor;TabOrder = 3
end event

type gb_8x from groupbox within tabpage_individual
integer x = 1253
integer y = 400
integer width = 338
integer height = 204
integer taborder = 6
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_7x from groupbox within tabpage_individual
integer x = 50
integer y = 292
integer width = 1079
integer height = 252
integer taborder = 5
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = " Opciones de Ordenamiento "
borderstyle borderstyle = styleraised!
end type

type gb_2x from groupbox within tabpage_individual
integer x = 55
integer y = 60
integer width = 695
integer height = 180
integer taborder = 3
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = " Núm. de Cuenta "
borderstyle borderstyle = styleraised!
end type

type cb_4x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
integer x = 2354
integer y = 388
integer width = 279
integer height = 108
integer taborder = 3
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
int Total
long Number[]

Total=lb_1.totalitems()
DO UNTIL Total=0
		lb_1.DeleteItem(1)
      lb_2.DeleteItem(1)
		Total=lb_1.totalitems()
LOOP
Number[1]=0
dw_1x.retrieve(Number)
end event

event constructor;TabOrder = 0
end event

type cb_1x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event type integer verifica ( )
event type integer verifica_2 ( string cuenta )
integer x = 818
integer y = 108
integer width = 279
integer height = 108
integer taborder = 2
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Agregar"
end type

event clicked;/* Se verifica que exista el alumno y que no este en la lista y que su digito verificador este
correcto */
string Cuenta
	Cuenta=em_1x.text
	if (Cuenta <> '') then
		if this. EVENT verifica() = 1 then
		else
			em_1x.SelectText(1, Len(em_1x.Text))
			em_1x.setfocus()
		end if	  
end if
end event

event verifica;/* Se verifica que el alumno exista y que el digito verificador corresponda */
string Digito_X
string Digito
string Cuenta
long Cuenta_A
long Cuenta_B

Cuenta=upper(em_1x.text)
Digito_X=mid(Cuenta,len(Cuenta),len(Cuenta))
Cuenta=mid(Cuenta,1,len(Cuenta)-1)
Digito=obten_digito ( long (Cuenta) )
Cuenta_A=long(Cuenta)

SELECT alumnos.cuenta  
    INTO :Cuenta_B  
	 FROM alumnos  
	 WHERE alumnos.cuenta = :Cuenta_A using gtr_sce;
	 if gtr_sce.sqlcode = 100 then
			messagebox("Atención","El alumno con clave "+string(cuenta)+" no existe.")
		   /* Alumno no existe */
			return 0
	 else		
		
		if Digito=Digito_X then
	      if this. EVENT verifica_2(Cuenta) = 1 then
			   lb_1.additem (Cuenta+" - "+Digito_X)
            lb_2.additem (Cuenta)
			   em_1x.text=''
		      return 1 /* Todo esta bien */
	      else
   			/* Ya esta en la lista */
	   		return 0
		   end if	
	 
	   else
	      /* Digito Verificador Erroneo */
         messagebox("Atención","El digito verificador es ERRONEO, favor de revisarlo")
      	return 0
      end if

end if

		
		
		
		










end event

event verifica_2;/* Se verifica que no se enceuntre en la lista */
int Total
int contador
string Textito
int Bandera

Bandera=0
Total=lb_2.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_2.text(contador)
	   if Cuenta=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	messagebox("Atención","El número de cuenta que desea introducir ~r~ "+&
	                      "        YA SE ENCUENTRA LA LISTA")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

event constructor;TabOrder = 2
end event

type gb_3x from groupbox within tabpage_individual
integer x = 782
integer y = 60
integer width = 347
integer height = 180
integer taborder = 4
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_4x from groupbox within tabpage_individual
integer x = 1714
integer y = 60
integer width = 974
integer height = 476
integer taborder = 3
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = " Lista  "
borderstyle borderstyle = styleraised!
end type

type cb_2x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
integer x = 2354
integer y = 124
integer width = 279
integer height = 108
integer taborder = 2
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index

li_Index = lb_1.SelectedIndex( )
lb_1.DeleteItem(li_Index)
lb_2.DeleteItem(li_Index)


end event

event constructor;TabOrder = 0
end event

type gb_5x from groupbox within tabpage_individual
integer x = 2866
integer y = 260
integer width = 439
integer height = 252
integer taborder = 4
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = " Movimiento"
borderstyle borderstyle = styleraised!
end type

type gb_6x from groupbox within tabpage_individual
integer x = 2789
integer y = 108
integer width = 562
integer height = 428
integer taborder = 4
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type vsb_dw_certificadox from vscrollbar within tabpage_individual
event constructor pbm_constructor
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 2981
integer y = 332
integer width = 206
integer height = 164
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event constructor;visible=FALSE
TabOrder = 0
end event

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_1x.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if


end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_1x.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_1x.ScrollToRow(scrollpos)

if dw_1x.Rowcount()=0 then
	st_1x.text='Actual : 0 / 0'	
else
   st_1x.text='Actual : '+string(scrollpos)+' / '+string(dw_1x.RowCount())	
end if

end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_1x.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

type gb_1x from groupbox within tabpage_individual
integer y = 4
integer width = 3461
integer height = 604
integer taborder = 4
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type lb_2 from listbox within tabpage_individual
integer x = 1248
integer y = 92
integer width = 288
integer height = 76
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

type dw_1x from datawindow within tabpage_individual
event constructor pbm_constructor
integer width = 3465
integer height = 1744
integer taborder = 4
string dataobject = "dw_titulacion_rep4x"
end type

event constructor;settransobject(gtr_sce)
TabOrder = 0
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


int li_Index
int Total
int Total_Renglon
int Contador

string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	/*Si es así, haz visible el VerticalScrollBar*/
	Cont =string(rowcount)
	vsb_dw_certificadox.visible=TRUE
	st_1x.text='Total : '+Cont
   
	Total=lb_2.totalitems()
   Total_Renglon=rowcount()
   lb_1.EVENT selecciona_todo()
   lb_1.EVENT invierte_seleccion()
	
		 FOR Contador=1 to Total_Renglon		   
	     li_Index = lb_1.SelectItem(string(object.titulacion_cuenta[Contador]), 1)
		  lb_1.SetState(li_Index, TRUE)		  
       NEXT
		 
 	/* Selecciona a los numero de cuenta que no se encontraron */	 
   lb_1.EVENT invierte_seleccion()

	
else
	vsb_dw_certificadox.visible=FALSE
	st_1x.text='Total : '+Cont
	lb_1.EVENT selecciona_todo()
end if



	
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificadox.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificadox.position=currentrow

end if

end event

