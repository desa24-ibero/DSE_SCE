$PBExportHeader$w_solicitud_materias_ant.srw
forward
global type w_solicitud_materias_ant from window
end type
type cbx_datos_generales from checkbox within w_solicitud_materias_ant
end type
type uo_1 from uo_per_ani within w_solicitud_materias_ant
end type
type gb_5 from groupbox within w_solicitud_materias_ant
end type
type cb_actualiza_avisos from commandbutton within w_solicitud_materias_ant
end type
type tab_1 from tab within w_solicitud_materias_ant
end type
type tabpage_1 from userobject within tab_1
end type
type lb_cuentas from listbox within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type st_status from statictext within tabpage_1
end type
type dw_sol_mat from datawindow within tabpage_1
end type
type cb_genera_solicitud from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
lb_cuentas lb_cuentas
st_5 st_5
st_4 st_4
st_status st_status
dw_sol_mat dw_sol_mat
cb_genera_solicitud cb_genera_solicitud
end type
type tabpage_2 from userobject within tab_1
end type
type st_ala from statictext within tabpage_2
end type
type st_delacarrera from statictext within tabpage_2
end type
type em_nombrefin from editmask within tabpage_2
end type
type em_nombreini from editmask within tabpage_2
end type
type em_carrerafin from editmask within tabpage_2
end type
type em_carreraini from editmask within tabpage_2
end type
type st_7 from statictext within tabpage_2
end type
type st_6 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type st_status1 from statictext within tabpage_2
end type
type cb_genera_solicitud1 from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_ala st_ala
st_delacarrera st_delacarrera
em_nombrefin em_nombrefin
em_nombreini em_nombreini
em_carrerafin em_carrerafin
em_carreraini em_carreraini
st_7 st_7
st_6 st_6
st_3 st_3
st_2 st_2
st_status1 st_status1
cb_genera_solicitud1 cb_genera_solicitud1
end type
type tab_1 from tab within w_solicitud_materias_ant
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type rb_avisopos from radiobutton within w_solicitud_materias_ant
end type
type rb_avisolic from radiobutton within w_solicitud_materias_ant
end type
type dw_avisos from datawindow within w_solicitud_materias_ant
end type
type uo_alumno from uo_nombre_alu_foto within w_solicitud_materias_ant
end type
end forward

global type w_solicitud_materias_ant from window
integer x = 832
integer y = 364
integer width = 3753
integer height = 2316
boolean titlebar = true
string title = "Solicitud de Materias"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 27291696
event inicia_proceso ( )
cbx_datos_generales cbx_datos_generales
uo_1 uo_1
gb_5 gb_5
cb_actualiza_avisos cb_actualiza_avisos
tab_1 tab_1
rb_avisopos rb_avisopos
rb_avisolic rb_avisolic
dw_avisos dw_avisos
uo_alumno uo_alumno
end type
global w_solicitud_materias_ant w_solicitud_materias_ant

type variables
String Fecha
DateTime FechaHoy
char ic_crlf[2]

long il_folio

Integer NumArchivo, ContHoja=1, ContLinea,ContAvisos=0
DataStore dw_encabezado,dw_adeuda_cobranzas
DataStore dw_historico,dw_plan_estud,dw_materiasxcursar
DataStore dw_materias_abiertas
DataStore ids_comprobante, ids_mensaje, ids_datos_generales

Datawindowchild Encabezado
Datawindowchild AvisosControlEscolar, AdeudaCobranzas
DataWindowChild historico
DataWindowChild SugiereMatInteg
DataWindowChild SugiereMatReinsc
DataWindowChild avisos
DataWindowChild Diagnostico
Datawindowchild DatosGenerales

Integer	carrera,Plan,Subsistema,ServSoc,Ingles
Integer	Puede_Integ,TemaF1,TemaF2,Tema1,Tema2,Tema3,Tema4
String	Nivel
long	Cuenta
Real	Promedio

integer genera_individual
end variables

forward prototypes
public subroutine escribe_encabezado ()
public subroutine escribe_encabezado1 ()
public subroutine despliega_materias (integer area, integer k)
public subroutine escribe_adeudos_cobranzas ()
public subroutine escribe_avisoscontrolescolar ()
public subroutine escribe_sugiere_integ ()
public subroutine escribe_avisos (string aviso)
public function string ajustapalabra (string as_palabra, integer ai_tamanio)
public subroutine escribe_comprobante (string as_mensaje, integer ai_lineas)
public subroutine escribe_encabezado_comp (integer ai_hoja)
public subroutine escribe_datos_generales ()
public subroutine escribe_encabezado_datos (integer ai_linea)
end prototypes

event inicia_proceso;// Juan Campos Sánchez.		Marzo-1998.

Long Cuenta_hi

cuenta=Message.LongParm

Select cuenta Into :Cuenta_hi From horario_insc Where cuenta = :Cuenta USING gtr_sce;
If gtr_sce.sqlcode = 0 Then
	tab_1.tabpage_1.lb_cuentas.AddItem(string(cuenta))
ElseIf gtr_sce.sqlcode = 100 Then
	Messagebox("Aviso","El alumno no tiene asignado un horario de inscripción.~nAsigne un horario para generar la solicitud")
Else
	MessageBox(gtr_sce.sqlerrtext,"")
End IF
end event

public subroutine escribe_encabezado ();// Juan Campos Sánchez.		Abril 1998.
// Escribe en el archivo de texto los datos del encabezado.

Integer	SubsInt
String	NomPlan,SubsStr

if genera_individual=0 then
	//FileWrite(NumArchivo,"~f")
	ContHoja = ContHoja +1
	//FileWrite(NumArchivo,Fill(" ", 60)+"HOJA: "+String(ContHoja,"00")+&
	//Fill(" ", 6)+string(il_folio,"000000"))
	FileWrite(NumArchivo,"~f"+Fill(" ", 60)+"HOJA: "+String(ContHoja,"00")+&
	Fill(" ", 6)+string(il_folio,"000000"))
	
	
	FileWrite(NumArchivo,ic_crlf+ic_crlf+ic_crlf+ic_crlf+ic_crlf)
	FileWrite(NumArchivo,Fill(" ", 30)+"SOLICITUD DE MATERIAS")
	FileWrite(NumArchivo,Fill(" ", 6)+'CUENTA: '+String(dw_encabezado.GetItemNumber(1,"horario_insc_cuenta")) + '-' + dw_encabezado.GetItemString(1,"digito")) 
	FileWrite(NumArchivo,Fill(" ", 6)+'NOMBRE: '+dw_encabezado.GetItemString(1,"alumnos_apaterno") + ' ' + &
		dw_encabezado.GetItemString(1,"alumnos_amaterno") 					+ ' ' + &
		dw_encabezado.GetItemString(1,"alumnos_nombre"))
		Plan = dw_encabezado.GetItemNumber(1,"academicos_cve_plan")
	if Plan = 1 Then
		NomPlan = "ANTIGUO" 
	ElseIF Plan = 2 Then
		NomPlan = "NUEVO" 
	ElseIF Plan = 3 Then
		NomPlan = "SANTE FE" 
	ElseIF Plan = 4 Then
		NomPlan = "SANTAFE II" 
	ElseIF Plan = 5 Then
		NomPlan = "SANTAFE III" 
	Else
		NomPlan = "" 
	End If	
	FileWrite(NumArchivo,Fill(" ", 5)+'CARRERA: '+ &							
		AjustaPalabra(String(dw_encabezado.GetItemNumber(1,"academicos_cve_carrera")),4)	+ '-' + &
		AjustaPalabra(dw_encabezado.GetItemString(1,"carreras_carrera"),42)+ &
		' PLAN: '+NomPlan) 

	SubsInt = dw_encabezado.GetItemNumber(1,"academicos_cve_subsistema")
	SubsStr = dw_encabezado.GetItemString(1,"subsistema_subsistema")
	if SubsInt = 0 or Isnull(SubsStr) Then
		FileWrite(NumArchivo, '  SUBSISTEMA: NO REGISTRADO')
	Else
		FileWrite(NumArchivo,'  SUBSISTEMA: '+ &
			String(dw_encabezado.GetItemNumber(1,"academicos_cve_subsistema"))+ ' ' + &
			dw_encabezado.GetItemString(1,"subsistema_subsistema"))					
	End if	
	FileWrite(NumArchivo,'  FECHA HORA: '+&
		dw_encabezado.GetItemString(1,"fecha")+Fill(" ", 3)+'LUGAR FILA: ' + &
	   String(dw_encabezado.GetItemNumber(1,"horario_insc_lugar_fila")))
	FileWrite(NumArchivo,"--------------------------------------------------------------------------------")
	FileWrite(NumArchivo,"")
	Contlinea = 10

	tab_1.tabpage_2.st_status1.text=dw_encabezado.GetItemString(1,"alumnos_apaterno") + ' ' + &
		dw_encabezado.GetItemString(1,"alumnos_amaterno") 					+ ' ' + &
		dw_encabezado.GetItemString(1,"alumnos_nombre")
	tab_1.tabpage_2.st_3.text = String(Cuenta)
