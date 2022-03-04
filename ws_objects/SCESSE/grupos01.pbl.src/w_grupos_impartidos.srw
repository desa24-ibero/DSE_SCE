$PBExportHeader$w_grupos_impartidos.srw
forward
global type w_grupos_impartidos from Window
end type
type st_cupo_asim2 from statictext within w_grupos_impartidos
end type
type dw_prof_adj from datawindow within w_grupos_impartidos
end type
type st_periodo from statictext within w_grupos_impartidos
end type
type cbx_nuevo from checkbox within w_grupos_impartidos
end type
type r_1 from rectangle within w_grupos_impartidos
end type
type sle_nombre_mat from singlelineedit within w_grupos_impartidos
end type
type dw_nombre_mat from datawindow within w_grupos_impartidos
end type
type dw_horario from datawindow within w_grupos_impartidos
end type
type dw_titular from datawindow within w_grupos_impartidos
end type
type dw_mat from datawindow within w_grupos_impartidos
end type
end forward

shared variables
 
end variables

global type w_grupos_impartidos from Window
int X=5
int Y=4
int Width=3584
int Height=1900
boolean TitleBar=true
string Title="Grupos impartidos en el semestre."
string MenuName="m_gpo_imp"
long BackColor=27291696
boolean HScrollBar=true
boolean VScrollBar=true
WindowState WindowState=maximized!
st_cupo_asim2 st_cupo_asim2
dw_prof_adj dw_prof_adj
st_periodo st_periodo
cbx_nuevo cbx_nuevo
r_1 r_1
sle_nombre_mat sle_nombre_mat
dw_nombre_mat dw_nombre_mat
dw_horario dw_horario
dw_titular dw_titular
dw_mat dw_mat
end type
global w_grupos_impartidos w_grupos_impartidos

type variables
Boolean    MateriaDeptoOK = False
Boolean    ChecharHoras = True
Integer      Periodo
Integer      Ocupado,Indice,  RengSalonHorario
long           Año
Window   EstaVentana
Integer lose =0
end variables

forward prototypes
public function string sigla_depto (ref string sigla)
public function boolean pertenece_mat_a_depto (long materia)
public function boolean decrementa_derecho_y_uso (integer materia, integer dia, integer hor_ini, integer hor_fin, integer cupo)
public function boolean incrementa_derecho_y_uso (integer materia, integer dia, integer hor_ini, integer hor_fin, integer cupo)
public subroutine periodo_alta_grupos (ref integer pergrupos, ref long añogrupos)
public function boolean tienemashoras (integer matp, integer math)
public function boolean existe_grupo (integer materia, string grupo, ref integer cupo, ref integer cve_profesor)
end prototypes

public function string sigla_depto (ref string sigla);// Juan Campos Sánchez. Octubre -1997.

Integer I
String  SiglaAux = ""
Char    Car
For I = 1 To Len(sigla)
	Car = Mid(Sigla,I,1)
 	If Car = "A" or Car = "B" or Car = "C" or Car = "D" or Car = "E" or &
    	Car = "F" or Car = "G" or Car = "H" or Car = "I" or Car = "J" or &
	 	Car = "K" or Car = "L" or Car = "M" or Car = "N" or Car = "O" or &
    	Car = "P" or Car = "Q" or Car = "R" or Car = "S" or Car = "T" or &
	 	Car = "V" or Car = "W" or Car = "X" or Car = "Y" or Car = "Z" Then 
		SiglaAux = SiglaAux + Car
	End If
Next 

Return SiglaAux
end function

public function boolean pertenece_mat_a_depto (long materia);// Regresa True si la materia le pertenece a al depto.
// Juan Campos. 		Octubre-1997.
// Modificacion Fantine Medina Carrillo  Septiembre 1998



//String	MatSigla,UsuarioSigla
//Integer	NumeroDepto = 0

Int	li_cve_coordinacion
string ls_user_id, ls_log_id
		
ls_log_id = Upper(gtr_sce.logid) // Usuario = sigla del depto. 									 

//If Mid(UsuarioSigla,2,1) = "_" Then
//	UsuarioSigla = Replace(UsuarioSigla, 2, 1, "-")
//End if
//
//Select cve_depto,materia  
//Into 	:NumeroDepto,:sle_nombre_mat.text
//From	materias  
//Where	materias.cve_mat = :Materia using gtr_sce;

Select cve_coordinacion,materia  
Into 	:li_cve_coordinacion,:sle_nombre_mat.text
From	materias  
Where	materias.cve_mat = :Materia using gtr_sce;


			
If gtr_sce.sqlcode = 100  Then
	MessageBox("Aviso","La Materia   No Existe")
	Goto Materia_false
Elseif li_cve_coordinacion <> 0 Then
	Select user_id
		Into :ls_user_id
		From coordinaciones 
		Where	cve_coordinacion = :li_cve_coordinacion using gtr_sce;
	If gtr_sce.sqlcode = 100  Then
		MessageBox("Aviso","La Coordinación No Existe")
		Goto Materia_false
	ElseIf gtr_sce.sqlcode = -1 Then
		MessageBox("Error al consultar la tabla de coordinaciones",gtr_sce.sqlerrtext)
	End IF
ElseIf gtr_sce.sqlcode = -1 Then
	MessageBox("Error al consultar la tabla de materias",gtr_sce.sqlerrtext)
	Goto Materia_false
End If

// Cambiar la sig linea, si la sigla se toma de materias 	
//	If sigla_depto(MatSigla) = UsuarioSigla Then

If ls_user_id = ls_log_id Then	// La sigla se toma de departamentos
	EstaVentana.setredraw(False)	
	dw_horario.reset()
	dw_titular.reset()
	dw_mat.Reset()
	dw_mat.ScrollToRow(dw_mat.insertrow(0))		
	dw_mat.EVENT desbloqueacampos()
	MateriaDeptoOK = True
	dw_mat.Setitem(dw_mat.GetRow(),"cve_mat",Materia)
	dw_mat.AcceptText( )
	EstaVentana.setredraw(True)									  
	Return True
