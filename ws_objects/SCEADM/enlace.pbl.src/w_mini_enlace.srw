$PBExportHeader$w_mini_enlace.srw
forward
global type w_mini_enlace from Window
end type
type em_ani from editmask within w_mini_enlace
end type
type vsb_dw_per from vscrollbar within w_mini_enlace
end type
type dw_per from datawindow within w_mini_enlace
end type
type ddlb_1 from dropdownlistbox within w_mini_enlace
end type
type uo_1 from uo_ver_per_ani within w_mini_enlace
end type
type dw_1 from uo_dw_captura within w_mini_enlace
end type
end forward

global type w_mini_enlace from Window
int X=834
int Y=362
int Width=3672
int Height=1958
boolean TitleBar=true
string Title="Enlace Entre Periodos"
string MenuName="m_menu"
long BackColor=30976088
em_ani em_ani
vsb_dw_per vsb_dw_per
dw_per dw_per
ddlb_1 ddlb_1
uo_1 uo_1
dw_1 dw_1
end type
global w_mini_enlace w_mini_enlace

type variables
int ord
end variables

on w_mini_enlace.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_ani=create em_ani
this.vsb_dw_per=create vsb_dw_per
this.dw_per=create dw_per
this.ddlb_1=create ddlb_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.em_ani,&
this.vsb_dw_per,&
this.dw_per,&
this.ddlb_1,&
this.uo_1,&
this.dw_1}
end on

on w_mini_enlace.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_ani)
destroy(this.vsb_dw_per)
destroy(this.dw_per)
destroy(this.ddlb_1)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type em_ani from editmask within w_mini_enlace
event modified pbm_enmodified
int X=2245
int Y=48
int Width=347
int Height=102
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
boolean AutoSkip=true
boolean Spin=true
string DisplayData=""
double Increment=1
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(gi_anio)
end event

type vsb_dw_per from vscrollbar within w_mini_enlace
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
int X=3306
int Y=45
int Width=106
int Height=106
boolean Enabled=false
boolean BringToTop=true
boolean StdWidth=false
int MinPosition=1
int Position=1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
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
maxposition=dw_per.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_per.ScrollToRow(scrollpos)
	

end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_per.RowCount() then
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

type dw_per from datawindow within w_mini_enlace
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
int X=2670
int Y=45
int Width=625
int Height=106
string DataObject="dw_periodo"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(gtr_sadm)
retrieve()
scrolltorow(gi_periodo+1)
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if RowCount()<>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_per.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_per.position=currentrow

end if
end event

type ddlb_1 from dropdownlistbox within w_mini_enlace
int X=1576
int Y=45
int Width=347
int Height=230
boolean VScrollBar=true
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Cuenta",&
"Folio",&
"Nombre"}
end type

event selectionchanged;CHOOSE CASE index
	CASE 1
		dw_1.SetSort("general_cuenta")
		dw_1.Sort( ) 
	CASE 2
		dw_1.SetSort("aspiran_folio")
		dw_1.Sort( ) 
	CASE 3
		dw_1.SetSort("nomb")
		dw_1.Sort( ) 
END CHOOSE

end event

type uo_1 from uo_ver_per_ani within w_mini_enlace
int X=0
int Y=16
int Width=1251
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_mini_enlace
int X=22
int Y=202
int Width=3606
int Height=1558
int TabOrder=0
string DataObject="dw_mini_enlace"
end type

event carga;/*Antes de cargar algo, ve si hay modificaciones no guardadas*/
event primero()
return retrieve(gi_periodo,gi_anio)
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event actualiza;/**/
return 0
end event

event borra;/**/
end event

event nuevo;/**/
end event

event doubleclicked;int nvo_anio,nvo_peri,clv_carr,estado,lugar_nac,nacional,edo_civil
int religion,bachillera,trabajo,trab_hor,ya_inscri,transporte,pago_insc, li_num_padres
long folio,cuenta
real puntaje,promedio
string nombre,apaterno,amaterno,calle,codigo_pos,colonia,telefono,sexo, ls_sexo_padre
datetime fecha_nac,hoy

hoy=datetime(today(),now())

