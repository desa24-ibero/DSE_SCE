$PBExportHeader$w_subsistemas.srw
forward
global type w_subsistemas from window
end type
type st_4 from statictext within w_subsistemas
end type
type p_1 from picture within w_subsistemas
end type
type em_clv_plan from editmask within w_subsistemas
end type
type em_clv_carr from editmask within w_subsistemas
end type
type rr_tres from roundrectangle within w_subsistemas
end type
type rr_dos from roundrectangle within w_subsistemas
end type
type rr_uno from roundrectangle within w_subsistemas
end type
type st_sub from statictext within w_subsistemas
end type
type st_cve from statictext within w_subsistemas
end type
type st_opt from statictext within w_subsistemas
end type
type st_obl from statictext within w_subsistemas
end type
type em_cve_sub from editmask within w_subsistemas
end type
type sle_sub from singlelineedit within w_subsistemas
end type
type cbx_mod from checkbox within w_subsistemas
end type
type st_total from statictext within w_subsistemas
end type
type cb_1 from commandbutton within w_subsistemas
end type
type vsb_dw_carr from vscrollbar within w_subsistemas
end type
type vsb_dw_pla from vscrollbar within w_subsistemas
end type
type dw_4 from datawindow within w_subsistemas
end type
type dw_3 from datawindow within w_subsistemas
end type
type dw_2 from datawindow within w_subsistemas
end type
type dw_1 from datawindow within w_subsistemas
end type
type dw_key from datawindow within w_subsistemas
end type
type rr_cinco from roundrectangle within w_subsistemas
end type
type rr_cuatro from roundrectangle within w_subsistemas
end type
type st_1 from statictext within w_subsistemas
end type
type st_2 from statictext within w_subsistemas
end type
type st_3 from statictext within w_subsistemas
end type
type dw_carr from datawindow within w_subsistemas
end type
type dw_pla from datawindow within w_subsistemas
end type
end forward

global type w_subsistemas from window
integer x = 5
integer y = 4
integer width = 3959
integer height = 2108
boolean titlebar = true
string title = "SubSistemas"
string menuname = "m_menu_cat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
st_4 st_4
p_1 p_1
em_clv_plan em_clv_plan
em_clv_carr em_clv_carr
rr_tres rr_tres
rr_dos rr_dos
rr_uno rr_uno
st_sub st_sub
st_cve st_cve
st_opt st_opt
st_obl st_obl
em_cve_sub em_cve_sub
sle_sub sle_sub
cbx_mod cbx_mod
st_total st_total
cb_1 cb_1
vsb_dw_carr vsb_dw_carr
vsb_dw_pla vsb_dw_pla
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
dw_key dw_key
rr_cinco rr_cinco
rr_cuatro rr_cuatro
st_1 st_1
st_2 st_2
st_3 st_3
dw_carr dw_carr
dw_pla dw_pla
end type
global w_subsistemas w_subsistemas

on w_subsistemas.create
if this.MenuName = "m_menu_cat" then this.MenuID = create m_menu_cat
this.st_4=create st_4
this.p_1=create p_1
this.em_clv_plan=create em_clv_plan
this.em_clv_carr=create em_clv_carr
this.rr_tres=create rr_tres
this.rr_dos=create rr_dos
this.rr_uno=create rr_uno
this.st_sub=create st_sub
this.st_cve=create st_cve
this.st_opt=create st_opt
this.st_obl=create st_obl
this.em_cve_sub=create em_cve_sub
this.sle_sub=create sle_sub
this.cbx_mod=create cbx_mod
this.st_total=create st_total
this.cb_1=create cb_1
this.vsb_dw_carr=create vsb_dw_carr
this.vsb_dw_pla=create vsb_dw_pla
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_key=create dw_key
this.rr_cinco=create rr_cinco
this.rr_cuatro=create rr_cuatro
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_carr=create dw_carr
this.dw_pla=create dw_pla
this.Control[]={this.st_4,&
this.p_1,&
this.em_clv_plan,&
this.em_clv_carr,&
this.rr_tres,&
this.rr_dos,&
this.rr_uno,&
this.st_sub,&
this.st_cve,&
this.st_opt,&
this.st_obl,&
this.em_cve_sub,&
this.sle_sub,&
this.cbx_mod,&
this.st_total,&
this.cb_1,&
this.vsb_dw_carr,&
this.vsb_dw_pla,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.dw_key,&
this.rr_cinco,&
this.rr_cuatro,&
this.st_1,&
this.st_2,&
this.st_3,&
this.dw_carr,&
this.dw_pla}
end on

