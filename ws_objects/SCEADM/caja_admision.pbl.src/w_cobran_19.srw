$PBExportHeader$w_cobran_19.srw
forward
global type w_cobran_19 from window
end type
type sle_4 from singlelineedit within w_cobran_19
end type
type st_4 from statictext within w_cobran_19
end type
type st_3 from statictext within w_cobran_19
end type
type sle_3 from singlelineedit within w_cobran_19
end type
type sle_1 from singlelineedit within w_cobran_19
end type
type st_1 from statictext within w_cobran_19
end type
type st_2 from statictext within w_cobran_19
end type
type sle_2 from singlelineedit within w_cobran_19
end type
type dw_3 from uo_dw_reporte within w_cobran_19
end type
type cb_3 from commandbutton within w_cobran_19
end type
type dw_2 from uo_dw_reporte within w_cobran_19
end type
type cb_1 from commandbutton within w_cobran_19
end type
type cb_2 from commandbutton within w_cobran_19
end type
type uo_1 from uo_ver_per_ani within w_cobran_19
end type
type dw_1 from uo_dw_reporte within w_cobran_19
end type
end forward

global type w_cobran_19 from window
integer x = 832
integer y = 364
integer width = 4462
integer height = 2976
boolean titlebar = true
string title = "Reporte de Inscripción Pagada por Cobranzas"
string menuname = "m_menu"
boolean resizable = true
long backcolor = 30976088
sle_4 sle_4
st_4 st_4
st_3 st_3
sle_3 sle_3
sle_1 sle_1
st_1 st_1
st_2 st_2
sle_2 sle_2
dw_3 dw_3
cb_3 cb_3
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
uo_1 uo_1
dw_1 dw_1
end type
global w_cobran_19 w_cobran_19

type variables
uo_administrador_liberacion iuo_administrador_liberacion
end variables

on w_cobran_19.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.sle_4=create sle_4
this.st_4=create st_4
this.st_3=create st_3
this.sle_3=create sle_3
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.sle_2=create sle_2
this.dw_3=create dw_3
this.cb_3=create cb_3
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.sle_4,&
this.st_4,&
this.st_3,&
this.sle_3,&
this.sle_1,&
this.st_1,&
this.st_2,&
this.sle_2,&
this.dw_3,&
this.cb_3,&
this.dw_2,&
this.cb_1,&
this.cb_2,&
this.uo_1,&
this.dw_1}
end on

on w_cobran_19.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_3)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1
string ls_control_correcto

if (conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password) <> 1) then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
	close(this)
	return
end if

if (conecta_bd_n_tr(gtr_sfeb,gs_sfeb,gs_usuario,gs_password) <> 1) then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de becas", StopSign!)
	close(this)
	return
end if

//if conecta_bd(gtr_scob,"scob","admision","y23MFH_x")=0 then
//	close(this)
//end if

//if not isvalid(iuo_administrador_liberacion) then
//	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
//end if
//
//IF iuo_administrador_liberacion.of_liberacion_vigente("SIT") THEN
//	IF iuo_administrador_liberacion.of_obten_control_correcto("SIT","admision","dw_cobran_19", "datawindow", ls_control_correcto) THEN
//		dw_1.dataobject = ls_control_correcto
//	END IF
//END IF

//dw_1.settransobject(gtr_scob)
dw_3.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)

end event

event close;desconecta_bd(gtr_scob)
desconecta_bd(gtr_sfeb)

//if isvalid(iuo_administrador_liberacion) then
//	DESTROY iuo_administrador_liberacion 
//end if

end event

type sle_4 from singlelineedit within w_cobran_19
integer x = 4064
integer y = 404
integer width = 270
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
end type

type st_4 from statictext within w_cobran_19
integer x = 2779
integer y = 408
integer width = 1280
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Total de registros actualizados: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_cobran_19
integer x = 2779
integer y = 300
integer width = 1280
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Procesando beca num.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_cobran_19
integer x = 4064
integer y = 296
integer width = 270
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
end type

type sle_1 from singlelineedit within w_cobran_19
integer x = 1906
integer y = 296
integer width = 270
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
end type

type st_1 from statictext within w_cobran_19
integer x = 622
integer y = 300
integer width = 1280
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Procesando pago num.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cobran_19
integer x = 622
integer y = 408
integer width = 1280
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Total de registros actualizados: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_cobran_19
integer x = 1906
integer y = 404
integer width = 270
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
end type

