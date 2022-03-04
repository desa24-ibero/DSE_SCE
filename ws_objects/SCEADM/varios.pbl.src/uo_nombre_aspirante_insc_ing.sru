$PBExportHeader$uo_nombre_aspirante_insc_ing.sru
$PBExportComments$Objeto que busca al aspirante por No. de Folio., por nombre o por apellidos, o efectuando una revisión en la tabla de aspirantes
forward
global type uo_nombre_aspirante_insc_ing from userobject
end type
type em_cuenta from editmask within uo_nombre_aspirante_insc_ing
end type
type cbx_nuevo from checkbox within uo_nombre_aspirante_insc_ing
end type
type dw_nombre_aspirante from datawindow within uo_nombre_aspirante_insc_ing
end type
type em_digito from editmask within uo_nombre_aspirante_insc_ing
end type
type st_2 from statictext within uo_nombre_aspirante_insc_ing
end type
type st_1 from statictext within uo_nombre_aspirante_insc_ing
end type
type uo_1 from uo_ver_per_ani within uo_nombre_aspirante_insc_ing
end type
end forward

global type uo_nombre_aspirante_insc_ing from userobject
integer width = 3240
integer height = 416
boolean enabled = false
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
event primero ( )
event siguiente ( )
event anterior ( )
event ultimo ( )
em_cuenta em_cuenta
cbx_nuevo cbx_nuevo
dw_nombre_aspirante dw_nombre_aspirante
em_digito em_digito
st_2 st_2
st_1 st_1
uo_1 uo_1
end type
global uo_nombre_aspirante_insc_ing uo_nombre_aspirante_insc_ing

type variables
window i_w_ventana
end variables

event primero();long lo_cuenta

setpointer(hourglass!) 
cbx_nuevo.checked = False

 SELECT min(aspiran.folio )
    INTO :lo_cuenta  
    FROM aspiran  
	 WHERE (aspiran.ing_per = :gi_periodo) AND
       (aspiran.ing_anio = :gi_anio) AND
		 (aspiran.pago_insc = 1)  
USING gtr_SADM;

if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")
end if	


end event

event siguiente();long lo_cuenta

setpointer(hourglass!) 
cbx_nuevo.checked = False
lo_cuenta = long(em_cuenta.text) 

SELECT min(aspiran.folio  )
  INTO :lo_cuenta  
  FROM aspiran
 WHERE (aspiran.ing_per = :gi_periodo) AND
       (aspiran.ing_anio = :gi_anio) AND
		 (aspiran.pago_insc = 1) AND
       (aspiran.folio > :lo_cuenta)
USING gtr_SADM;

if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")	
else
	Messagebox("Información","Este es el último aspirante")
end if
end event

event anterior();long lo_cuenta

setpointer(hourglass!) 
cbx_nuevo.checked = False
lo_cuenta = long(em_cuenta.text)
 
SELECT max(aspiran.folio)
  INTO :lo_cuenta  
  FROM aspiran
 WHERE (aspiran.ing_per = :gi_periodo) AND
       (aspiran.ing_anio = :gi_anio) AND
		 (aspiran.pago_insc = 1) AND
       (aspiran.folio < :lo_cuenta) 
USING gtr_SADM;


if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")

else
	Messagebox("Información","Este es el primer aspirante")
end if	

end event

event ultimo();long lo_cuenta

 setpointer(hourglass!)
 cbx_nuevo.checked = False
 
 SELECT max(aspiran.folio)
    INTO :lo_cuenta  
    FROM aspiran  
	 WHERE (aspiran.ing_per = :gi_periodo) AND
       (aspiran.ing_anio = :gi_anio) AND
		 (aspiran.pago_insc = 1) 
USING gtr_SADM;

if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(lo_cuenta) + obten_digito(lo_cuenta)
	em_cuenta.triggerevent("activarbusq")
end if

end event

on uo_nombre_aspirante_insc_ing.create
this.em_cuenta=create em_cuenta
this.cbx_nuevo=create cbx_nuevo
this.dw_nombre_aspirante=create dw_nombre_aspirante
this.em_digito=create em_digito
this.st_2=create st_2
this.st_1=create st_1
this.uo_1=create uo_1
this.Control[]={this.em_cuenta,&
this.cbx_nuevo,&
this.dw_nombre_aspirante,&
this.em_digito,&
this.st_2,&
this.st_1,&
this.uo_1}
end on

on uo_nombre_aspirante_insc_ing.destroy
destroy(this.em_cuenta)
destroy(this.cbx_nuevo)
destroy(this.dw_nombre_aspirante)
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_1)
end on

event constructor;i_w_ventana=parent
end event

type em_cuenta from editmask within uo_nombre_aspirante_insc_ing
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modified pbm_enmodified
event activarbusq ( )
integer x = 161
integer y = 42
integer width = 271
integer height = 80
integer taborder = 10
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
string displaydata = ""
end type

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