Else
	MessageBox("Aviso","La materia  no le pertenece a esta coordinación") 	
	Goto Materia_false
End If	//  UsuarioSigla 	

Materia_False:
	EstaVentana.setredraw(False)	
	dw_horario.reset()
	dw_titular.reset()
	dw_mat.Reset()
	dw_mat.ScrollToRow(dw_mat.insertrow(0))	
	dw_mat.EVENT bloqueacampos()
	MateriaDeptoOK = False
	sle_nombre_mat.text= ""
	dw_mat.setfocus()
	EstaVentana.setredraw(True)									  
	Return False


end function

public function boolean decrementa_derecho_y_uso (integer materia, integer dia, integer hor_ini, integer hor_fin, integer cupo);// Regresa True si se decremento en uno, el campo de ocupados de la tabla de salones_derecho_uso
// Juan Campos.     Junio-1997.
  
Integer Depto=0,DIferencia,hora_inicio_sdu,siclo
Boolean ConsultaDepto = False

IF Isvalid(w_grupos_impartidos_dse) Then
	If w_grupos_impartidos_dse.cbx_ServiciosEscolares.Checked Then
		Depto = 7300 // Servicios Escolares
	Else
		ConsultaDepto = True
 	End IF
Else
	ConsultaDepto = True
End If	
If ConsultaDepto Then
	Select cve_coordinacion
	Into 	:depto
	From 	materias
	Where	cve_mat = :Materia using gtr_sce;
	If gtr_sce.sqlcode <> 0 Then 
		Messagebox("Error al consultar la coordinacion",gtr_sce.sqlerrtext)
   	Return False
	End if
End If
If gtr_sce.sqlcode = 0 or Depto = 7300 Then	
	If hor_fin > hor_ini Then
		DIferencia = hor_fin - hor_ini
		hora_inicio_sdu = hor_ini
		FOR siclo=1 TO DIferencia
			Update salones_derecho_uso
			Set ocupados = ocupados - 1 // decrementa uno en el campo de ocupados 
			Where (cve_coordinacion	= :depto) and (cve_dia	= :Dia) and
					(hora_inicio = :Hora_inicio_sdu) and(cupo	= :cupo) and
					(ocupados <> 0) using gtr_sce;
			hora_inicio_sdu ++
			If gtr_sce.sqlcode = -1 Then
				MessageBox("Error al decrementar el derecho y uso",gtr_sce.sqlerrtext)
				Return False
			End If	
		Next
		Return True
	Else
		Messagebox("Aviso","el horario no es valido, favor de verIficar")
		Return False
	End If
	Messagebox("Error","al obtener la clave del departamento")
	Return False
End If 
end function

public function boolean incrementa_derecho_y_uso (integer materia, integer dia, integer hor_ini, integer hor_fin, integer cupo);// Regresa True si se Incremento en uno, el campo de ocupados de la tabla de salones_derecho_uso
// Juan Campos.     Junio-1997.
 
Integer Depto=0,Diferencia,hora_inicio_sdu,siclo,Derecho=0,Ocupados=0
Boolean TieneDerechoTodosOk = True, ConsultaDepto = False
 
IF Isvalid(w_grupos_impartidos_dse) Then
	If w_grupos_impartidos_dse.cbx_ServiciosEscolares.Checked Then
		Depto = 7300 // Servicios Escolares
	Else
		ConsultaDepto = True
 	End IF
Else
	ConsultaDepto = True
End If	

If ConsultaDepto Then
	Select cve_coordinacion
	Into 	:depto
	From 	materias
	Where	cve_mat = :Materia using gtr_sce;	
	If gtr_sce.sqlcode <> 0 Then 
		Messagebox("Error al consultar la coordinacion",gtr_sce.sqlerrtext)
		Return False
	End if
End If

IF gtr_sce.sqlcode = 0 or Depto = 7300 Then	
	IF hor_fin > hor_ini Then
		Diferencia = hor_fin - hor_ini
		hora_inicio_sdu = hor_ini
		FOR siclo=1 TO Diferencia
			Select derecho,ocupados
			Into :Derecho,:Ocupados
			From salones_derecho_uso
			Where	(cve_coordinacion	= :depto) and (cve_dia = :Dia) and
					(hora_inicio = :Hora_inicio_sdu) and (cupo = :Cupo) using gtr_sce;
			IF gtr_sce.sqlcode = 0 Then			
				IF Ocupados >= Derecho Then
					TieneDerechoTodosOk = False
					Messagebox("No tiene derecho","Hora Inicio = "+string(Hora_inicio_sdu)+" Ocupados = "+string(Ocupados)+" Derecho = "+string(Derecho))  								 
				Else	
					Update salones_derecho_uso
					Set ocupados = ocupados + 1 // Incrementa uno en el campo de ocupados 
					Where (cve_coordinacion	= :depto) and (cve_dia	= :Dia) and
							(hora_inicio = :Hora_inicio_sdu) and(cupo	= :cupo) using gtr_sce;
					IF gtr_sce.sqlcode <> 0 Then
						TieneDerechoTodosOk= False
						Messagebox("Error al actualizar la tabla derecho_y_uso",gtr_sce.sqlerrtext)
 					End IF	
				End IF
			Else
				TieneDerechoTodosOk = False
				Messagebox("No tiene asignado un derecho y usu para:","Dia "+Dia_String(Dia)+"~nHora Inicio "+string(Hora_inicio_sdu)+"~nCupo "+string(Cupo)+" "+gtr_sce.sqlerrtext)
			End IF // Sqlcode del select 
			hora_inicio_sdu ++
		Next
	Else
		TieneDerechoTodosOk = False
		Messagebox("Aviso","El horario no es valido, favor de Verificar")
	End IF
Else	
	TieneDerechoTodosOk = False
	Messagebox("Error","Al obtener el numero de coordinacion")
End IF 

IF TieneDerechoTodosOk Then
	Return True
Else
	Return False
End IF	

 
end function

