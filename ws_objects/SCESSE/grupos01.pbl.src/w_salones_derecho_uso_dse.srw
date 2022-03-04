$PBExportHeader$w_salones_derecho_uso_dse.srw
forward
global type w_salones_derecho_uso_dse from w_salones_derecho_uso
end type
end forward

global type w_salones_derecho_uso_dse from w_salones_derecho_uso
int Height=2192
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
end type
global w_salones_derecho_uso_dse w_salones_derecho_uso_dse

type variables
window EstaVentana
end variables

event primero;// Juan campos Diciembre-1997.

Integer Depto

Select Min(cve_coordinacion) Into :Depto From coordinaciones using gtr_sce;
If gtr_sce.Sqlcode = 0 Then
	em_depto.text = String(Depto)
	ddlb_cupo.text = "20"
	Select coordinacion Into :st_nomdepto.text 
	From coordinaciones where cve_coordinacion = :Depto using gtr_sce;
	ddlb_cupo.TriggerEvent(SelectionChanged!)
End If

end event

event anterior;// Juan campos Diciembre-1997.

Integer Depto

Depto = Integer(em_depto.text)

Select Max(cve_coordinacion) Into :Depto From coordinaciones Where cve_coordinacion < :Depto using gtr_sce;
If gtr_sce.Sqlcode = 0 and Not IsNull(Depto) Then
	em_depto.text = String(Depto)
	ddlb_cupo.text = "20"
	Select coordinacion Into :st_nomdepto.text 
	From coordinaciones where cve_coordinacion = :Depto using gtr_sce;	
	ddlb_cupo.TriggerEvent(SelectionChanged!)
Else
	Messagebox("Aviso","Es la primer coordinacion")
End If


 
end event

event siguiente;// Juan campos Diciembre-1997.

Integer Depto

Depto = Integer(em_depto.text)

Select Min(cve_coordinacion) Into :Depto From coordinaciones Where cve_coordinacion > :Depto using gtr_sce;
If gtr_sce.Sqlcode = 0 and Not IsNull(Depto) Then
	em_depto.text = String(Depto)
	ddlb_cupo.text = "20"
	Select coordinacion Into :st_nomdepto.text 
	From coordinaciones where cve_coordinacion = :Depto using gtr_sce;	
	ddlb_cupo.TriggerEvent(SelectionChanged!)
Else
	Messagebox("Aviso","Es la última coordinacion")
End If

end event

event ultimo;// Juan campos Diciembre-1997.

Integer Depto

Select Max(cve_coordinacion) Into :Depto From coordinaciones using gtr_sce;
If gtr_sce.Sqlcode = 0 Then
	em_depto.text = String(Depto)
	ddlb_cupo.text = "20"
	Select coordinacion Into :st_nomdepto.text 
	From coordinaciones where cve_coordinacion = :Depto using gtr_sce;	
	ddlb_cupo.TriggerEvent(SelectionChanged!)
End If


end event

on w_salones_derecho_uso_dse.create
call super::create
end on

on w_salones_derecho_uso_dse.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;// Juan Campos.      Junio-1997.
// Modificado			Noviembre-1997.

//g_nv_security.fnv_secure_window (this)

This.x = 5
This.y = 5

Integer	NumeroDepto = 0
String 	UsuarioSigla

EstaVentana = This
m_salon_derecho_uso.ventana = This 
  
dw_sdu_lun.settransobject(gtr_sce)
dw_sdu_mar.settransobject(gtr_sce)
dw_sdu_mie.settransobject(gtr_sce)
dw_sdu_jue.settransobject(gtr_sce)
dw_sdu_vie.settransobject(gtr_sce)
dw_sdu_sab.settransobject(gtr_sce)

dw_sdu_lun.object.cve_dia.background.Color = RGB(0,98,196)	
dw_sdu_mar.object.cve_dia.background.Color = RGB(170,0,0)	
dw_sdu_mie.object.cve_dia.background.Color = RGB(0,128,192)	
dw_sdu_jue.object.cve_dia.background.Color = RGB(255,111,111)	
dw_sdu_vie.object.cve_dia.background.Color = RGB(0,128,128)	
dw_sdu_sab.object.cve_dia.background.Color = RGB(228,188,27)
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

event actualiza;// Juan Campos 	Noviembre-1997.

IF dw_sdu_lun.Update(True,True) = 1 and &
	dw_sdu_mar.Update(True,True) = 1 and &
	dw_sdu_mie.Update(True,True) = 1 and &
	dw_sdu_jue.Update(True,True) = 1 and &
	dw_sdu_vie.Update(True,True) = 1 and &
	dw_sdu_sab.Update(True,True) = 1 Then
	Commit using gtr_sce;
	Messagebox("Aviso","Los cambios fueron guardados")
Else
	Rollback using gtr_sce;
	Messagebox("Aviso","Los cambios no fueron guardados")
End IF
end event

event borra;Int 		Respuesta,Renglon,Todos
Boolean	DeleteOk = True

