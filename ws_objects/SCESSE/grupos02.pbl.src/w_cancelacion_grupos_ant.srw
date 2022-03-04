$PBExportHeader$w_cancelacion_grupos_ant.srw
forward
global type w_cancelacion_grupos_ant from Window
end type
type st_11 from singlelineedit within w_cancelacion_grupos_ant
end type
type rb_3 from radiobutton within w_cancelacion_grupos_ant
end type
type rb_2 from radiobutton within w_cancelacion_grupos_ant
end type
type rb_1 from radiobutton within w_cancelacion_grupos_ant
end type
type dw_rgc from datawindow within w_cancelacion_grupos_ant
end type
type dw_teoria_lab from datawindow within w_cancelacion_grupos_ant
end type
type cb_imprime_reporte from commandbutton within w_cancelacion_grupos_ant
end type
type dw_ch from datawindow within w_cancelacion_grupos_ant
end type
type dw_cg from datawindow within w_cancelacion_grupos_ant
end type
type cb_cancela_grupo from commandbutton within w_cancelacion_grupos_ant
end type
type st_2 from statictext within w_cancelacion_grupos_ant
end type
type st_1 from statictext within w_cancelacion_grupos_ant
end type
type em_grupo from editmask within w_cancelacion_grupos_ant
end type
type em_materia from editmask within w_cancelacion_grupos_ant
end type
type dw_mat_insc from datawindow within w_cancelacion_grupos_ant
end type
type rr_1 from roundrectangle within w_cancelacion_grupos_ant
end type
type rr_2 from roundrectangle within w_cancelacion_grupos_ant
end type
type gb_1 from groupbox within w_cancelacion_grupos_ant
end type
end forward

global type w_cancelacion_grupos_ant from Window
int X=834
int Y=365
int Width=3617
int Height=2413
boolean TitleBar=true
string Title="CANCELACIÓN DE GRUPOS"
string MenuName="m_cancela_grupos"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_11 st_11
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_rgc dw_rgc
dw_teoria_lab dw_teoria_lab
cb_imprime_reporte cb_imprime_reporte
dw_ch dw_ch
dw_cg dw_cg
cb_cancela_grupo cb_cancela_grupo
st_2 st_2
st_1 st_1
em_grupo em_grupo
em_materia em_materia
dw_mat_insc dw_mat_insc
rr_1 rr_1
rr_2 rr_2
gb_1 gb_1
end type
global w_cancelacion_grupos_ant w_cancelacion_grupos_ant

type variables
Integer Periodo,Año
end variables

forward prototypes
public function boolean decrementa_dus (integer materia, integer dia, integer hor_ini, integer hor_fin, integer cupo)
public function boolean existe_salon_cg (string salon)
public function boolean desocupa_salon_cg (string salon, integer dia, integer hor_inicio, integer hor_final)
public function boolean borra_mat_asociada (long materia, long cuenta, ref string grupo)
public subroutine nombre_y_sigla_materia (long cvemat, ref string nombre, ref string sigla)
end prototypes

public function boolean decrementa_dus (integer materia, integer dia, integer hor_ini, integer hor_fin, integer cupo);// Regresa True si se decremento en uno, el campo de ocupados de la tabla de salones_derecho_uso
// Juan Campos.     Junio-1997.