end if
end subroutine

public subroutine escribe_encabezado1 ();// Encabezado para las MATERIAS A LAS QUE PUEDES INSCRIBIRTE ESTE PERIODO.
// Juan Campos Mayo-1998.

FileWrite(NumArchivo,Fill(' ',12)+"** MATERIAS A LAS QUE PUEDES INSCRIBIRTE ESTE PERIODO **")
FileWrite(NumArchivo,"")
FileWrite(NumArchivo,"  CLAVE GRUPO  SIGLA"+FILL(' ',6)+"NOMBRE"+FILL(' ',27)+&
                     "CREDITOS. SEM.IDEAL")
FileWrite(NumArchivo,Fill('-',78))							
ContLinea=ContLinea+4

end subroutine

public subroutine despliega_materias (integer area, integer k);integer ll_cont_1,cont_materias
string ls_textin
string ls_sigla

if isnull(area) then
	area=0
end if
if nivel = "P" then
	DataStore lds_sigla_por_carrera
	lds_sigla_por_carrera = Create DataStore
	lds_sigla_por_carrera.DataObject = "d_sigla_por_carrera"
	lds_sigla_por_carrera.SetTransObject(gtr_sce)
	if (lds_sigla_por_carrera.Retrieve(carrera) = 1) then
		ls_sigla = lds_sigla_por_carrera.GetItemString(1,"coordinaciones_sigla")
	else
		ls_sigla = ""
	end if
	DESTROY lds_sigla_por_carrera
end if
	
dw_materiasxcursar.SetFilter("area_mat_cve_area="+string(area))
dw_materiasxcursar.Filter( )
dw_materiasxcursar.Sort( )
FOR ll_cont_1=1 TO dw_materiasxcursar.rowcount()
	if genera_individual=0 then
		If ContLinea >= 57 Then Escribe_Encabezado()
		ls_textin=left(dw_materiasxcursar.object.materia[ll_cont_1],46)
		ls_textin=ls_textin+fill(" ",46 - len(ls_textin))
		if nivel = "L" OR k <> 3 OR Mid(dw_materiasxcursar.object.sigla[ll_cont_1],1,3) = ls_sigla then
			FileWrite(NumArchivo,+"  "+string(dw_materiasxcursar.object.cve_mat[ll_cont_1])+'  (   )  '+&
				string(dw_materiasxcursar.object.sigla[ll_cont_1])+'  '+ls_textin+'  '+&
				string(dw_materiasxcursar.object.creditos[ll_cont_1],"###0.00")+'  '+&
				string(dw_materiasxcursar.object.semestre_ideal[ll_cont_1]))
			ContLinea = ContLinea + 1
		end if
	else		
		cont_materias=SugiereMatReinsc.insertrow(0)
  		SugiereMatReinsc.SetItem(cont_materias,2,dw_materiasxcursar.object.cve_mat[ll_cont_1])
  		SugiereMatReinsc.SetItem(cont_materias,3,"(       )")
   		SugiereMatReinsc.SetItem(cont_materias,4,dw_materiasxcursar.object.sigla[ll_cont_1])
  		SugiereMatReinsc.SetItem(cont_materias,5,dw_materiasxcursar.object.materia[ll_cont_1])
   		SugiereMatReinsc.SetItem(cont_materias,6,dw_materiasxcursar.object.creditos[ll_cont_1])
  		SugiereMatReinsc.SetItem(cont_materias,7,k) // K 1=AreaBasica,2=AreaMayorObl,3=AreaMayorOpt
		SugiereMatReinsc.SetItem(cont_materias,8,dw_materiasxcursar.object.semestre_ideal[ll_cont_1])
	end if
NEXT
end subroutine

public subroutine escribe_adeudos_cobranzas ();// Juan Campos Sánchez.  Abril-1998.
// Trae los adeudos vencidos de un alumno (db_cobranzas tabla saldos),
// y los escribe en el archivo de texto.
// Se validan las cadenas para que se escriban justificadas en el archivo.

Integer	i,j
String	DesConcepto,Importe,Total

IF dw_adeuda_cobranzas.Retrieve(Cuenta,FechaHoy) > 0 Then
	If ContLinea >= 49 Then Escribe_Encabezado()
	FileWrite(NumArchivo,Fill(" ",29)+"** ADEUDOS VENCIDOS **")
	FileWrite(NumArchivo,"")	
	FileWrite(NumArchivo,"  TE PEDIMOS QUE PASES A LIQUIDAR LOS MONTOS CORRESPONDIENTES A LA MAYOR BREVEDAD")
	FileWrite(NumArchivo,"  RECUERDA QUE LOS ADEUDOS VENCIDOS NO PAGADOS, BLOQUEAN TU INSCRIPCION,")
	FileWrite(NumArchivo,"  SI ALGUNO DE LOS CONCEPTOS AQUI DESCRITOS YA LOS CUBRISTE, PASA AL DEPARTAMENTO")
   FileWrite(NumArchivo,"  A VERIFICAR TU PAGO.")
	FileWrite(NumArchivo,"")	
	FileWrite(NumArchivo,"  PERIODO"+Fill(" ",2)+"CONCEPTO"+Fill(" ",30)+"IMPORTE")
	ContLinea = ContLinea + 8
	For i = 1 To dw_adeuda_cobranzas.RowCount() 
		DesConcepto= dw_adeuda_cobranzas.GetItemString(i,"conceptos_descripcion")
		if len(DesConcepto) < 31 then
			j= 31 - len(DesConcepto)
			DesConcepto = DesConcepto + Fill(" ",j)
		End if	
		Importe = String(Round(dw_adeuda_cobranzas.GetItemDecimal(i,"saldos_importe"),2))
		If len(Importe) < 11 Then
			j = 10 - len(Importe)
			Importe = Fill(" ",j) +Importe
		End if	
		If ContLinea >= 57 Then Escribe_Encabezado()
		FileWrite(NumArchivo,Fill(" ",4)+dw_adeuda_cobranzas.GetItemString(i,"saldos_periodo") + &
									String(dw_adeuda_cobranzas.GetItemNumber(i,"saldos_anio"))+Fill(" ",4)+ &
									DesConcepto +Fill(" ",4) + Importe)
		ContLinea = ContLinea + 1							
	Next
	Total = String(Round(dw_adeuda_cobranzas.GetItemDecimal(dw_adeuda_cobranzas.getrow(),"total_saldos"),2))
	J = 54 -( len(Total)+8) 	
	If ContLinea >= 57 Then Escribe_Encabezado()
	Total = Fill(" ",j) + "  TOTAL: $" + Total
	FileWrite(NumArchivo,Fill(" ",45)+"  ---------") 
	FileWrite(NumArchivo,Total) 
	FileWrite(NumArchivo,"")
	ContLinea = ContLinea + 3
End IF
end subroutine

public subroutine escribe_avisoscontrolescolar ();// Escribe los avisos de las banderas del alumno
// Juan campos Sánchez.   Mar-1998.

Integer	insc_sem_ant,cve_flag_promedio,baja_3_reprob,baja_4_insc, &
			baja_documentos,cve_flag_prerreq_ingles,cve_flag_serv_social, &
  			cve_flag_biblioteca,cve_flag_diapositeca,Ind, li_preinscrito
	 
