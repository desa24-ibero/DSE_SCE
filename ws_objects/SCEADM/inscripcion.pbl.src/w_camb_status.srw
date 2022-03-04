$PBExportHeader$w_camb_status.srw
$PBExportComments$Usa el dw_camb_status y guarda los cambio en la bitácora bita_res
forward
global type w_camb_status from Window
end type
type uo_nombre from uo_nombre_aspirante within w_camb_status
end type
type dw_1 from datawindow within w_camb_status
end type
end forward

global type w_camb_status from Window
int X=5
int Y=5
int Width=3274
int Height=837
boolean TitleBar=true
string Title="Cambia Rechazados a Aceptados"
string MenuName="m_menu"
long BackColor=10789024
uo_nombre uo_nombre
dw_1 dw_1
end type
global w_camb_status w_camb_status

type variables
string salones[]
int num_salones
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_camb_status.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_nombre=create uo_nombre
this.dw_1=create dw_1
this.Control[]={ this.uo_nombre,&
this.dw_1}
end on

on w_camb_status.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_1)
end on

event open;x = 1
y = 1

dw_1.settransobject(gtr_sadm)

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = false
uo_nombre.cbx_nuevo.enabled = false
end event

event doubleclicked;dw_1.event carga(long(uo_nombre.em_cuenta.text))

end event

type uo_nombre from uo_nombre_aspirante within w_camb_status
event destroy ( )
int X=1
int Y=1
int TabOrder=11
boolean Enabled=true
long BackColor=1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante::destroy
end on

type dw_1 from datawindow within w_camb_status
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
int X=289
int Y=473
int Width=2661
int Height=185
string DataObject="dw_camb_status"
end type

event primero;event actualiza()
uo_nombre.event primero()
end event

event anterior;event actualiza()
uo_nombre.event anterior()
end event

event siguiente;event actualiza()
uo_nombre.event siguiente()
end event

event ultimo;event actualiza()
uo_nombre.event ultimo()
end event

event actualiza;long fol
int respuesta

/*Acepta el texto de la última columna editada*/

//OJO--->> w_camb_status.uo_nombre.dw_nombre_alumno.AcceptText()

AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount() > 0 Then
	/*Pregunta si se desean guardar los cambios hechos*/
	//respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
	respuesta=1
	if respuesta = 1 then
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
	end if /*respuesta = 1*/
end if /*ModifiedCount() > 0*/
end event

event carga;/*event actualiza()*/
return retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

event itemchanged;long columna,fol
int st_ant,st_act
datetime hoy

columna = getcolumn()

if columna=3 then

	hoy=datetime(today(),now())
	fol=object.folio[1]
	st_ant=object.status[1]
	st_act=integer(data)
	
	INSERT INTO bita_res
		( folio, clv_ver, clv_per, anio, fecha, status_ant, status_act, usuario )  
	VALUES ( :fol,:gi_version,:gi_periodo,:gi_anio,:hoy,:st_ant,:st_act,:gs_usuario) 
	using gtr_sadm;
	commit using gtr_sadm;

	event actualiza()
	
end if
end event

event constructor;m_menu.dw = this

DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

