$PBExportHeader$w_cap_mat_preinsc.srw
$PBExportComments$Captura Manual de Materias Preinscritas
forward
global type w_cap_mat_preinsc from w_ancestral
end type
type dw_cap_mat_preinsc from uo_dw_captura within w_cap_mat_preinsc
end type
type uo_1 from uo_per_ani within w_cap_mat_preinsc
end type
type uo_nombre from uo_nombre_alu_foto within w_cap_mat_preinsc
end type
end forward

global type w_cap_mat_preinsc from w_ancestral
integer width = 3653
integer height = 2220
string title = "Captura Manual de Materias Preinscritas"
string menuname = "m_menu"
event inicia_proceso ( )
dw_cap_mat_preinsc dw_cap_mat_preinsc
uo_1 uo_1
uo_nombre uo_nombre
end type
global w_cap_mat_preinsc w_cap_mat_preinsc

type variables
long il_cuenta
transaction itr_web
end variables

event inicia_proceso;call super::inicia_proceso;/*
DESCRIPCIÓN: Cuando se capture el número de cuenta, carga en dw_cap_mat_preinsc las materias
				 que tenga preinscritas.
PARÁMETROS: Message.LongParm
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

il_cuenta=Message.LongParm
dw_cap_mat_preinsc.retrieve(il_cuenta,gi_periodo,gi_anio)
end event

event open;/*
DESCRIPCIÓN: Pon la ventana en el extremo.
				 Liga dw_cap_mat_preinsc a sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

x=1
y=1

dw_cap_mat_preinsc.settransobject(gtr_sce)
if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
	end if
end if
gi_numscob++

periodo_actual(gi_periodo,gi_anio,gtr_sce)
gi_periodo++
if gi_periodo=3 then
	gi_periodo=0
	gi_anio++
end if

//if conecta_bd(itr_web,gs_sweb, "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_cap_mat_preinsc.SetTransObject(itr_web)
end if

end event

on w_cap_mat_preinsc.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_cap_mat_preinsc=create dw_cap_mat_preinsc
this.uo_1=create uo_1
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cap_mat_preinsc
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_nombre
end on

on w_cap_mat_preinsc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_cap_mat_preinsc)
destroy(this.uo_1)
destroy(this.uo_nombre)
end on

event close;if gi_numscob = 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if
gi_numscob --


if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

end event

type p_uia from w_ancestral`p_uia within w_cap_mat_preinsc
end type

type dw_cap_mat_preinsc from uo_dw_captura within w_cap_mat_preinsc
event type integer actualiza ( )
event nuevo ( )
event inicia_transaction_object ( )
integer x = 0
integer y = 604
integer width = 3547
integer height = 1388
integer taborder = 0
string dataobject = "d_cap_mat_preinsc"
end type

event type integer actualiza();/*
DESCRIPCIÓN: Antes de guardar los cambios hechos, verifica el status de las materias.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
int li_status,li_carr,li_plan,li_respuesta
long ll_clave,ll_renglon
string ls_grupo,ls_nivel

SELECT academicos.cve_carrera,academicos.cve_plan,academicos.nivel
INTO :li_carr,:li_plan,:ls_nivel
FROM academicos
WHERE academicos.cuenta = :il_cuenta
USING gtr_sce;

FOR ll_renglon=1 TO rowcount()
	ll_clave=object.cve_mat[ll_renglon]
	if gi_periodo=object.periodo[ll_renglon] and gi_anio=object.anio[ll_renglon] then
		ls_grupo=object.gpo[ll_renglon]	
		li_status=f_e_mat(ll_clave)
		li_status=f_e_grup(ll_clave,ls_grupo)+li_status
		li_status=f_e_plan(ls_nivel,li_carr,li_plan,ll_clave)+li_status
		li_status=f_no_curso(il_cuenta,ll_clave)+li_status
		li_status=f_puede_integracion(il_cuenta,ll_clave)+li_status
		li_status=f_puede_cursar(il_cuenta,ll_clave,li_carr,li_plan)+li_status
		object.status[ll_renglon]=li_status
	end if
NEXT

/*Acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if update(true) = 1 then		
				/*Si es asi, guardalo en la tabla y avisa.*/
				commit using itr_web;
				messagebox("Información","Se han guardado los cambios")
				return 1
			else
				/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using itr_web;
				messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
				return -1
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		return 1
	end if
else
	return 1
end if
end event

event nuevo;call super::nuevo;/*
DESCRIPCIÓN: Cuando el usuario pida una materia nueva, inicializa el número de cuenta,
				 el periodo y el año.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_renglon

ll_renglon=rowcount()

object.cuenta[ll_renglon]=il_cuenta
object.periodo[ll_renglon]=gi_periodo
object.anio[ll_renglon]=gi_anio
end event

event inicia_transaction_object();call super::inicia_transaction_object;tr_dw_propio = itr_web
end event

type uo_1 from uo_per_ani within w_cap_mat_preinsc
integer x = 14
integer y = 432
integer width = 1253
integer height = 168
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_nombre from uo_nombre_alu_foto within w_cap_mat_preinsc
integer x = 5
integer height = 428
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alu_foto::destroy
end on

