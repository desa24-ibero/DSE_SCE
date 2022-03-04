$PBExportHeader$w_asignacion_automatica_salones.srw
forward
global type w_asignacion_automatica_salones from window
end type
type uo_1 from uo_per_ani within w_asignacion_automatica_salones
end type
type cb_asigna_salones_tp from commandbutton within w_asignacion_automatica_salones
end type
type cb_asigna_salones_sp from commandbutton within w_asignacion_automatica_salones
end type
type dw_salones_sp from datawindow within w_asignacion_automatica_salones
end type
type st_horafinal from statictext within w_asignacion_automatica_salones
end type
type st_horainicio from statictext within w_asignacion_automatica_salones
end type
type st_2 from statictext within w_asignacion_automatica_salones
end type
type st_1 from statictext within w_asignacion_automatica_salones
end type
type dw_salones from datawindow within w_asignacion_automatica_salones
end type
type st_status from statictext within w_asignacion_automatica_salones
end type
type cb_asigna_salones from commandbutton within w_asignacion_automatica_salones
end type
type cbx_con_inscritos from checkbox within w_asignacion_automatica_salones
end type
type cbx_con_cupo from checkbox within w_asignacion_automatica_salones
end type
type cbx_licenciatura from checkbox within w_asignacion_automatica_salones
end type
type cbx_postgrado from checkbox within w_asignacion_automatica_salones
end type
type rr_6 from roundrectangle within w_asignacion_automatica_salones
end type
type dw_asig_autom_horario from datawindow within w_asignacion_automatica_salones
end type
type dw_asig_autom_grupos from datawindow within w_asignacion_automatica_salones
end type
type rr_1 from roundrectangle within w_asignacion_automatica_salones
end type
type rr_2 from roundrectangle within w_asignacion_automatica_salones
end type
end forward

global type w_asignacion_automatica_salones from window
integer x = 832
integer y = 352
integer width = 2231
integer height = 1400
boolean titlebar = true
string title = "Asignación Automática de Salones."
string menuname = "m_asignacion_salones"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
uo_1 uo_1
cb_asigna_salones_tp cb_asigna_salones_tp
cb_asigna_salones_sp cb_asigna_salones_sp
dw_salones_sp dw_salones_sp
st_horafinal st_horafinal
st_horainicio st_horainicio
st_2 st_2
st_1 st_1
dw_salones dw_salones
st_status st_status
cb_asigna_salones cb_asigna_salones
cbx_con_inscritos cbx_con_inscritos
cbx_con_cupo cbx_con_cupo
cbx_licenciatura cbx_licenciatura
cbx_postgrado cbx_postgrado
rr_6 rr_6
dw_asig_autom_horario dw_asig_autom_horario
dw_asig_autom_grupos dw_asig_autom_grupos
rr_1 rr_1
rr_2 rr_2
end type
global w_asignacion_automatica_salones w_asignacion_automatica_salones

type variables
window  Ventana
Integer   Periodo
long       Año
String     PerStr
Boolean Criterio1,Criterio2,Criterio3
end variables

forward prototypes
public function integer cupo_mat_asimilada (integer materia, string grupo)
public function integer inscritos_mat_asimilada (integer materia, string grupo)
public function boolean ocupa_salon (string salon, integer dia, integer hor_inicio, integer hor_final)
public function boolean mismo_salon (string salon, integer dia, integer hor_inicio, integer hor_final)
public function boolean salon_libre_1 (string salon, integer dia, integer hor_inicio, integer hor_final)
public subroutine periodo_asignacion_salones (ref integer per, ref long anio)
end prototypes

public function integer cupo_mat_asimilada (integer materia, string grupo);// Regresa la suma del cupo de las materias asimiladas 
// Juan Campos.		Octubre-1997.

Integer	Cupo = 0

Select Sum(cupo)
Into :Cupo
From grupos
Where cve_asimilada = :Materia and 
      gpo_asimilado = :Grupo and 
		periodo       = :Periodo and 
		anio          = :Año and
		cond_gpo      = 1
Using gtr_sce;

IF IsNull(Cupo) Then
	Cupo = 0
End IF

Return Cupo
 
end function

public function integer inscritos_mat_asimilada (integer materia, string grupo);// Regresa la suma del campo de inscritos de las materias asimiladas 
// Juan Campos.		Octubre-1997.

Integer	Inscritos = 0

Select sum(inscritos)
Into :Inscritos
From grupos
Where cve_asimilada = :Materia and 
      gpo_asimilado = :Grupo and 
		periodo       = :Periodo and 
		anio          = :Año and
		cond_gpo      = 1
