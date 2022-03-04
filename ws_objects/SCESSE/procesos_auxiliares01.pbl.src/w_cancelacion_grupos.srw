$PBExportHeader$w_cancelacion_grupos.srw
forward
global type w_cancelacion_grupos from window
end type
type uo_1 from uo_per_ani within w_cancelacion_grupos
end type
type st_11 from singlelineedit within w_cancelacion_grupos
end type
type rb_3 from radiobutton within w_cancelacion_grupos
end type
type rb_2 from radiobutton within w_cancelacion_grupos
end type
type rb_1 from radiobutton within w_cancelacion_grupos
end type
type dw_rgc from datawindow within w_cancelacion_grupos
end type
type dw_teoria_lab from datawindow within w_cancelacion_grupos
end type
type cb_imprime_reporte from commandbutton within w_cancelacion_grupos
end type
type dw_ch from datawindow within w_cancelacion_grupos
end type
type dw_cg from datawindow within w_cancelacion_grupos
end type
type cb_cancela_grupo from commandbutton within w_cancelacion_grupos
end type
type st_2 from statictext within w_cancelacion_grupos
end type
type st_1 from statictext within w_cancelacion_grupos
end type
type em_grupo from editmask within w_cancelacion_grupos
end type
type em_materia from editmask within w_cancelacion_grupos
end type
type dw_mat_insc from datawindow within w_cancelacion_grupos
end type
type rr_1 from roundrectangle within w_cancelacion_grupos
end type
type rr_2 from roundrectangle within w_cancelacion_grupos
end type
type gb_1 from groupbox within w_cancelacion_grupos
end type
end forward

global type w_cancelacion_grupos from window
integer x = 832
integer y = 364
integer width = 3616
integer height = 2412
boolean titlebar = true
string title = "CANCELACIÓN DE GRUPOS"
string menuname = "m_cancela_grupos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
uo_1 uo_1
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
global w_cancelacion_grupos w_cancelacion_grupos

type variables
Integer Periodo,Año
end variables

forward prototypes
public function boolean decrementa_dus (integer materia, integer dia, integer hor_ini, integer hor_fin, integer cupo)
public function boolean existe_salon_cg (string salon)
public function boolean desocupa_salon_cg (string salon, integer dia, integer hor_inicio, integer hor_final)
public function boolean borra_mat_asociada (integer materia, long cuenta, ref string grupo)
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

public function boolean borra_mat_asociada (integer materia, long cuenta, ref string grupo);// Borra de la tabla mat_inscritas el Alumno_MateriaAsociada
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

