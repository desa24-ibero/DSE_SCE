$PBExportHeader$uo_nombre_aspirante2.sru
$PBExportComments$Objeto que busca al aspirante por No. de Folio., por nombre o por apellidos, o efectuando una revisión en la tabla de aspirantes. Para datos básicos
forward
global type uo_nombre_aspirante2 from userobject
end type
type uo_1 from uo_ver_per_ani within uo_nombre_aspirante2
end type
type cbx_nuevo from checkbox within uo_nombre_aspirante2
end type
type dw_nombre_aspirante from datawindow within uo_nombre_aspirante2
end type
type em_digito from editmask within uo_nombre_aspirante2
end type
type st_2 from statictext within uo_nombre_aspirante2
end type
type st_1 from statictext within uo_nombre_aspirante2
end type
type em_cuenta from editmask within uo_nombre_aspirante2
end type
end forward

shared variables

end variables

global type uo_nombre_aspirante2 from userobject
integer width = 3241
integer height = 416
boolean enabled = false
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
event primero ( )
event siguiente ( )
event anterior ( )
event ultimo ( )
event cambia_seleccion ( )
uo_1 uo_1
cbx_nuevo cbx_nuevo
dw_nombre_aspirante dw_nombre_aspirante
em_digito em_digito
st_2 st_2
st_1 st_1
em_cuenta em_cuenta
end type
global uo_nombre_aspirante2 uo_nombre_aspirante2

type variables
window ventana
integer ii_version
end variables

event primero;long lo_cuenta

setpointer(hourglass!) 
cbx_nuevo.checked = False

 SELECT min(aspiran.folio )
    INTO :lo_cuenta  
    FROM aspiran  
	 WHERE (aspiran.clv_ver = :gi_version) AND
       (aspiran.clv_per = :gi_periodo) AND
       (aspiran.anio = :gi_anio)
USING gtr_SADM;

if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")
end if
end event

event siguiente;long lo_cuenta

setpointer(hourglass!) 
cbx_nuevo.checked = False
lo_cuenta = long(em_cuenta.text) 

SELECT min(aspiran.folio  )
  INTO :lo_cuenta  
  FROM aspiran
 WHERE (aspiran.clv_ver = :gi_version) AND
       (aspiran.clv_per = :gi_periodo) AND
       (aspiran.anio = :gi_anio) AND
       (aspiran.folio > :lo_cuenta)
USING gtr_SADM;

if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")	
else
	Messagebox("Información","Este es el último aspirante")
end if
end event

event anterior;long lo_cuenta

setpointer(hourglass!) 
cbx_nuevo.checked = False
lo_cuenta = long(em_cuenta.text)
 
SELECT max(aspiran.folio)
  INTO :lo_cuenta  
  FROM aspiran
 WHERE (aspiran.clv_ver = :gi_version) AND
       (aspiran.clv_per = :gi_periodo) AND
       (aspiran.anio = :gi_anio) AND
       (aspiran.folio < :lo_cuenta)
USING gtr_SADM;

if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")

else
	Messagebox("Información","Este es el primer aspirante")
end if
end event

event ultimo;long lo_cuenta

 setpointer(hourglass!)
 cbx_nuevo.checked = False
 
 SELECT max(aspiran.folio)
    INTO :lo_cuenta  
    FROM aspiran  
	 WHERE (aspiran.clv_ver = :gi_version) AND
       (aspiran.clv_per = :gi_periodo) AND
       (aspiran.anio = :gi_anio)
USING gtr_SADM;

if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")	
end if
end event

event cambia_seleccion();RETURN 
end event

on uo_nombre_aspirante2.create
this.uo_1=create uo_1
this.cbx_nuevo=create cbx_nuevo
this.dw_nombre_aspirante=create dw_nombre_aspirante
this.em_digito=create em_digito
this.st_2=create st_2
this.st_1=create st_1
this.em_cuenta=create em_cuenta
this.Control[]={this.uo_1,&
this.cbx_nuevo,&
this.dw_nombre_aspirante,&
this.em_digito,&
this.st_2,&
this.st_1,&
this.em_cuenta}
end on