// Se suspende está función. Segun platica con fantine medina. 5-Diciembre-1997.
  
  
//Integer depto,DIferencia,hora_inicio_sdu,siclo
// 
//Select cve_depto
//Into 	:depto
//From 	materias
//Where	cve_mat = :Materia using gtr_sce;
//If gtr_sce.sqlcode = 0 Then	
//	If hor_fin > hor_ini Then
//		DIferencia = hor_fin - hor_ini
//		hora_inicio_sdu = hor_ini
//		FOR siclo=1 TO DIferencia
//			Update salones_derecho_uso
//			Set ocupados = ocupados - 1 // decrementa uno en el campo de ocupados 
//			Where (cve_depto	= :depto) and (cve_dia	= :Dia) and
//					(hora_inicio = :Hora_inicio_sdu) and(cupo	= :cupo) and
//					(ocupados <> 0) using gtr_sce;
//			hora_inicio_sdu ++
//			If gtr_sce.sqlcode = -1 Then
//				MessageBox("Error al decrementar el derecho y uso",gtr_sce.sqlerrtext)
//				Return False
//			End If	
//		Next
//		Return True
//	Else
//		Messagebox("Aviso","el horario no es valido, favor de verIficar")
//		Return False
//	End If
//	Messagebox("Error","al obtener el numero de departamento")
//	Return False
//End If

Return True
end function

public function boolean existe_salon_cg (string salon);// Regresa True si el salon Existe
// Juan Campos.		Octubre-1997.

Integer Existe = 0

Select Count(*)
Into :Existe
From salon
where cve_salon = :Salon using gtr_sce;

If Existe > 0 Then 
 	Return True
Else 
	Return False
End If
end function

public function boolean desocupa_salon_cg (string salon, integer dia, integer hor_inicio, integer hor_final);// Regresa True si la actualización es exitosa.
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

public function boolean borra_mat_asociada (long materia, long cuenta, ref string grupo);// Borra de la tabla mat_inscritas el Alumno_MateriaAsociada
// Decrementa en uno, en la tabla de grupos en el campo de inscritos con MateriaAsociada_Grupo
// Juan Campos.		Noviembre-1997.

Select gpo
Into	:Grupo
From mat_inscritas
Where cuenta = :Cuenta and cve_mat = :Materia using gtr_sce;

If gtr_sce.sqlcode = 0 Then
	Delete 
	From mat_inscritas 
	Where cuenta = :Cuenta and cve_mat = :Materia using gtr_sce;
	If gtr_sce.sqlcode = 0 Then
		Update From grupos 
		Set inscritos = inscritos - 1
		Where cve_mat = :Materia And gpo = :Grupo And inscritos <> 0 using gtr_sce;
		Return True
	End If	
End If

Grupo =""
Return False
end function

public subroutine nombre_y_sigla_materia (long cvemat, ref string nombre, ref string sigla);//	Regresa el nombre y la sigla de materia
// Juan Campos.		Noviembre-1997.

Select materia,sigla
Into	:Nombre,:Sigla
From	materias
Where cve_mat = :cvemat using gtr_sce;

if gtr_sce.sqlcode <> 0 Then
	Nombre = "Error" 
	Sigla = "Error"
End if

end subroutine

on w_cancelacion_grupos_ant.create
if this.MenuName = "m_cancela_grupos" then this.MenuID = create m_cancela_grupos
this.st_11=create st_11
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_rgc=create dw_rgc
this.dw_teoria_lab=create dw_teoria_lab
this.cb_imprime_reporte=create cb_imprime_reporte
this.dw_ch=create dw_ch
this.dw_cg=create dw_cg
this.cb_cancela_grupo=create cb_cancela_grupo
this.st_2=create st_2
this.st_1=create st_1
this.em_grupo=create em_grupo
this.em_materia=create em_materia
this.dw_mat_insc=create dw_mat_insc
this.rr_1=create rr_1
this.rr_2=create rr_2
this.gb_1=create gb_1
this.Control[]={this.st_11,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.dw_rgc,&
this.dw_teoria_lab,&
this.cb_imprime_reporte,&
this.dw_ch,&
this.dw_cg,&
this.cb_cancela_grupo,&
this.st_2,&
this.st_1,&
this.em_grupo,&
this.em_materia,&
this.dw_mat_insc,&
this.rr_1,&
this.rr_2,&
this.gb_1}
end on

