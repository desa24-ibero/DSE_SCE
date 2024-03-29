﻿$PBExportHeader$uo_nombre_carr_tit4.sru
$PBExportComments$Objeto para la ventana de Profesiones en Titulación
forward
global type uo_nombre_carr_tit4 from userobject
end type
type em_digito from editmask within uo_nombre_carr_tit4
end type
type st_2 from statictext within uo_nombre_carr_tit4
end type
type st_1 from statictext within uo_nombre_carr_tit4
end type
type r_3 from rectangle within uo_nombre_carr_tit4
end type
type cbx_nuevo from checkbox within uo_nombre_carr_tit4
end type
type vsb_dw_nombre_alumno from vscrollbar within uo_nombre_carr_tit4
end type
type cb_2 from commandbutton within uo_nombre_carr_tit4
end type
type cb_1 from commandbutton within uo_nombre_carr_tit4
end type
type rb_actual from radiobutton within uo_nombre_carr_tit4
end type
type rb_anterior from radiobutton within uo_nombre_carr_tit4
end type
type gb_2 from groupbox within uo_nombre_carr_tit4
end type
type gb_1 from groupbox within uo_nombre_carr_tit4
end type
type cbx_navega from checkbox within uo_nombre_carr_tit4
end type
type em_cuenta from editmask within uo_nombre_carr_tit4
end type
type dw_nombre_alumno from datawindow within uo_nombre_carr_tit4
end type
end forward

global type uo_nombre_carr_tit4 from userobject
integer width = 3534
integer height = 640
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
r_3 r_3
cbx_nuevo cbx_nuevo
vsb_dw_nombre_alumno vsb_dw_nombre_alumno
cb_2 cb_2
cb_1 cb_1
rb_actual rb_actual
rb_anterior rb_anterior
gb_2 gb_2
gb_1 gb_1
cbx_navega cbx_navega
em_cuenta em_cuenta
dw_nombre_alumno dw_nombre_alumno
end type
global uo_nombre_carr_tit4 uo_nombre_carr_tit4

type variables
window ventana
menu menu

end variables

forward prototypes
public function integer revisa_num_cuenta ()
public function param_obj_nombre entrega_ventana ()
end prototypes

event primero;long cuenta
char digito

setpointer(hourglass!) 
cbx_nuevo.checked = False
 SELECT alumnos.cuenta  
    INTO :cuenta  
    FROM alumnos  
ORDER BY alumnos.cuenta ASC  using gtr_sce;

if gtr_sce.sqlcode <> 100 then
	em_cuenta.text = string(cuenta) + obten_digito(cuenta)	
	em_cuenta.triggerevent("activarbusq")
end if	


end event

event siguiente;long cuenta
char digito
setpointer(hourglass!) 
cbx_nuevo.checked = False
cuenta = long(em_cuenta.text) 
SELECT alumnos.cuenta  
  INTO :cuenta  
  FROM alumnos  
 WHERE alumnos.cuenta > :cuenta   
ORDER BY alumnos.cuenta ASC  using gtr_sce;


if gtr_sce.sqlcode <> 100 then
	em_cuenta.text = string(cuenta) + obten_digito(cuenta)	
	em_cuenta.triggerevent("activarbusq")	
else
	Messagebox("Información","Este es el último alumno")
end if	
end event

event anterior;long cuenta,cont
char digito
setpointer(hourglass!) 
cbx_nuevo.checked = False
cuenta = long(em_cuenta.text)
 
SELECT alumnos.cuenta  
  INTO :cuenta  
  FROM alumnos  
 WHERE alumnos.cuenta < :cuenta   
ORDER BY alumnos.cuenta DESC  using gtr_sce;

if gtr_sce.sqlcode <> 100 then
	em_cuenta.text = string(cuenta) + obten_digito(cuenta)	
	em_cuenta.triggerevent("activarbusq")

else
	Messagebox("Información","Este es el primer alumno")
end if	

end event

event ultimo;long cuenta
char digito
 setpointer(hourglass!)
 cbx_nuevo.checked = False
 
 SELECT alumnos.cuenta  
    INTO :cuenta  
    FROM alumnos  
ORDER BY alumnos.cuenta DESC  using gtr_sce;

