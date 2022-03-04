$PBExportHeader$w_folios_disponibles.srw
forward
global type w_folios_disponibles from window
end type
type ddlb_periodo from dropdownlistbox within w_folios_disponibles
end type
type em_version from editmask within w_folios_disponibles
end type
type em_anio from editmask within w_folios_disponibles
end type
type st_4 from statictext within w_folios_disponibles
end type
type st_3 from statictext within w_folios_disponibles
end type
type st_2 from statictext within w_folios_disponibles
end type
type cb_salir from commandbutton within w_folios_disponibles
end type
type st_fin from statictext within w_folios_disponibles
end type
type st_inicio from statictext within w_folios_disponibles
end type
type st_1 from statictext within w_folios_disponibles
end type
type em_fin from editmask within w_folios_disponibles
end type
type em_inicio from editmask within w_folios_disponibles
end type
type cb_reservar from commandbutton within w_folios_disponibles
end type
end forward

global type w_folios_disponibles from window
integer width = 1938
integer height = 936
boolean titlebar = true
string title = "Reserva de Folios"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
ddlb_periodo ddlb_periodo
em_version em_version
em_anio em_anio
st_4 st_4
st_3 st_3
st_2 st_2
cb_salir cb_salir
st_fin st_fin
st_inicio st_inicio
st_1 st_1
em_fin em_fin
em_inicio em_inicio
cb_reservar cb_reservar
end type
global w_folios_disponibles w_folios_disponibles

forward prototypes
public function boolean wf_verifica_captura ()
end prototypes

public function boolean wf_verifica_captura ();long ll_inicio,ll_fin
integer li_anio,li_periodo,li_version


ll_inicio=long(em_inicio.text)
ll_fin=long(em_fin.text)
li_anio=long(em_anio.text)
li_version=long(em_version.text)
li_periodo=ddlb_periodo.finditem(ddlb_periodo.text,0) 
 

if em_anio.text="" then
	messagebox("Mensaje del Sistema","Debe capturar el año para verificar la reserva",stopsign!)
	return(true)
end if
if li_anio<0 then
	messagebox("Mensaje del Sistema","El año debe ser mayor a cero",stopsign!)
	return(true)
end if



if li_periodo=-1 then
	messagebox("Mensaje del Sistema","Debe seleccionar el periodo para verificar la reserva",stopsign!)
	return(true)
end if

if em_version.text="" then
	messagebox("Mensaje del Sistema","Debe capturar la versión para verificar la reserva",stopsign!)
	return(true)
end if
if li_version<=0 then
	messagebox("Mensaje del Sistema","La version debe ser mayor a cero",stopsign!)
	return(true)
end if



if em_inicio.text="" or em_fin.text="" then	
	messagebox("Mensaje del Sistema","Debe incluir el folio de Inicio y Fin",stopsign!)
	return(true)
end if

if ll_fin<ll_inicio then				
	messagebox("Mensaje del Sistema","El folio final no puede ser menor al inicial",stopsign!)
	return(true)
end if
	
return false
end function

on w_folios_disponibles.create
this.ddlb_periodo=create ddlb_periodo
this.em_version=create em_version
this.em_anio=create em_anio
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_salir=create cb_salir
this.st_fin=create st_fin
this.st_inicio=create st_inicio
this.st_1=create st_1
this.em_fin=create em_fin
this.em_inicio=create em_inicio
this.cb_reservar=create cb_reservar
this.Control[]={this.ddlb_periodo,&
this.em_version,&
this.em_anio,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_salir,&
this.st_fin,&
this.st_inicio,&
this.st_1,&
this.em_fin,&
this.em_inicio,&
this.cb_reservar}
end on

on w_folios_disponibles.destroy
destroy(this.ddlb_periodo)
destroy(this.em_version)
destroy(this.em_anio)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_salir)
destroy(this.st_fin)
destroy(this.st_inicio)
destroy(this.st_1)
destroy(this.em_fin)
destroy(this.em_inicio)
destroy(this.cb_reservar)
end on

type ddlb_periodo from dropdownlistbox within w_folios_disponibles
integer x = 768
integer y = 248
integer width = 608
integer height = 400
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"Primavera","Verano","Otoño"}
borderstyle borderstyle = stylelowered!
end type

type em_version from editmask within w_folios_disponibles
integer x = 1655
integer y = 244
integer width = 155
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#"
end type