on w_cancelacion_grupos_ant.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_11)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_rgc)
destroy(this.dw_teoria_lab)
destroy(this.cb_imprime_reporte)
destroy(this.dw_ch)
destroy(this.dw_cg)
destroy(this.cb_cancela_grupo)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_grupo)
destroy(this.em_materia)
destroy(this.dw_mat_insc)
destroy(this.rr_1)
destroy(this.rr_2)
destroy(this.gb_1)
end on

event open;// Cancelacion de grupos	
// Juan Campos Sánchez.					Noviembre.1997.

MessageBox("Servidor de: "+gtr_sce.servername,"TOMA PRECAUCIONES.~nQuitar esté mensaje despues de las pruebas.")

//Periodo_Actual(Periodo,Año,gtr_sce)

int per, anio
st_11.text = string(gi_anio)
anio = integer(st_11.text)
per = gi_periodo
if per = 0 then rb_1.checked = true
if per = 1 then rb_2.checked = true
if per = 2 then rb_3.checked = true
Periodo = per
Año = anio
 
 
Choose Case Periodo
Case 0
	dw_rgc.object.periodoanio.text = "PRIMAVERA " + String(Año)
Case 1
	dw_rgc.object.periodoanio.text = "VERANO " + String(Año)
Case 2
	dw_rgc.object.periodoanio.text = "OTOÑO " + String(Año)
End Choose
cb_cancela_grupo.Enabled = False
cb_imprime_reporte.Enabled = False
dw_cg.SetTransObject(gtr_sce)
dw_ch.SetTransObject(gtr_sce)
dw_teoria_lab.SetTransObject(gtr_sce)
dw_mat_insc.SetTransObject(gtr_sce)
dw_rgc.SetTransObject(gtr_sce)
end event

type st_11 from singlelineedit within w_cancelacion_grupos_ant
int X=168
int Y=352
int Width=187
int Height=77
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_cancelacion_grupos_ant
int X=146
int Y=272
int Width=333
int Height=77
string Text="Otoño"
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_cancelacion_grupos_ant
int X=146
int Y=205
int Width=333
int Height=77
string Text="Verano"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_cancelacion_grupos_ant
int X=146
int Y=141
int Width=333
int Height=77
string Text="Primavera"
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_rgc from datawindow within w_cancelacion_grupos_ant
int X=40
int Y=1245
int Width=3525
int Height=291
boolean Visible=false
boolean Enabled=false
string DataObject="dw_rep_grupos_cancelados"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_rgc.object.fecha_hoy.text =Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

type dw_teoria_lab from datawindow within w_cancelacion_grupos_ant
int X=2304
int Y=173
int Width=856
int Height=307
boolean Visible=false
boolean Enabled=false
string DataObject="dw_teoria_lab"
boolean LiveScroll=true
end type

type cb_imprime_reporte from commandbutton within w_cancelacion_grupos_ant
int X=1156
int Y=365
int Width=490
int Height=109
int TabOrder=60
string Text="Imprime Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_rgc.print()
Messagebox("Proceso Terminado","")
em_materia.Setfocus()
end event

type dw_ch from datawindow within w_cancelacion_grupos_ant
int X=37
int Y=835
int Width=1810
int Height=403
boolean Visible=false
boolean Enabled=false
string DataObject="dw_cancela_horario"
boolean LiveScroll=true
end type

type dw_cg from datawindow within w_cancelacion_grupos_ant
int X=37
int Y=525
int Width=1935
int Height=307
boolean Visible=false
boolean Enabled=false
string DataObject="dw_cancela_grupo"
boolean LiveScroll=true
end type

type cb_cancela_grupo from commandbutton within w_cancelacion_grupos_ant
event keydown pbm_keydown
int X=1159
int Y=205
int Width=490
int Height=109
int TabOrder=40
string Text="Cancela Grupo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event keydown;if keydown(keyenter!) Then
	TriggerEvent(Clicked!)
End if
end event

event clicked;// Decrementa Salones_Derecho_Y_Uso, y si tiene un salón asociado
// llama a la función desocupa_salon() y borra el salon de dw_ch
// Regresa True si hacen todas las actualizaciones.
// Ver codigo del evento RetrieveEnd del dw_mat_incs.
// Juan campos. 		Noviembre-1997.
 
