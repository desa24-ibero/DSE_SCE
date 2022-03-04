$PBExportHeader$w_egresados.srw
$PBExportComments$Contiene el corte de los alumnos egresados. Actualiza el campo de egresado en la tabla de academicos. Juan Campos Abril-1998.
forward
global type w_egresados from w_ancestral
end type
type st_ultimacuenta from statictext within w_egresados
end type
type st_6 from statictext within w_egresados
end type
type st_update from statictext within w_egresados
end type
type st_5 from statictext within w_egresados
end type
type st_fin from statictext within w_egresados
end type
type st_inicio from statictext within w_egresados
end type
type st_4 from statictext within w_egresados
end type
type st_3 from statictext within w_egresados
end type
type st_2 from statictext within w_egresados
end type
type st_status from statictext within w_egresados
end type
type st_1 from statictext within w_egresados
end type
type st_status1 from statictext within w_egresados
end type
type cb_corteegresados from commandbutton within w_egresados
end type
type uo_1 from uo_per_ani within w_egresados
end type
end forward

global type w_egresados from w_ancestral
integer width = 2075
integer height = 964
st_ultimacuenta st_ultimacuenta
st_6 st_6
st_update st_update
st_5 st_5
st_fin st_fin
st_inicio st_inicio
st_4 st_4
st_3 st_3
st_2 st_2
st_status st_status
st_1 st_1
st_status1 st_status1
cb_corteegresados cb_corteegresados
uo_1 uo_1
end type
global w_egresados w_egresados

type variables
datastore dw_historico_sin_area
datastore dw_historico_area
DataStore dw_Revision,dw_mat_acred
end variables

forward prototypes
public function boolean revisa_areas_completas (long l_cuenta, integer l_carrera, integer l_plan, integer l_subsistema, string l_nivel)
public function boolean revisa_periodo_egreso (long cuenta, ref integer periodo, ref long anio, integer carrera, integer plan, string tabla)
end prototypes

public function boolean revisa_areas_completas (long l_cuenta, integer l_carrera, integer l_plan, integer l_subsistema, string l_nivel);int in_i, in_j, in_tot_mat, in_tot_mat_a, in_m, in_renglon, in_area2, in_CreditosComunes, in_area3
int in_FalMe, in_FalMa, in_Areas[14], in_CredMin[14], in_TotCred[14]
Boolean bo_Egresado = True, lb_rev
Integer in_Minimos = 0

Constant int ABa=1;Constant int AMaOb=2;Constant int AOT=3;Constant int ASS=4;Constant int AMeOb=5
Constant int AI0=6;Constant int AI1=7;Constant int AI2=8;Constant int AI3=9;Constant int AI4=10;
Constant int AMaOp = 11;Constant int AMeOp = 12 
Constant int SinEvalObg = 14;Constant int SinEvalOpt = 13 

dw_revision.Reset()
dw_mat_acred.Reset()
dw_historico_area.Reset()
dw_historico_sin_area.Reset()

SELECT 	cve_area_basica,					cve_area_mayor_oblig,		cve_area_mayor_opt,
			cve_area_opcion_terminal,		cve_area_servicio_social,
			cve_area_integ_fundamental,	cve_area_integ_tema1,		cve_area_integ_tema2,
			cve_area_integ_tema3,			cve_area_integ_tema4,
			cve_area_sintesis_eval_oblig, cve_area_sintesis_eval_opt
		INTO	:in_Areas[ABa], :in_Areas[AMaOb],	:in_Areas[AMaOp], :in_Areas[AOT], :in_Areas[ASS],
				:in_Areas[AI0], :in_Areas[AI1], 		:in_Areas[AI2],  :in_Areas[AI3], :in_Areas[AI4], 
				:in_Areas[SinEvalObg], :in_Areas[SinEvalOpt] 
		FROM plan_estudios
		WHERE cve_carrera = :l_carrera AND cve_plan = :l_plan
		USING gtr_sce;
if IsNull(l_subsistema) then l_subsistema = 0
if (l_subsistema<> 0) then
	SELECT cve_area  INTO :in_Areas[AMeOb] FROM subsistema 
		WHERE cve_subsistema = :l_subsistema 
		AND	cve_carrera = :l_carrera
		AND 	cve_plan = :l_plan
		AND 	clase_area LIKE "OBL"
		USING gtr_sce;

	SELECT cve_area  INTO :in_Areas[AMeOp] FROM subsistema 
		WHERE cve_subsistema = :l_subsistema 
		AND	cve_carrera = :l_carrera
		AND 	cve_plan = :l_plan
		AND 	clase_area LIKE "OPT"
		USING gtr_sce;
