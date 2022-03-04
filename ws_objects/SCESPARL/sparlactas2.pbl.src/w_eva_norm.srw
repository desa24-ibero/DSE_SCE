$PBExportHeader$w_eva_norm.srw
forward
global type w_eva_norm from w_ancestral
end type
type cb_4 from commandbutton within w_eva_norm
end type
type cb_3 from commandbutton within w_eva_norm
end type
type dw_califica from datawindow within w_eva_norm
end type
type cb_2 from commandbutton within w_eva_norm
end type
type cb_1 from commandbutton within w_eva_norm
end type
type dw_actas from uo_dw_captura within w_eva_norm
end type
type uo_1 from uo_per_ani within w_eva_norm
end type
end forward

global type w_eva_norm from w_ancestral
integer width = 3131
integer height = 2275
string title = "Lectura de Actas de Evaluación Normal"
string menuname = "m_menu"
cb_4 cb_4
cb_3 cb_3
dw_califica dw_califica
cb_2 cb_2
cb_1 cb_1
dw_actas dw_actas
uo_1 uo_1
end type
global w_eva_norm w_eva_norm

type variables
int ii_error_file
end variables

event open;call super::open;dw_actas.settransobject(gtr_sce)
dw_califica.settransobject(gtr_sce)


int li_value
string ls_docname, ls_named

li_value = GetFileSaveName("Selecciona Archivo",+ ls_docname, ls_named, "TXT",+ "Archivo de ERROR (*.TXT),*.TXT,")

IF li_value = 1 THEN
	ii_error_file = FileOpen(ls_docname,LineMode!, Write!, LockWrite!, Replace!)
else
	ii_error_file = 999
end if

end event

on w_eva_norm.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_califica=create dw_califica
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_actas=create dw_actas
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_califica
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_actas
this.Control[iCurrent+7]=this.uo_1
end on

on w_eva_norm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_califica)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_actas)
destroy(this.uo_1)
end on

event close;IF ii_error_file <> 999 THEN
	FileClose(ii_error_file)
end if
end event