event activarbusq;int cont
long cuenta
char digito,dig

	cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
	if cuenta > 1 then
		em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
		em_cuenta.text = string(cuenta)

		 SELECT aspiran.folio  
			   INTO :cuenta  
		    FROM aspiran  
	      WHERE (aspiran.folio = :cuenta) AND
					(aspiran.periodo = :gi_version) AND
					(aspiran.semestre = :gi_periodo) AND
					(aspiran.anio = :gi_anio)
		USING gtr_SADM;

		if cbx_nuevo.checked = true then
			
			em_digito.text =obten_digito(long(em_cuenta.text))		
			i_w_ventana.triggerevent(doubleclicked!)
			if dw_nombre_aspirante.event carga(cuenta) = 0 then
			   dw_nombre_aspirante.insertrow(0)
			end if
		elseif cbx_nuevo.checked = false then
			if gtr_sadm.sqlcode = 100 then
				messagebox("Atención","El aspirante con clave "+string(cuenta)+" no existe.")
				em_cuenta.text = " "
				em_digito.text=" "
				i_w_ventana.triggerevent(doubleclicked!)
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
				   i_w_ventana.triggerevent(doubleclicked!)	
				else
					messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)			
				end if	
			
			end if	
		end if
	else 
		em_digito.text=" "
		em_cuenta.text = " "
		i_w_ventana.triggerevent(doubleclicked!)
		if dw_nombre_aspirante.event carga(0) = 0 then
			  dw_nombre_aspirante.insertrow(0)
		end if
		em_cuenta.setfocus()
	end if
fin:
end event

type cbx_nuevo from checkbox within uo_nombre_aspirante_insc_ing
integer x = 2743
integer y = 48
integer width = 395
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Modificar"
borderstyle borderstyle = stylelowered!
end type

type dw_nombre_aspirante from datawindow within uo_nombre_aspirante_insc_ing
event type integer carga ( long cuenta )
integer y = 154
integer width = 3237
integer height = 262
integer taborder = 20
string dataobject = "dw_nombre_aspirante_insc_ing"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type integer carga(long cuenta);return retrieve(cuenta,gi_periodo,gi_anio)
end event

event itemchanged;string nombre,apat,amat,columna
char digito
long cuenta
param_obj_aspirante origen

columna = getcolumnname() 

CHOOSE CASE columna
	
  CASE "nombre"
	if cbx_nuevo.checked = true then		
		if w_datosgenerales.dw_3.RowCount()=1 then
			w_datosgenerales.dw_3.object.nombre[1]=data
		end if
	else
		nombre ="%"+gettext()+"%"
		SELECT general.cuenta  
	   INTO :cuenta  
	   FROM general, aspiran
	   WHERE (aspiran.ing_per = :gi_periodo) AND
      		(aspiran.ing_anio = :gi_anio) AND
				(general.nombre like :nombre) AND
				(general.folio = aspiran.folio) AND
				(general.clv_ver = aspiran.clv_ver) AND
				(general.clv_per = aspiran.clv_per) AND
				(general.anio = aspiran.anio)	AND
				( aspiran.pago_insc = 1 )
		USING gtr_sadm;
	end if

  CASE "apaterno"
	if cbx_nuevo.checked = true then		
		if w_datosgenerales.dw_3.RowCount()=1 then
			w_datosgenerales.dw_3.object.apaterno[1]=data
		end if
	else
	  apat ="%"+gettext()+"%"
	  SELECT general.cuenta  
	  INTO :cuenta  
	  FROM general, aspiran
	  WHERE (aspiran.ing_per = :gi_periodo) AND
      	  (aspiran.ing_anio = :gi_anio) AND
			  (general.apaterno like :apat) AND
				(general.folio = aspiran.folio) AND
				(general.clv_ver = aspiran.clv_ver) AND
				(general.clv_per = aspiran.clv_per) AND
				(general.anio = aspiran.anio)	AND
				( aspiran.pago_insc = 1 )			
		USING gtr_sadm;
	end if

  CASE "amaterno"
	if cbx_nuevo.checked = true then		
		if w_datosgenerales.dw_3.RowCount()=1 then
			w_datosgenerales.dw_3.object.amaterno[1]=data
		end if
	else
		amat ="%"+gettext()+"%"
		SELECT general.cuenta  
	   INTO :cuenta  
	   FROM general, aspiran
	   WHERE (aspiran.ing_per = :gi_periodo) AND
       		(aspiran.ing_anio = :gi_anio) AND
				(general.amaterno like :amat) AND
				(general.folio = aspiran.folio) AND
				(general.clv_ver = aspiran.clv_ver) AND
				(general.clv_per = aspiran.clv_per) AND
				(general.anio = aspiran.anio)	AND
				( aspiran.pago_insc = 1 )							
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

type em_digito from editmask within uo_nombre_aspirante_insc_ing
integer x = 490
integer y = 48
integer width = 77
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
string displaydata = "4"
end type

type st_2 from statictext within uo_nombre_aspirante_insc_ing
integer x = 443
integer y = 48
integer width = 51
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

type st_1 from statictext within uo_nombre_aspirante_insc_ing
integer y = 42
integer width = 150
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
boolean focusrectangle = false
end type

type uo_1 from uo_ver_per_ani within uo_nombre_aspirante_insc_ing
event destroy ( )
integer x = 443
integer height = 166
boolean bringtotop = true
boolean enabled = true
long backcolor = 1090519039
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

