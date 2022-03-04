$PBExportHeader$uo_periodo_tipo_servicios.sru
forward
global type uo_periodo_tipo_servicios from userobject
end type
end forward

global type uo_periodo_tipo_servicios from userobject
integer width = 503
integer height = 864
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global uo_periodo_tipo_servicios uo_periodo_tipo_servicios

type variables
Long i_error
String s_message, s_title = "Error"
end variables

forward prototypes
public function long f_obten_num_periodos (n_tr atr_app)
public function string f_obten_tipo_periodo (n_tr atr_app, long al_indice)
public function string f_obten_desc_periodo (n_tr atr_app, string as_tipo)
public function string f_obten_desc_periodo_msg (string as_tipo)
public function boolean f_existe_periodo_default (n_tr atr_app, string as_tipo)
public function string f_obten_primer_periodo_como_default (n_tr atr_app)
end prototypes

public function long f_obten_num_periodos (n_tr atr_app);Long ll_valor
String ls_nombre_funcion = "f_obten_num_periodos"

SELECT ISNULL(COUNT(id_tipo),0)
INTO :ll_valor
FROM periodo_tipo
USING atr_app; 
		
IF atr_app.sqlcode < 0  Then
	s_message = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	i_error = -1
ELSE
	IF ll_valor <= 0 THEN
		s_message = "El numero de periodos obtenido de la función " + ls_nombre_funcion + ", no es válido: " + String(ll_valor)
		i_error = -1
	END IF		
END IF			

RETURN ll_valor
end function

public function string f_obten_tipo_periodo (n_tr atr_app, long al_indice);String ls_tipo_periodo
String ls_nombre_funcion = "f_obten_tipo_periodo"

SELECT ISNULL(a1.id_tipo, "")
INTO :ls_tipo_periodo
FROM periodo_tipo a1, periodo_tipo a2
WHERE a1.id_tipo >= a2.id_tipo
GROUP BY a1.id_tipo
HAVING COUNT(1) = :al_indice
ORDER BY a1.id_tipo
USING atr_app;
		
IF atr_app.sqlcode < 0  THEN
	s_message = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	i_error = -1
ELSE
	IF ls_tipo_periodo = "" THEN
		s_message = "El tipo periodo obtenido de la función  " + ls_nombre_funcion + ", no es válido: vacío"
		i_error = -1
	END IF		
END IF

RETURN ls_tipo_periodo

end function

public function string f_obten_desc_periodo (n_tr atr_app, string as_tipo);String ls_desc_periodo
String ls_nombre_funcion = "f_obten_desc_periodo"

SELECT ISNULL(descripcion, "")
INTO :ls_desc_periodo
FROM periodo_tipo 
WHERE id_tipo = :as_tipo
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	s_message = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	i_error = -1
ELSE
	IF ls_desc_periodo = "" THEN
		s_message = "La descripción obtenida de la función  " + ls_nombre_funcion + ", no es válida: vacío"
		i_error = -1
	END IF
END IF

RETURN ls_desc_periodo

end function

public function string f_obten_desc_periodo_msg (string as_tipo);String ls_desc_periodo

CHOOSE CASE UPPER(as_tipo)
	CASE 'S'
		ls_desc_periodo = "Semestre"
	CASE 'T'		
		ls_desc_periodo = "Trimestre"
	CASE 'Q'
		ls_desc_periodo = "Cuatrimestre"
	CASE ELSE
		s_message = "La descripción del tipo " + as_tipo + ", no ha sido definda"
		i_error = -1
END CHOOSE		

RETURN ls_desc_periodo

end function

public function boolean f_existe_periodo_default (n_tr atr_app, string as_tipo);Long ll_existe
String ls_nombre_funcion = "f_existe_periodo_default"

SELECT COUNT(1)
INTO :ll_existe
FROM periodo_tipo 
WHERE id_tipo = :as_tipo
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	s_message = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	i_error = -1
END IF

RETURN (1 = ll_existe)

end function

public function string f_obten_primer_periodo_como_default (n_tr atr_app);String ls_id_tipo
String ls_nombre_funcion = "f_obten_primer_periodo_como_default"

SELECT TOP 1 id_tipo
INTO :ls_id_tipo
FROM periodo_tipo 
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	s_message = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	i_error = -1
ELSE
	IF ls_id_tipo = "" THEN
		s_message = "La descripción obtenida de la función  " + ls_nombre_funcion + ", no es válida: vacío"
		i_error = -1
	END IF
END IF

RETURN ls_id_tipo
end function

on uo_periodo_tipo_servicios.create
end on

on uo_periodo_tipo_servicios.destroy
end on