Using gtr_sce;

If IsNull(Inscritos) Then
	Inscritos = 0
End if

Return Inscritos
 
end function

public function boolean ocupa_salon (string salon, integer dia, integer hor_inicio, integer hor_final);// Regresa True si la actualización es exitosa.
// se modifica el campo de ocupado de cero(libre) a uno(ocupado).  
// en el dia y entre de [hora_inicio .. hora_final].
// Juan Campos.		Octubre-1997.

Update salon_horario
Set ocupado = 1 
Where (cve_salon = :Salon And cve_dia = :Dia) And
      (hora_inicio Between  :hor_inicio And :hor_final - 1)
Using gtr_sce;

If gtr_sce.sqlcode = 0  Then
	Return True
Else
	Messagebox("Error al actualizar salón",gtr_sce.sqlerrtext)  
End if

Return False

end function

public function boolean mismo_salon (string salon, integer dia, integer hor_inicio, integer hor_final);// Regresa True si el salón esta disponible en el Dia y la hora_inicio
// Esta entre de [hora_inicio .. hora_final].
// Juan Campos.		Octubre-1997.

Integer SalonLibre = 0

Select Count(*)
Into  :SalonLibre
From  salon_horario 
Where (cve_salon = :Salon And cve_dia = :Dia) And
      (hora_inicio Between  :hor_inicio And :hor_final - 1)
Group By cve_salon Having SUM(ocupado) = 0
Using gtr_sce;

If gtr_sce.sqlcode = 0 And SalonLibre > 0 Then
	Return True
Else 
	Return False
End if


end function

public function boolean salon_libre_1 (string salon, integer dia, integer hor_inicio, integer hor_final);// Regresa True si el salón esta disponible en el Dia y la hora_inicio
// Esta entre de [hora_inicio .. hora_final].
// Juan Campos.		Octubre-1997.

Integer SalonLibre = 0

Select Count(*)
Into  :SalonLibre
From  salon_horario 
Where (cve_salon = :Salon And cve_dia = :Dia) And
      (hora_inicio Between  :hor_inicio And :hor_final - 1)
Group By cve_salon Having SUM(ocupado) = 0
Using gtr_sce;

If gtr_sce.sqlcode = 0 And SalonLibre > 0 Then
	Return True
End if

Return False

end function

public subroutine periodo_asignacion_salones (ref integer per, ref long anio);// Estas fechas solo son validas para el Per de alta de nuevos grupos
// Verifique las fechas en su calendario.
// Juan campos.		Octubre-1997.

string fecha,mes

fecha 		= fecha_ingles_servidor(gtr_sce)
Anio 	= long(mid(fecha,8,4))
mes 			= upper(mid(fecha,1,3))
If mes = "JAN" or mes = "FEB" or mes = "MAR" Then
	Per = 0
Elseif mes = "APR" or mes = "MAY" Then
	Per = 1	
ElseIf mes = "JUN" or mes = "JUL" or mes = "AUG" or mes = "SEP" or mes = "OCT" Then
	Per = 2
ElseIf mes = "NOV" or mes = "DEC"  Then
	Per = 0
	Anio ++
End if


end subroutine

on w_asignacion_automatica_salones.create
if this.MenuName = "m_asignacion_salones" then this.MenuID = create m_asignacion_salones
this.uo_1=create uo_1
this.cb_asigna_salones_tp=create cb_asigna_salones_tp
this.cb_asigna_salones_sp=create cb_asigna_salones_sp
this.dw_salones_sp=create dw_salones_sp
this.st_horafinal=create st_horafinal
this.st_horainicio=create st_horainicio
this.st_2=create st_2
this.st_1=create st_1
this.dw_salones=create dw_salones
this.st_status=create st_status
this.cb_asigna_salones=create cb_asigna_salones
this.cbx_con_inscritos=create cbx_con_inscritos
this.cbx_con_cupo=create cbx_con_cupo
this.cbx_licenciatura=create cbx_licenciatura
this.cbx_postgrado=create cbx_postgrado
this.rr_6=create rr_6
this.dw_asig_autom_horario=create dw_asig_autom_horario
this.dw_asig_autom_grupos=create dw_asig_autom_grupos
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.uo_1,&
this.cb_asigna_salones_tp,&
this.cb_asigna_salones_sp,&
this.dw_salones_sp,&
this.st_horafinal,&
this.st_horainicio,&
this.st_2,&
this.st_1,&
this.dw_salones,&
this.st_status,&
this.cb_asigna_salones,&
this.cbx_con_inscritos,&
this.cbx_con_cupo,&
this.cbx_licenciatura,&
this.cbx_postgrado,&
this.rr_6,&
this.dw_asig_autom_horario,&
this.dw_asig_autom_grupos,&
this.rr_1,&
this.rr_2}
end on