public subroutine periodo_alta_grupos (ref integer pergrupos, ref long añogrupos);// Estas fechas solo son validas para el periodo de alta de nuevos grupos
// Juan campos.		Octubre-1997.

string fecha,mes

fecha 		= fecha_ingles_servidor(gtr_sce)
AñoGrupos 	= long(mid(fecha,8,4))
mes 			= upper(mid(fecha,1,3))
If mes = "JAN" or mes = "FEB" or mes = "MAR" Then
	PerGrupos = 0
	st_periodo.text = "PRIMAVERA " + String(AñoGrupos)
Elseif mes = "APR" or mes = "MAY" Then
	PerGrupos = 1	
	st_periodo.text = "VERANO  " + String(AñoGrupos)
ElseIf mes = "JUN" or mes = "JUL" or mes = "AUG" or mes = "SEP" or mes = "OCT" Then
	PerGrupos = 2
	st_periodo.text = "OTOÑO  " + String(AñoGrupos)
ElseIf mes = "NOV" or mes = "DEC"  Then
	PerGrupos = 0
	AñoGrupos ++
	st_periodo.text = "PRIMAVERA " + String(AñoGrupos)
Else
	Messagebox("Aviso","El periodo no es valido")
	Close(w_grupos_impartidos)	
End if

 
end subroutine

public function boolean tienemashoras (integer matp, integer math);int li_horas_realesp, li_horas_realesh

Select m.horas_reales
Into :li_horas_realesp
From  materias m
Where m.cve_mat = :matp using gtr_sce;

Select m.horas_reales
Into :li_horas_realesh
From  materias m
Where m.cve_mat = :math using gtr_sce;

IF gtr_sce.Sqlcode = 0 and li_horas_realesp >= li_horas_realesh Then
	Return True
Else
	Return False	
End If	

end function

public function boolean existe_grupo (integer materia, string grupo, ref integer cupo, ref integer cve_profesor);// Juan Campos Sanchez.      Junio-1998.

Select g.cupo, g.cve_profesor
Into :Cupo, :cve_profesor
From grupos g
Where g.cve_mat = :Materia and 
		g.gpo =:Grupo And 
		g.periodo = :Periodo and 
		g.anio = :Año using gtr_sce;

If IsNull(Cupo) Then Cupo = 0

IF gtr_sce.Sqlcode = 0 Then
	Return True
Else
//	Messagebox("Error al consultar el cupo en la tabla de grupos",gtr_sce.sqlerrtext)
	Return False	
End If	

end function

on w_grupos_impartidos.create
if this.MenuName = "m_gpo_imp" then this.MenuID = create m_gpo_imp
this.st_cupo_asim2=create st_cupo_asim2
this.dw_prof_adj=create dw_prof_adj
this.st_periodo=create st_periodo
this.cbx_nuevo=create cbx_nuevo
this.r_1=create r_1
this.sle_nombre_mat=create sle_nombre_mat
this.dw_nombre_mat=create dw_nombre_mat
this.dw_horario=create dw_horario
this.dw_titular=create dw_titular
this.dw_mat=create dw_mat
this.Control[]={this.st_cupo_asim2,&
this.dw_prof_adj,&
this.st_periodo,&
this.cbx_nuevo,&
this.r_1,&
this.sle_nombre_mat,&
this.dw_nombre_mat,&
this.dw_horario,&
this.dw_titular,&
this.dw_mat}
end on

on w_grupos_impartidos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_cupo_asim2)
destroy(this.dw_prof_adj)
destroy(this.st_periodo)
destroy(this.cbx_nuevo)
destroy(this.r_1)
destroy(this.sle_nombre_mat)
destroy(this.dw_nombre_mat)
destroy(this.dw_horario)
destroy(this.dw_titular)
destroy(this.dw_mat)
end on

event open;// 	GRUPOS IMPATIDOS EN EL SEMESTRE.
// 	Juan Campos Sánchez. 							Junio-1997.
 
m_gpo_imp.ventana = This 
EstaVentana = This

dw_mat.settransobject(gtr_sce)
dw_nombre_mat.settransobject(gtr_sce)
dw_titular.settransobject(gtr_sce)
dw_horario.settransobject(gtr_sce)
 
dw_mat.insertrow(0)
dw_titular.insertrow(0)

cbx_nuevo.enabled = False
periodo_alta_grupos(periodo,año)
dw_nombre_mat.Enabled = False
dw_nombre_mat.Visible = False
m_gpo_imp.m_registro.m_borrasaln.Disable()
/**/gnv_app.inv_security.of_SetSecurity(this)

//g_nv_security.fnv_secure_window (this)


end event

event activate;control_escolar.toolbarsheettitle = "Grupos impartidos en el semestre"
                                  

end event

type st_cupo_asim2 from statictext within w_grupos_impartidos
int X=690
int Y=660
int Width=160
int Height=92
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_prof_adj from datawindow within w_grupos_impartidos
int X=119
int Y=1712
int Width=2917
int Height=300
int TabOrder=20
boolean Visible=false
string DataObject="dw_prof_adj"
boolean TitleBar=true
string Title="Profesor Adjunto"
boolean ControlMenu=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;This.Visible= False
This.x = 119
This.y =	1713
This.width = 2917
This.height = 297


end event

type st_periodo from statictext within w_grupos_impartidos
int X=1472
int Y=12
int Width=613
int Height=100
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=10789024
long BorderColor=8388608
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_nuevo from checkbox within w_grupos_impartidos
int X=78
int Y=28
int Width=411
int Height=64
boolean Enabled=false
string Text="Nuevo"
BorderStyle BorderStyle=StyleRaised!
boolean LeftText=true
long BackColor=16777215
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Juan Campos Sánchez.    Junio-1997.

long Ren

EstaVentana.setredraw(False)	

If This.checked Then
	//st_cupo_asim2.x=689
	//st_cupo_asim2.Visible=False
 	dw_horario.reset()
	dw_titular.reset()
	dw_titular.insertrow(0)
	sle_nombre_mat.text = " "
	dw_mat.reset()
	dw_mat.EVENT desbloqueacampos()
	dw_mat.ScrollToRow(dw_mat.insertrow(0))	
	dw_mat.setfocus()