Long	Clave,ClaveAsim
Integer CupoGrupo,RenHor,Dia,HoraIni,HoraFin,ClaseAula,Existe = 0,i,Todos,RengReporte
String 	Grupo,GrupoAsim,CampoNulo,Salon,Nombre,Sigla
Boolean	CambiosOk = True, ErrorMatInscritas = False
int cuenta,pregunta

año = integer(st_11.text)
periodo = 2
if (rb_1.checked = true) then
	periodo = 0
else
	if (rb_2.checked = true) then periodo = 1
end if

Choose Case Periodo
Case 0
	dw_rgc.object.periodoanio.text = "PRIMAVERA " + String(Año)
Case 1
	dw_rgc.object.periodoanio.text = "VERANO " + String(Año)
Case 2
	dw_rgc.object.periodoanio.text = "OTOÑO " + String(Año)
End Choose

if dw_cg.rowcount()>0 then
	Clave	= dw_cg.GetItemnumber(dw_cg.GetRow(),"cve_mat")
	Grupo	= dw_cg.GetItemstring(dw_cg.GetRow(),"gpo")	

  SELECT dbo.grupos.primer_sem  
    INTO :cuenta
    FROM dbo.grupos  
   WHERE ( dbo.grupos.cve_mat = :clave ) AND  
         ( dbo.grupos.gpo = :grupo ) AND  
         ( dbo.grupos.periodo = :periodo ) AND  
         ( dbo.grupos.anio = :año )
	USING gtr_sce;

	if cuenta<>0 then
		pregunta = MessageBox("Ese grupo es de primer ingreso", "¿LO CANCELO?",  &
		Exclamation!, YESNO!, 2)
		IF pregunta <> 1 THEN 
			return
		END IF				
	end if
end if
   
//ClaveAsim = dw_cg.GetItemnumber(dw_cg.GetRow(),"cve_asimilada")
//GrupoAsim = dw_cg.GetItemstring(dw_cg.GetRow(),"gpo_asimilado")	

SELECT cve_mat, cve_gpo INTO :ClaveAsim, :GrupoAsim FROM grupos
WHERE periodo = :Periodo AND anio = :Año
AND cve_asimilada = :Clave AND gpo_asimilado = :Grupo using gtr_sce;
 
Select Count(*) 
Into :Existe
From grupos
Where cve_mat = :ClaveAsim and gpo = :GrupoAsim and 
	   periodo = :Periodo And anio = :Año And cond_gpo = 1 using gtr_sce;
If Existe > 0 Then
	Messagebox("Aviso","Existe un grupo asimilado que no fue cancelado previamente")
	ErrorMatInscritas = True
