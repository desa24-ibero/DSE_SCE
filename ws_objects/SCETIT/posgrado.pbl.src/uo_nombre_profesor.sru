$PBExportHeader$uo_nombre_profesor.sru
forward
global type uo_nombre_profesor from userobject
end type
type st_1 from statictext within uo_nombre_profesor
end type
type st_2 from statictext within uo_nombre_profesor
end type
type r_2 from rectangle within uo_nombre_profesor
end type
type dw_nombre_alumno from datawindow within uo_nombre_profesor
end type
type r_3 from rectangle within uo_nombre_profesor
end type
type cbx_nuevo from checkbox within uo_nombre_profesor
end type
type r_1 from rectangle within uo_nombre_profesor
end type
type em_cve_profesor from editmask within uo_nombre_profesor
end type
type em_digito from editmask within uo_nombre_profesor
end type
end forward

global type uo_nombre_profesor from userobject
integer width = 2757
integer height = 188
boolean enabled = false
long backcolor = 10789024
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
event primero ( )
event siguiente ( )
event anterior ( )
event ultimo ( )
st_1 st_1
st_2 st_2
r_2 r_2
dw_nombre_alumno dw_nombre_alumno
r_3 r_3
cbx_nuevo cbx_nuevo
r_1 r_1
em_cve_profesor em_cve_profesor
em_digito em_digito
end type
global uo_nombre_profesor uo_nombre_profesor

type variables
window iw_ventana
long il_cve_profesor=0
end variables

forward prototypes
public function integer revisa_num_cve_profesor ()
public function long of_obten_cve_profesor ()
public function string of_obten_nombre_completo ()
public function param_obj_nombre entrega_ventana ()
end prototypes

event primero;long ll_cve_profesor
char lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False

 SELECT min(profesor.cve_profesor )
    INTO :ll_cve_profesor  
    FROM profesor
	 USING gtr_sce;


if gtr_sce.sqlcode <> 100 then
//	em_cve_profesor.text = string(ll_cve_profesor)+ obten_digito(ll_cve_profesor)
	em_cve_profesor.text = string(ll_cve_profesor)
	em_cve_profesor.triggerevent("activarbusq")
end if	


end event

event siguiente;long ll_cve_profesor
char lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False
ll_cve_profesor = long(em_cve_profesor.text) 

SELECT min(profesor.cve_profesor  )
  INTO :ll_cve_profesor  
  FROM profesor  
 WHERE profesor.cve_profesor > :ll_cve_profesor
 USING gtr_sce;

if gtr_sce.sqlcode <> 100 then
//	em_cve_profesor.text = string(ll_cve_profesor) + obten_digito(ll_cve_profesor)
	em_cve_profesor.text = string(ll_cve_profesor) 
	em_cve_profesor.triggerevent("activarbusq")	
else
	Messagebox("Información","Este es el último alumno")
end if	
end event

event anterior;long	ll_cve_profesor,ll_cont
char	lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False
ll_cve_profesor = long(em_cve_profesor.text)
 
SELECT max(profesor.cve_profesor )
  INTO :ll_cve_profesor  
  FROM profesor  
 WHERE profesor.cve_profesor < :ll_cve_profesor
 USING gtr_sce;

if gtr_sce.sqlcode <> 100 then
//	em_cve_profesor.text = string(ll_cve_profesor) + obten_digito(ll_cve_profesor)
	em_cve_profesor.text = string(ll_cve_profesor) 
	em_cve_profesor.triggerevent("activarbusq")

else
	Messagebox("Información","Este es el primer alumno")
end if	

end event

event ultimo;long ll_cve_profesor
char lch_digito

setpointer(hourglass!)
cbx_nuevo.checked = False
 
SELECT max(profesor.cve_profesor)
INTO :ll_cve_profesor  
FROM profesor
USING gtr_sce;

if gtr_sce.sqlcode <> 100 then
//	em_cve_profesor.text = string(ll_cve_profesor) + obten_digito(ll_cve_profesor)
	em_cve_profesor.text = string(ll_cve_profesor) 
	em_cve_profesor.triggerevent("activarbusq")	
end if

end event

public function integer revisa_num_cve_profesor ();return 1
end function

public function long of_obten_cve_profesor ();//of_obten_cve_profesor
//Devuelve la clave del profesor actual
long ll_row_actual, ll_cve_profesor

if dw_nombre_alumno.RowCount()>0 then
	ll_row_actual = dw_nombre_alumno.GetRow()
	ll_cve_profesor = dw_nombre_alumno.GetItemNumber(ll_row_actual,"cve_profesor")
	return 	ll_cve_profesor
end if

return 0

end function

public function string of_obten_nombre_completo ();//of_obten_nombre_completo
//Devuelve el nombre_completo del profesor actual
long ll_row_actual
string ls_nombre_completo

