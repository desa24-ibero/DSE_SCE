$PBExportHeader$w_grupos_impartidos_dse.srw
forward
global type w_grupos_impartidos_dse from w_grupos_impartidos
end type
type tab_disponibles from tab within w_grupos_impartidos_dse
end type
type tabpage_1 from userobject within tab_disponibles
end type
type dw_disp from datawindow within tabpage_1
end type
type ddlb_dia from dropdownlistbox within tabpage_1
end type
type ddlb_cupo from dropdownlistbox within tabpage_1
end type
type em_horini from editmask within tabpage_1
end type
type em_horfin from editmask within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type cb_versalones from commandbutton within tabpage_1
end type
type cb_cerrar from commandbutton within tabpage_1
end type
type cbx_serviciosescolares from checkbox within w_grupos_impartidos_dse
end type
type rr_2 from roundrectangle within w_grupos_impartidos_dse
end type
type rr_3 from roundrectangle within w_grupos_impartidos_dse
end type
type rr_4 from roundrectangle within w_grupos_impartidos_dse
end type
type st_5 from statictext within w_grupos_impartidos_dse
end type
type uo_1 from uo_per_ani within w_grupos_impartidos_dse
end type
type cb_1 from commandbutton within w_grupos_impartidos_dse
end type
type tabpage_1 from userobject within tab_disponibles
dw_disp dw_disp
ddlb_dia ddlb_dia
ddlb_cupo ddlb_cupo
em_horini em_horini
em_horfin em_horfin
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
cb_versalones cb_versalones
cb_cerrar cb_cerrar
end type
type tab_disponibles from tab within w_grupos_impartidos_dse
tabpage_1 tabpage_1
end type
end forward

global type w_grupos_impartidos_dse from w_grupos_impartidos
int Width=3588
int Height=2061
tab_disponibles tab_disponibles
cbx_serviciosescolares cbx_serviciosescolares
rr_2 rr_2
rr_3 rr_3
rr_4 rr_4
st_5 st_5
uo_1 uo_1
cb_1 cb_1
end type
global w_grupos_impartidos_dse w_grupos_impartidos_dse

type variables
 
end variables

forward prototypes
public function boolean existe_materia (long materia)
public function boolean existe_salon (string salon)
public function boolean ocupa_salon (string salon, integer dia, integer hor_inicio, integer hor_final)
public function boolean desocupa_salon (string salon, integer dia, integer hor_inicio, integer hor_final)
public function boolean salon_libre_dse (string salon, integer dia, integer hor_inicio, integer hor_final)
end prototypes

public function boolean existe_materia (long materia);// Regresa True si la materia le pertenece a al depto.
// Juan Campos. 		Octubre-1997.

Select materia  
Into 	:sle_nombre_mat.text
From	materias  
Where	materias.cve_mat = :Materia using gtr_sce;
			
If gtr_sce.sqlcode = 100  Then
	MessageBox("Aviso","La Materia   No Existe")
	Goto Materia_false
Elseif gtr_sce.sqlcode = -1 Then
	MessageBox("Error","Al consultar la materia. "+gtr_sce.sqlerrtext)
	Goto Materia_false
End If

EstaVentana.setredraw(False)	
dw_horario.reset()
dw_titular.reset()
dw_mat.Reset()
dw_mat.ScrollToRow(dw_mat.insertrow(0))		
Triggerevent("desbloqueacampos")
MateriaDeptoOK = True
dw_mat.Setitem(dw_mat.GetRow(),"cve_mat",Materia)
dw_mat.AcceptText( )
EstaVentana.setredraw(True)									  
Return True
 
Materia_False:
	EstaVentana.setredraw(False)	
	dw_horario.reset()
	dw_titular.reset()
	dw_mat.Reset()
	dw_mat.ScrollToRow(dw_mat.insertrow(0))	
	Triggerevent("bloqueacampos")
	MateriaDeptoOK = False
	sle_nombre_mat.text= ""
	dw_mat.setfocus()
	EstaVentana.setredraw(True)									  
	Return False


end function

public function boolean existe_salon (string salon);// Regrea True si el salon Existe
// Juan Campos.		Octubre-1997.

Integer Existe = 0 , Bloqueado

Select Count(*),bloqueado
Into :Existe,:Bloqueado
From salon
where cve_salon = :Salon using gtr_sce;

If Existe > 0 Then 
	If Bloqueado = 1 Then
		Messagebox("Error","Esté salón esta bloqueado")
		Return False
	End If
	Return True
ElseIf Existe = 0 Then
	Messagebox("Error","Esté salón no existe")
	Return False
ElseIf gtr_sce.sqlcode = -1 Then
	Messagebox("Error al consultar el salón",String(gtr_sce.sqlcode)+" "+gtr_sce.sqlerrtext)
   Return False	
ElseIf gtr_sce.sqlcode = 100 or Existe = 0 Then
	Messagebox("Error","El Salón " +Salon+" No Existe")
	Return False
End If
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

public function boolean desocupa_salon (string salon, integer dia, integer hor_inicio, integer hor_final);// Regresa True si la actualización es exitosa.
// se modifica el campo de ocupado de cero(libre) a uno(ocupado).  
// en el dia y entre de [hora_inicio .. hora_final].
// Juan Campos.		Octubre-1997.

Update salon_horario
Set ocupado = 0 
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

public function boolean salon_libre_dse (string salon, integer dia, integer hor_inicio, integer hor_final);// Regresa True si el salón esta disponible en el Dia, y la hora_inicio este entre de [hora_inicio .. hora_final].
// Si el salon esta ocupado pero la clase del salon es igual a: LAB o TALLER
// se hace la pregunta si desea encimarlo si es afirmativa la funcion regresa True.
// Juan Campos.		Octubre-1997.

String	ClaseAula = ""
int li_cve_mat


  SELECT horario.cve_mat 
  INTO :li_cve_mat
    FROM horario  
   WHERE ( horario.cve_dia = :Dia ) AND  
         ( horario.cve_salon LIKE :Salon ) AND
			( horario.anio = :gi_anio ) AND
			( horario.periodo = :gi_periodo ) AND  
			(((horario.hora_final  <= :hor_final)AND(horario.hora_final  > :hor_inicio)) OR 
			 ((horario.hora_inicio >= :hor_inicio)AND(horario.hora_inicio < :hor_final)))
	using gtr_sce;

If gtr_sce.sqlcode = 100 then
	Return True
Else
	Select clase_aula Into :ClaseAula From salon Where cve_salon = :Salon using gtr_sce; 
	IF ClaseAula = "LAB" Or ClaseAula = "TALLER" Then
		IF Messagebox("El salón no esta disponible","Desea encimar el salón",Question!,YesNo!,2) = 1 Then
			Return True
		End IF
	END IF
End IF
Messagebox("El salón no esta disponible",gtr_sce.sqlerrtext)  
Return False



end function

on w_grupos_impartidos_dse.create
int iCurrent
call super::create
this.tab_disponibles=create tab_disponibles
this.cbx_serviciosescolares=create cbx_serviciosescolares
this.rr_2=create rr_2
this.rr_3=create rr_3
this.rr_4=create rr_4
this.st_5=create st_5
this.uo_1=create uo_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_disponibles
this.Control[iCurrent+2]=this.cbx_serviciosescolares
this.Control[iCurrent+3]=this.rr_2
this.Control[iCurrent+4]=this.rr_3
this.Control[iCurrent+5]=this.rr_4
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.cb_1
end on

