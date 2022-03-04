$PBExportHeader$w_salones_derecho_uso.srw
forward
global type w_salones_derecho_uso from window
end type
type st_destino_coordinacion from statictext within w_salones_derecho_uso
end type
type st_4 from statictext within w_salones_derecho_uso
end type
type st_2 from statictext within w_salones_derecho_uso
end type
type em_salones from editmask within w_salones_derecho_uso
end type
type em_coordinacion from editmask within w_salones_derecho_uso
end type
type dw_sdu_sab from datawindow within w_salones_derecho_uso
end type
type dw_sdu_vie from datawindow within w_salones_derecho_uso
end type
type dw_sdu_jue from datawindow within w_salones_derecho_uso
end type
type dw_sdu_mie from datawindow within w_salones_derecho_uso
end type
type dw_sdu_mar from datawindow within w_salones_derecho_uso
end type
type ddlb_cupo from dropdownlistbox within w_salones_derecho_uso
end type
type st_3 from statictext within w_salones_derecho_uso
end type
type st_nomdepto from statictext within w_salones_derecho_uso
end type
type st_1 from statictext within w_salones_derecho_uso
end type
type em_depto from editmask within w_salones_derecho_uso
end type
type dw_sdu_lun from datawindow within w_salones_derecho_uso
end type
type rr_1 from roundrectangle within w_salones_derecho_uso
end type
type rr_2 from roundrectangle within w_salones_derecho_uso
end type
end forward

global type w_salones_derecho_uso from window
integer x = 800
integer y = 224
integer width = 3579
integer height = 2000
boolean titlebar = true
string title = "DERECHO Y USO"
string menuname = "m_salon_derecho_uso"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
event actualiza ( )
event nuevo ( )
event borra ( )
event cede ( datawindow ventana_datos,  long renglon )
st_destino_coordinacion st_destino_coordinacion
st_4 st_4
st_2 st_2
em_salones em_salones
em_coordinacion em_coordinacion
dw_sdu_sab dw_sdu_sab
dw_sdu_vie dw_sdu_vie
dw_sdu_jue dw_sdu_jue
dw_sdu_mie dw_sdu_mie
dw_sdu_mar dw_sdu_mar
ddlb_cupo ddlb_cupo
st_3 st_3
st_nomdepto st_nomdepto
st_1 st_1
em_depto em_depto
dw_sdu_lun dw_sdu_lun
rr_1 rr_1
rr_2 rr_2
end type
global w_salones_derecho_uso w_salones_derecho_uso

type variables
 
end variables

event cede(datawindow ventana_datos, long renglon);integer fuente_coordinacion,cve_dia,hora_inicio,cupo,derecho,ocupados
integer destino_coordinacion,salones
string ls_error,ls_nivel

salones=integer(em_salones.text)
destino_coordinacion=integer(em_coordinacion.text)

if salones=0 then
	messagebox("¿Cuantos salones quieres ceder?","")
	setfocus(em_salones)
	return
end if

if destino_coordinacion=0 then
	messagebox("¿A qué coordinación?","")
	setfocus(em_coordinacion)
	return
end if

