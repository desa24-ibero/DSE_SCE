$PBExportHeader$uo_carreras_alumno_lista.sru
forward
global type uo_carreras_alumno_lista from userobject
end type
type cbx_nuevo from checkbox within uo_carreras_alumno_lista
end type
type dw_nombre_alumno from datawindow within uo_carreras_alumno_lista
end type
type em_digito from editmask within uo_carreras_alumno_lista
end type
type st_2 from statictext within uo_carreras_alumno_lista
end type
type em_cuenta from editmask within uo_carreras_alumno_lista
end type
type st_1 from statictext within uo_carreras_alumno_lista
end type
type dw_carreras from datawindow within uo_carreras_alumno_lista
end type
type r_1 from rectangle within uo_carreras_alumno_lista
end type
end forward

global type uo_carreras_alumno_lista from userobject
integer width = 3291
integer height = 520
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event anterior ( )
event primero ( )
event siguiente ( )
event ultimo ( )
cbx_nuevo cbx_nuevo
dw_nombre_alumno dw_nombre_alumno
em_digito em_digito
st_2 st_2
em_cuenta em_cuenta
st_1 st_1
dw_carreras dw_carreras
r_1 r_1
end type
global uo_carreras_alumno_lista uo_carreras_alumno_lista

type variables
window iw_ventana
param_obj_carrera istr_carrera
datawindowchild idwc_carreras
end variables

forward prototypes
public subroutine of_llena_str_carrera ()
public subroutine of_recupera_lista_carreras ()
public function string of_obten_amaterno ()
public function string of_obten_apaterno ()
public function character of_obten_digito (long an_cuenta)
public function string of_obten_nombre ()
public function integer of_obten_plan ()
public function integer of_obten_subsist ()
public function param_obj_nombre entrega_ventana ()
public function long of_obten_cuenta ()
public function long of_obten_carrera ()
end prototypes

event anterior();long	ll_cuenta,ll_cont
char	lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False
ll_cuenta = long(em_cuenta.text)
 
SELECT max(alumnos.cuenta )
  INTO :ll_cuenta  
  FROM alumnos  
 WHERE alumnos.cuenta < :ll_cuenta
 USING sqlca;

if sqlca.sqlcode <> 100 then
	em_cuenta.text = string(ll_cuenta) + obten_digito(ll_cuenta)
	em_cuenta.triggerevent("activarbusq")

else
	Messagebox("Información","Este es el primer alumno")
end if	

end event

event primero();long ll_cuenta
char lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False

 SELECT min(alumnos.cuenta )
    INTO :ll_cuenta  
    FROM alumnos
	 USING sqlca;


if sqlca.sqlcode <> 100 then
	em_cuenta.text = string(ll_cuenta) + obten_digito(ll_cuenta)
	em_cuenta.triggerevent("activarbusq")
end if	
end event

event siguiente();long ll_cuenta
char lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False
ll_cuenta = long(em_cuenta.text)

SELECT min(alumnos.cuenta  )
  INTO :ll_cuenta  
  FROM alumnos  
 WHERE alumnos.cuenta > :ll_cuenta
 USING sqlca;

if sqlca.sqlcode <> 100 then
	em_cuenta.text = string(ll_cuenta) + obten_digito(ll_cuenta)
	em_cuenta.triggerevent("activarbusq")	
else
	Messagebox("Información","Este es el último alumno")
end if	
end event

event ultimo();long ll_cuenta
char lch_digito

setpointer(hourglass!)
cbx_nuevo.checked = False
 
SELECT max(alumnos.cuenta)
INTO :ll_cuenta  
FROM alumnos
USING sqlca;

if sqlca.sqlcode <> 100 then
	em_cuenta.text = string(ll_cuenta) + obten_digito(ll_cuenta)
	em_cuenta.triggerevent("activarbusq")	
end if

end event

public subroutine of_llena_str_carrera ();istr_carrera.str_carrera = idwc_carreras.Getitemstring(idwc_carreras.Getrow(),'carrera')
istr_carrera.str_vigente = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'vigente')
istr_carrera.str_cve_carrera = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_carrera')
istr_carrera.str_cve_plan = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_plan')
istr_carrera.str_cve_subsist = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_subsistema')
istr_carrera.str_nivel = idwc_carreras.Getitemstring(idwc_carreras.Getrow(),'nivel')
istr_carrera.str_promedio = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'promedio')
istr_carrera.str_sem_cursados = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'sem_cursados')
istr_carrera.str_cred_cursados = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'creditos_cursados')
istr_carrera.str_egresado = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'egresado')
istr_carrera.str_periodo_ing = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'periodo_ing')
istr_carrera.str_anio_ing = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'anio_ing')
istr_carrera.str_periodo_egre = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'periodo_egre')
istr_carrera.str_anio_egre = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'anio_egre')
istr_carrera.str_cve_formaing = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_formaingreso')
istr_carrera.str_ceremonia_mes = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'ceremonia_mes')
istr_carrera.str_ceremonia_anio = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'ceremonia_anio')