Select	insc_sem_ant,				cve_flag_promedio,		baja_3_reprob,
			baja_4_insc,				baja_documentos,			cve_flag_prerreq_ingles,
			cve_flag_serv_social,	puede_integracion,		tema_fundamental_1,
			tema_fundamental_2,		tema_1,						tema_2,
			tema_3,						tema_4,						cve_flag_biblioteca,
			cve_flag_diapositeca
			
Into		:insc_sem_ant,				:cve_flag_promedio,		:baja_3_reprob,
			:baja_4_insc,         	:baja_documentos,			:cve_flag_prerreq_ingles,
			:cve_flag_serv_social,	:Puede_Integ,				:TemaF1,
			:TemaF2,						:Tema1,						:Tema2,
			:Tema3,						:Tema4,						:cve_flag_biblioteca,
			:cve_flag_diapositeca
From banderas
Where cuenta = :Cuenta
using gtr_sce;
								
If gtr_sce.sqlcode = 0 Then
	
	SELECT status INTO :li_preinscrito FROM preinsc
	WHERE anio = :gi_anio AND periodo = :gi_periodo AND cuenta = :cuenta USING gtr_sce;
	if gtr_sce.sqlcode = 0 then
		li_preinscrito = 1 
	else
		li_preinscrito = 0
	end if
	
	If insc_sem_ant = 0 or 					cve_flag_promedio = 1 or 			&
   	cve_flag_promedio = 2 or			cve_flag_promedio = 3 or 			& 
		baja_3_reprob = 1 or 				baja_4_insc = 1 or 					&
		baja_documentos = 1 or				cve_flag_prerreq_ingles = 1 or	&
		cve_flag_prerreq_ingles = 2 or	cve_flag_serv_social = 1 or		&
		cve_flag_biblioteca = 1 or 		cve_flag_biblioteca = 2 or			&
		cve_flag_biblioteca = 3 or			cve_flag_diapositeca = 1 or		&
		cve_flag_diapositeca = 2 or cve_flag_diapositeca = 3 or				&
		li_preinscrito = 0 Then
		If ContLinea >= 56 Then Escribe_Encabezado()
		FileWrite(NumArchivo,Fill(" ",26)+"** AVISOS CONTROL ESCOLAR **")	
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
	End if
	
	If li_preinscrito = 0 Then 
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  ALUMNO NO PREINSCRITO ")
		FileWrite(NumArchivo,"  TU HORARIO FUE ASIGNADO DESPUES DE TODOS LOS ALUMNOS PREINSCRITOS")
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 3
 	End IF
	
	If insc_sem_ant = 0 Then 
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  NO ESTUVISTE INSCRITO EL SEMESTRE ANTERIOR.")
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
 	End IF
	If Nivel = 'L' Then
		If cve_flag_promedio = 1 Then
			If ContLinea >= 54 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ESTAS AMONESTADO , SEGUN EL REGLAMENTO DE PUNTAJE DE CALIDAD ARTICULO 7.3.2.2")
			FileWrite(NumArchivo,"  UNA SEGUNDA AMONESTACION CONSECUTIVA CAUSA BAJA.")	    
			FileWrite(NumArchivo,"")
			ContLinea = ContLinea + 3
		End If			 
		If cve_flag_promedio = 2 Then
			If ContLinea >= 54 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ESTAS DADO DE BAJA, POR ACUMULAR 2 AMONESTACIONES CONSECUTIVAS, CONSULTA EL ")
			FileWrite(NumArchivo,"  REGLAMENTO DE PUNTAJE DE CALIDAD.")		
			FileWrite(NumArchivo,"") 
			ContLinea = ContLinea + 3
		End If			 
		If cve_flag_promedio = 3 Then		 
			If ContLinea >= 54 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ESTAS EXENTO POR CONCEPTO DE PROMEDIO.")		 
			FileWrite(NumArchivo,"")
			ContLinea = ContLinea + 2
		End If	
	End if
   IF baja_3_reprob = 1 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  ESTAS DADO DE BAJA POR REPROBAR 3 VECES LA MISMA MATERIA. REGLAMENTO DE ")
		FileWrite(NumArchivo,"  EVALUACIONES , ARTICULO 3.5.")
		FileWrite(NumArchivo,"") 	
		ContLinea = ContLinea + 3
	End IF
	IF baja_4_insc = 1 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  ESTAS DADO DE BAJA, POR TENER 4 INSCRIPCIONES A UNA MISMA MATERIA, SEGUN EL")
		FileWrite(NumArchivo,"  ARTICULO 3.5 (B) DEL REGLAMENTO.")     		
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 3
	End IF
	IF baja_documentos = 1 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  BLOQUEADO POR ADEUDO DE DOCUMENTOS")
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
 	End If
	 
	If Nivel = 'L' Then
		IF cve_flag_prerreq_ingles = 1 Then
			If ContLinea >= 54 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ADEUDA PRERREQUISITO DE INGLES")
			FileWrite(NumArchivo,"")
			ContLinea = ContLinea + 2
 		End If
		IF cve_flag_prerreq_ingles = 2 Then	  
			If ContLinea >= 54 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  SI TERMINAS DOS SEMESTRES EN LA UNIVERSIDAD SIN HABER ACREDITADO EL ")
			FileWrite(NumArchivo,"  PRERREQUISITO DE INGLES, EN TU TERCER SEMESTRE NO PODRAS CURSAR MAS ")
			FileWrite(NumArchivo,"  DE 30 CREDITOS.")
			FileWrite(NumArchivo,"")
			ContLinea = ContLinea + 4
 		End if
		IF cve_flag_serv_social = 1 Then
			If ContLinea >= 54 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  YA PUEDES CURSAR TU SERVICIO SOCIAL. TE RECUERDO QUE LOS 16 CREDITOS ")
			FileWrite(NumArchivo,"  DE SERVICIO SOCIAL TAMBIEN SE TOMAN EN CUENTA PARA EL MAXIMO  DE CREDITOS")
			FileWrite(NumArchivo,"  QUE PUEDES INSCRIBIR EN UN SEMESTRE.")
			FileWrite(NumArchivo,"")
			ContLinea = ContLinea + 4
 		End if
	End If
	IF cve_flag_biblioteca = 1 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  AMONESTADO POR ADEUDO EN BIBLIOTECA")
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
 	End IF
	IF cve_flag_biblioteca = 2 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  SUSPENDIDO POR ADEUDO EN BIBLIOTECA")
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
	END IF
 	IF cve_flag_biblioteca = 3 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  DADO DE BAJA POR ADEUDO EN BIBLIOTECA")		
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
 	End if	
	If cve_flag_diapositeca = 1 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  AMONESTADO POR ADEUDO EN DIAPOSITECA")		
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
 	End if
	If cve_flag_diapositeca = 2 Then
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  SUSPENDIDO POR ADEUDO EN DIAPOSITECA")
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
 	End if
	If cve_flag_diapositeca = 3 Then	
		If ContLinea >= 54 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  DADO DE BAJA POR ADEUDO EN DIAPOSITECA")
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 2
 	End IF
End If	
FileWrite(NumArchivo,"")
ContLinea = ContLinea + 1 
end subroutine

public subroutine escribe_sugiere_integ ();// Escribe en el archivo de texto las materias que puede inscribir de integración
// Juan Campos Sánchez.		Abril-1998.

Integer i=0,j=0,Indice
Boolean Agrupa[]
String  Descrip[]
Integer OrdenTema,Justifica=0

Agrupa[1]=False; Agrupa[2]=False; Agrupa[3]=False
Agrupa[4]=False; Agrupa[5]=False; Agrupa[6]=False
Descrip[1]="  INTEGRACION TEMA FUNDAMENTAL"
Descrip[2]="  INTEGRACION TEMA I"	
Descrip[3]="  INTEGRACION TEMA II"
Descrip[4]="  INTEGRACION TEMA III"	
Descrip[5]="  INTEGRACION TEMA IV"
Descrip[6]="  MATERIAS ADICIONALES"

FileWrite(NumArchivo,"")
ContLinea = ContLinea + 1