type dw_3 from uo_dw_reporte within w_cobran_19
integer x = 23
integer y = 508
integer width = 2162
integer height = 1344
integer taborder = 70
boolean titlebar = true
string title = "Inscripciones pagadas"
string dataobject = "dw_cobran_19_sit_nvo"
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event carga;string ls_dataobject
long ll_reg1,ll_reg2

SetPointer(HourGlass!)

ll_reg1 = dw_3.retrieve(gi_periodo, gi_anio)	
ll_reg2 =  dw_2.retrieve(gi_periodo, gi_anio)	
	
return ll_reg1+ ll_reg2

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_scob
end event

event asigna_dw_menu;/*
DESCRIPCIÓN: Evento en el cual se asigna a la variable dw del menu este objeto.
				En este evento se busca la ventana dueña del objeto y cual es su menu
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: CAMP(DkWf)
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
window ventana_propietaria

ventana_propietaria = getparent()

menu_propietario = ventana_propietaria.menuid

menu_propietario.dw	= this
end event

type cb_3 from commandbutton within w_cobran_19
integer x = 23
integer y = 348
integer width = 462
integer height = 148
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesa Pagos"
end type

event clicked;int li_i,li_cont,li_tot_becas
long ll_cuenta,ll_folio,ll_cta
string ls_mensaje

sle_1.text =  ''
sle_2.text =  ''

for li_i = 1 to dw_2.Rowcount()
	sle_1.text=string(li_i)
	ll_cuenta = dw_2.Getitemnumber(li_i,'general_cuenta')
	ll_folio = dw_2.Getitemnumber(li_i,'aspiran_folio')
	
	SELECT DISTINCT dbo.v_saldos_mov_alumnos.cuenta
	into :ll_cta
	FROM dbo.v_saldos_mov_alumnos
	WHERE ( dbo.v_saldos_mov_alumnos.saldo < 0 ) and
  		( dbo.v_saldos_mov_alumnos.cve_concepto IN(3,30,1,31) ) and
 		( dbo.v_saldos_mov_alumnos.periodo = :gi_periodo ) and
  		( dbo.v_saldos_mov_alumnos.anio = :gi_anio )   and
         ( dbo.v_saldos_mov_alumnos.cuenta = :ll_cuenta ) using gtr_scob;
	
	if gtr_scob.sqlcode = 0  then
		update aspiran
			set pago_insc = 1 
		where folio = :ll_folio
		and ing_per = :gi_periodo
		and ing_anio = :gi_anio using gtr_sadm;
		li_tot_becas ++
		sle_2.text=string(li_tot_becas)
	end if
	
end for

commit using gtr_sadm;
end event

type dw_2 from uo_dw_reporte within w_cobran_19
integer x = 2194
integer y = 508
integer width = 2162
integer height = 1344
integer taborder = 50
boolean titlebar = true
string title = "Inscripciones por Beca"
string dataobject = "dw_cobran_19_adm"
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event carga;return 0
end event

event asigna_dw_menu;//
end event

type cb_1 from commandbutton within w_cobran_19
integer x = 2194
integer y = 348
integer width = 462
integer height = 148
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesa Becas"
end type

event clicked;int li_i,li_cont,li_tot_becas
long ll_cuenta,ll_folio,ll_cta
string ls_mensaje

sle_3.text =  ''
sle_4.text =  ''

for li_i = 1 to dw_2.Rowcount()
	sle_3.text=string(li_i)
	ll_cuenta = dw_2.Getitemnumber(li_i,'general_cuenta')
	ll_folio = dw_2.Getitemnumber(li_i,'aspiran_folio')
	
	ll_cta = 0
	
	//Select  cuenta
	SELECT COUNT(1) 
		into :ll_cta
	From  dbo.v_sfeb_apoyos_activos_new
	Where   ( anio = :gi_anio )
	And   ( periodo = :gi_periodo )
	and cuenta = :ll_cuenta
	 and porcentaje_total = 100 using gtr_sfeb; 
	 
	IF ISNULL(ll_cta) THEN ll_cta = 0 
	
	// Se cambia esta condición para que solo actualice si encuentra la cuenta. 
	//if gtr_sfeb.sqlcode = 0  then
	IF ll_cta > 0 THEN 
		update aspiran
			set pago_insc = 1 
		where folio = :ll_folio
		and ing_per = :gi_periodo
		and ing_anio = :gi_anio using gtr_sadm;
		li_tot_becas ++
		sle_4.text=string(li_tot_becas)
	end if
	
end for

commit using gtr_sadm;

end event

type cb_2 from commandbutton within w_cobran_19
event clicked pbm_bnclicked
boolean visible = false
integer x = 855
integer y = 2540
integer width = 462
integer height = 148
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesa Pagos"
end type

event clicked;long cont,cuenta,folio,ll_cont
int pagado
string lugar

SetPointer(HourGlass!)

st_1.text = 'Procesando pago num.: '
sle_1.text =  ''
sle_2.text =  ''

FOR cont=1 TO dw_1.rowcount()
	sle_1.text=string(cont)
	cuenta=dw_1.object.cuenta[cont]
//	Comentado para el nuevo sistema de tesoreria	
//	lugar=string(dw_1.object.cve_ban[cont])

	SELECT aspiran.folio,aspiran.pago_insc,aspiran.clv_ver
	INTO :folio,:pagado,:gi_version
	FROM aspiran,general
	WHERE ( aspiran.folio = general.folio ) and
		( aspiran.clv_ver = general.clv_ver ) and
		( general.clv_per = aspiran.clv_per ) and
		( aspiran.anio = general.anio ) and
		( ( aspiran.ing_per = :gi_periodo ) AND
		( aspiran.ing_anio = :gi_anio ) AND
		( general.cuenta = :cuenta ) )
	USING gtr_sadm;
	
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error Grave",string(cuenta)+" NO está registrado")
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
		elseif pagado=0 then
			UPDATE aspiran
			SET pago_insc = 1
			WHERE ( aspiran.folio = :folio ) AND
				( aspiran.ing_per = :gi_periodo ) AND
				( aspiran.ing_anio = :gi_anio )
			USING gtr_sadm;
			
			ll_cont ++
			
			sle_2.text=string(ll_cont)
//				( aspiran.clv_ver = :gi_version ) AND

		 if gtr_sadm.SqlCode<>0 then
			  messagebox(gtr_sadm.sqlerrtext,"Insert")
			  rollback using gtr_sadm;
			  return
		 else
			commit using gtr_sadm;
		 end if

//	Comentado para el nuevo sistema de tesoreria	
//			UPDATE bita_bachi
//			SET usuario = :lugar
//			FROM bita_bachi, aspiran
//			WHERE ( aspiran.folio = :folio ) AND
//				( aspiran.ing_per = :gi_periodo ) AND
//				( aspiran.ing_anio = :gi_anio ) AND
//				( bita_bachi.anterior = NULL ) AND
//				( bita_bachi.folio = aspiran.folio) AND
//				( bita_bachi.clv_ver = aspiran.clv_ver) AND
//				( bita_bachi.clv_per = aspiran.clv_per) AND
//				( bita_bachi.anio = aspiran.anio) 		
//		USING gtr_sadm;
////				( bita_bachi.clv_ver = :gi_version ) AND
//
//		  if gtr_sadm.sqlerrtext<>"" then
//			  messagebox(gtr_sadm.sqlerrtext,"Insert")
//			  return
//		  end if

	End If
NEXT

//--commit using gtr_sadm;
end event

type uo_1 from uo_ver_per_ani within w_cobran_19
integer x = 23
integer y = 24
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_cobran_19
boolean visible = false
integer x = 27
integer y = 1888
integer width = 2162
integer height = 608
integer taborder = 0
boolean titlebar = true
string title = "Inscripciones pagadas"
string dataobject = "dw_cobran_19_sit"
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event inicia_transaction_object;call super::inicia_transaction_object;//tr_dw_propio = gtr_scob
end event

event carga;return 0

//string ls_dataobject
//long ll_reg1,ll_reg2
//
//SetPointer(HourGlass!)
//
//ls_dataobject = this.dataobject
//IF ls_dataobject = "dw_cobran_19" THEN
//
//	CHOOSE CASE gi_periodo
//		CASE 0
//			return dw_1.retrieve('P',gi_anio - integer(gi_anio/100)*100)
//		CASE 1
//			return dw_1.retrieve('V',gi_anio - integer(gi_anio/100)*100)
//		CASE 2
//			return dw_1.retrieve('O',gi_anio - integer(gi_anio/100)*100)
//	END CHOOSE
//ELSEIF ls_dataobject = "dw_cobran_19_sit" THEN
//	ll_reg1 = dw_1.retrieve(gi_periodo, gi_anio)	
//	ll_reg2 =  dw_2.retrieve(gi_periodo, gi_anio)	
//	
//	return ll_reg1+ ll_reg2
//END IF
//
//
//dw_1.object.st_1.text=tit1
end event

event asigna_dw_menu;//
end event