on w_grupos_impartidos_dse.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_disponibles)
destroy(this.cbx_serviciosescolares)
destroy(this.rr_2)
destroy(this.rr_3)
destroy(this.rr_4)
destroy(this.st_5)
destroy(this.uo_1)
destroy(this.cb_1)
end on

event open;call super::open;// 	GRUPOS IMPATIDOS EN EL SEMESTRE.
// 	Juan Campos Sánchez. 							Octubre-1997.

//g_nv_security.fnv_secure_window (this)
 
m_gpo_imp.ventana = This
Tab_disponibles.x = 1189
Tab_disponibles.y = 417
Tab_disponibles.width = 138	
Tab_disponibles.height = 649	
m_gpo_imp.m_registro.m_borrasaln.Enable() 
año = gi_anio
periodo = gi_periodo
choose case periodo
	case 0
		st_periodo.text = "PRIMAVERA " + String(año)
	case 1
		st_periodo.text = "VERANO " + String(año)
	case 2
		st_periodo.text = "OTOÑO " + String(año)
end choose

	

end event

event activate;control_escolar.toolbarsheettitle = "Grupos impartidos en el semestre.    Dirección de Servicios Escolares."
                                  

end event

type dw_prof_adj from w_grupos_impartidos`dw_prof_adj within w_grupos_impartidos_dse
int TabOrder=30
end type

type st_periodo from w_grupos_impartidos`st_periodo within w_grupos_impartidos_dse
int X=688
int Y=29
int Height=64
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long TextColor=65535
long BackColor=8388608
int TextSize=-10
end type

type cbx_nuevo from w_grupos_impartidos`cbx_nuevo within w_grupos_impartidos_dse
string Text=" Nuevo"
long TextColor=16711680
end type

type sle_nombre_mat from w_grupos_impartidos`sle_nombre_mat within w_grupos_impartidos_dse
int TabOrder=60
end type

type dw_nombre_mat from w_grupos_impartidos`dw_nombre_mat within w_grupos_impartidos_dse
int TabOrder=50
end type

event dw_nombre_mat::doubleclicked;call super::doubleclicked;String 	Columna
Long 		Materia_dw

Columna = GetColumnName()

If Columna = "cve_mat" or Columna = "materia" Then
	Materia_dw = GetItemNumber(Getrow( ),"cve_mat")
	dw_nombre_mat.enabled = False
	dw_nombre_mat.visible = False
	dw_nombre_mat.height = 120
	If Existe_Materia(Materia_dw) Then
 		dw_mat.setfocus()
		dw_mat.triggerevent(itemchanged!)	
	End If
End If
end event

type dw_horario from w_grupos_impartidos`dw_horario within w_grupos_impartidos_dse
int X=1335
int TabOrder=40
end type

event dw_horario::getfocus;// J.C.S.

If dw_horario.rowcount() > 0 Then
	IF (dw_mat.getitemnumber(dw_mat.getrow(),"tipo") = 1 or &
	 	dw_mat.getitemnumber(dw_mat.getrow(),"tipo") = 2) Then // 1=Asesoria, 2=Asimilado	
		MessageBox("Aviso","El tipo de grupo Asesoria o Asimilado no puede tener asociado un horario.~nSi desea puede borrar el horario.")		
   	This.Undo()	
   	Return
	End IF
End if
end event

event dw_horario::itemchanged;// Juan Campos.         Junio-1997.

String			Columna,Salon,Salon_P
Integer			Bloqueado,HoraIni,HoraFin,Dia
 
Accepttext()
Columna = Getcolumnname()

If Columna = "hora_inicio" Then
	horaIni = GetitemNumber(GetRow(),"hora_inicio")	
	Choose Case horaini
	Case 7 to 21
		SetTabOrder("clase_aula",10)
		SetTabOrder("cve_dia",20)
		SetTabOrder("hora_inicio",30)
		SetTabOrder("hora_final",40)
		SetTabOrder("cve_salon",50)
 		Return 0 // hora inicio valida
	Case Else
		SetTabOrder("clase_aula",0)
		SetTabOrder("cve_dia",0)
		SetTabOrder("hora_inicio",30)
		SetTabOrder("hora_final",0)
		SetTabOrder("cve_salon",0)
		SelectText(1,4)
		Return 1 // hora inicio NO valida
	End Choose				
ElseIf Columna = "hora_final" Then
	horaFin = GetitemNumber(GetRow(),"hora_final")		
	Choose Case horafin
	Case 8 to 22
 		If horafin > horaini Then 
			SetTabOrder("clase_aula",10)
 			SetTabOrder("cve_dia",20)
			SetTabOrder("hora_inicio",30)
			SetTabOrder("hora_final",40)
			SetTabOrder("cve_salon",50)
 			Return 0 // hora final valida
		Else
			SetTabOrder("clase_aula",0)
			SetTabOrder("cve_dia",0)
			SetTabOrder("hora_inicio",0)
			SetTabOrder("hora_final",40)
			SetTabOrder("cve_salon",0)
			SelectText(1,4)
			Return 1 // hora final NO valida
		End If
	Case Else		 
			SetTabOrder("clase_aula",0)
			SetTabOrder("cve_dia",0)
			SetTabOrder("hora_inicio",0)
			SetTabOrder("hora_final",40)
			SetTabOrder("cve_salon",0)
			SelectText(1,4)
			Return 1 // hora final NO valida
	End Choose		
ElseIf Columna = "cve_salon" Then
 	horaIni 	= GetitemNumber(GetRow(),"hora_inicio")		
	horaFin 	= GetitemNumber(GetRow(),"hora_final")			
	If horafin > horaini Then 
	 	dw_mat.TriggerEvent("Actualiza")
		Return 0 
 	Else
		Messagebox("Error","El horario no es valido")
		Return 1  	
	End if // horafin > horaini	
End If // Columna
 
end event

type dw_titular from w_grupos_impartidos`dw_titular within w_grupos_impartidos_dse
int X=881
int Width=2560
end type

type dw_mat from w_grupos_impartidos`dw_mat within w_grupos_impartidos_dse
event type boolean cancelagrupo ( )
int X=48
int Width=3452
end type

event cancelagrupo;// Decrementa el derecho y uso de salón y si tiene un salón asociado
// llama a la función desocupa_salon() y borra el salon de dw_horario
// Regresa True si se efectuan todos los cambios.
// Juan campos 		Noviembre-1997.

Integer	Clave,ClaveAsim,CupoGrupo,RenHor,Dia,HoraIni,HoraFin,ClaseAula,Existe = 0
String 	Grupo,GrupoAsim,CampoNulo,Salon
Boolean	CambiosOk = True

If cbx_nuevo.checked Then
	Messagebox("Aviso","Esté grupo no existe, no es posible Cancelarlo")
	Return False
End If

ClaveAsim = dw_mat.GetItemnumber(dw_mat.GetRow(),"cve_asimilada",Primary!,True)
GrupoAsim = dw_mat.GetItemstring(dw_mat.GetRow(),"gpo_asimilado",Primary!,True)	
messagebox(string(claveasim)+"-"+string(grupoasim),string(periodo)+"-"+string(año))
If Not IsNull(ClaveAsim) or Not IsNull(GrupoAsim) Then
	Select Count(*) 
	Into :Existe
	From grupos
	Where cve_mat = :ClaveAsim and gpo = :GrupoAsim and 
	      periodo = :Periodo And anio = :Año And cond_gpo = 1 using gtr_sce;
	If Existe > 0 Then
		Messagebox("Error","Existe un grupo Asimilado que no fue Cancelado previamente")
		Return False
	End if	