End If

EstaVentana.setredraw(True)	

end event

type r_1 from rectangle within w_grupos_impartidos
int X=69
int Y=20
int Width=434
int Height=80
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=10789024
end type

type sle_nombre_mat from singlelineedit within w_grupos_impartidos
int X=786
int Y=148
int Width=2048
int Height=84
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;// Juan Campos.        Junio-1997.
String MateriaComodin

IF  Not isnull(sle_nombre_mat.text) Then
	MateriaComodin = "%" + sle_nombre_mat.text + "%"
	IF dw_nombre_mat.Retrieve(MateriaComodin) > 0 Then
		dw_nombre_mat.enabled = True
		dw_nombre_mat.visible = True
		dw_nombre_mat.height = 450
	Else
		dw_nombre_mat.enabled = False
		dw_nombre_mat.visible = False	
		dw_nombre_mat.height = 129		
		Messagebox("Aviso","No hay materias con esté nombre")
	End IF
End IF
end event

type dw_nombre_mat from datawindow within w_grupos_impartidos
event keydown pbm_dwnkey
int X=1179
int Y=244
int Width=2254
int Height=92
int TabOrder=40
string DataObject="dw_nombre_mat"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event keydown;// Juan Campos.    Junio-1997.

IF key = keyenter! Then
	Triggerevent(doubleclicked!)			
End IF


end event

event doubleclicked;String 	Columna
Long 		Materia_dw

Columna = GetColumnName()

If Columna = "cve_mat" or Columna = "materia" Then
	Materia_dw = GetItemNumber(Getrow( ),"cve_mat")
	dw_nombre_mat.enabled = False
	dw_nombre_mat.visible = False
	dw_nombre_mat.height = 120
	If Pertenece_Mat_a_Depto(Materia_dw) Then
 		dw_mat.setfocus()
		dw_mat.triggerevent(itemchanged!)	
	End If
End If
end event

type dw_horario from datawindow within w_grupos_impartidos
int X=1307
int Y=404
int Width=2098
int Height=896
int TabOrder=30
string DataObject="dw_g_i_horario"
boolean TitleBar=true
string Title="                                               HORARIO"
boolean VScrollBar=true
boolean Resizable=true
end type

event itemchanged;// Juan Campos.         Junio-1997.

String	Columna, SalonDwPrimario
Integer	Bloqueado,HoraIni,HoraFin,ClaseAula

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
		SetTabOrder("cve_salon",0)
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
			SetTabOrder("cve_salon",0)
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
End If // Columna
end event

event itemerror;// Juan Campos.

Return 1  // OjO No quitar. Regresa el valor, y no desplega el mensaje de default del evento.

end event

event getfocus;SetTabOrder("cve_salon",0)

IF RowCount() > 0 Then  
 
	IF (dw_mat.getitemnumber(dw_mat.getrow(),"tipo") = 1 or &
	 	dw_mat.getitemnumber(dw_mat.getrow(),"tipo") = 2) Then // 1=Asesoria, 2=Asimilado	
		MessageBox("Aviso","El tipo de grupo Asesoria o Asimilado no puede tener asociado un horario.~nSi desea puede borrar el horario")		
   	This.Undo()	
   	Return
	End IF
End IF 


end event

event rowfocuschanged;SetRow(GetRow())
SetRowFocusIndicator(Hand!)  
ScrollToRow(GetRow())  	

end event

type dw_titular from datawindow within w_grupos_impartidos
int X=878
int Y=1376
int Width=2377
int Height=196
string DataObject="dw_prof_titu"
boolean Border=false
end type

event constructor;m_gpo_imp.dw = this
end event

type dw_mat from datawindow within w_grupos_impartidos
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event bloqueacampos ( )
event desbloqueacampos ( )
event bloqueamenu ( )
event desbloqueamenu ( )
event nuevo ( )
event borraregistro ( )
event profadjunto ( )
event insertahorario ( )
event borrahorario ( )
event type boolean actualiza ( )
event type boolean borratodohorario ( )
event type boolean cambiacupo ( )
event borrasalon ( )
int X=37
int Y=108
int Width=3461
int Height=1532
int TabOrder=10
string DataObject="dw_materia_grupo"
boolean Border=false
end type

event primero;// Juan Campos.             Junio-1997.

Integer	Mat
String		Gpo

Select Min(cve_mat),gpo
Into :Mat,:Gpo
From grupos using gtr_sce;
 
if Not IsNull(Mat)  then
	setitem(getrow(),"cve_mat",Mat)
	setitem(getrow(),"gpo",Gpo)
	setcolumn("cve_mat")
	triggerevent(itemchanged!,2,"")
end if
end event

event anterior;// Juan Sánchez Campos.     Junio-1997.
 
string MatGpo,Gpo

MatGpo = String(getitemnumber(getrow(),"cve_mat")) + getitemString(getrow(),"gpo")

If Mid(MatGpo,1,3) = "200" then
	MatGpo= "0" + MatGpo
end if	

Select Max(cve_mat_gpo)
Into :MatGpo
From grupos  
Where cve_mat_gpo <  :MatGpo using gtr_sce;
 
If Not isnull(MatGpo) Then
	setitem(getrow(),"cve_mat",Integer(Mid(MatGpo,1,4)))
     setitem(getrow(),"gpo",Mid(MatGpo,5,2))
	setcolumn("cve_mat")
	triggerevent(itemchanged!,2,"")
Else 
	MessageBox("Aviso","Este es el primer grupo")
End if
		
end event

event siguiente;// Juan Campos-     Junio-1997.
 
string MatGpo,Gpo

MatGpo = String(getitemnumber(getrow(),"cve_mat")) + getitemString(getrow(),"gpo")

If Mid(MatGpo,1,3) = "200" then
	MatGpo= "0" + MatGpo
end if	

Select Min(cve_mat_gpo)
Into :MatGpo
From grupos  
Where cve_mat_gpo >  :MatGpo using gtr_sce;
 
