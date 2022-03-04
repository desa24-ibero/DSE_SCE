$PBExportHeader$w_inscripcion.srw
$PBExportComments$Ventana para la asignación de paquetes de horarios a los aceptados. (uno por uno)
forward
global type w_inscripcion from window
end type
type uo_nombre from uo_nombre_aspirante_p_insc within w_inscripcion
end type
type dw_1 from datawindow within w_inscripcion
end type
type dw_2 from datawindow within w_inscripcion
end type
type dw_3 from datawindow within w_inscripcion
end type
end forward

global type w_inscripcion from window
integer x = 5
integer y = 8
integer width = 3378
integer height = 1992
boolean titlebar = true
string title = "Inscripción de Aceptados"
string menuname = "m_menu"
long backcolor = 10789024
uo_nombre uo_nombre
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global w_inscripcion w_inscripcion

type variables
string salones[]
int num_salones


long il_cve_coordinacion, il_cve_carrera
string is_carrera

Transaction itr_parametros_iniciales
transaction itr_web
n_tr itr_seguridad, itr_original
//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

string is_nivel = "A"
n_transfiere_sybase_sql in_transfiere_sybase_sql
long il_array_cuentas[]
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_inscripcion.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_nombre=create uo_nombre
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.Control[]={this.uo_nombre,&
this.dw_1,&
this.dw_2,&
this.dw_3}
end on

on w_inscripcion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;datetime ldttm_fecha_servidor, ldttm_fecha_inicial
u_datastore lds_origen, lds_destino, lds_origen2, lds_destino2
string ls_dataobject_paquetes, ls_dataobject_paquetes_materias
long ll_actualiza_datastore, ll_actualiza_datastore2, ll_rows, ll_rows2
integer li_inserta_paquetes, li_inserta_paquetes_materias
ls_dataobject_paquetes          = 'd_bit_paquetes_sql_sybase'
ls_dataobject_paquetes_materias = 'd_bit_paquetes_materias_sql_sybase'

this.x = 1
this.y = 1


uo_nombre.cbx_nuevo.visible = false
uo_nombre.cbx_nuevo.enabled = false

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)
dw_3.settransobject(gtr_sadm)

int li_chk
integer  li_obten_server_bd
string ls_tipo_server

li_obten_server_bd = f_obten_tipo_server_bd(gtr_sce,'controlescolar_bd',ls_tipo_server)

if li_obten_server_bd<> 1 then
	MessageBox("Error de Inscripcion",'No es posible validar el tipo de Inscripción', StopSign!)
	this.event close()
	return 
end if	

if ls_tipo_server <> 'SYBASE' THEN
	MessageBox("A punto de Actualizar paquetes", "Presione el botón para Continuar",Information!)

	itr_parametros_iniciales = gtr_sce

	li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,itr_web,is_controlescolar_cnx,gs_usuario,gs_password,1)
	if li_chk <> 1 then return

	in_transfiere_sybase_sql =  create n_transfiere_sybase_sql

	ldttm_fecha_servidor = fecha_servidor(gtr_sce)

	ldttm_fecha_inicial = datetime(ldttm_fecha_servidor)

	
	lds_origen = create u_datastore
	lds_destino = create u_datastore
	
	lds_origen.dataobject = ls_dataobject_paquetes
	lds_destino.dataobject = ls_dataobject_paquetes

	lds_origen.SetTransObject(itr_web)
	lds_destino.SetTransObject(gtr_sadm)

	ll_rows = lds_origen.Retrieve(9999)
	ll_rows2= lds_destino.Retrieve(9999)
	if ll_rows<> -1 then
		ll_actualiza_datastore = in_transfiere_sybase_sql.of_delete_insert_datastore(lds_origen, lds_destino, itr_web, gtr_sadm)
		li_inserta_paquetes = f_inserta_paquetes()
		if li_inserta_paquetes= -1 then
			MessageBox("Error de Actualización","No es posible realizar la inserción de los paquetes",StopSign!)
			return
		end if
	else
		MessageBox("Error de Actualización","No es posible realizar la actualización de los paquetes",StopSign!)
		return
	end if

	lds_origen2 = create u_datastore
	lds_destino2 = create u_datastore
	
	lds_origen2.dataobject = ls_dataobject_paquetes_materias
	lds_destino2.dataobject = ls_dataobject_paquetes_materias

	lds_origen2.SetTransObject(itr_web)
	lds_destino2.SetTransObject(gtr_sadm)

	ll_rows = lds_origen2.Retrieve(9999)
	ll_rows2= lds_destino2.Retrieve(9999)
	if ll_rows<> -1 then
		ll_actualiza_datastore2 = in_transfiere_sybase_sql.of_delete_insert_datastore(lds_origen2, lds_destino2, itr_web, gtr_sadm)
		li_inserta_paquetes_materias = f_inserta_paquetes_materias()
		if li_inserta_paquetes_materias= -1 then
			MessageBox("Error de Actualización","No es posible realizar la inserción de los paquetes_materias",StopSign!)
			return
		end if
	else
		MessageBox("Error de Actualización","No es posible realizar la actualización de los paquetes_materias",StopSign!)
		return
	end if

	if li_inserta_paquetes<> -1 and li_inserta_paquetes_materias<> -1 then
		MessageBox("Actualización Exitosa","Se realizo la actualización de los paquetes y paquetes_materias exitosamente",Information!)
		return
	end if