if dw_nombre_alumno.RowCount()>0 then
	ll_row_actual = dw_nombre_alumno.GetRow()
	ls_nombre_completo = dw_nombre_alumno.GetItemString(ll_row_actual,"nombre_completo")
	return 	ls_nombre_completo
end if

return ""

end function

public function param_obj_nombre entrega_ventana ();param_obj_nombre origen
origen.nombre = this.dw_nombre_alumno
origen.cuenta = this.em_cve_profesor
origen.digito = this.em_digito
return origen
end function

on uo_nombre_profesor.create
this.st_1=create st_1
this.st_2=create st_2
this.r_2=create r_2
this.dw_nombre_alumno=create dw_nombre_alumno
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.r_1=create r_1
this.em_cve_profesor=create em_cve_profesor
this.em_digito=create em_digito
this.Control[]={this.st_1,&
this.st_2,&
this.r_2,&
this.dw_nombre_alumno,&
this.r_3,&
this.cbx_nuevo,&
this.r_1,&
this.em_cve_profesor,&
this.em_digito}
end on

on uo_nombre_profesor.destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.r_2)
destroy(this.dw_nombre_alumno)
destroy(this.r_3)
destroy(this.cbx_nuevo)
destroy(this.r_1)
destroy(this.em_cve_profesor)
destroy(this.em_digito)
end on

event constructor;dw_nombre_alumno.settransobject(gtr_sce)
dw_nombre_alumno.insertrow(0)
iw_ventana = parent

end event

type st_1 from statictext within uo_nombre_profesor
integer x = 50
integer y = 16
integer width = 384
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Clave Prof."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within uo_nombre_profesor
boolean visible = false
integer x = 375
integer y = 88
integer width = 41
integer height = 80
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

type r_2 from rectangle within uo_nombre_profesor
integer linethickness = 8
long fillcolor = 15780518
integer x = 946
integer y = 28
integer width = 393
integer height = 92
end type

type dw_nombre_alumno from datawindow within uo_nombre_profesor
integer x = 443
integer y = 12
integer width = 2299
integer height = 156
integer taborder = 30
string dataobject = "d_nombre_profesor"
boolean border = false
end type

event itemchanged;string ls_nombre,ls_apat,ls_amat,ls_columna
char lch_digito
long ll_cve_profesor

ll_cve_profesor= 999999

param_obj_nombre origen

if cbx_nuevo.checked = false then
	
	ls_columna = dw_nombre_alumno.getcolumnname()

	CHOOSE CASE ls_columna
		CASE "nombre"
		     ls_nombre ="%"+dw_nombre_alumno.gettext()+"%"
			  ls_apat="%--%"
			  ls_amat="%--%"
			  SELECT profesor.cve_profesor  
	    		 INTO :ll_cve_profesor  
	    	    FROM profesor  
	   		WHERE profesor.nombre like :ls_nombre
				AND	profesor.status = "A"
				USING gtr_sce;
		CASE "apaterno"
			  ls_nombre="%--%"
			  ls_amat="%--%"			
			  ls_apat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT profesor.cve_profesor  
	    		 INTO :ll_cve_profesor  
	    	    FROM profesor  
	   		WHERE profesor.apaterno like :ls_apat
				AND	profesor.status = "A"
				USING gtr_sce;
		CASE "amaterno"
			  ls_nombre="%--%"
			  ls_apat="%--%"
			  ls_amat ="%"+dw_nombre_alumno.gettext()+"%"			  
			  SELECT profesor.cve_profesor  
	    		 INTO :ll_cve_profesor  
	    	    FROM profesor  
	   		WHERE profesor.amaterno like :ls_amat
				AND	profesor.status = "A"
				USING gtr_sce;
	END CHOOSE	
	
	if gtr_sce.sqlerrtext = "Select returned more than one row" then
		origen = entrega_ventana()
		openwithparm(w_profesoresnombre,origen)
		if w_profesoresnombre.dw_nombre.retrieve(ls_nombre,ls_apat,ls_amat)  = 0 then
			messagebox("Aviso","No existe ningun "+mid(ls_nombre,2,len(ls_nombre)-2)+" "+mid(ls_apat,2,len(ls_apat)-2)+" "+mid(ls_amat,2,len(ls_amat)-2)+" dado de alta.")
			close(w_profesoresnombre)
		end if	
	else
		if dw_nombre_alumno.retrieve(ll_cve_profesor) = 0 then
			dw_nombre_alumno.insertrow(0)
		else 
			em_cve_profesor.text=string(ll_cve_profesor)
			lch_digito = obten_digito(ll_cve_profesor)
			em_digito.text=lch_digito
			iw_ventana.triggerevent("inicia_proceso",0,ll_cve_profesor)
			iw_ventana.triggerevent(doubleclicked!)
		end if	
	end if	
