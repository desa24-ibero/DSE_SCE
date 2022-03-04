$PBExportHeader$w_codigospostal.srw
$PBExportComments$Se cargará el código postal para agilizar la captura de las direcciones.
forward
global type w_codigospostal from w_catalogo
end type
type sle_cod_pos from singlelineedit within w_codigospostal
end type
type st_1 from statictext within w_codigospostal
end type
type vsb_dw_codigo_postal from vscrollbar within w_codigospostal
end type
type st_cuenta from statictext within w_codigospostal
end type
type st_2 from statictext within w_codigospostal
end type
end forward

global type w_codigospostal from w_catalogo
int Width=3168
int Height=1400
boolean TitleBar=true
string Title="Catalogo de Códigos Postales"
long BackColor=30976088
sle_cod_pos sle_cod_pos
st_1 st_1
vsb_dw_codigo_postal vsb_dw_codigo_postal
st_cuenta st_cuenta
st_2 st_2
end type
global w_codigospostal w_codigospostal

type variables
string is_cod_pos
end variables

on w_codigospostal.create
int iCurrent
call super::create
this.sle_cod_pos=create sle_cod_pos
this.st_1=create st_1
this.vsb_dw_codigo_postal=create vsb_dw_codigo_postal
this.st_cuenta=create st_cuenta
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_cod_pos
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.vsb_dw_codigo_postal
this.Control[iCurrent+4]=this.st_cuenta
this.Control[iCurrent+5]=this.st_2
end on

on w_codigospostal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_cod_pos)
destroy(this.st_1)
destroy(this.vsb_dw_codigo_postal)
destroy(this.st_cuenta)
destroy(this.st_2)
end on

event activate;/* En cuanto se active la ventana w_codigospostal ... */

/* SE DEBE DESHABILITAR EL SCRIPT DEL PADRE */

/* Cambia el título del Sheet */

control_escolar.toolbarsheettitle="Catálogo de Códigos Postales"
end event

event open;/* En cuanto se abra la ventana w_codigopostal... */

/* SE DEBE DESHABILITAR EL SCRIPT DEL PADRE!!!! */

/* Asocia la fuente de datos de dw_catalogo a la base default */
dw_catalogo.settransobject(gtr_sce)

/* Inicia cargando TODOS los renglones de la tabla código postal 
	(comentario al respecto alla abajo...) */
if dw_catalogo.retrieve("0")=0 then
	dw_catalogo.InsertRow(0)
	vsb_dw_codigo_postal.maxposition=0
	st_cuenta.text='Vacío...'

end if

/* Configura el VerticalScrollBar para que su máximo sea igual al número de renglones
	obtenidos */
vsb_dw_codigo_postal.maxposition=dw_catalogo.RowCount()

/* Inicia el StaticText que lleva la cuenta, dice el número de renglones del DataWindow y
	cual es el que se está viendo */
st_cuenta.text=string(dw_catalogo.GetRow())+' de '+&
	string(dw_catalogo.RowCount())

/* Actualiza el Single Line Edit */
sle_cod_pos.text=string(dw_catalogo.Object.Data[dw_catalogo.GetRow(),1])

	
/* Ubica la ventana en la parte  superior derecha del área del cliente */
this.x=1
this.y=1


/*
		¿Como estoy bajando todos los renglones de la tabla de códigos postales al paserle 
		como parámetro el Código Postal?
		
	SELECT codigo_postal.cod_postal,   
   	codigo_postal.colonia,   
      codigo_postal.ciudad,   
      estados.estado,   
      codigo_postal.cve_estado,   
      estados.cve_estado  
	FROM codigo_postal, estados  
	WHERE ( codigo_postal.cve_estado = estados.cve_estado ) and  
         ( ( :cp = 0 ) OR  
         ( codigo_postal.cod_postal = :cp ) )   
	ORDER BY codigo_postal.cod_postal ASC,   
         codigo_postal.colonia ASC   

-	La primera línea del Where es un Join sencillo con la tabla de Estados.

-	En la segunda y tercera se realiza un OR que se asocia con la primera con un AND.

-	Así si se cumple que :cp=0 (cp es el parámetro código postal que le mando) ya no
	se realiza la tercera.

-	Si por el contrario, :cp es diferente de 0 entonces se intenta satisfacer la tercera 
	línea; cod_postal=:cp que es lo que se hace regularmente.
*/

//g_nv_security.fnv_secure_window (this)

end event

