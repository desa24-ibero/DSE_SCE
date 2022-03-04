$PBExportHeader$w_cortes_diferidos.srw
forward
global type w_cortes_diferidos from Window
end type
type em_max from editmask within w_cortes_diferidos
end type
type em_min from editmask within w_cortes_diferidos
end type
type st_1 from statictext within w_cortes_diferidos
end type
type dw_1 from datawindow within w_cortes_diferidos
end type
type cb_1 from commandbutton within w_cortes_diferidos
end type
type uo_1 from uo_ver_per_ani within w_cortes_diferidos
end type
end forward

global type w_cortes_diferidos from Window
int X=833
int Y=361
int Width=2885
int Height=653
boolean TitleBar=true
string Title="Emisión de Cortes para DIFERIDOS"
string MenuName="m_menu"
event type long num_folios ( integer min_max )
event cambia_status ( long fol,  integer status )
em_max em_max
em_min em_min
st_1 st_1
dw_1 dw_1
cb_1 cb_1
uo_1 uo_1
end type
global w_cortes_diferidos w_cortes_diferidos

type variables

end variables

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

event cambia_status;UPDATE aspiran  
SET status = :status
WHERE ( aspiran.folio = :fol ) AND  
	( aspiran.clv_per = :gi_periodo ) AND  
	( aspiran.anio = :gi_anio )
USING gtr_sadm;
end event

on w_cortes_diferidos.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_max=create em_max
this.em_min=create em_min
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={ this.em_max,&
this.em_min,&
this.st_1,&
this.dw_1,&
this.cb_1,&
this.uo_1}
end on

on w_cortes_diferidos.destroy
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

type em_max from editmask within w_cortes_diferidos
int X=2378
int Y=173
int Width=407
int Height=101
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=","
double Increment=1
string MinMax="2~~999999"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_cortes_diferidos
int X=2378
int Y=45
int Width=407
int Height=101
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type st_1 from statictext within w_cortes_diferidos
int X=28
int Y=361
int Width=2286
int Height=77
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_cortes_diferidos
int X=179
int Y=613
int Width=494
int Height=361
boolean LiveScroll=true
end type

event constructor;m_menu.dw = this
end event

type cb_1 from commandbutton within w_cortes_diferidos
int X=2382
int Y=349
int Width=430
int Height=109
int TabOrder=10
string Text="Emite Cortes"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long fol,min,max,foli
int carr
double puntaje_acep,puntaje

SetPointer(HourGlass!)
min=long(em_min.text)
max=long(em_max.text)
FOR fol=min TO max

  SELECT aspiran.folio,aspiran.clv_carr,aspiran.puntaje
  INTO :foli,:carr,:puntaje
  FROM aspiran  
  WHERE  ( aspiran.clv_per = :gi_periodo ) AND  
         ( aspiran.anio = :gi_anio ) AND  
         ( aspiran.pago_exam = 1 ) AND  
			( aspiran.status = 3 or aspiran.status = 4 ) AND  
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
			event cambia_status(fol,4)
		else
			event cambia_status(fol,3)
		end if
	else
		st_1.text='No existe o no pago el folio, o no es DIFERIDO '+string(fol)
	end if
NEXT

commit using gtr_sadm;
st_1.text='Ya acabe'
end event

type uo_1 from uo_ver_per_ani within w_cortes_diferidos
int X=549
int Y=49
int Width=1244
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

