$PBExportHeader$w_califica.srw
$PBExportComments$Ventana que califica secciones, áreas y da los puntajes en base a las calificaciones dadas por el CENEVAL.
forward
global type w_califica from window
end type
type dw_1 from datawindow within w_califica
end type
type em_max from editmask within w_califica
end type
type em_min from editmask within w_califica
end type
type st_1 from statictext within w_califica
end type
type cb_1 from commandbutton within w_califica
end type
type uo_1 from uo_ver_per_ani within w_califica
end type
end forward

global type w_califica from window
integer x = 832
integer y = 360
integer width = 2885
integer height = 672
boolean titlebar = true
string title = "Calificación de Exámenes"
string menuname = "m_menu"
event type long num_folios ( integer min_max )
event type integer obten_carr ( long fol )
event cal_are ( long fol,  integer area,  integer carr )
event type real pes_are ( long fol,  integer area,  integer carr )
event da_puntaje ( long fol,  real acumula )
dw_1 dw_1
em_max em_max
em_min em_min
st_1 st_1
cb_1 cb_1
uo_1 uo_1
end type
global w_califica w_califica

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

event obten_carr;int carr

SELECT aspiran.clv_carr
INTO :carr
FROM aspiran  
WHERE ( aspiran.folio = :fol ) AND
	( aspiran.clv_ver = :gi_version ) AND  
	( aspiran.clv_per = :gi_periodo ) AND  
	( aspiran.anio = :gi_anio )   
USING gtr_sadm;
	
return carr

end event

event cal_are(long fol, integer area, integer carr);real valor

		SELECT sum(round(cali_sec.calif,2) * round(sec_peso.peso,2))
		INTO :valor  
		FROM cali_sec, sec_peso  
		WHERE ( cali_sec.folio = :fol ) AND  
			( cali_sec.clv_ver = :gi_version ) AND  
			( cali_sec.clv_per = :gi_periodo ) AND  
			( cali_sec.anio = :gi_anio ) AND  
			( cali_sec.clv_area = :area ) and  
			( sec_peso.clv_carr= :carr ) and
			( sec_peso.clv_area = :area ) and  
			( sec_peso.clv_sec = cali_sec.clv_sec )
		USING gtr_sadm;
					
		UPDATE cali_are
		SET calif = round(:valor,2)
		WHERE ( cali_are.folio = :fol ) AND  
			( cali_are.clv_ver = :gi_version ) AND  
			( cali_are.clv_per = :gi_periodo ) AND  
			( cali_are.anio = :gi_anio ) AND  
			( cali_are.clv_area = :area )   
		USING gtr_sadm;
end event

event pes_are;real valor

		SELECT round(cali_are.calif,2)*round(area_pes.peso,5)/100.00000
		INTO :valor
		FROM cali_are, area_pes  
		WHERE ( cali_are.clv_area = area_pes.clv_area ) and  
			( cali_are.folio = :fol ) AND  
			( cali_are.clv_ver = :gi_version ) AND  
			( cali_are.clv_per = :gi_periodo ) AND  
			( cali_are.anio = :gi_anio ) AND  
			( area_pes.clv_carr = :carr ) AND  
			( cali_are.clv_area = :area )
		USING gtr_sadm;		

return round(valor,2)
end event

event da_puntaje(long fol, real acumula);real valor

//		UPDATE aspiran
//		SET puntaje = round(:acumula+round(promedio,2) * 40.00000,2)
//		WHERE ( aspiran.folio = :fol ) AND  
//			( aspiran.clv_ver = :gi_version ) AND  
//			( aspiran.clv_per = :gi_periodo ) AND  
//			( aspiran.anio = :gi_anio )   
//		USING gtr_sadm;


		UPDATE aspiran
		SET puntaje = round(:acumula+round(aspiran.promedio,2) * promedio_peso.peso,2)
		FROM aspiran, promedio_peso
		WHERE ( aspiran.folio = :fol ) AND  
			( aspiran.clv_ver = :gi_version ) AND  
			( aspiran.clv_per = :gi_periodo ) AND  
			( aspiran.anio = :gi_anio )   AND
			( aspiran.clv_carr = promedio_peso.clv_carr)
		USING gtr_sadm;
		
		
		
end event

on w_califica.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.em_max=create em_max
this.em_min=create em_min
this.st_1=create st_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={this.dw_1,&
this.em_max,&
this.em_min,&
this.st_1,&
this.cb_1,&
this.uo_1}
end on

on w_califica.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event activate;x=1
y=1

end event

type dw_1 from datawindow within w_califica
event constructor pbm_constructor
integer x = 178
integer y = 612
integer width = 494
integer height = 360
boolean livescroll = true
end type

event constructor;m_menu.dw = this
end event

type em_max from editmask within w_califica
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

type em_min from editmask within w_califica
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

type st_1 from statictext within w_califica
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

type cb_1 from commandbutton within w_califica
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
string text = "Califica"
end type

event clicked;long foli,fol,min,max
int carr,area
real valor, acumula

SetPointer(HourGlass!)
min=long(em_min.text)
max=long(em_max.text)
FOR fol=min TO max

  SELECT aspiran.folio  
  INTO :foli
  FROM aspiran  
  WHERE ( aspiran.clv_ver = :gi_version ) AND  
         ( aspiran.clv_per = :gi_periodo ) AND  
         ( aspiran.anio = :gi_anio ) AND  
         ( aspiran.pago_exam = 1 ) AND  
         ( aspiran.folio = :fol )    
	USING gtr_sadm;

	if fol=foli then
		
		carr=event obten_carr(fol)
		FOR area=1 TO 4
			st_1.text='Calificando el área '+string(area)+' del Folio '+string(fol)+' de '+string(max)
			event cal_are(fol,area,carr)
		NEXT
		commit using gtr_sce;
	
		acumula=0
		FOR area=1 TO 4
			st_1.text='Dando puntaje al área '+string(area)+' del Folio '+string(fol)+' de '+string(max)
			acumula=acumula+event pes_are(fol,area,carr)
		NEXT
		st_1.text='Dando puntaje al Folio '+string(fol)+' de '+string(max)
		event da_puntaje(fol,acumula)	
		commit using gtr_sce;
	else
		st_1.text='No existe o no pago el folio '+string(fol)
	end if
NEXT
st_1.text='Ya acabe'
end event

type uo_1 from uo_ver_per_ani within w_califica
integer x = 27
integer y = 48
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

