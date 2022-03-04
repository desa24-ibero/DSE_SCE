$PBExportHeader$uo_nombre_alumno_adm.sru
forward
global type uo_nombre_alumno_adm from UserObject
end type
type em_digito from editmask within uo_nombre_alumno_adm
end type
type st_2 from statictext within uo_nombre_alumno_adm
end type
type st_1 from statictext within uo_nombre_alumno_adm
end type
type r_2 from rectangle within uo_nombre_alumno_adm
end type
type dw_nombre_alumno from datawindow within uo_nombre_alumno_adm
end type
type r_3 from rectangle within uo_nombre_alumno_adm
end type
type cbx_nuevo from checkbox within uo_nombre_alumno_adm
end type
type r_1 from rectangle within uo_nombre_alumno_adm
end type
type em_cuenta from editmask within uo_nombre_alumno_adm
end type
end forward

global type uo_nombre_alumno_adm from UserObject
int Width=3240
int Height=426
boolean Enabled=false
long BackColor=10789024
long PictureMaskColor=553648127
long TabTextColor=41943040
long TabBackColor=80793808
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
global uo_nombre_alumno_adm uo_nombre_alumno_adm

type variables
window iw_ventana
end variables

forward prototypes
public function integer revisa_num_cuenta ()
public function param_obj_nombre entrega_ventana ()
end prototypes

event primero;long ll_cuenta
char lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False

 SELECT min(general.cuenta )
    INTO :ll_cuenta  
    FROM general
	 USING gtr_sadm;


if gtr_sadm.sqlcode <> 100 then
	em_cuenta.text = string(ll_cuenta) + obten_digito(ll_cuenta)
	em_cuenta.triggerevent("activarbusq")
end if	


end event

event siguiente;long ll_cuenta
char lch_digito

setpointer(hourglass!) 
cbx_nuevo.checked = False
ll_cuenta = long(em_cuenta.text) 

SELECT min(general.cuenta  )
  INTO :ll_cuenta  
  FROM general  
 WHERE general.cuenta > :ll_cuenta
 USING gtr_sadm;

if gtr_sadm.sqlcode <> 100 then
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
 
SELECT max(general.cuenta )
  INTO :ll_cuenta  
  FROM general  
 WHERE general.cuenta < :ll_cuenta
 USING gtr_sadm;

if gtr_sadm.sqlcode <> 100 then
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
 
SELECT max(general.cuenta)
INTO :ll_cuenta  
FROM general
USING gtr_sadm;

if gtr_sadm.sqlcode <> 100 then
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

on uo_nombre_alumno_adm.create
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

on uo_nombre_alumno_adm.destroy
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

event constructor;dw_nombre_alumno.insertrow(0)
iw_ventana = parent

end event

type em_digito from editmask within uo_nombre_alumno_adm
int X=856
int Y=29
int Width=66
int Height=80
boolean Enabled=false
boolean Border=false
string Mask="!!"
MaskDataType MaskDataType=StringMask!
string DisplayData=""
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within uo_nombre_alumno_adm
int X=816
int Y=29
int Width=40
int Height=80
boolean Enabled=false
string Text="-"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BorderColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within uo_nombre_alumno_adm
int X=40
int Y=29
int Width=472
int Height=80
boolean Enabled=false
boolean Border=true
string Text="No. de Cuenta"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
long BorderColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_2 from rectangle within uo_nombre_alumno_adm
int X=944
int Y=26
int Width=395
int Height=90
boolean Enabled=false
int LineThickness=6
long FillColor=15780518
end type

type dw_nombre_alumno from datawindow within uo_nombre_alumno_adm
int X=33
int Y=138
int Width=3185
int Height=256
int TabOrder=30
string DataObject="dw_nombre_alumno_adm"
boolean Border=false
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
			  SELECT general.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM general  
	   		WHERE general.nombre like :ls_nombre
				USING gtr_sadm;
		CASE "apaterno"
			  ls_nombre="%--%"
			  ls_amat="%--%"			
			  ls_apat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT general.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM general  
	   		WHERE general.apaterno like :ls_apat
				USING gtr_sadm;
		CASE "amaterno"
			  ls_nombre="%--%"
			  ls_apat="%--%"
			  ls_amat ="%"+dw_nombre_alumno.gettext()+"%"			  
			  SELECT general.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM general  
	   		WHERE general.amaterno like :ls_amat
				USING gtr_sadm;
	END CHOOSE	
	
	if gtr_sadm.sqlerrtext = "Select returned more than one row" then
		origen = entrega_ventana()
		openwithparm(w_alumnosnombre_adm,origen)
		if w_alumnosnombre_adm.dw_nombre.retrieve(ls_nombre,ls_apat,ls_amat)  = 0 then
			messagebox("Aviso","No existe ningun "+mid(ls_nombre,2,len(ls_nombre)-2)+" "+mid(ls_apat,2,len(ls_apat)-2)+" "+mid(ls_amat,2,len(ls_amat)-2)+" dado de alta.")
			close(w_alumnosnombre_adm)
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

event getfocus;if isvalid(w_alumnosnombre_adm) then
	close(w_alumnosnombre_adm)
end if
end event

type r_3 from rectangle within uo_nombre_alumno_adm
int X=2809
int Y=32
int Width=406
int Height=74
boolean Visible=false
boolean Enabled=false
int LineThickness=6
long FillColor=30588249
end type

type cbx_nuevo from checkbox within uo_nombre_alumno_adm
int X=2812
int Y=38
int Width=395
int Height=64
int TabOrder=10
boolean Visible=false
boolean Enabled=false
string Text="Modificar"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within uo_nombre_alumno_adm
int X=22
int Y=6
int Width=3204
int Height=394
boolean Enabled=false
int LineThickness=6
long LineColor=1090519039
long FillColor=10789024
end type

type em_cuenta from editmask within uo_nombre_alumno_adm
event activarbusq ( )
int X=534
int Y=29
int Width=278
int Height=80
int TabOrder=20
boolean BringToTop=true
Alignment Alignment=Right!
boolean Border=false
string Mask="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
MaskDataType MaskDataType=StringMask!
string DisplayData="Ä"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event activarbusq;int li_cont
long ll_cuenta
char lch_digito,lch_dig

	ll_cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
	if ll_cuenta > 1 then
		em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
 
		em_cuenta.text = string(ll_cuenta)

		 SELECT general.cuenta  
			   INTO :ll_cuenta  
		    FROM general  
	      WHERE general.cuenta = :ll_cuenta
			USING gtr_sadm;

		if cbx_nuevo.checked = true then
			
			em_digito.text =obten_digito(long(em_cuenta.text))		
			iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
			if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
			   dw_nombre_alumno.insertrow(0)
			end if
		elseif cbx_nuevo.checked = false then
			if gtr_sadm.sqlcode = 100 then
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

event getfocus;if isvalid(w_alumnosnombre_adm) then
	close(w_alumnosnombre_adm)
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

