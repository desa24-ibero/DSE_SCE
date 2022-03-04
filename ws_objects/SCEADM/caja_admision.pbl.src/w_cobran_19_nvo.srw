$PBExportHeader$w_cobran_19_nvo.srw
forward
global type w_cobran_19_nvo from window
end type
type sle_1 from singlelineedit within w_cobran_19_nvo
end type
type cb_2 from commandbutton within w_cobran_19_nvo
end type
type uo_1 from uo_ver_per_ani within w_cobran_19_nvo
end type
type dw_1 from uo_dw_reporte within w_cobran_19_nvo
end type
end forward

global type w_cobran_19_nvo from window
integer x = 832
integer y = 364
integer width = 3506
integer height = 1964
boolean titlebar = true
string title = "Reporte de Inscripción Pagada por Cobranzas"
string menuname = "m_menu"
long backcolor = 30976088
sle_1 sle_1
cb_2 cb_2
uo_1 uo_1
dw_1 dw_1
end type
global w_cobran_19_nvo w_cobran_19_nvo

type variables
uo_administrador_liberacion iuo_administrador_liberacion
end variables

on w_cobran_19_nvo.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.sle_1=create sle_1
this.cb_2=create cb_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.sle_1,&
this.cb_2,&
this.uo_1,&
this.dw_1}
end on

on w_cobran_19_nvo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1
string ls_control_correcto


if conecta_bd(gtr_scob,gs_scob,"admision","y23MFH_x")=0 then
	close(this)
end if


if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if

IF iuo_administrador_liberacion.of_liberacion_vigente("SIT") THEN
	IF iuo_administrador_liberacion.of_obten_control_correcto("SIT","admision","dw_cobran_19", "datawindow", ls_control_correcto) THEN
		dw_1.dataobject = ls_control_correcto
	END IF
END IF

dw_1.settransobject(gtr_scob)
end event

event close;desconecta_bd(gtr_scob)

if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

end event

type sle_1 from singlelineedit within w_cobran_19_nvo
integer x = 3081
integer y = 60
integer width = 270
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
end type

type cb_2 from commandbutton within w_cobran_19_nvo
event clicked pbm_bnclicked
integer x = 2537
integer y = 72
integer width = 293
integer height = 72
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesa"
end type

event clicked;long cont,cuenta,folio, ll_clv_ver ,ll_clv_per, ll_anio
int pagado
string lugar

SetPointer(HourGlass!)

FOR cont=1 TO dw_1.rowcount()
	sle_1.text=string(cont)
	cuenta=dw_1.object.cuenta[cont]
//	Comentado para el nuevo sistema de tesoreria	
// lugar=string(dw_1.object.cve_ban[cont])

	SELECT aspiran.folio, aspiran.pago_insc, aspiran.clv_ver, aspiran.clv_per, aspiran.anio
	INTO :folio, :pagado, :ll_clv_ver, :ll_clv_per, :ll_anio
	FROM aspiran,general
	WHERE ( aspiran.folio = general.folio ) and
		( aspiran.clv_ver = general.clv_ver ) and
		( general.clv_per = aspiran.clv_per ) and
		( general.cuenta = :cuenta )  and
		( aspiran.clv_ver <> 0 ) 		
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
				( aspiran.clv_ver = :ll_clv_ver ) AND
				( aspiran.clv_per = :ll_clv_per ) AND
				( aspiran.anio = :ll_anio )
			USING gtr_sadm;

//				( aspiran.clv_ver = :gi_version ) AND

		  if gtr_sadm.sqlerrtext<>"" then
			  messagebox(gtr_sadm.sqlerrtext,"Insert")
			  return
		  end if

//	Comentado para el nuevo sistema de tesoreria	
//			UPDATE bita_bachi
//			SET usuario = :lugar
//			FROM bita_bachi, aspiran
//			WHERE ( aspiran.folio = :folio ) AND
//				( aspiran.clv_ver = :ll_clv_ver ) AND
//				( aspiran.clv_per = :ll_clv_per ) AND
//				( aspiran.anio = :ll_anio ) AND
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

commit using gtr_sadm;
end event

type uo_1 from uo_ver_per_ani within w_cobran_19_nvo
integer y = 24
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_cobran_19_nvo
integer y = 192
integer width = 3456
integer height = 1592
integer taborder = 0
string dataobject = "dw_cobran_19"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_scob
end event

event carga;string ls_dataobject

SetPointer(HourGlass!)

ls_dataobject = this.dataobject
IF ls_dataobject = "dw_cobran_19" THEN

	CHOOSE CASE gi_periodo
		CASE 0
			return dw_1.retrieve('P',gi_anio - integer(gi_anio/100)*100)
		CASE 1
			return dw_1.retrieve('V',gi_anio - integer(gi_anio/100)*100)
		CASE 2
			return dw_1.retrieve('O',gi_anio - integer(gi_anio/100)*100)
	END CHOOSE
ELSEIF ls_dataobject = "dw_cobran_19_sit" THEN
	return dw_1.retrieve(gi_periodo, gi_anio)	
END IF


dw_1.object.st_1.text=tit1
end event

