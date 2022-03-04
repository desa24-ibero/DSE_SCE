$PBExportHeader$uo_atencion_tsu.sru
forward
global type uo_atencion_tsu from nonvisualobject
end type
end forward

global type uo_atencion_tsu from nonvisualobject
end type
global uo_atencion_tsu uo_atencion_tsu

type variables
u_datastore ids_cuentas, ids_revision, ids_mat_acred
u_datastore ids_historico_sin_area, ids_historico_area  

end variables

forward prototypes
public function integer of_existe_hoja_libro_carrera (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function integer of_revision_estudios (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function integer of_adeuda_finanzas (long al_cuenta)
public function boolean of_titulado_anterior (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function long of_alumno_licenciatura (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function boolean of_revisa_areas_completas (long al_cuenta, long al_cve_carrera, long al_cve_plan, integer ai_subsistema, string as_nivel)
public function integer of_actualiza_datos_tramites (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function boolean of_alumno_susceptible (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function integer of_inserta_hoja_libro_carrera (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function boolean of_susceptible_diploma (long al_cuenta, long al_cve_carrera, long al_cve_plan)
public function integer of_actualiza_datos_tramites ()
public function integer of_inserta_carreras ()
public function integer of_inserta_carreras (long al_cuenta)
public function integer of_actualiza_datos_tramites_i ()
end prototypes

public function integer of_existe_hoja_libro_carrera (long al_cuenta, long al_cve_carrera, long al_cve_plan);//Función que inserta un egresado en el libro de carreras
//
//of_existe_hoja_libro_carrera
//
//Parámetros:		al_cuenta	
//						al_cve_carrera
//						al_cve_plan


int li_codigo_sql, li_cve_constancia
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_max_folio, ll_max_libro
long ll_folio_siguiente, ll_libro_siguiente, ll_libro, ll_num_veces
string ls_carrera, ls_nivel, ls_mensaje_sql, ls_sexo, ls_mensaje_aux
boolean 	lb_nueva_insercion 

lb_nueva_insercion = false
	
ll_cuenta = al_cuenta
ll_cve_carrera = al_cve_carrera
ll_cve_plan = al_cve_plan

SELECT COUNT(*)
INTO 	:ll_num_veces
FROM hoja_libro_carrera
WHERE  cuenta = :ll_cuenta
AND 	 cve_carrera =  :ll_cve_carrera
AND 	 cve_plan =  :ll_cve_plan
USING gtr_sce;

ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	MessageBox("Error al contar alumnos en libro:"+string(ll_cve_carrera),  ls_mensaje_sql)
	return -1
end if

if ll_num_veces = 0 then
	return 0
elseif ll_num_veces = 1 then
	return 1
elseif ll_num_veces > 1 then
	MessageBox("Error al contar alumnos en libro:"+string(ll_cve_carrera)+"~n *>1*",  ls_mensaje_sql)
	return -1	
end if


return -1

end function

public function integer of_revision_estudios (long al_cuenta, long al_cve_carrera, long al_cve_plan);//of_revision_estudios
//Recibe 	al_cuenta		long
//			al_cve_carrera	long
//			al_cve_plan		long
//

Integer	li_cve_Carrera,li_cve_Plan,li_Sub,li_CredCur,li_Cont = 0,li_NumArchivo,li_PEgre =9, li_creditos
Long		ll_Cuenta,ll_i,ll_AEgre=0, ll_num_alumnos
String	ls_Ruta,ls_NombreArch,ls_Nivel
real lr_promedio
integer li_codigo_sql
string ls_mensaje_sql

ids_cuentas = CREATE U_DataStore
ids_cuentas.DataObject = "d_cuenta_tramite_titulac"
ids_cuentas.Settransobject(gtr_sce)

 
ids_revision = CREATE U_DataStore
ids_revision.DataObject = "d_revision_est"
ids_revision.Settransobject(gtr_sce)

ids_mat_acred = CREATE U_DataStore
ids_mat_acred.DataObject = "d_mat_acred"
ids_mat_acred.Settransobject(gtr_sce)

ids_historico_sin_area = CREATE U_DataStore
ids_historico_sin_area.DataObject = "d_hist_sin_area"
ids_historico_sin_area.settransobject(gtr_sce)

ids_historico_area = CREATE U_DataStore
ids_historico_area.DataObject = "d_hist_area"
ids_historico_area.settransobject(gtr_sce)
 
ll_num_alumnos= ids_cuentas.Retrieve(al_cuenta,al_cve_carrera, al_cve_plan) 
if ll_num_alumnos= -1 then 
	Messagebox("Error de alumnos","Error en la consulta de datos del alumno",StopSign!)		
	Goto Fin
End if

For ll_i=1 To ids_cuentas.RowCount()
	ll_Cuenta = ids_cuentas.GetItemNumber(ll_i,"cuenta")
	li_cve_carrera = ids_cuentas.GetItemNumber(ll_i,"cve_carrera")
	li_cve_plan = ids_cuentas.GetItemNumber(ll_i,"cve_plan")
	li_Sub = ids_cuentas.GetItemNumber(ll_i,"cve_subsistema")
	ls_Nivel = "L"
	If li_cve_carrera> 0 and li_cve_plan>0 Then
		int li_credegre
		If IsNull(li_CredCur) Then li_CredCur=0
		Select cred_egresado INTO :li_CredEgre 
		From	plan_estudios
		Where	cve_carrera = :li_cve_Carrera And cve_plan = :li_cve_Plan
		USING gtr_sce;
		li_codigo_sql = gtr_sce.sqlcode
		ls_mensaje_sql = gtr_sce.sqlErrText		
		if li_codigo_sql= -1 then 
			Messagebox("Query plan_estudios",string(gtr_sce.sqlcode)+' '+gtr_sce.sqlerrtext,StopSign!)		
			Goto Fin
		end if
      If gtr_sce.SqlCode = 0 Then 
				If not of_revisa_areas_completas(ll_Cuenta,li_cve_Carrera,li_cve_Plan,li_Sub,ls_Nivel) Then 					
					Goto Fin
 				End if
//			End if	
		End IF	
	End if	
	Commit using gtr_sce;

Next

ids_cuentas.Reset() 
DESTROY ids_cuentas
DESTROY ids_revision  
DESTROY ids_mat_acred  
DESTROY ids_historico_sin_area 
DESTROY ids_historico_area  

return 0


Fin:
return -1
end function

public function integer of_adeuda_finanzas (long al_cuenta);//of_adeuda_finanzas
//Recibe	al_cuenta long
//Revisa si el alumno tiene adeudos en cobranzas

integer li_tiene_adeudos
integer li_sql_code=0
string ls_mensaje
long ll_cuenta

if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)= 1 then
	li_tiene_adeudos = tiene_adeudos(al_cuenta,gtr_scob) 
	if li_tiene_adeudos= -1 then		
		MessageBox("Error en tiene_adeudos","Error en función de Adeudos de Cobranzas",StopSign!)
		return -1
	end if
	desconecta_bd (gtr_scob)
else
	MessageBox("Error de consulta","No es posible Revisar Adeudos de Cobranzas",StopSign!)
	return -1
end if

//Asigna el Resultado de la revisión
UPDATE dbo.tramite_titulacion
SET  adeuda_finanzas = :li_tiene_adeudos
FROM dbo.tramite_titulacion
WHERE cuenta = :al_cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Actualizar", ls_mensaje,StopSign!)
	return -1
ELSE
	COMMIT USING gtr_sce;
//	MessageBox("Actualización Exitosa", "La información de finanzas ha sido guardada",Information!)
	return 0
END IF


return li_tiene_adeudos
end function

public function boolean of_titulado_anterior (long al_cuenta, long al_cve_carrera, long al_cve_plan);//of_titulado_anterior
//Recibe		al_cuenta			long
//				al_cve_carrera		long
//				al_cve_plan			long

integer li_sql_code=0
string ls_mensaje
long ll_cuenta, ll_cantidad

SELECT count(*)
INTO :ll_cantidad
FROM titulacion t
WHERE t.cuenta = :al_cuenta
AND t.aprobado = 1
AND NOT (t.cve_carrera = :al_cve_carrera
			AND t.cve_plan =:al_cve_plan)
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN
	MessageBox("Error al Consultar datos Titulacion", ls_mensaje,StopSign!)
	return false
ELSE
	IF ll_cantidad> 0 THEN
		return true
	else
		return false
	END IF
END IF

return false


end function

public function long of_alumno_licenciatura (long al_cuenta, long al_cve_carrera, long al_cve_plan);//of_alumno_licenciatura
//Recibe		al_cuenta			long
//				al_cve_carrera		long
//				al_cve_plan			long

integer li_sql_code=0
string ls_mensaje
long ll_cuenta

SELECT ac.cuenta 
INTO :ll_cuenta
FROM academicos ac, carreras c
WHERE ac.cuenta = :al_cuenta
AND ac.cve_carrera = :al_cve_carrera
AND ac.cve_plan =:al_cve_plan
AND ac.cve_carrera = c.cve_carrera
AND c.nivel = "L"
AND ac.cve_carrera not in (9532)
and ac.cve_plan in (1,2,3,4,98)
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN
	MessageBox("Error al Consultar datos Académicos", ls_mensaje,StopSign!)
	return -1
ELSEIF li_sql_code =100 THEN
	
	SELECT hc.cuenta
	INTO :ll_cuenta
	FROM hist_carreras hc, carreras c
	WHERE hc.cve_carrera_ant not in (9532)
	AND	hc.cve_plan_ant in (1,2,3,4,98)
	AND	hc.cve_carrera_ant = c.cve_carrera
	AND	c.nivel = "L" 
	AND	hc.cuenta = :al_cuenta
	AND	hc.cve_carrera_ant = :al_cve_carrera
	AND	hc.cve_plan_ant =:al_cve_plan
	AND	hc.cve_carrera_ant = c.cve_carrera
	USING gtr_sce;
	IF li_sql_code =-1 THEN
		MessageBox("Error al Consultar datos Académicos", ls_mensaje,StopSign!)
		return -1
	ELSEIF li_sql_code =100 THEN
		MessageBox("Alumno no Registrado", "El alumno no está registrado en la Licenciatura Indicada",StopSign!)
		return -1
	END IF
END IF

return li_sql_code


end function

public function boolean of_revisa_areas_completas (long al_cuenta, long al_cve_carrera, long al_cve_plan, integer ai_subsistema, string as_nivel);//public function boolean of_revisa_areas_completas 
//Recibe	long al_cuenta, 
//			integer al_cve_carrera, 
//			integer al_cve_plan, 
//			integer ai_subsistema, 
//			string as_nivel
			


int in_i, in_j, in_tot_mat, in_tot_mat_a, in_m, in_renglon, in_area2, in_CreditosComunes
int in_FalMe, in_FalMa, in_Areas[12], in_CredMin[12], in_TotCred[12]
Boolean bo_Egresado = True, lb_rev
Integer in_Minimos = 0

Constant int ABa=1;Constant int AMaOb=2;Constant int AOT=3;Constant int ASS=4;Constant int AMeOb=5
Constant int AI0=6;Constant int AI1=7;Constant int AI2=8;Constant int AI3=9;Constant int AI4=10;
Constant int AMaOp = 11;Constant int AMeOp = 12


ids_revision.Reset()
ids_mat_acred.Reset()
ids_historico_area.Reset()
ids_historico_sin_area.Reset()

SELECT 	cve_area_basica,					cve_area_mayor_oblig,		cve_area_mayor_opt,
			cve_area_opcion_terminal,		cve_area_servicio_social,
			cve_area_integ_fundamental,	cve_area_integ_tema1,		cve_area_integ_tema2,
			cve_area_integ_tema3,			cve_area_integ_tema4
		INTO	:in_Areas[ABa], :in_Areas[AMaOb],	:in_Areas[AMaOp], :in_Areas[AOT], :in_Areas[ASS],
				:in_Areas[AI0], :in_Areas[AI1], 		:in_Areas[AI2],  :in_Areas[AI3], :in_Areas[AI4]
		FROM plan_estudios
		WHERE cve_carrera = :al_cve_carrera AND cve_plan = :al_cve_plan
		USING gtr_sce;
if IsNull(ai_subsistema) then ai_subsistema = 0
if (ai_subsistema<> 0) then
	SELECT cve_area  INTO :in_Areas[AMeOb] FROM subsistema 
		WHERE cve_subsistema = :ai_subsistema 
		AND	cve_carrera = :al_cve_carrera
		AND 	cve_plan = :al_cve_plan
		AND 	clase_area LIKE "OBL"
		USING gtr_sce;

	SELECT cve_area  INTO :in_Areas[AMeOp] FROM subsistema 
		WHERE cve_subsistema = :ai_subsistema 
		AND	cve_carrera = :al_cve_carrera
		AND 	cve_plan = :al_cve_plan
		AND 	clase_area LIKE "OPT"
		USING gtr_sce;
else
	//if as_nivel = "L" then
	if as_nivel <> "P" then
		in_CredMin[AMeOp] = 1
		in_CredMin[AMeOb] = 1
	end if
end if

ids_historico_sin_area.retrieve(al_cuenta,al_cve_carrera,al_cve_plan)
in_tot_mat = ids_historico_sin_area.rowcount()
ids_mat_acred.insertrow(1)
ids_mat_acred.setitem(1,1,0)
ids_mat_acred.setitem(1,2,0)
if IsNull(in_Areas[AMeOp]) then in_Areas[AMeOp] = 0
if IsNull(in_Areas[AMaOp]) then in_Areas[AMaOp] = 0
in_i = 2
for in_j = 1 to 12
	if IsNull(in_Areas[in_j]) then in_Areas[in_j] = 0
	if in_CredMin[in_j] <> 1 then
		SELECT creditos_min INTO :in_CredMin[in_j] FROM areas WHERE cve_area = :in_Areas[in_j] USING gtr_sce; 
	end if
	if (in_Areas[in_j] <> 0) then
		in_area2 = 0
		if in_j = AMaOp then in_area2 = in_Areas[AMeOp]
		if in_j = AMeOp then in_area2 = in_Areas[AMaOp]
		ids_historico_area.retrieve(al_cuenta,in_Areas[in_j],al_cve_carrera,al_cve_plan, in_area2)
		in_tot_mat_a = ids_historico_area.rowcount()
		if in_tot_mat_a > 0 then
			for in_m=1 to in_tot_mat_a
				in_renglon = ids_historico_sin_area.find("materias_materia = '"+&
										ids_historico_area.getitemstring(in_m,3)+"'", 1, in_tot_mat)
				if (in_renglon<>0) then
					ids_historico_sin_area.deleterow(in_renglon)
					in_tot_mat --
					ids_mat_acred.insertrow(in_i)
					ids_mat_acred.setitem(in_i,1,al_cuenta)//cuenta
					ids_mat_acred.setitem(in_i,2,TipoArea(in_j,al_cve_plan))//tipo Area
					ids_mat_acred.setitem(in_i,3,ids_historico_area.getitemstring(in_m,2))//sigla
					ids_mat_acred.setitem(in_i,4,ids_historico_area.getitemstring(in_m,3))//materia
					ids_mat_acred.setitem(in_i,5,SacaPeriodo(&
								ids_historico_area.getitemnumber(in_m,4),ids_historico_area.getitemnumber(in_m,5),ids_historico_area.getitemnumber(in_m,8)))//periodo
					ids_mat_acred.setitem(in_i,6,ids_historico_area.getitemnumber(in_m,6))//creditos
					in_TotCred[in_j] += ids_historico_area.getitemnumber(in_m,6)
					ids_mat_acred.setitem(in_i,7,ids_historico_area.getitemstring(in_m,7))//CalNum
					ids_mat_acred.setitem(in_i,8,ConvierteLetra(ids_historico_area.getitemstring(in_m,7)))//CalLetra
					ids_mat_acred.setitem(in_i,9,ConvierteObservacion(ids_historico_area.getitemnumber(in_m,8),lb_rev))//Observaciones
					ids_mat_acred.setitem(in_i,10,string(&
								ids_historico_area.getitemnumber(in_m,4)-1900)+string(ids_historico_area.getitemnumber(in_m,5)))//periodonumerico
					ids_mat_acred.setitem(in_i,11,ids_historico_area.getitemnumber(in_m,9))//sigla
					ids_mat_acred.setitem(in_i,12,in_j)//clave del area
					in_i++
				end if
			next
		end if
	end  if
next

//	ids_mat_acred.SetFilter("tipoarea="+string(AMeOp))
//	ids_mat_acred.Filter()
//	ids_mat_acred.GroupCalc()
//	if (ids_mat_acred.rowcount() > 0 ) then
//		CreditosComunes = ids_mat_acred.getitemnumber(1,"creditos_cursados")
//	end if
//	ids_mat_acred.SetFilter("")
//	ids_mat_acred.Filter()
in_CreditosComunes = 0


if (ids_historico_sin_area.RowCount() > 0) then
	for in_j = AMaOp to AmeOp
		ids_historico_area.retrieve(al_cuenta,in_Areas[in_j],al_cve_carrera,al_cve_plan, 0)
		if (in_Areas[in_j] <> 0) then
			in_tot_mat_a = ids_historico_area.rowcount()
			if in_tot_mat_a > 0 then
				for in_m=1 to in_tot_mat_a
					if (in_TotCred[in_j] + ids_historico_area.getitemnumber(in_m,6) <= in_CredMin[in_j]) OR (in_j = AMeOp)then
						in_renglon = ids_historico_sin_area.find("materias_materia = '"+&
												ids_historico_area.getitemstring(in_m,3)+"'", 1, in_tot_mat)
						if (in_renglon<>0) then
							ids_historico_sin_area.deleterow(in_renglon)
							in_tot_mat --
							ids_mat_acred.insertrow(in_i)
							ids_mat_acred.setitem(in_i,1,al_cuenta)//cuenta
							ids_mat_acred.setitem(in_i,2,TipoArea(in_j,al_cve_plan))//tipo Area
							ids_mat_acred.setitem(in_i,3,ids_historico_area.getitemstring(in_m,2))//sigla
							ids_mat_acred.setitem(in_i,4,ids_historico_area.getitemstring(in_m,3))//materia
							ids_mat_acred.setitem(in_i,5,SacaPeriodo(&
										ids_historico_area.getitemnumber(in_m,4),ids_historico_area.getitemnumber(in_m,5),ids_historico_area.getitemnumber(in_m,8)))//periodo
							ids_mat_acred.setitem(in_i,6,ids_historico_area.getitemnumber(in_m,6))//creditos
							in_TotCred[in_j] += ids_historico_area.getitemnumber(in_m,6)
							in_CreditosComunes += ids_historico_area.getitemnumber(in_m,6)
							ids_mat_acred.setitem(in_i,7,ids_historico_area.getitemstring(in_m,7))//CalNum
							ids_mat_acred.setitem(in_i,8,ConvierteLetra(ids_historico_area.getitemstring(in_m,7)))//CalLetra
							ids_mat_acred.setitem(in_i,9,ConvierteObservacion(ids_historico_area.getitemnumber(in_m,8),lb_rev))//Observaciones
							ids_mat_acred.setitem(in_i,10,string(&
										ids_historico_area.getitemnumber(in_m,4)-1900)+string(ids_historico_area.getitemnumber(in_m,5)))//periodonumerico
							ids_mat_acred.setitem(in_i,11,ids_historico_area.getitemnumber(in_m,9))//sigla
							ids_mat_acred.setitem(in_i,12,in_j)//clave del area
							in_i++
						end if
					end if
				next
			end if
		end if
	next
end if
ids_revision.reset()
for in_i = 1 to 12
	ids_mat_acred.SetFilter("tipoarea="+string(in_i))
	ids_mat_acred.Filter()
	ids_mat_acred.GroupCalc()
	ids_revision.InsertRow(in_i)
	ids_revision.SetItem(in_i,1,in_CredMin[in_i])
	if (ids_mat_acred.RowCount()>0) then
		ids_revision.SetItem(in_i,2,ids_mat_acred.getitemnumber(1,"creditos_cursados"))
//		if (i = AMeOp) then CreditosComunes = ids_mat_acred.getitemnumber(1,&
//												"creditos_cursados") - CreditosComunes
	else
		ids_revision.SetItem(in_i,2,0)
	end if
next

ids_mat_acred.SetFilter("")
ids_mat_acred.Filter()
ids_mat_acred.SetSort("tipoarea A")
ids_mat_acred.Sort()
ids_mat_acred.GroupCalc()

in_FalMa = ids_revision.getitemnumber(AMaOp,"faltantes")
in_FalMe = ids_revision.getitemnumber(AMeOp,"faltantes")
if (in_FalMe < 0) then
	if (in_FalMa > 0) and (in_FalMe+in_FalMa <= 0) and (in_CreditosComunes >= in_FalMa) then
		ids_revision.setitem(AMaOp,"cursados", &
		ids_revision.getitemnumber(AMaOp,"cursados") + in_FalMa)
		ids_revision.setitem(AMeOp,"cursados", &
		ids_revision.getitemnumber(AMeOp,"cursados") - in_FalMa)
	end if
end if

if (in_FalMa < 0) then
	if (in_FalMe > 0) and (in_FalMe+in_FalMa <= 0) and (in_CreditosComunes >= in_FalMe) then
		ids_revision.setitem(AMeOp,"cursados", &
		ids_revision.getitemnumber(AMeOp,"cursados") + in_FalMe)
		ids_revision.setitem(AMaOp,"cursados", &
		ids_revision.getitemnumber(AMaOp,"cursados") - in_FalMe)
	end if
end if

//if ((al_cve_plan = 1) OR (al_cve_plan = 2)) AND (as_nivel = "L") then
if ((al_cve_plan = 1) OR (al_cve_plan = 2)) AND (as_nivel <> "P") then	
	if (ids_revision.getitemnumber(AI1,"cursados")+ids_revision.getitemnumber(AI2,"cursados")+&
		ids_revision.getitemnumber(AI3,"cursados")+ids_revision.getitemnumber(AI4,"cursados")+&
		ids_revision.getitemnumber(AI0,"cursados")>=40)then
				ids_revision.setitem(AI0,"minimos",ids_revision.getitemnumber(AI0,"cursados"))
				ids_revision.setitem(AI1,"minimos",ids_revision.getitemnumber(AI1,"cursados"))
				ids_revision.setitem(AI2,"minimos",ids_revision.getitemnumber(AI2,"cursados"))
				ids_revision.setitem(AI3,"minimos",ids_revision.getitemnumber(AI3,"cursados"))
				ids_revision.setitem(AI4,"minimos",ids_revision.getitemnumber(AI4,"cursados"))
	end if
end if

//if  (((al_cve_plan = 3) OR (al_cve_plan = 4)) AND as_nivel = "L") then
if  (((al_cve_plan = 3) OR (al_cve_plan = 4)) AND as_nivel <> "P") then
	if (ids_revision.getitemnumber(AI1,"cursados")+ids_revision.getitemnumber(AI2,"cursados")+&
		ids_revision.getitemnumber(AI3,"cursados")+ids_revision.getitemnumber(AI4,"cursados")>=32)then
				ids_revision.setitem(AI1,"minimos",ids_revision.getitemnumber(AI1,"cursados"))
				ids_revision.setitem(AI2,"minimos",ids_revision.getitemnumber(AI2,"cursados"))
				ids_revision.setitem(AI3,"minimos",ids_revision.getitemnumber(AI3,"cursados"))
				ids_revision.setitem(AI4,"minimos",ids_revision.getitemnumber(AI4,"cursados"))
	end if
end if

in_CredMin[AMaOp] = ids_revision.getitemnumber(AMaOp,"minimos")
in_CredMin[AMeOp] = ids_revision.getitemnumber(AMeOp,"minimos")

in_TotCred[AMaOp] = ids_revision.getitemnumber(AMaOp,"cursados")
in_TotCred[AMeOp] = ids_revision.getitemnumber(AMeOp,"cursados")

If f_actualiza_creditos_revision(al_cuenta, al_cve_carrera, al_cve_plan, in_CredMin , in_TotCred )= -1 THEN
	RETURN FALSE	
else
	return true
end if

//El resto no debe ejecutarse...
For in_i = 1 To 12
	in_Minimos = in_Minimos + ids_revision.GetItemNumber(in_i,"minimos")
	If ids_revision.getitemnumber(in_i,"faltantes") > 0 Then 
		bo_Egresado = False
		Exit
	End if
Next	

If	bo_Egresado And in_Minimos > 0 Then
	Return True		// Egresado ok 
Else
	Return False	// Faltan Créditos
End if 


end function

public function integer of_actualiza_datos_tramites (long al_cuenta, long al_cve_carrera, long al_cve_plan);//of_actualiza_datos_tramites
//Actualiza la información requerida en el tramite de titulacion
integer li_sql_code=0
string ls_mensaje
long ll_cuenta
integer li_tiene_adeudos

if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)= 1 then
	li_tiene_adeudos = tiene_adeudos(al_cuenta,gtr_scob) 
	if li_tiene_adeudos= -1 then		
		MessageBox("Error en tiene_adeudos","Error en función de Adeudos de Cobranzas",StopSign!)
		return -1
	end if
	desconecta_bd (gtr_scob)
else
	MessageBox("Error de consulta","No es posible Revisar Adeudos de Cobranzas",StopSign!)
	return -1
end if


//Limpia los tramite de titulación indicANDo que les falta todo

UPDATE dbo.tramite_titulacion
SET prerreq_ingles = 0,
	 certificado = 0,
	 titulado = 0,
	 egresado = 0,
	 tiene_mats_reval = 0,
	 docs_nacim = 0,
	 docs_rev_est = 0,
	 docs_ss = 0,
	 docs_pliego_reval = 0,
	 docs_estudios = 0,
	 baja_laboratorio = 0,
	 baja_biblioteca = 0,
	 adeuda_finanzas = 1,
	 baja_disciplina = 0
FROM dbo.tramite_titulacion
WHERE cuenta = :al_cuenta
AND	cve_carrera = :al_cve_carrera
AND	cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Actualiza si el alumno tiene adeudos de finanzas
UPDATE dbo.tramite_titulacion
SET  adeuda_finanzas = :li_tiene_adeudos
FROM dbo.tramite_titulacion
WHERE cuenta = :al_cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Actualiza el tramite de titulación indicANDo a los que tienen aprobado el
//prerrequisito de ingles
UPDATE dbo.tramite_titulacion
SET prerreq_ingles = 1
FROM dbo.historico h, dbo.tramite_titulacion tt
WHERE h.cve_mat in (4078)
AND h.calificacion = "AC"
AND h.cuenta = tt.cuenta
AND h.cve_carrera = tt.cve_carrera
AND h.cve_plan = tt.cve_plan
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Actualiza el tramite de titulación indicANDo a los que tienen aprobado el examen

UPDATE dbo.tramite_titulacion
SET titulado = 1
FROM dbo.titulacion t, dbo.tramite_titulacion tt
WHERE t.cuenta = tt.cuenta
AND t.cve_carrera = tt.cve_carrera
AND t.cve_plan = tt.cve_plan
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
AND	t.aprobado = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Actualiza el tramite de titulación indicANDo a los que han solicitado certificado total

UPDATE dbo.tramite_titulacion
SET certificado = 1
FROM dbo.certificado c, dbo.tramite_titulacion tt
WHERE c.cuenta = tt.cuenta
AND c.cve_carrera = tt.cve_carrera
AND c.cve_plan = tt.cve_plan
AND c.parcial = 0
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Actualiza el tramite de titulación indicANDo a los alumnos egresados

UPDATE dbo.tramite_titulacion
SET egresado = 1
FROM dbo.academicos a, dbo.tramite_titulacion tt
WHERE a.cuenta = tt.cuenta
AND a.cve_carrera = tt.cve_carrera
AND a.cve_plan = tt.cve_plan
AND a.egresado = 1
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

UPDATE dbo.tramite_titulacion
SET egresado = 1
FROM dbo.hist_carreras h, dbo.tramite_titulacion tt
WHERE h.cuenta = tt.cuenta
AND h.cve_carrera_ant = tt.cve_carrera
AND h.cve_plan_ant = tt.cve_plan
AND h.egresado_ant = 1
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Tiene materias revalidadas
UPDATE dbo.tramite_titulacion
SET tiene_mats_reval = 1
FROM dbo.historico h, dbo.tramite_titulacion tt
WHERE h.observacion = 5
AND h.cuenta = tt.cuenta
AND h.cve_carrera = tt.cve_carrera
AND h.cve_plan = tt.cve_plan
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Documentos de Nacimiento
UPDATE dbo.tramite_titulacion
SET docs_nacim = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (1,14)
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Quita aquellos que están en anomalía
UPDATE dbo.tramite_titulacion
SET docs_nacim = 0
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (0,6)
AND d.en_archivo = 0
AND d.cve_documento in (14)
AND tt.docs_nacim = 1
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Revision de Estudios
UPDATE dbo.tramite_titulacion
SET docs_rev_est = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (9,55,80)
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Servicio Social
UPDATE dbo.tramite_titulacion
SET docs_ss = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (6,79)
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Documentos de Pliego de Revalidacion para alumnos con materias revalidadas
UPDATE dbo.tramite_titulacion
SET docs_pliego_reval = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (33)
AND tt.tiene_mats_reval = 1
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Bloqueo de biblioteca
UPDATE dbo.tramite_titulacion
SET baja_biblioteca = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt
WHERE b.cuenta = tt.cuenta
AND b.cve_flag_biblioteca in (3)
AND	b.cuenta = :al_cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de adeudo de laboratorio
UPDATE dbo.tramite_titulacion
SET baja_laboratorio = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt
WHERE b.cuenta = tt.cuenta
AND b.baja_laboratorio in (1)
AND	b.cuenta = :al_cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de baja por disciplina
UPDATE dbo.tramite_titulacion
SET baja_disciplina = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt
WHERE b.cuenta = tt.cuenta
AND b.baja_disciplina in (1)
AND	b.cuenta = :al_cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Estudios de Bachillerato
UPDATE dbo.tramite_titulacion
SET docs_estudios = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (3)
AND	tt.cuenta = :al_cuenta
AND	tt.cve_carrera = :al_cve_carrera
AND	tt.cve_plan = :al_cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	
	Goto Error
ELSE
	COMMIT USING gtr_sce;
//	MessageBox("Actualización Exitosa", "La información de los documentos ha sido guardada",Information!)
	return 0
END IF

Error:
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Actualizar", ls_mensaje,StopSign!)
	return -1
	
RETURN 0
end function

public function boolean of_alumno_susceptible (long al_cuenta, long al_cve_carrera, long al_cve_plan);// of_alumno_susceptible
//Recibe 	al_cuenta	long
//			al_cve_carrera long
//			al_cve_plan

integer li_adeuda_finanzas, li_baja_biblioteca, li_baja_laboratorio, li_baja_disciplina
integer li_tiene_mats_reval, li_docs_pliego_reval
integer li_docs_nacim, li_docs_estudios, li_docs_rev_est, li_docs_ss
integer li_sql_code=0
string ls_mensaje
long ll_cuenta
boolean lb_titulado_anterior


SELECT
isnull(adeuda_finanzas,-1),
isnull(baja_laboratorio,-1),
isnull(baja_biblioteca,-1),
isnull(baja_disciplina,-1),

isnull(tiene_mats_reval,-1),
isnull(docs_pliego_reval,-1),

isnull(docs_nacim,-1),
isnull(docs_estudios,-1),
isnull(docs_rev_est,-1),
isnull(docs_ss,-1)
INTO
:li_adeuda_finanzas,
:li_baja_laboratorio,
:li_baja_biblioteca,
:li_baja_disciplina,

:li_tiene_mats_reval,
:li_docs_pliego_reval,

:li_docs_nacim,
:li_docs_estudios,
:li_docs_rev_est,
:li_docs_ss
FROM tramite_titulacion
WHERE cuenta = :al_cuenta
AND   cve_carrera = :al_cve_carrera
AND   cve_plan = :al_cve_plan
USING gtr_sce;

li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText

IF li_sql_code =-1 THEN	
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Consultar", ls_mensaje,StopSign!)
	return false
ELSE

lb_titulado_anterior = of_titulado_anterior(al_cuenta, al_cve_carrera, al_cve_plan)

//A petición de cobranzas, la revisión de finanzas no será obstáculo en el 
//trámite de opción cero
//	if li_adeuda_finanzas=0 and li_baja_laboratorio=0 then
//2015-02-27 FORZADO A TRUE	
//return true
//2015-03-06 YA LIBERADO	CON TODAS LAS REVISIONES

//Revisa adeudos de biblioteca
	if li_baja_biblioteca=0 then
//Revisa baja por disciplina
		if li_baja_disciplina=0 then		
//Si tiene materias revalidadas y pliego de revalidación o no tiene materias revalidadas
			if (li_tiene_mats_reval =1 and li_docs_pliego_reval=1) or &
				(li_tiene_mats_reval = 0) then
//Si tiene los documentos de nacimiento , 
//revisión de estudios y carta de servicio social			
				if li_docs_nacim=1 and &
					li_docs_rev_est=1 and li_docs_ss=1 then
//Si tiene certificado de estudios de bachillerato o se titulo antes en la ibero, 
					if lb_titulado_anterior or li_docs_estudios=1 then
						return true
					else
						return false				
					end if								
				else
					return false				
				end if			
			else
				return false	
			end if	
		else
			return false		
		end if
	else
		return false		
	end if
END IF

return true
end function

public function integer of_inserta_hoja_libro_carrera (long al_cuenta, long al_cve_carrera, long al_cve_plan);//Función que inserta un egresado en el libro de carreras
//
//of_inserta_hoja_libro_carrera
//
//Parámetros:		al_cuenta	
//						al_cve_carrera
//						al_cve_plan


int li_codigo_sql, li_cve_constancia, li_existente
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_max_folio, ll_max_libro
long ll_folio_siguiente, ll_libro_siguiente, ll_libro
string ls_carrera, ls_nivel, ls_mensaje_sql, ls_sexo, ls_mensaje_aux
boolean 	lb_nueva_insercion 

lb_nueva_insercion = false
	
ll_cuenta = al_cuenta
ll_cve_carrera = al_cve_carrera
ll_cve_plan = al_cve_plan

SELECT COUNT(*) 
INTO :li_existente
FROM hoja_libro_carrera
WHERE cuenta = :ll_cuenta
AND   cve_carrera = :ll_cve_carrera
USING gtr_sce;

ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	ls_mensaje_aux="Error al consultar en hoja_libro_carrera : "
	MessageBox(ls_mensaje_aux+string(ll_cuenta)+":"+string(ll_cve_carrera),  ls_mensaje_sql, StopSign!)
	return -1
end if

if li_existente=1 then
	return 0
end if



SELECT max(folio)
INTO	:ll_max_folio
FROM	libro_carrera
WHERE cve_carrera = :ll_cve_carrera
AND   folio < 500
USING gtr_sce;

ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	MessageBox("Error al recuperar el folio máximo en el libro:"+string(ll_cve_carrera),  ls_mensaje_sql)
end if

SELECT max(libro)
INTO	:ll_max_libro
FROM	libro_carrera
WHERE cve_carrera = :ll_cve_carrera
USING gtr_sce;

ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	MessageBox("Error al recuperar el libro máximo del libro:"+string(ll_cve_carrera),  ls_mensaje_sql)
//elseif li_codigo_sql=100 then
//	ll_max_folio = 0
//	ll_max_libro = 0
end if



if isnull(ll_max_folio) then
	lb_nueva_insercion = true
	ll_max_folio = 0
	if isnull(ll_max_libro) then
		ll_max_libro = 0
	end if
	ll_folio_siguiente= ll_max_folio +1
	ll_libro_siguiente= ll_max_libro +1
	ll_libro = ll_libro_siguiente
else
	ll_libro = ll_max_libro
end if




ll_folio_siguiente= ll_max_folio +1
if lb_nueva_insercion then

	ls_mensaje_aux="Error al insertar en libro_carrera en el libro: "

	INSERT INTO	libro_carrera
	(cve_carrera, libro, folio)
	VALUES
	(:ll_cve_carrera, :ll_libro, :ll_folio_siguiente)
	USING gtr_sce;
else

	ls_mensaje_aux="Error al actualizar en libro_carrera en el libro: "

	UPDATE libro_carrera
	SET    folio = :ll_folio_siguiente
	FROM   libro_carrera
	WHERE  cve_carrera = :ll_cve_carrera
	AND 	 libro =  :ll_libro
	USING gtr_sce;
end if


ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	rollback using gtr_sce;
	MessageBox(ls_mensaje_aux+string(ll_cve_carrera),  ls_mensaje_sql, StopSign!)
	return 	li_codigo_sql

end if


if li_existente=0 then

	INSERT INTO hoja_libro_carrera
		(cve_carrera, libro, folio, cuenta, cve_plan)
	VALUES
		(:ll_cve_carrera, :ll_libro, :ll_folio_siguiente, :ll_cuenta, :ll_cve_plan)
	USING gtr_sce;

	ls_mensaje_sql=gtr_sce.SqlErrText
	li_codigo_sql=gtr_sce.SqlCode

	if li_codigo_sql = -1 then
		rollback using gtr_sce;
		MessageBox(ls_mensaje_aux+string(ll_cve_carrera),  ls_mensaje_sql, StopSign!)
	elseif li_codigo_sql= 0 then
//	MessageBox("Actualización exitosa",  "Se registro en libros correctamente", Information! )	
		commit using gtr_sce;
	end if
else 
	return 0
end if

return li_codigo_sql


end function

public function boolean of_susceptible_diploma (long al_cuenta, long al_cve_carrera, long al_cve_plan);//of_susceptible_diploma
//Recibe	al_cuenta
//			al_cve_carrera
//			al_cve_plan

long ll_num_mats, ll_cuenta
integer li_codigo_sql
string ls_mensaje

IF al_cve_carrera = 4601 OR al_cve_carrera = 4602 THEN
	
	SELECT count(*), h.cuenta 
	INTO :ll_num_mats, :ll_cuenta
	FROM tramite_titulacion tt, historico h
	WHERE tt.cuenta = h.cuenta
	AND tt.cve_carrera in (4601,4602)
	AND h.anio <1994
	AND tt.cuenta = :al_cuenta
	AND tt.cve_carrera = :al_cve_carrera
	AND tt.cve_plan = :al_cve_plan	
	GROUP BY h.cuenta
	USING gtr_sce;

	li_codigo_sql = gtr_sce.SQLCode
	ls_mensaje = gtr_sce.SQLErrText
	
	IF li_codigo_sql = -1 THEN
		MessageBox("Error al consultar susceptibles de diploma",ls_mensaje, StopSign!)
		return true
	ELSEIF li_codigo_sql = 100 OR (isnull(ll_num_mats) AND isnull(ll_cuenta)) THEN
		return false
	ELSE
		IF ll_num_mats>0 THEN
			return true
		ELSE
			return false
		END IF
	END IF	
ELSE
	return false	
END IF

return false
end function

public function integer of_actualiza_datos_tramites ();//of_actualiza_datos_tramites
//Actualiza la información requerida en el tramite de titulacion
integer li_sql_code=0
string ls_mensaje
long ll_cuenta

//Limpia los tramite de titulación indicANDo que les falta todo

UPDATE dbo.tramite_titulacion
SET prerreq_ingles = 0,
	 certificado = 0,
	 titulado = 0,
	 egresado = 0,
	 tiene_mats_reval = 0,
	 docs_nacim = 0,
	 docs_rev_est = 0,
	 docs_ss = 0,
	 docs_pliego_reval = 0,
	 docs_estudios = 0,
	 baja_laboratorio = 0,
	 baja_biblioteca = 0,
	 adeuda_finanzas = 1,
	 baja_disciplina = 0
FROM dbo.tramite_titulacion
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error



//Actualiza el tramite de titulación indicANDo a los que tienen aprobado el
//prerrequisito de ingles
UPDATE dbo.tramite_titulacion
SET prerreq_ingles = 1
FROM dbo.historico h, dbo.tramite_titulacion tt
WHERE h.cve_mat in (4078)
AND h.calificacion = "AC"
AND h.cuenta = tt.cuenta
AND h.cve_carrera = tt.cve_carrera
AND h.cve_plan = tt.cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Actualiza el tramite de titulación indicANDo a los que tienen aprobado el examen

UPDATE dbo.tramite_titulacion
SET titulado = 1
FROM dbo.titulacion t, dbo.tramite_titulacion tt
WHERE t.cuenta = tt.cuenta
AND t.cve_carrera = tt.cve_carrera
AND t.cve_plan = tt.cve_plan
AND t.aprobado = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Actualiza el tramite de titulación indicANDo a los que han solicitado certificado total

UPDATE dbo.tramite_titulacion
SET certificado = 1
FROM dbo.certificado c, dbo.tramite_titulacion tt
WHERE c.cuenta = tt.cuenta
AND c.cve_carrera = tt.cve_carrera
AND c.cve_plan = tt.cve_plan
AND c.parcial = 0
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Actualiza el tramite de titulación indicANDo a los alumnos egresados

UPDATE dbo.tramite_titulacion
SET egresado = 1
FROM dbo.academicos a, dbo.tramite_titulacion tt
WHERE a.cuenta = tt.cuenta
AND a.cve_carrera = tt.cve_carrera
AND a.cve_plan = tt.cve_plan
AND a.egresado = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

UPDATE dbo.tramite_titulacion
SET egresado = 1
FROM dbo.hist_carreras h, dbo.tramite_titulacion tt
WHERE h.cuenta = tt.cuenta
AND h.cve_carrera_ant = tt.cve_carrera
AND h.cve_plan_ant = tt.cve_plan
AND h.egresado_ant = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Tiene materias revalidadas
UPDATE dbo.tramite_titulacion
SET tiene_mats_reval = 1
FROM dbo.historico h, dbo.tramite_titulacion tt
WHERE h.observacion = 5
AND h.cuenta = tt.cuenta
AND h.cve_carrera = tt.cve_carrera
AND h.cve_plan = tt.cve_plan
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Documentos de Nacimiento
UPDATE dbo.tramite_titulacion
SET docs_nacim = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (1,14)
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Quita aquellos que están en anomalía
UPDATE dbo.tramite_titulacion
SET docs_nacim = 0
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (0,6)
AND d.en_archivo = 0
AND d.cve_documento in (14)
AND tt.docs_nacim = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Revision de Estudios
UPDATE dbo.tramite_titulacion
SET docs_rev_est = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (9,55,80)
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Servicio Social
UPDATE dbo.tramite_titulacion
SET docs_ss = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (6,79)
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Documentos de Pliego de Revalidacion para alumnos con materias revalidadas
UPDATE dbo.tramite_titulacion
SET docs_pliego_reval = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (33)
AND tt.tiene_mats_reval = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de biblioteca
UPDATE dbo.tramite_titulacion
SET baja_biblioteca = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt
WHERE b.cuenta = tt.cuenta
AND b.cve_flag_biblioteca in (3)
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de adeudo de laboratorio
UPDATE dbo.tramite_titulacion
SET baja_laboratorio = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt
WHERE b.cuenta = tt.cuenta
AND b.baja_laboratorio in (1)
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de baja por disciplina
UPDATE dbo.tramite_titulacion
SET baja_disciplina = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt
WHERE b.cuenta = tt.cuenta
AND b.baja_disciplina in (1)
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Bloqueo de finanzas**Todos deben hasta que se realice la revisión en línea
UPDATE dbo.tramite_titulacion
SET adeuda_finanzas = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Estudios de Bachillerato
UPDATE dbo.tramite_titulacion
SET docs_estudios = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (3)
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	
	Goto Error
ELSE
	COMMIT USING gtr_sce;
	MessageBox("Actualización Exitosa", "La información de los documentos ha sido guardada",Information!)
	return 0
END IF

Error:
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Actualizar", ls_mensaje,StopSign!)
	return -1
	
RETURN 0
end function

public function integer of_inserta_carreras ();//of_inserta_carreras
//Inserta la información requerida en el tramite de titulacion
integer li_sql_code=0
string ls_mensaje
long ll_cuenta

//Elimina los registros de tramite de titulación (el esqueleto)
DELETE FROM tramite_titulacion
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Inserta los registros de tramite de titulación (el esqueleto)

INSERT INTO tramite_titulacion (cuenta, cve_carrera, cve_plan, cve_subsistema, egresado)
select distinct hc.cuenta, cve_carrera= hc.cve_carrera_ant, cve_plan = hc.cve_plan_ant, cve_subsistema = hc.cve_subsistema_ant, egresado= hc.egresado_ant
from hist_carreras hc, carreras c
where hc.cve_carrera_ant not in (9532)
and	hc.cve_plan_ant in (1,2,3,4,6,98)
and	hc.cve_carrera_ant = c.cve_carrera
and	c.nivel = "L"
union 
select distinct a.cuenta, a.cve_carrera, a.cve_plan, a.cve_subsistema, a.egresado
from academicos a, carreras c 
where a.cve_carrera not in (9532)
and	a.cve_plan in (1,2,3,4,6,98)
and	a.cve_carrera = c.cve_carrera
and	c.nivel = "L"
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	
	Goto Error
ELSE
	COMMIT USING gtr_sce;
//	MessageBox("Actualización Exitosa", "La información de los documentos ha sido guardada",Information!)
	return 0
END IF

Error:
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Insertar tramite_titulacion", ls_mensaje,StopSign!)
	return -1
	
RETURN 0
end function

public function integer of_inserta_carreras (long al_cuenta);//of_inserta_carreras
//Inserta la información requerida en el tramite de titulacion
integer li_sql_code=0
string ls_mensaje
long ll_cuenta, ll_rows_insertados

//Elimina los registros de tramite de titulación (el esqueleto)
DELETE FROM tramite_titulacion
WHERE cuenta = :al_cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Inserta los registros de tramite de titulación (el esqueleto)

INSERT INTO tramite_titulacion (cuenta, cve_carrera, cve_plan, cve_subsistema, egresado)
select distinct hc.cuenta, cve_carrera= hc.cve_carrera_ant, cve_plan = hc.cve_plan_ant, cve_subsistema = hc.cve_subsistema_ant, egresado= hc.egresado_ant
from hist_carreras hc, carreras c
where hc.cve_carrera_ant  in (select cve_carrera from carreras_tsu)
and	hc.cve_carrera_ant = c.cve_carrera
and	c.nivel in ( "L" ,"T")
and   hc.cuenta = :al_cuenta
union 
select distinct a.cuenta, a.cve_carrera, a.cve_plan, a.cve_subsistema, a.egresado
from academicos a, carreras c 
where a.cve_carrera in (select cve_carrera from carreras_tsu)
and	a.cve_carrera = c.cve_carrera
and	c.nivel in ( "L" ,"T")
and   a.cuenta = :al_cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
ll_rows_insertados = gtr_sce.SQLNrows
IF li_sql_code =-1 THEN	
	Goto Error
ELSE
	COMMIT USING gtr_sce;
//	MessageBox("Actualización Exitosa", "La información de los documentos ha sido guardada",Information!)
	IF ll_rows_insertados = 0 THEN
		return 100
	ELSE
		return 0
	END IF
END IF

Error:
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Actualizar", ls_mensaje,StopSign!)
	return -1
	
RETURN 0
end function

public function integer of_actualiza_datos_tramites_i ();//of_actualiza_datos_tramites_i
//Actualiza la información requerida en el tramite de titulacion
integer li_sql_code=0
string ls_mensaje
long ll_cuenta
SetPointer(HourGlass!)
//Limpia los tramite de titulación indicANDo que les falta todo

UPDATE dbo.tramite_titulacion
SET prerreq_ingles = 0,
	 certificado = 0,
	 titulado = 0,
	 egresado = 0,
	 tiene_mats_reval = 0,
	 docs_nacim = 0,
	 docs_rev_est = 0,
	 docs_ss = 0,
	 docs_pliego_reval = 0,
	 docs_estudios = 0,
	 baja_laboratorio = 0,
	 baja_biblioteca = 0,
	 adeuda_finanzas = 1,
	 baja_disciplina = 0
FROM dbo.tramite_titulacion, dbo.banderas_inscrito
WHERE dbo.tramite_titulacion.cuenta = dbo.banderas_inscrito.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error



//Actualiza el tramite de titulación indicANDo a los que tienen aprobado el
//prerrequisito de ingles
UPDATE dbo.tramite_titulacion
SET prerreq_ingles = 1
FROM dbo.historico h, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE h.cve_mat in (4078)
AND h.calificacion = "AC"
AND h.cuenta = tt.cuenta
AND h.cve_carrera = tt.cve_carrera
AND h.cve_plan = tt.cve_plan
AND h.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Actualiza el tramite de titulación indicANDo a los que tienen aprobado el examen

UPDATE dbo.tramite_titulacion
SET titulado = 1
FROM dbo.titulacion t, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE t.cuenta = tt.cuenta
AND t.cve_carrera = tt.cve_carrera
AND t.cve_plan = tt.cve_plan
AND t.aprobado = 1
AND t.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Actualiza el tramite de titulación indicANDo a los que han solicitado certificado total

UPDATE dbo.tramite_titulacion
SET certificado = 1
FROM dbo.certificado c, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE c.cuenta = tt.cuenta
AND c.cve_carrera = tt.cve_carrera
AND c.cve_plan = tt.cve_plan
AND c.parcial = 0
AND c.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Actualiza el tramite de titulación indicANDo a los alumnos egresados

UPDATE dbo.tramite_titulacion
SET egresado = 1
FROM dbo.academicos a, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE a.cuenta = tt.cuenta
AND a.cve_carrera = tt.cve_carrera
AND a.cve_plan = tt.cve_plan
AND a.egresado = 1
AND a.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

UPDATE dbo.tramite_titulacion
SET egresado = 1
FROM dbo.hist_carreras h, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE h.cuenta = tt.cuenta
AND h.cve_carrera_ant = tt.cve_carrera
AND h.cve_plan_ant = tt.cve_plan
AND h.egresado_ant = 1
AND h.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Tiene materias revalidadas
UPDATE dbo.tramite_titulacion
SET tiene_mats_reval = 1
FROM dbo.historico h, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE h.observacion = 5
AND h.cuenta = tt.cuenta
AND h.cve_carrera = tt.cve_carrera
AND h.cve_plan = tt.cve_plan
AND h.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Documentos de Nacimiento
UPDATE dbo.tramite_titulacion
SET docs_nacim = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (1,14)
AND d.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Quita aquellos que están en anomalía
UPDATE dbo.tramite_titulacion
SET docs_nacim = 0
FROM dbo.documentos d, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (0,6)
AND d.en_archivo = 0
AND d.cve_documento in (14)
AND tt.docs_nacim = 1
AND d.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Revision de Estudios
UPDATE dbo.tramite_titulacion
SET docs_rev_est = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (9,55)
AND d.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Servicio Social
UPDATE dbo.tramite_titulacion
SET docs_ss = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (6)
AND d.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Documentos de Pliego de Revalidacion para alumnos con materias revalidadas
UPDATE dbo.tramite_titulacion
SET docs_pliego_reval = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (33)
AND tt.tiene_mats_reval = 1
AND d.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de biblioteca
UPDATE dbo.tramite_titulacion
SET baja_biblioteca = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE b.cuenta = tt.cuenta
AND b.cve_flag_biblioteca in (3)
AND b.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de adeudo de laboratorio
UPDATE dbo.tramite_titulacion
SET baja_laboratorio = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE b.cuenta = tt.cuenta
AND b.baja_laboratorio in (1)
AND b.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error

//Bloqueo de baja por disciplina
UPDATE dbo.tramite_titulacion
SET baja_disciplina = 1
FROM dbo.banderas b, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE b.cuenta = tt.cuenta
AND b.baja_disciplina in (1)
AND b.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Bloqueo de finanzas**Todos deben hasta que se realice la revisión en línea
UPDATE dbo.tramite_titulacion
SET adeuda_finanzas = 1
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	Goto Error


//Documentos de Estudios de Bachillerato
UPDATE dbo.tramite_titulacion
SET docs_estudios = 1
FROM dbo.documentos d, dbo.tramite_titulacion tt, dbo.banderas_inscrito bi
WHERE d.cuenta = tt.cuenta
AND d.cve_flag_documento in (1,2,10,12)
AND d.en_archivo = 0
AND d.cve_documento in (3)
AND d.cuenta = bi.cuenta
USING gtr_sce;
li_sql_code= gtr_sce.SQLCode
ls_mensaje= gtr_sce.SQLErrText
IF li_sql_code =-1 THEN	
	Goto Error
ELSE
	COMMIT USING gtr_sce;
	MessageBox("Actualización Exitosa", "La información de los documentos ha sido guardada",Information!)
   SetPointer(Arrow!)
	return 0
END IF

Error:
	ROLLBACK USING gtr_sce;
	MessageBox("Error al Actualizar", ls_mensaje,StopSign!)
   SetPointer(Arrow!)
	return -1
	
RETURN 0
end function

on uo_atencion_tsu.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_atencion_tsu.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