else
	if l_nivel = "L" then
		in_CredMin[AMeOp] = 1
		in_CredMin[AMeOb] = 1
	end if
end if

dw_historico_sin_area.retrieve(l_cuenta,l_carrera,l_plan)
in_tot_mat = dw_historico_sin_area.rowcount()
dw_mat_acred.insertrow(1)
dw_mat_acred.setitem(1,1,0)
dw_mat_acred.setitem(1,2,0)
if IsNull(in_Areas[AMeOp]) then in_Areas[AMeOp] = 0
if IsNull(in_Areas[AMaOp]) then in_Areas[AMaOp] = 0
in_i = 2
//for in_j = 1 to 12 
// Se agregan las nuevas áreas  
for in_j = 1 to 14
	if IsNull(in_Areas[in_j]) then in_Areas[in_j] = 0
	if in_CredMin[in_j] <> 1 then
		SELECT creditos_min INTO :in_CredMin[in_j] FROM areas WHERE cve_area = :in_Areas[in_j] USING gtr_sce; 
	end if
	if (in_Areas[in_j] <> 0) then
		in_area2 = 0
		in_area3 = 0
		
		// Se recuperan las áreas optativas 
		// Si es la Mayor Optativa, se excluyen la Menor Optativa y la de sintésis_optativa  
		if in_j = AMaOp then 
			in_area2 = in_Areas[AMeOp]
			in_area3 = in_Areas[SinEvalOpt]
		END IF 	
		
		// Si es la Menor Optativa, se excluyen la Mayor Optativa y la de   sintésis_optativa
		if in_j = AMeOp then 
			in_area2 = in_Areas[AMaOp]
			in_area3 = in_Areas[SinEvalOpt]
		END IF 	
		// Si es la Menor Optativa, se excluyen la Mayor Optativa y la de   sintésis_optativa
		if in_j = SinEvalOpt then 
			in_area2 = in_Areas[AMaOp]
			in_area3 = in_Areas[AMeOp]
		END IF 			
			
		dw_historico_area.retrieve(l_cuenta,in_Areas[in_j],l_carrera,l_plan, in_area2, in_area3)
		in_tot_mat_a = dw_historico_area.rowcount()
		if in_tot_mat_a > 0 then
			for in_m=1 to in_tot_mat_a
				in_renglon = dw_historico_sin_area.find("materias_materia = '"+&
										dw_historico_area.getitemstring(in_m,3)+"'", 1, in_tot_mat)
				if (in_renglon<>0) then
					dw_historico_sin_area.deleterow(in_renglon)
					in_tot_mat --
					dw_mat_acred.insertrow(in_i)
					dw_mat_acred.setitem(in_i,1,l_cuenta)//cuenta
					dw_mat_acred.setitem(in_i,2,TipoArea(in_j,l_plan))//tipo Area
					dw_mat_acred.setitem(in_i,3,dw_historico_area.getitemstring(in_m,2))//sigla
					dw_mat_acred.setitem(in_i,4,dw_historico_area.getitemstring(in_m,3))//materia
					dw_mat_acred.setitem(in_i,5,SacaPeriodo(&
								dw_historico_area.getitemnumber(in_m,4),dw_historico_area.getitemnumber(in_m,5),dw_historico_area.getitemnumber(in_m,8)))//periodo
					dw_mat_acred.setitem(in_i,6,dw_historico_area.getitemdecimal(in_m,6))//creditos
					in_TotCred[in_j] += dw_historico_area.getitemnumber(in_m,6)
					dw_mat_acred.setitem(in_i,7,dw_historico_area.getitemstring(in_m,7))//CalNum
					dw_mat_acred.setitem(in_i,8,ConvierteLetra(dw_historico_area.getitemstring(in_m,7)))//CalLetra
					dw_mat_acred.setitem(in_i,9,ConvierteObservacion(dw_historico_area.getitemnumber(in_m,8),lb_rev))//Observaciones
					dw_mat_acred.setitem(in_i,10,string(&
								dw_historico_area.getitemnumber(in_m,4)-1900)+string(dw_historico_area.getitemnumber(in_m,5)))//periodonumerico
					dw_mat_acred.setitem(in_i,11,dw_historico_area.getitemnumber(in_m,9))//sigla
					dw_mat_acred.setitem(in_i,12,in_j)//clave del area
					in_i++
				end if
			next
		end if
	end  if
