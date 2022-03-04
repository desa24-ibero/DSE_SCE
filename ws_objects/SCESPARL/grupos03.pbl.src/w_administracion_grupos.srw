$PBExportHeader$w_administracion_grupos.srw
forward
global type w_administracion_grupos from window
end type
type cb_borrar_embeded from commandbutton within w_administracion_grupos
end type
type cb_borrar_alumno from commandbutton within w_administracion_grupos
end type
type dw_documentos from datawindow within w_administracion_grupos
end type
type dw_banderas from datawindow within w_administracion_grupos
end type
type st_5 from statictext within w_administracion_grupos
end type
type em_cuenta from editmask within w_administracion_grupos
end type
type ids_sdu from datawindow within w_administracion_grupos
end type
type ids_profesor_auxiliar from datawindow within w_administracion_grupos
end type
type ids_horario from datawindow within w_administracion_grupos
end type
type ids_grupos from datawindow within w_administracion_grupos
end type
type st_4 from statictext within w_administracion_grupos
end type
type st_3 from statictext within w_administracion_grupos
end type
type em_anio from editmask within w_administracion_grupos
end type
type em_periodo from editmask within w_administracion_grupos
end type
type st_2 from statictext within w_administracion_grupos
end type
type cb_borrar_individual from commandbutton within w_administracion_grupos
end type
type st_1 from statictext within w_administracion_grupos
end type
type em_gpo from editmask within w_administracion_grupos
end type
type em_cve_mat from editmask within w_administracion_grupos
end type
end forward

global type w_administracion_grupos from window
integer x = 846
integer y = 372
integer width = 2057
integer height = 1752
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
cb_borrar_embeded cb_borrar_embeded
cb_borrar_alumno cb_borrar_alumno
dw_documentos dw_documentos
dw_banderas dw_banderas
st_5 st_5
em_cuenta em_cuenta
ids_sdu ids_sdu
ids_profesor_auxiliar ids_profesor_auxiliar
ids_horario ids_horario
ids_grupos ids_grupos
st_4 st_4
st_3 st_3
em_anio em_anio
em_periodo em_periodo
st_2 st_2
cb_borrar_individual cb_borrar_individual
st_1 st_1
em_gpo em_gpo
em_cve_mat em_cve_mat
end type
global w_administracion_grupos w_administracion_grupos

type variables
u_administrador_grupos iuo_administrador_grupos
transaction itr_sce
end variables

on w_administracion_grupos.create
this.cb_borrar_embeded=create cb_borrar_embeded
this.cb_borrar_alumno=create cb_borrar_alumno
this.dw_documentos=create dw_documentos
this.dw_banderas=create dw_banderas
this.st_5=create st_5
this.em_cuenta=create em_cuenta
this.ids_sdu=create ids_sdu
this.ids_profesor_auxiliar=create ids_profesor_auxiliar
this.ids_horario=create ids_horario
this.ids_grupos=create ids_grupos
this.st_4=create st_4
this.st_3=create st_3
this.em_anio=create em_anio
this.em_periodo=create em_periodo
this.st_2=create st_2
this.cb_borrar_individual=create cb_borrar_individual
this.st_1=create st_1
this.em_gpo=create em_gpo
this.em_cve_mat=create em_cve_mat
this.Control[]={this.cb_borrar_embeded,&
this.cb_borrar_alumno,&
this.dw_documentos,&
this.dw_banderas,&
this.st_5,&
this.em_cuenta,&
this.ids_sdu,&
this.ids_profesor_auxiliar,&
this.ids_horario,&
this.ids_grupos,&
this.st_4,&
this.st_3,&
this.em_anio,&
this.em_periodo,&
this.st_2,&
this.cb_borrar_individual,&
this.st_1,&
this.em_gpo,&
this.em_cve_mat}
end on

on w_administracion_grupos.destroy
destroy(this.cb_borrar_embeded)
destroy(this.cb_borrar_alumno)
destroy(this.dw_documentos)
destroy(this.dw_banderas)
destroy(this.st_5)
destroy(this.em_cuenta)
destroy(this.ids_sdu)
destroy(this.ids_profesor_auxiliar)
destroy(this.ids_horario)
destroy(this.ids_grupos)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_anio)
destroy(this.em_periodo)
destroy(this.st_2)
destroy(this.cb_borrar_individual)
destroy(this.st_1)
destroy(this.em_gpo)
destroy(this.em_cve_mat)
end on

event open;//iuo_administrador_grupos = CREATE u_administrador_grupos

//CREA LOS DATASTORE A UTILIZAR