on w_subsistemas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_4)
destroy(this.p_1)
destroy(this.em_clv_plan)
destroy(this.em_clv_carr)
destroy(this.rr_tres)
destroy(this.rr_dos)
destroy(this.rr_uno)
destroy(this.st_sub)
destroy(this.st_cve)
destroy(this.st_opt)
destroy(this.st_obl)
destroy(this.em_cve_sub)
destroy(this.sle_sub)
destroy(this.cbx_mod)
destroy(this.st_total)
destroy(this.cb_1)
destroy(this.vsb_dw_carr)
destroy(this.vsb_dw_pla)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_key)
destroy(this.rr_cinco)
destroy(this.rr_cuatro)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_carr)
destroy(this.dw_pla)
end on

event open;this.x=1
this.y=1

// Inicializar comunicación con bases de Datos
dw_key.SetTrans (gtr_sce)
dw_1.SetTrans (gtr_sce)
dw_2.SetTrans (gtr_sce)
dw_3.SetTrans (gtr_sce)
dw_4.SetTrans (gtr_sce)
dw_carr.SetTrans (gtr_sce)
dw_pla.SetTrans (gtr_sce)

// Hacer el retrieve de los datawindows utilizados
dw_carr.retrieve()
dw_pla.retrieve()

//Ocultar los controles al inicio
//rr_seis.visible=false
//rr_siete.visible=false
//rr_9.visible=false
rr_cuatro.visible=false
rr_cinco.visible=false
rr_tres.visible=false
/**/gnv_app.inv_security.of_SetSecurity(this)


//g_nv_security.fnv_secure_window (this)
end event

type st_4 from statictext within w_subsistemas
integer x = 709
integer y = 116
integer width = 192
integer height = 88
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_1 from picture within w_subsistemas
integer x = 9
integer y = 36
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type em_clv_plan from editmask within w_subsistemas
integer x = 494
integer y = 892
integer width = 247
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#"
string displaydata = "D"
end type

event modified;if (text<>string(dw_pla.object.cve_plan[dw_pla.getrow()])) then
	long estas_en=1, total

	total=dw_pla.rowcount()

	DO UNTIL (estas_en>=total or string(dw_pla.object.cve_plan[estas_en])=text)
		estas_en=estas_en+1
	LOOP
	if string(dw_pla.object.cve_plan[estas_en])=text then
		dw_pla.scrolltorow(estas_en)
	else
		dw_pla.scrolltorow(1)
		text="1"
	end if
	cb_1.event clicked()
end if
end event

type em_clv_carr from editmask within w_subsistemas
integer x = 14
integer y = 412
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = "Ä"
end type

event modified;if (text<>string(dw_carr.object.cve_carrera[dw_carr.getrow()])) then
	long estas_en=1, total

	total=dw_carr.rowcount()

	DO UNTIL (estas_en>=total or string(dw_carr.object.cve_carrera[estas_en])=text)
		estas_en=estas_en+1
	LOOP
	if string(dw_carr.object.cve_carrera[estas_en])=text then
		dw_carr.scrolltorow(estas_en)
	else
		dw_carr.scrolltorow(999)
		text="999"
	end if
end if
end event

type rr_tres from roundrectangle within w_subsistemas
integer linethickness = 3
long fillcolor = 16777215
integer x = 2789
integer y = 788
integer width = 475
integer height = 260
integer cornerheight = 42
integer cornerwidth = 40
end type

type rr_dos from roundrectangle within w_subsistemas
integer linethickness = 3
long fillcolor = 16777215
integer x = 1915
integer y = 788
integer width = 517
integer height = 260
integer cornerheight = 42
integer cornerwidth = 40
end type

type rr_uno from roundrectangle within w_subsistemas
integer linethickness = 3
long fillcolor = 16777215
integer x = 329
integer y = 788
integer width = 1285
integer height = 260
integer cornerheight = 42
integer cornerwidth = 40
end type

