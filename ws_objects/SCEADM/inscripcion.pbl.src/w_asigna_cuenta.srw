$PBExportHeader$w_asigna_cuenta.srw
$PBExportComments$Ventana con la que se les asigna número de cuenta a los alumnos nuevos
forward
global type w_asigna_cuenta from Window
end type
type ddlb_opcion from dropdownlistbox within w_asigna_cuenta
end type
type em_1 from editmask within w_asigna_cuenta
end type
type cb_1 from commandbutton within w_asigna_cuenta
end type
type uo_1 from uo_ver_per_ani within w_asigna_cuenta
end type
type dw_1 from uo_dw_reporte within w_asigna_cuenta
end type
end forward

global type w_asigna_cuenta from Window
int X=833
int Y=361
int Width=3694
int Height=1969
boolean TitleBar=true
string Title="Asignación de Números de Cuenta"
string MenuName="m_menu"
long BackColor=30976088
ddlb_opcion ddlb_opcion
em_1 em_1
cb_1 cb_1
uo_1 uo_1
dw_1 dw_1
end type
global w_asigna_cuenta w_asigna_cuenta

type variables

end variables

on w_asigna_cuenta.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.ddlb_opcion=create ddlb_opcion
this.em_1=create em_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.ddlb_opcion,&
this.em_1,&
this.cb_1,&
this.uo_1,&
this.dw_1}
end on

on w_asigna_cuenta.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_opcion)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type ddlb_opcion from dropdownlistbox within w_asigna_cuenta
int X=3123
int Y=41
int Width=398
int Height=229
int TabOrder=20
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"NORMAL",&
"DIFERIDOS"}
end type

type em_1 from editmask within w_asigna_cuenta
int X=2492
int Y=41
int Width=357
int Height=101
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="######"
string DisplayData=""
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_asigna_cuenta
int X=2894
int Y=33
int Width=183
int Height=109
int TabOrder=30
string Text="Asigna"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cont

for cont=1 to dw_1.rowcount()
	dw_1.object.general_cuenta[cont]=long(em_1.text)
	em_1.text=string(long(em_1.text)+1)
next
end event

type uo_1 from uo_ver_per_ani within w_asigna_cuenta
int X=5
int Y=5
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_asigna_cuenta
int X=42
int Y=201
int Width=3612
int Height=1589
int TabOrder=0
string DataObject="dw_asigna_cuenta"
end type

event actualiza;call super::actualiza;/*Cuando se dispara el evento actualiza...*/

/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	int respuesta
	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if respuesta = 1 &
		then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if update(true) = 1 then		
				/*Si es asi, guardalo en la tabla y avisa.*/
				commit using gtr_sadm;
				messagebox("Información","Se han guardado los cambios")			
			else
				/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using gtr_sadm;
				messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if	
end if	
end event

event carga;int opcion

event primero()

iF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=1
else
	opcion=0
END IF

return retrieve(gi_periodo,gi_anio,opcion)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