If Not isnull(MatGpo) Then
	setitem(getrow(),"cve_mat",Integer(Mid(MatGpo,1,4)))
	setitem(getrow(),"gpo",Mid(MatGpo,5,2))
	setcolumn("cve_mat")
	triggerevent(itemchanged!,2,"")
Else 
	MessageBox("Aviso","Este es el ultimo grupo")
End if		
end event

event ultimo;// Juan Campos.             Junio-1997.

String MatGpo

Select Max(cve_mat_gpo)
Into :MatGpo
From grupos using gtr_sce;
 
if Not IsNull(MatGpo)  then 
	setitem(getrow(),"cve_mat",Integer(Mid(MatGpo,1,4)))
	setitem(getrow(),"gpo",Mid(MatGpo,5,2))
	setcolumn("cve_mat")
	triggerevent(itemchanged!,2,"")
end if
		
end event

event bloqueacampos;// Juan Campos.   Mayo-1997. 	
 
SetTabOrder("gpo",0)	
SetTabOrder("tipo",0)
SetTabOrder("cve_asimilada", 0)
SetTabOrder("gpo_asimilado", 0)
SetTabOrder("cond_gpo", 0)
SetTabOrder("cupo",0)
SetTabOrder("cve_profesor",0)
dw_horario.enabled = False
dw_titular.enabled = False
m_gpo_imp.m_registro.m_actualizar.enabled = False	
m_gpo_imp.m_registro.m_borrarhorario.enabled = False	
m_gpo_imp.m_registro.m_borraregistro.enabled = False	
m_gpo_imp.m_registro.m_consultarprofesoradjunto.enabled = False	
m_gpo_imp.m_registro.m_insertarnuevohorario.enabled = False	
m_gpo_imp.m_registro.m_nuevogrupo.enabled = False	
m_gpo_imp.m_edicion.enabled = False 
m_gpo_imp.m_ventana.enabled = False	
 
end event

event desbloqueacampos;// Juan Campos.   Mayo-1997.

SetTabOrder("gpo",10)	 
SetTabOrder("gpo",20)	
SetTabOrder("tipo",30)
SetTabOrder("cve_asimilada", 40)
SetTabOrder("gpo_asimilado", 50)
SetTabOrder("cond_gpo", 0)
SetTabOrder("cupo",60)
SetTabOrder("cve_profesor",70)
dw_horario.enabled = True
dw_titular.enabled = True
m_gpo_imp.m_registro.m_actualizar.enabled = True	
m_gpo_imp.m_registro.m_borrarhorario.enabled = True	
m_gpo_imp.m_registro.m_borraregistro.enabled = True	
m_gpo_imp.m_registro.m_consultarprofesoradjunto.enabled = True	
m_gpo_imp.m_registro.m_insertarnuevohorario.enabled = True	
m_gpo_imp.m_registro.m_nuevogrupo.enabled = True	
m_gpo_imp.m_edicion.enabled = True 
m_gpo_imp.m_ventana.enabled = True	

end event

event bloqueamenu;// Juan Campos.     Junio-1997.
m_gpo_imp.m_registro.m_actualizar.enabled = false	
m_gpo_imp.m_registro.m_borrarhorario.enabled = false	
m_gpo_imp.m_registro.m_borraregistro.enabled = false	
m_gpo_imp.m_registro.m_consultarprofesoradjunto.enabled = false	
m_gpo_imp.m_registro.m_insertarnuevohorario.enabled = false	
m_gpo_imp.m_registro.m_nuevogrupo.enabled = false	

end event

event desbloqueamenu;// Juan Campos.     Junio-1997.
m_gpo_imp.m_registro.m_actualizar.enabled = true	
m_gpo_imp.m_registro.m_borrarhorario.enabled = true	
m_gpo_imp.m_registro.m_borraregistro.enabled = true	
m_gpo_imp.m_registro.m_consultarprofesoradjunto.enabled = true	
m_gpo_imp.m_registro.m_insertarnuevohorario.enabled = true	
m_gpo_imp.m_registro.m_nuevogrupo.enabled = true	

end event

event nuevo;// Juan Campos Octubre 1997.

cbx_nuevo.checked = True		
cbx_nuevo.triggerevent(clicked!)

 
end event

event borraregistro;// Juan Campos.      Junio-1997.

Long    	Clave,ExisteHorario = 0, TipoGpo
String  	Grupo

If cbx_nuevo.checked Then
	EstaVentana.Setredraw(False)			
 	sle_nombre_mat.text =""
	dw_horario.reset()
	dw_titular.reset()
	dw_mat.reset()
	ScrollToRow(dw_mat.insertRow(0))	
	Setcolumn("cve_mat")
	cbx_nuevo.checked = False
	EstaVentana.setredraw(True)
	Return
Else 
	IF dw_mat.getitemnumber(dw_mat.GetRow(),"primer_sem")<>0 then
		Messagebox("Aviso","Este grupo es de Primer Semestre")
	END IF
	IF Messagebox("Aviso","Está seguro que desea borrar el grupo actual",Question!,Okcancel!,2) = 1 Then
		clave = dw_mat.getitemnumber(dw_mat.GetRow(),"cve_mat")
		grupo = dw_mat.getitemstring(dw_mat.GetRow(),"gpo")	
		TipoGpo = dw_mat.getitemNumber(dw_mat.GetRow(),"Tipo")	
 		Select count(*)
		Into	:ExisteHorario
		From	horario
		Where	(cve_mat = :clave and gpo = :grupo and periodo = :Periodo And anio = :Año) using gtr_sce;
		IF gtr_sce.sqlcode = -1 Then
			Messagebox("Error",gtr_sce.sqlerrtext)		
			Return
		ElseIF ExisteHorario > 0  Then
			If Messagebox("Aviso","Para borrar un grupo es necesario borrar el horario.~nDesea Borrarlo",Question!,YesNo!,2) = 1 Then
				If This.Event BorraTodoHorario() Then
					IF dw_horario.RowCount() = 0 Then
						EstaVentana.Setredraw(False)			
						IF dw_mat.deleterow(dw_mat.GetRow()) = 1 Then	
 							IF dw_mat.update(True,True) = 1 Then	
 								cbx_nuevo.checked = False 
								Commit using gtr_sce;			
								dw_mat.insertrow(0)
								dw_titular.retrieve(0)
								EstaVentana.Setredraw(True)
								Return 
 							End IF 			 
						End IF 	
					End If	
				End if	
			End IF  
		ElseIf TipoGpo = 1 or TipoGpo = 2 or TipoGpo = 3 Then // 1=Asesoria, 2=Asimilado, 3=Otro
			EstaVentana.Setredraw(False)			
			IF dw_mat.deleterow(dw_mat.GetRow()) = 1 Then	
 				IF dw_mat.update(True,True) = 1 Then	
 					cbx_nuevo.checked = False 
					Commit using gtr_sce;
					MessageBox("Aviso","Se guardaron los cambios")
					EstaVentana.Setredraw(True)			
					dw_mat.insertrow(0)
					dw_titular.retrieve(0)		
					EstaVentana.Setredraw(True)
					Return 
 				End IF 
				EstaVentana.Setredraw(True)			
			End IF 			
		End If
	End IF  