if renglon>0 then
	fuente_coordinacion=ventana_datos.object.cve_coordinacion[renglon]
	cve_dia=ventana_datos.object.cve_dia[renglon]
	hora_inicio=ventana_datos.object.hora_inicio[renglon]
	cupo=ventana_datos.object.cupo[renglon]
	
	SELECT distinct materias.nivel
	INTO :ls_nivel
	FROM materias
	WHERE materias.cve_coordinacion = :fuente_coordinacion
	USING gtr_sce;
	
	if gtr_sce.SQLCode = 100 then
		MessageBox("Error Grave","La coordinación fuente tiene materias de Licenciatura y de Posgrado.")
		return
	elseif gtr_sce.SQLCode > 0 then
		MessageBox("Error de base de datos",gtr_sce.SQLErrText, Exclamation!)
		return
	End If
	
	//if ls_nivel<>'L' then
	if ls_nivel = 'P' then 
		MessageBox("Error","La coordinación fuente tiene materias de Posgrado.")
		return
	end if

	SELECT salones_derecho_uso.derecho,salones_derecho_uso.ocupados
	INTO :derecho,:ocupados
	FROM salones_derecho_uso
	WHERE ( salones_derecho_uso.cve_coordinacion = :fuente_coordinacion ) AND
		( salones_derecho_uso.cve_dia = :cve_dia ) AND
		( salones_derecho_uso.hora_inicio = :hora_inicio ) AND
		( salones_derecho_uso.cupo = :cupo )
	USING gtr_sce;
	commit using gtr_sce;
	
	if derecho - ocupados >= salones then
		IF MessageBox("¿Seguro que quieres ceder",em_salones.text+" salones?",Exclamation!, YesNo!, 2)=1 THEN 
			
			UPDATE salones_derecho_uso
			SET derecho = derecho + :salones
			WHERE ( salones_derecho_uso.cve_coordinacion = :destino_coordinacion ) AND
				( salones_derecho_uso.cve_dia = :cve_dia ) AND
				( salones_derecho_uso.hora_inicio = :hora_inicio ) AND
				( salones_derecho_uso.cupo = :cupo )
			USING gtr_sce;
			if gtr_sce.SQLCode<>0 then
				ls_error=gtr_sce.SQLErrtext
				rollback using gtr_sce;
				messagebox("Error al intentar quitar los salones.",ls_error)
				return
			end if

			UPDATE salones_derecho_uso
			SET derecho = derecho - :salones
			WHERE ( salones_derecho_uso.cve_coordinacion = :fuente_coordinacion ) AND
				( salones_derecho_uso.cve_dia = :cve_dia ) AND
				( salones_derecho_uso.hora_inicio = :hora_inicio ) AND
				( salones_derecho_uso.cupo = :cupo )
			USING gtr_sce;
			if gtr_sce.SQLCode<>0 then
				ls_error=gtr_sce.SQLErrtext
				rollback using gtr_sce;
				messagebox("Error al intentar quitar los salones.",ls_error)
				return
			else
				commit using gtr_sce;
			end if
			
			messagebox("Hecho está","")
			
			ddlb_cupo.event selectionchanged(1)
			
		ELSE
			messagebox("Sabia decisión","")
		END IF
	else
		messagebox("No Puedes ceder más de",string(derecho - ocupados)+" salones.")
	end if
end if
end event

on w_salones_derecho_uso.create
if this.MenuName = "m_salon_derecho_uso" then this.MenuID = create m_salon_derecho_uso
this.st_destino_coordinacion=create st_destino_coordinacion
this.st_4=create st_4
this.st_2=create st_2
this.em_salones=create em_salones
this.em_coordinacion=create em_coordinacion
this.dw_sdu_sab=create dw_sdu_sab
this.dw_sdu_vie=create dw_sdu_vie
this.dw_sdu_jue=create dw_sdu_jue
this.dw_sdu_mie=create dw_sdu_mie
this.dw_sdu_mar=create dw_sdu_mar
this.ddlb_cupo=create ddlb_cupo
this.st_3=create st_3
this.st_nomdepto=create st_nomdepto
this.st_1=create st_1
this.em_depto=create em_depto
this.dw_sdu_lun=create dw_sdu_lun
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.st_destino_coordinacion,&
this.st_4,&
this.st_2,&
this.em_salones,&
this.em_coordinacion,&
this.dw_sdu_sab,&
this.dw_sdu_vie,&
this.dw_sdu_jue,&
this.dw_sdu_mie,&
this.dw_sdu_mar,&
this.ddlb_cupo,&
this.st_3,&
this.st_nomdepto,&
this.st_1,&
this.em_depto,&
this.dw_sdu_lun,&
this.rr_1,&
this.rr_2}
end on

on w_salones_derecho_uso.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_destino_coordinacion)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.em_salones)
destroy(this.em_coordinacion)
destroy(this.dw_sdu_sab)
destroy(this.dw_sdu_vie)
destroy(this.dw_sdu_jue)
destroy(this.dw_sdu_mie)
destroy(this.dw_sdu_mar)
destroy(this.ddlb_cupo)
destroy(this.st_3)
destroy(this.st_nomdepto)
destroy(this.st_1)
destroy(this.em_depto)
destroy(this.dw_sdu_lun)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;// Juan Campos.      Junio-1997.
// Modificado			Noviembre-1997.