if conecta_bd(itr_sce,gs_sce,gs_usuario,gs_password)=1 then

end if
//ids_grupos = CREATE datastore
//ids_horario = CREATE datastore
//ids_profesor_auxiliar = CREATE datastore
//ids_sdu = CREATE datastore

//ids_grupos.dataobject = "d_uo_grupos"
//ids_horario.dataobject = "d_uo_horario"
//ids_profesor_auxiliar.dataobject = "d_uo_profesor_auxiliar"
//ids_sdu.dataobject = "d_uo_salones_derecho_uso"

ids_grupos.SetTransObject(itr_sce)
ids_horario.SetTransObject(itr_sce)
ids_profesor_auxiliar.SetTransObject(itr_sce)
ids_sdu.SetTransObject(itr_sce)


dw_banderas.SetTransObject(itr_sce)
dw_documentos.SetTransObject(itr_sce)


end event

type cb_borrar_embeded from commandbutton within w_administracion_grupos
integer x = 1106
integer y = 280
integer width = 718
integer height = 76
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar EMBEDED grupo"
end type

event clicked;long ll_cve_mat, ll_grupos, ll_horarios, ll_profesores
integer li_periodo, li_anio, li_borra, li_borra_grupo, li_borra_horario, li_borra_profesor
string ls_gpo, ls_cve_mat, ls_periodo, ls_anio




ls_cve_mat = em_cve_mat.text
ls_gpo = em_gpo.text
ls_periodo = em_periodo.text
ls_anio = em_anio.text

ll_cve_mat = long(ls_cve_mat)
li_periodo = integer(ls_periodo)
li_anio = integer(ls_anio)

//li_borra = iuo_administrador_grupos.of_borra_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio, false)

DELETE FROM horario 
WHERE cve_mat = :ll_cve_mat
AND	gpo = :ls_gpo
AND	periodo = :li_periodo
AND	anio = :li_anio
USING itr_sce;

IF itr_sce.sqlcode <> -1 THEN
	DELETE FROM grupos 
	WHERE cve_mat = :ll_cve_mat
	AND	gpo = :ls_gpo
	AND	periodo = :li_periodo
	AND	anio = :li_anio
	USING itr_sce;
	IF itr_sce.sqlcode <> -1 THEN
		MessageBox("DELETE EXITOSO","")
		COMMIT USING itr_sce;
		RETURN
	ELSE	
		GOTO ERROR	
	END IF	
ELSE	
	GOTO ERROR	
END IF



ERROR:
ROLLBACK USING gtr_sce;
MessageBox("ERROR EN DELETE","")




end event

type cb_borrar_alumno from commandbutton within w_administracion_grupos
integer x = 1065
integer y = 616
integer width = 485
integer height = 76
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar CUENTA"
end type

event clicked;long ll_cve_mat, ll_grupos, ll_horarios, ll_profesores, ll_cuenta,ll_banderas, ll_documentos
integer li_periodo, li_anio, li_borra, li_borra_grupo, li_borra_horario, li_borra_profesor
string ls_gpo, ls_cve_mat, ls_periodo, ls_anio, ls_cuenta
integer li_borra_banderas, li_borra_documentos



ls_cuenta = em_cuenta.text
ll_cuenta = long(ls_cuenta)

//li_borra = iuo_administrador_grupos.of_borra_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio, false)

ll_banderas= dw_banderas.Retrieve(ll_cuenta)
ll_documentos= dw_documentos.Retrieve(ll_cuenta)
if ll_banderas >0 then
	li_borra_banderas= dw_banderas.DeleteRow(1)
end if
if ll_documentos >0 then
	li_borra_documentos= dw_documentos.DeleteRow(1)
end if

IF dw_documentos.Update()=1 THEN
	MessageBox("DOCUMENTOS","")
	IF	dw_banderas.Update()=1 THEN
		COMMIT USING itr_sce;
		MessageBox("BIEN ACTUALIZADO","")	
		RETURN
	ELSE
		GOTO ERROR
	END IF
ELSE
	GOTO ERROR
END IF

ERROR:
ROLLBACK USING itr_sce;
MessageBox("ERROR","")




end event

type dw_documentos from datawindow within w_administracion_grupos
integer x = 1358
integer y = 1220
integer width = 503
integer height = 368
integer taborder = 120
string dataobject = "d_uo_documentos"
boolean livescroll = true
end type

type dw_banderas from datawindow within w_administracion_grupos
integer x = 1358
integer y = 804
integer width = 503
integer height = 368
integer taborder = 90
string dataobject = "d_uo_banderas"
boolean livescroll = true
end type

