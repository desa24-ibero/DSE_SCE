$PBExportHeader$w_cambio_periodo_ingreso_base_ingreso.srw
forward
global type w_cambio_periodo_ingreso_base_ingreso from Window
end type
type em_ani from editmask within w_cambio_periodo_ingreso_base_ingreso
end type
type vsb_dw_per from vscrollbar within w_cambio_periodo_ingreso_base_ingreso
end type
type dw_per from datawindow within w_cambio_periodo_ingreso_base_ingreso
end type
type ddlb_1 from dropdownlistbox within w_cambio_periodo_ingreso_base_ingreso
end type
type uo_1 from uo_ver_per_ani within w_cambio_periodo_ingreso_base_ingreso
end type
type dw_1 from uo_dw_captura within w_cambio_periodo_ingreso_base_ingreso
end type
end forward

global type w_cambio_periodo_ingreso_base_ingreso from Window
int X=834
int Y=362
int Width=3672
int Height=1958
boolean TitleBar=true
string Title="Cambio de Periodo de Ingreso por Periodo Sustentacion"
string MenuName="m_menu"
long BackColor=30976088
em_ani em_ani
vsb_dw_per vsb_dw_per
dw_per dw_per
ddlb_1 ddlb_1
uo_1 uo_1
dw_1 dw_1
end type
global w_cambio_periodo_ingreso_base_ingreso w_cambio_periodo_ingreso_base_ingreso

type variables
int ord
end variables

on w_cambio_periodo_ingreso_base_ingreso.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_ani=create em_ani
this.vsb_dw_per=create vsb_dw_per
this.dw_per=create dw_per
this.ddlb_1=create ddlb_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.em_ani,&
this.vsb_dw_per,&
this.dw_per,&
this.ddlb_1,&
this.uo_1,&
this.dw_1}
end on

on w_cambio_periodo_ingreso_base_ingreso.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_ani)
destroy(this.vsb_dw_per)
destroy(this.dw_per)
destroy(this.ddlb_1)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type em_ani from editmask within w_cambio_periodo_ingreso_base_ingreso
event modified pbm_enmodified
int X=2245
int Y=48
int Width=347
int Height=102
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
boolean AutoSkip=true
boolean Spin=true
string DisplayData=""
double Increment=1
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(gi_anio)
end event

type vsb_dw_per from vscrollbar within w_cambio_periodo_ingreso_base_ingreso
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
int X=3306
int Y=45
int Width=106
int Height=106
boolean Enabled=false
boolean BringToTop=true
boolean StdWidth=false
int MinPosition=1
int Position=1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
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
maxposition=dw_per.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_per.ScrollToRow(scrollpos)
	

end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
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

type dw_per from datawindow within w_cambio_periodo_ingreso_base_ingreso
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
int X=2670
int Y=45
int Width=625
int Height=106
string DataObject="dw_periodo"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(gtr_sadm)
retrieve()
scrolltorow(gi_periodo+1)
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_per.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_per.position=currentrow

end if
end event

type ddlb_1 from dropdownlistbox within w_cambio_periodo_ingreso_base_ingreso
int X=1576
int Y=45
int Width=347
int Height=230
boolean VScrollBar=true
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Cuenta",&
"Folio",&
"Nombre"}
end type

event selectionchanged;CHOOSE CASE index
	CASE 1
		dw_1.SetSort("general_cuenta")
		dw_1.Sort( ) 
	CASE 2
		dw_1.SetSort("aspiran_folio")
		dw_1.Sort( ) 
	CASE 3
		dw_1.SetSort("nomb")
		dw_1.Sort( ) 
END CHOOSE

end event

type uo_1 from uo_ver_per_ani within w_cambio_periodo_ingreso_base_ingreso
int X=0
int Y=16
int Width=1251
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_cambio_periodo_ingreso_base_ingreso
int X=22
int Y=202
int Width=3606
int Height=1558
int TabOrder=0
string DataObject="d_cambio_periodo_ingreso_base_ingreso"
boolean HScrollBar=true
end type

event carga;/*Antes de cargar algo, ve si hay modificaciones no guardadas*/
event primero()
return retrieve(gi_periodo,gi_anio)
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event actualiza;/**/
return 0
end event

event borra;/**/
end event

event nuevo;/**/
end event

event doubleclicked;int nvo_anio,nvo_peri,clv_carr,estado,lugar_nac,nacional,edo_civil
int religion,bachillera,trabajo,trab_hor,ya_inscri,transporte,pago_insc, li_num_padres
long folio,cuenta, ll_cuenta
real puntaje,promedio
string nombre,apaterno,amaterno,calle,codigo_pos,colonia,telefono,sexo, ls_sexo_padre
datetime fecha_nac,hoy
int li_codigo_sql, li_cambio_periodo
string ls_mensaje_sql

hoy=datetime(today(),now())

IF row>0 THEN
	ok = messagebox("Folio: "+string(object.aspiran_folio[row])+' '+object.nomb[row],&
		"Con número de Cuenta: "+string(object.general_cuenta[row]),Exclamation!, OKCancel!, 2)
	IF ok = 1 THEN 
		ll_cuenta = object.general_cuenta[row]
		folio=object.aspiran_folio[row]
		nvo_anio=integer(em_ani.text)
		nvo_peri=dw_per.object.clv_per[dw_per.getrow()]
		IF nvo_anio=gi_anio and nvo_peri=gi_periodo THEN
			messagebox("Periodo destino repetido","Es necesario modificar al anio y periodo destino",StopSign!)
			RETURN
		ELSE
			li_codigo_sql = f_existe_alumno(ll_cuenta)
			IF li_codigo_sql= 100 THEN
				MessageBox("El alumno no existe en control escolar","Es necesario realizar el enlace del alumno antes de cambiar su periodo de ingreso",StopSign!)
				RETURN
			ELSEIF li_codigo_sql= -1 THEN
				MessageBox("Error al consultar academicos","No es posible cambiar su periodo de ingreso",StopSign!)				
				RETURN
			END IF				
			li_cambio_periodo= f_apartado_lugar_cob(ll_cuenta, gi_periodo, gi_anio, nvo_peri, nvo_anio)
			IF li_cambio_periodo= 0 THEN
				MessageBox("Cambio Exitoso","El alumno ha cambiado de periodo exitosamente",Information!)
				RETURN
			ELSEIF li_cambio_periodo= -1 THEN
				MessageBox("Error al cambiar de periodo","No es posible efectuar el cambio",StopSign!)
				RETURN
			END IF				
		END IF		
	END IF

END IF
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

