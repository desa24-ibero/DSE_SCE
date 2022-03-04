$PBExportHeader$w_salones_derecho_uso_ant.srw
forward
global type w_salones_derecho_uso_ant from Window
end type
type st_destino_coordinacion from statictext within w_salones_derecho_uso_ant
end type
type st_4 from statictext within w_salones_derecho_uso_ant
end type
type st_2 from statictext within w_salones_derecho_uso_ant
end type
type em_salones from editmask within w_salones_derecho_uso_ant
end type
type em_coordinacion from editmask within w_salones_derecho_uso_ant
end type
type dw_sdu_sab from datawindow within w_salones_derecho_uso_ant
end type
type dw_sdu_vie from datawindow within w_salones_derecho_uso_ant
end type
type dw_sdu_jue from datawindow within w_salones_derecho_uso_ant
end type
type dw_sdu_mie from datawindow within w_salones_derecho_uso_ant
end type
type dw_sdu_mar from datawindow within w_salones_derecho_uso_ant
end type
type ddlb_cupo from dropdownlistbox within w_salones_derecho_uso_ant
end type
type st_3 from statictext within w_salones_derecho_uso_ant
end type
type st_nomdepto from statictext within w_salones_derecho_uso_ant
end type
type st_1 from statictext within w_salones_derecho_uso_ant
end type
type em_depto from editmask within w_salones_derecho_uso_ant
end type
type dw_sdu_lun from datawindow within w_salones_derecho_uso_ant
end type
type rr_1 from roundrectangle within w_salones_derecho_uso_ant
end type
type rr_2 from roundrectangle within w_salones_derecho_uso_ant
end type
end forward

global type w_salones_derecho_uso_ant from Window
int X=801
int Y=224
int Width=3580
int Height=2000
boolean TitleBar=true
string Title="DERECHO Y USO"
string MenuName="m_salon_derecho_uso"
long BackColor=10789024
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
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
global w_salones_derecho_uso_ant w_salones_derecho_uso_ant

type variables
 
end variables

event cede;integer fuente_coordinacion,cve_dia,hora_inicio,cupo,derecho,ocupados
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
	
	if ls_nivel<>'L' then
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

on w_salones_derecho_uso_ant.create
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

on w_salones_derecho_uso_ant.destroy
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

type st_destino_coordinacion from statictext within w_salones_derecho_uso_ant
int X=1020
int Y=141
int Width=1953
int Height=93
boolean Enabled=false
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_salones_derecho_uso_ant
int X=2995
int Y=42
int Width=219
int Height=61
boolean Enabled=false
string Text="Coordina."
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_salones_derecho_uso_ant
int X=3013
int Y=157
int Width=187
int Height=61
boolean Enabled=false
string Text="Salones"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_salones from editmask within w_salones_derecho_uso_ant
int X=3215
int Y=138
int Width=249
int Height=99
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
string DisplayData=""
long TextColor=33554432
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_coordinacion from editmask within w_salones_derecho_uso_ant
int X=3215
int Y=19
int Width=249
int Height=99
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
string DisplayData=""
long TextColor=33554432
long BackColor=16777215
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type dw_sdu_sab from datawindow within w_salones_derecho_uso_ant
int X=2875
int Y=307
int Width=545
int Height=1354
string DataObject="dw_salones_derecho_uso"
boolean Border=false
boolean LiveScroll=true
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

type dw_sdu_vie from datawindow within w_salones_derecho_uso_ant
int X=2308
int Y=307
int Width=545
int Height=1354
string DataObject="dw_salones_derecho_uso"
boolean Border=false
boolean LiveScroll=true
end type

event doubleclicked;event cede(this,row)
end event

type dw_sdu_jue from datawindow within w_salones_derecho_uso_ant
int X=1741
int Y=307
int Width=545
int Height=1354
string DataObject="dw_salones_derecho_uso"
boolean Border=false
boolean LiveScroll=true
end type

event doubleclicked;event cede(this,row)
end event

type dw_sdu_mie from datawindow within w_salones_derecho_uso_ant
int X=1174
int Y=307
int Width=545
int Height=1354
string DataObject="dw_salones_derecho_uso"
boolean Border=false
boolean LiveScroll=true
end type

event doubleclicked;event cede(this,row)
end event

type dw_sdu_mar from datawindow within w_salones_derecho_uso_ant
int X=607
int Y=307
int Width=545
int Height=1354
string DataObject="dw_salones_derecho_uso"
boolean Border=false
boolean LiveScroll=true
end type

event doubleclicked;event cede(this,row)
end event

type ddlb_cupo from dropdownlistbox within w_salones_derecho_uso_ant
int X=655
int Y=125
int Width=216
int Height=429
int TabOrder=20
string Text="20"
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean AutoHScroll=true
int Limit=3
long TextColor=8388608
long BackColor=15793151
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"20",&
"40",&
"60",&
"80"}
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

type st_3 from statictext within w_salones_derecho_uso_ant
int X=655
int Y=26
int Width=216
int Height=77
boolean Enabled=false
boolean Border=true
string Text="Cupo"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8421504
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_nomdepto from statictext within w_salones_derecho_uso_ant
int X=1020
int Y=32
int Width=1953
int Height=93
boolean Enabled=false
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_salones_derecho_uso_ant
int X=51
int Y=26
int Width=530
int Height=77
boolean Enabled=false
boolean Border=true
string Text="Cve Coordinacion"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8421504
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_depto from editmask within w_salones_derecho_uso_ant
int X=51
int Y=125
int Width=530
int Height=93
int TabOrder=10
Alignment Alignment=Center!
string Mask="###"
string DisplayData=""
long TextColor=8388608
long BackColor=15793151
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_sdu_lun from datawindow within w_salones_derecho_uso_ant
event nuevo ( )
int X=40
int Y=307
int Width=545
int Height=1354
string DataObject="dw_salones_derecho_uso"
boolean Border=false
boolean LiveScroll=true
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

type rr_1 from roundrectangle within w_salones_derecho_uso_ant
int X=22
int Y=275
int Width=3460
int Height=1405
boolean Enabled=false
int LineThickness=3
int CornerHeight=42
int CornerWidth=40
long LineColor=33554431
long FillColor=10789024
end type

type rr_2 from roundrectangle within w_salones_derecho_uso_ant
int X=22
int Y=10
int Width=3460
int Height=240
boolean Enabled=false
int LineThickness=3
int CornerHeight=42
int CornerWidth=40
long LineColor=16777215
long FillColor=12632256
end type

