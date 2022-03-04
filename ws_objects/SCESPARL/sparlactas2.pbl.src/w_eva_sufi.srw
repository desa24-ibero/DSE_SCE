$PBExportHeader$w_eva_sufi.srw
forward
global type w_eva_sufi from w_ancestral
end type
type cb_4 from commandbutton within w_eva_sufi
end type
type cb_3 from commandbutton within w_eva_sufi
end type
type dw_extra_tit from datawindow within w_eva_sufi
end type
type cb_2 from commandbutton within w_eva_sufi
end type
type cb_1 from commandbutton within w_eva_sufi
end type
type dw_actas from uo_dw_captura within w_eva_sufi
end type
type uo_1 from uo_per_ani within w_eva_sufi
end type
end forward

global type w_eva_sufi from w_ancestral
integer width = 3152
integer height = 2275
string title = "Lectura de Actas de Evaluación Suficiencia"
string menuname = "m_menu"
cb_4 cb_4
cb_3 cb_3
dw_extra_tit dw_extra_tit
cb_2 cb_2
cb_1 cb_1
dw_actas dw_actas
uo_1 uo_1
end type
global w_eva_sufi w_eva_sufi

event open;call super::open;dw_actas.settransobject(gtr_sce)
dw_extra_tit.settransobject(gtr_sce)

end event

on w_eva_sufi.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_extra_tit=create dw_extra_tit
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_actas=create dw_actas
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_extra_tit
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_actas
this.Control[iCurrent+7]=this.uo_1
end on

on w_eva_sufi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_extra_tit)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_actas)
destroy(this.uo_1)
end on