Else 
	Clave	= dw_cg.GetItemnumber(dw_cg.GetRow(),"cve_mat")
	Grupo	= dw_cg.GetItemstring(dw_cg.GetRow(),"gpo")	
	CupoGrupo = dw_cg.GetItemNumber(dw_cg.GetRow(),"cupo")		
	Ajusta_Cupo(CupoGrupo)
	SetNull(CampoNulo)
	IF dw_ch.RowCount() > 0  Then	
		For RenHor = 1 To dw_ch.RowCount()
			ClaseAula= dw_ch.GetItemNumber(RenHor,"clase_aula")
			Dia     	= dw_ch.GetItemNumber(RenHor,"cve_dia")
 			horaini	= dw_ch.GetItemNumber(RenHor,"hora_inicio")
			horafin	= dw_ch.GetItemNumber(RenHor,"hora_final")
			Salon    = dw_ch.GetItemString(RenHor,"cve_salon")
			If ClaseAula = 0 Then // 0=Salon
		 		If Not Decrementa_Dus(Clave,Dia,HoraIni,HoraFin,CupoGrupo) Then
					CambiosOk = False	
				End if
			End if
			If CambiosOK Then
				If Not isNull(Salon) Then
					If Existe_salon_cg(Salon) Then	
						If DesOcupa_salon_cg(Salon,Dia,HoraIni,HoraFin) Then
							dw_ch.SetItem(RenHor,"cve_salon",CampoNulo)
						Else
							CambiosOK = False	
 						End IF
					End IF
 				End IF
			End iF
		Next
	End if
	IF CambiosOk Then 
		dw_cg.SetItem(dw_cg.GetRow(),"cond_gpo",0) // 0=Cancelado
		if dw_cg.Update(True,True) = 1 And dw_ch.Update(True,True) = 1 Then
			IF dw_mat_insc.Retrieve(Clave,Grupo,Periodo,Año) > 0 Then
				Todos = dw_mat_insc.RowCount()
				For i = 1 To Todos
					dw_mat_insc.DeleteRow(0)
				Next
				If dw_mat_insc.Update(True,True) <> 1 Then
					ErrorMatInscritas = True
				End if
			Else //juan
				dw_rgc.insertrow(0)
				RengReporte = dw_rgc.insertrow(0)
				dw_rgc.SetItem(RengReporte,"cve_mat",Clave)
				dw_rgc.SetItem(RengReporte,"gpo",Grupo)
				Nombre_y_Sigla_Materia(Clave,Nombre,Sigla)
				dw_rgc.SetItem(RengReporte,"materias_materia",Nombre)
				dw_rgc.SetItem(RengReporte,"materias_sigla",Sigla)
			End IF
		Else
			ErrorMatInscritas = True
 		End IF
	Else
		ErrorMatInscritas = True
	End IF
End if	

If ErrorMatInscritas Then
	Rollback Using gtr_sce;
	Messagebox("Aviso","Los cambios no fueron guardados")	
Else
	Commit using gtr_sce;
	Messagebox("Aviso","Los cambios fueron guardados")	
	cb_imprime_reporte.Enabled = True
End if

em_materia.Setfocus()

end event

type st_2 from statictext within w_cancelacion_grupos_ant
int X=881
int Y=67
int Width=249
int Height=77
boolean Enabled=false
boolean Border=true
string Text="Grupo"
Alignment Alignment=Center!
boolean FocusRectangle=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_cancelacion_grupos_ant
int X=622
int Y=67
int Width=249
int Height=77
boolean Enabled=false
boolean Border=true
string Text="Materia"
Alignment Alignment=Center!
boolean FocusRectangle=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_grupo from editmask within w_cancelacion_grupos_ant
int X=889
int Y=157
int Width=249
int Height=93
int TabOrder=30
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="!#"
MaskDataType MaskDataType=StringMask!
string DisplayData=""
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;dw_cg.Reset()
dw_ch.Reset()
dw_mat_insc.Reset()
dw_teoria_lab.Reset()
em_grupo.SelectText(1,Len(em_grupo.Text))
end event

event modified;int per, anio
anio = integer(st_11.text)
per = 2
if (rb_1.checked = true) then
	per = 0
else
	if (rb_2.checked = true) then per = 1
end if
Periodo = per
Año = anio
 
 
Choose Case Periodo
Case 0
	dw_rgc.object.periodoanio.text = "PRIMAVERA " + String(Año)
Case 1
	dw_rgc.object.periodoanio.text = "VERANO " + String(Año)
Case 2
	dw_rgc.object.periodoanio.text = "OTOÑO " + String(Año)
End Choose

IF dw_cg.Retrieve(long(em_materia.text),em_grupo.text,Periodo,Año) > 0 Then
	dw_ch.Retrieve(long(em_materia.text),em_grupo.text,Periodo,Año)	
	cb_cancela_grupo.Enabled = True
	cb_cancela_grupo.SetFocus()
Else
	MessageBox("Aviso","Esté grupo no existe, o ya esta cancelado")
	cb_cancela_grupo.Enabled = False
	em_materia.SetFocus()