on w_asignacion_automatica_salones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.cb_asigna_salones_tp)
destroy(this.cb_asigna_salones_sp)
destroy(this.dw_salones_sp)
destroy(this.st_horafinal)
destroy(this.st_horainicio)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_salones)
destroy(this.st_status)
destroy(this.cb_asigna_salones)
destroy(this.cbx_con_inscritos)
destroy(this.cbx_con_cupo)
destroy(this.cbx_licenciatura)
destroy(this.cbx_postgrado)
destroy(this.rr_6)
destroy(this.dw_asig_autom_horario)
destroy(this.dw_asig_autom_grupos)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;// Asignación Automática de salones.
// Juan Campos Sánchez.		Octubre-1997.


//ventana =  this 
//ventana.setredraw(False)
//ventana.setredraw(True)

cbx_licenciatura.checked = True
cbx_con_cupo.Checked = True
st_status.text = ""
Criterio1=False ;Criterio2= False; Criterio3=False
//Periodo_Asignacion_Salones(Periodo,Año)
//IF Periodo  = 0  	Then
//	PerStr=  "PRIMAVERA"
//ElseIf Periodo = 1 Then 
//	PerStr=  "VERANO"
//ElseIf Periodo = 2 Then 
//	PerStr=  "OTOÑO"
//Else
//	Messagebox("Aviso","El periodo no es valido")
//	Close(This)
//End If

dw_asig_autom_grupos.SetTransObject(gtr_sce)
dw_asig_autom_horario.SetTransObject(gtr_sce)
dw_salones.SetTransObject(gtr_sce)
dw_salones_sp.SetTransObject(gtr_sce)
end event

type uo_1 from uo_per_ani within w_asignacion_automatica_salones
integer x = 905
integer y = 732
integer taborder = 31
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_asigna_salones_tp from commandbutton within w_asignacion_automatica_salones
integer x = 1349
integer y = 424
integer width = 722
integer height = 116
integer taborder = 10
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
string text = "Asigna Criterio 3"
end type

event clicked;// Asignación Automática de salones. 			Tercer Pasada
// Asignación Automática de salones. 			Tercer Pasada
// Juan Campos.         Noviembre-1997.

If Criterio3 Then  
	If Messagebox("Esté proceso ya fue corrido con este criterio","Deseas correrlo nuevamente",Question!,YesNo!,2) = 2 Then 
		Return 
	End if
Else
	Criterio3 = True
End IF  
  
Integer	IndGpo=0,Cupo=0,CupoSalon1=0,CupoSalon2=0
Long Materia
Integer HorIni,HorFin,IndHor,Dia,ClaseAula
Integer	IndSalon,CupoAux = 0
String	Letra1,Letra2, Grupo, Salon, Fecha, Hora
Char		Nivel
Boolean  SeModificoAlguno

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

st_horainicio.text = ""
st_horafinal.text = ""	

Año = gi_anio
Periodo = gi_periodo

PerStr = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, periodo)

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN luo_periodo_servicios.ierror
END IF	

//choose case periodo
//	case 0
//		PerStr = "Primavera"
//	case 1
//		PerStr = "Verano"
//	case 2
//		PerStr = "Otoño"
//end choose