type p_uia from w_ancestral`p_uia within w_eva_sufi
end type

type cb_4 from commandbutton within w_eva_sufi
event clicked pbm_bnclicked
integer x = 2304
integer y = 202
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

event clicked;dw_actas.reset()
dw_extra_tit.reset()

end event

type cb_3 from commandbutton within w_eva_sufi
event clicked pbm_bnclicked
integer x = 1543
integer y = 202
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

event clicked;long ll_cont_1, ll_cont_2
string ls_calif

FOR ll_cont_1=1 TO dw_actas.rowcount()
	dw_actas.scrolltorow(ll_cont_1)
	dw_extra_tit.retrieve(gi_anio,gi_periodo,dw_actas.object.clave[ll_cont_1],dw_actas.object.grupo[ll_cont_1],6)
	if dw_extra_tit.rowcount()<>dw_actas.object.inscritos[ll_cont_1] then
		dw_actas.deleterow(ll_cont_1)
		ll_cont_1 --
	else
		CHOOSE CASE dw_extra_tit.object.materias_evaluacion[1]
			CASE 'NUM'
				ls_calif=checa_num(dw_actas.object.calif_num[ll_cont_1],dw_extra_tit.rowcount())
			CASE 'ALFA'
				ls_calif=checa_alfa(dw_actas.object.calif_num[ll_cont_1],dw_actas.object.calif_alfa[ll_cont_1],dw_extra_tit.rowcount())
			CASE 'ALIN'
				ls_calif=checa_alin(dw_actas.object.calif_num[ll_cont_1],dw_actas.object.calif_alfa[ll_cont_1],dw_extra_tit.rowcount())
			CASE 'NUIN'
				ls_calif=checa_nuin(dw_actas.object.calif_num[ll_cont_1],dw_actas.object.calif_alfa[ll_cont_1],dw_extra_tit.rowcount())
		END CHOOSE			

		FOR ll_cont_2=1 TO dw_extra_tit.rowcount()
			if mid(ls_calif,ll_cont_2,1)=' ' or mid(ls_calif,ll_cont_2,1)='*' then
				if dw_extra_tit.object.materias_evaluacion[ll_cont_2]='NUM' or &
					dw_extra_tit.object.materias_evaluacion[ll_cont_2]='NUIN' then
					dw_extra_tit.object.examen_extrao_titulo_calificacion[ll_cont_2]='5'
				else
					dw_extra_tit.object.examen_extrao_titulo_calificacion[ll_cont_2]='NA'
				end if
			else
				dw_extra_tit.object.examen_extrao_titulo_calificacion[ll_cont_2]=conv(mid(ls_calif,ll_cont_2,1))
			end if
		NEXT
		dw_extra_tit.AcceptText()
		if dw_extra_tit.update(true) = 1 then		
			commit using gtr_sce;
		else
			rollback using gtr_sce;
			messagebox("Error al actualizar","")
			return
		end if	
	end if
NEXT
end event

type dw_extra_tit from datawindow within w_eva_sufi
event constructor pbm_constructor
integer x = 216
integer y = 1210
integer width = 2882
integer height = 874
integer taborder = 40
string dataobject = "d_extra_tit"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_eva_sufi
event clicked pbm_bnclicked
integer x = 1083
integer y = 202
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

event clicked;long ll_cont,ll_salto
string ls_faltan,ls_repetida

dw_actas.sort()

ls_faltan=""
ll_salto=dw_actas.object.numacta[1] -1

for ll_cont=1 to dw_actas.rowcount()
	DO UNTIL ll_cont+ll_salto=dw_actas.object.numacta[ll_cont]
		ls_faltan=ls_faltan+' '+string(ll_cont+ll_salto)
		ll_salto=ll_salto+1
		if ll_cont+ll_salto>dw_actas.object.numacta[ll_cont] then
			ls_repetida=string(dw_actas.object.numacta[ll_cont])
			messagebox("Peligro, está ls_repetida el acta:",ls_repetida)
			return
		end if
	LOOP
next
messagebox("ls_faltan las siguientes actas:",ls_faltan)
end event

type cb_1 from commandbutton within w_eva_sufi
event clicked pbm_bnclicked
integer x = 508
integer y = 202
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
			dw_actas.event agrega(ls_s)
		end if
		ll_bytes_read = FileRead(li_lee_file, ls_s)
	LOOP
	FileClose(li_lee_file)
end if

dw_actas.insertrow(0)
dw_actas.deleterow(dw_actas.rowcount())
end event

type dw_actas from uo_dw_captura within w_eva_sufi
event constructor pbm_constructor
event doubleclicked pbm_dwnlbuttondblclk
event borra ( )
event agrega ( string linea )
integer x = 216
integer y = 419
integer width = 2597
integer height = 771
integer taborder = 10
string dataobject = "d_actas"
end type

event doubleclicked;call super::doubleclicked;if row>0 then
	dw_extra_tit.retrieve(gi_anio,gi_periodo,dw_actas.object.clave[row],dw_actas.object.grupo[row],6)
end if
end event

event borra;setfocus()
deleterow(getrow())
end event

event agrega(string linea);string ls_clave1, ls_clave2, ls_clave3, ls_clave4, ls_clave5, ls_grupo1, ls_grupo2, ls_numacta
STRING ls_hoja, ls_inscritos, ls_calif_num, ls_calif_alfa
int li_a
long ll_renglon
string ls_anio
char lch_per

//ls_anio=string(gi_anio - integer(gi_anio/100)*100,"00")
ls_anio = string(gi_anio)


CHOOSE CASE gi_periodo
	CASE 0
		lch_per='P'
	CASE 1
		lch_per='V'
	CASE 2
		lch_per='O'
END CHOOSE

li_a=Pos (linea, ",")
if ls_anio<>Left (linea, li_a -1) then
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
if lch_per<>Left (linea, li_a -1) then
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_clave1=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_clave2=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_clave3=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_clave4=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_clave5=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_grupo1=Left (linea, li_a -1)

if integer(ls_grupo1)<asc('A') or integer(ls_grupo1)>asc('Z') then
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_grupo2=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_numacta=Left (linea, li_a -1)

if long(ls_numacta)=0 then
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_hoja=Left (linea, li_a -1)

if integer(ls_hoja)=0 then
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_inscritos=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_calif_num=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
ls_calif_alfa=linea

if integer(ls_hoja)=1 then
	insertrow(0)
	ll_renglon=rowcount()
//	object.clave[ll_renglon]=long(ls_clave1+ls_clave2+ls_clave3+ls_clave4)
	object.clave[ll_renglon]=long(ls_clave1+ls_clave2+ls_clave3+ls_clave4+ls_clave5)
	object.grupo[ll_renglon]=trim(char(integer(ls_grupo1))+char(integer(ls_grupo2)))
	object.numacta[ll_renglon]=long(ls_numacta)
	object.hoja[ll_renglon]=integer(ls_hoja)
	object.inscritos[ll_renglon]=integer(ls_inscritos)
	object.calif_num[ll_renglon]=ls_calif_num
	object.calif_alfa[ll_renglon]=ls_calif_alfa
else
	FOR ll_renglon=rowcount() TO 1 STEP -1
//		if object.clave[ll_renglon]=long(ls_clave1+ls_clave2+ls_clave3+ls_clave4) and &
		if object.clave[ll_renglon]=long(ls_clave1+ls_clave2+ls_clave3+ls_clave4+ls_clave5) and &
			object.grupo[ll_renglon]=trim(char(integer(ls_grupo1))+char(integer(ls_grupo2))) and &
			object.numacta[ll_renglon]=long(ls_numacta) and object.hoja[ll_renglon]+1=integer(ls_hoja) then
				object.inscritos[ll_renglon]=object.inscritos[ll_renglon]+integer(ls_inscritos)
				object.calif_num[ll_renglon]=object.calif_num[ll_renglon]+ls_calif_num
				object.calif_alfa[ll_renglon]=object.calif_alfa[ll_renglon]+ls_calif_alfa
				return
		end if
	NEXT
end if

/*
	messagebox(gi_anio+' '+periodo+' '+ls_clave1+' '+ls_clave2+' '+ls_clave3+' ',ls_clave4+' '+ls_grupo1+' '+&
		ls_grupo2+' '+ls_numacta+' '+ls_hoja+' '+ls_inscritos+' '+ls_calif)

Formato: 

ANO, PERIODO, ls_clave1, ls_clave2, ls_clave3, ls_clave4, ls_grupo1, ls_grupo2, ls_numacta, ls_hoja, ls_inscritos, ls_calif
*/
end event

type uo_1 from uo_per_ani within w_eva_sufi
integer x = 892
integer width = 1251
integer height = 166
integer taborder = 1
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

