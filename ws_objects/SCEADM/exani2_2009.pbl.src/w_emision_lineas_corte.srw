$PBExportHeader$w_emision_lineas_corte.srw
$PBExportComments$Cambia el Status a Aceptado o Rechazado según las líneas de corte
forward
global type w_emision_lineas_corte from w_main
end type
type em_max from editmask within w_emision_lineas_corte
end type
type em_min from editmask within w_emision_lineas_corte
end type
type st_1 from statictext within w_emision_lineas_corte
end type
type dw_1 from datawindow within w_emision_lineas_corte
end type
type cb_1 from commandbutton within w_emision_lineas_corte
end type
type uo_1 from uo_ver_per_ani within w_emision_lineas_corte
end type
end forward

global type w_emision_lineas_corte from w_main
integer x = 832
integer y = 360
integer width = 2885
integer height = 660
boolean titlebar = true
string title = "Emisión de Cortes"
string menuname = "m_menu"
event type long num_folios ( integer min_max )
event cambia_status ( long fol,  integer status )
em_max em_max
em_min em_min
st_1 st_1
dw_1 dw_1
cb_1 cb_1
uo_1 uo_1
end type
global w_emision_lineas_corte w_emision_lineas_corte

type variables

end variables

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

event cambia_status;UPDATE aspiran  
SET status = :status
WHERE ( aspiran.folio = :fol ) AND  
	( aspiran.clv_ver = :gi_version ) AND  
	( aspiran.clv_per = :gi_periodo ) AND  
	( aspiran.anio = :gi_anio )
USING gtr_sadm;
end event

on w_emision_lineas_corte.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_max=create em_max
this.em_min=create em_min
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={this.em_max,&
this.em_min,&
this.st_1,&
this.dw_1,&
this.cb_1,&
this.uo_1}
end on

on w_emision_lineas_corte.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

end event

type em_max from editmask within w_emision_lineas_corte
integer x = 2377
integer y = 172
integer width = 407
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ","
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_emision_lineas_corte
integer x = 2377
integer y = 44
integer width = 407
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type st_1 from statictext within w_emision_lineas_corte
integer x = 27
integer y = 360
integer width = 2286
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_emision_lineas_corte
integer x = 178
integer y = 612
integer width = 494
integer height = 360
boolean livescroll = true
end type

event constructor;m_menu.dw = this
end event

type cb_1 from commandbutton within w_emision_lineas_corte
integer x = 2382
integer y = 348
integer width = 430
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Emite Cortes"
end type

event clicked;long fol,min,max,foli
int carr,ing_per,ing_anio
double puntaje_dif,puntaje_acep,puntaje

SetPointer(HourGlass!)
min=long(em_min.text)
max=long(em_max.text)
FOR fol=min TO max

  SELECT aspiran.folio,aspiran.clv_carr,aspiran.puntaje,aspiran.ing_per,aspiran.ing_anio
  INTO :foli,:carr,:puntaje,:ing_per,:ing_anio
  FROM aspiran  
  WHERE ( aspiran.clv_ver = :gi_version ) AND  
         ( aspiran.clv_per = :gi_periodo ) AND  
         ( aspiran.anio = :gi_anio ) AND  
         ( aspiran.pago_exam = 1 ) AND  
         ( aspiran.folio = :fol )
	USING gtr_sadm;
	
	if fol=foli then

		st_1.text='Cortando al Folio '+string(fol)+' de '+string(max)
	
		SELECT lineas_corte.puntaje_acep
		INTO :puntaje_acep
		FROM lineas_corte
		WHERE lineas_corte.clv_carr = :carr
		USING gtr_sadm;
		
		if puntaje>=puntaje_acep then
			event cambia_status(fol,1)
		else
			if ing_per=gi_periodo and ing_anio=gi_anio then
				SELECT lineas_corte.puntaje_dif
				INTO :puntaje_dif
				FROM lineas_corte  
				WHERE lineas_corte.clv_carr = :carr
				USING gtr_sadm;
			
				if puntaje>=puntaje_dif then
					event cambia_status(fol,3)
				else
					event cambia_status(fol,0)
				end if
			else
				event cambia_status(fol,0)
			end if
		end if
	else
		st_1.text='No existe o no pago el folio '+string(fol)
	end if
NEXT

commit using gtr_sadm;
st_1.text='Ya acabe'
end event

type uo_1 from uo_ver_per_ani within w_emision_lineas_corte
integer x = 27
integer y = 48
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

