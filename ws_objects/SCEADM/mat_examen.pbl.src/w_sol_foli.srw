$PBExportHeader$w_sol_foli.srw
$PBExportComments$Ventana para asignar folios a los salones. dw_version, dw_sol_foli, dw_salonxcarrera, dw_sum_lugares, dw_sum_folios, dw_salonxcarrera, dw_folioxnocarrera
forward
global type w_sol_foli from window
end type
type cb_2 from commandbutton within w_sol_foli
end type
type dw_2 from datawindow within w_sol_foli
end type
type dw_1 from uo_dw_captura within w_sol_foli
end type
type uo_1 from uo_ver_per_ani within w_sol_foli
end type
type dw_7 from datawindow within w_sol_foli
end type
type dw_6 from datawindow within w_sol_foli
end type
type dw_5 from datawindow within w_sol_foli
end type
type dw_4 from datawindow within w_sol_foli
end type
type dw_3 from datawindow within w_sol_foli
end type
end forward

global type w_sol_foli from window
integer x = 160
integer y = 600
integer width = 3255
integer height = 1964
boolean titlebar = true
string title = "Solicitud Folios por Carrera"
string menuname = "m_menu"
long backcolor = 30976088
cb_2 cb_2
dw_2 dw_2
dw_1 dw_1
uo_1 uo_1
dw_7 dw_7
dw_6 dw_6
dw_5 dw_5
dw_4 dw_4
dw_3 dw_3
end type
global w_sol_foli w_sol_foli

type variables

end variables

on w_sol_foli.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_2=create cb_2
this.dw_2=create dw_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.dw_7=create dw_7
this.dw_6=create dw_6
this.dw_5=create dw_5
this.dw_4=create dw_4
this.dw_3=create dw_3
this.Control[]={this.cb_2,&
this.dw_2,&
this.dw_1,&
this.uo_1,&
this.dw_7,&
this.dw_6,&
this.dw_5,&
this.dw_4,&
this.dw_3}
end on

on w_sol_foli.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.dw_7)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.dw_3)
end on

event open;x=1
y=1


dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)
dw_3.settransobject(gtr_sadm)
dw_4.settransobject(gtr_sce)
dw_5.settransobject(gtr_sadm)
dw_6.settransobject(gtr_sadm)
dw_7.settransobject(gtr_sadm)


//LONG ll_carreras 
//DataWindowChild carr
//dw_1.getchild("clv_carr",carr)
//carr.settransobject(gtr_sce)
//ll_carreras = carr.retrieve() 
//dw_1.INSERTROW(0)
//

RETURN 0 






end event

type cb_2 from commandbutton within w_sol_foli
integer x = 2670
integer y = 52
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lugares"
end type

event clicked;long renglon
dw_1.setfocus()
FOR renglon=dw_1.rowcount() TO 1 STEP -1
	dw_1.scrolltorow(renglon)
NEXT
end event

type dw_2 from datawindow within w_sol_foli
event actualiza ( )
event carga ( )
integer x = 2962
integer y = 56
integer width = 247
integer height = 100
string dataobject = "dw_varios"
boolean livescroll = true
end type

event actualiza;if ModifiedCount() > 0 Then
	/*Checa que los renglones cumplan con las reglas de validación*/
	if update(true) = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		commit using gtr_sadm;
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using gtr_sadm;
	end if
end if
end event

event carga;event actualiza()
retrieve(1)
end event

event losefocus;event actualiza()
end event

type dw_1 from uo_dw_captura within w_sol_foli
event cuenta_lugares ( )
integer x = 0
integer y = 196
integer width = 2523
integer height = 1564
integer taborder = 20
string dataobject = "dw_sol_foli"
end type

event cuenta_lugares();int cv_carr

cv_carr=object.clv_carr[getrow()]

IF ISNULL(cv_carr) OR cv_carr = 0 THEN RETURN 

dw_3.event carga(cv_carr)
dw_6.event carga(cv_carr)
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

end event