IF Puede_Integ = 1 Then  // 1=True
	If TemaF1 = 0 Then 
		OrdenTema= 1
		If Agrupa[OrdenTema] = False  Then
			If ContLinea >= 55 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"")
			FileWrite(NumArchivo,Fill(' ',13)+Descrip[OrdenTema])
			FileWrite(NumArchivo,"")
			ContLinea = ContLinea + 3
			Agrupa[OrdenTema] = True
		End if	
		If ContLinea >= 57 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  8580" +Fill(' ',2)+ &
							"(   )"+Fill(' ',2)+"FL111"+Fill(' ',2) + &
							"INTRODUCCION AL PROBLEMA DEL HOMBRE")
		ContLinea=ContLinea+1							
		if "8580" = "____" Then
			FileWrite(NumArchivo,"")
			ContLinea=ContLinea+1							
		End if
	End IF
	
	If TemaF2 = 0 Then
		OrdenTema= 1
		If Agrupa[OrdenTema] = False  Then
			If ContLinea >= 57 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"")
			FileWrite(NumArchivo,Fill(' ',13)+Descrip[OrdenTema])
			FileWrite(NumArchivo,"")
			ContLinea = ContLinea + 3
			Agrupa[OrdenTema] = True
		End if	
		If ContLinea >= 57 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"  8581" +Fill(' ',2)+ &
							"(   )"+Fill(' ',2)+"FL112"+Fill(' ',2) + &
							"INTRODUCCION AL PROBLEMA SOCIAL")
		ContLinea=ContLinea+1							
		if "8581" = "____" Then
			FileWrite(NumArchivo,"")
			ContLinea=ContLinea+1							
		End if
	End IF
	
	If TemaF1=1 And TemaF2 = 1 Then
		If Tema1 = 0 Then
			OrdenTema= 2
			If Agrupa[OrdenTema] = False  Then
				If ContLinea >= 57 Then Escribe_Encabezado()
				FileWrite(NumArchivo,"")
				FileWrite(NumArchivo,Fill(' ',13)+Descrip[OrdenTema])
				FileWrite(NumArchivo,"")
				ContLinea = ContLinea + 3
				Agrupa[OrdenTema] = True
			End if	
			If ContLinea >= 57 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ----" +Fill(' ',2)+ &
								"(   )"+Fill(' ',2)+"-----"+Fill(' ',2) + &
								"----------------------------------------------")
			ContLinea=ContLinea+1
			FileWrite(NumArchivo,"")
			ContLinea=ContLinea+1
		End if
		
		If Tema2 = 0 Then
			OrdenTema= 3
			If Agrupa[OrdenTema] = False  Then
				If ContLinea >= 57 Then Escribe_Encabezado()
				FileWrite(NumArchivo,"")
				FileWrite(NumArchivo,Fill(' ',13)+Descrip[OrdenTema])
				FileWrite(NumArchivo,"")
				ContLinea = ContLinea + 3
				Agrupa[OrdenTema] = True
			End if	
			If ContLinea >= 57 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ----" +Fill(' ',2)+ &
								"(   )"+Fill(' ',2)+"-----"+Fill(' ',2) + &
								"----------------------------------------------")
			ContLinea=ContLinea+1
			FileWrite(NumArchivo,"")
			ContLinea=ContLinea+1
		End if
		
		If Tema3 = 0 Then
			OrdenTema= 4
			If Agrupa[OrdenTema] = False  Then
				If ContLinea >= 57 Then Escribe_Encabezado()
				FileWrite(NumArchivo,"")
				FileWrite(NumArchivo,Fill(' ',13)+Descrip[OrdenTema])
				FileWrite(NumArchivo,"")
				ContLinea = ContLinea + 3
				Agrupa[OrdenTema] = True
			End if	
			If ContLinea >= 57 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ----" +Fill(' ',2)+ &
								"(   )"+Fill(' ',2)+"-----"+Fill(' ',2) + &
								"----------------------------------------------")
			ContLinea=ContLinea+1
			FileWrite(NumArchivo,"")
			ContLinea=ContLinea+1
		End if
		
		If Tema4 = 0 Then
			OrdenTema= 5
			If Agrupa[OrdenTema] = False  Then
				If ContLinea >= 57 Then Escribe_Encabezado()
				FileWrite(NumArchivo,"")
				FileWrite(NumArchivo,Fill(' ',13)+Descrip[OrdenTema])
				FileWrite(NumArchivo,"")
				ContLinea = ContLinea + 3
				Agrupa[OrdenTema] = True
			End if	
			If ContLinea >= 57 Then Escribe_Encabezado()
			FileWrite(NumArchivo,"  ----" +Fill(' ',2)+ &
								"(   )"+Fill(' ',2)+"-----"+Fill(' ',2) + &
								"----------------------------------------------")
			ContLinea=ContLinea+1
			FileWrite(NumArchivo,"")
			ContLinea=ContLinea+1
		End if    		
	End If 
End if

For j = i To i+5
	OrdenTema= 6
	If Agrupa[OrdenTema] = False  Then
		If ContLinea >= 57 Then Escribe_Encabezado()
		FileWrite(NumArchivo,"")
		FileWrite(NumArchivo,Fill(' ',13)+Descrip[OrdenTema])
		FileWrite(NumArchivo,"")
		ContLinea = ContLinea + 3
		Agrupa[OrdenTema] = True
	End if	
	If ContLinea >= 57 Then Escribe_Encabezado()
	FileWrite(NumArchivo,"  ----" +Fill(' ',2)+ &
						"(   )"+Fill(' ',2)+"-----"+Fill(' ',2) + &
						"----------------------------------------------")
	ContLinea=ContLinea+1
	FileWrite(NumArchivo,"")
	ContLinea=ContLinea+1
Next
end subroutine

public subroutine escribe_avisos (string aviso);FileWrite(NumArchivo,Fill(' ',29)+"*** AVISOS Y NOTAS ***")
FileWrite(NumArchivo,aviso)
FileWrite(NumArchivo,"")
ContLinea=Contlinea + ContAvisos + 1
end subroutine

public function string ajustapalabra (string as_palabra, integer ai_tamanio);if isnull(as_palabra) then as_palabra = " "
as_palabra = righttrim(as_palabra)
if (len(as_palabra) > ai_tamanio) then
	as_palabra = mid(as_palabra,1,ai_tamanio)
else
	as_palabra = as_palabra + space(ai_tamanio - len(as_palabra))
end if
return as_palabra
end function

public subroutine escribe_comprobante (string as_mensaje, integer ai_lineas);int li_i, li_res, li_numlinea, li_hoja
long ll_cve_mat
string ls_linea
ic_crlf[1] = char(13)
ic_crlf[2] = char(10)
li_res = ids_comprobante.Retrieve(cuenta,gi_anio,gi_periodo)
if ( li_res >= 0 ) then
	if ( li_res > 0 ) then
		li_numlinea = 0
		ai_lineas = 46 - ai_lineas - 4
		ll_cve_mat = 0
		li_hoja = 1
		for li_i = 1 to li_res
			if li_numlinea > ai_lineas then
				li_hoja++
				li_numlinea = 0
				ll_cve_mat = 0
				ls_linea = "  ------------------------------------------------------CONTINUA . . . (1)"
				FileWrite(NumArchivo,ls_linea)
				FileWrite(NumArchivo,"")
				FileWrite(NumArchivo,as_mensaje)
			end if
			if li_numlinea = 0 then
				escribe_encabezado_comp(li_hoja)
			end if
			ls_linea = ""
			if ll_cve_mat <> ids_comprobante.GetItemNumber(li_i,"mat_inscritas_cve_mat") then
				ls_linea = "   ------------------------------------------------------------------------"
				FileWrite(NumArchivo,ls_linea)
				li_numlinea++
				ls_linea = "  "+AjustaPalabra(string(ids_comprobante.GetItemNumber(li_i,"mat_inscritas_cve_mat")),5)+" "+&
					AjustaPalabra(ids_comprobante.GetItemString(li_i,"mat_inscritas_gpo"),3)+" "+&
					AjustaPalabra(ids_comprobante.GetItemString(li_i,"materias_materia"),50)+" "+&
					AjustaPalabra(string(ids_comprobante.GetItemDecimal(li_i,"materias_creditos")),5)+" "+&
					AjustaPalabra(string(ids_comprobante.GetItemNumber(li_i,"materias_horas_totales")),5)+ic_crlf
					li_numlinea ++
			end if
			if isnull(ids_comprobante.GetItemNumber(li_i,"horario_hora_inicio")) then
				ls_linea +=	"            "+ids_comprobante.GetItemString(li_i,"tipo_grupo_nombre_tipo")
			else
				ls_linea +=	"            "+AjustaPalabra(ids_comprobante.GetItemString(li_i,"horario_cve_salon"),6)+" "+&
				AjustaPalabra(ids_comprobante.GetItemString(li_i,"dias_dia"),10)+" "+&
				AjustaPalabra(string(ids_comprobante.GetItemNumber(li_i,"horario_hora_inicio")),2)+" a las "+&
				AjustaPalabra(string(ids_comprobante.GetItemnumber(li_i,"horario_hora_final")),2)+" hrs."
			end if
			FileWrite(NumArchivo,ls_linea)
			li_numlinea++
			ll_cve_mat = ids_comprobante.GetItemNumber(li_i,"mat_inscritas_cve_mat")
		next
		ls_linea = "  ----------------------------------------------------------------------(1)"
		FileWrite(NumArchivo,ls_linea)
		FileWrite(NumArchivo,as_mensaje)
	end if