else
	MessageBox("No es necesario actualizar paquetes", "Presione el botón para Continuar",Information!)
end if


end event

event doubleclicked;dw_2.event carga(long(uo_nombre.em_cuenta.text))
end event

type uo_nombre from uo_nombre_aspirante_p_insc within w_inscripcion
integer width = 3241
integer taborder = 20
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_aspirante_p_insc::destroy
end on

event constructor;call super::constructor;m_menu.objeto=this
end event

type dw_1 from datawindow within w_inscripcion
integer x = 3369
integer y = 60
integer width = 832
integer height = 940
string dataobject = "dw_salonxcarrera"
boolean livescroll = true
end type

event retrieverow;num_salones=num_salones+1
salones[num_salones]=object.salon[row]

end event

type dw_2 from datawindow within w_inscripcion
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
integer x = 9
integer y = 436
integer width = 1440
integer height = 176
string dataobject = "dw_inscripcion"
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

event actualiza;AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()> 0 Then
	if update(true) = 1 then
		commit using gtr_sadm;
	else
		rollback using gtr_sadm;
	end if
end if /*ModifiedCount() > 0*/
end event

event carga;/*event actualiza()*/
return retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

event constructor;m_menu.dw = this
end event

event retrieveend;long fol
int carr

if rowcount>0 then

	fol=object.folio[1]
	
	SELECT bita_carr.carr_act
	INTO :carr
	FROM bita_carr
	WHERE ( bita_carr.folio = :fol ) AND
		( bita_carr.clv_ver = :gi_version ) AND
		( bita_carr.clv_per = :gi_periodo ) AND
		( bita_carr.anio = :gi_anio )
	ORDER BY bita_carr.fecha DESC
	USING gtr_sadm;

	if gtr_sadm.SQLCode = 100 then
		dw_3.event carga(object.clv_carr[1])
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
	else 
		dw_3.event carga(carr)
	End If	
	
else
	dw_3.event carga(0)
end if
end event

event doubleclicked;int num_paq
if row>0 then
	
	num_paq=object.num_paq[1]
	UPDATE paquetes
	SET inscritos = inscritos-1
	WHERE paquetes.num_paq = :num_paq
	USING gtr_sadm;
	
	object.num_paq[1]=0
	object.status[1]=1
	event actualiza()
	dw_2.event siguiente()
end if
end event

type dw_3 from datawindow within w_inscripcion
event carga ( integer carr )
event actualiza ( )
integer x = 9
integer y = 652
integer width = 3346
integer height = 1148
string dataobject = "dw_paqxcarr"
boolean vscrollbar = true
boolean livescroll = true
end type

event carga;if retrieve(carr)=0 and carr>0 then
	string carrera
	SELECT carreras.carrera
	INTO :carrera
	FROM carreras
	WHERE carreras.cve_carrera = :carr
	USING gtr_sce;
	messagebox("No hay paquetes asignados para la carrera",carrera)
end if

end event

event actualiza;long fol
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()> 0 Then
	if update(true) = 1 then
		commit using gtr_sadm;
	else
		rollback using gtr_sadm;
	end if
end if /*ModifiedCount() > 0*/
end event

event constructor;m_menu.dw = this

DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild plan
getchild("clv_plan",plan)
plan.settransobject(gtr_sce)
plan.retrieve()

end event

event doubleclicked;int num_paq, li_num_paq, li_respuesta


if row>0 then
	if object.cupo[row]>object.inscritos[row] then
		li_num_paq= dw_2.object.num_paq[1]
		
		if dw_2.object.num_paq[1]<>object.num_paq[row] then
//Confirma si se desea cambiar
			if li_num_paq> 0 then
				li_respuesta= MessageBox("Numero de paquete existente","¿Esta usted seguro de cambiar el paquete de este aspirante?",Question!, YesNo! )  
				if li_respuesta <> 1 then
					return
				end if
			end if
				
				num_paq=dw_2.object.num_paq[1]
				if num_paq>0 then
					UPDATE paquetes
					SET inscritos = inscritos-1
					WHERE paquetes.num_paq = :num_paq
					USING gtr_sadm;
				end if

				object.inscritos[row]=object.inscritos[row]+1
				event actualiza()
				dw_2.object.num_paq[1]=object.num_paq[row]
				dw_2.object.status[1]=2
				dw_2.event actualiza()
				dw_2.event siguiente()
				
			
		end if	
	end if
end if
end event