idwc_carreras.Setrow(idwc_carreras.Getrow())
dw_carreras.Setitem(1,'cve_carrera',idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_carrera'))

iw_ventana.triggerevent(doubleclicked!)


end subroutine

public subroutine of_recupera_lista_carreras ();long ll_cuenta

dw_carreras.Reset()
dw_carreras.insertrow(0)
ll_cuenta = long(of_obten_cuenta ())
if idwc_carreras.retrieve(ll_cuenta) = 0 then
	messagebox('Aviso','El alumno no cuenta con carreras en historico',Stopsign!,Ok!)
	em_cuenta.Setfocus()
else
	of_llena_str_carrera ()
end if
end subroutine

public function string of_obten_amaterno ();string ls_amaterno

if dw_nombre_alumno.rowcount() > 0 then
	ls_amaterno = dw_nombre_alumno.Getitemstring(dw_nombre_alumno.Getrow(),'amaterno')
else
	ls_amaterno = ''
end if

return ls_amaterno
end function

public function string of_obten_apaterno ();string ls_apaterno

if dw_nombre_alumno.rowcount() > 0 then
	ls_apaterno = dw_nombre_alumno.Getitemstring(dw_nombre_alumno.Getrow(),'apaterno')
else
	ls_apaterno = ''
end if

return ls_apaterno
end function

public function character of_obten_digito (long an_cuenta);string ls_digito

ls_digito = obten_digito(long(em_cuenta.text))

return ls_digito
end function

public function string of_obten_nombre ();string ls_nombre

if dw_nombre_alumno.rowcount() > 0 then
	ls_nombre = dw_nombre_alumno.Getitemstring(dw_nombre_alumno.Getrow(),'nombre')
else
	ls_nombre = ''
end if

return ls_nombre
end function

public function integer of_obten_plan ();integer li_plan

if idwc_carreras.rowcount() > 0 then
	li_plan = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_plan')
else
	setnull(li_plan)
end if

return li_plan
end function

public function integer of_obten_subsist ();integer li_subsist

if idwc_carreras.rowcount() > 0 then
	li_subsist = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_subsistema')
else
	setnull(li_subsist)
end if

return li_subsist
end function

public function param_obj_nombre entrega_ventana ();param_obj_nombre origen
origen.nombre = this.dw_nombre_alumno
origen.cuenta = this.em_cuenta
origen.digito = this.em_digito
return origen
end function

public function long of_obten_cuenta ();long ll_cuenta

ll_cuenta =  long(em_cuenta.text)

Return ll_cuenta
end function

public function long of_obten_carrera ();integer li_carrera

if idwc_carreras.rowcount() > 0 then
	li_carrera = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_carrera')
else
	setnull(li_carrera)
end if

return li_carrera
end function

on uo_carreras_alumno_lista.create
this.cbx_nuevo=create cbx_nuevo
this.dw_nombre_alumno=create dw_nombre_alumno
this.em_digito=create em_digito
this.st_2=create st_2
this.em_cuenta=create em_cuenta
this.st_1=create st_1
this.dw_carreras=create dw_carreras
this.r_1=create r_1
this.Control[]={this.cbx_nuevo,&
this.dw_nombre_alumno,&
this.em_digito,&
this.st_2,&
this.em_cuenta,&
this.st_1,&
this.dw_carreras,&
this.r_1}
end on

on uo_carreras_alumno_lista.destroy
destroy(this.cbx_nuevo)
destroy(this.dw_nombre_alumno)
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.em_cuenta)
destroy(this.st_1)
destroy(this.dw_carreras)
destroy(this.r_1)
end on

event constructor;dw_nombre_alumno.settransobject(sqlca)
dw_nombre_alumno.insertrow(0)
iw_ventana = parent
end event

type cbx_nuevo from checkbox within uo_carreras_alumno_lista
boolean visible = false
integer x = 2811
integer y = 36
integer width = 393
integer height = 64
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Modificar"
end type

type dw_nombre_alumno from datawindow within uo_carreras_alumno_lista
integer x = 82
integer y = 136
integer width = 3145
integer height = 196
integer taborder = 30
string title = "none"
string dataobject = "dw_nombre_alumno_2013"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_nombre,ls_apat,ls_amat,ls_columna
char lch_digito
long ll_cuenta

param_obj_nombre origen