else
	MessageBox("Error","Error al consultar el comprobante de inscripcion")
end if

end subroutine

public subroutine escribe_encabezado_comp (integer ai_hoja);string ls_linea
//FileWrite(NumArchivo,"~f")
//ls_linea = 	" COMPROBANTE DE INSCRIPCION PARA EL PERIODO:          "
ls_linea = 	"~f COMPROBANTE DE INSCRIPCION PARA EL PERIODO:          "

choose case ids_comprobante.GetItemNumber(1,"mat_inscritas_periodo")
	case 0
		ls_linea += "PRIMAVERA "
	case 1
		ls_linea += "   VERANO "
	case 2
		ls_linea += "    OTONO "
end choose
ls_linea += string(ids_comprobante.GetItemNumber(1,"mat_inscritas_anio"))+&
		" "+string(il_folio,"000000")+ic_crlf+space(54)+&
		"FECHA:     "+string(Today( ), "dd/mm/yyyy")+ic_crlf+space(69)+"HOJA "+string(ai_hoja)+&
		ic_crlf+ic_crlf+ic_crlf+ic_crlf+&
		"  CUENTA: "+string(cuenta)+"-"+obten_digito(cuenta)+ic_crlf+"  NOMBRE: "+&
		ids_comprobante.GetItemString(1,"alumnos_nombre_completo")+ic_crlf+"  CARRERA: "+&
		ids_comprobante.GetItemString(1,"carreras_carrera")+" PLAN: "+&
		ids_comprobante.GetItemString(1,"nombre_plan_nombre_plan")+ic_crlf+&
		"                        RELACION DE MATERIAS INSCRITAS                    "+ic_crlf+ic_crlf+& 
		"  CLAVE GPO MATERIA                                            CRED  HORAS"+ic_crlf+&
		"            SALON  DIA        HORARIO"
FileWrite(NumArchivo,ls_linea)
end subroutine

public subroutine escribe_datos_generales ();string ls_linea, ls_cve_grado, ls_linea2
int li_res, li_renglon

ids_datos_generales.DataObject = "d_datos_generales"
ids_datos_generales.SetTransObject(gtr_sce)
li_res = ids_datos_generales.Retrieve(cuenta)
ls_linea2 = "     INCORRECTO ( )     CORRECTO ( )"+char(13)+char(10)+&
"     ----------------------------------------------------------------------"
if li_res <= 0 then
	ls_linea = "ERROR AL CONSULTAR LOS DATOS GENERALES DE "+string(cuenta)+"-"+obten_digito(cuenta)
	FileWrite(NumArchivo,ls_linea)
else
	li_renglon = ids_datos_generales.Find("estudio_ant_cve_grado = 'M'",1,li_res)
	if li_renglon = 0 then
		li_renglon = ids_datos_generales.Find("estudio_ant_cve_grado = 'L'",1,li_res)
		if li_renglon = 0 then
			li_renglon = ids_datos_generales.Find("estudio_ant_cve_grado = 'B'",1,li_res)
			if li_renglon = 0 then li_renglon = 1
		end if
	end if
	escribe_encabezado_datos(1)
	ls_linea = "     CUENTA:"+ajustapalabra(string(cuenta)+"-"+obten_digito(cuenta),30)+"DATOS CORRECTOS"
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,"")
	ls_linea = "     NOMBRE:            "+ids_datos_generales.GetItemString(li_renglon,"alumnos_nombre")
	if IsNull(ls_linea) then ls_linea = "     NOMBRE:            "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     APELLIDO PATERNO:  "+ids_datos_generales.GetItemString(li_renglon,"alumnos_apaterno")
	if IsNull(ls_linea) then ls_linea = "     APELLIDO PATERNO:  "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     APELLIDO MATERNO:  "+ids_datos_generales.GetItemString(li_renglon,"alumnos_amaterno")
	if IsNull(ls_linea) then ls_linea = "     APELLIDO MATERNO:  "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     RELIGION:          "+ids_datos_generales.GetItemString(li_renglon,"religion_religion")
	if IsNull(ls_linea) then ls_linea = "     RELIGION:          "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     ESTADO CIVIL:      "+ids_datos_generales.GetItemString(li_renglon,"edo_civil_edo_civil")
	if IsNull(ls_linea) then ls_linea = "     ESTADO CIVIL:      "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     TRABAJO:           "+ids_datos_generales.GetItemString(li_renglon,"trabajo_trabajo")
	if IsNull(ls_linea) then ls_linea = "     TRABAJO:           "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     HORARIO DE TRABAJO:                HORAS DE TRABAJO:"+string(ids_datos_generales.GetItemNumber(li_renglon,"alumnos_horas_trabajo"))
	if IsNull(ls_linea) then ls_linea = "     HORARIO DE TRABAJO:                HORAS DE TRABAJO:"
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     TRANSPORTE:        "+ids_datos_generales.GetItemString(li_renglon,"transporte_transporte")
	if IsNull(ls_linea) then ls_linea = "     TRANSPORTE:        "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     CALLE:             "+ids_datos_generales.GetItemString(li_renglon,"domicilio_calle")
	if IsNull(ls_linea) then ls_linea = "     CALLE:             "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     COLONIA:           "+ids_datos_generales.GetItemString(li_renglon,"domicilio_colonia")
	if IsNull(ls_linea) then ls_linea = "     COLONIA:           "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     ESTADO:            "+ids_datos_generales.GetItemString(li_renglon,"estados_estado")
	if IsNull(ls_linea) then ls_linea = "     ESTADO:            "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     CODIGO POSTAL:     "+ids_datos_generales.GetItemString(li_renglon,"domicilio_cod_postal")
	if IsNull(ls_linea) then ls_linea = "     CODIGO POSTAL:     "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     TELEFONO:          "+ids_datos_generales.GetItemString(li_renglon,"domicilio_telefono")
	if IsNull(ls_linea) then ls_linea =  "     TELEFONO:          "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     ESCUELA PROC.:     "+left(ids_datos_generales.GetItemString(li_renglon,"escuelas_escuela"),50)
	if IsNull(ls_linea) then ls_linea = "     ESCUELA PROC.:     "
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	ls_linea = "     CORREO ELECTRONICO:"+ids_datos_generales.GetItemString(li_renglon,"alumnos_fotografia")
	if IsNull(ls_linea) then ls_linea = "     CORREO ELECTRONICO:"
	FileWrite(NumArchivo,ls_linea)
	FileWrite(NumArchivo,ls_linea2)
	FileWrite(NumArchivo,"")
	FileWrite(NumArchivo,"")
	ls_linea = "                                                              -------------"
	FileWrite(NumArchivo,ls_linea)
	ls_linea = "                                                                  FIRMA    "
	FileWrite(NumArchivo,ls_linea)
	ls_linea = "     EN  CASO  DE  QUE ALGUN DATO ESTE INCORRECTO, FAVOR DE CORREGIRLO A LA"
	FileWrite(NumArchivo,ls_linea)
	ls_linea = "     DERECHA DEL MISMO."
	FileWrite(NumArchivo,ls_linea)