type dw_catalogo from w_catalogo`dw_catalogo within w_codigospostal
event botonazo pbm_dwnkey
int X=119
int Y=288
int Width=2839
int Height=708
int TabOrder=20
string DataObject="dw_codigo_postal"
boolean VScrollBar=false
end type

event dw_catalogo::botonazo;call super::botonazo;IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=4 then
			setcolumn(1)
			SetFocus()
			return -1
		end if
	END IF
END IF

IF keyflags  = 0 THEN
	IF key = KeyEnter! THEN
		if update(true) = 1 then
			setcolumn(1)
			SetFocus()
		else
			return -1
		end if
	END IF
END IF

IF keyflags  = 1 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=1 then
			setcolumn(4)
			SetFocus()
			return -1
		end if	
	END IF
END IF

end event

event dw_catalogo::rowfocuschanged;call super::rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_codigo_postal.maxposition=dw_catalogo.RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_codigo_postal.position=GetRow()

	/* Actualiza el StaticText */
	st_cuenta.text=string(GetRow())+' de '+string(RowCount())
	
	/* Actualiza el Single Line Edit */
	//sle_cod_pos.text=string(Object.Data[GetRow(),1])
end if


end event

event dw_catalogo::itemchanged;call super::itemchanged;if GetColumn()=1 then
	insertrow(0)
end if
end event

event dw_catalogo::retrieveend;call super::retrieveend;if rowcount>1 then
	vsb_dw_codigo_postal.visible=TRUE
else
	vsb_dw_codigo_postal.visible=FALSE
end if
end event

event dw_catalogo::dberror;call super::dberror;return -1
end event

type sle_cod_pos from singlelineedit within w_codigospostal
int X=1463
int Y=72
int Width=274
int Height=92
int TabOrder=10
boolean BringToTop=true
boolean AutoHScroll=false
int Limit=6
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;/* En cuanto el usuario escriba algo en el SingleLineEdit cod_pos... */

/* Transforma la entrada del usuario al tipo long y guardala en la variable de instancia 
	tipo long li_cod_pos */
is_cod_pos=sle_cod_pos.text
dw_catalogo.AcceptText()
/* Ve si se deben salvar  cambios */
int resp
if dw_catalogo.modifiedcount() > 0 or dw_catalogo.deletedcount() > 0 then
	resp = messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesnocancel!)
	choose case resp
		case 1 
			m_catalogo.m_registro.m_actualiza.triggerevent(clicked!)			
		case 2
			dw_catalogo.resetupdate()
	end choose
end if

if resp<>3 then
	/* Carga dentro del DataWindow dw_catalogo los datos del código postal seleccionado */
	/* Si no existe el código, agrega un renglón para ver si el usuario quiere insertarlo */
	if dw_catalogo.retrieve(is_cod_pos) = 0 then
	//este codigo postal no existe
		dw_catalogo.SetFocus()
		dw_catalogo.insertrow(0)
		dw_catalogo.Object.Data[dw_catalogo.GetRow(),1]=sle_cod_pos.text
		dw_catalogo.SetColumn(2)
	
		vsb_dw_codigo_postal.maxposition=0
		st_cuenta.text='Agrega...'
		dw_catalogo.insertrow(0)

	else
		/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
		vsb_dw_codigo_postal.maxposition=dw_catalogo.RowCount()

		/* Modifica el texto estático para los nuevos datos obtenidos */
		st_cuenta.text=string(dw_catalogo.GetRow())+' de '+&
			string(vsb_dw_codigo_postal.maxposition)
	
		/* Actualiza el Single Line Edit */
		sle_cod_pos.text=string(dw_catalogo.Object.Data[dw_catalogo.GetRow(),1])
	end if
end if
end event

event getfocus;selecttext(1,len(text))
end event

type st_1 from statictext within w_codigospostal
int X=910
int Y=72
int Width=448
int Height=92
boolean Enabled=false
boolean Border=true
string Text="Código Postal:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=10789024
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type vsb_dw_codigo_postal from vscrollbar within w_codigospostal
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
int X=2994
int Y=280
int Width=73
int Height=720
boolean Enabled=false
boolean BringToTop=true
int MinPosition=1
int Position=1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_catalogo.RowCount() then
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

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_catalogo.RowCount() then
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

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
vsb_dw_codigo_postal.maxposition=dw_catalogo.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_catalogo.ScrollToRow(scrollpos)

/* Actualiza el StaticText para mostrar el cambio debido al movimiento */
st_cuenta.text=string(dw_catalogo.GetRow())+' de '+&
	string(dw_catalogo.RowCount())
	
/* Actualiza el Single Line Edit */
	sle_cod_pos.text=string(dw_catalogo.Object.Data[dw_catalogo.GetRow(),1])
end event

event constructor;visible=FALSE
end event

type st_cuenta from statictext within w_codigospostal
int X=2715
int Y=160
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_codigospostal
int X=1819
int Y=80
int Width=891
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="0 Para Mostrar Lista Completa"
boolean FocusRectangle=false
long BackColor=30976088
long BorderColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