If MessageBox("Asignación de salones para el Periodo: "+PerStr+" "+String(Año),"Son correctas las opciones para la asignación de salones.",Question!,YesNo!,2) = 1 Then	
	st_status.text =""
 	If cbx_licenciatura.checked Then
		Nivel	 = "L"
	ElseIf cbx_Postgrado.checked Then
		Nivel	 = "P"	
 	Else
		Messagebox("Aviso","No hay un nivel académico seleccionado.~nSeleccione uno")
		st_status.text = "Fin de proceso"
		Return
	End If
	Letra1 = "A" 
	Letra2 = "Z"  
	Fecha = String(today(),"dd-mmm-yyyy h:mm")
	Hora = mid(fecha,12, 10)   
	st_horainicio.text = Hora
	st_status.text = "Cargando Datos. "+ PerStr+" "+String(Año)+" Espere...."
	CupoSalon1 = 1
	CupoSalon2 = 100							 
	dw_salones_sp.Retrieve(CupoSalon1,CupoSalon2,letra1,letra2)
	If dw_asig_autom_grupos.Retrieve(Periodo,Año,Nivel) > 0 Then	
	   st_status.text = "Asignación automática de salones. "+ PerStr+" "+String(Año)+".  Espere...."
		DO  // dw_asig_autom_grupos.RowCount()
			IndGpo ++
			Materia = dw_asig_autom_grupos.GetItemNumber(IndGpo,"cve_mat")
			Grupo	= dw_asig_autom_grupos.GetItemString(IndGpo,"gpo")						
			Cupo = 0
			If cbx_con_cupo.checked Then				
				Cupo = dw_asig_autom_grupos.GetItemNumber(IndGpo,"cupo")
			ElseIf cbx_con_inscritos.checked Then				
				 Cupo = dw_asig_autom_grupos.GetItemNumber(IndGpo,"grupos_inscritos")
			Else	 
				Messagebox("Aviso","No hay un cupo seleccionado.~nSeleccione uno")
				st_status.text = "Fin de proceso"
				Return
 			End IF			
			If dw_asig_autom_horario.Retrieve(Periodo,Año,Materia,Grupo) > 0 Then									 
				SeModificoAlguno = False				
 				For IndHor= 1 To dw_asig_autom_horario.RowCount()
					HorIni = dw_asig_autom_horario.GetItemNumber(IndHor,"hora_inicio")
					HorFin = dw_asig_autom_horario.GetItemNumber(IndHor,"hora_final")
					Dia = dw_asig_autom_horario.GetItemNumber(IndHor,"cve_dia")
					ClaseAula = dw_asig_autom_horario.GetItemNumber(IndHor,"clase_aula")
					IF ClaseAula = 0 Then							 
						For IndSalon= 1 To dw_salones_sp.RowCount()
							Salon = dw_salones_sp.GetItemString(IndSalon,"cve_salon") 							 
							If Salon_Libre_1(Salon,Dia,HorIni,HorFin) Then
								If Ocupa_salon(Salon,Dia,HorIni,HorFin) Then
								   dw_asig_autom_horario.SetItem(IndHor,"cve_salon",Salon)					  				
									SeModificoAlguno = True
									Exit //IndSalon
								End if // Ocupa_salon
							End if // Salon_Libre
						Next // IndSalon
					End if // ClaseAula	
				Next // IndHor	
				IF dw_asig_autom_horario.Update(True,False) = 1 Then						
 					Commit Using gtr_sce;
				Else
					Rollback Using gtr_sce;
 				End if // update horario			
 			End IF // retrieve horario > 0
//			st_status.text = string(indgpo)			 
		LOOP UNTIL IndGpo =  dw_asig_autom_grupos.RowCount()
		Fecha = String(today(),"dd-mmm-yyyy h:mm")
		Hora = mid(fecha,12, 10)   
		st_horafinal.text = Hora		
		st_status.text ="Proceso terminado"
	ElseIf dw_asig_autom_grupos.Retrieve(Periodo,Año,Nivel) = 0 Then	
		Messagebox("Aviso","Ya no hay mas renglones para procesar") 
		st_status.text =""
	Else
		Messagebox("Error al leer grupos",gtr_sce.sqlerrtext) 
		st_status.text =""				
 	End If
End if 

Rollback using gtr_sce; 
st_status.text = "Fin de proceso"
end event

type cb_asigna_salones_sp from commandbutton within w_asignacion_automatica_salones
integer x = 1349
integer y = 268
integer width = 722
integer height = 120
integer taborder = 20
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
string text = "Asigna Criterio 2"
end type

event clicked;// Asignación Automática de salones.		Segunda Pasada.
// Juan Campos.         Noviembre-1997.

If Criterio2 Then  
	If Messagebox("Esté proceso ya fue corrido con este criterio","Deseas correrlo nuevamente",Question!,YesNo!,2) = 2 Then 
		Return 
	End if
Else
	Criterio2 = True
End IF  

  
Integer	IndGpo=0,Cupo=0,CupoSalon1=0,CupoSalon2=0
Long Materia
Integer HorIni,HorFin,IndHor,Dia,ClaseAula
Integer	IndSalon,ContSalonLibre,ContClaseAula,CupoAux = 0
String	Letra1,Letra2, Grupo, Salon, Fecha, Hora
Char		Nivel

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

st_horainicio.text = ""
st_horafinal.text = ""

Año = gi_anio
Periodo = gi_periodo

