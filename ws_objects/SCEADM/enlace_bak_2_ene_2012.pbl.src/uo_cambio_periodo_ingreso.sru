$PBExportHeader$uo_cambio_periodo_ingreso.sru
forward
global type uo_cambio_periodo_ingreso from nonvisualobject
end type
end forward

global type uo_cambio_periodo_ingreso from nonvisualobject
end type
global uo_cambio_periodo_ingreso uo_cambio_periodo_ingreso

forward prototypes
public function boolean uof_liberacion_vigente (string as_sistema, transaction at_transaction)
public function integer uof_existe_alumno (long al_cuenta, transaction at_transaction)
public function integer uof_apartado_lugar_cob_sit (long al_cuenta, integer ai_periodo_pago, integer ai_anio_pago, integer ai_periodo_apartado, integer ai_anio_apartado, transaction at_transaction_tes, transaction at_transaction_sce)
end prototypes

public function boolean uof_liberacion_vigente (string as_sistema, transaction at_transaction);//of_liberacion_vigente
//Recibe 	as_sistema
//Devuelve	booleano que indica si existe una liberacion en curso

String		ls_nombre_servidor, ls_nombre_base_datos, ls_mensaje_sql
Integer	li_codigo_sql, li_liberacion_vigente

as_sistema= upper(as_sistema)

SELECT	COUNT(*)
INTO		:li_liberacion_vigente
FROM		parametros_liberacion
WHERE	sistema = :as_sistema
AND		liberacion_vigente = 1
USING	at_transaction;

ls_mensaje_sql	= at_transaction.SqlErrtext
li_codigo_sql	= at_transaction.SqlCode

IF li_codigo_sql= -1 THEN
	MessageBox("No es posible consultar los parametros de liberacion", ls_mensaje_sql, StopSign!)
	gb_liberacion_vigente = false
	RETURN  False
ELSEIF  li_codigo_sql = 100 THEN
	gb_liberacion_vigente = false
	Return False
ELSE
	IF li_liberacion_vigente>0 THEN
		gb_liberacion_vigente = true
		RETURN True
	ELSE
		gb_liberacion_vigente = false
		RETURN False
	END IF
END IF
end function

public function integer uof_existe_alumno (long al_cuenta, transaction at_transaction);/*
f_existe_alumno
Recibe 	:	al_cuenta	long
Devuelve : 0 Existe el alumno
			100 No existe el alumno
			 -1 Error al consultar

at_transaction			transaction
*/

Long		ll_cuenta
Int			li_codigo_sql
String		ls_mensaje

SELECT	cuenta 
INTO		:ll_cuenta
FROM		controlescolar_bd.dbo.academicos ac
WHERE	ac.cuenta = :al_cuenta
USING	at_transaction;

li_codigo_sql = at_transaction.SqlCode

ls_mensaje = at_transaction.SqlErrText

IF li_codigo_sql = -1 THEN
	MessageBox ( "Error al consultar academicos" , ls_mensaje , StopSign! )
END IF

RETURN li_codigo_sql
end function

public function integer uof_apartado_lugar_cob_sit (long al_cuenta, integer ai_periodo_pago, integer ai_anio_pago, integer ai_periodo_apartado, integer ai_anio_apartado, transaction at_transaction_tes, transaction at_transaction_sce);/*
f_apartado_lugar_cob_sit
Recibe:	al_cuenta				long
			ai_periodo_pago		int
			ai_anio_pago			int
			ai_periodo_apartado	int
			ai_anio_apartado		int
			at_transaction_tes			transaction
			
Nota:		Utiliza la transaccion que conecta a a controlescolar_bd: at_transaction_sce
*/

Int			li_existe_alumno, li_codigo_error, li_codigo_error_exec, li_exito, li_res_admision, li_res_control
String		ls_mensaje, ls_mensaje_exec, ls_mensaje_titulo, ls_periodo_pago
Int			li_anio_pago_cob, li_anio_apartado_cob
String		ls_mensaje_control, ls_mensaje_admision, ls_mensaje_out
String		ls_mensaje_aportacion, ls_mensaje_inscripcion
Int			li_periodo_pago, li_periodo_apartado

li_existe_alumno = uof_existe_alumno ( al_cuenta , at_transaction_sce  )
li_exito= 0