End If

Rollback Using gtr_sce;
MessageBox("Aviso","No se guardaron los cambios",stopsign!)
dw_mat.resetupdate()
EstaVentana.Setredraw(True)						

end event

event profadjunto;// Juan Campos.      Octubre-1997.

Integer	Materia
String	Grupo

dw_prof_adj.SettransObject(gtr_sce)
Materia	= dw_mat.GetItemNumber(dw_mat.GetRow(),"cve_mat")
Grupo		= dw_mat.GetItemString(dw_mat.GetRow(),"gpo")
if dw_prof_adj.Retrieve(Materia,Grupo,Periodo,Año) > 0 Then
	dw_prof_adj.x = 119
	dw_prof_adj.y =	897
	dw_prof_adj.width = 2917
	dw_prof_adj.height = 350
	dw_prof_adj.Visible= True
Else
	Messagebox("Aviso","No tiene profesor adjunto")
End if

 

end event

event insertahorario;// Juan Campos       Octubre-1997.
  
IF	dw_mat.getitemnumber(1,"tipo") = 0 or &
	dw_mat.getitemnumber(1,"tipo") = 3 Then // 0=Normal, 3=Otro
	EstaVentana.SetRedraw(False)
	dw_horario.setfocus()
	dw_horario.SetItem(dw_horario.InsertRow(0),"clase_aula",0)
	dw_horario.SetRow(dw_horario.RowCount())
	EstaVentana.SetRedraw(True)
Else
	Messagebox("Error","El tipo de grupo: Asesoria o Asimilado, no puede tener asociado un horario")
End IF
 
end event

event borrahorario;// Juan Campos        Octubre-1997.

String	DiaStr,Grupo
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
			if CambiosOk Then
				IF dw_horario.DeleteRow(dw_horario.getrow()) = 1 Then
					ChecharHoras = True
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

event actualiza;// Juan Campos.       Octubre-1997.

// Variables para grupo
Boolean 	GruposOk = False
Integer	ExisteGrupo = 0, ExisteHorario = 0, MatDw,PerDw,AñoDw,CupoDw,TipoDw,TipoDw1,CondGpo,MatAsim,null_num,cupo,cve_profesor
String	GpoDw,GpoAsim,null_string

// Variables para horario
Integer 	HorasClase=0, ContHoras = 0 ,i,Renglon,Columna, Dia,HorIni,HorFin
Boolean	MovimientoOk = False, RengModificado = False, RengNuevo = False, HorarioOk= True,DerechoUsoOK
dwItemStatus status
char GpoDw1, GpoDw2

SetPointer(hourglass!)  
EstaVentana.setredraw(False) // No se reflejan  los cambios en la ventana. Está Función hace que las modIficaciones sean mas rapidas.
MatDw		= dw_mat.getitemnumber(dw_mat.GetRow(),"cve_mat")
GpoDw		= dw_mat.getitemstring(dw_mat.GetRow(),"gpo")
PerDw		= dw_mat.getitemnumber(dw_mat.GetRow(),"periodo")
AñoDw		= dw_mat.getitemnumber(dw_mat.GetRow(),"anio")
CupoDw	= dw_mat.getitemnumber(dw_mat.GetRow(),"cupo")
TipoDw	= dw_mat.getitemnumber(dw_mat.GetRow(),"tipo")
TipoDw1	= dw_mat.getitemnumber(dw_mat.GetRow(),"tipo",primary!,true)
CondGpo	= dw_mat.getitemnumber(dw_mat.GetRow(),"cond_gpo")

GpoDw = Upper(GpoDw)
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
		Messagebox("Error","Algunos datos son incorrectos, favor de verificar los datos.")
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
				Status = dw_horario.GetItemStatus(Renglon,0, Primary!)
				If Status = NewModIfied! Then
				 	RengNuevo = True
					If dw_horario.GetItemNumber(Renglon,"clase_aula") = 0 Then // 0= Salon
            		Dia	=dw_horario.GetItemNumber(Renglon,"cve_dia")
						HorIni=dw_horario.GetItemNumber(Renglon,"hora_inicio")
						HorFin=dw_horario.GetItemNumber(Renglon,"hora_final")
						If Incrementa_Derecho_y_uso(MatDw,Dia,HorIni,HorFin,CupoDw) Then
							DerechoUsoOK = True		
						Else
							DerechoUsoOK = False	
							HorarioOk = False
						End if				
					Else
						DerechoUsoOK = True		
					End if
				Else // Status del renglon 	
					For Columna = 1 to 9
						Status = dw_horario.GetItemStatus(Renglon,Columna, Primary!)
 						If Status = DataModIfied! Then // Si se modifico alguna columna se  con los datos primarios y Incrementa con los datos de filtro				                           
							RengModificado = True
 						End IF
					Next // Columna
					If RengModificado Then
						If dw_horario.GetItemNumber(Renglon,"clase_aula",primary!,True) = 0 Then // 0= Salon
            			Dia	=dw_horario.GetitemNumber(Renglon,"cve_dia", primary!,True) 
							HorIni=dw_horario.Getitemnumber(Renglon,"hora_inicio", primary!,True)
							HorFin=dw_horario.Getitemnumber(Renglon,"hora_final", primary!,True)
				   		if Decrementa_Derecho_y_uso(MatDw,Dia,HorIni,HorFin,CupoDw) Then
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
            				Dia	=dw_horario.GetItemNumber(Renglon,"cve_dia")
								HorIni=dw_horario.GetItemNumber(Renglon,"hora_inicio")
								HorFin=dw_horario.GetItemNumber(Renglon,"hora_final")
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
		Else 
			Messagebox("Error","Algunos Datos son incorrectos.~nFavor de verificar los datos")
			HorarioOk = False		
		End If // dw_horario.Accepttext() 
	Else // Si no hay modIficaciones en el dw_horario, se consulta si existe un horario para un grupo de tipo normal en la base de datos	  		
		If TipoDw = 0 or TipoDw = 3 Then // 0=Normal, 3=Otro
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