next

GARBAGECOLLECT() 

//	dw_mat_acred.SetFilter("tipoarea="+string(AMeOp))
//	dw_mat_acred.Filter()
//	dw_mat_acred.GroupCalc()
//	if (dw_mat_acred.rowcount() > 0 ) then
//		CreditosComunes = dw_mat_acred.getitemnumber(1,"creditos_cursados")
//	end if
//	dw_mat_acred.SetFilter("")
//	dw_mat_acred.Filter()
in_CreditosComunes = 0


if (dw_historico_sin_area.RowCount() > 0) then
	//for in_j = AMaOp to AmeOp
	// Se modifica el ciclo del área 11 a la 13 para considerar la nueva optativa. 
	for in_j = AMaOp to SinEvalOpt 
		// Se recuperan las materias de cada una de las materias optativas 
		dw_historico_area.retrieve(l_cuenta,in_Areas[in_j],l_carrera,l_plan, 0)
		if (in_Areas[in_j] <> 0) then
			in_tot_mat_a = dw_historico_area.rowcount()
			if in_tot_mat_a > 0 then
				for in_m=1 to in_tot_mat_a
					if (in_TotCred[in_j] + dw_historico_area.getitemnumber(in_m,6) <= in_CredMin[in_j]) OR (in_j = AMeOp)then
						in_renglon = dw_historico_sin_area.find("materias_materia = '"+&
												dw_historico_area.getitemstring(in_m,3)+"'", 1, in_tot_mat)
						if (in_renglon<>0) then
							dw_historico_sin_area.deleterow(in_renglon)
							in_tot_mat --
							dw_mat_acred.insertrow(in_i)
							dw_mat_acred.setitem(in_i,1,l_cuenta)//cuenta
							dw_mat_acred.setitem(in_i,2,TipoArea(in_j,l_plan))//tipo Area
							dw_mat_acred.setitem(in_i,3,dw_historico_area.getitemstring(in_m,2))//sigla
							dw_mat_acred.setitem(in_i,4,dw_historico_area.getitemstring(in_m,3))//materia
							dw_mat_acred.setitem(in_i,5,SacaPeriodo(&
										dw_historico_area.getitemnumber(in_m,4),dw_historico_area.getitemnumber(in_m,5),dw_historico_area.getitemnumber(in_m,8)))//periodo
							dw_mat_acred.setitem(in_i,6,dw_historico_area.getitemdecimal(in_m,6))//creditos
							in_TotCred[in_j] += dw_historico_area.getitemnumber(in_m,6)
							in_CreditosComunes += dw_historico_area.getitemnumber(in_m,6)
							dw_mat_acred.setitem(in_i,7,dw_historico_area.getitemstring(in_m,7))//CalNum
							dw_mat_acred.setitem(in_i,8,ConvierteLetra(dw_historico_area.getitemstring(in_m,7)))//CalLetra
							dw_mat_acred.setitem(in_i,9,ConvierteObservacion(dw_historico_area.getitemnumber(in_m,8),lb_rev))//Observaciones
							dw_mat_acred.setitem(in_i,10,string(&
										dw_historico_area.getitemnumber(in_m,4)-1900)+string(dw_historico_area.getitemnumber(in_m,5)))//periodonumerico
							dw_mat_acred.setitem(in_i,11,dw_historico_area.getitemnumber(in_m,9))//sigla
							dw_mat_acred.setitem(in_i,12,in_j)//clave del area
							in_i++
						end if
					end if
				next
			end if
		end if
	next
end if
dw_revision.reset()

GARBAGECOLLECT() 

//for in_i = 1 to 12
// Se agregan las dos nuevas áreas 
for in_i = 1 to 14
	dw_mat_acred.SetFilter("tipoarea="+string(in_i))
	dw_mat_acred.Filter()
	dw_mat_acred.GroupCalc()
	dw_revision.InsertRow(in_i)
	dw_revision.SetItem(in_i,1,in_CredMin[in_i])
	if (dw_mat_acred.RowCount()>0) then
		dw_revision.SetItem(in_i,2,dw_mat_acred.getitemdecimal(1,"creditos_cursados"))