end if	
	
IF Messagebox("Aviso","Desea cancelar esté grupo",Question!,YesNo!,2) = 1 Then
	Clave	= dw_mat.GetItemnumber(dw_mat.GetRow(),"cve_mat",Primary!,True)
	Grupo	= dw_mat.GetItemstring(dw_mat.GetRow(),"gpo",Primary!,True)	
	CupoGrupo = dw_mat.GetItemNumber(dw_mat.GetRow(),"cupo",Primary!,True)		
	Ajusta_Cupo(CupoGrupo)
	SetNull(CampoNulo)
	IF dw_horario.ModifiedCount( ) > 0 Then
		dw_horario.Retrieve(Clave,Grupo,Periodo,Año)
	End If	
	IF dw_horario.RowCount() > 0  Then	
		For RenHor = 1 To dw_horario.RowCount()
			ClaseAula= dw_horario.GetItemNumber(RenHor,"clase_aula")
			Dia     	= dw_horario.GetItemNumber(RenHor,"cve_dia")
 			horaini	= dw_horario.GetItemNumber(RenHor,"hora_inicio")
			horafin	= dw_horario.GetItemNumber(RenHor,"hora_final")
			Salon    = dw_horario.GetItemString(RenHor,"cve_salon")
			If ClaseAula = 0 Then // 0=Salon
		 		If Not Decrementa_Derecho_y_Uso(Clave,Dia,HoraIni,HoraFin,CupoGrupo) Then
					CambiosOk = False	
				End if
			End if

			If CambiosOK Then
				If Not isNull(Salon) Then
					If Existe_salon(Salon) Then	
						If DesOcupa_salon(Salon,Dia,HoraIni,HoraFin) Then
							dw_horario.SetItem(RenHor,"cve_salon",CampoNulo)
						Else
							CambiosOK = False	
 						End IF
					Else
						CambiosOK = False
					End IF
 				End IF
			End iF
		Next
		IF CambiosOk And & 
		   dw_mat.Update(True,True) = 1 And dw_horario.Update(True,True) = 1 Then
			Commit using gtr_sce;
			Messagebox("Aviso","Los cambios fueron guardados")	
			Return True
		Else
			Rollback Using gtr_sce;
			Messagebox("Aviso","Los cambios no fueron guardados")	
			Return False
		End IF
	Else
		Return True
	End If
Else
	Return False
End If

end event

event dw_mat::itemchanged; // Juan Campos.   Junio-1997.

String	columna,Grupo_Dw,gpo_ant,null_string, GpoAsim
long		Materia_dw, cve, HazRetrieve = 0
Integer	cont,ren, Mat_Aux, ContGrupo, null_num ,MatAsim,Cupo,cve_profesor
 
HazRetrieve		=	Message.WordParm	
Columna			=	GetColumnName()
Accepttext()
 
If Columna = "cve_mat" Then	
	dwItemstatus status1	
 	status1 = GetItemstatus(GetRow(),"cve_mat", primary!)
	If status1 = datamodIfied! or status1 = NewmodIfied! or status1 = New! Then
		Materia_dw = Getitemnumber(GetRow(),"cve_mat")
		If Not Existe_Materia(Materia_dw) Then
			Return 1 // Rechaza el codigo y no deja cambiar de focus.  Pero si se teclea 2 tabs si cambia de focus, por esta razon se  hace el triggerevent a bloqueacampos.			      						
		End If
	End If	// status1 = datamodIfied!
End If	// Columna = "cve_mat"