If HorarioOk Then
	For I= 1 To  dw_horario.Rowcount()
		ContHoras =	ContHoras + (dw_horario.GetItemNumber(I,"hora_final") - &
													 dw_horario.GetItemNumber(i,"hora_inicio"))				
	Next				
	If TipoDw = 0 or TipoDw = 3 Then // 0=Normal, 3=Otro
		If horas_materia(Matdw,Periodo,HorasClase) Then
			IF (ContHoras = HorasClase) or Not ChecharHoras Then
				If dw_horario.Update(True,False) = 1 Then	
					HorarioOk = True
				Else
					HorarioOk = False
					MessageBox("Error","Algunos datos son incorrectos.~nFavor de verificar los datos.")
				End If // dw_horario.Update Normal,Otro
			Elseif ContHoras > HorasClase Then
				HorarioOk = False
				Messagebox("Aviso","El total de horas asignadas es mayor a el total de horas para esté Periodo.~nHoras Asignadas = "+string(ContHoras)+"~nTotal de horas para esté Periodo = "+string(horasclase))
			Elseif ContHoras < HorasClase Then	
				HorarioOk = False					
				Messagebox("Aviso","El total de horas asignadas es menor a el total de horas para esté Periodo.~nHoras Asignadas = "+string(ContHoras)+"~nTotal de horas para esté Periodo = "+string(horasclase))
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

Actualiza:

If GruposOk And HorarioOk Then
	dw_mat.resetupdate()
	dw_horario.resetupdate()
	Commit using gtr_sce;
   sle_nombre_mat.text =""
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

event borratodohorario;//  Juan Campos        Octubre-1997.

String	DiaStr,Grupo
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
			ExisteHorario = 0
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

event cambiacupo;//	Juan Campos Sánchez.			Octubre-1997.

Integer	MatDw,PerDw,AñoDw,CupoDw,TipoDw,ExisteGrupo = 0,ExisteHorario = 0
Integer 	Dia,HorIni,HorFin,Renglon,CupoDwOriginal
String	GpoDw
Boolean 	CambiaDerechoYUso = False

MatDw	= dw_mat.getitemnumber(dw_mat.GetRow(),"cve_mat",Primary!,True)
GpoDw	= dw_mat.getitemstring(dw_mat.GetRow(),"gpo",Primary!,True)
PerDw	= dw_mat.getitemnumber(dw_mat.GetRow(),"periodo",Primary!,True)
AñoDw	= dw_mat.getitemnumber(dw_mat.GetRow(),"anio",Primary!,True)
TipoDw= dw_mat.getitemnumber(dw_mat.GetRow(),"tipo",Primary!,True)

Select Count(*)
Into	:ExisteGrupo
From	grupos	
Where (cve_mat	= :MatDw and
      gpo    	= :GpoDw and
		periodo	= :PerDw and
		anio 		= :AñoDw) using gtr_sce;		
IF gtr_sce.sqlcode <> -1 and ExisteGrupo > 0 Then
	Select Count(*)
	Into	:ExisteHorario
	From	horario
	Where (cve_mat	= :MatDw and
      	gpo    	= :GpoDw and
			periodo	= :PerDw and
			anio 		= :AñoDw) using gtr_sce;		
	IF gtr_sce.sqlcode <> -1 and ExisteHorario > 0 Then
		IF dw_horario.modIfiedcount() > 0 Then
         Messagebox("Aviso","Si desea cambiar el cupo, es necesario actualizar los cambios")
        	Return False
		ElseIf dw_horario.modIfiedcount() = 0 Then 
			if TipoDw = 0 or TipoDw = 3 Then // 0= Normal, 3=Otro
				CambiaDerechoYUso = True
			Else
				MessageBox("Aviso","El tipo de grupo Asesoría o Asimilado no puede tener asociado un horario.~nSi desea cambiar el tipo de grupo, borre el horario.")						
				Return False
			End if
		End if	
	End IF			
Else
	Return True // Evento CambiaCupo
End if

If CambiaDerechoYUso Then
	CupoDwOriginal	= dw_mat.getitemnumber(dw_mat.GetRow(),"cupo",Primary!,True)
	CupoDw			= dw_mat.getitemnumber(dw_mat.GetRow(),"cupo")
	Ajusta_Cupo(CupoDwOriginal)
	Ajusta_Cupo(CupoDw)
	For Renglon = 1 To dw_horario.RowCount()
		IF dw_horario.GetItemNumber(Renglon,"clase_aula") = 0 Then // 0= Salon		
			Dia 		= dw_horario.GetItemNumber(Renglon,"cve_dia")
			HorIni	= dw_horario.GetItemNumber(Renglon,"hora_inicio")
			HorFin	= dw_horario.GetItemNumber(Renglon,"hora_final")
 			if Decrementa_Derecho_y_uso(MatDw,Dia,HorIni,HorFin,CupoDwOriginal) And &
	 			Incrementa_Derecho_y_uso(MatDw,Dia,HorIni,HorFin,CupoDw) Then
				// ok
			Else
				Rollback using gtr_sce;
				Return False // Evento CambiaCupo
		   End if		
		End If
	Next	