end if
	

end subroutine

public subroutine escribe_encabezado_datos (integer ai_linea);string ls_linea
//FileWrite(NumArchivo,"~f")
//ls_linea = 	"                 ACTUALIZACION DE DATOS GENERALES:                   "+string(il_folio,"000000")
ls_linea = 	"~f                 ACTUALIZACION DE DATOS GENERALES:                   "+string(il_folio,"000000")

FileWrite(NumArchivo,ls_linea)
FileWrite(NumArchivo, "")
FileWrite(NumArchivo, "")
FileWrite(NumArchivo, "")
FileWrite(NumArchivo, "")
FileWrite(NumArchivo, "")
FileWrite(NumArchivo, "")
FileWrite(NumArchivo, "")
end subroutine

event open;// PROCESO DE SOLICITUD DE MATERIAS.
// Juan Campos Sánchez.		Febrero.1998.
// Víctor Manuel Iniestra Álvarez.		Octubre.1998.

x = 1
y = 1

if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
if gi_numscob <= 0 then
	if conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
		return
	end if
end if
gi_numscob++


dw_historico = CREATE DataStore
dw_historico.DataObject = "dw_historico"
dw_historico.Settransobject(gtr_sce)

dw_plan_estud = CREATE DataStore
dw_plan_estud.DataObject = "dw_plan_estud"
dw_plan_estud.Settransobject(gtr_sce)

dw_materiasxcursar = CREATE DataStore
dw_materiasxcursar.DataObject = "dw_materiasxcursar"
dw_materiasxcursar.Settransobject(gtr_sce)

dw_materias_abiertas = CREATE DataStore
dw_materias_abiertas.DataObject = "dw_materias_abiertas"
dw_materias_abiertas.Settransobject(gtr_sce)

ids_comprobante = Create DataStore
ids_comprobante.DataObject = "d_comprobante"
ids_comprobante.SetTransObject(gtr_sce)

ids_datos_generales = Create DataStore
ids_datos_generales.DataObject = "d_datos_generales"
ids_datos_generales.SetTransObject(gtr_sce)

Periodo_Actual(gi_periodo,gi_anio,gtr_sce)
gi_periodo=gi_periodo+1
if gi_periodo=3 then
	gi_periodo=0
	gi_anio=gi_anio+1
end if

DECLARE Fecha_Servidor procedure for fechainsc
	@fecha = :FechaHoy out
USING gtr_sce;

EXECUTE Fecha_Servidor;
FETCH Fecha_Servidor INTO :FechaHoy;
CLOSE Fecha_Servidor;
    
Fecha = Mid(fecha_espaniol_servidor(gtr_sce),1,12)
end event

on w_solicitud_materias_ant.create
this.cbx_datos_generales=create cbx_datos_generales
this.uo_1=create uo_1
this.gb_5=create gb_5
this.cb_actualiza_avisos=create cb_actualiza_avisos
this.tab_1=create tab_1
this.rb_avisopos=create rb_avisopos
this.rb_avisolic=create rb_avisolic
this.dw_avisos=create dw_avisos
this.uo_alumno=create uo_alumno
this.Control[]={this.cbx_datos_generales,&
this.uo_1,&
this.gb_5,&
this.cb_actualiza_avisos,&
this.tab_1,&
this.rb_avisopos,&
this.rb_avisolic,&
this.dw_avisos,&
this.uo_alumno}
end on

on w_solicitud_materias_ant.destroy
destroy(this.cbx_datos_generales)
destroy(this.uo_1)
destroy(this.gb_5)
destroy(this.cb_actualiza_avisos)
destroy(this.tab_1)
destroy(this.rb_avisopos)
destroy(this.rb_avisolic)
destroy(this.dw_avisos)
destroy(this.uo_alumno)
end on

event close;DESTROY dw_historico
DESTROY dw_plan_estud
DESTROY dw_materiasxcursar
DESTROY dw_materias_abiertas
DESTROY ids_comprobante
DESTROY ids_datos_generales

if gi_numscob = 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if
gi_numscob --
end event

type cbx_datos_generales from checkbox within w_solicitud_materias_ant
integer x = 1335
integer y = 892
integer width = 649
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Con Datos Generales"
end type

type uo_1 from uo_per_ani within w_solicitud_materias_ant
integer x = 2181
integer y = 892
integer taborder = 50
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type gb_5 from groupbox within w_solicitud_materias_ant
integer x = 27
integer y = 716
integer width = 1019
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78164112
string text = "Nivel"
end type

type cb_actualiza_avisos from commandbutton within w_solicitud_materias_ant
event clicked pbm_bnclicked
integer x = 1330
integer y = 752
integer width = 526
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Avisos"
end type

event clicked;// Juan Campos Sánchez.	Marzo-1998.
 
IF dw_avisos.ModifiedCount( ) > 0 Then
	IF dw_avisos.Update(True,True) = 1 Then
		Commit Using gtr_sce;
		Messagebox("Aviso","Los cambios fueron guardados")
	Else
		Rollback Using gtr_sce;
		Messagebox("Aviso","Los cambios no se guardaron")
	End If
Else
	Messagebox("No hay cambios para actualizar","")
End if

end event

type tab_1 from tab within w_solicitud_materias_ant
event create ( )
event destroy ( )
integer x = 18
integer y = 448
integer width = 3662
integer height = 652
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 27291696
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;if newindex=1 then
	uo_alumno.visible=true
else
	uo_alumno.visible=false
end if
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3625
integer height = 524
long backcolor = 79741120
string text = "Individual"
long tabtextcolor = 16776960
long tabbackcolor = 8388608
string picturename = "Custom076!"
long picturemaskcolor = 553648127
lb_cuentas lb_cuentas
st_5 st_5
st_4 st_4
st_status st_status
dw_sol_mat dw_sol_mat
cb_genera_solicitud cb_genera_solicitud
end type

on tabpage_1.create
this.lb_cuentas=create lb_cuentas
this.st_5=create st_5
this.st_4=create st_4
this.st_status=create st_status
this.dw_sol_mat=create dw_sol_mat
this.cb_genera_solicitud=create cb_genera_solicitud
this.Control[]={this.lb_cuentas,&
this.st_5,&
this.st_4,&
this.st_status,&
this.dw_sol_mat,&
this.cb_genera_solicitud}
end on

on tabpage_1.destroy
destroy(this.lb_cuentas)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_status)
destroy(this.dw_sol_mat)
destroy(this.cb_genera_solicitud)
end on

type lb_cuentas from listbox within tabpage_1
integer x = 2738
integer width = 494
integer height = 188
integer taborder = 51
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
end type

event doubleclicked;DeleteItem(index)
end event

type st_5 from statictext within tabpage_1
integer x = 1719
integer width = 439
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 0
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_1
integer x = 914
integer width = 805
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 33554432
boolean enabled = false
string text = " Procesando Cuenta:"
boolean focusrectangle = false
end type

type st_status from statictext within tabpage_1
integer x = 914
integer y = 96
integer width = 1243
integer height = 68
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 0
boolean enabled = false
string text = " Status"
boolean focusrectangle = false
end type

type dw_sol_mat from datawindow within tabpage_1
boolean visible = false
integer x = 2981
integer y = 1296
integer width = 293
integer height = 128
integer taborder = 10
boolean enabled = false
string dataobject = "dw_sol_mat"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetRedraw(False)																
end event

type cb_genera_solicitud from commandbutton within tabpage_1
integer y = 44
integer width = 544
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Solicitud"
end type

event clicked;// REPORTE DE SOLICITUD DE MATERIAS PARA REINSCRIPCIÓN.
// JUAN CAMPOS SÁNCHEZ.		FEBRERO-1998. 
// Víctor Manuel Iniestra Álvarez.		Octubre-1998. 

integer i,cont

if dw_materias_abiertas.retrieve(gi_periodo,gi_anio)=0 then
	messagebox("No hay materias abiertas","para este semestre, verificalo.")
	return
end if