PerStr = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, periodo)

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN luo_periodo_servicios.ierror
END IF	

//choose case periodo
//	case 0
//		PerStr = "Primavera"
//	case 1
//		PerStr = "Verano"
//	case 2
//		PerStr = "Otoño"
//end choose

If MessageBox("Asignación de salones para el Periodo: "+PerStr+" "+String(Año),"Son correctas las opciones para la asignación de salones.",Question!,YesNo!,2) = 1 Then	
	st_status.text =""
 	If cbx_licenciatura.checked Then
		Nivel	 = "L"
		Letra1 = "A" 
		Letra2 = "F" // Salones cuyo 1.er Digito esta entre A a la E 
	ElseIf cbx_Postgrado.checked Then
		Nivel	 = "P"
		Letra1 = "F" 
		Letra2 = "H" // Salones cuyo 1.er Digito esta entre F a la G
	Else
		Messagebox("Aviso","No hay un nivel académico seleccionado.~nSeleccione uno")
		st_status.text = "Fin de proceso"
		Return
	End If
	Fecha = String(today(),"dd-mmm-yyyy h:mm")
	Hora = mid(fecha,12, 10)   
	st_horainicio.text = Hora		
	st_status.text = "Cargando Datos. "+ PerStr+" "+String(Año)+" Espere...."
	If dw_asig_autom_grupos.Retrieve(Periodo,Año,Nivel) > 0 Then	
	   st_status.text = "Asignación automática de salones. "+ PerStr+" "+String(Año)+".   Espere...."
		DO  // dw_asig_autom_grupos.RowCount()
			IndGpo ++
			Materia = dw_asig_autom_grupos.GetItemNumber(IndGpo,"cve_mat")
			Grupo	= dw_asig_autom_grupos.GetItemString(IndGpo,"gpo")						
			Cupo = 0
			If cbx_con_cupo.checked Then				
				Cupo = dw_asig_autom_grupos.GetItemNumber(IndGpo,"cupo")
			ElseIf cbx_con_inscritos.checked Then				
				 Cupo = dw_asig_autom_grupos.GetItemNumber(IndGpo,"grupos_inscritos")
			Else	 
				Messagebox("Aviso","No hay un cupo seleccionado.~nSeleccione uno")
				st_status.text = "Fin de proceso"
				Return
			End IF
			Choose Case Cupo // Ajusta Cupo
			Case 0 to 20
				Cupo = 20
				CupoSalon1 = 10
				CupoSalon2 = 35
 			Case 21 to 30
				Cupo = 30
				CupoSalon1 = 20
				CupoSalon2 = 40
			Case 31 to 40
				Cupo = 40
				CupoSalon1 = 25
				CupoSalon2 = 50				
			Case 41 to 50
				Cupo = 50
				CupoSalon1 = 35
				CupoSalon2 = 60				
			Case 51 to 50
				Cupo = 60
				CupoSalon1 = 40
				CupoSalon2 = 79				
			Case Is >=80
				Cupo = 70
				CupoSalon1 = 80
				CupoSalon2 = 100				
			End Choose
			If dw_asig_autom_horario.Retrieve(Periodo,Año,Materia,Grupo) > 0 Then
				IF Cupo <> CupoAux Then
					dw_salones_sp.Retrieve(CupoSalon1,CupoSalon2,letra1,letra2)
					CupoAux = Cupo
				End if	
				For IndSalon= 1 To dw_salones_sp.RowCount()
					Salon = dw_salones_sp.GetItemString(IndSalon,"cve_salon") 
					ContSalonLibre = 0
					ContClaseAula = 0
 					For IndHor= 1 To dw_asig_autom_horario.RowCount()
						HorIni = dw_asig_autom_horario.GetItemNumber(IndHor,"hora_inicio")
						HorFin = dw_asig_autom_horario.GetItemNumber(IndHor,"hora_final")
						Dia = dw_asig_autom_horario.GetItemNumber(IndHor,"cve_dia")
						ClaseAula = dw_asig_autom_horario.GetItemNumber(IndHor,"clase_aula")
						IF ClaseAula = 0 Then
							ContClaseAula ++							
							If Salon_Libre_1(Salon,Dia,HorIni,HorFin) Then
								If Ocupa_salon(Salon,Dia,HorIni,HorFin) Then
								   dw_asig_autom_horario.SetItem(IndHor,"cve_salon",Salon)					  				
	                 			ContSalonLibre ++								
								End if
							End if  
						End if	
					Next	
					If ContSalonLibre = ContClaseAula And &
						dw_asig_autom_horario.Update(True,False) = 1 Then 	
 						Commit Using gtr_sce;