end if
end event

event getfocus;if isvalid(w_profesoresnombre) then
	close(w_profesoresnombre)
end if
end event

event retrieveend;//Asigna el numero de profesor
if rowcount > 0 then
	if this.Getitemstatus(this.getrow(),"cve_profesor",Primary!)=New!	then
		il_cve_profesor=0	
	else
		il_cve_profesor=this.getitemnumber(this.getrow(),"cve_profesor")
	end if
else
	il_cve_profesor=0	
end if

end event

type r_3 from rectangle within uo_nombre_profesor
boolean visible = false
integer linethickness = 8
long fillcolor = 30588249
integer x = 2807
integer y = 32
integer width = 407
integer height = 76
end type

type cbx_nuevo from checkbox within uo_nombre_profesor
boolean visible = false
integer x = 2811
integer y = 44
integer width = 393
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

type r_1 from rectangle within uo_nombre_profesor
long linecolor = 1090519039
integer linethickness = 8
long fillcolor = 10789024
integer x = 9
integer y = 4
integer width = 2752
integer height = 180
end type

type em_cve_profesor from editmask within uo_nombre_profesor
event activarbusq ( )
integer x = 55
integer y = 76
integer width = 366
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#####"
end type

event activarbusq;int li_cont
long ll_cve_profesor
char lch_digito,lch_dig

//	ll_cve_profesor = long(mid(em_cve_profesor.text,1,len(em_cve_profesor.text) - 1))
	ll_cve_profesor = long(em_cve_profesor.text)
	if ll_cve_profesor >= 1 then
//		em_digito.text = upper(mid(em_cve_profesor.text,len(em_cve_profesor.text),1))
 
//		em_cve_profesor.text = string(ll_cve_profesor)

		 SELECT profesor.cve_profesor  
			   INTO :ll_cve_profesor  
		    FROM profesor  
	      WHERE profesor.cve_profesor = :ll_cve_profesor
			AND	profesor.status = "A"
			USING gtr_sce;

		if cbx_nuevo.checked = true then
			
//			em_digito.text =obten_digito(long(em_cve_profesor.text))		
			iw_ventana.triggerevent("inicia_proceso",0,ll_cve_profesor)
			iw_ventana.triggerevent(doubleclicked!)
			if dw_nombre_alumno.retrieve(ll_cve_profesor) = 0 then
			   dw_nombre_alumno.insertrow(0)
			end if
		elseif cbx_nuevo.checked = false then
			if gtr_sce.sqlcode = 100 then
				messagebox("Atención","El profesor con clave "+string(ll_cve_profesor)+" no existe.")
				em_cve_profesor.text = " "
//				em_digito.text=" "
				iw_ventana.triggerevent("inicia_proceso",0,ll_cve_profesor)
				iw_ventana.triggerevent(doubleclicked!)
				if dw_nombre_alumno.retrieve(999999) = 0 then
			  		 dw_nombre_alumno.insertrow(0)
				end if
				goto fin
			end if
			em_cve_profesor.text = string(ll_cve_profesor)
//			if em_digito.text = "" then
//			em_digito.setfocus()
//			else	
//				lch_digito = upper(em_digito.text)
//				lch_dig = obten_digito(ll_cve_profesor)
//				if lch_digito = lch_dig then	
					if dw_nombre_alumno.retrieve(ll_cve_profesor) = 0 then
					   dw_nombre_alumno.insertrow(0)
					end if
				   iw_ventana.triggerevent("inicia_proceso",0,ll_cve_profesor)
					iw_ventana.triggerevent(doubleclicked!)
//				else
//					messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)			
//				end if	
			
//			end if	
		end if
	else 
//		em_digito.text=" "
		em_cve_profesor.text = " "
		iw_ventana.triggerevent("inicia_proceso",0,ll_cve_profesor)
		iw_ventana.triggerevent(doubleclicked!)
		if dw_nombre_alumno.retrieve(999999) = 0 then
			  dw_nombre_alumno.insertrow(0)
		end if
		em_cve_profesor.setfocus()
	end if
fin:
end event

event getfocus;if isvalid(w_profesoresnombre) then
	close(w_profesoresnombre)
end if

em_cve_profesor.selecttext(1,len(em_cve_profesor.text))
end event

event losefocus;if keydown(KeyEnter!) = true then
	triggerevent("activarbusq")	
end if
end event

event modified;if keydown(keyenter!) then	
	dw_nombre_alumno.setfocus()	
end if
end event

type em_digito from editmask within uo_nombre_profesor
boolean visible = false
integer x = 416
integer y = 80
integer width = 64
integer height = 80
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

