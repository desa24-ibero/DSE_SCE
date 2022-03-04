$PBExportHeader$w_camb_calif.srw
forward
global type w_camb_calif from w_ancestral
end type
type cb_4 from commandbutton within w_camb_calif
end type
type cb_3 from commandbutton within w_camb_calif
end type
type dw_camb_calif from datawindow within w_camb_calif
end type
type cb_2 from commandbutton within w_camb_calif
end type
type cb_1 from commandbutton within w_camb_calif
end type
type dw_camb_actas from uo_dw_captura within w_camb_calif
end type
end forward

global type w_camb_calif from w_ancestral
integer width = 3090
integer height = 1741
string title = "Lectura de Cambios de Calificación"
string menuname = "m_menu"
cb_4 cb_4
cb_3 cb_3
dw_camb_calif dw_camb_calif
cb_2 cb_2
cb_1 cb_1
dw_camb_actas dw_camb_actas
end type
global w_camb_calif w_camb_calif

type variables
int ii_esc_file
end variables

event close;call super::close;IF ii_esc_file <> 999 THEN
	FileClose(ii_esc_file)
end if
end event

event open;call super::open;int li_value
string ls_docname, ls_named

li_value = GetFileSaveName("Selecciona Archivo",+ ls_docname, ls_named, "TXT",+ "Archivo de ERROR (*.TXT),*.TXT,")

IF li_value = 1 THEN
	ii_esc_file = FileOpen(ls_docname,LineMode!, Write!, LockWrite!, Replace!)
else
	ii_esc_file = 999
end if

dw_camb_actas.settransobject(gtr_sce)
dw_camb_calif.settransobject(gtr_sce)
end event

on w_camb_calif.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_camb_calif=create dw_camb_calif
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_camb_actas=create dw_camb_actas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_camb_calif
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_camb_actas
end on

on w_camb_calif.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_camb_calif)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_camb_actas)
end on