if gtr_sce.sqlcode <> 100 then
	em_cuenta.text = string(cuenta) + obten_digito(cuenta)	
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

on uo_nombre_carr_tit4.create
this.em_digito=create em_digito
this.st_2=create st_2
this.st_1=create st_1
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.vsb_dw_nombre_alumno=create vsb_dw_nombre_alumno
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_actual=create rb_actual
this.rb_anterior=create rb_anterior
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cbx_navega=create cbx_navega
this.em_cuenta=create em_cuenta
this.dw_nombre_alumno=create dw_nombre_alumno
this.Control[]={this.em_digito,&
this.st_2,&
this.st_1,&
this.r_3,&
this.cbx_nuevo,&
this.vsb_dw_nombre_alumno,&
this.cb_2,&
this.cb_1,&
this.rb_actual,&
this.rb_anterior,&
this.gb_2,&
this.gb_1,&
this.cbx_navega,&
this.em_cuenta,&
this.dw_nombre_alumno}
end on

on uo_nombre_carr_tit4.destroy
destroy(this.em_digito)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.r_3)
destroy(this.cbx_nuevo)
destroy(this.vsb_dw_nombre_alumno)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_actual)
destroy(this.rb_anterior)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cbx_navega)
destroy(this.em_cuenta)
destroy(this.dw_nombre_alumno)
end on

event constructor;dw_nombre_alumno.settransobject(gtr_sce)
dw_nombre_alumno.insertrow(0)
ventana = parent

end event

type em_digito from editmask within uo_nombre_carr_tit4
integer x = 827
integer y = 12
integer width = 64
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean border = false
boolean displayonly = true
maskdatatype maskdatatype = stringmask!
string mask = "!!"
string displaydata = ""
end type

type st_2 from statictext within uo_nombre_carr_tit4
integer x = 777
integer y = 12
integer width = 50
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "--"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_nombre_carr_tit4
integer x = 23
integer y = 12
integer width = 471
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "No. de Cuenta"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type r_3 from rectangle within uo_nombre_carr_tit4
boolean visible = false
integer linethickness = 3
long fillcolor = 30588249
integer x = 2807
integer y = 32
integer width = 407
integer height = 76
end type

type cbx_nuevo from checkbox within uo_nombre_carr_tit4
boolean visible = false
integer x = 2811
integer y = 36
integer width = 393
integer height = 64
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Modificar"
end type

type vsb_dw_nombre_alumno from vscrollbar within uo_nombre_carr_tit4
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 3456
integer y = 96
integer width = 73
integer height = 540
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_nombre_alumno.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if


end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_nombre_alumno.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_nombre_alumno.ScrollToRow(scrollpos)
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_nombre_alumno.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event constructor;visible=FALSE
end event

type cb_2 from commandbutton within uo_nombre_carr_tit4
string tag = "Este botón carga el registro de la Carrera Actual"
integer x = 2720
integer y = 388
integer width = 192
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<----"
end type

event clicked;/*Carga el DataWindow dw_1 con los datos del cetificado de la carrera actual*/
w_titulacion4.dw_1. event carga(w_titulacion4.uo_nombre.em_cuenta.Text,&
	string(dw_nombre_alumno.Object.academicos_cve_carrera[1]), &
	string(dw_nombre_alumno.Object.academicos_cve_plan[1]))
	
end event

event constructor;enabled=FALSE
visible=FALSE
gb_2.visible=FALSE


end event

type cb_1 from commandbutton within uo_nombre_carr_tit4
string tag = "Este botón carga el registro de la Carrera Anterior"
integer x = 2725
integer y = 508
integer width = 192
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<----"
end type

event clicked;/*Carga el DataWindow dw_1 con los datos del cetificado de la carrera anterior*/
w_titulacion4.dw_1. event carga(w_titulacion4.uo_nombre.em_cuenta.Text,&
	string(dw_nombre_alumno.Object.hist_carreras_cve_carrera_ant[dw_nombre_alumno.GetRow()]), &
	string(dw_nombre_alumno.Object.hist_carreras_cve_plan_ant[dw_nombre_alumno.GetRow()]))
	
end event

event constructor;enabled=FALSE
visible=FALSE

end event