//		if (i = AMeOp) then CreditosComunes = dw_mat_acred.getitemnumber(1,&
//												"creditos_cursados") - CreditosComunes
	else
		dw_revision.SetItem(in_i,2,0)
	end if
next

dw_mat_acred.SetFilter("")
dw_mat_acred.Filter()
dw_mat_acred.SetSort("tipoarea A")
dw_mat_acred.Sort()
dw_mat_acred.GroupCalc()

in_FalMa = dw_revision.getitemnumber(AMaOp,"faltantes")
in_FalMe = dw_revision.getitemnumber(AMeOp,"faltantes")
if (in_FalMe < 0) then
	if (in_FalMa > 0) and (in_FalMe+in_FalMa <= 0) and (in_CreditosComunes >= in_FalMa) then
		dw_revision.setitem(AMaOp,"cursados", &
		dw_revision.getitemnumber(AMaOp,"cursados") + in_FalMa)
		dw_revision.setitem(AMeOp,"cursados", &
		dw_revision.getitemnumber(AMeOp,"cursados") - in_FalMa)
	end if
end if

if (in_FalMa < 0) then
	if (in_FalMe > 0) and (in_FalMe+in_FalMa <= 0) and (in_CreditosComunes >= in_FalMe) then
		dw_revision.setitem(AMeOp,"cursados", &
		dw_revision.getitemnumber(AMeOp,"cursados") + in_FalMe)
		dw_revision.setitem(AMaOp,"cursados", &
		dw_revision.getitemnumber(AMaOp,"cursados") - in_FalMe)
	end if
end if

if ((l_plan = 1) OR (l_plan = 2)) AND (l_nivel = "L") then
	if (dw_revision.getitemnumber(AI1,"cursados")+dw_revision.getitemnumber(AI2,"cursados")+&
		dw_revision.getitemnumber(AI3,"cursados")+dw_revision.getitemnumber(AI4,"cursados")+&
		dw_revision.getitemnumber(AI0,"cursados")>=40)then
				dw_revision.setitem(AI0,"minimos",dw_revision.getitemnumber(AI0,"cursados"))
				dw_revision.setitem(AI1,"minimos",dw_revision.getitemnumber(AI1,"cursados"))
				dw_revision.setitem(AI2,"minimos",dw_revision.getitemnumber(AI2,"cursados"))
				dw_revision.setitem(AI3,"minimos",dw_revision.getitemnumber(AI3,"cursados"))
				dw_revision.setitem(AI4,"minimos",dw_revision.getitemnumber(AI4,"cursados"))
	end if
end if

if  (((l_plan = 3) OR (l_plan = 4)) AND l_nivel = "L") then
	if (dw_revision.getitemnumber(AI1,"cursados")+dw_revision.getitemnumber(AI2,"cursados")+&
		dw_revision.getitemnumber(AI3,"cursados")+dw_revision.getitemnumber(AI4,"cursados")>=32)then
				dw_revision.setitem(AI1,"minimos",dw_revision.getitemnumber(AI1,"cursados"))
				dw_revision.setitem(AI2,"minimos",dw_revision.getitemnumber(AI2,"cursados"))
				dw_revision.setitem(AI3,"minimos",dw_revision.getitemnumber(AI3,"cursados"))
				dw_revision.setitem(AI4,"minimos",dw_revision.getitemnumber(AI4,"cursados"))
	end if
end if

For in_i = 1 To 12
	in_Minimos = in_Minimos + dw_revision.GetItemNumber(in_i,"minimos")
	If dw_revision.getitemnumber(in_i,"faltantes") > 0 Then 
		bo_Egresado = False
		Exit
	End if
Next	

GARBAGECOLLECT()

If	bo_Egresado And in_Minimos > 0 Then
	Return True		// Egresado ok 
Else
	Return False	// Faltan Créditos
End if 
end function

public function boolean revisa_periodo_egreso (long cuenta, ref integer periodo, ref long anio, integer carrera, integer plan, string tabla);// Gregresa el periodo y el año de la ultima materia inscrita
// Juan Campos Sánchez.

IF tabla = "h" THEN 

	Select max(periodo),anio
	Into :Periodo,:Anio
	From historico
	Where cuenta 		= :Cuenta And 
			cve_carrera = :Carrera And 
			cve_plan 	= :Plan And
			anio 			= (Select max(anio) From historico
								Where cuenta = :Cuenta
								AND cve_carrera = :Carrera 
								AND cve_plan 	= :Plan )
	Group BY anio
	using gtr_sce;

	If gtr_sce.Sqlcode = 0 Then
		Return True
	Else
		return False
	End if

