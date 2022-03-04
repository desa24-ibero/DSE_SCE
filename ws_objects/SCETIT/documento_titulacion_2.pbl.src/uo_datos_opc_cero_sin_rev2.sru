$PBExportHeader$uo_datos_opc_cero_sin_rev2.sru
forward
global type uo_datos_opc_cero_sin_rev2 from userobject
end type
type cb_elegir from commandbutton within uo_datos_opc_cero_sin_rev2
end type
type st_3 from statictext within uo_datos_opc_cero_sin_rev2
end type
type uo_nombre_alumno_i from uo_nombre_alumno_opc_cero2 within uo_datos_opc_cero_sin_rev2
end type
type uo_carreras_alumno_i from uo_carreras_alumno_opc_cero2 within uo_datos_opc_cero_sin_rev2
end type
end forward

global type uo_datos_opc_cero_sin_rev2 from userobject
integer width = 2754
integer height = 288
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event inicia_proceso ( )
cb_elegir cb_elegir
st_3 st_3
uo_nombre_alumno_i uo_nombre_alumno_i
uo_carreras_alumno_i uo_carreras_alumno_i
end type
global uo_datos_opc_cero_sin_rev2 uo_datos_opc_cero_sin_rev2

type variables
window iw_padre
str_alumno_opc_cero ist_parametros
boolean ib_revisa_cobranzas= true
long il_cuenta, il_cve_carrera, il_cve_plan
end variables

forward prototypes
public function long of_obten_cve_carrera ()
public function long of_obten_cve_plan (long al_cuenta)
public function boolean of_procede_tramite ()
public function long of_obten_cuenta ()
public function integer of_set_revisa_cobranzas (boolean ab_revisa_cobranzas)
public function boolean of_obten_revisa_cobranzas ()
public subroutine of_set_texto_boton (string as_texto)
end prototypes

event inicia_proceso();//inicia_proceso
long ll_cuenta, ll_sincroniza
long ll_registros

ll_cuenta = this.of_obten_cuenta()
if ll_cuenta > 0 then
	ll_sincroniza = uo_carreras_alumno_i.of_sincroniza(ll_cuenta)
end if

//MessageBox("Prueba","cuenta: "+string(ll_cuenta)+"~n Sincroniza: "+string(ll_sincroniza)) 

end event

public function long of_obten_cve_carrera ();//of_obten_cve_carrera
//Devuelve la cuenta del alumno
return this.uo_carreras_alumno_i.of_obten_clave()

end function

public function long of_obten_cve_plan (long al_cuenta);//of_obten_cve_plan
//Devuelve la cuenta del alumno
return this.uo_carreras_alumno_i.of_obten_clave_02(al_cuenta)
end function

public function boolean of_procede_tramite ();//of_procede_tramite
//Devuelve si se puede continuar con el támite
//Compara si el valor tecleado es el ultimo introducido y validado por la estructura
//si no es el mismo regresa false
if ist_parametros.cuenta = this.of_obten_cuenta() and &
   ist_parametros.cve_carrera = this.of_obten_cve_carrera()  then
	return true
//	return ist_parametros.procede_tramite
else
	return false
end if
end function

public function long of_obten_cuenta ();//of_obten_cuenta
//Devuelve la cuenta del alumno
return this.uo_nombre_alumno_i.of_obten_cuenta()
end function

public function integer of_set_revisa_cobranzas (boolean ab_revisa_cobranzas);//of_set_revisa_cobranzas
//Establece si habra de revisarse cobranzas

ib_revisa_cobranzas = ab_revisa_cobranzas
return 0
end function

public function boolean of_obten_revisa_cobranzas ();//of_obten_revisa_cobranzas
//Devuelve si habra de revisarse cobranzas
return ib_revisa_cobranzas
end function

public subroutine of_set_texto_boton (string as_texto);//of_set_texto_boton
//Recibe		as_texto string

cb_elegir.text = as_texto

end subroutine