type rb_actual from radiobutton within uo_nombre_carr_tit4
integer x = 3072
integer y = 384
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Actual  "
boolean checked = true
boolean lefttext = true
end type

event constructor;enabled=FALSE
visible=FALSE
gb_1.visible=FALSE
end event

type rb_anterior from radiobutton within uo_nombre_carr_tit4
integer x = 3072
integer y = 500
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Anterior"
boolean lefttext = true
end type

event constructor;enabled=FALSE
visible=FALSE

end event

type gb_2 from groupbox within uo_nombre_carr_tit4
integer x = 2661
integer y = 308
integer width = 320
integer height = 308
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Mostrar"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within uo_nombre_carr_tit4
integer x = 2994
integer y = 308
integer width = 439
integer height = 308
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Nuevos en"
borderstyle borderstyle = styleraised!
end type

type cbx_navega from checkbox within uo_nombre_carr_tit4
integer x = 1737
integer y = 12
integer width = 425
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Navegando..."
end type

type em_cuenta from editmask within uo_nombre_carr_tit4
event activarbusq ( )
event busqueda_simple ( string cuenta )
integer x = 530
integer y = 12
integer width = 247
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean border = false
alignment alignment = right!
maskdatatype maskdatatype = stringmask!
string mask = "##aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
string displaydata = ""
end type

event activarbusq();/*En cuento se genere el evento activarbusq...*/
long cuenta
char digito,dig

/*Verifica si hay cambios en el DataWindow dw_1 que no se hayan salvado*/
w_titulacion4.dw_1. event actualiza()

/*Si el número de cuenta entrado fué un 0*/
	if em_cuenta.text='0' then
		/*Deshabilita la opción nuevo del menú y habilita la de actualiza y borraregistro*/
  		m_titulacion.m_registro.m_nuevo.disable ( )
		m_titulacion.m_registro.m_actualiza.enable ( )
		m_titulacion.m_registro.m_borraregistro.enable ( )
		m_titulacion.m_registro.m_primero.enable ( )
		m_titulacion.m_registro.m_ultimo.enable ( )
		m_titulacion.m_registro.m_siguiente.enable ( )
		m_titulacion.m_registro.m_anterior.enable ( )
		
		/*Deshabilita los botones para (cargar/hacer nuevo) certificados de otras carreras*/
		cb_1.enabled=FALSE
		cb_2.enabled=FALSE
		rb_actual.enabled=FALSE
		rb_anterior.enabled=FALSE

		/*Prende la bandera de "navega" (está atras del DataWindow dw_nombre_alumno)*/
		parent.cbx_navega.checked=TRUE

		/*Llama al evento carga del DataWindow dw_1 con los parámetros 0,0 (carrera,clv plan)*/
//		if w_titulacion4.dw_1. event carga('0','0', '0')<>0 then
			/*Si el evento contestó algo diferente de 0, entonces si hay registros de 
				certificados solicitados. Ahora actualiza los datos del DataWindow 
				dw_nombre_alumno llamando al evento busqueda_simple*/
				
			// MALH 10/11/2017 SE COMENTA DEBIDO A QUE GENERABA ERROR AL CONSULTAR
			/*
				w_titulacion4.uo_nombre.em_cuenta.event busqueda_simple(string(&
				w_titulacion4.dw_1.Object.cuenta[w_titulacion4.dw_1.GetRow()]))
			*/
			
			w_titulacion4.uo_nombre.em_cuenta.event busqueda_simple(em_cuenta.text)

