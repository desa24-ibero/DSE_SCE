$PBExportHeader$w_grupos_historico.srw
forward
global type w_grupos_historico from window
end type
type uo_1 from uo_per_ani within w_grupos_historico
end type
type st_nombre_materia from statictext within w_grupos_historico
end type
type st_materia from statictext within w_grupos_historico
end type
type em_materia from editmask within w_grupos_historico
end type
type dw_hist_grupos from datawindow within w_grupos_historico
end type
type uo_per from uo_periodo within w_grupos_historico
end type
type rr_1 from roundrectangle within w_grupos_historico
end type
type rr_2 from roundrectangle within w_grupos_historico
end type
end forward

global type w_grupos_historico from window
integer x = 832
integer y = 352
integer width = 4137
integer height = 2352
boolean titlebar = true
string title = "HISTÓRICO DE GRUPOS IMPARTIDOS"
string menuname = "m_salir"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
event modifaño ( )
event modifper ( )
uo_1 uo_1
st_nombre_materia st_nombre_materia
st_materia st_materia
em_materia em_materia
dw_hist_grupos dw_hist_grupos
uo_per uo_per
rr_1 rr_1
rr_2 rr_2
end type
global w_grupos_historico w_grupos_historico

type variables
uo_periodo_servicios iuo_periodo_servicios
Datawindowchild dwc_periodo
end variables

event modifaño;If keydown(keyEnter!)  Then
  em_materia.SetFocus()	
End If  
end event

on w_grupos_historico.create
if this.MenuName = "m_salir" then this.MenuID = create m_salir
this.uo_1=create uo_1
this.st_nombre_materia=create st_nombre_materia
this.st_materia=create st_materia
this.em_materia=create em_materia
this.dw_hist_grupos=create dw_hist_grupos
this.uo_per=create uo_per
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.uo_1,&
this.st_nombre_materia,&
this.st_materia,&
this.em_materia,&
this.dw_hist_grupos,&
this.uo_per,&
this.rr_1,&
this.rr_2}
end on

on w_grupos_historico.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.st_nombre_materia)
destroy(this.st_materia)
destroy(this.em_materia)
destroy(this.dw_hist_grupos)
destroy(this.uo_per)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;dw_hist_grupos.settransobject(gtr_sce)
uo_per.ddlb_periodo.setfocus()

dw_hist_grupos.insertrow(0)

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos(gs_tipo_periodo, gtr_sce)

end event

type uo_1 from uo_per_ani within w_grupos_historico
integer x = 1184
integer y = 108
integer taborder = 30
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_nombre_materia from statictext within w_grupos_historico
integer x = 1102
integer y = 388
integer width = 1911
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_materia from statictext within w_grupos_historico
integer x = 571
integer y = 404
integer width = 256
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Materia:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_materia from editmask within w_grupos_historico
integer x = 832
integer y = 392
integer width = 251
integer height = 100
integer taborder = 20
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

event modified;// Juan Campos.          Junio-1997.
 
integer 	periodo,año
Long		ClaveMateria

periodo=integer(uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L"))
año     = integer(uo_1.em_ani.text)

//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_hist_grupos, dwc_periodo, "periodo")

If dw_hist_grupos.retrieve(Integer(em_materia.text), periodo, año) = 0 Then
    messagebox("Aviso","No hay información de está materia en el periodo y año selecionados")
	 st_nombre_materia.text = ""
    dw_hist_grupos.insertrow(0)
    em_materia.setfocus()
Else
	ClaveMateria = long(em_materia.text)
	Select materia
	into :st_nombre_materia.text
	from materias
	where cve_mat = :ClaveMateria
	using gtr_sce;
End If
  
end event

event getfocus;selectText(1,4)
end event

type dw_hist_grupos from datawindow within w_grupos_historico
integer x = 50
integer y = 620
integer width = 3685
integer height = 1024
integer taborder = 30
string dataobject = "dw_hist_grupos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type uo_per from uo_periodo within w_grupos_historico
boolean visible = false
integer x = 3415
integer y = 132
integer height = 160
integer taborder = 10
boolean enabled = false
end type

on uo_per.destroy
call uo_periodo::destroy
end on

type rr_1 from roundrectangle within w_grupos_historico
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 10789024
integer x = 18
integer y = 584
integer width = 3739
integer height = 1088
integer cornerheight = 40
integer cornerwidth = 41
end type

type rr_2 from roundrectangle within w_grupos_historico
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 10789024
integer x = 544
integer y = 368
integer width = 2501
integer height = 140
integer cornerheight = 40
integer cornerwidth = 41
end type