If MateriaDeptoOK Then   // Inicio MateriaDeptoOK
	If HazRetrieve = 2  Then	// SignIfica que esté codigo fue llamdo desde los eventos primero anterior,siguiente,ultimo.
		Columna = "gpo"
		HazRetrieve = 0
	ElseIf status1 = datamodIfied! or status1 = NewmodIfied! Then
		Setitem(GetRow(),"gpo"," ")	
		setcolumn("gpo")
		Accepttext()
	End If 
	If cbx_nuevo.checked Then	//Revisa si se esta consultando o agregando un grupo
		If Columna = "gpo" Then
			Materia_dw = Getitemnumber(GetRow(),"cve_mat")
			Grupo_dw   = GetitemString(GetRow(),"gpo")
			Setitem(GetRow(),"periodo",periodo)
			Setitem(GetRow(),"anio",año)	
			If Existe_Grupo(Materia_dw,Grupo_dw,Cupo,cve_profesor) Then
				Messagebox("Aviso","Este grupo ya existe.")			 				
				sle_nombre_mat.text =""
				dw_mat.setredraw(False)
				dw_horario.reset()
				dw_titular.reset()
				dw_mat.reset()
				ScrollToRow(dw_mat.insertRow(0))	
				Setcolumn("cve_mat")
				cbx_nuevo.checked = False
				dw_mat.setredraw(True)
				Return 1
			Else	
				cve =	Getitemnumber(GetRow(),"cve_profesor")
		      If dw_titular.retrieve(cve) < 1  Then
					setitem(1,"cve_profesor",1)
					dw_titular.retrieve(1) 
			   End If 
 				dw_horario.retrieve(Materia_dw,Grupo_dw,periodo,año) 		
				dw_horario.SetSort("cve_dia A")
				dw_horario.Sort( )
				SetItem(GetRow(),"cond_gpo",1) // 1=Activo					 
				SetItem(GetRow(),"tipo",0) // 0=Normal					 
 				setcolumn("gpo")
				Return 0				 
	   	End If
		End If
	Else
		If Columna = "gpo" Then
			Materia_dw    = Getitemnumber(GetRow(),"cve_mat")
			Grupo_dw      = GetitemString(GetRow(),"gpo")
			dw_mat.setredraw(false)	
			If Retrieve(Materia_dw,Grupo_dw,Periodo,Año) > 0 Then
				dw_mat.setredraw(True)
				cve =	Getitemnumber(GetRow(),"cve_profesor")
		   	If dw_titular.retrieve(cve) < 1  Then
				   setitem(1,"cve_profesor",1)
				   dw_titular.retrieve(1) 
 				End If 			
				dw_horario.retrieve(Materia_dw,Grupo_dw,periodo,año)
				dw_horario.SetSort("cve_dia A")
				dw_horario.Sort( )
 				setcolumn("gpo")
				Return 0
			Else
				sle_nombre_mat.text =""
				dw_mat.setredraw(False)
				dw_horario.reset()
				dw_titular.reset()
				dw_mat.reset()
				ScrollToRow(dw_mat.insertRow(0))	
				Setcolumn("cve_mat")
				dw_mat.setredraw(True)
				Messagebox("Aviso", "Está materia no se imparte en el semestre indicado.",stopsign!)
			End If
		End If	
	End If

	If columna = "tipo" Then
		Cupo= 0
		IF cbx_nuevo.checked Then
			IF Getitemnumber(GetRow(),"tipo") = 0 or &
				Getitemnumber(GetRow(),"tipo") = 1 or &
				Getitemnumber(GetRow(),"tipo") = 3 Then // 0=Normal,1=Asesoria,3=Otro 
				SetNull(null_num)
				SetItem(GetRow(),"cve_asimilada",null_num)
				SetNull(null_string)
				SetItem(GetRow(),"gpo_asimilado",null_string)
				AcceptText()
				//st_cupo_asim2.x=691
				//st_cupo_asim2.Visible=False
				SetTabOrder("cupo",60)
				SetTabOrder("cve_profesor",70)
			Else
            //st_cupo_asim2.x=517
				//st_cupo_asim2.Visible=True														
				SetTabOrder("cupo",0)
				SetTabOrder("cve_profesor",0)
			End If
			Return 0
		Else
			Messagebox("Aviso","Si requiere cambiar el tipo de grupo, borre el grupo y genere un nuevo grupo")
         ReselectRow(GetRow())			
			Return 1
		End if	
			
  	ElseIf columna = "cve_asimilada" Then	
 		If GetItemNumber(GetRow(),"tipo") = 2 Then
			IF IsNull(GetItemNumber(GetRow(),"cve_asimilada")) Then
				Return 1
			ElseIf Not IsNull(GetItemString(GetRow(),"gpo_asimilado")) Then
				columna = "gpo_asimilado"
			End if	
	  	Else
			SetNull(null_num)
			SetItem(GetRow(),"cve_asimilada",null_num)
			SetNull(null_string)
			SetItem(GetRow(),"gpo_asimilado",null_string)
			Accepttext()
			Return 0
	  	End If	
		  
 	ElseIf columna = "gpo_asimilado" Then
		Materia_dw    = Getitemnumber(GetRow(),"cve_mat")
		Grupo_dw      = GetitemString(GetRow(),"gpo")
		If GetItemNumber(GetRow(),"tipo") = 2 Then
			MatAsim = GetItemNumber(GetRow(),"cve_asimilada")
			GpoAsim = GetItemString(GetRow(),"gpo_asimilado")
			If Materia_dw = MatAsim And Grupo_dw = GpoAsim Then
				Messagebox("Error","No se puede asimilar al mismo Grupo")
				SetColumn("cve_asimilada")
				Return 1
			Else
				If Existe_Grupo(MatAsim,GpoAsim,cupo,cve_profesor) Then
					If TieneMasHoras(MatAsim,Materia_dw) then
						//st_cupo_asim2.text = String(Cupo)
						SetItem(GetRow(),"cupo",integer(cupo))
						SetItem(GetRow(),"cve_profesor",integer(cve_profesor))
						Return 0
					else
						Messagebox("Error","El grupo al que se quiere asimilar tiene menos horas impartidas")
						Return 1	
					end if
				Else
					Messagebox("Error","El grupo al que se quiere asimilar no existe")
					Return 1
				End if				
			End if
		Else	
			SetNull(null_num)
			SetItem(GetRow(),"cve_asimilada",null_num)
			SetNull(null_string)
			SetItem(GetRow(),"gpo_asimilado",null_string)
			Accepttext()
			Return 0			
		End If		
		
 	ElseIf columna = "cupo" Then
		IF cbx_nuevo.checked Then
			IF IsNull(GetItemNumber(GetRow(),"cupo")) Then 
				SetItem(GetRow(),"Cupo",0)
			End if			
			Return 0
		Else
			If Messagebox("Aviso","Se cambiara el derecho y uso, si no está seguro de tener derecho para el nuevo cupo, revise el catalogo de derecho y uso.~nDesea Cambiar el cupo.",Question!,YesNo!,2) = 1 Then
				IF This.Event CambiaCupo() Then
					Return 0
				Else
					ReselectRow(GetRow())
 				End If
				Return 1 // Error No acepta el valor
			Else 
				ReselectRow(GetRow())
				Return 1
			End if			
		End If
	
	ElseIf columna = "cve_profesor" Then
		cve =	Getitemnumber(GetRow(),"cve_profesor")
 		If dw_titular.retrieve(cve) > 0 Then
 	 		Return 0
		Else
			setitem(1,"cve_profesor",1)
			dw_titular.retrieve(1) 
			Return 1			
	 	End If	
	End If
Else
	Return 1 // Rechaza el codigo y no deja cambiar de focus.  Pero si se tecla 2 tabs si cambia de focus, por esta razon se  hace el triggerevent a bloqueacampos.			      						End If // Fin MateriaDeptoOK
End If


end event

event dw_mat::actualiza;// Juan Campos.       	Octubre-1997.

// Variables para grupo
Boolean 	GruposOk = False
Integer	ExisteGrupo = 0, ExisteHorario = 0, MatDw,PerDw,AñoDw,CupoDw,TipoDw,CondGpo,CondGpo1,MatAsim,null_num,Cupo,cve_profesor
String	GpoDw, Salon, Salon_P, GpoAsim,null_string
char GpoDw1, gpoDw2

// Variables para horario
Integer 	HorasClase=0, ContHoras = 0 ,i,Renglon,Columna, Dia,HorIni,HorFin,Dia_p,HorIni_p,HorFin_p
Boolean	MovimientoOk = False, RengModificado = False, RengNuevo = False, HorarioOk= True,DerechoUsoOK
dwItemStatus status, StatusSalon
  
EstaVentana.setredraw(False) // No se reflejan  los cambios en la ventana. Está Función hace que las modIficaciones sean mas rapidas.
MatDw		= dw_mat.getitemnumber(dw_mat.GetRow(),"cve_mat")
GpoDw		= dw_mat.getitemstring(dw_mat.GetRow(),"gpo")
PerDw		= dw_mat.getitemnumber(dw_mat.GetRow(),"periodo")
AñoDw		= dw_mat.getitemnumber(dw_mat.GetRow(),"anio")
CupoDw	= dw_mat.getitemnumber(dw_mat.GetRow(),"cupo")
TipoDw	= dw_mat.getitemnumber(dw_mat.GetRow(),"tipo")
CondGpo1	= dw_mat.getitemnumber(dw_mat.GetRow(),"cond_gpo")
CondGpo	= dw_mat.getitemnumber(dw_mat.GetRow(),"cond_gpo",Primary!,True)

GpoDw = Trim(GpoDw)
GpoDw1 = mid(GpoDw,1,1)
GpoDw2 = mid(GpoDw,2,1)
if asc(GpoDw1)<65 OR asc(GpoDw1)>90 or &
((asc(GpoDw2)<65 OR asc(GpoDw2)>90)and(asc(GpoDw2)<48 OR asc(GpoDw2)>57)and asc(GpoDw2)<>0)then
	MessageBox("Error","El grupo debe empezar con una letra y seguir con una letra o número")
	Goto Actualiza
End If

dw_mat.SetItem(dw_mat.GetRow(),"gpo",GpoDw)

IF cbx_nuevo.checked and CondGpo = 0 Then // 0 = Cancelado
	MessageBox("Error","La condición del grupo no puede ser de: CANCELADO")
	Goto Actualiza
End If

If Tipodw = 2 Then // Asimilado
	MatAsim = GetItemNumber(GetRow(),"cve_asimilada")
	GpoAsim = GetItemString(GetRow(),"gpo_asimilado")
	if Matdw = MatAsim And Gpodw = GpoAsim Then
		Messagebox("Error","No se puede asimilar al mismo Grupo") 
     Goto Actualiza	
	End if
	If Not Existe_Grupo(MatAsim,GpoAsim,Cupo,cve_profesor) Then
		Messagebox("Error","La materia asimilada no existe")
		Goto Actualiza	
 	End if