//		end if
	else
		/*Si el número de cuenta entrado no fue 0...*/
		/*Apaga la bandera de "navega"*/
		parent.cbx_navega.checked=FALSE
		m_titulacion.m_registro.m_primero.disable ( )
		m_titulacion.m_registro.m_ultimo.disable ( )
		m_titulacion.m_registro.m_siguiente.disable ( )
		m_titulacion.m_registro.m_anterior.disable ( )
		
	
		cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
		if cuenta > 1 then
			em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
 
			em_cuenta.text = string(cuenta)

		 	SELECT alumnos.cuenta  
			INTO :cuenta  
		   FROM alumnos  
	      WHERE alumnos.cuenta = :cuenta   using gtr_sce;

			if cbx_nuevo.checked = true then
			
				em_digito.text =obten_digito(long(em_cuenta.text))		
				//ventana.triggerevent(doubleclicked!)
				if dw_nombre_alumno.retrieve(cuenta) = 0 then
			   	dw_nombre_alumno.insertrow(0)
					w_titulacion4.dw_1.enabled = false
					w_titulacion4.dw_1.visible = false
					w_titulacion4.vsb_dw_certificado.visible=false
			end if
		elseif cbx_nuevo.checked = false then
				if gtr_sce.sqlcode = 100 then
					messagebox("Atención","El alumno con clave "+string(cuenta)+" no existe.")
					em_cuenta.text = " "
					em_digito.text=" "
					//ventana.triggerevent(doubleclicked!)
					if dw_nombre_alumno.retrieve(0) = 0 then
			  			dw_nombre_alumno.insertrow(0)
					end if
					goto fin
				end if
				em_cuenta.text = string(cuenta)
				if em_digito.text = "" then
					//em_digito.setfocus()
				else	
					digito = upper(em_digito.text)
					dig = obten_digito(cuenta)
					if digito = dig then	
						if dw_nombre_alumno.retrieve(cuenta) = 0 then
					   	dw_nombre_alumno.insertrow(0)
						end if
				  		// ventana.triggerevent(doubleclicked!)	
					else
						messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)			
						w_titulacion4.dw_1.enabled = false
					w_titulacion4.dw_1.visible = false
					w_titulacion4.vsb_dw_certificado.visible=false
					end if	
			
				end if	
			end if
		else 
			em_digito.text=" "
			em_cuenta.text = " "
			// ventana.triggerevent(doubleclicked!)
			if dw_nombre_alumno.retrieve(0) = 0 then
				dw_nombre_alumno.insertrow(0)
			end if
			em_cuenta.setfocus()
		end if
	end if
fin:
end event

event busqueda_simple;/*Cuando se genera el evento busqueda_simple...*/

/*Carga el DataWindow dw_nombre_alumno con los datos del número de cuenta que se le pasó 
como parámetro*/
dw_nombre_alumno.retrieve(long(cuenta))

/*Actualiza los campos del número de cuenta y del dígito verificador en los EditMask del
Objeto*/
em_digito.text=obten_digito(long(cuenta))
em_cuenta.text =cuenta
end event

event getfocus;em_cuenta.selecttext(1,len(em_cuenta.text))
end event

event modified;/*En cuanto se modifique el EditMask em_cuenta...*/

/*Ve si la última tecla oprimida fué un enter*/
if keydown(keyenter!) then	
	/*Si así fue, pon el foco en el DataWindow dw_nombre_alumno*/
	dw_nombre_alumno.setfocus()
	/*Activa el evento activarbusq*/
	triggerevent("activarbusq")
end if
end event

type dw_nombre_alumno from datawindow within uo_nombre_carr_tit4
integer y = 96
integer width = 3451
integer height = 540
integer taborder = 20
string dataobject = "dw_nombre_alumno_carrera"
end type

event getfocus;
if isvalid(w_alumnosnombre) then
	close(w_alumnosnombre)
end if
//
//if isvalid(w_datosgenerales) then
//	w_datosgenerales.triggerevent("cutnombre")
//end if
//
end event

event itemchanged;//datawindow origen
string nombre,apat,amat,columna
char digito
long cuenta

param_obj_nombre origen