//g_nv_security.fnv_secure_window (this)

This.x = 5
This.y = 5
m_salon_derecho_uso.ventana = This 

Integer	NumeroDepto = 0
String 	UsuarioSigla
  
em_depto.Enabled	=	False
ddlb_cupo.enabled =	False
m_salon_derecho_uso.m_edicion.m_copiar.enabled = false
m_salon_derecho_uso.m_edicion.m_cortar.enabled = false
m_salon_derecho_uso.m_edicion.m_pegar.enabled = false
m_salon_derecho_uso.m_edicion.m_borrar.enabled = false
m_salon_derecho_uso.m_edicion.m_deshacer.enabled = false
m_salon_derecho_uso.m_registro.m_actualiza.enabled =False
m_salon_derecho_uso.m_registro.m_nuevo.enabled =False
m_salon_derecho_uso.m_registro.m_borraregistro.enabled =False
m_salon_derecho_uso.m_registro.m_primero.enabled = False
m_salon_derecho_uso.m_registro.m_anterior.enabled = False
m_salon_derecho_uso.m_registro.m_siguiente.enabled = False
m_salon_derecho_uso.m_registro.m_ultimo.enabled = False

UsuarioSigla = Upper(gtr_sce.logid)
If Mid(UsuarioSigla,2,1) = "_" Then
	UsuarioSigla = Replace(UsuarioSigla, 2, 1, "-")
End if

Select cve_coordinacion,coordinacion 
Into :NumeroDepto,:st_nomdepto.text
From coordinaciones
Where user_id = :UsuarioSigla using gtr_sce;

IF gtr_sce.sqlcode = 0 And NumeroDepto > 0 Then
	em_depto.text = String(NumeroDepto)
	ddlb_cupo.enabled = True
	ddlb_cupo.SetFocus()
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
Else
	Messagebox("Error","Al consultar la clave de la coordinacion")
	Close(This)
End if
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

type st_destino_coordinacion from statictext within w_salones_derecho_uso
integer x = 1019
integer y = 140
integer width = 1952
integer height = 92
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_4 from statictext within w_salones_derecho_uso
integer x = 2994
integer y = 44
integer width = 219
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Coordina."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_salones_derecho_uso
integer x = 3013
integer y = 156
integer width = 187
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Salones"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_salones from editmask within w_salones_derecho_uso
integer x = 3214
integer y = 140
integer width = 247
integer height = 100
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = ""
end type

type em_coordinacion from editmask within w_salones_derecho_uso
integer x = 3214
integer y = 20
integer width = 247
integer height = 100
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = ""
end type

event modified;int li_coordinacion
string ls_coordinacion

li_coordinacion=integer(text)
setnull(ls_coordinacion)

SELECT coordinaciones.coordinacion
INTO :ls_coordinacion
FROM coordinaciones
WHERE coordinaciones.cve_coordinacion = :li_coordinacion
USING gtr_sce;
commit USING gtr_sce;

if isnull(ls_coordinacion) then
	text=""
	st_destino_coordinacion.text=""
else
	IF messagebox("Escogiste la coordinación:",ls_coordinacion,&
		Exclamation!, YesNo!, 2) = 1 THEN 
		st_destino_coordinacion.text='Cede a '+ls_coordinacion
	ELSE
		text=""
		st_destino_coordinacion.text=""
	END IF
end if
end event

type dw_sdu_sab from datawindow within w_salones_derecho_uso
integer x = 2875
integer y = 308
integer width = 544
integer height = 1356
string dataobject = "dw_salones_derecho_uso"
boolean border = false
boolean livescroll = true
end type