Else
	SetNull(null_num)
	SetItem(GetRow(),"cve_asimilada",null_num)
	SetNull(null_string)
	SetItem(GetRow(),"gpo_asimilado",null_string)
	AcceptText()
End if

If (Tipodw = 1 or TipoDw = 2) And dw_horario.RowCount() > 0 Then // 1=Asesoria 2=Asimilado
	MessageBox("Error","El tipo de grupo Asesoría o Asimilado, no puede tener asociado un horario")
	Goto Actualiza
End if
	

 	
If dw_mat.modIfiedcount() > 0 Then
	dw_mat.SetItem(dw_mat.GetRow(),"cve_mat_gpo",String(MatDw)+GpoDw)
	If dw_mat.Update(True,False) = 1 Then	
		GruposOk = True 
	Else 
		Messagebox("Error","Algunos datos son incorrectos, favor de verificar los datos")
		Goto Actualiza
	End If
Else // Si no hay modIficaciones en el dw_mat, se consulta si existe el grupo en la base de datos	  
	Select count(*)
	Into	:ExisteGrupo
	From	grupos
	Where	(cve_mat = :MatDw ) And (gpo = :GpoDw ) And (periodo = :PerDw ) And (anio = :AñoDw) using gtr_sce;
	If ExisteGrupo > 0 Then
		GruposOk = True 
	Else		
		MessageBox("Error","No existe esté grupo, favor de verificar los datos.")
		Goto Actualiza
	End If
End If

If GruposOk  Then	 	
	If	dw_horario.modIfiedcount() > 0 or dw_horario.DeletedCount( ) > 0 Then
 		If dw_horario.Accepttext() = 1 Then
			Ajusta_Cupo(CupoDw)
			For Renglon = 1 To dw_horario.RowCount()
				Dia	= dw_horario.GetItemNumber(Renglon,"cve_dia")
				HorIni= dw_horario.GetItemNumber(Renglon,"hora_inicio")
				HorFin= dw_horario.GetItemNumber(Renglon,"hora_final")
				Salon = dw_horario.GetItemString(Renglon,"cve_salon")		
				Status = dw_horario.GetItemStatus(Renglon,0, Primary!)
				If Status = NewModIfied! or CondGpo = 0 Then // 0=Cancelado
				 	RengNuevo = True
					If dw_horario.GetItemNumber(Renglon,"clase_aula") = 0 Then // 0= Salon
						If Incrementa_Derecho_y_uso(MatDw,Dia,HorIni,HorFin,CupoDw) Then
							DerechoUsoOK = True		
						Else
							DerechoUsoOK = False	
							HorarioOk = False
						End if							
					Else
						DerechoUsoOK = True		
					End if
					// Inicio Ocupa y  salon
					If DerechoUsoOK Then
						If Not isNull(Salon) Then
							If Existe_salon(Salon) Then	
								If Salon_Libre_dse(Salon,Dia,HorIni,HorFin) Then					 
									If Ocupa_salon(Salon,Dia,HorIni,HorFin) Then					
										DerechoUsoOK = True
									Else
										DerechoUsoOK = False	
										HorarioOk = False								
 									End IF
								Else
									DerechoUsoOK = False	
									HorarioOk = False
								End IF
							Else
								DerechoUsoOK = False	
								HorarioOk = False
							End IF
						End if
					End if					
					// Final Ocupa y  salon
					
				Else // Status del renglon 	
					For Columna = 1 to 9
						Status = dw_horario.GetItemStatus(Renglon,Columna, Primary!)
 						If Status = DataModIfied! Then // Si se modifico alguna columna se  con los datos primarios y Incrementa con los datos de filtro				                           
							RengModificado = True
 						End IF
					Next // Columna
					If RengModificado Then
						If dw_horario.GetItemNumber(Renglon,"clase_aula",primary!,True) = 0 Then // 0= Salon
            			Dia_p		= dw_horario.GetitemNumber(Renglon,"cve_dia", primary!,True) 
							HorIni_P	= dw_horario.Getitemnumber(Renglon,"hora_inicio", primary!,True)
							HorFin_p	= dw_horario.Getitemnumber(Renglon,"hora_final", primary!,True)
							Salon_p 	= dw_horario.Getitemstring(Renglon,"cve_salon", primary!,True)
				   		if Decrementa_Derecho_y_uso(MatDw,Dia_p,HorIni_p,HorFin_p,CupoDw) Then
								DerechoUsoOK = True
							Else
								DerechoUsoOK = False
								HorarioOk = False
							End If
						Else
							DerechoUsoOK = True	
						End If // Clase_aula salon, Buffer primario																	
						If DerechoUsoOK Then
							IF dw_horario.GetItemNumber(Renglon,"clase_aula") = 0 Then // 0= Salon
 								if Incrementa_Derecho_y_uso(MatDw,Dia,HorIni,HorFin,CupoDw) Then
									DerechoUsoOK = True	
								Else
									DerechoUsoOK = False
									HorarioOk = False
								End if
							Else
								DerechoUsoOK = True // Si la Clase de aula no es de tipo salón, No incrementa derecho y uso
							End If
						Else
							DerechoUsoOK = False
							HorarioOk = False
							MessageBox("Error","Al actualizar derecho y uso")
						End If  // Clase_aula salon, Buffer actual
						
						// Inicio Ocupa y desocupa salon
//						StatusSalon = dw_horario.GetItemStatus(Renglon,"cve_salon", Primary!)
						If DerechoUsoOK Then
//							If StatusSalon = DataModIfied! Then
							If Not isNull(Salon) Then
								If Existe_salon(Salon) Then	
									If Salon_Libre_dse(Salon,Dia,HorIni,HorFin) Then					 
										if DesOcupa_salon(Salon_p,Dia_p,HorIni_p,HorFin_p) Then					
											If Ocupa_salon(Salon,Dia,HorIni,HorFin) Then					
												DerechoUsoOK = True
											Else
												DerechoUsoOK = False	
												HorarioOk = False								
 											End IF
										Else
											DerechoUsoOK = False	
											HorarioOk = False																			
										End If
									Else
										DerechoUsoOK = False	
										HorarioOk = False
									End IF
								Else
									DerechoUsoOK = False	
									HorarioOk = False
								End IF
							End if
						End if
						// Final Ocupa y desocupa salon
						
					End If // Renglon Modificado
				End IF // Status del renglon 	
				If (RengModificado or RengNuevo) And DerechoUsoOK Then
					dw_horario.SetItem(Renglon,"cve_mat",MatDw) 
					dw_horario.SetItem(Renglon,"gpo", GpoDw)
					dw_horario.SetItem(Renglon,"periodo",PerDw)
					dw_horario.SetItem(Renglon,"anio",AñoDw)
				End If
				RengModificado = False
				RengNuevo = False		  												
			Next // Renglon
			If HorarioOk Then
				If TipoDw = 0 or TipoDw = 3 Then // 0=Normal, 3=Otro
 					If dw_horario.Update(True,True) = 1 Then	
						HorarioOk = True
					Else
						HorarioOk = False
						MessageBox("Error","Algunos datos son incorrectos.~nFavor de verificar los datos")
					End If // dw_horario.Update Normal,Otro
				ElseIF TipoDw = 1 or TipoDw = 2  Then // 1=Asesoria, 2=Asimilado
					If dw_horario.RowCount() = 0 And dw_horario.Update(True,True) = 1 Then	
						HorarioOk = True
					Else
						HorarioOk = False
						MessageBox("Error","Algunos datos son incorrectos.~nFavor de verificar los datos")
					End If // dw_horario.Update Asesoria,Asimilado					
				End If // TipoDw 
			End If // Horario ok		
		Else 
			Messagebox("Error","Algunos datos son incorrectos.~nFavor de verificar los datos")
			HorarioOk = False		
		End If // dw_horario.Accepttext() 
	Else // Si no hay modIficaciones en el dw_horario, se consulta si existe un horario para un grupo de tipo normal en la base de datos	  		
		If TipoDw = 0 Then // 0=Normal 
 			Select count(*)
			Into	:ExisteHorario
			From	horario
			Where	(cve_mat = :MatDw ) And (gpo = :GpoDw ) And (periodo = :PerDw ) And (anio = :AñoDw) using gtr_sce;
			If ExisteHorario > 0 Then
				HorarioOk = True
			Else
				HorarioOk = False
				MessageBox("Error","No existe un horario para esté grupo")
			End If // ExisteHorario
		ElseIf (TipoDw = 1 or TipoDw = 2) And dw_horario.RowCount() > 0 Then // 1=Asesoria, 2=Asimilado
			HorarioOk = False		
			MessageBox("Error","El tipo de grupo Asesoría o Asimilado, no puede tener asociado un horario")			
		End If // TipoDw
	End if // dw_horario.modIfiedcount()