End if


end event

type em_materia from editmask within w_cancelacion_grupos_ant
int X=622
int Y=157
int Width=249
int Height=93
int TabOrder=20
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;em_materia.SelectText(1,Len(em_materia.Text))

end event

type dw_mat_insc from datawindow within w_cancelacion_grupos_ant
int X=2033
int Y=749
int Width=1221
int Height=307
boolean Visible=false
boolean Enabled=false
string DataObject="dw_mat_inscritas"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrieveend;// Juan Campos.		Noviembre-1997.

Long	Materia,MatAsociada,i,RengReporte, Cont
String	Grupo,Nombre,Sigla,Digito
Long		Cuenta
Boolean  TieneMatAsociada

IF RowCount() > 0 Then
	dw_rgc.insertrow(0)
	Materia 		= GetItemNumber(1,"cve_mat")
	RengReporte = dw_rgc.insertrow(0)
	dw_rgc.SetItem(RengReporte,"cve_mat",Materia)
	dw_rgc.SetItem(RengReporte,"gpo",GetItemString(1,"gpo"))
	Nombre_y_Sigla_Materia(Materia,Nombre,Sigla)
	dw_rgc.SetItem(RengReporte,"materias_materia",Nombre)
	dw_rgc.SetItem(RengReporte,"materias_sigla",Sigla)
	IF dw_teoria_lab.Retrieve(Materia) > 0 then	
		TieneMatAsociada = True
 		dw_rgc.SetItem(dw_rgc.insertrow(0),"materias_materia","****************** MATERIA(S) ASOCIADA(S) ******************")		
		If Materia = dw_teoria_lab.GetItemNumber(dw_teoria_lab.GetRow(),"cve_teoria") Then
			MatAsociada = dw_teoria_lab.GetItemNumber(dw_teoria_lab.GetRow(),"cve_lab")
		ElseIf Materia = dw_teoria_lab.GetItemNumber(dw_teoria_lab.GetRow(),"cve_lab") Then
			MatAsociada = dw_teoria_lab.GetItemNumber(dw_teoria_lab.GetRow(),"cve_teoria")
 		End IF
	Else
		TieneMatAsociada = False
	End If
   
	For i = 1 To RowCount()
		RengReporte = dw_rgc.insertrow(0)
		Cuenta = GetItemNumber(i,"cuenta")	
		If TieneMatAsociada Then
			Grupo = ""
			If Borra_Mat_Asociada(MatAsociada,Cuenta,Grupo) Then
			 	dw_rgc.SetItem(RengReporte,"cve_mat",MatAsociada)
				dw_rgc.SetItem(RengReporte,"gpo",Grupo)
				Nombre_y_Sigla_Materia(MatAsociada,Nombre,Sigla)
				dw_rgc.SetItem(RengReporte,"materias_materia",Nombre)
				dw_rgc.SetItem(RengReporte,"materias_sigla",Sigla)				
			End if
		End if	
		Digito = Obten_Digito(Cuenta)
		dw_rgc.SetItem(RengReporte,"cuenta",Cuenta)
		dw_rgc.SetItem(RengReporte,"calificacion",Digito)
	Next
End if
end event

type rr_1 from roundrectangle within w_cancelacion_grupos_ant
int X=51
int Y=16
int Width=1744
int Height=477
boolean Enabled=false
int LineThickness=3
int CornerHeight=45
int CornerWidth=40
long LineColor=16777215
long FillColor=29064704
end type

type rr_2 from roundrectangle within w_cancelacion_grupos_ant
int X=607
int Y=61
int Width=534
int Height=93
boolean Enabled=false
int LineThickness=3
int CornerHeight=45
int CornerWidth=40
long LineColor=16777215
long FillColor=10789024
end type

type gb_1 from groupbox within w_cancelacion_grupos_ant
int X=91
int Y=64
int Width=505
int Height=397
int TabOrder=10
string Text="Periodo"
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

