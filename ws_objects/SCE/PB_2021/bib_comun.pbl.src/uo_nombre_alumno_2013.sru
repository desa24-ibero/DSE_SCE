$PBExportHeader$uo_nombre_alumno_2013.sru
$PBExportComments$Objeto que busca al alumno por No. de Cta., por nombre o por apellidos, o efectuando una revisión en la tabla de alumnos
forward
global type uo_nombre_alumno_2013 from uo_master_uo
end type
type dw_nombre_alumno from uo_dw_nombre_alumno_2013 within uo_nombre_alumno_2013
end type
type cbx_nuevo from checkbox within uo_nombre_alumno_2013
end type
type em_digito from editmask within uo_nombre_alumno_2013
end type
type st_2 from statictext within uo_nombre_alumno_2013
end type
type em_cuenta from editmask within uo_nombre_alumno_2013
end type
type st_1 from statictext within uo_nombre_alumno_2013
end type
type r_1 from rectangle within uo_nombre_alumno_2013
end type
end forward

global type uo_nombre_alumno_2013 from uo_master_uo
integer width = 3218
integer height = 332
long backcolor = 16777215
event anterior ( )
event primero ( )
event ultimo ( )
event siguiente ( )
dw_nombre_alumno dw_nombre_alumno
cbx_nuevo cbx_nuevo
em_digito em_digito
st_2 st_2
em_cuenta em_cuenta
st_1 st_1
r_1 r_1
end type
global uo_nombre_alumno_2013 uo_nombre_alumno_2013

type variables
window iw_ventana
end variables

forward prototypes
public function param_obj_nombre entrega_ventana ()
public function integer revisa_num_cuenta ()
public function long of_obten_cuenta ()
public function character of_obten_digito (long an_cuenta)
public function string of_obten_amaterno ()
public function string of_obten_apaterno ()
public function string of_obten_nombre ()
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
 USING gtr_sce;

if gtr_sce.sqlcode <> 100 then
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
	 USING gtr_sce;


if gtr_sce.sqlcode <> 100 then
	em_cuenta.text = string(ll_cuenta) + obten_digito(ll_cuenta)
	em_cuenta.triggerevent("activarbusq")
end if	


end event

event ultimo();long ll_cuenta
char lch_digito

setpointer(hourglass!)
cbx_nuevo.checked = False
 
SELECT max(alumnos.cuenta)
INTO :ll_cuenta  
FROM alumnos
USING gtr_sce;

if gtr_sce.sqlcode <> 100 then
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
 USING gtr_sce;

if gtr_sce.sqlcode <> 100 then
	em_cuenta.text = string(ll_cuenta) + obten_digito(ll_cuenta)
	em_cuenta.triggerevent("activarbusq")	
else
	Messagebox("Información","Este es el último alumno")
end if	
end event

public function param_obj_nombre entrega_ventana ();param_obj_nombre origen
origen.nombre = this.dw_nombre_alumno
origen.cuenta = this.em_cuenta
origen.digito = this.em_digito
return origen
end function

public function integer revisa_num_cuenta ();return 1
end function

public function long of_obten_cuenta ();long ll_cuenta

ll_cuenta = long(em_cuenta.text)

Return ll_cuenta
end function

public function character of_obten_digito (long an_cuenta);string ls_digito

ls_digito = obten_digito(of_obten_cuenta())

return ls_digito
end function

public function string of_obten_amaterno ();string ls_amaterno

dw_nombre_alumno.Accepttext()
if dw_nombre_alumno.rowcount() > 0 then
	ls_amaterno = dw_nombre_alumno.Getitemstring(dw_nombre_alumno.Getrow(),'amaterno')
else
	ls_amaterno = ''
end if

return ls_amaterno
end function

public function string of_obten_apaterno ();string ls_apaterno

dw_nombre_alumno.Accepttext()
if dw_nombre_alumno.rowcount() > 0 then
	ls_apaterno = dw_nombre_alumno.Getitemstring(dw_nombre_alumno.Getrow(),'apaterno')
else
	ls_apaterno = ''
end if

return ls_apaterno
end function

public function string of_obten_nombre ();string ls_nombre

dw_nombre_alumno.Accepttext()
if dw_nombre_alumno.rowcount() > 0 then
	ls_nombre = dw_nombre_alumno.Getitemstring(dw_nombre_alumno.Getrow(),'nombre')
else
	ls_nombre = ''
end if

return ls_nombre
end function

on uo_nombre_alumno_2013.create
int iCurrent
call super::create
this.dw_nombre_alumno=create dw_nombre_alumno
this.cbx_nuevo=create cbx_nuevo
this.em_digito=create em_digito
this.st_2=create st_2
this.em_cuenta=create em_cuenta
this.st_1=create st_1
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_nombre_alumno
this.Control[iCurrent+2]=this.cbx_nuevo
this.Control[iCurrent+3]=this.em_digito
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_cuenta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.r_1
end on

on uo_nombre_alumno_2013.destroy
call super::destroy
destroy(this.dw_nombre_alumno)
destroy(this.cbx_nuevo)
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.em_cuenta)
destroy(this.st_1)
destroy(this.r_1)
end on

event constructor;call super::constructor;dw_nombre_alumno.settransobject(gtr_sce)
dw_nombre_alumno.insertrow(0)
iw_ventana = parent