st_4.text = " Procesando Cuenta:"
SetPointer(HourGlass!)
genera_individual=1

IF lb_cuentas.TotalItems( ) > 0 Then
	For i=1 to lb_cuentas.TotalItems( )
		Cuenta = long(lb_cuentas.Text(i))
		Select 	cve_carrera, cve_plan, cve_subsistema,nivel,promedio
		Into	:Carrera,:Plan,:Subsistema,:Nivel,:Promedio
		From	academicos
		Where	cuenta = :Cuenta
		using gtr_sce;
		If gtr_sce.sqlcode = 0 Then							 			
			st_5.text= String(Cuenta)
			// Referencias para los reportes dentro del datawindow compuesto.
			if cbx_datos_generales.checked = true then dw_sol_mat.Getchild('datosgenerales',DatosGenerales)
			dw_sol_mat.Getchild('avisos',avisos)
			dw_sol_mat.Getchild('encabezado',Encabezado)
			dw_sol_mat.Getchild('adeuda_cobranzas',AdeudaCobranzas)
			dw_sol_mat.Getchild('avisos_control_escolar',AvisosControlEscolar)
			dw_sol_mat.Getchild('historico',Historico)
			dw_sol_mat.Getchild('sugiere_mat_integ',SugiereMatInteg)
			dw_sol_mat.Getchild('sugiere_mat_reinsc',SugiereMatReinsc)
			dw_sol_mat.Getchild('diagnostico',Diagnostico)
  			// Transaction object especifica los parametros que PowerBuilder usa para la conección con la base de datos.
			if cbx_datos_generales.checked = true then DatosGenerales.SetTransObject(gtr_sce)
			Encabezado.SetTransObject(gtr_sce)
			AdeudaCobranzas.SetTransObject(gtr_scob)  
			AvisosControlEscolar.SetTransObject(gtr_sce)			
			Avisos.SetTransObject(gtr_sce)
			Historico.SetTransObject(gtr_sce)
			SugiereMatInteg.SetTransObject(gtr_sce)
			SugiereMatReinsc.SetTransObject(gtr_sce)
			Diagnostico.SetTransObject(gtr_sce)
 			// Se traen los datos en los datawindowsChild
			if Nivel = 'L' then
				Avisos.retrieve(0)
			else
				Avisos.retrieve(1)
			end if
			if cbx_datos_generales.checked = true then 
				if DatosGenerales.Retrieve(cuenta) > 1 then
					if DatosGenerales.Find("estudio_ant_cve_grado = 'M'",1,DatosGenerales.RowCount()) > 0 then
						DatosGenerales.SetFilter("estudio_ant_cve_grado = 'M'")
						DatosGenerales.Filter()
					elseif DatosGenerales.Find("estudio_ant_cve_grado = 'L'",1,DatosGenerales.RowCount()) > 0 then
						DatosGenerales.SetFilter("estudio_ant_cve_grado = 'L'")
						DatosGenerales.Filter()
					elseif DatosGenerales.Find("estudio_ant_cve_grado = 'B'",1,DatosGenerales.RowCount()) > 0 then
						DatosGenerales.SetFilter("estudio_ant_cve_grado = 'B'")
						DatosGenerales.Filter()
					end if
					DatosGenerales.SetFilter("estudio_ant_cve_grado = 'X'")
					DatosGenerales.Filter()
				end if
			end if
			Encabezado.Retrieve(Cuenta)
         llena_Avisos_Control_Esc(Cuenta,Puede_Integ,TemaF1,TemaF2,Tema1,Tema2,Tema3,Tema4,Nivel,AvisosControlEscolar,ServSoc,Ingles)
			AdeudaCobranzas.Retrieve(Cuenta,FechaHoy) 			 
			Historico.Retrieve(Cuenta,"5","9","10","AC","NA","RE","IN","BA","BJ","E","MB","B","S")
			agrega_materiasxcursar(nivel,dw_materiasxcursar,dw_historico,dw_materias_abiertas,cuenta,contlinea,numarchivo,plan,carrera,subsistema,dw_plan_estud,servsoc)
			
			sugierematreinsc.SetSort("area A, sem_ideal, cve_mat")
			sugierematreinsc.Sort()
			sugierematreinsc.GroupCalc()
			
			Diagnostico.SetSort("tipoarea A")
			Diagnostico.Sort()
			Diagnostico.GroupCalc()

			if sugierematreinsc.RowCount() = 0 Then
				cont = sugierematreinsc.InsertRow(0)
				sugierematreinsc.SetItem(i,2,0)
				sugierematreinsc.SetItem(i,3," ")
				sugierematreinsc.SetItem(i,4," ")
				sugierematreinsc.SetItem(i,5," ")
			 	sugierematreinsc.SetItem(i,6,0)
				sugierematreinsc.SetItem(i,7,4) // 4= Sin titulo 
				sugierematreinsc.SetItem(i,8,0)				
			End if
			
         If Nivel = 'L' Then			
         	Llena_Sugiere_Mat_Integ(Puede_Integ,TemaF1,TemaF2,Tema1,Tema2,Tema3,Tema4,SugiereMatInteg,Plan)
			End If		
 			Commit Using gtr_sce; 
			Commit Using gtr_scob;
			dw_sol_mat.Print()    
			dw_sol_mat.Reset();			Encabezado.Reset()
			AdeudaCobranzas.Reset();	AvisosControlEscolar.Reset()
			Diagnostico.Reset()
 		Else
			Messagebox("Error al consultar datos académicos",gtr_sce.sqlerrtext)
		End IF
	Next
End IF
st_4.text = " Fin del proceso"

For i=lb_cuentas.TotalItems( ) to 1 step -1
	lb_cuentas.DeleteItem(i)
next

SetPointer(Arrow!)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3625
integer height = 524
long backcolor = 79741120
string text = "General"
long tabtextcolor = 65535
long tabbackcolor = 8388608
string picturename = "Custom045!"
long picturemaskcolor = 553648127
st_ala st_ala
st_delacarrera st_delacarrera
em_nombrefin em_nombrefin
em_nombreini em_nombreini
em_carrerafin em_carrerafin
em_carreraini em_carreraini
st_7 st_7
st_6 st_6
st_3 st_3
st_2 st_2
st_status1 st_status1
cb_genera_solicitud1 cb_genera_solicitud1
end type

on tabpage_2.create
this.st_ala=create st_ala
this.st_delacarrera=create st_delacarrera
this.em_nombrefin=create em_nombrefin
this.em_nombreini=create em_nombreini
this.em_carrerafin=create em_carrerafin
this.em_carreraini=create em_carreraini
this.st_7=create st_7
this.st_6=create st_6
this.st_3=create st_3
this.st_2=create st_2
this.st_status1=create st_status1
this.cb_genera_solicitud1=create cb_genera_solicitud1
this.Control[]={this.st_ala,&
this.st_delacarrera,&
this.em_nombrefin,&
this.em_nombreini,&
this.em_carrerafin,&
this.em_carreraini,&
this.st_7,&
this.st_6,&
this.st_3,&
this.st_2,&
this.st_status1,&
this.cb_genera_solicitud1}
end on

on tabpage_2.destroy
destroy(this.st_ala)
destroy(this.st_delacarrera)
destroy(this.em_nombrefin)
destroy(this.em_nombreini)
destroy(this.em_carrerafin)
destroy(this.em_carreraini)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_status1)
destroy(this.cb_genera_solicitud1)
end on

type st_ala from statictext within tabpage_2
boolean visible = false
integer x = 2958
integer y = 236
integer width = 133
integer height = 108
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78164112
boolean enabled = false
string text = "a la"
boolean focusrectangle = false
end type

type st_delacarrera from statictext within tabpage_2
boolean visible = false
integer x = 2368
integer y = 236
integer width = 393
integer height = 108
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 78164112
boolean enabled = false
string text = "De la carrera"
boolean focusrectangle = false
end type

type em_nombrefin from editmask within tabpage_2
integer x = 2533
integer y = 96
integer width = 1061
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = ""
end type

type em_nombreini from editmask within tabpage_2
integer x = 2533
integer width = 1061
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = ""
end type