on uo_datos_opc_cero_sin_rev2.create
this.cb_elegir=create cb_elegir
this.st_3=create st_3
this.uo_nombre_alumno_i=create uo_nombre_alumno_i
this.uo_carreras_alumno_i=create uo_carreras_alumno_i
this.Control[]={this.cb_elegir,&
this.st_3,&
this.uo_nombre_alumno_i,&
this.uo_carreras_alumno_i}
end on

on uo_datos_opc_cero_sin_rev2.destroy
destroy(this.cb_elegir)
destroy(this.st_3)
destroy(this.uo_nombre_alumno_i)
destroy(this.uo_carreras_alumno_i)
end on

event constructor;iw_padre = this.GetParent()
end event

type cb_elegir from commandbutton within uo_datos_opc_cero_sin_rev2
integer x = 2432
integer y = 189
integer width = 311
integer height = 86
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Añadir"
end type

event clicked;str_alumno_opc_cero lst_parametros
long ll_cuenta, ll_cve_carrera, ll_cve_plan
boolean lb_procede_tramite, lb_procede_tramite02
integer li_res

ll_cuenta = parent.of_obten_cuenta()
if ll_cuenta<=0 then
	MessageBox("Error", "La cuenta no es válida", StopSign!)
	return
end if

ll_cve_carrera = parent.of_obten_cve_carrera()
ll_cve_plan = parent.of_obten_cve_plan(ll_cuenta)

il_cuenta = ll_cuenta
il_cve_carrera = ll_cve_carrera
il_cve_plan = ll_cve_plan

lb_procede_tramite = false




MessageBox("Alumno Seleccionado",&
					"Se ha seleccionado al Alumno ["+ string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+"]~n"+&
					"                     Carrera ["+ string(ll_cve_carrera)+"]~n"+&
					"                     Plan    ["+ string(ll_cve_plan)+"] ?", Information!)

iw_padre.TriggerEvent("Metodo01")


//
//if li_res = 1 then
//	
//	lst_parametros.cuenta = ll_cuenta
//	lst_parametros.cve_carrera = ll_cve_carrera
//	lst_parametros.cve_plan = ll_cve_plan
//	lst_parametros.procede_tramite = lb_procede_tramite
//	lst_parametros.revisa_cobranzas = of_obten_revisa_cobranzas()
//	
//	ist_parametros.cuenta = ll_cuenta
//	ist_parametros.cve_carrera = ll_cve_carrera
//	ist_parametros.cve_plan = ll_cve_plan
//	ist_parametros.procede_tramite = lb_procede_tramite
//	ist_parametros.revisa_cobranzas = of_obten_revisa_cobranzas()
//	
//	OpenWithParm(w_diagnostico_acad_opc_cero, lst_parametros, iw_padre)
//	lst_parametros =Message.PowerObjectParm
//	lb_procede_tramite02 = lst_parametros.procede_tramite
//	ist_parametros.procede_tramite = lb_procede_tramite02
//	if NOT lb_procede_tramite02 then
//		MessageBox("Requisitos Incompletos",&
//		"El alumno no cumple con los requisitos~n"+&
//		" para proseguir con el Trámite de Titulación", Information!)
//		return		
//		
//	end if
//	iw_padre.TriggerEvent("Metodo01")
//end if
//
//
end event

type st_3 from statictext within uo_datos_opc_cero_sin_rev2
integer x = 18
integer y = 198
integer width = 241
integer height = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carreras"
boolean focusrectangle = false
end type

type uo_nombre_alumno_i from uo_nombre_alumno_opc_cero2 within uo_datos_opc_cero_sin_rev2
integer taborder = 10
boolean enabled = true
end type

on uo_nombre_alumno_i.destroy
call uo_nombre_alumno_opc_cero2::destroy
end on

type uo_carreras_alumno_i from uo_carreras_alumno_opc_cero2 within uo_datos_opc_cero_sin_rev2
integer x = 267
integer y = 182
integer width = 2117
integer height = 96
integer taborder = 40
end type

on uo_carreras_alumno_i.destroy
call uo_carreras_alumno_opc_cero2::destroy
end on

