$PBExportHeader$n_trans_sp.sru
forward
global type n_trans_sp from transaction
end type
end forward

global type n_trans_sp from transaction
end type
global n_trans_sp n_trans_sp

type prototypes
function long sp_sit_saldo_pago_concepto(long cuenta,long anio,long periodo,long cve_concepto,long HorasMateria,ref decimal saldo,ref string as_error) RPCFUNC ALIAS FOR "dbo.sp_sit_saldo_pago_concepto"

end prototypes

forward prototypes
public function long f_sit_saldo_pago_concepto (long cuenta, integer anio, integer periodo, integer cve_concepto, integer horasmateria, ref decimal ad_saldo, ref string as_error)
end prototypes

public function long f_sit_saldo_pago_concepto (long cuenta, integer anio, integer periodo, integer cve_concepto, integer horasmateria, ref decimal ad_saldo, ref string as_error);//f_sit_saldo_pago_concepto
//Recibe:
//	(long cuenta,
//	int anio,
//	int periodo,
//	int cve_concepto,
//	int HorasMateria,
//	ref decimal saldo	,
//	ref string error) 
//RPCFUNC ALIAS FOR 
//	"dbo.sp_sit_saldo_pago_concepto"
int li_return

sp_sit_saldo_pago_concepto(cuenta, anio, periodo, cve_concepto, HorasMateria, ad_saldo, as_error) 

li_return = 0

return li_return
end function

on n_trans_sp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_trans_sp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