on uo_nombre_aspirante2.destroy
destroy(this.uo_1)
destroy(this.cbx_nuevo)
destroy(this.dw_nombre_aspirante)
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_cuenta)
end on

event constructor;ventana=parent
end event

type uo_1 from uo_ver_per_ani within uo_nombre_aspirante2
event destroy ( )
integer x = 443
boolean enabled = true
long backcolor = 1090519039
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;PARENT.TRIGGEREVENT("cambia_seleccion")
end event

type cbx_nuevo from checkbox within uo_nombre_aspirante2
integer x = 2738
integer y = 48
integer width = 393
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Modificar"
end type

type dw_nombre_aspirante from datawindow within uo_nombre_aspirante2
event type integer carga ( long cuenta )
integer y = 156
integer width = 3232
integer height = 264
integer taborder = 20
string dataobject = "dw_nombre_aspirante"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event carga;integer li_version

li_version = gi_sol_version

if gi_version = 99 then
	return retrieve(cuenta,gi_sol_version,gi_periodo,gi_anio)
else
	return retrieve(cuenta,gi_version,gi_periodo,gi_anio)
end if
end event

event itemchanged;string nombre,apat,amat,columna
char digito
long cuenta
param_obj_aspirante origen

columna = getcolumnname() 

CHOOSE CASE columna
	
  CASE "nombre"
	if cbx_nuevo.checked = true then		
		if w_datosbasicos.dw_3.RowCount()=1 then
			w_datosbasicos.dw_3.object.nombre[1]=data
		end if
	else
		nombre ="%"+gettext()+"%"
		SELECT general.cuenta  
	   INTO :cuenta  
	   FROM general
	   WHERE((general.clv_ver = :gi_version) OR
		      (:gi_version = 99)             ) AND
				(general.clv_per = :gi_periodo) AND
				(general.anio = :gi_anio) AND
				(general.nombre like :nombre)
		USING gtr_sadm;
	end if

  CASE "apaterno"
	if cbx_nuevo.checked = true then		
		if w_datosbasicos.dw_3.RowCount()=1 then
			w_datosbasicos.dw_3.object.apaterno[1]=data
		end if
	else
	  apat ="%"+gettext()+"%"
	  SELECT general.cuenta  
	  INTO :cuenta  
	  FROM general
	  WHERE ((general.clv_ver = :gi_version) OR
		      (:gi_version = 99)             ) AND				
				(general.clv_per = :gi_periodo) AND
				(general.anio = :gi_anio) AND
				(general.apaterno like :apat)
	USING gtr_sadm;
	end if

  CASE "amaterno"
	if cbx_nuevo.checked = true then		
		if w_datosbasicos.dw_3.RowCount()=1 then
			w_datosbasicos.dw_3.object.amaterno[1]=data
		end if
	else
		amat ="%"+gettext()+"%"
		SELECT general.cuenta  
	   INTO :cuenta  
	   FROM general
	   WHERE ((general.clv_ver = :gi_version) OR
		       (:gi_version = 99)             ) AND				
				 (general.clv_per = :gi_periodo) AND
				 (general.anio = :gi_anio) AND
				 (general.amaterno like :amat)
		USING gtr_sadm;
	end if

END CHOOSE	

if cbx_nuevo.checked = false then		
	if cbx_nuevo.text = "Modificar" then

		origen.nombre = this
		origen.folio = cuenta
		origen.em_cuenta = em_cuenta

		openwithparm(w_aspirantesnombre,origen)
		if w_aspirantesnombre.dw_nombre.event carga(nombre,apat,amat)  = 0 then
			messagebox("Aviso","No existe ningun "+mid(nombre,2,len(nombre)-2)+" "+mid(apat,2,len(apat)-2)+" "+mid(amat,2,len(amat)-2)+" dado de alta.")
			close(w_aspirantesnombre)
		end if	
	end if
end if

end event

event getfocus;if isvalid(w_aspirantesnombre) then
	close(w_aspirantesnombre)
end if
end event