End If // GruposOk

// revisar ultima domificacion 20-Marzo-1998 juan campos
//******************************************************
If HorarioOk Then
	For I= 1 To  dw_horario.Rowcount()
		ContHoras =	ContHoras + (dw_horario.GetItemNumber(I,"hora_final") - &
													 dw_horario.GetItemNumber(i,"hora_inicio"))				
	Next				
	If TipoDw = 0 or TipoDw = 3 Then // 0=Normal, 3=Otro
		If horas_materia(Matdw,Periodo,HorasClase) Then
			IF (ContHoras = HorasClase) or Not ChecharHoras Then
				If dw_horario.Update(True,True) = 1 Then	
					HorarioOk = True
				Else
					HorarioOk = False
					MessageBox("Error","Algunos datos son incorrectos.~nFavor de verificar los datos.")
				End If // dw_horario.Update Normal,Otro
			Elseif ContHoras > HorasClase Then				
				IF Messagebox("Aviso","El total de horas asignadas es mayor a el total de horas para esté Periodo.~nHoras Asignadas = "+string(ContHoras)+"~nTotal de horas para esté Periodo = "+string(horasclase)+"~nDeseas Continuar",Question!,YesNO!,2) = 1 Then
					HorarioOk = True
				Else
					HorarioOk = False
				End IF	
			Elseif ContHoras < HorasClase Then	
				HorarioOk = False					
				IF Messagebox("Aviso","El total de horas asignadas es menor a el total de horas para esté Periodo.~nHoras Asignadas = "+string(ContHoras)+"~nTotal de horas para esté Periodo = "+string(horasclase)+"~nDeseas Continuar",Question!,YesNO!,2) = 1 Then
					HorarioOk = True
				Else
					HorarioOk = False
				End IF	
			End If // Cont_horas 			
		Else
			Messagebox("Error","Al consultar horas materia para esté periodo")
		End If // Funcion Horas_materia
	ElseIF TipoDw = 1 or TipoDw = 2  Then // 1=Asesoria, 2=Asimilado
		If dw_horario.RowCount() = 0 And dw_horario.Update(True,False) = 1 Then	
			HorarioOk = True
		Else
			HorarioOk = False
			MessageBox("Error","Algunos datos son incorrectos.~nFavor de verificar los datos.")
		End If // dw_horario.Update Asesoria,Asimilado					
	End If // TipoDw 
End If // Horario ok		
//******************************************************

Actualiza:

If GruposOk And HorarioOk Then
	dw_mat.resetupdate()
	dw_horario.resetupdate()
	Commit using gtr_sce;
	sle_nombre_mat.text = ""
	//st_cupo_asim2.x=691
	//st_cupo_asim2.Visible=False
	MessageBox("Aviso","Se guardaron los cambios")
	dw_mat.retrieve(MatDw,GpoDw,PerDw,AñoDw)
	dw_horario.retrieve(MatDw,GpoDw,PerDw,AñoDw) 
   dw_horario.SetSort("cve_dia A")
	dw_horario.Sort( )
	cbx_nuevo.checked = False
	EstaVentana.setredraw(True) 
	Return True // Evento actualiza
Else
	Rollback using gtr_sce;
	if Not cbx_nuevo.checked Then // No es un grupo nuevo
		dw_mat.retrieve(MatDw,GpoDw,PerDw,AñoDw)
  		dw_horario.retrieve(MatDw,GpoDw,PerDw,AñoDw)
	End IF
	MessageBox("Aviso","No se guardaron los cambios",stopsign!)
	EstaVentana.setredraw(True) 
	Return False // Evento actualiza
End If

end event

event dw_mat::borrahorario;// Juan Campos        Octubre-1997.

String	DiaStr,Grupo, Salon
Integer	Dia,HoraIni,HoraFin,ExisteHorario = 0,Clave,CupoGrupo,ClaseAula,Columna
Boolean	CambiosOk = True, RengModificado= False
dwItemStatus Status				
   	
IF dw_horario.RowCount() > 0 Then	
	Status = dw_horario.GetItemStatus(GetRow(),0, Primary!)				
	If Status = NewModIfied! Then
		dw_horario.deleterow(dw_horario.getrow())
		Return		
	Else
 		Clave 	= dw_mat.getitemnumber(dw_mat.GetRow(),"cve_mat",Primary!,True)
		Grupo 	= dw_mat.getitemstring(dw_mat.GetRow(),"gpo",Primary!,True)	
		Dia     	= dw_horario.GetItemNumber(dw_horario.getrow(),"cve_dia",Primary!,True)
		DiaStr	= dia_string(Dia)		
 		horaini	= dw_horario.GetItemNumber(dw_horario.getrow(),"hora_inicio",Primary!,True)
		horafin	= dw_horario.GetItemNumber(dw_horario.getrow(),"hora_final",Primary!,True)
		ClaseAula= dw_horario.GetItemNumber(dw_horario.getrow(),"clase_aula",Primary!,True)
		Salon		= dw_horario.GetItemString(dw_horario.getrow(),"cve_salon",Primary!,True)
 		IF Messagebox("Aviso","Está seguro que desea borrar esté horario.~n Dia "+DiaStr+" hora_inicio "+string(horaini)+" hora_final "+string(horafin),Question!,YesNo!,2) = 1 Then 
         If ClaseAula = 0 Then // 0=Salon
				CupoGrupo = dw_mat.getitemNumber(dw_mat.GetRow(),"cupo")	
 				Ajusta_Cupo(CupoGrupo)
				If Decrementa_Derecho_y_Uso(Clave,Dia,HoraIni,HoraFin,CupoGrupo) then
					CambiosOk = True
				Else
					CambiosOk = False
				End if					
			Else
				CambiosOk = True
			End if
 
			If CambiosOK Then
				If Not isNull(Salon) Then
					If Existe_salon(Salon) Then	
						if DesOcupa_salon(Salon,Dia,HoraIni,HoraFin) Then					
							CambiosOK = True
						Else
							CambiosOK = False	
 						End IF
					Else
						CambiosOK = False
					End IF
 				End IF
			End if
	
			if CambiosOk Then
				IF dw_horario.DeleteRow(dw_horario.getrow()) = 1 Then
            	TriggerEvent("Actualiza")
					Return	
				Else
					CambiosOk = False
				End If 				
 			End if
 		End IF // Messagebox
	End IF
