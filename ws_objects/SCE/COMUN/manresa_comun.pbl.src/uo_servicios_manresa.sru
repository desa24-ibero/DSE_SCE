$PBExportHeader$uo_servicios_manresa.sru
$PBExportComments$Servicios de materias MANRESA
forward
global type uo_servicios_manresa from nonvisualobject
end type
end forward

global type uo_servicios_manresa from nonvisualobject
end type
global uo_servicios_manresa uo_servicios_manresa

type variables
transaction itr_trans

LONG il_cuenta  
LONG il_cve_carrera  
INTEGER ie_cve_plan 
INTEGER ie_periodo  
INTEGER ie_anio 
LONG il_area

LONG il_cve_mat_sel
STRING is_gpo_sel 
LONG ll_cve_mat_sep_sel





end variables
forward prototypes
public function integer of_inserta_mat_insc_sep (long al_cve_mat_sep, string as_gpo_sep, long al_cve_mat, string as_gpo)
public function long of_recupera_mat_sep_area (long al_area)
public function integer of_inserta_mat_insc_sep_area (integer al_cve_mat, string as_gpo, long al_area)
public function integer of_selecciona_materia_sep ()
end prototypes

public function integer of_inserta_mat_insc_sep (long al_cve_mat_sep, string as_gpo_sep, long al_cve_mat, string as_gpo);

INSERT INTO mat_inscritas_sep (cuenta, cve_carrera, cve_plan, cve_mat_sep, gpo_sep, cve_mat, gpo, periodo, anio)
VALUES (:il_cuenta, :il_cve_carrera, :ie_cve_plan, :al_cve_mat_sep, :as_gpo_sep, :al_cve_mat, :as_gpo, :ie_periodo, :ie_anio)  
USING itr_trans;


RETURN 0 


end function

public function long of_recupera_mat_sep_area (long al_area);// Función que recupera la materia SEP asociada al área especificada en el plan de estudios. 

LONG ll_cve_materia_sep

SELECT cve_mat_sep 
INTO :ll_cve_materia_sep 
FROM materias_sep 
WHERE cve_area = :al_area 
USING itr_trans; 


RETURN ll_cve_materia_sep 




end function

public function integer of_inserta_mat_insc_sep_area (integer al_cve_mat, string as_gpo, long al_area);LONG ll_cve_mat_sep 
STRING ls_gpo_sep 

// Se recupera la clave de la materia SEP por el área asociada 
ll_cve_mat_sep = of_recupera_mat_sep_area( al_area)  
ls_gpo_sep = ""

// Se inserta la materia SEP inscrita y la materia IBERO relacionada 
of_inserta_mat_insc_sep( ll_cve_mat_sep, ls_gpo_sep, al_cve_mat, as_gpo) 


RETURN 0



end function

public function integer of_selecciona_materia_sep ();//LONG il_coordinacion 
//LONG il_area 
//LONG il_cve_carrera 
//INTEGER ie_plan 


uo_paso_parm_manresa luo_paso_parm_manresa
luo_paso_parm_manresa = CREATE uo_paso_parm_manresa

uo_paso_parm_manresa luo_paso_parm_manresa_ret
luo_paso_parm_manresa_ret = CREATE uo_paso_parm_manresa

luo_paso_parm_manresa.ie_plan = ie_cve_plan 
luo_paso_parm_manresa.il_area = il_area
luo_paso_parm_manresa.il_coordinacion = 0
luo_paso_parm_manresa.il_cve_carrera = il_cve_carrera 
luo_paso_parm_manresa.itr_trans = itr_trans 

OPENWITHPARM(w_selecciona_materia_sep, luo_paso_parm_manresa) 

luo_paso_parm_manresa_ret = Message.PowerObjectParm



RETURN 0 





end function

on uo_servicios_manresa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_servicios_manresa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