type st_sub from statictext within w_subsistemas
integer x = 1353
integer y = 1100
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
boolean enabled = false
string text = "Subsistema"
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type st_cve from statictext within w_subsistemas
integer x = 366
integer y = 1100
integer width = 585
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
boolean enabled = false
string text = "Clave del Subsistema"
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type st_opt from statictext within w_subsistemas
integer x = 2482
integer y = 1244
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "OPTATIVA"
boolean border = true
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type st_obl from statictext within w_subsistemas
integer x = 763
integer y = 1244
integer width = 425
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "OBLIGATORIA"
boolean border = true
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type em_cve_sub from editmask within w_subsistemas
integer x = 974
integer y = 1092
integer width = 297
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = "¨"
end type

event modified;if (dw_key.Getrow() > 0) then
	if text<>string(dw_key.object.cve_subsistema[dw_key.Getrow()]) then
		if cbx_mod.checked then
			if dw_1.rowcount()>0 then
				dw_1.object.cve_subsistema[dw_1.GetRow()]=integer(text)
			end if
			if dw_2.rowcount()>0 then
				dw_2.object.cve_subsistema[dw_2.GetRow()]=integer(text)
			end if
		else
			long estas_en=1, total

			total=dw_key.rowcount()

			DO UNTIL (estas_en>=total or string(dw_key.object.cve_subsistema[estas_en])=text)
				estas_en=estas_en+1
			LOOP
			if string(dw_key.object.cve_subsistema[estas_en])=text then
				dw_key.scrolltorow(estas_en)
			else
				dw_key.scrolltorow(1)
				if dw_key.rowcount()>0 then
					text=string(dw_key.object.cve_subsistema[1])
				end if
			end if
		end if
	end if
else
	if cbx_mod.checked then
		if dw_1.rowcount()>0 then
			dw_1.object.cve_subsistema[dw_1.GetRow()]=integer(text)
		end if
		if dw_2.rowcount()>0 then
			dw_2.object.cve_subsistema[dw_2.GetRow()]=integer(text)
		end if
	end if
end if

end event

event constructor;visible=false
end event

type sle_sub from singlelineedit within w_subsistemas
integer x = 1719
integer y = 1092
integer width = 1513
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;if cbx_mod.checked then
	if dw_1.rowcount()>0 then
		dw_1.object.subsistema[dw_1.GetRow()]=text
	end if
	if dw_2.rowcount()>0 then
		dw_2.object.subsistema[dw_2.GetRow()]=text
	end if
else
	if dw_1.rowcount()>0 then
		text=dw_1.object.subsistema[dw_1.GetRow()]
	else
		if dw_2.rowcount()>0 then
			text=dw_2.object.subsistema[dw_2.GetRow()]
		end if
	end if
end if
end event

event constructor;visible=false
end event

type cbx_mod from checkbox within w_subsistemas
integer x = 1998
integer y = 808
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "&Modificar"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

type st_total from statictext within w_subsistemas
integer x = 2885
integer y = 900
integer width = 279
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean border = true
long bordercolor = 79741120
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type cb_1 from commandbutton within w_subsistemas
integer x = 2048
integer y = 920
integer width = 270
integer height = 108
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Car&gar"
end type

event clicked;dw_key.event carga(dw_carr.Object.cve_carrera[dw_carr.GetRow()],&
	dw_pla.Object.cve_plan[dw_pla.GetRow()])
end event

type vsb_dw_carr from vscrollbar within w_subsistemas
event constructor pbm_constructor
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 3799
integer y = 320
integer width = 78
integer height = 412
boolean bringtotop = true
integer minposition = 1
integer position = 1
end type

event constructor;visible=FALSE
end event

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_carr.RowCount() then
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
vsb_dw_carr.maxposition=dw_carr.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_carr.ScrollToRow(scrollpos)
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_carr.RowCount() then
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

type vsb_dw_pla from vscrollbar within w_subsistemas
event constructor pbm_constructor
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 1463
integer y = 888
integer width = 73
integer height = 132
boolean bringtotop = true
integer minposition = 1
integer position = 1
end type