//						IndSalon= dw_salones_sp.RowCount()
                  Exit
					Else
						Rollback Using gtr_sce;
 					End if // update horario
				Next // rowcount salon
 			End IF // retrieve horario > 0
//			st_status.text =String(IndGpo) 
		LOOP UNTIL IndGpo =  dw_asig_autom_grupos.RowCount()
		Fecha = String(today(),"dd-mmm-yyyy h:mm")
		Hora = mid(fecha,12, 10)   
		st_horafinal.text = Hora		
		st_status.text ="Proceso terminado"
	ElseIf dw_asig_autom_grupos.Retrieve(Periodo,Año,Nivel) = 0 Then	
		Messagebox("Aviso","Ya no hay mas renglones para procesar") 
		st_status.text =""
	Else
		Messagebox("Error al leer grupos",gtr_sce.sqlerrtext) 
		st_status.text =""				
 	End If
End if 

Rollback using gtr_sce;
st_status.text = "Fin de proceso"
end event

type dw_salones_sp from datawindow within w_asignacion_automatica_salones
boolean visible = false
integer x = 1239
integer y = 568
integer width = 951
integer height = 456
integer taborder = 30
boolean enabled = false
string dataobject = "dw_salon_cupo_1"
end type

event constructor;Setredraw(False)
end event

event destructor;Setredraw(True)
end event

type st_horafinal from statictext within w_asignacion_automatica_salones
integer x = 549
integer y = 824
integer width = 306
integer height = 100
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 8421376
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean border = true
long bordercolor = 8388608
boolean focusrectangle = false
end type

type st_horainicio from statictext within w_asignacion_automatica_salones
integer x = 549
integer y = 712
integer width = 306
integer height = 100
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 8421376
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean border = true
long bordercolor = 8388608
boolean focusrectangle = false
end type

type st_2 from statictext within w_asignacion_automatica_salones
integer x = 69
integer y = 712
integer width = 471
integer height = 100
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 16776960
long backcolor = 27291696
boolean enabled = false
string text = "Hora Inicio: "
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_1 from statictext within w_asignacion_automatica_salones
integer x = 69
integer y = 824
integer width = 471
integer height = 100
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 16776960
long backcolor = 27291696
boolean enabled = false
string text = "Hora Final:"
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_salones from datawindow within w_asignacion_automatica_salones
boolean visible = false
integer x = 2217
integer y = 568
integer width = 951
integer height = 456
integer taborder = 40
boolean enabled = false
string dataobject = "dw_salon_cupo"
end type

event constructor;setredraw(False)
end event

event destructor;setredraw(True)
end event

type st_status from statictext within w_asignacion_automatica_salones
integer x = 64
integer y = 1056
integer width = 2062
integer height = 108
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long textcolor = 16776960
long backcolor = 27291696
boolean enabled = false
string text = "Estatus del proceso."
alignment alignment = center!
long bordercolor = 16777215
boolean focusrectangle = false
end type

type cb_asigna_salones from commandbutton within w_asignacion_automatica_salones
integer x = 1349
integer y = 112
integer width = 722
integer height = 120
integer taborder = 70
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
string text = "Asigna Criterio 1"
end type

event clicked;// Asignación Automática de salones.		Primer Pasada
// Juan Campos.         Noviembre-1997.

If Criterio1 Then  
	If Messagebox("Esté proceso ya fue corrido con este criterio","Deseas correrlo nuevamente",Question!,YesNo!,2) = 2 Then 
		Return 
	End if
Else
	Criterio1 = True
End IF  
    
Integer	IndGpo=0,Cupo=0
Long Materia
Integer HorIni,HorFin,IndHor,Dia,ClaseAula
Integer	IndSalon,ContSalonLibre,ContClaseAula,CupoAux = 0
String	Letra1,Letra2, Grupo, Salon, Fecha, Hora
Char		Nivel
Año = gi_anio
Periodo = gi_periodo

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

PerStr = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, periodo)

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN luo_periodo_servicios.ierror
END IF	

//choose case periodo
//	case 0
//		PerStr = "Primavera"
//	case 1
//		PerStr = "Verano"
//	case 2
//		PerStr = "Otoño"
//end choose