Else
	CambiosOk = False
	Messagebox("Error","No hay un horario para borrar")
	Return
End IF // dw_horario.RowCount()
	
If Not CambiosOk Then
	Rollback Using gtr_sce;
	Messagebox("Aviso","El horario no fue borrado")	
	dw_horario.retrieve(clave,Grupo,periodo,año) 					
End If
end event

event dw_mat::borratodohorario;//  Juan Campos        Octubre-1997.

String	DiaStr,Grupo,Salon
Integer	Dia,HoraIni,HoraFin,ExisteHorario = 0,Clave,CupoGrupo,RenHor,RenTodos,ClaseAula
Boolean	CambiosOk = True

dwItemStatus Status				
   		
IF dw_horario.RowCount() > 0 Then	
	CupoGrupo 	= dw_mat.GetItemNumber(dw_mat.GetRow(),"cupo")	
	Clave			= dw_mat.GetItemnumber(dw_mat.GetRow(),"cve_mat")
	Grupo			= dw_mat.GetItemstring(dw_mat.GetRow(),"gpo")	
	RenTodos 	= dw_horario.RowCount() 		
	Ajusta_Cupo(CupoGrupo)
	For RenHor = 1 To RenTodos
		Status = dw_horario.GetItemStatus(RenHor,0, Primary!)						
		If Status = NewModIfied! Then
			If dw_horario.DeleteRow(0) <> 1 Then			
				CambiosOk = False
				Goto Fin				
			End IF			 
		Else	
			ClaseAula= dw_horario.GetItemNumber(dw_horario.GetRow(),"clase_aula",Primary!,True)
			Dia     	= dw_horario.GetItemNumber(dw_horario.GetRow(),"cve_dia",Primary!,True)
 			horaini	= dw_horario.GetItemNumber(dw_horario.GetRow(),"hora_inicio",Primary!,True)
			horafin	= dw_horario.GetItemNumber(dw_horario.GetRow(),"hora_final",Primary!,True)
			Salon    = dw_horario.GetItemString(dw_horario.GetRow(),"cve_salon",Primary!,True)
			ExisteHorario = 0
			
			If Not isNull(Salon) Then
				If Existe_salon(Salon) Then	
					If DesOcupa_salon(Salon,Dia,HoraIni,HoraFin) Then					
						CambiosOK = True
					Else
						CambiosOK = False	
 					End IF
				Else
					CambiosOK = False
				End IF
 			End IF
			
			if CambiosOK Then
				If ClaseAula = 0 Then // 0=Salon
		 			If Not Decrementa_Derecho_y_Uso(Clave,Dia,HoraIni,HoraFin,CupoGrupo) Then
						CambiosOk = False
						Goto Fin
					Else
						If dw_horario.DeleteRow(0) <> 1 Then			
							CambiosOk = False
							Goto Fin				
						End IF
										
					End if
				Else
					If dw_horario.DeleteRow(0) <> 1 Then			
						CambiosOk = False
						Goto Fin				
					End IF
				End IF
			Else
				CambiosOk = False
				Goto Fin								
			End if
		End if	
	Next
Else
	CambiosOk = False
	Goto Fin	
End IF // dw_horario.RowCount()
	
Fin:	
	If CambiosOk Then
		ChecharHoras = False
		TriggerEvent("actualiza")
		ChecharHoras = True
		Return True
	Else
		Rollback Using gtr_sce;
		Messagebox("Aviso","El horario no fue borrado")	
		dw_horario.retrieve(clave,Grupo,periodo,año) 					
		Return False
	End If
	
				
end event

event dw_mat::borrasalon;// Juan Campos Sánchez.	Mayo-1998.
// Borra el salón de la tabla horario y desocupa el salón 
// en la tabla salon_horario
 
String	StrNull,Salon_p
Integer	Dia_p,HorIni_p,HorFin_p, NextRow
dwItemStatus	Status

NextRow = dw_horario.GetRow() +1
Status = dw_horario.GetItemStatus(dw_horario.GetRow(),0, Primary!)
If Status = NewModIfied! Then
	SetNull(StrNull)
	dw_horario.SetItem(dw_horario.GetRow(),"cve_salon",StrNull)
	dw_horario.Accepttext()	
Else
	Dia_p		=	dw_horario.GetItemNumber(dw_horario.GetRow(),"cve_dia",Primary!,True)	
	HorIni_p	=	dw_horario.GetItemNumber(dw_horario.GetRow(),"hora_inicio",Primary!,True)
	HorFin_p	=	dw_horario.GetItemNumber(dw_horario.GetRow(),"hora_final",Primary!,True)
	Salon_p	=	dw_horario.GetItemString(dw_horario.GetRow(),"cve_salon",Primary!,True)	
	dw_horario.SetRedraw(False)
	dw_horario.ReselectRow(dw_horario.GetRow())
	dw_horario.SetRedraw(True)
	If Existe_salon(Salon_p) Then	
		If DesOcupa_salon(Salon_p,Dia_p,HorIni_p,HorFin_p) Then
			SetNull(StrNull)
			dw_horario.SetItem(dw_horario.GetRow(),"cve_salon",StrNull)
			dw_horario.Accepttext()
			dw_mat.Event Actualiza()
			dw_horario.SetRedraw(False)
			dw_horario.SetRow(NextRow)
			dw_horario.SetRedraw(True)
		Else
			dw_horario.ReselectRow(dw_horario.GetRow())
			Messagebox("Aviso","Los cambios no se guardaron")
		End if
	Else
		dw_horario.ReselectRow(dw_horario.GetRow())
		Messagebox("Aviso","Los cambios no se guardaron")
	End if	
End IF

dw_horario.SetColumn("cve_salon")


 

  
end event

type tab_disponibles from tab within w_grupos_impartidos_dse
int X=1189
int Y=416
int Width=1814
int Height=883
int TabOrder=20
string Tag=" "
boolean BringToTop=true
boolean RaggedRight=true
boolean BoldSelectedText=true
int SelectedTab=1
TabPosition TabPosition=TabsOnLeft!
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
end type

on tab_disponibles.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_disponibles.destroy
destroy(this.tabpage_1)
end on

event clicked;// Juan Campos.           Octubre de 1997.

Integer Cupo 