event constructor;visible=FALSE
end event

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_pla.RowCount() then
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
maxposition=dw_pla.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_pla.ScrollToRow(scrollpos)
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_pla.RowCount() then
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

type dw_4 from datawindow within w_subsistemas
event carga ( integer clave )
integer x = 2062
integer y = 1628
integer width = 1170
integer height = 224
string dataobject = "dw_subsistema2"
boolean border = false
boolean livescroll = true
end type

event carga;retrieve(clave)
end event

event constructor;visible=false
end event

event retrieveend;if rowcount>0 then
	visible=true
else
	visible=false
	insertrow(0)
end if
end event

type dw_3 from datawindow within w_subsistemas
event carga ( integer clave )
integer x = 366
integer y = 1628
integer width = 1166
integer height = 224
string dataobject = "dw_subsistema2"
boolean border = false
boolean livescroll = true
end type

event carga;retrieve(clave)
end event

event constructor;visible=false
end event

event retrieveend;if rowcount>0 then
	visible=true
else
	visible=false
	insertrow(0)
end if
end event

type dw_2 from datawindow within w_subsistemas
event carga ( integer carrera,  integer plan,  integer subsistema )
event actualiza ( )
event nuevo ( integer carrera,  integer plan )
event borrar ( )
integer x = 2377
integer y = 1372
integer width = 553
integer height = 188
integer taborder = 60
string dataobject = "dw_subsistema1"
boolean border = false
boolean livescroll = true
end type

event carga;if cbx_mod.checked then
	AcceptText()
	dw_key.event db_update()			
end if
retrieve("OPT",carrera,plan,subsistema)
end event

event actualiza;if parent.st_total.text="Nuevo" then
	if rowcount() > 0 then	
		if object.cve_area[rowcount()]=0 then
			deleterow(rowcount())
		end if
	end if
end if
if cbx_mod.checked then
	AcceptText()
	if deletedcount()+modifiedcount() > 0 then
		if update(true) = 1 then		
			commit using gtr_sce;
		else
			rollback using gtr_sce;
		end if
	end if
	cb_1.event clicked()
end if
end event

event nuevo;visible=true
int ii_renglon
ii_renglon=insertrow(0)

scrolltorow(ii_renglon)
object.cve_carrera[ii_renglon]=carrera
object.cve_plan[ii_renglon]=plan
object.clase_area[ii_renglon]="OPT"
object.cve_area[ii_renglon]=0
end event

event borrar;if rowcount()>0 then
	Deleterow(Getrow())
end if
dw_1.event actualiza()
end event

event retrieveend;if rowcount>0 then
	visible=true
	st_opt.visible=true
	dw_4.visible=true
	dw_4.event carga ( dw_2.object.cve_area[1] )
else
	st_opt.visible=false
	visible=false
	dw_4.visible=false
end if
end event

event constructor;visible=false
end event

event dberror;//return -1
end event

type dw_1 from datawindow within w_subsistemas
event carga ( integer carrera,  integer plan,  integer subsistema )
event actualiza ( )
event nuevo ( integer carrera,  integer plan )
event borrar ( )
integer x = 699
integer y = 1380
integer width = 562
integer height = 204
integer taborder = 50
string dataobject = "dw_subsistema1"
boolean border = false
boolean livescroll = true
end type

event carga;if cbx_mod.checked then
	AcceptText()
	dw_key.event db_update()			
end if
retrieve("OBL",carrera,plan,subsistema)
end event

event actualiza;if parent.st_total.text="Nuevo" then
if rowcount() > 0 then	
	if object.cve_area[rowcount()]=0 then
		deleterow(rowcount())
	end if
end if
end if
if cbx_mod.checked then
	AcceptText()
	if deletedcount()+modifiedcount()> 0 then
		if update(true) = 1 then		
			commit using gtr_sce;
		else
			rollback using gtr_sce;
		end if
	end if
	dw_2.event actualiza()
end if
end event

event nuevo;visible=true
int ii_renglon
ii_renglon=insertrow(0)
scrolltorow(ii_renglon)
object.cve_carrera[ii_renglon]=carrera
object.cve_plan[ii_renglon]=plan
object.clase_area[ii_renglon]="OBL"
object.cve_area[ii_renglon]=0
end event