event itemchanged;call super::itemchanged;int cont, cupo, usados, faltan, per, carr
string salon


	if getcolumn()=3 then
		faltan=integer(data)
		per=object.clv_per[row]
		carr=object.clv_carr[row]

		if faltan - object.folios[row]>object.lugares[row] then
			messagebox("No hay tantos lugares","Da de alta más salones para esta carrera")
		else
			dw_3.update()
			FOR cont = 1 to dw_3.rowcount()
				salon=dw_3.object.salon[cont]
		
				SELECT isnull(salon.cupo,0)
				INTO :cupo  
				FROM salon
				WHERE salon.cve_salon = :salon
				USING gtr_sce;		
				
				dw_7.event carga(salon,carr)
				usados=dw_7.object.compute_0001[1]
			
				if isnull(usados) then
					usados=0
				end if
					
				if (faltan > (cupo - usados)) then
					faltan=faltan - (cupo - usados)
					dw_3.object.folios[cont]=cupo - usados
				else
					dw_3.object.folios[cont]=faltan
					faltan=0
				end if
			
			NEXT				
			dw_3.update()
			event cuenta_lugares()
		end if
	end if
end event

event itemfocuschanged;call super::itemfocuschanged;event cuenta_lugares()
/*Estaba como post event*/
end event

event nuevo;LONG ll_row
if gi_version<99 then 
	setfocus()
	ll_row = insertrow(0) 
	//SETITEM(ll_row, "clv_carr", 0)
	scrolltorow(ll_row)
	setcolumn(2)
	object.folios[getrow()]=0
	object.lugares[getrow()]=999
	object.clv_ver[getrow()]=gi_version
	object.clv_per[getrow()]=gi_periodo
	object.anio[getrow()]=gi_anio
end if



end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;dw_2.event carga()
if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

type uo_1 from uo_ver_per_ani within w_sol_foli
integer x = 69
integer y = 24
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_7 from datawindow within w_sol_foli
event carga ( string sal,  integer car )
integer x = 3465
integer y = 1396
integer width = 741
integer height = 360
string dataobject = "dw_folioxnocarrera"
boolean livescroll = true
end type

event carga;retrieve(gi_version,sal,car,gi_periodo,gi_anio)
end event

type dw_6 from datawindow within w_sol_foli
event carga ( integer carr )
integer x = 3456
integer y = 592
integer width = 727
integer height = 360
string dataobject = "dw_folioxcarrera"
boolean livescroll = true
end type

event carga;retrieve(carr,gi_version,gi_periodo,gi_anio)

end event

event retrieveend;int li_folios

li_folios=int(object.compute_0001[1])

if dw_1.object.folios[dw_1.getrow()]<>li_folios then
	dw_1.object.folios[dw_1.getrow()]=li_folios
end if
end event

type dw_5 from datawindow within w_sol_foli
event carga ( )
integer x = 3451
integer y = 1004
integer width = 736
integer height = 360
string dataobject = "dw_sum_folios"
boolean livescroll = true
end type

event carga;string sal[]
int cont

FOR cont = 1 to dw_3.rowcount()
	sal[cont]=dw_3.object.salon[cont]
NEXT

retrieve(sal,gi_version,gi_periodo,gi_anio)
end event

event retrieveend;real porc_uso_salon
int li_disponibles

	select valor/100.0
	into :porc_uso_salon
	from varios
	where indice=1
	using gtr_sadm;

li_disponibles=int(dw_4.object.compute_0001[1]*porc_uso_salon)-int(object.compute_0001[1])

if dw_1.object.lugares[dw_1.getrow()]<>li_disponibles then
	dw_1.object.lugares[dw_1.getrow()]=li_disponibles
end if
end event

type dw_4 from datawindow within w_sol_foli
event carga ( )
integer x = 3456
integer y = 196
integer width = 736
integer height = 360
string dataobject = "dw_sum_lugares"
boolean livescroll = true
end type

event carga;string sal[]
int cont

FOR cont = 1 to dw_3.rowcount()
	sal[cont]=dw_3.object.salon[cont]
NEXT

retrieve(sal)
end event

type dw_3 from datawindow within w_sol_foli
event carga ( integer carr )
integer x = 2551
integer y = 196
integer width = 686
integer height = 1564
string dataobject = "dw_salonxcarrera_sol_foli_2020"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event carga(integer carr);retrieve(carr,gi_version,gi_periodo,gi_anio, 0)
end event

event retrieveend;if rowcount>0 then 
	dw_4.event carga() 
	dw_5.event carga()
else
	LONG ll_folios 
	ll_folios = dw_1.object.folios[dw_1.getrow()] 
	IF ISNULL(ll_folios) THEN 
		dw_1.object.folios[dw_1.getrow()]=0
		dw_1.object.lugares[dw_1.getrow()]=999
	END IF 	
end if
end event

event updateend;commit using gtr_sadm;
end event