IF  li_existe_alumno= 0 THEN

	ls_mensaje_titulo = "Cuenta: ["+string(al_cuenta)+"] ~n" +&
								"Periodo Pago: ["+string(ai_periodo_pago)+"] ~n"+&
								"Anio Pago: ["+string(ai_anio_pago)+"] ~n"+&
								"Periodo Apartado: ["+string(ai_periodo_apartado)+"] ~n"+&
								"Anio Apartado: ["+string(ai_anio_apartado)+"] ~n"
								
	li_periodo_pago = ai_periodo_pago
	li_anio_pago_cob = ai_anio_pago
	li_periodo_apartado = ai_periodo_apartado
	li_anio_apartado_cob = ai_anio_apartado

	IF NOT isvalid(at_transaction_tes) THEN
		IF conecta_bd(at_transaction_tes,"SCOB",gs_usuario,gs_password)<>1 THEN
			RETURN -1
		END IF
	END IF

	// Deja el manejo transaccional al stored procedure
	at_transaction_tes.Autocommit = true

	DECLARE spapartadoslugarscob procedure for sp_apartado_de_lugar
	@cuenta		= :al_cuenta,
	@periodo	= :li_periodo_pago,
	@anio		= :li_anio_pago_cob,
	@p_cambio	= :li_periodo_apartado,
	@a_cambio	= :li_anio_apartado_cob,
	@status		= :li_exito out
	using at_transaction_tes;	
	
	EXECUTE spapartadoslugarscob;
	li_codigo_error_exec= at_transaction_tes.SQLCode
	ls_mensaje_exec= at_transaction_tes.SQLErrText
		
	// Libera el manejo transaccional del stored procedure
	at_transaction_tes.Autocommit = false

	IF li_codigo_error_exec= -1 THEN
		CLOSE spapartadoslugarscob;
		MessageBox("Error al ejecutar sp_apartado_de_lugar: ", ls_mensaje_titulo+"~n"+ls_mensaje_exec, StopSign!)		
		desconecta_bd(at_transaction_tes)

		RETURN -1			
	END IF

	FETCH spapartadoslugarscob INTO :li_exito;
	
	li_codigo_error= at_transaction_tes.SQLCode
	ls_mensaje= at_transaction_tes.SQLErrText
	IF li_codigo_error= -1 THEN
		CLOSE spapartadoslugarscob;
		MessageBox("Error al ejecutar fetch de sp_apartado_de_lugar: ", ls_mensaje_titulo+"~n"+ls_mensaje, StopSign!)		
		desconecta_bd(at_transaction_tes)

		RETURN -1
	END IF
	
		
	CLOSE spapartadoslugarscob;


	// Si se pudo realizar la actualizacion en cobranzas

	IF li_exito = 1 THEN
		//ActualizaControl:
		UPDATE	controlescolar_bd.dbo.academicos
		SET		ac.periodo_ing = :ai_periodo_apartado,
					ac.anio_ing = :ai_anio_apartado
		FROM		controlescolar_bd.dbo.academicos ac
		WHERE	ac.cuenta = :al_cuenta
		USING	at_transaction_sce;
		li_res_control = at_transaction_sce.SqlCode
		ls_mensaje_control= at_transaction_sce.SqlErrtext
		
		IF li_res_control= -1 THEN
			ROLLBACK USING at_transaction_sce;
			MessageBox("Error al actualizar el periodo en academicos", ls_mensaje_titulo+"~n"+ls_mensaje_control, StopSign!)		
			desconecta_bd(at_transaction_tes)
			RETURN -1
		END IF
	
		UPDATE	admision_bd.dbo.aspiran
		SET		a.ing_per = :ai_periodo_apartado,
					a.ing_anio = :ai_anio_apartado
		FROM		admision_bd.dbo.aspiran a, admision_bd.dbo.general g
		WHERE	g.cuenta = :al_cuenta
		AND		a.folio = g.folio
		AND		a.clv_ver = g.clv_ver
		AND		a.clv_per = g.clv_per
		AND		a.anio = g.anio
		USING	at_transaction_sce;
		li_res_admision= at_transaction_sce.SqlCode
		ls_mensaje_admision= at_transaction_sce.SqlErrtext
	
		IF  li_res_admision= 0 THEN
			COMMIT USING at_transaction_sce;
			IF li_codigo_error_exec<> -1 AND li_codigo_error<>-1 THEN
		//NO realiza el manejo transaccional de la conexión a tesorería
		//				COMMIT USING at_transaction_tes;
				IF IsValid( at_transaction_tes) then
					desconecta_bd(at_transaction_tes)
				END IF
			END IF
			RETURN 0
		ELSE
			ROLLBACK USING at_transaction_sce;
			MessageBox("Error al actualizar el periodo en aspiran", ls_mensaje_titulo+"~n"+ls_mensaje_admision, StopSign!)		
			desconecta_bd(at_transaction_tes)
			RETURN -1
		END IF
	ELSE
		
		//SIN FUNCION MIENTRAS SE ESTABILIZA EL NUEVO SISTEMA DE COBRANZAS
		MessageBox("Error al ejecutar sp_apartado_de_lugar: ", ls_mensaje_titulo+"~n"+ls_mensaje_out+"~n" +&
						ls_mensaje_aportacion+"~n"+ls_mensaje_inscripcion, StopSign!)		
		desconecta_bd(at_transaction_tes)
		RETURN -1
	END IF

ELSEIF  li_existe_alumno= -1 THEN
	RETURN -1
ELSEIF  li_existe_alumno= 100 THEN
	MessageBox("Alumno Inexistente","No existe el alumno con la cuenta["+string(al_cuenta)+"]",StopSign!)		
END IF

end function

on uo_cambio_periodo_ingreso.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cambio_periodo_ingreso.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