st_horainicio.text = ""
st_horafinal.text = ""
If MessageBox("Asignación de salones para el Periodo: "+PerStr+" "+String(Año),"Son correctas las opciones para la asignación de salones.",Question!,YesNo!,2) = 1 Then	
	st_status.text =""
 	If cbx_licenciatura.checked Then
		Nivel	 = "L"
		Letra1 = "A" 
		Letra2 = "F" // Salones cuyo 1.er Digito esta entre A a la E 
	ElseIf cbx_Postgrado.checked Then
		Nivel	 = "P"
		Letra1 = "F" 
		Letra2 = "H" // Salones cuyo 1.er Digito esta entre F a la G
	Else
		Messagebox("Aviso","No hay un nivel académico seleccionado.~nSeleccione uno")
		st_status.text = "Fin de proceso"
		Return
	End If
	Fecha = String(today(),"dd-mmm-yyyy h:mm")
	Hora = mid(fecha,12, 10)   
	st_horainicio.text = Hora	
	st_status.text = "Cargando Datos. "+ PerStr+" "+String(Año)+" Espere...."
	If dw_asig_autom_grupos.Retrieve(Periodo,Año,Nivel) > 0 Then	
	   st_status.text = "Asignación automática de salones. "+ PerStr+" "+String(Año)+".  Espere...."
		DO  // dw_asig_autom_grupos.RowCount()
			IndGpo ++
			Materia = dw_asig_autom_grupos.GetItemNumber(IndGpo,"cve_mat")
			Grupo	= dw_asig_autom_grupos.GetItemString(IndGpo,"gpo")						
			Cupo = 0
			If cbx_con_cupo.checked Then				
				Cupo = dw_asig_autom_grupos.GetItemNumber(IndGpo,"cupo")
			ElseIf cbx_con_inscritos.checked Then				
				 Cupo = dw_asig_autom_grupos.GetItemNumber(IndGpo,"grupos_inscritos")
			Else	 
				Messagebox("Aviso","No hay un cupo seleccionado.~nSeleccione uno")
				st_status.text = "Fin de proceso"
				Return
			End IF
			Choose Case Cupo // Ajusta Cupo
			Case 0 to 25
				Cupo = 20
			Case 26 to 44
				Cupo = 40
			Case 45 to 64
				Cupo = 60
			Case Is >=65
				Cupo = 80
			End Choose
			If dw_asig_autom_horario.Retrieve(Periodo,Año,Materia,Grupo) > 0 Then
				IF Cupo <> CupoAux Then
					dw_salones.Retrieve(Cupo,letra1,letra2)
					CupoAux = Cupo
				End if	
				For IndSalon= 1 To dw_salones.RowCount()
					Salon = dw_salones.GetItemString(IndSalon,"cve_salon") 
					ContSalonLibre = 0
					ContClaseAula = 0
 					For IndHor= 1 To dw_asig_autom_horario.RowCount()
						HorIni = dw_asig_autom_horario.GetItemNumber(IndHor,"hora_inicio")
						HorFin = dw_asig_autom_horario.GetItemNumber(IndHor,"hora_final")
						Dia = dw_asig_autom_horario.GetItemNumber(IndHor,"cve_dia")
						ClaseAula = dw_asig_autom_horario.GetItemNumber(IndHor,"clase_aula")
						IF ClaseAula = 0 Then
							ContClaseAula ++							
							If Salon_Libre_1(Salon,Dia,HorIni,HorFin) Then
								If Ocupa_salon(Salon,Dia,HorIni,HorFin) Then
								   dw_asig_autom_horario.SetItem(IndHor,"cve_salon",Salon)					  				
	                 			ContSalonLibre ++								
								End if
							End if  
						End if	
					Next	
					If ContSalonLibre = ContClaseAula And &
						dw_asig_autom_horario.Update(True,False) = 1 Then 	
 						Commit Using gtr_sce;
//						IndSalon= dw_salones.RowCount()
                  Exit
					Else
						Rollback Using gtr_sce;
 					End if // update horario
				Next // rowcount salon
 			End IF // retrieve horario > 0
//			st_status.text =String(IndGpo) 
		LOOP UNTIL IndGpo =  dw_asig_autom_grupos.RowCount()
		Fecha = String(today(),"dd-mmm-yyyy h:mm")
		Hora = mid(fecha,12, 10)   
		st_horafinal.text = Hora		
		st_status.text ="Proceso terminado"
	ElseIf dw_asig_autom_grupos.Retrieve(Periodo,Año,Nivel) = 0 Then	
		Messagebox("Aviso","Ya no hay mas renglones para procesar") 
		st_status.text =""
	Else
		Messagebox("Error al leer grupos",gtr_sce.sqlerrtext) 
		st_status.text =""		
	End If