event retrieveend;Integer i
For i = 1 to RowCount()
IF GetItemNumber(GetRow(),"hora_inicio") = 8 or &
	GetItemNumber(GetRow(),"hora_inicio") = 10 or &
	GetItemNumber(GetRow(),"hora_inicio") = 12 or &
	GetItemNumber(GetRow(),"hora_inicio") = 14 or &
	GetItemNumber(GetRow(),"hora_inicio") = 16 or &
	GetItemNumber(GetRow(),"hora_inicio") = 18 or &
	GetItemNumber(GetRow(),"hora_inicio") = 20 Then	
	dw_sdu_lun.object.line.Color = 255
End if
next
end event

event doubleclicked;event cede(this,row)
end event

type dw_sdu_vie from datawindow within w_salones_derecho_uso
integer x = 2309
integer y = 308
integer width = 544
integer height = 1356
string dataobject = "dw_salones_derecho_uso"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;event cede(this,row)
end event

type dw_sdu_jue from datawindow within w_salones_derecho_uso
integer x = 1742
integer y = 308
integer width = 544
integer height = 1356
string dataobject = "dw_salones_derecho_uso"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;event cede(this,row)
end event

type dw_sdu_mie from datawindow within w_salones_derecho_uso
integer x = 1175
integer y = 308
integer width = 544
integer height = 1356
string dataobject = "dw_salones_derecho_uso"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;event cede(this,row)
end event

type dw_sdu_mar from datawindow within w_salones_derecho_uso
integer x = 608
integer y = 308
integer width = 544
integer height = 1356
string dataobject = "dw_salones_derecho_uso"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;event cede(this,row)
end event

type ddlb_cupo from dropdownlistbox within w_salones_derecho_uso
integer x = 654
integer y = 124
integer width = 215
integer height = 428
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
string text = "20"
boolean autohscroll = true
boolean sorted = false
integer limit = 3
string item[] = {"20","40","60","80"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// Juan Campos.      Junio-1997.

Integer Depto,Cupo
Cupo = integer(ddlb_cupo.text) 
	
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

end event

type st_3 from statictext within w_salones_derecho_uso
integer x = 654
integer y = 28
integer width = 215
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421504
boolean enabled = false
string text = "Cupo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_nomdepto from statictext within w_salones_derecho_uso
integer x = 1019
integer y = 32
integer width = 1952
integer height = 92
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_salones_derecho_uso
integer x = 50
integer y = 28
integer width = 530
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421504
boolean enabled = false
string text = "Cve Coordinacion"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_depto from editmask within w_salones_derecho_uso
integer x = 50
integer y = 124
integer width = 530
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
alignment alignment = center!
string mask = "###"
string displaydata = ""
end type

type dw_sdu_lun from datawindow within w_salones_derecho_uso
event nuevo ( )
integer x = 41
integer y = 308
integer width = 544
integer height = 1356
string dataobject = "dw_salones_derecho_uso"
boolean border = false
boolean livescroll = true
end type

event nuevo;// Juan Campos        Noviembre de 1997.

// Ver Codigo en la ventana que se herede
end event

event retrieveend;Integer i
For i = 1 to RowCount()
IF GetItemNumber(GetRow(),"hora_inicio") = 8 or &
	GetItemNumber(GetRow(),"hora_inicio") = 10 or &
	GetItemNumber(GetRow(),"hora_inicio") = 12 or &
	GetItemNumber(GetRow(),"hora_inicio") = 14 or &
	GetItemNumber(GetRow(),"hora_inicio") = 16 or &
	GetItemNumber(GetRow(),"hora_inicio") = 18 or &
	GetItemNumber(GetRow(),"hora_inicio") = 20 Then	
	dw_sdu_lun.object.line.Color = 255
End if
next
end event

event doubleclicked;event cede(this,row)
end event

type rr_1 from roundrectangle within w_salones_derecho_uso
long linecolor = 33554431
integer linethickness = 3
long fillcolor = 10789024
integer x = 23
integer y = 276
integer width = 3461
integer height = 1404
integer cornerheight = 42
integer cornerwidth = 40
end type

type rr_2 from roundrectangle within w_salones_derecho_uso
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 12632256
integer x = 23
integer y = 12
integer width = 3461
integer height = 240
integer cornerheight = 42
integer cornerwidth = 40
end type