end event

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
				USING gtr_sce;
		CASE "apaterno"
			  ls_nombre="%--%"
			  ls_amat="%--%"			
			  ls_apat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.apaterno like :ls_apat
				USING gtr_sce;
		CASE "amaterno"
			  ls_nombre="%--%"
			  ls_apat="%--%"
			  ls_amat ="%"+dw_nombre_alumno.gettext()+"%"			  
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.amaterno like :ls_amat
				USING gtr_sce;
	END CHOOSE	
	
	if gtr_sce.sqlerrtext = "Select returned more than one row" then
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
			iw_ventana.triggerevent("ue_inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
		end if	
	end if	
end if
end event

type dw_nombre_alumno from uo_dw_nombre_alumno_2013 within uo_nombre_alumno_2013
integer x = 32
integer y = 116
integer width = 3163
integer height = 192
integer taborder = 20
boolean livescroll = true
end type

event constructor;call super::constructor;dw_nombre_alumno.insertrow(0)


end event

event itemchanged;call super::itemchanged;string ls_nombre,ls_apat,ls_amat,ls_columna
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
				USING gtr_sce;
		CASE "apaterno"
			  ls_nombre="%--%"
			  ls_amat="%--%"			
			  ls_apat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.apaterno like :ls_apat
				USING gtr_sce;
		CASE "amaterno"
			  ls_nombre="%--%"
			  ls_apat="%--%"
			  ls_amat ="%"+dw_nombre_alumno.gettext()+"%"			  
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.amaterno like :ls_amat
				USING gtr_sce;
	END CHOOSE	
	
	if gtr_sce.sqlerrtext = "Select returned more than one row" then
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
			iw_ventana.triggerevent("ue_inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
		end if	
	end if	
end if
end event

type cbx_nuevo from checkbox within uo_nombre_alumno_2013
boolean visible = false
integer x = 2798
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
long backcolor = 15793151
boolean enabled = false
string text = "Modificar"
end type

type em_digito from editmask within uo_nombre_alumno_2013
integer x = 914
integer y = 28
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

type st_2 from statictext within uo_nombre_alumno_2013
integer x = 873
integer y = 28
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

type em_cuenta from editmask within uo_nombre_alumno_2013
event activarbusq ( )
integer x = 535
integer y = 28
integer width = 334
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
STRING ls_tipo_periodo, descripcion_tipo 
LONG ll_carrera, ll_plan

	ll_cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
	if ll_cuenta > 1 then
		em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
 
		em_cuenta.text = string(ll_cuenta)

		 SELECT alumnos.cuenta  
			   INTO :ll_cuenta  
		    FROM alumnos  
	      WHERE alumnos.cuenta = :ll_cuenta
			USING gtr_sce;

		if cbx_nuevo.checked = true then
			
			em_digito.text =obten_digito(long(em_cuenta.text))		
			iw_ventana.triggerevent("ue_inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
			if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
			   dw_nombre_alumno.insertrow(0)
			end if
		elseif cbx_nuevo.checked = false then
			if gtr_sce.sqlcode = 100 then
				messagebox("Atención","El alumno con clave "+string(ll_cuenta)+" no existe.")
				em_cuenta.text = " "
				em_digito.text=" "
				iw_ventana.triggerevent("ue_inicia_proceso",0,ll_cuenta)
				iw_ventana.triggerevent(doubleclicked!)
				if dw_nombre_alumno.retrieve(0) = 0 then
			  		 dw_nombre_alumno.insertrow(0)
				end if
				goto fin
			end if
			
			//**--**--**--**--**--**--**--**--**--**--**--**--**--**--** 
			// Se verifica si existe el alumno en academicos. 
			SELECT cve_carrera, cve_plan 
			INTO :ll_carrera, :ll_plan
			FROM academicos 
			WHERE cuenta = :ll_cuenta 
			USING gtr_sce; 
			IF gtr_sce.SQLCODE < 0 THEN  
				MESSAGEBOX("Error", "Se produjo un error al verificar el alumno en académicos:" + gtr_sce.SQLERRTEXT ) 
				em_cuenta.text = " " 
				em_digito.text=" " 
				dw_nombre_alumno.RESET() 
				dw_nombre_alumno.INSERTROW(0) 
				goto fin				
			END IF 
			
			IF ISNULL(ll_carrera ) THEN ll_carrera  = 0 
			IF ISNULL(ll_plan) THEN ll_plan = 0 
			
			// Si tiene datos válidos en académicos, se valida el tipo de periodo del alumno. 
			IF ll_carrera <> 0 AND ll_plan <> 0 THEN 
				SELECT pe.tipo_periodo 
				INTO :ls_tipo_periodo 
				FROM academicos ac, plan_estudios pe
				WHERE ac.cve_plan = pe.cve_plan
				AND ac.cve_carrera = pe.cve_carrera 
				AND ac.cuenta = :ll_cuenta 
				USING gtr_sce;
				// Se verifica el tipo de periodo. 
				IF ls_tipo_periodo <> gs_tipo_periodo THEN 
					SELECT descripcion 
					INTO :descripcion_tipo 
					FROM periodo_tipo 
					WHERE id_tipo = :gs_tipo_periodo 
					USING gtr_sce;
					messagebox("Atención","El alumno con clave "+string(ll_cuenta)+" no es de tipo " + descripcion_tipo + ".")			
					em_cuenta.text = " " 
					em_digito.text=" " 
					dw_nombre_alumno.RESET() 
					dw_nombre_alumno.INSERTROW(0) 
					goto fin
				END IF 
			END IF
			//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
			
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
				   iw_ventana.triggerevent("ue_inicia_proceso",0,ll_cuenta)
					iw_ventana.triggerevent(doubleclicked!)
				else
					messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)		
					return
				end if	
			
			end if	
		end if
	else 
		em_digito.text=" "
		em_cuenta.text = " "
//		iw_ventana.triggerevent("ue_inicia_proceso",0,ll_cuenta)
//		iw_ventana.triggerevent(doubleclicked!)
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

type st_1 from statictext within uo_nombre_alumno_2013
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

type r_1 from rectangle within uo_nombre_alumno_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 9
integer width = 3205
integer height = 316
end type