//if cbx_nuevo.checked = false then
	
	columna = dw_nombre_alumno.getcolumnname() 

	CHOOSE CASE columna
		CASE "nombre"
		     nombre ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT alumnos.cuenta  
	    		 INTO :cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.nombre like :nombre   using gtr_sce;				
		CASE "apaterno"
			  apat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT alumnos.cuenta  
	    		 INTO :cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.apaterno like :apat   using gtr_sce;	
		CASE "amaterno"
			  amat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT alumnos.cuenta  
	    		 INTO :cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.amaterno like :amat   using gtr_sce;	
	END CHOOSE	
	
	if gtr_sce.sqlerrtext = "Select returned more than one row" then
		origen = entrega_ventana()
		openwithparm(w_alumnosnombre,origen)
		if w_alumnosnombre.dw_nombre.retrieve(nombre,apat,amat)  = 0 then
			messagebox("Aviso","No existe ningun "+mid(nombre,2,len(nombre)-2)+" "+mid(apat,2,len(apat)-2)+" "+mid(amat,2,len(amat)-2)+" dado de alta.")
			close(w_alumnosnombre)
		end if	
	else
		if dw_nombre_alumno.retrieve(cuenta) = 0 then
			dw_nombre_alumno.insertrow(0)
			w_titulacion4.dw_1.InsertRow(0) /**/
			w_titulacion4.dw_1.enabled = false /**/
			
		else 
			em_cuenta.text=string(cuenta)
			digito = obten_digito(cuenta)
			em_digito.text=digito
			w_titulacion4.dw_1. event carga(w_titulacion4.uo_nombre.em_cuenta.Text,& 
				string(Object.academicos_cve_carrera[1]), &
				string(Object.academicos_cve_plan[1])) /**/
			

      end if	
	end if	
//end if
				
end event

event retrieveend;/*En cuanto cabe de cargar datos el DataWindow dw_nombre_alumno...*/

if rowcount>1 then
	/*Si cargó más de 1 dato, haz visible el VerticalScrollBar*/
	vsb_dw_nombre_alumno.visible=TRUE
else
	vsb_dw_nombre_alumno.visible=FALSE
end if

if parent.cbx_navega.checked then
else
	/*Si no está habilitada la bandera "navega"*/
	if rowcount=0 then
		/*Si no se bajaron datos, deshabilita algunas opciones del menú,*/
  		m_titulacion.m_registro.m_nuevo.disable ( )
		m_titulacion.m_registro.m_actualiza.disable ( )
		m_titulacion.m_registro.m_borraregistro.disable ( )
		/*Inserta un renglón en el DataWindow dw_1 pero deshabilítalo,*/
		w_titulacion4.dw_1.InsertRow(0)
		w_titulacion4.dw_1.enabled = false
		
		/*Deshabilita y oculta los botones.*/
		cb_1.enabled=FALSE
		cb_2.enabled=FALSE
		cb_1.visible=FALSE
		cb_2.visible=FALSE
		rb_actual.enabled=FALSE
		rb_anterior.enabled=FALSE
		rb_actual.visible=FALSE
		rb_anterior.visible=FALSE
		gb_1.visible=FALSE
		gb_2.visible=FALSE
	else
		/*Habilita algunas opciones del menú,*/
  		m_titulacion.m_registro.m_nuevo.enable ( )
		m_titulacion.m_registro.m_actualiza.enable ( )
		m_titulacion.m_registro.m_borraregistro.enable ( )
		/*Llama al evento carga pasándole el número de cuenta y la clave de la carrera actual*/
		w_titulacion4.dw_1. event carga(w_titulacion4.uo_nombre.em_cuenta.Text,&
			string(Object.academicos_cve_carrera[1]), &
			string(Object.academicos_cve_plan[1]))
	  
	/*El máximo del VerticalScrollBar será el número de renglones que tenga el DataWindow*/
		vsb_dw_nombre_alumno.maxposition=rowcount
	
		if isnull(getitemnumber(1,"hist_carreras_cve_carrera_ant")) then
			/*Si el campo de la carrera anterior es nulo...*/
			
			rb_actual.checked=TRUE
			cb_1.enabled=FALSE
			cb_2.enabled=FALSE
			cb_1.visible=FALSE
			cb_2.visible=FALSE
			rb_actual.enabled=FALSE
			rb_anterior.enabled=FALSE
			rb_actual.visible=FALSE
			rb_anterior.visible=FALSE
			gb_1.visible=FALSE
			gb_2.visible=FALSE


		else
			gb_1.visible=TRUE
			gb_2.visible=TRUE
			cb_1.enabled=TRUE
			cb_2.enabled=TRUE
			cb_1.visible=TRUE
			cb_2.visible=TRUE
			rb_actual.enabled=TRUE
			rb_anterior.enabled=TRUE
			rb_actual.visible=TRUE
			rb_anterior.visible=TRUE
		end if
	end if

end if
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_nombre_alumno.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_nombre_alumno.position=currentrow

end if

end event