event borrar;if rowcount()>0 then
	Deleterow(Getrow())
end if
dw_2.event borrar()
end event

event retrieveend;if rowcount>0 then
	visible=true
	st_obl.visible=true
	dw_3.visible=true
	dw_3.event carga ( dw_1.object.cve_area[1] )
else
	st_obl.visible=false
	visible=false
	dw_3.visible=false
end if
end event

event constructor;visible=false
end event

event dberror;//return -1
end event

type dw_key from datawindow within w_subsistemas
event constructor pbm_constructor
event itemchanged pbm_dwnitemchange
event itemfocuschanged pbm_dwnitemchangefocus
event retrieveend pbm_dwnretrieveend
event db_update ( )
event dw_del ( )
event dw_new ( )
event primero ( )
event ultimo ( )
event siguiente ( )
event anterior ( )
event carga ( integer carrera,  integer plan )
boolean visible = false
integer x = 3854
integer y = 340
integer width = 3319
integer height = 304
string dataobject = "dw_subsistema"
boolean border = false
end type

event constructor;m_menu_cat.dw = This

end event

event retrieveend;// Si no existen datos al momento de acabar el retrieve 
// se ocultan algunos controles y campos de edición, de caso contrario
// se habilitan y se insertan los campos de carrera y plan de otros datawindows.
if rowcount=0 then
	dw_1.visible=false
	dw_2.visible=false
	dw_3.visible=false
	dw_4.visible=false
	st_obl.visible=false
	st_opt.visible=false
	visible=false
	em_cve_sub.visible=False
	sle_sub.visible=False
	st_total.visible=False

	st_sub.visible=False
	st_cve.visible=False
	
	st_3.visible=False
//	rr_9.visible=False
//	rr_seis.visible=False
//	rr_siete.visible=False
	rr_cuatro.visible=false
   rr_cinco.visible=false
   rr_tres.visible=false
else
	visible=true
	em_cve_sub.visible=true
	sle_sub.visible=true
	st_total.visible=true
	cbx_mod.checked=false
	st_sub.visible=true
	st_cve.visible=true
	
	rr_cuatro.visible=true
   rr_cinco.visible=true
   rr_tres.visible=true
	
//	rr_9.visible=true
//	rr_seis.visible=true
//	rr_siete.visible=true
	st_3.visible=true
	

	dw_1.event carga ( dw_key.object.cve_carrera[Getrow()],dw_key.object.cve_plan[Getrow()], &
		dw_key.object.cve_subsistema[Getrow()])
	dw_2.event carga ( dw_key.object.cve_carrera[Getrow()],dw_key.object.cve_plan[Getrow()], &
		dw_key.object.cve_subsistema[Getrow()])
		
	em_cve_sub.text=string(object.cve_subsistema[Getrow()])
	sle_sub.text=string(object.subsistema[Getrow()])
	st_total.text=string(GetRow())+' de '+string(Rowcount())

end if
end event

event db_update;// Si se encuentra seleccionado el check de actualizar, se actualizan los datawindows 
//que despliegan los datos de obligatorio y optativo
if cbx_mod.checked then
	if dw_1.modifiedcount()+dw_1.deletedcount()+dw_2.modifiedcount()+dw_2.deletedcount() > 0 then
		if messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesno!)=1 then
			AcceptText()
			dw_1.event actualiza()
		else
			rollback using gtr_sce;
			cbx_mod.checked=FALSE
		end if
	end if
end if

end event

event dw_del;//Si se encuentra marcado el check de modoficar, permite borrar
if cbx_mod.checked then
	dw_1.event borrar()
end if
end event

event dw_new();cb_1.event clicked()
parent.st_total.text="Nuevo"
//Este sirve para dar de alta a uno nuevo, con los datosde carrera y plan como defaults
dw_1.event nuevo ( dw_carr.object.cve_carrera[dw_carr.Getrow()],dw_pla.object.cve_plan[dw_pla.Getrow()])
dw_2.event nuevo ( dw_carr.object.cve_carrera[dw_carr.Getrow()],dw_pla.object.cve_plan[dw_pla.Getrow()])
// Este codigo es para habilitar algunos controles y chacharitas para observar la
//pantalla de edición
st_obl.visible=true
st_opt.visible=true
visible=true
em_cve_sub.visible=true
sle_sub.visible=true
st_total.visible=true
cbx_mod.checked=true
st_sub.visible=true
st_cve.visible=true

