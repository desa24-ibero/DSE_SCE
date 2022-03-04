﻿$PBExportHeader$w_alumnos_credenciales_falt.srw
forward
global type w_alumnos_credenciales_falt from window
end type
type st_1 from statictext within w_alumnos_credenciales_falt
end type
type em_cve_carrera from editmask within w_alumnos_credenciales_falt
end type
type cb_cargar from commandbutton within w_alumnos_credenciales_falt
end type
type cb_generar from commandbutton within w_alumnos_credenciales_falt
end type
type dw_1 from datawindow within w_alumnos_credenciales_falt
end type
end forward

global type w_alumnos_credenciales_falt from window
integer x = 846
integer y = 372
integer width = 3323
integer height = 1228
boolean titlebar = true
string title = "Alumnos Credenciales Faltantes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_1 st_1
em_cve_carrera em_cve_carrera
cb_cargar cb_cargar
cb_generar cb_generar
dw_1 dw_1
end type
global w_alumnos_credenciales_falt w_alumnos_credenciales_falt

on w_alumnos_credenciales_falt.create
this.st_1=create st_1
this.em_cve_carrera=create em_cve_carrera
this.cb_cargar=create cb_cargar
this.cb_generar=create cb_generar
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_cve_carrera,&
this.cb_cargar,&
this.cb_generar,&
this.dw_1}
end on

on w_alumnos_credenciales_falt.destroy
destroy(this.st_1)
destroy(this.em_cve_carrera)
destroy(this.cb_cargar)
destroy(this.cb_generar)
destroy(this.dw_1)
end on

type st_1 from statictext within w_alumnos_credenciales_falt
integer x = 1321
integer y = 216
integer width = 219
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carrera:"
boolean focusrectangle = false
end type

type em_cve_carrera from editmask within w_alumnos_credenciales_falt
integer x = 1618
integer y = 192
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type cb_cargar from commandbutton within w_alumnos_credenciales_falt
integer x = 626
integer y = 188
integer width = 389
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;long ll_num_rows, ll_cve_carrrera
string ls_cve_carrrera

SetPointer ( HourGlass! )
ls_cve_carrrera = em_cve_carrera.text
ll_cve_carrrera = Long (ls_cve_carrrera)

ll_num_rows=  dw_1.Retrieve(ll_cve_carrrera)
if ll_num_rows <= 0 then
	MessageBox("No hay datos", "Es necesario que haya algo que procesar")
	return
end if

SetPointer ( Arrow! )
end event

type cb_generar from commandbutton within w_alumnos_credenciales_falt
integer x = 2295
integer y = 196
integer width = 389
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;integer li_FileNum, li_FileNumBlob, li_num_spaces, li_file_sin_foto
long ll_num_rows, ll_row_actual, ll_matricula, ll_cve_carrrera
string ls_matricula, ls_separador, ls_apellidos, ls_nombre, ls_carrera, ls_grabacion_causa
string ls_tipo_de_grupo, ls_nombre_de_la_imagen, ls_registro, ls_digito, ls_path, ls_formato
string ls_cve_carrrera

SetPointer ( HourGlass! )
ls_cve_carrrera = em_cve_carrera.text
ll_cve_carrrera = Long (ls_cve_carrrera)

ll_num_rows=  dw_1.RowCount()
if ll_num_rows <= 0 then
	MessageBox("No hay datos", "Es necesario cargar antes de procesar")
	return
end if

ls_path = "C:\CREDENCIALES\"+ls_cve_carrrera+"\"

li_FileNum = FileOpen(ls_path+"16022006.TXT", LineMode!, Write!, LockWrite!, Append!)
li_file_sin_foto= FileOpen(ls_path+"16022006_sinfoto.TXT", LineMode!, Write!, LockWrite!, Append!)

ls_separador = ";"
ls_formato = ""
FOR ll_row_actual= 1 to ll_num_rows
	ll_matricula = dw_1.GetItemNumber(ll_row_actual, "matricula")
	ls_apellidos  = dw_1.GetItemString(ll_row_actual, "apellidos")
	ls_nombre  = dw_1.GetItemString(ll_row_actual, "alumnos_nombre")
	ls_carrera  = dw_1.GetItemString(ll_row_actual, "carrera")
	ls_grabacion_causa = dw_1.GetItemString(ll_row_actual, "grabacion_causa")
	ls_tipo_de_grupo = dw_1.GetItemString(ll_row_actual, "tipo_de_grupo")
//	ls_nombre_de_la_imagen = dw_1.GetItemString(ll_row_actual, "nombre_de_la_imagen")
	
	ls_digito = obten_digito(ll_matricula)
	ls_matricula = string(ll_matricula,"0000000")+ls_digito
	
	li_num_spaces = 30 - len(ls_apellidos) 
	ls_formato =space(li_num_spaces)
	ls_apellidos =ls_apellidos +ls_formato

	li_num_spaces = 30 - len(ls_nombre) 
	ls_formato =space(li_num_spaces)
	ls_nombre =ls_nombre+ls_formato
	
	li_num_spaces = 30 - len(ls_carrera) 
	ls_formato =space(li_num_spaces)
	ls_carrera =ls_carrera+ls_formato
	
	ls_grabacion_causa =ls_grabacion_causa
	ls_tipo_de_grupo =ls_tipo_de_grupo
	
	ls_nombre_de_la_imagen = string(ll_matricula,"00000000")+".jpg"
	
blob	lblob_foto
	SetNull(lblob_foto)
	SELECTBLOB credenciales_bd.dbo.fotos_alumnos.foto
	INTO :lblob_foto 
	FROM credenciales_bd.dbo.fotos_alumnos
	WHERE credenciales_bd.dbo.fotos_alumnos.cuenta = :ll_matricula
	Using gtr_sce;

	if not isnull(lblob_foto) then
		li_FileNumBlob = FileOpen(ls_path+ls_nombre_de_la_imagen,StreamMode!,Write!,LockReadWrite!,Replace!)
		FileWrite(li_FileNumBlob, lblob_foto)
		FileClose (li_FileNumBlob)
	
		ls_registro = ls_matricula +ls_separador +ls_apellidos+ls_separador+ls_nombre+ls_separador+ &
					ls_carrera+ ls_separador+ ls_grabacion_causa+ls_separador+ls_tipo_de_grupo+ ls_separador+&
					ls_nombre_de_la_imagen	 
	
		FileWrite(li_FileNum, ls_registro)
	else
		ls_registro = ls_matricula +ls_separador +ls_apellidos+ls_separador+ls_nombre+ls_separador+ &
					ls_carrera+ ls_separador+ ls_grabacion_causa+ls_separador+ls_tipo_de_grupo+ ls_separador+&
					ls_nombre_de_la_imagen	 
		FileWrite(li_file_sin_foto, ls_registro)
	end if

NEXT
FileClose(li_FileNum)
FileClose(li_file_sin_foto)
SetPointer ( Arrow! )
end event

type dw_1 from datawindow within w_alumnos_credenciales_falt
integer x = 366
integer y = 444
integer width = 2720
integer height = 476
integer taborder = 20
string dataobject = "d_alumnos_credenciales_falt_carr"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(gtr_sce)
end event