Respuesta = Messagebox("ATENCIÓN","Desea borrar los datos actuales.",StopSign!,YesNo!,2)
EstaVentana.setredraw(False)
IF respuesta = 1 Then
	Todos = dw_sdu_lun.RowCount()
	For Renglon = 1 To Todos
		IF dw_sdu_lun.deleterow(0) = 1 Then
			IF dw_sdu_mar.deleterow(0) = 1 Then
				IF dw_sdu_mie.deleterow(0) = 1 Then
					IF dw_sdu_jue.deleterow(0) = 1 Then
						IF dw_sdu_vie.deleterow(0) = 1 Then
							IF dw_sdu_sab.deleterow(0) = 1 Then
								// DeleteOk							
							Else
								DeleteOk = False
							End If	
						End If	
					End If	
				End If	
			End If	
		End IF
	Next	
	EstaVentana.Setredraw(True)
	IF DeleteOk And &
		dw_sdu_lun.update(true,true) = 1 and &		
		dw_sdu_mar.update(true,true) = 1 and &		
		dw_sdu_mie.update(true,true) = 1 and &		
		dw_sdu_jue.update(true,true) = 1 and &		
		dw_sdu_vie.update(true,true) = 1 and &		
		dw_sdu_sab.update(true,true) = 1 Then
		Commit using gtr_sce;
		Messagebox("Información","Se han guardado los cambios")			
	Else
		Rollback using gtr_sce;
		Messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	End IF
ElseIF respuesta = 2 Then
	Rollback using gtr_sce;
End IF

end event

event nuevo;// Juan Campos.		Noviembre-1997.

Integer Indice,Depto,Dia,Cupo,Ocupados

EstaVentana.Setredraw(False)		 
Depto = Integer(em_depto.text)
st_nomdepto.text	= ""
dw_sdu_lun.Reset()
dw_sdu_mar.Reset()
dw_sdu_mie.Reset()
dw_sdu_jue.Reset()
dw_sdu_vie.Reset()
dw_sdu_sab.Reset()
Select coordinacion
Into :st_nomdepto.text
From coordinaciones
Where cve_coordinacion = :Depto using gtr_sce;
If gtr_sce.sqlcode <> 0 Then 
  	MessageBox("Error","la clave de la coordinacion no existe")
  	em_depto.clear()
  	em_depto.setfocus()
Else
	Cupo	= Integer(ddlb_cupo.text)
	Depto	= Integer(em_depto.text)
	IF dw_sdu_lun.Retrieve(Depto,1,Cupo) > 0 or &
		dw_sdu_mar.Retrieve(Depto,2,Cupo) > 0 or &
		dw_sdu_mie.Retrieve(Depto,3,Cupo) > 0 or &
		dw_sdu_jue.Retrieve(Depto,4,Cupo) > 0 or &
		dw_sdu_vie.Retrieve(Depto,5,Cupo) > 0 or &
		dw_sdu_sab.Retrieve(Depto,6,Cupo) > 0 Then
		Messagebox("Aviso","Estos datos ya existen")
		dw_sdu_lun.Setfocus()
	Else
		For Indice = 1 To 15
			dw_sdu_lun.ScrolltoRow(dw_sdu_lun.InsertRow(Indice))
			dw_sdu_lun.SetItem(Indice,"cve_coordinacion",Depto)
			dw_sdu_lun.SetItem(Indice,"cve_dia",1)
			dw_sdu_lun.SetItem(Indice,"hora_inicio",Indice+6)
			dw_sdu_lun.SetItem(Indice,"cupo",cupo)
			dw_sdu_lun.SetItem(indice,"derecho",0)
			dw_sdu_lun.SetItem(Indice,"ocupados",0)
			
			dw_sdu_mar.ScrolltoRow(dw_sdu_mar.InsertRow(Indice))
			dw_sdu_mar.SetItem(Indice,"cve_coordinacion",Depto)
			dw_sdu_mar.SetItem(Indice,"cve_dia",2)
			dw_sdu_mar.SetItem(Indice,"hora_inicio",Indice+6)
			dw_sdu_mar.SetItem(Indice,"cupo",cupo)
			dw_sdu_mar.SetItem(indice,"derecho",0)
			dw_sdu_mar.SetItem(Indice,"ocupados",0)

			dw_sdu_mie.ScrolltoRow(dw_sdu_mie.InsertRow(Indice))
			dw_sdu_mie.SetItem(Indice,"cve_coordinacion",Depto)
			dw_sdu_mie.SetItem(Indice,"cve_dia",3)
			dw_sdu_mie.SetItem(Indice,"hora_inicio",Indice+6)
			dw_sdu_mie.SetItem(Indice,"cupo",cupo)
			dw_sdu_mie.SetItem(indice,"derecho",0)
			dw_sdu_mie.SetItem(Indice,"ocupados",0)

			dw_sdu_jue.ScrolltoRow(dw_sdu_jue.InsertRow(Indice))
			dw_sdu_jue.SetItem(Indice,"cve_coordinacion",Depto)
			dw_sdu_jue.SetItem(Indice,"cve_dia",4)
			dw_sdu_jue.SetItem(Indice,"hora_inicio",Indice+6)
			dw_sdu_jue.SetItem(Indice,"cupo",cupo)
			dw_sdu_jue.SetItem(indice,"derecho",0)
			dw_sdu_jue.SetItem(Indice,"ocupados",0)
			
			dw_sdu_vie.ScrolltoRow(dw_sdu_vie.InsertRow(Indice))
			dw_sdu_vie.SetItem(Indice,"cve_coordinacion",Depto)
			dw_sdu_vie.SetItem(Indice,"cve_dia",5)
			dw_sdu_vie.SetItem(Indice,"hora_inicio",Indice+6)
			dw_sdu_vie.SetItem(Indice,"cupo",cupo)
			dw_sdu_vie.SetItem(indice,"derecho",0)
			dw_sdu_vie.SetItem(Indice,"ocupados",0)
			
			dw_sdu_sab.ScrolltoRow(dw_sdu_sab.InsertRow(Indice))
			dw_sdu_sab.SetItem(Indice,"cve_coordinacion",Depto)
			dw_sdu_sab.SetItem(Indice,"cve_dia",6)
			dw_sdu_sab.SetItem(Indice,"hora_inicio",Indice+6)
			dw_sdu_sab.SetItem(Indice,"cupo",cupo)
			dw_sdu_sab.SetItem(indice,"derecho",0)
			dw_sdu_sab.SetItem(Indice,"ocupados",0)			
		Next
    	dw_sdu_lun.SetFocus()
		dw_sdu_lun.ScrolltoRow(1)
    	dw_sdu_lun.setcolumn("Derecho")
  End if