ELSE
	
	periodo = gi_periodo
	anio = gi_anio 	
	
END IF 	

// SE COMENTA ESTA PARTE PARA CONSIDERAR LAS MATERIAS DEL HISTÓRICO 
// SE COMENTA ESTA PARTE PARA CONSIDERAR LAS MATERIAS DEL HISTÓRICO 
//periodo = gi_periodo
//anio = gi_anio 
// SE COMENTA ESTA PARTE PARA CONSIDERAR LAS MATERIAS DEL HISTÓRICO 
// SE COMENTA ESTA PARTE PARA CONSIDERAR LAS MATERIAS DEL HISTÓRICO 

return true

 
end function

event open;call super::open;// CORTE DE ALUMNOS EGRESADOS

// JUAN CAMPOS SÁNCHEZ.			ABRIL-1998.


end event

on w_egresados.create
int iCurrent
call super::create
this.st_ultimacuenta=create st_ultimacuenta
this.st_6=create st_6
this.st_update=create st_update
this.st_5=create st_5
this.st_fin=create st_fin
this.st_inicio=create st_inicio
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_status=create st_status
this.st_1=create st_1
this.st_status1=create st_status1
this.cb_corteegresados=create cb_corteegresados
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ultimacuenta
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.st_update
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_fin
this.Control[iCurrent+6]=this.st_inicio
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_status
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_status1
this.Control[iCurrent+13]=this.cb_corteegresados
this.Control[iCurrent+14]=this.uo_1
end on

on w_egresados.destroy
call super::destroy
destroy(this.st_ultimacuenta)
destroy(this.st_6)
destroy(this.st_update)
destroy(this.st_5)
destroy(this.st_fin)
destroy(this.st_inicio)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_status)
destroy(this.st_1)
destroy(this.st_status1)
destroy(this.cb_corteegresados)
destroy(this.uo_1)
end on

