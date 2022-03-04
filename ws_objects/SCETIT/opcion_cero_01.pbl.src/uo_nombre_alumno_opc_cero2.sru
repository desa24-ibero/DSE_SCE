$PBExportHeader$uo_nombre_alumno_opc_cero2.sru
$PBExportComments$Objeto que busca al alumno por No. de Cta., por nombre o por apellidos, o efectuando una revisión en la tabla de alumnos
forward
global type uo_nombre_alumno_opc_cero2 from userobject
end type
type em_digito from editmask within uo_nombre_alumno_opc_cero2
end type
type st_2 from statictext within uo_nombre_alumno_opc_cero2
end type
type st_1 from statictext within uo_nombre_alumno_opc_cero2
end type
type r_2 from rectangle within uo_nombre_alumno_opc_cero2
end type
type dw_nombre_alumno from datawindow within uo_nombre_alumno_opc_cero2
end type
type r_3 from rectangle within uo_nombre_alumno_opc_cero2
end type
type cbx_nuevo from checkbox within uo_nombre_alumno_opc_cero2
end type
type r_1 from rectangle within uo_nombre_alumno_opc_cero2
end type
type em_cuenta from editmask within uo_nombre_alumno_opc_cero2
end type
end forward

global type uo_nombre_alumno_opc_cero2 from userobject
integer width = 2750
integer height = 182
boolean enabled = false
long backcolor = 10789024
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
event primero ( )
event siguiente ( )
event anterior ( )
event ultimo ( )
em_digito em_digito
st_2 st_2
st_1 st_1
r_2 r_2
dw_nombre_alumno dw_nombre_alumno
r_3 r_3
cbx_nuevo cbx_nuevo
r_1 r_1
em_cuenta em_cuenta
end type
global uo_nombre_alumno_opc_cero2 uo_nombre_alumno_opc_cero2

type variables
window iw_ventana
end variables

forward prototypes
public function integer revisa_num_cuenta ()
public function param_obj_nombre entrega_ventana ()
public function long of_obten_cuenta ()
end prototypes

event primero;long ll_cuenta
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

event siguiente;long ll_cuenta
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

event anterior;long	ll_cuenta,ll_cont
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

event ultimo;long ll_cuenta
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

public function integer revisa_num_cuenta ();return 1
end function

public function param_obj_nombre entrega_ventana ();param_obj_nombre origen
origen.nombre = this.dw_nombre_alumno
origen.cuenta = this.em_cuenta
origen.digito = this.em_digito
return origen
end function

public function long of_obten_cuenta ();//of_obten_cuenta

string ls_cuenta
long ll_cuenta

ls_cuenta = this.em_cuenta.text
ls_cuenta = trim(ls_cuenta)

if not isnumber(ls_cuenta) then
	MessageBox("Error en cuenta","Favor de escribir una cuenta válida",StopSign!)
	return -1
else 
	ll_cuenta = long(ls_cuenta)
end if 

return ll_cuenta
end function

on uo_nombre_alumno_opc_cero2.create
this.em_digito=create em_digito
this.st_2=create st_2
this.st_1=create st_1
this.r_2=create r_2
this.dw_nombre_alumno=create dw_nombre_alumno
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.r_1=create r_1
this.em_cuenta=create em_cuenta
this.Control[]={this.em_digito,&
this.st_2,&
this.st_1,&
this.r_2,&
this.dw_nombre_alumno,&
this.r_3,&
this.cbx_nuevo,&
this.r_1,&
this.em_cuenta}
end on

on uo_nombre_alumno_opc_cero2.destroy
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.r_2)
destroy(this.dw_nombre_alumno)
destroy(this.r_3)
destroy(this.cbx_nuevo)
destroy(this.r_1)
destroy(this.em_cuenta)
end on

event constructor;dw_nombre_alumno.settransobject(gtr_sce)
dw_nombre_alumno.insertrow(0)
iw_ventana = parent

end event

type em_digito from editmask within uo_nombre_alumno_opc_cero2
integer x = 366
integer y = 86
integer width = 66
integer height = 77
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean border = false
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = "~b"
end type

type st_2 from statictext within uo_nombre_alumno_opc_cero2
integer x = 325
integer y = 86
integer width = 40
integer height = 77
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "-"
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_1 from statictext within uo_nombre_alumno_opc_cero2
integer x = 18
integer y = 6
integer width = 472
integer height = 77
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "No. de Cuenta"
alignment alignment = center!
boolean border = true
long bordercolor = 33554432
boolean focusrectangle = false
end type

type r_2 from rectangle within uo_nombre_alumno_opc_cero2
integer linethickness = 5
long fillcolor = 15780518
integer x = 922
integer y = 19
integer width = 395
integer height = 90
end type

type dw_nombre_alumno from datawindow within uo_nombre_alumno_opc_cero2
integer x = 486
integer y = 6
integer width = 2235
integer height = 163
integer taborder = 30
string dataobject = "dw_nombre_alumno_opc_cero2"
boolean border = false
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
			lch_digito = obten_digito(ll_cuenta)
			em_digito.text=lch_digito
			iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
		end if	
	end if	
end if
end event

event getfocus;if isvalid(w_alumnosnombre) then
	close(w_alumnosnombre)
end if
end event

type r_3 from rectangle within uo_nombre_alumno_opc_cero2
boolean visible = false
integer linethickness = 5
long fillcolor = 30588249
integer x = 2787
integer y = 26
integer width = 406
integer height = 74
end type

type cbx_nuevo from checkbox within uo_nombre_alumno_opc_cero2
boolean visible = false
integer x = 2790
integer y = 19
integer width = 395
integer height = 64
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Modificar"
borderstyle borderstyle = stylelowered!
end type

type r_1 from rectangle within uo_nombre_alumno_opc_cero2
long linecolor = 1090519039
integer linethickness = 5
long fillcolor = 10789024
integer y = -3
integer width = 2750
integer height = 182
end type

type em_cuenta from editmask within uo_nombre_alumno_opc_cero2
event activarbusq ( )
integer x = 44
integer y = 86
integer width = 278
integer height = 77
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
alignment alignment = right!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
string displaydata = "Ä"
end type

event activarbusq;int li_cont
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
			USING gtr_sce;

		if cbx_nuevo.checked = true then
			
			em_digito.text =obten_digito(long(em_cuenta.text))		
			iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
			if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
			   dw_nombre_alumno.insertrow(0)
			end if
		elseif cbx_nuevo.checked = false then
			if gtr_sce.sqlcode = 100 then
				messagebox("Atención","El alumno con clave "+string(ll_cuenta)+" no existe.")
				em_cuenta.text = " "
				em_digito.text=" "
				iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
				iw_ventana.triggerevent(doubleclicked!)
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
				   iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
					iw_ventana.triggerevent(doubleclicked!)
				else
					messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)			
				end if	
			
			end if	
		end if
	else 
		em_digito.text=" "
		em_cuenta.text = " "
		iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
		iw_ventana.triggerevent(doubleclicked!)
		if dw_nombre_alumno.retrieve(0) = 0 then
			  dw_nombre_alumno.insertrow(0)
		end if
		em_cuenta.setfocus()
	end if
fin:
end event

event getfocus;if isvalid(w_alumnosnombre) then
	close(w_alumnosnombre)
end if

em_cuenta.selecttext(1,len(em_cuenta.text))
end event

event losefocus;if keydown(KeyEnter!) = true then
	triggerevent("activarbusq")	
end if
end event

event modified;if keydown(keyenter!) then	
	dw_nombre_alumno.setfocus()	
end if
end event