type st_5 from statictext within w_administracion_grupos
integer x = 265
integer y = 572
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Cuenta"
boolean focusrectangle = false
end type

type em_cuenta from editmask within w_administracion_grupos
integer x = 608
integer y = 572
integer width = 251
integer height = 76
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string mask = "#######"
end type

type ids_sdu from datawindow within w_administracion_grupos
integer x = 645
integer y = 1220
integer width = 503
integer height = 368
integer taborder = 130
string dataobject = "d_uo_salones_derecho_uso"
boolean livescroll = true
end type

type ids_profesor_auxiliar from datawindow within w_administracion_grupos
integer x = 64
integer y = 1212
integer width = 503
integer height = 368
integer taborder = 110
string dataobject = "d_uo_profesor_auxiliar"
boolean livescroll = true
end type

type ids_horario from datawindow within w_administracion_grupos
integer x = 649
integer y = 804
integer width = 503
integer height = 368
integer taborder = 100
string dataobject = "d_uo_horario"
boolean livescroll = true
end type

type ids_grupos from datawindow within w_administracion_grupos
integer x = 55
integer y = 800
integer width = 503
integer height = 368
integer taborder = 80
string dataobject = "d_uo_grupos"
boolean livescroll = true
end type

type st_4 from statictext within w_administracion_grupos
integer x = 270
integer y = 412
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Año"
boolean focusrectangle = false
end type

type st_3 from statictext within w_administracion_grupos
integer x = 270
integer y = 252
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Periodo"
boolean focusrectangle = false
end type

type em_anio from editmask within w_administracion_grupos
integer x = 608
integer y = 412
integer width = 251
integer height = 76
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string mask = "####"
end type

type em_periodo from editmask within w_administracion_grupos
integer x = 608
integer y = 252
integer width = 251
integer height = 76
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string mask = "#"
end type

type st_2 from statictext within w_administracion_grupos
integer x = 869
integer y = 96
integer width = 64
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_borrar_individual from commandbutton within w_administracion_grupos
integer x = 1125
integer y = 96
integer width = 581
integer height = 76
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar DW grupo"
end type

event clicked;long ll_cve_mat, ll_grupos, ll_horarios, ll_profesores
integer li_periodo, li_anio, li_borra, li_borra_grupo, li_borra_horario, li_borra_profesor
string ls_gpo, ls_cve_mat, ls_periodo, ls_anio




ls_cve_mat = em_cve_mat.text
ls_gpo = em_gpo.text
ls_periodo = em_periodo.text
ls_anio = em_anio.text

ll_cve_mat = long(ls_cve_mat)
li_periodo = integer(ls_periodo)
li_anio = integer(ls_anio)

//li_borra = iuo_administrador_grupos.of_borra_grupo(ll_cve_mat, ls_gpo, li_periodo, li_anio, false)

ll_grupos= ids_grupos.Retrieve(ll_cve_mat, ls_gpo, li_periodo, li_anio)
ll_horarios= ids_horario.Retrieve(ll_cve_mat, ls_gpo, li_periodo, li_anio)
ll_profesores= ids_profesor_auxiliar.Retrieve(ll_cve_mat, ls_gpo, li_periodo, li_anio)

li_borra_horario= ids_horario.DeleteRow(ids_horario.GetRow())
li_borra_profesor= ids_profesor_auxiliar.DeleteRow(ids_profesor_auxiliar.GetRow())
li_borra_grupo = ids_grupos.DeleteRow(ids_grupos.GetRow())

IF ids_horario.Update()=1 THEN
	MessageBox("","")
	IF	ids_profesor_auxiliar.Update()=1 THEN
		IF	ids_grupos .Update()=1 THEN
			COMMIT USING gtr_sce;
			MessageBox("BIEN ACTUALIZADO","")			
		ELSE
			GOTO ERROR
		END IF
	ELSE
		GOTO ERROR
	END IF
ELSE
	GOTO ERROR
END IF

ERROR:
ROLLBACK USING gtr_sce;
MessageBox("ERROR","")




end event

type st_1 from statictext within w_administracion_grupos
integer x = 270
integer y = 96
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "MATERIA"
boolean focusrectangle = false
end type

type em_gpo from editmask within w_administracion_grupos
integer x = 933
integer y = 96
integer width = 96
integer height = 76
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
maskdatatype maskdatatype = stringmask!
string mask = "ax"
end type

type em_cve_mat from editmask within w_administracion_grupos
integer x = 608
integer y = 100
integer width = 251
integer height = 76
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string mask = "#####"
end type