dw_3.visible=false
dw_4.visible=false

rr_cuatro.visible=true
rr_cinco.visible=true
rr_tres.visible=true
	
//rr_9.visible=true
//rr_seis.visible=true
//rr_siete.visible=true
st_3.visible=true

sle_sub.text=""
em_cve_sub.text=""
em_cve_sub.setfocus()
end event

event primero;//Se mueve al primer renglon
event db_update()
scrolltorow(1)

end event

event ultimo;// obtiene el ultimo renglon
event db_update()
scrolltorow(rowcount())
end event

event siguiente;// obtiene el siguiente renglon 
event db_update()
if GetRow()<RowCount() then
	ScrollToRow(GetRow()+1)
end if

end event

event anterior;//Se dispara el evento update para no perder los datos actuales
event db_update()

//Obtiene el renglon anterior
if GetRow()>1 then
	ScrollToRow(GetRow() -1)
end if

end event

event carga;// obtiene datos a partir de carrera y plan
event db_update()
retrieve(carrera,plan)
end event

event rowfocuschanged;// Al haber un cambio en los datawindows, se actualizan y se redespliegan todos
//los datos actualizados en los dos datawindows de optativos y obligatorios
if GetRow() > 0 then
	parent.sle_sub.text=string(object.subsistema[Getrow()])
	parent.st_total.text=string(GetRow())+' de '+string(Rowcount())
	parent.em_cve_sub.text=string(object.cve_subsistema[Getrow()])
	dw_1.event carga ( dw_key.object.cve_carrera[Getrow()],dw_key.object.cve_plan[Getrow()], &
		dw_key.object.cve_subsistema[Getrow()])
	dw_2.event carga ( dw_key.object.cve_carrera[Getrow()],dw_key.object.cve_plan[Getrow()], &
		dw_key.object.cve_subsistema[Getrow()])
end if
	

end event

type rr_cinco from roundrectangle within w_subsistemas
integer linethickness = 3
long fillcolor = 16777215
integer x = 334
integer y = 1220
integer width = 2939
integer height = 676
integer cornerheight = 42
integer cornerwidth = 40
end type

type rr_cuatro from roundrectangle within w_subsistemas
integer linethickness = 3
long fillcolor = 16777215
integer x = 329
integer y = 1060
integer width = 2939
integer height = 156
integer cornerheight = 42
integer cornerwidth = 40
end type

type st_1 from statictext within w_subsistemas
integer x = 402
integer y = 804
integer width = 393
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Clave del Plan"
boolean focusrectangle = false
end type

type st_2 from statictext within w_subsistemas
integer x = 914
integer y = 804
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Nombre del Plan"
boolean focusrectangle = false
end type

type st_3 from statictext within w_subsistemas
integer x = 2871
integer y = 820
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
boolean enabled = false
string text = "Reg. Actual"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type dw_carr from datawindow within w_subsistemas
integer y = 324
integer width = 3799
integer height = 408
string dataobject = "dw_cat_carrera_2013"
boolean hscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_carr.maxposition=dw_carr.RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_carr.position=GetRow()
	
	em_clv_carr.text=string(object.cve_carrera[getrow()])

end if


end event

event retrieveend;if rowcount>1 then
	vsb_dw_carr.visible=TRUE
	em_clv_carr.text=string(object.cve_carrera[1])
else
	vsb_dw_carr.visible=FALSE
end if
end event

type dw_pla from datawindow within w_subsistemas
integer x = 421
integer y = 888
integer width = 1042
integer height = 132
string dataobject = "dw_plan"
boolean border = false
boolean livescroll = true
end type

event retrieveend;if rowcount>1 then
	vsb_dw_pla.visible=TRUE
	em_clv_plan.text=string(object.cve_plan[1])
else
	vsb_dw_pla.visible=FALSE
end if
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_pla.maxposition=dw_pla.RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_pla.position=GetRow()
	
	em_clv_plan.text=string(object.cve_plan[getrow()])

end if


end event