End if

Rollback using gtr_sce;
st_status.text = "Fin de proceso"
end event

type cbx_con_inscritos from checkbox within w_asignacion_automatica_salones
integer x = 105
integer y = 468
integer width = 635
integer height = 76
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long backcolor = 15793151
string text = "Con Inscritos"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

type cbx_con_cupo from checkbox within w_asignacion_automatica_salones
integer x = 105
integer y = 360
integer width = 635
integer height = 76
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long backcolor = 15793151
string text = "Con Cupo"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

type cbx_licenciatura from checkbox within w_asignacion_automatica_salones
integer x = 105
integer y = 136
integer width = 635
integer height = 76
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long backcolor = 15793151
string text = "Licenciatura"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

type cbx_postgrado from checkbox within w_asignacion_automatica_salones
integer x = 105
integer y = 248
integer width = 635
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long backcolor = 15793151
string text = "Postgrado"
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

type rr_6 from roundrectangle within w_asignacion_automatica_salones
long linecolor = 15793151
integer linethickness = 4
long fillcolor = 10789024
integer x = 32
integer y = 1024
integer width = 2121
integer height = 160
integer cornerheight = 40
integer cornerwidth = 41
end type

type dw_asig_autom_horario from datawindow within w_asignacion_automatica_salones
boolean visible = false
integer x = 73
integer y = 1036
integer width = 2240
integer height = 456
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_asig_autom_horario"
end type

event constructor;Setredraw(False)
end event

event destructor;Setredraw(True)
end event

type dw_asig_autom_grupos from datawindow within w_asignacion_automatica_salones
boolean visible = false
integer x = 73
integer y = 568
integer width = 1138
integer height = 456
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_asig_autom_grupos"
end type

event constructor;Setredraw(False)
end event

event destructor;Setredraw(True)
end event

event retrieveend;// Fija el nuevo cupo.
// Juan Campos Sánchez.		Noviembre-1997.

If cbx_con_inscritos.checked Then
	If RowCount() > 0 Then
		Integer IndGpo= 0 ,Cupo
		Long Materia
		String Grupo
		Do
			IndGpo ++
			Materia 	= GetItemNumber(IndGpo,"cve_mat") 
			Grupo		= GetItemString(IndGpo,"gpo")		  
			Cupo 		= 0		          
			Cupo = GetItemNumber(IndGpo,"grupos_inscritos")
//			Cupo = Cupo + Inscritos_Mat_Asimilada(Materia,Grupo) 
// Se comantario esta linea a petición de fantine medina ,ya que el total de
// Inscritos en las materias asimiladas ya fueron sumados.
// Juan Campos 12-Enero-1998
			SetItem(IndGpo,"grupos_inscritos",Cupo)
			Accepttext() 
		LOOP UNTIL IndGpo =  dw_asig_autom_grupos.RowCount()
		Sort()
	End if
End if

// Si se requiere que se sume el cupo de las materias asimiladas cuando se
// seleccione la opción de "Por cupo" cambia el codigo que se encuentra 
// comentariado por el antarior.
//If RowCount() > 0 Then
//	Integer IndGpo= 0 ,Cupo,Materia
//	String Grupo
//	Do
//		IndGpo ++
//		Materia 	= GetItemNumber(IndGpo,"cve_mat") 
//		Grupo		= GetItemString(IndGpo,"gpo")		  
//		Cupo 		= 0		                          
//		If cbx_con_cupo.checked Then		
//			Cupo = GetItemNumber(IndGpo,"cupo")
//			Cupo = Cupo + Cupo_Mat_Asimilada(Materia,Grupo)
//			SetItem(IndGpo,"cupo",Cupo)
//		Else
//			Cupo = GetItemNumber(IndGpo,"inscritos")
//			Cupo = Cupo + Inscritos_Mat_Asimilada(Materia,Grupo)
//			SetItem(IndGpo,"inscritos",Cupo)
//		End IF
//		Accepttext() 
//	LOOP UNTIL IndGpo =  dw_asig_autom_grupos.RowCount()
//	Sort()
//End if
 
end event

type rr_1 from roundrectangle within w_asignacion_automatica_salones
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 27291696
integer x = 37
integer y = 664
integer width = 846
integer height = 292
integer cornerheight = 40
integer cornerwidth = 41
end type

type rr_2 from roundrectangle within w_asignacion_automatica_salones
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 15793151
integer x = 64
integer y = 72
integer width = 2062
integer height = 536
integer cornerheight = 40
integer cornerwidth = 41
end type