End if

EstaVentana.setredraw(True)
end event

event ddlb_cupo::selectionchanged;// Juan Campos.      Junio-1997.

Integer Depto,Cupo
Cupo = integer(ddlb_cupo.text) 

EstaVentana.SetRedraw(False)	
If cupo = 20 or cupo = 40 or cupo = 60 or cupo = 80 Then
	Depto =	Integer(em_depto.text)
	If dw_sdu_lun.Retrieve(Depto,1,Cupo) = 0 Then
		dw_sdu_lun.Reset()
		Messagebox("Aviso","No hay información para el dia Lunes")
		ddlb_cupo.setfocus()
	End If		
	If dw_sdu_mar.Retrieve(Depto,2,Cupo) = 0 Then			
		dw_sdu_mar.Reset()
		Messagebox("Aviso","No hay información para el dia Martes")
		ddlb_cupo.setfocus()
	End If		
	If dw_sdu_mie.Retrieve(Depto,3,Cupo) = 0 Then			
		dw_sdu_mie.Reset()
		Messagebox("Aviso","No hay información para el dia miercoles")
		ddlb_cupo.setfocus()
	End If		
	If dw_sdu_jue.Retrieve(Depto,4,Cupo) = 0 Then			
		dw_sdu_jue.Reset()
		Messagebox("Aviso","No hay información para el dia Jueves")
		ddlb_cupo.setfocus()
	End If		
	If dw_sdu_vie.Retrieve(Depto,5,Cupo) = 0 Then			
		dw_sdu_vie.Reset()
		Messagebox("Aviso","No hay información para el dia Viernes")
		ddlb_cupo.setfocus()
	End If		
	If dw_sdu_sab.Retrieve(Depto,6,Cupo) = 0 Then			
		dw_sdu_sab.Reset()
		Messagebox("Aviso","No hay información para el dia Sabado")
		ddlb_cupo.setfocus()
	End If			
Else
	Messagebox("Error","Valores validos:  [20, 40, 60, 80]")
	ddlb_cupo.setfocus()
End If

EstaVentana.SetRedraw(True)
end event

type em_depto from w_salones_derecho_uso`em_depto within w_salones_derecho_uso_dse
string Mask="####"
string DisplayData="Ä"
end type

event modified;// Juan Campos Sánchez.		Noviembre-1997.
Integer	Depto

EstaVentana.SetRedraw(False)
Depto = Integer(em_depto.text)
dw_sdu_lun.Reset()
dw_sdu_mar.Reset()
dw_sdu_mie.Reset()
dw_sdu_jue.Reset()
dw_sdu_vie.Reset()
dw_sdu_sab.Reset()

Select coordinacion 
Into :st_nomdepto.text
From coordinaciones
Where cve_coordinacion = :Depto using gtr_sce;

IF gtr_sce.SqlCode = 0 Then
	ddlb_cupo.setfocus()
ElseIf gtr_sce.SqlCode =100 Then
	Messagebox("La coordinacion no existe","Intenta con otro número")
ElseIf gtr_sce.SqlCode = -1 Then
	Messagebox("Error al consultar la tabla coordinaciones",gtr_sce.sqlerrtext)
End If 

EstaVentana.SetRedraw(True)
end event

event em_depto::getfocus;call super::getfocus;em_depto.SelectText(1, Len(em_depto.Text))
end event

