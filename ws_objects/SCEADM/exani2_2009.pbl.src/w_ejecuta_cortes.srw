$PBExportHeader$w_ejecuta_cortes.srw
$PBExportComments$Cambia el Status a Aceptado o Rechazado según las líneas de corte
forward
global type w_ejecuta_cortes from w_main
end type
type cb_2 from commandbutton within w_ejecuta_cortes
end type
type dw_aspiran_ejecuta_cortes from u_dw within w_ejecuta_cortes
end type
type em_max from editmask within w_ejecuta_cortes
end type
type em_min from editmask within w_ejecuta_cortes
end type
type st_1 from statictext within w_ejecuta_cortes
end type
type cb_1 from commandbutton within w_ejecuta_cortes
end type
type uo_1 from uo_ver_per_ani within w_ejecuta_cortes
end type
end forward

global type w_ejecuta_cortes from w_main
integer x = 832
integer y = 360
integer width = 3621
integer height = 2004
string title = "Ejecución de Cortes"
string menuname = "m_menu"
event type long num_folios ( integer min_max )
event cambia_status ( long fol,  integer status )
cb_2 cb_2
dw_aspiran_ejecuta_cortes dw_aspiran_ejecuta_cortes
em_max em_max
em_min em_min
st_1 st_1
cb_1 cb_1
uo_1 uo_1
end type
global w_ejecuta_cortes w_ejecuta_cortes

type variables

transaction itr_admision_web


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

on w_ejecuta_cortes.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_2=create cb_2
this.dw_aspiran_ejecuta_cortes=create dw_aspiran_ejecuta_cortes
this.em_max=create em_max
this.em_min=create em_min
this.st_1=create st_1
this.cb_1=create cb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.dw_aspiran_ejecuta_cortes
this.Control[iCurrent+3]=this.em_max
this.Control[iCurrent+4]=this.em_min
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_1
end on

on w_ejecuta_cortes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.dw_aspiran_ejecuta_cortes)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_aspiran_ejecuta_cortes.SetTransObject(gtr_sadm)
this.of_SetResize(TRUE)

this.inv_resize.of_Register &
 (dw_aspiran_ejecuta_cortes, this.inv_resize.SCALERIGHTBOTTOM)
 
dw_aspiran_ejecuta_cortes.of_SetSort(TRUE)
dw_aspiran_ejecuta_cortes.inv_sort.of_SetColumnHeader(TRUE)


INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if
end event

event close;call super::close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type cb_2 from commandbutton within w_ejecuta_cortes
integer x = 2382
integer y = 292
integer width = 512
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga Aspirantes"
end type

event clicked;long ll_rows, ll_min, ll_max

ll_min=long(em_min.text)
ll_max=long(em_max.text)

ll_rows = dw_aspiran_ejecuta_cortes.Retrieve(gi_version,gi_periodo, gi_anio, ll_min, ll_max )
end event

type dw_aspiran_ejecuta_cortes from u_dw within w_ejecuta_cortes
integer x = 59
integer y = 560
integer width = 3433
integer height = 1192
integer taborder = 40
string dataobject = "d_aspiran_ejecuta_cortes"
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

type em_max from editmask within w_ejecuta_cortes
integer x = 2377
integer y = 172
integer width = 407
integer height = 100
integer taborder = 20
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

type em_min from editmask within w_ejecuta_cortes
integer x = 2377
integer y = 44
integer width = 407
integer height = 100
integer taborder = 10
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

type st_1 from statictext within w_ejecuta_cortes
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

type cb_1 from commandbutton within w_ejecuta_cortes
integer x = 2382
integer y = 416
integer width = 512
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ejecuta Cortes"
end type

event clicked;long fol,ll_min, ll_max,foli, ll_row, ll_rows
int carr, li_ing_per, li_ing_anio, li_confirma_periodo, li_status, li_update
double ld_puntaje_dif,ld_puntaje_acep, ld_puntaje

SetPointer(HourGlass!)


li_confirma_periodo = f_confirma_periodo()
if li_confirma_periodo= -1 or isnull(li_confirma_periodo) then
	MessageBox("Error al elegir el periodo", "No es una versión de examen válida", StopSign!)
	return
elseif li_confirma_periodo<> 1 then
	MessageBox("Cancelación del proceso", "No se ejecutará el proceso de Ejecución de cortes", StopSign!)
	return
END IF

ll_min=long(em_min.text)
ll_max=long(em_max.text)

ll_rows = dw_aspiran_ejecuta_cortes.Retrieve(gi_version,gi_periodo, gi_anio, ll_min, ll_max )