End if	
if This.Event Actualiza() Then
	Return True // Evento CambiaCupo
Else
	Return False // Evento CambiaCupo
End if




end event

event borrasalon;// Juan Campos Sánchez.	Mayo-1998.

// Esté evento no debe contener codigo.
// Desabilitado para los departamentos.
end event

event itemchanged;// Juan Campos.   Junio-1997.

String	columna,Grupo_Dw,gpo_ant,null_string, GpoAsim
long		Materia_dw, cve, HazRetrieve = 0
Integer	cont,ren, Mat_Aux, ContGrupo, null_num ,MatAsim, Cupo, cve_profesor
 
HazRetrieve		=	Message.WordParm	
Columna			=	GetColumnName()
Accepttext()
  
If Columna = "cve_mat" Then	
	dwItemstatus status1	
 	status1 = GetItemstatus(GetRow(),"cve_mat", primary!)
	If status1 = datamodIfied! or status1 = NewmodIfied! or status1 = New! Then
		Materia_dw = Getitemnumber(GetRow(),"cve_mat")
		If Not Pertenece_Mat_a_Depto(Materia_dw) Then
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
		      //st_cupo_asim2.x=695
				//st_cupo_asim2.Visible=False
				SetTabOrder("cupo",60)
				SetTabOrder("cve_profesor",70)
			Else
				//st_cupo_asim2.x=516
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
		Materia_dw =Getitemnumber(GetRow(),"cve_mat")
		Grupo_dw   = GetitemString(GetRow(),"gpo")
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
						SetItem(GetRow(),"cupo",cupo)
						SetItem(GetRow(),"cve_profesor",cve_profesor)
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

event constructor;m_gpo_imp.dw = this

 
 
 
 
end event

event itemfocuschanged;// Juan Campos. Noviembre-1997.
String Columna,GpoAsim,null_string
Integer Tipo,CveAsim,null_num

Columna = GetColumnName()
Tipo = GetItemNumber(GetRow(),"tipo")
CveAsim = GetItemNumber(GetRow(),"cve_asimilada")
GpoAsim =GetItemString(GetRow(),"gpo_asimilado")

If Tipo = 2 Then // 2= Asimilado 
	If Columna = "gpo_asimilado" And isNull(CveAsim) Then
		MessageBox("Error","La clave asimilada no es valida")
		SetColumn("cve_asimilada")
	ElseIf Columna = "cupo" And isNull(GpoAsim) Then
		MessageBox("Error","El grupo asimilado no es valido")
		SetColumn("gpo_asimilado")		
	End if
Else
	SetNull(null_num)
	SetItem(GetRow(),"cve_asimilada",null_num)
	SetNull(null_string)
	SetItem(GetRow(),"gpo_asimilado",null_string)
	Accepttext()
	Return 0			
End IF
 
 
end event

event updateend;int li_tipo, li_cve_mat, li_cve_asimilada,li_cupo, li_cve_profesor
string ls_gpo, ls_gpo_asimilado

if rowsupdated>0 then
li_tipo = GetItemNumber(GetRow(),"tipo")
li_cve_mat = GetItemNumber(GetRow(),"cve_mat")
ls_gpo = GetItemString(GetRow(),"gpo")
li_cupo = GetItemNumber(GetRow(),"cupo")
li_cve_profesor = GetItemNumber(GetRow(),"cve_profesor")
li_cve_asimilada = GetItemNumber(GetRow(),"cve_asimilada")
ls_gpo_asimilado = GetItemString(GetRow(),"gpo_asimilado")
if li_tipo = 2 then
	 UPDATE grupos  
		    SET cupo  = :li_cupo, cve_profesor = :li_cve_profesor  
	  WHERE 			((( grupos.cve_mat = :li_cve_asimilada) AND
						( grupos.gpo = :ls_gpo_asimilado)) OR
						(( grupos.cve_asimilada = :li_cve_asimilada) AND
						( grupos.gpo_asimilado =:ls_gpo_asimilado))) AND
						( grupos.periodo = :periodo) AND
						( grupos.anio = :año) using gtr_sce;

else
	UPDATE grupos  
		    SET cupo = :li_cupo, cve_profesor = :li_cve_profesor 
	  WHERE 			((( grupos.cve_mat = :li_cve_mat ) AND  
			         ( grupos.gpo = :ls_gpo )) OR
						(( grupos.cve_asimilada = :li_cve_mat) AND
						( grupos.gpo_asimilado = :ls_gpo))) AND
						( grupos.periodo = :periodo) AND
						( grupos.anio = :año) using gtr_sce;
end if
end if
if rowsinserted>0 then
li_tipo = GetItemNumber(GetRow(),"tipo")
li_cve_mat = GetItemNumber(GetRow(),"cve_mat")
ls_gpo = GetItemString(GetRow(),"gpo")
if li_tipo = 2 then
	UPDATE grupos
		SET g1.inscritos = g2.inscritos FROM grupos g1, grupos g2
		WHERE g1.cve_asimilada = g2.cve_mat AND
				g1.gpo_asimilado = g2.gpo AND
				g1.anio = g2.anio AND
				g1.periodo = g2.periodo AND
				g1.periodo = :periodo AND
				g1.anio = :año AND
				g1.cve_mat = :li_cve_mat AND
				g1.gpo = :ls_gpo using gtr_sce;
end if
end if
return 0 // Continue processing
end event

event retrieveend;if rowcount > 0 then
int li_tipo
li_tipo = GetItemnumber(GetRow(),"tipo")
if li_tipo = 2 then
	SetTabOrder("cupo",0)
	SetTabOrder("cve_profesor",0)
else
	SetTabOrder("cupo",60)
	SetTabOrder("cve_profesor",70)
end if
end if
end event