type em_carrerafin from editmask within tabpage_2
boolean visible = false
integer x = 3104
integer y = 236
integer width = 169
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
string mask = "#######"
string displaydata = "~r"
end type

type em_carreraini from editmask within tabpage_2
boolean visible = false
integer x = 2766
integer y = 236
integer width = 169
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
string mask = "#######"
string displaydata = ""
end type

type st_7 from statictext within tabpage_2
integer x = 2171
integer y = 96
integer width = 361
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Letra Fin:"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_2
integer x = 2171
integer width = 361
integer height = 92
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Letra Inicio:"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_2
integer x = 1719
integer width = 439
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_2
integer x = 914
integer width = 805
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 33554432
boolean enabled = false
string text = " Procesando Cuenta:"
boolean focusrectangle = false
end type

type st_status1 from statictext within tabpage_2
integer x = 914
integer y = 96
integer width = 1243
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
string text = " Status"
boolean focusrectangle = false
end type

type cb_genera_solicitud1 from commandbutton within tabpage_2
integer x = 27
integer y = 44
integer width = 544
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Solicitud"
end type

event clicked;// REPORTE GENERAL DE SOLICITUD DE MATERIAS PARA REINSCRIPCIÓN.
// JUAN CAMPOS SÁNCHEZ.		ABRIL-1998. 
// Víctor Manuel Iniestra Alvarez.		Octubre-1998. 

SetPointer(HourGlass!)
DataStore dw_cuentas, lds_folios

String ls_mensajecomprobante
int li_lineasmenscomp = 0

Integer	Cont,Exito
Integer  AreaBasica,AreaMayorObl,AreaMayorOpt
String	Ruta,NombreArch
Long		i,CuentaIni,CuentaFin
int 	rowcuentas
string NombreIni, NombreFin
int CarreraIni, CarreraFin
Char  	Texto[]

if dw_materias_abiertas.retrieve(gi_periodo,gi_anio)=0 then
	messagebox("No hay materias abiertas","para este semestre, verificalo.")
	return
end if

st_2.text = " Procesando Cuenta:"

NombreIni = em_nombreini.text
NombreFin = em_nombrefin.text
CarreraIni = dec(em_carreraini.text)
CarreraFin = dec(em_carrerafin.text)

genera_individual=0
dw_cuentas = CREATE DataStore
lds_folios = CREATE DataStore
ids_mensaje = CREATE DataStore

if rb_avisolic.checked then
	dw_cuentas.DataObject = "d_cuentas_horario_inscl"
	dw_cuentas.Settransobject(gtr_sce)
	lds_folios.DataObject = "d_folios_lic"
	lds_folios.Settransobject(gtr_sce)
	ids_mensaje.DataObject = "d_mensajel"
	rowcuentas = dw_cuentas.Retrieve(NombreIni,NombreFin)
	Nivel='L'
else
	dw_cuentas.DataObject = "d_cuentas_horario_inscp"
	dw_cuentas.Settransobject(gtr_sce)
	lds_folios.DataObject = "d_folios_pos"
	lds_folios.Settransobject(gtr_sce)
	ids_mensaje.DataObject = "d_mensajep"
	rowcuentas = dw_cuentas.Retrieve(NombreIni,NombreFin,CarreraIni,CarreraFin)
	Nivel='P'
end if
lds_folios.Retrieve()
ids_mensaje.SetTransObject(gtr_sce)
ids_mensaje.Retrieve()
ls_mensajecomprobante = convierte_avisos(ids_mensaje.GetItemString(1,"mensaje"))

dw_encabezado = CREATE DataStore
dw_encabezado.DataObject = "dw_encabezado"
dw_encabezado.Settransobject(gtr_sce)

dw_adeuda_cobranzas = CREATE DataStore
dw_adeuda_cobranzas.DataObject = "dw_adeuda_cobranzas"
dw_adeuda_cobranzas.SetTransObject(gtr_scob)

/*Verifica el tamaño de los avisos.*/
if rb_avisolic.checked = true then
	dw_avisos.retrieve(0)
else
	dw_avisos.retrieve(1)
end if 
texto=convierte_avisos(string(dw_avisos.object.texto[1]))
Texto[Len(Texto)+1] = Char(13)

ContAvisos = 0
For i = 1 To Len(Texto)
	If Texto[i] = char(13) Then
		ContAvisos++
	end if
Next

For i = 1 To Len(ls_mensajecomprobante) 
	If Mid(ls_mensajecomprobante,i,1) = char(13) Then li_lineasmenscomp ++
next

/**/
If RowCuentas > 0 Then
	Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
	If Exito = 1 then
		NumArchivo = FileOpen(Ruta,LineMode!,Write!,LockWrite!,Replace!)
		il_folio = lds_folios.Find("cuenta = "+string(dw_cuentas.getitemnumber(1,"cuenta")),1,lds_folios.RowCount())
		For Cont = 1 To dw_cuentas.RowCount()
         Cuenta = dw_cuentas.GetItemNumber(Cont,"cuenta") 	
			Select 	cve_carrera, cve_plan, cve_subsistema,nivel,promedio
				Into	:Carrera,:Plan,:Subsistema,:Nivel,:Promedio
				From	academicos 
				Where	cuenta = :Cuenta And nivel = :Nivel
			Using gtr_sce;
			If gtr_sce.sqlcode = 0 Then
				if cbx_datos_generales.checked = true then escribe_datos_generales()
				//st_3.text = string(Cont)
				escribe_comprobante(ls_mensajecomprobante,li_lineasmenscomp)
				ContHoja = 0
				dw_encabezado.Retrieve(Cuenta)
				Escribe_Encabezado()
				Escribe_Avisos(Texto)
				Escribe_AvisosControlEscolar()
				Escribe_Adeudos_Cobranzas()
				agrega_materiasxcursar(nivel,dw_materiasxcursar,dw_historico,dw_materias_abiertas,cuenta,contlinea,numarchivo,plan,carrera,subsistema,dw_plan_estud,servsoc)
          	If Nivel = 'L' Then
					Escribe_Sugiere_Integ()
				End if
			End if
			il_folio ++
		Next	
		FileClose(NumArchivo)
	End If
Else
	Messagebox("No hay datos en la tabla de horario_insc","Favor de verificar")
End If
SetPointer(Arrow!)  

DESTROY dw_cuentas
DESTROY lds_folios
DESTROY dw_encabezado
DESTROY dw_adeuda_cobranzas
DESTROY ids_mensaje

st_2.text = " Fin de proceso"
end event

type rb_avisopos from radiobutton within w_solicitud_materias_ant
event clicked pbm_bnclicked
integer x = 622
integer y = 780
integer width = 357
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78164112
string text = "Posgrado"
end type

event clicked;dw_avisos.RetriEve(1)

tab_1.tabpage_2.st_delacarrera.visible = true
tab_1.tabpage_2.st_ala.visible = true
tab_1.tabpage_2.em_carreraini.visible = true
tab_1.tabpage_2.em_carrerafin.visible = true
end event

type rb_avisolic from radiobutton within w_solicitud_materias_ant
event clicked pbm_bnclicked
integer x = 123
integer y = 780
integer width = 443
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78164112
string text = "Licenciatura"
boolean checked = true
end type

event clicked;dw_avisos.RetriEve(0)

tab_1.tabpage_2.st_delacarrera.visible = false
tab_1.tabpage_2.st_ala.visible = false
tab_1.tabpage_2.em_carreraini.visible = false
tab_1.tabpage_2.em_carrerafin.visible = false
end event

type dw_avisos from datawindow within w_solicitud_materias_ant
event key pbm_dwnkey
integer x = 50
integer y = 1100
integer width = 3621
integer height = 1084
string dataobject = "dw_avisos"
boolean livescroll = true
end type

event key;if key = Keyenter! Then
	Accepttext()
End if
end event

event constructor;settransobject(gtr_sce)
IF RetriEve(0) = 0 Then
	Messagebox("No hay información para los avios","Favor de verificar")
End if
end event

event editchanged;Accepttext()
end event

event itemchanged;Accepttext()
end event

type uo_alumno from uo_nombre_alu_foto within w_solicitud_materias_ant
integer x = 9
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_alumno.destroy
call uo_nombre_alu_foto::destroy
end on