IF dw_horario.RowCount() > 0 Then 
	dw_horario.Accepttext()
	dw_mat.enabled = False
	dw_horario.enabled = False
	dw_titular.enabled = False
	sle_nombre_mat.enabled = False
	dw_nombre_mat.enabled = False
	Tabpage_1.em_horini.text = String(dw_horario.GetItemNumber(dw_horario.GetRow(),"hora_inicio"))
	Tabpage_1.em_horfin.text = String(dw_horario.GetItemNumber(dw_horario.GetRow(),"hora_final"))
   Tabpage_1.ddlb_dia.text  = Dia_String(dw_horario.GetItemNumber(dw_horario.GetRow(),"cve_dia"))
   Cupo = dw_mat.GetItemNumber(dw_mat.GetRow(),"cupo") 
	Ajusta_Cupo(Cupo)
	Tabpage_1.ddlb_cupo.text = String(Cupo) 	
	Tab_disponibles.x = 1189
	Tab_disponibles.y = 417
	Tab_disponibles.width = 2227
	Tab_disponibles.height = 885
	Tabpage_1.cb_versalones.SetFocus()
End If	

end event

type tabpage_1 from userobject within tab_disponibles
int X=113
int Y=13
int Width=1686
int Height=858
long BackColor=79741120
string Text="Salones Disponibles"
long TabBackColor=8388608
long TabTextColor=16777215
long PictureMaskColor=8388608
string PictureName="Custom033!"
dw_disp dw_disp
ddlb_dia ddlb_dia
ddlb_cupo ddlb_cupo
em_horini em_horini
em_horfin em_horfin
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
cb_versalones cb_versalones
cb_cerrar cb_cerrar
end type

on tabpage_1.create
this.dw_disp=create dw_disp
this.ddlb_dia=create ddlb_dia
this.ddlb_cupo=create ddlb_cupo
this.em_horini=create em_horini
this.em_horfin=create em_horfin
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.cb_versalones=create cb_versalones
this.cb_cerrar=create cb_cerrar
this.Control[]={this.dw_disp,&
this.ddlb_dia,&
this.ddlb_cupo,&
this.em_horini,&
this.em_horfin,&
this.st_1,&
this.st_2,&
this.st_3,&
this.st_4,&
this.cb_versalones,&
this.cb_cerrar}
end on

on tabpage_1.destroy
destroy(this.dw_disp)
destroy(this.ddlb_dia)
destroy(this.ddlb_cupo)
destroy(this.em_horini)
destroy(this.em_horfin)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_versalones)
destroy(this.cb_cerrar)
end on

type dw_disp from datawindow within tabpage_1
int X=823
int Width=1258
int Height=848
int TabOrder=70
boolean BringToTop=true
string DataObject="dw_aula_libre"
boolean TitleBar=true
string Title="SALONES DISPONIBLES"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;This.x = 823
This.y = 1
This.width = 1258
This.height = 849
end event

type ddlb_dia from dropdownlistbox within tabpage_1
int X=336
int Y=272
int Width=479
int Height=227
int TabOrder=30
boolean BringToTop=true
string Text="LUNES"
boolean Sorted=false
int Limit=6
long BackColor=15793151
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"LUNES",&
"MARTES",&
"MIERCOLES",&
"JUEVES",&
"VIERNES",&
"SABADO"}
end type

type ddlb_cupo from dropdownlistbox within tabpage_1
int X=625
int Y=381
int Width=194
int Height=227
int TabOrder=40
boolean BringToTop=true
string Text="0"
boolean Sorted=false
int Limit=3
long BackColor=15793151
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"20",&
"40",&
"60",&
"80"}
end type

type em_horini from editmask within tabpage_1
int X=336
int Y=48
int Width=121
int Height=90
int TabOrder=10
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="##"
string DisplayData="ˆ"
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;//If Integer(em_horini.text) < 7 or  Integer(em_horini.text) > 21 Then
//	Undo()
//End If
//	
end event

type em_horfin from editmask within tabpage_1
int X=336
int Y=157
int Width=121
int Height=90
int TabOrder=20
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="##"
string DisplayData="Ä"
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;//If Integer(em_horfin.text) < 8 or &
//   Integer(em_horfin.text) > 22 or &
//	Integer(em_horfin.text) < Integer(em_horini.text) Then 
//	Undo()
//End If
end event

type st_1 from statictext within tabpage_1
int X=18
int Y=58
int Width=311
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Hora Inicio:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tabpage_1
int X=18
int Y=163
int Width=311
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Hora Final:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_1
int X=18
int Y=272
int Width=311
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Día:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within tabpage_1
int X=18
int Y=381
int Width=600
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Cupo Grupo Ajustado:"
boolean FocusRectangle=false
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_versalones from commandbutton within tabpage_1
int X=18
int Y=621
int Width=380
int Height=109
int TabOrder=50
boolean BringToTop=true
string Text="Ver Salones"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Juan campos.	Noviembre-1997.

Integer HorIni,HorFin,Dia,Cupo

HorIni 	=  Integer(em_horini.text)
HorFin 	=  Integer(em_horfin.text)
Dia 		=  Dia_Integer(ddlb_dia.text)
Cupo     =  Integer(ddlb_cupo.text)

HorFin 	= HorFin -1
	
dw_disp.settransobject(gtr_sce)
If dw_disp.Retrieve(HorIni,HorFin,Dia,Cupo) = 0 Then
	Messagebox("No hay salones disponibles","Intente con con otros datos")
End If
 
end event

type cb_cerrar from commandbutton within tabpage_1
int X=494
int Y=621
int Width=249
int Height=109
int TabOrder=60
boolean BringToTop=true
string Text="Cerrar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_disp.Reset()
Tab_disponibles.x = 1189
Tab_disponibles.y = 413
Tab_disponibles.width = 138	
Tab_disponibles.height = 649	
dw_mat.enabled = True
dw_horario.enabled = True
dw_titular.enabled = True
sle_nombre_mat.enabled = True
 
end event

type cbx_serviciosescolares from checkbox within w_grupos_impartidos_dse
int X=2651
int Y=26
int Width=662
int Height=77
boolean BringToTop=true
string Text="Servicios Escolares"
BorderStyle BorderStyle=StyleRaised!
boolean LeftText=true
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rr_2 from roundrectangle within w_grupos_impartidos_dse
int X=1986
int Y=122
int Width=581
int Height=96
boolean Enabled=false
int LineThickness=3
int CornerHeight=42
int CornerWidth=40
long LineColor=8388608
long FillColor=16777215
end type

type rr_3 from roundrectangle within w_grupos_impartidos_dse
int X=1840
int Y=112
int Width=581
int Height=96
boolean Enabled=false
int LineThickness=3
int CornerHeight=42
int CornerWidth=40
long LineColor=8388608
long FillColor=16777215
end type

type rr_4 from roundrectangle within w_grupos_impartidos_dse
int X=1785
int Y=16
int Width=1671
int Height=96
boolean Enabled=false
int LineThickness=3
int CornerHeight=42
int CornerWidth=40
long LineColor=16777215
long FillColor=8388608
end type

type st_5 from statictext within w_grupos_impartidos_dse
int X=1796
int Y=26
int Width=863
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Descontar derecho y uso a:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_1 from uo_per_ani within w_grupos_impartidos_dse
int X=2245
int Y=1658
int TabOrder=70
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_1 from commandbutton within w_grupos_impartidos_dse
int X=1631
int Y=1683
int Width=519
int Height=109
int TabOrder=62
boolean BringToTop=true
string Text="Actualiza Periodo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_mat.Reset()
año = gi_anio
periodo = gi_periodo
choose case periodo
	case 0
		st_periodo.text = "PRIMAVERA " + String(año)
	case 1
		st_periodo.text = "VERANO " + String(año)
	case 2
		st_periodo.text = "OTOÑO " + String(año)
end choose
end event