for ll_row=1 to ll_rows
	ld_puntaje_acep = dw_aspiran_ejecuta_cortes.GetItemNumber(ll_row,"puntaje_acep")
	ld_puntaje_dif = dw_aspiran_ejecuta_cortes.GetItemNumber(ll_row,"puntaje_dif")
	ld_puntaje = dw_aspiran_ejecuta_cortes.GetItemNumber(ll_row,"puntaje")
	li_ing_per  = dw_aspiran_ejecuta_cortes.GetItemNumber(ll_row,"ing_per")
	li_ing_anio = dw_aspiran_ejecuta_cortes.GetItemNumber(ll_row,"ing_anio")
	if ld_puntaje >= ld_puntaje_acep then
		li_status = 1
	elseif li_ing_per=gi_periodo and li_ing_anio=gi_anio then	
		if ld_puntaje>=ld_puntaje_dif then
			li_status = 3
		else
			li_status = 0
		end if
	else
		li_status = 0		
	end if
	dw_aspiran_ejecuta_cortes.SetItem(ll_row,"status",li_status)
	
next

li_update = dw_aspiran_ejecuta_cortes.update(true)

if li_update = 1 then		

else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using gtr_sadm;	
		//destroy ltr_trans
		MessageBox("Error de Actualización","No fue posible ejecutar los cortes",StopSign!)
		st_1.text="Error de Ejecución"
		return -1
end if


// Se actualiza el estatus en SQL SERVER
LONG ll_folio
INTEGER le_clv_ver
INTEGER le_clv_per
INTEGER le_anio
STRING ls_error

ll_rows = dw_aspiran_ejecuta_cortes.ROWCOUNT()
for ll_row=1 to ll_rows

	ll_folio = dw_aspiran_ejecuta_cortes.GETITEMNUMBER(ll_row,"folio") 
	le_clv_ver = dw_aspiran_ejecuta_cortes.GETITEMNUMBER(ll_row,"clv_ver") 
	le_clv_per = dw_aspiran_ejecuta_cortes.GETITEMNUMBER(ll_row,"clv_per") 
	le_anio = dw_aspiran_ejecuta_cortes.GETITEMNUMBER(ll_row,"anio") 
	li_status = dw_aspiran_ejecuta_cortes.GETITEMNUMBER(ll_row,"status")
	
	UPDATE aspiran  
	SET status = :li_status
	WHERE ( aspiran.folio = :ll_folio ) AND  
		( aspiran.clv_ver = :le_clv_ver ) AND  
		( aspiran.clv_per = :le_clv_per ) AND  
		( aspiran.anio = :le_anio )
	USING itr_admision_web;
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		MESSAGEBOX("ERROR", "Se produjo un error al actualizar el estatus en WEB: " + ls_error) 
		ROLLBACK USING itr_admision_web;
		rollback using gtr_sadm;
		RETURN -1
	END IF 
	
NEXT 

COMMIT USING itr_admision_web;
COMMIT USING gtr_sadm;

MessageBox("Actualización Exitosa","Se ejecutaron los cortes",Information!)
st_1.text="Ejecución Exitosa"
RETURN 1









//
//min=long(em_min.text)
//max=long(em_max.text)
//FOR fol=min TO max
//
//  SELECT aspiran.folio,aspiran.clv_carr,aspiran.puntaje,aspiran.ing_per,aspiran.ing_anio
//  INTO :foli,:carr,:puntaje,:ing_per,:ing_anio
//  FROM aspiran  
//  WHERE ( aspiran.clv_ver = :gi_version ) AND  
//         ( aspiran.clv_per = :gi_periodo ) AND  
//         ( aspiran.anio = :gi_anio ) AND  
//         ( aspiran.pago_exam = 1 ) AND  
//         ( aspiran.folio = :fol )
//	USING gtr_sadm;
//	
//	if fol=foli then
//
//		st_1.text='Cortando al Folio '+string(fol)+' de '+string(max)
//	
//		SELECT lineas_corte.puntaje_acep
//		INTO :puntaje_acep
//		FROM lineas_corte
//		WHERE lineas_corte.clv_carr = :carr
//		USING gtr_sadm;
//		
//		if puntaje>=puntaje_acep then
//			event cambia_status(fol,1)
//		else
//			if ing_per=gi_periodo and ing_anio=gi_anio then
//				SELECT lineas_corte.puntaje_dif
//				INTO :puntaje_dif
//				FROM lineas_corte  
//				WHERE lineas_corte.clv_carr = :carr
//				USING gtr_sadm;
//			
//				if puntaje>=puntaje_dif then
//					event cambia_status(fol,3)
//				else
//					event cambia_status(fol,0)
//				end if
//			else
//				event cambia_status(fol,0)
//			end if
//		end if
//	else
//		st_1.text='No existe o no pago el folio '+string(fol)
//	end if
//NEXT




end event

type uo_1 from uo_ver_per_ani within w_ejecuta_cortes
integer x = 27
integer y = 48
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

