$PBExportHeader$w_pago_examen.srw
$PBExportComments$En esta ventana se puede elegir el FOLIO del aspirante que esta pagando su examen.
forward
global type w_pago_examen from Window
end type
type dw_1 from datawindow within w_pago_examen
end type
type uo_nombre from uo_nombre_aspirante within w_pago_examen
end type
end forward

global type w_pago_examen from Window
int X=5
int Y=5
int Width=3255
int Height=817
boolean TitleBar=true
string Title="Pagos de Exámenes"
string MenuName="m_menu"
long BackColor=10789024
dw_1 dw_1
uo_nombre uo_nombre
end type
global w_pago_examen w_pago_examen

type variables
string salones[]
int num_salones
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_pago_examen.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.uo_nombre=create uo_nombre
this.Control[]={ this.dw_1,&
this.uo_nombre}
end on

on w_pago_examen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.uo_nombre)
end on

event open;x = 1
y = 1

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = false
uo_nombre.cbx_nuevo.enabled = false
end event

event doubleclicked;dw_1.event carga(long(uo_nombre.em_cuenta.text))
end event

event close;dw_1.event actualiza()
end event

type dw_1 from datawindow within w_pago_examen
event constructor pbm_constructor
event itemchanged pbm_dwnitemchange
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
int X=1107
int Y=453
int Width=1025
int Height=177
int TabOrder=20
string DataObject="dw_pago_examen"
end type

event constructor;m_menu.dw = this
settransobject(gtr_sadm)
end event

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

event actualiza;int respuesta
datetime hoy
long fol

AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount() > 0 Then
	/*Pregunta si se desean guardar los cambios hechos*/
	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
	if respuesta = 1 then
		/*Checa que los renglones cumplan con las reglas de validación*/
		if update(true) = 1 then
			/*Si es asi, guardalo en la tabla y avisa.*/

		fol=object.folio[1]
		
		hoy=datetime(today(),Time("01:01:00"))
	   UPDATE bita_bachi  
      SET fecha = :hoy,   
          usuario = :gs_usuario
    WHERE ( bita_bachi.folio = :fol ) AND  
          ( bita_bachi.clv_ver = :gi_version ) AND  
          ( bita_bachi.clv_per = :gi_periodo ) AND  
          ( bita_bachi.anio = :gi_anio ) AND
			 ( isnull(bita_bachi.anterior,0)=0 )
		USING gtr_sadm;	
			
			commit using gtr_sadm;
			messagebox("Información","Se han guardado los cambios")			
		else
			/*De lo contrario, desecha los cambios (todos) y avisa*/
			rollback using gtr_sadm;
			messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
		end if
	end if /*respuesta=1*/ 
end if /*ModifiedCount()> 0*/
end event

event carga;event actualiza()
return retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

type uo_nombre from uo_nombre_aspirante within w_pago_examen
event destroy ( )
int X=1
int Y=1
int TabOrder=10
boolean Enabled=true
long BackColor=1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante::destroy
end on

