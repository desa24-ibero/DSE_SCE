$PBExportHeader$w_relacion_titulos_profesiones.srw
forward
global type w_relacion_titulos_profesiones from window
end type
type st_fecha from statictext within w_relacion_titulos_profesiones
end type
type st_formato from statictext within w_relacion_titulos_profesiones
end type
type em_fecha_inicial from editmask within w_relacion_titulos_profesiones
end type
type st_2 from statictext within w_relacion_titulos_profesiones
end type
type st_1 from statictext within w_relacion_titulos_profesiones
end type
type lb_2 from listbox within w_relacion_titulos_profesiones
end type
type lb_1 from listbox within w_relacion_titulos_profesiones
end type
type cb_1x from commandbutton within w_relacion_titulos_profesiones
end type
type em_1x from editmask within w_relacion_titulos_profesiones
end type
type cb_1 from commandbutton within w_relacion_titulos_profesiones
end type
type dw_1 from datawindow within w_relacion_titulos_profesiones
end type
end forward

global type w_relacion_titulos_profesiones from window
integer x = 37
integer y = 211
integer width = 3650
integer height = 1667
boolean titlebar = true
string title = "Relación de Títulos Enviados a la Dirección General de Profesiones"
string menuname = "m_menu_reporte"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
boolean righttoleft = true
st_fecha st_fecha
st_formato st_formato
em_fecha_inicial em_fecha_inicial
st_2 st_2
st_1 st_1
lb_2 lb_2
lb_1 lb_1
cb_1x cb_1x
em_1x em_1x
cb_1 cb_1
dw_1 dw_1
end type
global w_relacion_titulos_profesiones w_relacion_titulos_profesiones

type variables
boolean ib_usuario_especial
end variables

forward prototypes
public function integer wf_cambia_dw (string as_nom_datawindow, integer ai_zoom, integer ai_orientation)
end prototypes

public function integer wf_cambia_dw (string as_nom_datawindow, integer ai_zoom, integer ai_orientation);/*
Función wf_cambia_dw

Parámetros:
as_nom_datawindow string
	Cadena con el nombre del datawindow

ai_zoom				integer
	Donde ai_zoom > 0 y es el porcentaje de la impresion
	
ai_orientation 	integer
	0 - La orientation de default de la impresora
	1 - Landscape
	2 - Portrait
*/


if isnull(dw_1.DataObject) then
	MessageBox("Nombre de DataWindow Inválido","El DataWindow :"+as_nom_datawindow+" no existe")	
	return 0
end if

if isnull(ai_zoom) or ai_zoom <= 0 then
	MessageBox("Tamaño del Zoom Inválido","El Zoom :"+string(ai_zoom)+" no está permitido")	
	return 0
end if

if isnull(ai_orientation) or (ai_orientation < 0 and ai_orientation> 2) then
	MessageBox("Orientación inválida","La Orientación :"+string(ai_orientation)+" no está permitida")	
	return 0
end if

dw_1.DataObject =  as_nom_datawindow

dw_1.SetTransObject(gtr_sce)

dw_1.Object.DataWindow.Print.Preview.Zoom = ai_zoom

dw_1.Object.DataWindow.Print.Orientation = ai_orientation

m_menu_reporte.dw = dw_1

return 0
end function

on w_relacion_titulos_profesiones.create
if this.MenuName = "m_menu_reporte" then this.MenuID = create m_menu_reporte
this.st_fecha=create st_fecha
this.st_formato=create st_formato
this.em_fecha_inicial=create em_fecha_inicial
this.st_2=create st_2
this.st_1=create st_1
this.lb_2=create lb_2
this.lb_1=create lb_1
this.cb_1x=create cb_1x
this.em_1x=create em_1x
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_fecha,&
this.st_formato,&
this.em_fecha_inicial,&
this.st_2,&
this.st_1,&
this.lb_2,&
this.lb_1,&
this.cb_1x,&
this.em_1x,&
this.cb_1,&
this.dw_1}
end on

on w_relacion_titulos_profesiones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_fecha)
destroy(this.st_formato)
destroy(this.em_fecha_inicial)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.lb_2)
destroy(this.lb_1)
destroy(this.cb_1x)
destroy(this.em_1x)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;datetime lddtm_fecha
string ls_fecha_inicial, ls_fecha_final

lddtm_fecha = fecha_servidor(gtr_sce)