if row>0 then
	ok = messagebox(string(object.aspiran_folio[row])+' '+object.nomb[row],&
		"Con número de Cuenta: "+string(object.cuent[row]),Exclamation!, OKCancel!, 2)
	IF ok = 1 THEN 
		folio=object.aspiran_folio[row]
		nvo_anio=integer(em_ani.text)
		nvo_peri=dw_per.object.clv_per[dw_per.getrow()]
		if nvo_anio=gi_anio and nvo_peri=gi_periodo then
			messagebox("Error","Cambia el periodo y/o año de destino")
		else

			SELECT clv_carr,promedio,puntaje,pago_insc  
			INTO :clv_carr,:promedio,:puntaje,:pago_insc  
			FROM aspiran  
			WHERE folio = :folio AND clv_per = :gi_periodo AND anio = :gi_anio
			USING gtr_sadm;
			
			INSERT INTO aspiran  
				( folio,clv_ver,clv_per,anio,clv_carr,promedio,status,puntaje,pago_exam,salon,
				lugar_gen,lugar_car,num_paq,pago_insc, ing_per, ing_anio )  
			VALUES ( :folio,0,:nvo_peri,:nvo_anio,:clv_carr,:promedio,1,:puntaje,1,'00TV',   
				0, 0, 0, :pago_insc, :nvo_peri, :nvo_anio )
			USING gtr_sadm;
			if gtr_sadm.sqlerrtext<>"" then
				messagebox("",gtr_sadm.sqlerrtext)
				rollback using gtr_sadm;
				return
			end if		
			commit using gtr_sadm;
			
			SELECT nombre,apaterno,amaterno,calle,codigo_pos,colonia,estado,telefono,
				fecha_nac,lugar_nac,nacional,sexo,edo_civil,religion,bachillera,trabajo,
				trab_hor,ya_inscri,cuenta,transporte  
			INTO :nombre,:apaterno,:amaterno,:calle,:codigo_pos,:colonia,:estado,
				:telefono,:fecha_nac,:lugar_nac,:nacional,:sexo,:edo_civil,:religion,:bachillera,   
				:trabajo,:trab_hor,:ya_inscri,:cuenta,:transporte  
			FROM general  
			WHERE folio = :folio AND clv_per = :gi_periodo AND anio = :gi_anio
			USING gtr_sadm;
			
			INSERT INTO general  
				( folio,clv_ver,clv_per,anio,nombre,apaterno,amaterno,calle,codigo_pos,colonia,   
				estado,telefono,fecha_nac,lugar_nac,nacional,sexo,edo_civil,religion,bachillera,   
				trabajo,trab_hor,ya_inscri,cuenta,transporte )  
			VALUES ( :folio,0,:nvo_peri,:nvo_anio,:nombre,:apaterno,:amaterno,:calle,:codigo_pos,   
				:colonia,:estado,:telefono,:fecha_nac,:lugar_nac,:nacional,:sexo,:edo_civil,
				:religion,:bachillera,:trabajo,:trab_hor,:ya_inscri,:cuenta,:transporte )
			USING gtr_sadm;
			if gtr_sadm.sqlerrtext<>"" then
				messagebox("",gtr_sadm.sqlerrtext)
				rollback using gtr_sadm;
				return
			end if		
			commit using gtr_sadm;
			
			SELECT nombre,apaterno,amaterno,calle,codigo_pos,colonia,estado,telefono, sexo  
			INTO :nombre,:apaterno,:amaterno,:calle,:codigo_pos,:colonia,:estado,:telefono, :ls_sexo_padre  
			FROM padres  
			WHERE folio = :folio AND clv_per = :gi_periodo AND anio = :gi_anio
			USING gtr_sadm;
			
			SELECT count(*)
			INTO :li_num_padres
			FROM padres  
			WHERE folio = :folio AND clv_per = :nvo_peri AND anio = :nvo_anio AND clv_ver = 0
			USING gtr_sadm;
			
			if li_num_padres > 0 then
				UPDATE padres
				SET nombre = :nombre,
					apaterno = :apaterno,
					amaterno = :amaterno,
					calle = :calle,
					codigo_pos = :codigo_pos,
					colonia = :colonia,   
					estado = :estado,
					telefono = :telefono,
					sexo = :ls_sexo_padre
				FROM padres
				WHERE folio = :folio AND clv_per = :nvo_peri AND anio = :nvo_anio AND clv_ver = 0
				USING gtr_sadm;
				
				if gtr_sadm.sqlcode<>0 then
					messagebox("",gtr_sadm.sqlerrtext)
					rollback using gtr_sadm;
					return
				end if						
			else

				INSERT INTO padres  
					( folio,clv_ver,clv_per,anio,nombre,apaterno,amaterno,calle,codigo_pos,colonia,   
					estado,telefono, sexo )  
				VALUES ( :folio,0,:nvo_peri,:nvo_anio,:nombre,:apaterno,:amaterno,:calle,
					:codigo_pos,:colonia,:estado,:telefono, :ls_sexo_padre )
				USING gtr_sadm;
				if gtr_sadm.sqlerrtext<>"" then
					messagebox("",gtr_sadm.sqlerrtext)
					rollback using gtr_sadm;
					return
				end if		
			end if
			commit using gtr_sadm;
			
			INSERT INTO bita_bachi  
				( folio,clv_ver,clv_per,anio,fecha,nuevo,anterior,usuario )  
			VALUES ( :folio,0,:nvo_peri,:nvo_anio,:hoy,:promedio,NULL,:gs_usuario )
			USING gtr_sadm;
			if gtr_sadm.sqlerrtext<>"" then
				messagebox("",gtr_sadm.sqlerrtext)
				rollback using gtr_sadm;
				return
			end if
			commit using gtr_sadm;
			
			if pago_insc=1 then
				INSERT INTO apartados_extemporaneos
					( cuenta,clv_per_org,anio_org,clv_per_nvo,anio_nvo,fecha_mov,checado )
				VALUES ( :cuenta,:gi_periodo,:gi_anio,:nvo_peri,:nvo_anio,:hoy,0 )
				using gtr_sadm;
				if gtr_sadm.sqlerrtext<>"" then
					messagebox("",gtr_sadm.sqlerrtext)
					rollback using gtr_sadm;
					return
				end if		
				commit using gtr_sadm;
			end if		
		end if		
	END IF
end if
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

