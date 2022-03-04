$PBExportHeader$w_alumnos_credenciales.srw
forward
global type w_alumnos_credenciales from window
end type
type cb_cargar from commandbutton within w_alumnos_credenciales
end type
type cb_generar from commandbutton within w_alumnos_credenciales
end type
type dw_1 from datawindow within w_alumnos_credenciales
end type
end forward

global type w_alumnos_credenciales from window
integer x = 846
integer y = 372
integer width = 3323
integer height = 1228
boolean titlebar = true
string title = "Alumnos Credenciales"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cb_cargar cb_cargar
cb_generar cb_generar
dw_1 dw_1
end type
global w_alumnos_credenciales w_alumnos_credenciales

on w_alumnos_credenciales.create
this.cb_cargar=create cb_cargar
this.cb_generar=create cb_generar
this.dw_1=create dw_1
this.Control[]={this.cb_cargar,&
this.cb_generar,&
this.dw_1}
end on

on w_alumnos_credenciales.destroy
destroy(this.cb_cargar)
destroy(this.cb_generar)
destroy(this.dw_1)
end on

type cb_cargar from commandbutton within w_alumnos_credenciales
integer x = 658
integer y = 196
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

event clicked;dw_1.Retrieve()
end event

type cb_generar from commandbutton within w_alumnos_credenciales
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

event clicked;integer li_FileNum, li_FileNumBlob, li_num_spaces
long ll_num_rows, ll_row_actual, ll_matricula
string ls_matricula, ls_separador, ls_apellidos, ls_nombre, ls_carrera, ls_grabacion_causa
string ls_tipo_de_grupo, ls_nombre_de_la_imagen, ls_registro, ls_digito, ls_path, ls_formato

ll_num_rows=  dw_1.RowCount()
SetPointer(HourGlass!)
if ll_num_rows <= 0 then
	MessageBox("No hay datos", "Es necesario cargar antes de procesar")
	return
end if
ls_path = "C:\CREDENCIALES\"

li_FileNum = FileOpen(ls_path+"CREDENCIALES.TXT", LineMode!, Write!, LockWrite!, Append!)

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
	end if

NEXT
FileClose(li_FileNum)

end event

type dw_1 from datawindow within w_alumnos_credenciales
integer x = 366
integer y = 440
integer width = 2720
integer height = 476
integer taborder = 20
string dataobject = "d_alumnos_credenciales"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(gtr_sce)
end event