type p_uia from w_ancestral`p_uia within w_egresados
end type

type st_ultimacuenta from statictext within w_egresados
integer x = 1298
integer y = 756
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_egresados
integer x = 315
integer y = 756
integer width = 901
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "ULTIMA CUENTA PROCESADA:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_update from statictext within w_egresados
integer x = 1298
integer y = 572
integer width = 247
integer height = 76
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_egresados
integer x = 325
integer y = 564
integer width = 891
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "REGISTROS ACTUALIZADOS:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_fin from statictext within w_egresados
integer x = 1129
integer y = 464
integer width = 585
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_inicio from statictext within w_egresados
integer x = 1129
integer y = 368
integer width = 585
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_egresados
integer x = 485
integer y = 464
integer width = 603
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "FECHA Y HORA FIN: "
boolean focusrectangle = false
end type

type st_3 from statictext within w_egresados
integer x = 398
integer y = 368
integer width = 690
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "FECHA Y HORA INICIO: "
boolean focusrectangle = false
end type

type st_2 from statictext within w_egresados
integer x = 1605
integer y = 660
integer width = 110
integer height = 64
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "DE"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_status from statictext within w_egresados
integer x = 1298
integer y = 660
integer width = 247
integer height = 76
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_egresados
integer x = 402
integer y = 660
integer width = 818
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "REGISTROS PROCESADOS:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_status1 from statictext within w_egresados
integer x = 1765
integer y = 660
integer width = 256
integer height = 76
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = " "
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_corteegresados from commandbutton within w_egresados
event clicked pbm_bnclicked
integer x = 617
integer y = 20
integer width = 1024
integer height = 96
integer taborder = 1
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Corte Egresados"
end type

event clicked;// Ojo. Si no se hace el corte para actualizar creditos_cursados En Académicos
// usar el codigo comentado al final este codigo, para obtener los créditos del alumno
// Juan Campos Sánchez	Abril-1998.

LONG li_cve_Carrera
INTEGER li_cve_Plan,li_Sub,li_CredCur,li_Cont = 0,li_NumArchivo,li_PEgre =9
Decimal ldc_creditos
Long		ll_Cuenta,ll_i,ll_AEgre=0
String	ls_Ruta,ls_NombreArch,ls_Nivel
real lr_promedio
decimal ldc_credegre
Long ll_creditos
STRING ls_tabla
STRING ls_cadena_archivo

GetFileSaveName("Selecciona Archivo",ls_Ruta,ls_NombreArch,"TXT","Archivo de texto,*.TXT,")
li_NumArchivo = FileOpen(ls_Ruta,LineMode!,Write!,LockWrite!,Replace!)
 	
DataStore dw_cuentas
dw_cuentas = CREATE DataStore
//dw_cuentas.DataObject = "d_cambios_nota" 
//dw_cuentas.DataObject = "d_extraordinario_titulo" 
//dw_cuentas.DataObject = "d_banderas_inscrito" //cambiar la sig linea por esta linea,si las cuentas de los alumnos se van a tomar de banderas inscrito}

// Se cambia el dataobject para considerar el histórico de carreras 
//dw_cuentas.DataObject = "d_cuentas_academ"
dw_cuentas.DataObject = "d_cuentas_academ2"

//dw_cuentas.DataObject = "d_prueba"
dw_cuentas.Settransobject(gtr_sce)

 //***************************************************************
dw_revision = CREATE DataStore
dw_revision.DataObject = "d_revision_est"
dw_revision.Settransobject(gtr_sce)

dw_mat_acred = CREATE DataStore
dw_mat_acred.DataObject = "d_mat_acred"
dw_mat_acred.Settransobject(gtr_sce)

dw_historico_sin_area = CREATE DataStore
dw_historico_sin_area.DataObject = "d_hist_sin_area"
dw_historico_sin_area.settransobject(gtr_sce)

dw_historico_area = CREATE DataStore
dw_historico_area.DataObject = "d_hist_area"
dw_historico_area.settransobject(gtr_sce)
//***************************************************************
 
LONG ll_cuentas_totales 
ll_cuentas_totales = dw_cuentas.Retrieve(gs_tipo_periodo) 
st_status1.text= String(dw_cuentas.RowCount())
st_inicio.text = String(today(),"dd-mmm-yyyy h:mm")

For ll_i=1 To dw_cuentas.RowCount()
	
	ll_Cuenta = dw_cuentas.GetItemNumber(ll_i,"cuenta")
	
	/***/
	// IF ll_Cuenta <> 12475 THEN CONTINUE 
	/***/
	
	ls_tabla = dw_cuentas.GetItemString(ll_i,"tabla")
	li_cve_Carrera = dw_cuentas.GetItemNumber(ll_i,"cve_carrera") 
	li_cve_Plan = dw_cuentas.GetItemNumber(ll_i,"cve_plan")
	li_CredCur = dw_cuentas.GetItemNumber(ll_i,"creditos_cursados") 
	IF ISNULL(li_CredCur) THEN li_CredCur = 0 
	li_Sub = dw_cuentas.GetItemNumber(ll_i,"cve_subsistema") 
	ls_Nivel = dw_cuentas.GetItemSTRING(ll_i,"nivel") 
	
	/****************/
//	INSERT INTO prueba(cuenta, nivel) 
//	VALUES (:ll_Cuenta, :ls_tabla) 
//	USING gtr_sce; 
//
//	COMMIT USING gtr_sce; 
	/****************/	
	
//	Select cve_carrera,cve_plan,creditos_cursados,cve_subsistema,nivel 
//	Into :li_cve_Carrera,:li_cve_Plan,:li_CredCur,:li_Sub,:ls_Nivel
//	From	academicos
//	Where	cuenta = :ll_Cuenta
//	USING gtr_sce;	
//	If gtr_sce.Sqlcode < 0 Then Messagebox("Query academicos",string(gtr_sce.sqlcode)+' '+gtr_sce.sqlerrtext)	
	
	If gtr_sce.Sqlcode = 0 Then
		ldc_credegre = 0
		If IsNull(li_CredCur) Then li_CredCur=0
		Select cred_egresado INTO :ldc_credegre
		From	plan_estudios
		Where	cve_carrera = :li_cve_Carrera And cve_plan = :li_cve_Plan
		USING gtr_sce;
		If gtr_sce.sqlcode < 0 Then Messagebox("Query plan_estudios",string(gtr_sce.sqlcode)+' '+gtr_sce.sqlerrtext)		
      	If gtr_sce.SqlCode = 0 Then
			ll_creditos = 0
			//If li_CredCur + 60 >= li_CredEgre Then 
			//  If li_CredCur >= 0 Then
				If Revisa_Areas_Completas(ll_Cuenta,li_cve_Carrera,li_cve_Plan,li_Sub,ls_Nivel) Then 		
					
					GARBAGECOLLECT() 
					
					If Revisa_Periodo_Egreso(ll_Cuenta,li_PEgre,ll_AEgre,li_cve_Carrera,li_cve_Plan,ls_tabla) Then
						// Se recuperan los créditos con valor DECIMAL
						cred_prom(ll_cuenta,ldc_creditos,lr_promedio)
						// Se pasan los créditos a un ENTERO
						ll_creditos = INTEGER(ldc_creditos) 

						ls_cadena_archivo = "" 
						
						IF ls_tabla = "a" THEN  
						
							Update academicos   // Actualiza en academicos Egresado = 1 True 
							Set egresado 		= 1, 
								 periodo_egre	= :li_PEgre,
								 anio_egre 		= :ll_AEgre,
								 creditos_cursados = :ll_creditos,
								 promedio = :lr_promedio
							Where cuenta = :ll_Cuenta
							USING gtr_sce;
							
							ls_cadena_archivo = "academicos "
							
						ELSEIF ls_tabla = "h" THEN   
							
							Update hist_carreras   // Actualiza en academicos Egresado = 1 True 
							Set egresado_ant 		= 1, 
								 periodo_egre_ant	= :li_PEgre,
								 anio_egre_ant 		= :ll_AEgre,
								 creditos_cursados_ant = :ll_creditos,
								 promedio_ant = :lr_promedio  
							Where cuenta = :ll_Cuenta
								AND cve_carrera_ant = :li_cve_Carrera 
								AND cve_plan_ant = :li_cve_Plan							
							USING gtr_sce;							
							
							ls_cadena_archivo = "hist_carreras "
							
						END IF 	
						
						If gtr_sce.sqlcode < 0 Then Messagebox("update",string(gtr_sce.sqlcode)+' '+gtr_sce.sqlerrtext)	
						If gtr_sce.sqlcode = 0 Then
							Commit Using gtr_sce;
		            			li_Cont++
									
							ls_cadena_archivo = ls_cadena_archivo + " " + STRING(ll_Cuenta) + " " + STRING(li_cve_Carrera) + " " + STRING(li_cve_Plan) + " " + & 
														STRING(li_PEgre) + " " + STRING(ll_AEgre) 
							
							//FileWrite(li_NumArchivo,String(ll_Cuenta))
							FileWrite(li_NumArchivo, ls_cadena_archivo) 
							st_update.text = String(li_Cont) 
							
							/************************/
							/************************/
//							IF li_Cont = 500 THEN 
//								EXIT
//							END IF 	
							/************************/
							/************************/							
							
						Else
							STRING ls_error 
							ls_error = gtr_sce.sqlerrtext 
							Rollback Using gtr_sce;
							Messagebox("Error", ls_error)
						End if
					End If
 				End if
			//End if	
		End IF	
	End if	
	Commit using gtr_sce;
	st_status.text = String(ll_i)
	st_ultimacuenta.text = String(ll_Cuenta)
	
	GARBAGECOLLECT() 
	
Next

FileClose(li_NumArchivo) 
dw_cuentas.Reset() 
DESTROY dw_cuentas
//***************************************************************
DESTROY dw_revision  
DESTROY dw_mat_acred  
DESTROY dw_historico_sin_area 
DESTROY dw_historico_area   
//***************************************************************
st_fin.text = String(today(),"dd-mmm-yyyy h:mm")

 
 
// Usar este codigo si no se actualiza creditos_cursados En Academicos
// ***********************************************************************
// Real		Promedio
//	DECLARE Emp_proc procedure for calcula_promedio
//    	@cuenta   = :cuenta,
//    	@cve_carr = :carrera, 
//    	@plan     = :plan,
//    	@promedio = :promedio out, // Solo declara la variable y no lo tomes en cuenta
//    	@creditos = :creditos out
//  USING gtr_sce; // Usa este campo
//   	
//	EXECUTE Emp_proc ;
// 	FETCH Emp_proc INTO :promedio,:creditos;
// 	CLOSE Emp_proc;
// 	IF gtr_sce.sqlcode = 0 Then
//		Goto Error
//   End if
// ***********************************************************************	
end event

type uo_1 from uo_per_ani within w_egresados
integer x = 434
integer y = 156
integer width = 1253
integer height = 168
integer taborder = 2
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