type em_anio from editmask within w_folios_disponibles
integer x = 174
integer y = 248
integer width = 288
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type st_4 from statictext within w_folios_disponibles
integer x = 1417
integer y = 264
integer width = 233
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Versión"
boolean focusrectangle = false
end type

type st_3 from statictext within w_folios_disponibles
integer x = 526
integer y = 264
integer width = 242
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo"
boolean focusrectangle = false
end type

type st_2 from statictext within w_folios_disponibles
integer x = 41
integer y = 260
integer width = 133
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
boolean focusrectangle = false
end type

type cb_salir from commandbutton within w_folios_disponibles
integer x = 987
integer y = 688
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type st_fin from statictext within w_folios_disponibles
integer x = 960
integer y = 412
integer width = 535
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fin"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_inicio from statictext within w_folios_disponibles
integer x = 297
integer y = 412
integer width = 535
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inicio"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_folios_disponibles
integer x = 18
integer y = 36
integer width = 1865
integer height = 160
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Indique el intervalo de folios del CENEVAL que desea reservar para las solicitudes de trámite de inscripción por Internet"
boolean focusrectangle = false
end type

type em_fin from editmask within w_folios_disponibles
integer x = 965
integer y = 484
integer width = 517
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
string minmax = "0~~350000"
end type

type em_inicio from editmask within w_folios_disponibles
integer x = 302
integer y = 484
integer width = 517
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "######"
string minmax = "0~~350000"
end type

type cb_reservar from commandbutton within w_folios_disponibles
integer x = 389
integer y = 688
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reservar"
end type

event clicked;long ll_inicio, ll_fin,ll_existen,i
integer li_anio, li_periodo, li_version
boolean lb_error=false

if not(wf_verifica_captura()) then
	ll_inicio=long(em_inicio.text)
	ll_fin=long(em_fin.text)
	li_anio=long(em_anio.text)
	li_version=long(em_version.text)
	li_periodo=ddlb_periodo.finditem(ddlb_periodo.text,0) -1
	//VERIFICAMOS QUE EL INTERVALO SEÑALADO ESTE DISPONIBLE
	 SELECT count(folio)  
	   INTO :ll_existen  
	   FROM aspiran  
	  WHERE aspiran.clv_ver=:li_version and aspiran.clv_per=:li_periodo and aspiran.anio=:li_anio and  aspiran.folio  between :ll_inicio and :ll_fin using gtr_admision;
	if gtr_admision.sqlcode=0 then
		if ll_existen=0 then
			//LOS FOLIOS ESTAN DISPONIBLES, AHORA VERIFICAMOS SI HAN SIDO RESERVADOS ANTERIORMENTE
		    SELECT count(folio)  
		    INTO :ll_existen  
		    FROM cnv_folios_disponibles  
		    WHERE cnv_folios_disponibles.folio between :ll_inicio and :ll_fin using gtr_admision;
			 if gtr_admision.sqlcode=0 then
				if ll_existen=0 then							
					for i=ll_inicio to ll_fin 
						  INSERT INTO cnv_folios_disponibles  ( folio )   VALUES ( :i )  using gtr_admision;
						  if gtr_admision.sqlcode<> 0 then lb_error=true
					next
					if lb_error=false then
						commit using gtr_admision;
						messagebox("Mensaje del Sistema","Se ha reservado el intervalo indicado",exclamation!)
					else
						rollback using gtr_admision;
						messagebox("Mensaje del Sistema","Ha ocurrido un error al registrar la reserva de folios",stopsign!)
					end if
				else
					SELECT max(folio)
					INTO :ll_existen
					FROM cnv_folios_disponibles using gtr_admision; 
					messagebox("Mensaje del Sistema","Los folios que desea reservar se encuentran reservados con anterioridad~r El último folio reservado es: "+string(ll_existen),stopsign!)
				end if
		 else
				messagebox("Mensaje del Sistema","Ha ocurrido un error al determinar si los folios se encuentran reservados anteriormente",stopsign!)
			 end if
		else
			messagebox("Mensaje del Sistema","Los folios que desea reservar se encuentran actualmente en uso",stopsign!)
		end if
	else
		messagebox("Mensaje del Sistema","Ha ocurrido un error al determinar si los folios se encuentran ocupados",stopsign!)
	end if				
end if
end event