type p_uia from w_ancestral`p_uia within w_eva_norm
end type

type cb_4 from commandbutton within w_eva_norm
event clicked pbm_bnclicked
integer x = 2282
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
dw_califica.reset()

end event

type cb_3 from commandbutton within w_eva_norm
event clicked pbm_bnclicked
integer x = 1521
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

event clicked;long ll_cont_1, ll_cont_2,ll_clave,ll_numacta, ll_cuenta
string ls_calif,ls_grupo, ls_sub_calif

FOR ll_cont_1=1 TO dw_actas.rowcount()
	dw_actas.scrolltorow(ll_cont_1)
	ll_clave=dw_actas.object.clave[ll_cont_1]
	ls_grupo=dw_actas.object.grupo[ll_cont_1]
	ll_numacta=dw_actas.object.numacta[ll_cont_1]
	
	if dw_califica.retrieve(gi_anio,gi_periodo,ll_clave,ls_grupo)>0 then
		if dw_califica.rowcount()<>dw_actas.object.inscritos[ll_cont_1] then
			FileWrite(ii_error_file, "Dif Ins~t"+string(dw_actas.GetItemNumber(ll_cont_1,"clave"))+"-"+&
			dw_actas.GetItemString(ll_cont_1,"grupo")+"-"+string(dw_actas.GetItemNumber(ll_cont_1,"numacta"))+"-"+&
			string(dw_actas.GetItemNumber(ll_cont_1,"hoja"))+"-"+string(dw_actas.GetItemNumber(ll_cont_1,"inscritos"))+"-"+&
			dw_actas.GetItemString(ll_cont_1,"calif_num")+"-"+dw_actas.GetItemString(ll_cont_1,"calif_num"))
			dw_actas.deleterow(ll_cont_1)
			ll_cont_1 --
		else
			
			CHOOSE CASE dw_califica.object.materias_evaluacion[1]
				CASE 'NUM'
					ls_calif=checa_num(dw_actas.object.calif_num[ll_cont_1],dw_califica.rowcount())
				CASE 'ALFA'
					ls_calif=checa_alfa(dw_actas.object.calif_num[ll_cont_1],dw_actas.object.calif_alfa[ll_cont_1],dw_califica.rowcount())
				CASE 'ALIN'
					ls_calif=checa_alin(dw_actas.object.calif_num[ll_cont_1],dw_actas.object.calif_alfa[ll_cont_1],dw_califica.rowcount())
				CASE 'NUIN'
					ls_calif=checa_nuin(dw_actas.object.calif_num[ll_cont_1],dw_actas.object.calif_alfa[ll_cont_1],dw_califica.rowcount())
			END CHOOSE			
	
			FOR ll_cont_2=1 TO dw_califica.rowcount()
				ls_sub_calif =mid(ls_calif,ll_cont_2,1)
				ll_cuenta = dw_califica.object.mat_inscritas_cuenta[ll_cont_2]
				if mid(ls_calif,ll_cont_2,1)=' ' or mid(ls_calif,ll_cont_2,1)='*' then
					if dw_califica.object.materias_evaluacion[ll_cont_2]='NUM' or &
						dw_califica.object.materias_evaluacion[ll_cont_2]='NUIN' then
						dw_califica.object.mat_inscritas_calificacion[ll_cont_2]='5'
					else
						dw_califica.object.mat_inscritas_calificacion[ll_cont_2]='NA'
					end if
				else
					dw_califica.object.mat_inscritas_calificacion[ll_cont_2]=conv(mid(ls_calif,ll_cont_2,1))
				end if
			NEXT
			dw_califica.AcceptText()
			if dw_califica.update(true) = 1 then		
	
				UPDATE actas_evaluacion
				SET status = 1
				WHERE ( actas_evaluacion.cve_mat = :ll_clave ) AND
				( actas_evaluacion.gpo = :ls_grupo ) AND
				( actas_evaluacion.no_acta = :ll_numacta )
				USING gtr_sce;
				
				if gtr_sce.sqlcode=0 then
					commit using gtr_sce;
				else
					rollback using gtr_sce;
					messagebox("Error al actualizar","")
					return
				end if
			else
				rollback using gtr_sce;
				messagebox("Error al actualizar","")
				return
			end if
		end if
	else
		FileWrite(ii_error_file, "Sin Ins~t"+string(dw_actas.GetItemNumber(ll_cont_1,"clave"))+"-"+&
		dw_actas.GetItemString(ll_cont_1,"grupo")+"-"+string(dw_actas.GetItemNumber(ll_cont_1,"numacta"))+"-"+&
		string(dw_actas.GetItemNumber(ll_cont_1,"hoja"))+"-"+string(dw_actas.GetItemNumber(ll_cont_1,"inscritos"))+"-"+&
		dw_actas.GetItemString(ll_cont_1,"calif_num")+"-"+dw_actas.GetItemString(ll_cont_1,"calif_num"))
	end if
NEXT
end event

type dw_califica from datawindow within w_eva_norm
event constructor pbm_constructor
integer y = 1203
integer width = 3065
integer height = 874
integer taborder = 40
string dataobject = "d_califica"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_eva_norm
event clicked pbm_bnclicked
integer x = 1061
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
			messagebox("Peligro, está repetida el acta:",ls_repetida)
			return
		end if
	LOOP
next
messagebox("Faltan las siguientes actas:",ls_faltan)
end event

type cb_1 from commandbutton within w_eva_norm
event clicked pbm_bnclicked
integer x = 486
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

type dw_actas from uo_dw_captura within w_eva_norm
event constructor pbm_constructor
event doubleclicked pbm_dwnlbuttondblclk
event borra ( )
event agrega ( string linea )
integer x = 0
integer y = 413
integer width = 3065
integer height = 771
integer taborder = 10
string dataobject = "d_actas"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;if row>0 then
	dw_califica.retrieve(gi_anio,gi_periodo,dw_actas.object.clave[row],dw_actas.object.grupo[row])
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
	FileWrite(ii_error_file, "Año~t"+linea)
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
if lch_per<>Left (linea, li_a -1) then
	FileWrite(ii_error_file, "Periodo~t"+linea)
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
	FileWrite(ii_error_file, "Grupo~t"+linea)
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_grupo2=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_numacta=Left (linea, li_a -1)

if long(ls_numacta)=0 then
	FileWrite(ii_error_file, "NumActa~t"+linea)
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_hoja=Left (linea, li_a -1)

if integer(ls_hoja)=0 then
	FileWrite(ii_error_file, "NumHoja~t"+linea)
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_inscritos=Left (linea, li_a -1)

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
ls_calif_num=Left (linea, li_a -1)
//*************IMPORTANTE: Este cambio se realizo el 3 de mayo para corregir una falla de impresión
//*************UNICAMENTE en la lectura de actas de primavera 2002
//*************UNA VEZ CORREGIDA LA GENERACION DEBERAN QUITARSE LAS SIGUIENTES 3 LINEAS
//if not(ls_numacta="02517" OR ls_numacta="01266" OR ls_numacta="01400" OR ls_numacta="01083") then
//	ls_calif_num= f_corrige_renglon_26(ls_calif_num)
//end if
//*************IMPORTANTE: Las lineas se comentaron el 14 de junio de 2002

linea=mid(linea,li_a+1)
ls_calif_alfa=linea
//*************IMPORTANTE: Este cambio se realizo el 3 de mayo para corregir una falla de impresión
//*************UNICAMENTE en la lectura de actas de primavera 2002
//*************UNA VEZ CORREGIDA LA GENERACION DEBERAN QUITARSE LAS SIGUIENTES 3 LINEAS
//if not(ls_numacta="02517" OR ls_numacta="01266" OR ls_numacta="01400" OR ls_numacta="01083") then
//	ls_calif_alfa= f_corrige_renglon_26(ls_calif_alfa)
//end if
//*************IMPORTANTE: Las lineas se comentaron el 14 de junio de 2002

if integer(ls_hoja)=1 then
	insertrow(0)
	ll_renglon=rowcount()
	object.clave[ll_renglon]=long(ls_clave1+ls_clave2+ls_clave3+ls_clave4+ls_clave5)
	object.grupo[ll_renglon]=trim(char(integer(ls_grupo1))+char(integer(ls_grupo2)))
	object.numacta[ll_renglon]=long(ls_numacta)
	object.hoja[ll_renglon]=integer(ls_hoja)
	object.inscritos[ll_renglon]=integer(ls_inscritos)
	object.calif_num[ll_renglon]=ls_calif_num
	object.calif_alfa[ll_renglon]=ls_calif_alfa
else
	FOR ll_renglon=rowcount() TO 1 STEP -1
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
	messagebox(ls_anio+' '+lch_per+' '+ls_clave1+' '+ls_clave2+' '+ls_clave3+' ',ls_clave4+' '+ls_grupo1+' '+&
		ls_grupo2+' '+ls_numacta+' '+ls_hoja+' '+ls_inscritos+' '+ls_calif)

Formato: 

ANO, PERIODO, ls_clave1, ls_clave2, ls_clave3, ls_clave4, ls_grupo1, ls_grupo2, ls_numacta, ls_hoja, ls_inscritos, ls_calif
*/
end event

type uo_1 from uo_per_ani within w_eva_norm
integer x = 874
integer width = 1251
integer height = 166
integer taborder = 41
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