if cbx_nuevo.checked = false then
	
	ls_columna = dw_nombre_alumno.getcolumnname()

	CHOOSE CASE ls_columna
		CASE "nombre"
		     ls_nombre ="%"+dw_nombre_alumno.gettext()+"%"
			  ls_apat="%--%"
			  ls_amat="%--%"
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.nombre like :ls_nombre
				USING sqlca;
		CASE "apaterno"
			  ls_nombre="%--%"
			  ls_amat="%--%"			
			  ls_apat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.apaterno like :ls_apat
				USING sqlca;
		CASE "amaterno"
			  ls_nombre="%--%"
			  ls_apat="%--%"
			  ls_amat ="%"+dw_nombre_alumno.gettext()+"%"			  
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.amaterno like :ls_amat
				USING sqlca;
	END CHOOSE	
	
	if sqlca.sqlerrtext = "Select returned more than one row" then
		origen = entrega_ventana()
		openwithparm(w_alumnosnombre,origen)
		if w_alumnosnombre.dw_nombre.retrieve(ls_nombre,ls_apat,ls_amat)  = 0 then
			messagebox("Aviso","No existe ningun "+mid(ls_nombre,2,len(ls_nombre)-2)+" "+mid(ls_apat,2,len(ls_apat)-2)+" "+mid(ls_amat,2,len(ls_amat)-2)+" dado de alta.")
			close(w_alumnosnombre)
		end if	
	else
		if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
			dw_nombre_alumno.insertrow(0)
		else 
			em_cuenta.text=string(ll_cuenta)
			lch_digito = of_obten_digito(ll_cuenta)
			em_digito.text=lch_digito
//			iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
//			iw_ventana.triggerevent(doubleclicked!)
		end if	
		of_recupera_lista_carreras ()	
	end if	
	of_recupera_lista_carreras ()	
end if
end event

event constructor;dw_nombre_alumno.Settransobject(sqlca)
end event

type em_digito from editmask within uo_carreras_alumno_lista
integer x = 846
integer y = 24
integer width = 64
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
boolean border = false
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = "~b"
end type

type st_2 from statictext within uo_carreras_alumno_lista
integer x = 805
integer y = 24
integer width = 41
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
boolean enabled = false
string text = "-"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

type em_cuenta from editmask within uo_carreras_alumno_lista
event activarbusq ( )
integer x = 526
integer y = 24
integer width = 279
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
string displaydata = "Ä"
end type

event activarbusq();int li_cont
long ll_cuenta
char lch_digito,lch_dig

ll_cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
if ll_cuenta > 1 then
	em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))

	em_cuenta.text = string(ll_cuenta)
	
	 SELECT alumnos.cuenta  
		   INTO :ll_cuenta  
	    FROM alumnos  
      WHERE alumnos.cuenta = :ll_cuenta
		USING sqlca;

	if cbx_nuevo.checked = true then
		
		em_digito.text =obten_digito(long(em_cuenta.text))		
		if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
		   dw_nombre_alumno.insertrow(0)
		end if
	elseif cbx_nuevo.checked = false then
		if sqlca.sqlcode = 100 then
			messagebox("Atención","El alumno con clave "+string(ll_cuenta)+" no existe.")
			em_cuenta.text = " "
			em_digito.text=" "
			if dw_nombre_alumno.retrieve(0) = 0 then
		  		 dw_nombre_alumno.insertrow(0)
			end if
			goto fin
		end if
		em_cuenta.text = string(ll_cuenta)
		if em_digito.text = "" then
//			em_digito.setfocus()
		else	
			lch_digito = upper(em_digito.text)
			lch_dig = obten_digito(ll_cuenta)
			if lch_digito = lch_dig then	
				if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
				   dw_nombre_alumno.insertrow(0)
				end if
			else
				messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)			
				return
			end if	
			of_recupera_lista_carreras ()	
		end if	
	end if
else 
	em_digito.text=" "
	em_cuenta.text = " "
	if dw_nombre_alumno.retrieve(0) = 0 then
		  dw_nombre_alumno.insertrow(0)
	end if
	em_cuenta.setfocus()
end if
fin:
end event

event getfocus;em_cuenta.selecttext(1,len(em_cuenta.text))
end event

event losefocus;if keydown(KeyEnter!) = true then
	triggerevent("activarbusq")	
end if
end event

event modified;if keydown(keyenter!) then	
	dw_nombre_alumno.setfocus()	
end if
end event

type st_1 from statictext within uo_carreras_alumno_lista
integer x = 41
integer y = 28
integer width = 471
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "No. de Cuenta:"
alignment alignment = right!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_carreras from datawindow within uo_carreras_alumno_lista
integer x = 87
integer y = 332
integer width = 3013
integer height = 168
integer taborder = 30
string title = "none"
string dataobject = "dw_carreras_cursadas_lista"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if row = 0 then return

of_llena_str_carrera ()
end event

event constructor;this.Getchild('cve_carrera',idwc_carreras)
idwc_carreras.settransobject(sqlca)
this.settransobject(sqlca)
this.insertrow(0)
end event

type r_1 from rectangle within uo_carreras_alumno_lista
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 5
integer width = 3255
integer height = 512
end type