on w_cancelacion_grupos.create
if this.MenuName = "m_cancela_grupos" then this.MenuID = create m_cancela_grupos
this.uo_1=create uo_1
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
this.Control[]={this.uo_1,&
this.st_11,&
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

on w_cancelacion_grupos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
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

String ls_periodo

//MessageBox("Servidor de: "+gtr_sce.servername,"TOMA PRECAUCIONES.~nQuitar esté mensaje despues de las pruebas.")

//Periodo_Actual(Periodo,Año,gtr_sce)

int per, anio


ls_periodo=uo_1.em_per.text
periodo=uo_1.iuo_periodo_servicios.f_recupera_id(ls_periodo, "L")
Año=Integer(uo_1.em_ani.text)
dw_rgc.object.periodoanio.text = ls_periodo+" "+uo_1.em_ani.text

/*
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
*/

cb_cancela_grupo.Enabled = False
cb_imprime_reporte.Enabled = False
dw_cg.SetTransObject(gtr_sce)
dw_ch.SetTransObject(gtr_sce)
dw_teoria_lab.SetTransObject(gtr_sce)
dw_mat_insc.SetTransObject(gtr_sce)
dw_rgc.SetTransObject(gtr_sce)
end event

type uo_1 from uo_per_ani within w_cancelacion_grupos
integer x = 279
integer y = 120
integer taborder = 20
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_11 from singlelineedit within w_cancelacion_grupos
boolean visible = false
integer x = 3342
integer y = 336
integer width = 187
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_3 from radiobutton within w_cancelacion_grupos
boolean visible = false
integer x = 3278
integer y = 216
integer width = 334
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Otoño"
end type

type rb_2 from radiobutton within w_cancelacion_grupos
boolean visible = false
integer x = 3278
integer y = 148
integer width = 334
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Verano"
boolean checked = true
end type

type rb_1 from radiobutton within w_cancelacion_grupos
boolean visible = false
integer x = 3278
integer y = 84
integer width = 334
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Primavera"
end type

type dw_rgc from datawindow within w_cancelacion_grupos
boolean visible = false
integer x = 41
integer y = 1592
integer width = 3525
integer height = 564
boolean enabled = false
string dataobject = "dw_rep_grupos_cancelados"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;dw_rgc.object.fecha_hoy.text =Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

type dw_teoria_lab from datawindow within w_cancelacion_grupos
boolean visible = false
integer x = 2304
integer y = 172
integer width = 855
integer height = 308
boolean enabled = false
string dataobject = "dw_teoria_lab"
boolean livescroll = true
end type

type cb_imprime_reporte from commandbutton within w_cancelacion_grupos
integer x = 933
integer y = 640
integer width = 489
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Reporte"
end type

event clicked;dw_rgc.print()
Messagebox("Proceso Terminado","")
em_materia.Setfocus()
end event

type dw_ch from datawindow within w_cancelacion_grupos
boolean visible = false
integer x = 37
integer y = 1168
integer width = 1810
integer height = 404
boolean enabled = false
string dataobject = "dw_cancela_horario"
boolean livescroll = true
end type

type dw_cg from datawindow within w_cancelacion_grupos
boolean visible = false
integer x = 37
integer y = 856
integer width = 1934
integer height = 308
boolean enabled = false
string dataobject = "dw_cancela_grupo"
boolean livescroll = true
end type

type cb_cancela_grupo from commandbutton within w_cancelacion_grupos
event keydown pbm_keydown
integer x = 411
integer y = 640
integer width = 489
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancela Grupo"
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
String 	Grupo,GrupoAsim,CampoNulo,Salon,Nombre,Sigla, ls_cve_mat, ls_gpo, ls_gpo_asimilado
Boolean	CambiosOk = True, ErrorMatInscritas = False, lb_es_asimilado
int cuenta,pregunta
long ll_cve_mat, ll_cve_asimilada
int li_periodo, li_anio, li_actual_hijos_asimil
String ls_periodo


ls_periodo=uo_1.em_per.text
periodo=uo_1.iuo_periodo_servicios.f_recupera_id(ls_periodo, "L")
Año=Integer(uo_1.em_ani.text)
dw_rgc.object.periodoanio.text = ls_periodo+" "+uo_1.em_ani.text



ls_cve_mat = em_materia.text
ls_gpo = em_grupo.text


if not isnumber(ls_cve_mat) then
	MessageBox("Materia invalida", "Favor de escribir una materia valida")
	return
else 
	ll_cve_mat= long(ls_cve_mat)
end if

if len(ls_gpo) =0 or isnull(ls_gpo) then
	MessageBox("Materia invalida", "Favor de escribir una materia valida")
	return
end if

/*
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

li_periodo = periodo
li_anio = año
*/

if f_grupo_que_asimila(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
	MessageBox("Grupo que Asimila", "No es posible cancelar un grupo que asimila a otro")
	return	
end if

lb_es_asimilado= false

if f_grupo_asimilado(ll_cve_mat, ls_gpo, li_periodo, li_anio) then
	//pude obtener el grupo que asimila
	if f_obten_grupo_que_asimila(ll_cve_mat, ls_gpo, li_periodo, li_anio, & 
										ll_cve_asimilada, ls_gpo_asimilado) then
		lb_es_asimilado= true										
	end if
end if


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

SELECT cve_mat, gpo INTO :ClaveAsim, :GrupoAsim FROM grupos
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
//		 		If Not Decrementa_Dus(Clave,Dia,HoraIni,HoraFin,CupoGrupo) Then
//Decrementa el derecho y uso y lo devuelve a servicios escolares
		 		If Not f_dec_derecho_uso(Clave,Dia,HoraIni,HoraFin,CupoGrupo, true) Then
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

//if	lb_es_asimilado then									
//	li_actual_hijos_asimil = f_actual_gpos_hijos_asimil(ll_cve_asimilada, ls_gpo_asimilado, &
//																			 li_periodo, li_anio)
//	if li_actual_hijos_asimil =-1 then
//		MessageBox("Grupo hermanos no actualizados", &
// 						"No es posible actualizar los grupos asimilados relacionados.")
//		return				
//	end if
//end if

em_materia.Setfocus()

end event

type st_2 from statictext within w_cancelacion_grupos
integer x = 942
integer y = 388
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Grupo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_cancelacion_grupos
integer x = 681
integer y = 388
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Materia"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_grupo from editmask within w_cancelacion_grupos
integer x = 946
integer y = 476
integer width = 247
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!#"
string displaydata = "~b"
end type

event getfocus;dw_cg.Reset()
dw_ch.Reset()
dw_mat_insc.Reset()
dw_teoria_lab.Reset()
em_grupo.SelectText(1,Len(em_grupo.Text))
end event

event modified;int per, anio
String ls_periodo


ls_periodo=uo_1.em_per.text
periodo=uo_1.iuo_periodo_servicios.f_recupera_id(ls_periodo, "L")
Año=Integer(uo_1.em_ani.text)
dw_rgc.object.periodoanio.text = ls_periodo+" "+uo_1.em_ani.text

/*
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
*/

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

type em_materia from editmask within w_cancelacion_grupos
integer x = 681
integer y = 476
integer width = 247
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event getfocus;em_materia.SelectText(1,Len(em_materia.Text))

end event

type dw_mat_insc from datawindow within w_cancelacion_grupos
boolean visible = false
integer x = 2034
integer y = 1080
integer width = 1221
integer height = 308
boolean enabled = false
string dataobject = "dw_mat_inscritas"
boolean vscrollbar = true
boolean livescroll = true
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

type rr_1 from roundrectangle within w_cancelacion_grupos
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 29064704
integer x = 50
integer y = 16
integer width = 1746
integer height = 760
integer cornerheight = 45
integer cornerwidth = 40
end type

type rr_2 from roundrectangle within w_cancelacion_grupos
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 10789024
integer x = 667
integer y = 380
integer width = 535
integer height = 92
integer cornerheight = 45
integer cornerwidth = 40
end type

type gb_1 from groupbox within w_cancelacion_grupos
integer x = 238
integer y = 48
integer width = 1330
integer height = 276
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 15780518
string text = "Periodo"
end type