ls_fecha_inicial = string(lddtm_fecha, "dd/mm/yyyy" )
//ls_fecha_final = string(lddtm_fecha, "dd/mm/yyyy" )


em_fecha_inicial.text = ls_fecha_inicial
//em_fecha_final.text = ls_fecha_final

x=1
y=1

end event

type st_fecha from statictext within w_relacion_titulos_profesiones
integer x = 2033
integer y = 192
integer width = 494
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha In. Examen"
boolean focusrectangle = false
end type

type st_formato from statictext within w_relacion_titulos_profesiones
integer x = 2556
integer y = 99
integer width = 369
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "dd/mm/yyyy"
boolean focusrectangle = false
end type

type em_fecha_inicial from editmask within w_relacion_titulos_profesiones
integer x = 2549
integer y = 182
integer width = 369
integer height = 83
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_relacion_titulos_profesiones
integer x = 1397
integer y = 35
integer width = 563
integer height = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ctas. Seleccionadas"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_relacion_titulos_profesiones
integer x = 62
integer y = 138
integer width = 413
integer height = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Num. Cuenta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type lb_2 from listbox within w_relacion_titulos_profesiones
boolean visible = false
integer x = 1093
integer y = 352
integer width = 143
integer height = 93
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

type lb_1 from listbox within w_relacion_titulos_profesiones
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 1397
integer y = 112
integer width = 545
integer height = 352
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

event doubleclicked;// Al hacer el doubleclick se selecciona el renglon y se borra
integer li_Index
	li_Index = lb_1.SelectedIndex( )
	lb_1.DeleteItem(li_Index)
	lb_2.DeleteItem(li_Index)




end event

type cb_1x from commandbutton within w_relacion_titulos_profesiones
event type integer verifica ( )
event type integer verifica_2 ( string cuenta )
integer x = 1024
integer y = 112
integer width = 278
integer height = 109
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar"
end type

event type integer verifica();/* Se verifica que el alumno exista y que el digito verificador corresponda y que no se 
   encuentre en la lista*/

string Digito_X
string Digito
string Cuenta
long Cuenta_A
long Cuenta_B

Cuenta=em_1x.text
Digito_X=UPPER(mid(Cuenta,len(Cuenta),len(Cuenta)))
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
		
//			if f_alumno_restringido(Cuenta_A) then
//				if ib_usuario_especial then
//					MessageBox("Usuario  Autorizado", &
//					"Alumno con acceso restringido",Information!)		
//				else
//					MessageBox("Usuario NO Autorizado", &
//		           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
//					 +"Dirección de Servicios Escolares",StopSign!)
//					return 0
//				end if
//			end if  
			
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

event verifica_2;/* Se verifica que no se encuentre en la lista */
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

event constructor;TabOrder = 2
end event

type em_1x from editmask within w_relacion_titulos_profesiones
integer x = 501
integer y = 125
integer width = 475
integer height = 83
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###xxxxxx"
string displaydata = "Ä"
end type

event constructor;TabOrder = 1
end event

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

type cb_1 from commandbutton within w_relacion_titulos_profesiones
integer x = 3013
integer y = 170
integer width = 362
integer height = 109
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cargar"
end type

event clicked;
dw_1.event Carga()






end event

type dw_1 from datawindow within w_relacion_titulos_profesiones
event carga ( )
integer x = 77
integer y = 522
integer width = 3295
integer height = 790
integer taborder = 60
string dataobject = "d_relacion_titulos_profesiones"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga();string ls_fecha_inicial, ls_fecha_final, ls_gpo, ls_cuenta
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros, li_cve_constancia
long ll_cve_mat, ll_total, ll_cuentas[], ll_contador


ls_fecha_inicial= em_fecha_inicial.text
//ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
//ldt_fecha_final =date(ls_fecha_final)

ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)

if isnull(dw_1.DataObject) then
	return
end if
// Se obtienen los numeros de cuenta
ll_total=lb_2.totalitems()


if ll_total > 0 then
   ll_contador=1
	FOR ll_contador=1 TO ll_total
		ls_cuenta=lb_2.text(ll_contador)
		ll_cuentas[ll_contador]=long(ls_cuenta)
   
	NEXT
	li_num_registros= dw_1.retrieve(ll_cuentas, ldttm_fecha_inicial)

end if


end event

event constructor;SetTransObject(gtr_sce)
m_menu_reporte.dw = dw_1
end event