event constructor;settransobject(gtr_sadm)
insertrow(0)
end event

type em_digito from editmask within uo_nombre_aspirante2
integer x = 489
integer y = 48
integer width = 78
integer height = 80
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = "œ4"
end type

type st_2 from statictext within uo_nombre_aspirante2
integer x = 443
integer y = 48
integer width = 50
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "--"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_nombre_aspirante2
integer y = 44
integer width = 142
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Folio"
alignment alignment = center!
boolean border = true
long bordercolor = 33554432
boolean focusrectangle = false
end type

type em_cuenta from editmask within uo_nombre_aspirante2
event activarbusq ( )
integer x = 151
integer y = 44
integer width = 274
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
alignment alignment = center!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaa"
string displaydata = "~r"
end type

event activarbusq;int cont
long cuenta
char digito,dig

	cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
	if cuenta > 1 then
		em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
		em_cuenta.text = string(cuenta)

//		 SELECT aspiran.folio, aspiran.clv_ver  
//			   INTO :cuenta, :ii_version
//		    FROM aspiran  
//	      WHERE (aspiran.folio = :cuenta) AND 			       
//				  ((aspiran.periodo = :gi_version) OR
//					(:gi_version = 99)              ) AND
//					(aspiran.semestre = :gi_periodo) AND
//					(aspiran.anio = :gi_anio)
//		USING gtr_SADM;

		 SELECT aspiran.folio, aspiran.clv_ver  
			   INTO :cuenta, :gi_sol_version
		    FROM aspiran  
	      WHERE (aspiran.folio = :cuenta) AND 			       
				  ((aspiran.clv_ver = :gi_version) OR
					(:gi_version = 99)              ) AND
					(aspiran.clv_per = :gi_periodo) AND
					(aspiran.anio = :gi_anio)
			USING gtr_sadm;


		if cbx_nuevo.checked = true then
			
			em_digito.text =obten_digito(long(em_cuenta.text))		
			ventana.triggerevent(doubleclicked!)
			if dw_nombre_aspirante.event carga(cuenta) = 0 then
			   dw_nombre_aspirante.insertrow(0)
			end if
		elseif cbx_nuevo.checked = false then
			if gtr_sadm.sqlcode = 100 then
				messagebox("Atención","El aspirante con clave "+string(cuenta)+" no existe.")
				em_cuenta.text = " "
				em_digito.text=" "
				ventana.triggerevent(doubleclicked!)
				if dw_nombre_aspirante.event carga(0) = 0 then
			  		 dw_nombre_aspirante.insertrow(0)
				end if
				goto fin
			end if
			em_cuenta.text = string(cuenta)
			if em_digito.text = "" then
//			em_digito.setfocus()
			else	
				digito = upper(em_digito.text)
				dig = obten_digito(cuenta)
				if digito = dig then	
					if dw_nombre_aspirante.event carga(cuenta) = 0 then
					   dw_nombre_aspirante.insertrow(0)
					end if
				   ventana.triggerevent(doubleclicked!)	
				else
					messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)			
				end if	
			
			end if	
		end if
	else 
		em_digito.text=" "
		em_cuenta.text = " "
		ventana.triggerevent(doubleclicked!)
		if dw_nombre_aspirante.event carga(0) = 0 then
			  dw_nombre_aspirante.insertrow(0)
		end if
		em_cuenta.setfocus()
	end if
fin:
end event

event getfocus;if isvalid(w_aspirantesnombre) then
	close(w_aspirantesnombre)
end if

em_cuenta.selecttext(1,len(em_cuenta.text))
end event

event losefocus;long cuenta
if keydown(KeyEnter!) = true then
	/*Si se llega a necesitar agregar otra vez el dígito verificador:*/
	//Borrar de aqui..
	cuenta = long(em_cuenta.text)
	em_cuenta.text = string(cuenta)+string(obten_digito(cuenta))
	//Hasta aca (o comentar)
	triggerevent("activarbusq")	
end if
end event

event modified;if keydown(keyenter!) then	
	dw_nombre_aspirante.setfocus()	
end if
end event