type p_uia from w_ancestral`p_uia within w_camb_calif
end type

type cb_4 from commandbutton within w_camb_calif
event clicked pbm_bnclicked
integer x = 2209
integer y = 99
integer width = 249
integer height = 109
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpia"
end type

event clicked;dw_camb_actas.reset()
dw_camb_calif.reset()

end event

type cb_3 from commandbutton within w_camb_calif
event clicked pbm_bnclicked
integer x = 1448
integer y = 99
integer width = 545
integer height = 109
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pon Calificaciones"
end type

event clicked;long ll_cont_1,ll_clave,ll_cuenta
string ls_actual,ls_anterior,ls_grupo,ls_user
datetime ldtm_hoy

ls_user=trim(gs_usuario)
ldtm_hoy=DateTime(today(),now())

FOR ll_cont_1=dw_camb_actas.rowcount() TO 1 STEP -1
	dw_camb_actas.scrolltorow(ll_cont_1)
	
	gi_anio=dw_camb_actas.object.anio[ll_cont_1]
	gi_periodo=dw_camb_actas.object.periodo[ll_cont_1]
	ll_clave=dw_camb_actas.object.clave[ll_cont_1]
	ls_grupo=dw_camb_actas.object.grupo[ll_cont_1]
	ll_cuenta=dw_camb_actas.object.cuenta[ll_cont_1]
	ls_anterior=dw_camb_actas.object.original[ll_cont_1]
	ls_actual=dw_camb_actas.object.nueva[ll_cont_1]
	
	periodo_actual(gi_periodo,gi_anio,gtr_sce)
	
	dw_camb_calif.retrieve(gi_anio,gi_periodo,ll_clave,ls_grupo,ll_cuenta)
	if dw_camb_calif.rowcount()=0 then
		IF ii_esc_file <> 999 THEN
			FileWrite(ii_esc_file, "Grupo y/o Materia equivocada: "+string(ll_cuenta)+' '+string(ll_clave)+' '+ls_grupo)
		end if
		dw_camb_actas.deleterow(ll_cont_1)
	else

		if dw_camb_calif.object.historico_calificacion[1]<>ls_anterior then
			IF ii_esc_file <> 999 THEN
				FileWrite(ii_esc_file, "Calificación original incorrecta: "+string(ll_cuenta))
			end if
			ls_anterior=dw_camb_calif.object.historico_calificacion[1]
		end if
		
		dw_camb_calif.object.historico_calificacion[1]=ls_actual
		dw_camb_calif.AcceptText()
		if dw_camb_calif.update(true) = 1 then		
			commit using gtr_sce;
			
//			INSERT INTO ui_bicamnot  
//				( cuenta,cve_movimiento,cve_mat,gpo,periodo,anio,calificacion,
//				calificacion_ant,fecha_hora,usuario )  
//			VALUES ( :ll_cuenta,0,:ll_clave,:ls_grupo,:gi_periodo,:gi_anio,:ls_actual,:ls_anterior,   
//				:ldtm_hoy,:ls_user )
//			USING gtr_sce;
//			commit using gtr_sce;
			
		else
			rollback using gtr_sce;
			messagebox("Error al actualizar","")
			return
		end if
	end if
NEXT
end event

type dw_camb_calif from datawindow within w_camb_calif
event constructor pbm_constructor
integer x = 121
integer y = 1203
integer width = 2882
integer height = 336
integer taborder = 40
string dataobject = "d_camb_calif"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_camb_calif
event clicked pbm_bnclicked
integer x = 987
integer y = 99
integer width = 249
integer height = 109
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordena"
end type

event clicked;dw_camb_actas.sort()
end event

type cb_1 from commandbutton within w_camb_calif
event clicked pbm_bnclicked
integer x = 410
integer y = 99
integer width = 362
integer height = 109
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lee Archivo"
end type

event clicked;int li_value, li_lee_file
long ll_bytes_read
string ls_docname, ls_named, ls_s

li_value = GetFileOpenName("Selecciona Archivo",+ ls_docname, ls_named, "DLM",+ "Archivo Actas (*.DLM),*.DLM,")

IF li_value = 1 THEN
	li_lee_file = FileOpen(ls_docname,LineMode!, Read!, LockReadWrite!)

	SetPointer(HourGlass!)
	
	ll_bytes_read = FileRead(li_lee_file, ls_s)
	DO UNTIL ll_bytes_read<0
		if ll_bytes_read>0 then
			dw_camb_actas.event agrega(ls_s)
		end if
		ll_bytes_read = FileRead(li_lee_file, ls_s)
	LOOP
	FileClose(li_lee_file)
end if

dw_camb_actas.insertrow(0)
dw_camb_actas.deleterow(dw_camb_actas.rowcount())
end event

type dw_camb_actas from uo_dw_captura within w_camb_calif
event constructor pbm_constructor
event doubleclicked pbm_dwnlbuttondblclk
event borra ( )
event agrega ( string linea )
integer x = 121
integer y = 416
integer width = 2586
integer height = 723
integer taborder = 10
string dataobject = "d_camb_actas"
end type

event doubleclicked;call super::doubleclicked;if row>0 then
	dw_camb_calif.retrieve(dw_camb_actas.object.anio[row],dw_camb_actas.object.periodo[row],dw_camb_actas.object.clave[row], &
		dw_camb_actas.object.grupo[row],dw_camb_actas.object.cuenta[row])
end if
end event

event borra;setfocus()
deleterow(getrow())
end event

event agrega(string linea);string ls_cuenta, ls_clave, ls_grupo, ls_original, ls_nueva
int li_a,li_anio,li_per
long ll_renglon

li_a=Pos (linea, ",")
ls_cuenta=Left (linea, li_a -1)

if obten_digito(long(mid(ls_cuenta,1,len(ls_cuenta) -1))) = mid(ls_cuenta,len(ls_cuenta),1) then
	ls_cuenta=mid(ls_cuenta,1,len(ls_cuenta) -1)
else
	IF ii_esc_file <> 999 THEN
		FileWrite(ii_esc_file, "Cuenta Inexistente: "+linea)
	end if
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_clave=Left (linea, li_a -1)
ls_clave=trim(ls_clave)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_grupo=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_original=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_nueva=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")

CHOOSE CASE Left (linea, li_a -1)
	CASE 'P'
		li_per=0
	CASE 'V'
		li_per=1
	CASE 'O'
		li_per=2
END CHOOSE
if len(ls_grupo)=3 and mid(ls_grupo,2,1)=' ' then
	ls_grupo = mid(ls_grupo,1,1)+mid(ls_grupo,3,1)
end if
linea=mid(linea,li_a+1)
li_anio=integer(linea)

insertrow(0)
ll_renglon=rowcount()
object.cuenta[ll_renglon]=long(ls_cuenta)
object.clave[ll_renglon]=long(ls_clave)
object.grupo[ll_renglon]=ls_grupo
object.original[ll_renglon]=ls_original
object.nueva[ll_renglon]=ls_nueva
object.periodo[ll_renglon]=li_per
object.anio[ll_renglon]=li_anio

/*
messagebox(li_anio+' '+li_per+' '+ls_cuenta,ls_clave+' '+ls_grupo+' '+ls_original+' '+ls_nueval)

Formato: 

ls_cuenta, ls_clave, ls_grupo, ls_original, ls_nueval, PERIODO, AÑO
*/
end event

