$PBExportHeader$w_ocup_sal.srw
forward
global type w_ocup_sal from w_master
end type
type uo_periodos from uo_per_ani within w_ocup_sal
end type
type st_2 from statictext within w_ocup_sal
end type
type dw_clase_aula from u_dw within w_ocup_sal
end type
type st_status from statictext within w_ocup_sal
end type
type st_1 from statictext within w_ocup_sal
end type
type em_sal from editmask within w_ocup_sal
end type
type rb_prim from radiobutton within w_ocup_sal
end type
type rb_ver from radiobutton within w_ocup_sal
end type
type rb_fall from radiobutton within w_ocup_sal
end type
type em_año from editmask within w_ocup_sal
end type
type cb_cargar from commandbutton within w_ocup_sal
end type
type st_tot from statictext within w_ocup_sal
end type
type gb_20 from groupbox within w_ocup_sal
end type
type gb_11 from groupbox within w_ocup_sal
end type
type gb_8 from groupbox within w_ocup_sal
end type
type gb_1 from groupbox within w_ocup_sal
end type
type dw_dkwf from u_dw within w_ocup_sal
end type
type dw_mad from u_dw within w_ocup_sal
end type
end forward

global type w_ocup_sal from w_master
integer x = 5
integer y = 4
integer width = 3918
integer height = 2248
string title = "Ocupación de Salones"
string menuname = "m_ocup_sal"
long backcolor = 67108864
uo_periodos uo_periodos
st_2 st_2
dw_clase_aula dw_clase_aula
st_status st_status
st_1 st_1
em_sal em_sal
rb_prim rb_prim
rb_ver rb_ver
rb_fall rb_fall
em_año em_año
cb_cargar cb_cargar
st_tot st_tot
gb_20 gb_20
gb_11 gb_11
gb_8 gb_8
gb_1 gb_1
dw_dkwf dw_dkwf
dw_mad dw_mad
end type
global w_ocup_sal w_ocup_sal

type variables
int periodo_x
uo_periodo_servicios iuo_periodo_servicios


end variables

forward prototypes
public subroutine impr ()
public subroutine resetea (string as_salon, integer ai_cupo_max)
public subroutine llena ()
end prototypes

public subroutine impr ();if dw_mad.rowcount() = 0 then
	MessageBox("Atencion","No hay salones que correspondan")
else
	openwithparm(conf_impr,dw_dkwf)
end if
end subroutine

public subroutine resetea (string as_salon, integer ai_cupo_max);int cont
for cont = 1 to 15
	dw_dkwf.insertrow(0)
	dw_dkwf.setitem(dw_dkwf.RowCount(),"hora",string(cont + 6)+" - "+string(cont + 7))	
	dw_dkwf.setitem(dw_dkwf.RowCount(),"salon",as_salon)	
	dw_dkwf.setitem(dw_dkwf.RowCount(),"cupo",ai_cupo_max)	
	
next

end subroutine

public subroutine llena ();long cont,ren
int dia,column,hora_ini,hora_fin
string sal,matgpocpo,salant
int li_renglon = 0
if dw_mad.rowcount() = 0 then
	MessageBox("Atencion","No hay salones que correspondan")
else
	st_status.text = "0 de "+string(dw_mad.RowCount())
	sal		=	dw_mad.getitemstring(1,"salon_cve_salon")
	dia		=	dw_mad.getitemnumber(1,"horario_cve_dia")
	resetea(sal,dw_mad.getitemnumber(1,"salon_cupo_max"))
	//li_renglon += 15
	/*dw_dkwf.setitem(1,"salon",sal)
	dw_dkwf.setitem(1,"cupo",dw_mad.getitemnumber(1,"salon_cupo_max"))*/
	
	
	hora_ini	=	dw_mad.getitemnumber(1,"horario_hora_inicio")
	hora_fin	=	dw_mad.getitemnumber(1,"horario_hora_final")
	for ren = hora_ini - 6 to hora_fin - 7
		dw_dkwf.setitem(ren,dia + 2,string(dw_mad.getitemnumber(1,"horario_cve_mat"))+" "+dw_mad.getitemstring(1,"horario_gpo")+" "+string(dw_mad.getitemnumber(1,"grupos_inscritos"))+" "+mid(dw_mad.getitemstring(1,"materias_sigla"),1,2))
	next
	salant		=	sal
	for cont = 2 to dw_mad.rowcount()
		sal		=	dw_mad.getitemstring(cont,"salon_cve_salon")
		if sal = salant then
			dia		=	dw_mad.getitemnumber(cont,"horario_cve_dia")		
			sal		=	dw_mad.getitemstring(cont,"salon_cve_salon")
			hora_ini	=	dw_mad.getitemnumber(cont,"horario_hora_inicio")
			hora_fin	=	dw_mad.getitemnumber(cont,"horario_hora_final")
			for ren = hora_ini - 6 to hora_fin - 7
				dw_dkwf.setitem(ren + li_renglon,dia + 2,string(dw_mad.getitemnumber(cont,"horario_cve_mat"))+" "+dw_mad.getitemstring(cont,"horario_gpo")+" "+string(dw_mad.getitemnumber(cont,"grupos_inscritos"))+" "+mid(dw_mad.getitemstring(cont,"materias_sigla"),1,2))
			next				
		else
			resetea(sal,dw_mad.getitemnumber(cont,"salon_cupo_max"))
			li_renglon += 15
			//dw_dkwf.setitem(1,"salon",sal)
			//dw_dkwf.setitem(1,"cupo",dw_mad.getitemnumber(cont,"salon_cupo_max"))
			dia		=	dw_mad.getitemnumber(cont,"horario_cve_dia")
			hora_ini	=	dw_mad.getitemnumber(cont,"horario_hora_inicio")
			hora_fin	=	dw_mad.getitemnumber(cont,"horario_hora_final")
			for ren = hora_ini - 6 to hora_fin - 7
				dw_dkwf.setitem(ren + li_renglon,dia + 2,string(dw_mad.getitemnumber(cont,"horario_cve_mat"))+" "+dw_mad.getitemstring(cont,"horario_gpo")+" "+string(dw_mad.getitemnumber(cont,"grupos_inscritos"))+" "+mid(dw_mad.getitemstring(cont,"materias_sigla"),1,2))
			next	
			salant = sal
		end if	
		salant = sal
		st_status.text = string(cont)+ " de "+string(dw_mad.RowCount())
	next
	dw_dkwf.Sort()
	dw_dkwf.GroupCalc()
	//openwithparm(conf_impr,dw_dkwf)
end if
end subroutine

on w_ocup_sal.create
int iCurrent
call super::create
if this.MenuName = "m_ocup_sal" then this.MenuID = create m_ocup_sal
this.uo_periodos=create uo_periodos
this.st_2=create st_2
this.dw_clase_aula=create dw_clase_aula
this.st_status=create st_status
this.st_1=create st_1
this.em_sal=create em_sal
this.rb_prim=create rb_prim
this.rb_ver=create rb_ver
this.rb_fall=create rb_fall
this.em_año=create em_año
this.cb_cargar=create cb_cargar
this.st_tot=create st_tot
this.gb_20=create gb_20
this.gb_11=create gb_11
this.gb_8=create gb_8
this.gb_1=create gb_1
this.dw_dkwf=create dw_dkwf
this.dw_mad=create dw_mad
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_periodos
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_clase_aula
this.Control[iCurrent+4]=this.st_status
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_sal
this.Control[iCurrent+7]=this.rb_prim
this.Control[iCurrent+8]=this.rb_ver
this.Control[iCurrent+9]=this.rb_fall
this.Control[iCurrent+10]=this.em_año
this.Control[iCurrent+11]=this.cb_cargar
this.Control[iCurrent+12]=this.st_tot
this.Control[iCurrent+13]=this.gb_20
this.Control[iCurrent+14]=this.gb_11
this.Control[iCurrent+15]=this.gb_8
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.dw_dkwf
this.Control[iCurrent+18]=this.dw_mad
end on

on w_ocup_sal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodos)
destroy(this.st_2)
destroy(this.dw_clase_aula)
destroy(this.st_status)
destroy(this.st_1)
destroy(this.em_sal)
destroy(this.rb_prim)
destroy(this.rb_ver)
destroy(this.rb_fall)
destroy(this.em_año)
destroy(this.cb_cargar)
destroy(this.st_tot)
destroy(this.gb_20)
destroy(this.gb_11)
destroy(this.gb_8)
destroy(this.gb_1)
destroy(this.dw_dkwf)
destroy(this.dw_mad)
end on

event open;x	=	1
y	=	1
this.of_SetResize(TRUE)
dw_mad.settransobject(gtr_sce)
dw_clase_aula.settransobject(gtr_sce)
dw_dkwf.modify("Datawindow.print.preview = Yes")
dw_dkwf.modify("Datawindow.print.orientation = 2")


DataWindowChild clase_aula_child

integer rtncode, li_retrieve, li_set_transobject, li_insertrow
rtncode = dw_clase_aula.GetChild('clase_aula', clase_aula_child)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Set the transaction object for the child
clase_aula_child.SetTransObject(gtr_sce)


// Populate with values for eastern states
li_retrieve = clase_aula_child.Retrieve()

//Se inserta un comodín para TODOS
li_insertrow = clase_aula_child.InsertRow(clase_aula_child.RowCount())
clase_aula_child.SetItem(li_insertrow,'clase_aula','TODAS')
clase_aula_child.SetItem(li_insertrow,'num_aulas',0)

	//Modif. Roberto Novoa R.  May/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)


// Set transaction object for main DW and retrieve
li_set_transobject = dw_clase_aula.SetTransObject(gtr_sce)
dw_clase_aula.Retrieve()

dw_dkwf.of_SetResize(TRUE)

end event

type uo_periodos from uo_per_ani within w_ocup_sal
integer x = 512
integer y = 216
integer taborder = 60
boolean enabled = true
end type

on uo_periodos.destroy
call uo_per_ani::destroy
end on

type st_2 from statictext within w_ocup_sal
integer x = 1920
integer y = 296
integer width = 398
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Clase de Aula:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_clase_aula from u_dw within w_ocup_sal
integer x = 2341
integer y = 280
integer width = 521
integer height = 104
integer taborder = 50
string dataobject = "d_salon_clase_aula"
boolean vscrollbar = false
end type

type st_status from statictext within w_ocup_sal
integer x = 14
integer y = 32
integer width = 411
integer height = 236
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_ocup_sal
integer x = 1518
integer y = 116
integer width = 974
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Clave del salon (para traer todos  %)"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_sal from editmask within w_ocup_sal
integer x = 2510
integer y = 116
integer width = 219
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!aaa"
string displaydata = "0"
end type

type rb_prim from radiobutton within w_ocup_sal
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 512
integer y = 196
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
boolean enabled = false
string text = "Primavera"
boolean checked = true
end type

event clicked;periodo_x = 0

end event

event constructor;TabOrder = 0
end event

type rb_ver from radiobutton within w_ocup_sal
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 901
integer y = 196
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
boolean enabled = false
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

event constructor;TabOrder = 0
end event

type rb_fall from radiobutton within w_ocup_sal
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 1216
integer y = 196
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
boolean enabled = false
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

event constructor;TabOrder = 0
end event

type em_año from editmask within w_ocup_sal
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
integer x = 526
integer y = 292
integer width = 219
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "1998"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
string displaydata = "`"
end type

event constructor;TabOrder = 0

int periodo,anio

periodo_actual(periodo,anio,gtr_sce)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño
CHOOSE CASE periodo
	CASE 0
		periodo_x = 0
		rb_prim.checked = TRUE
	CASE 1
		periodo_x = 1
      	rb_ver.checked = TRUE
	CASE 2
		periodo_x = 2
	     rb_fall.checked = TRUE
END CHOOSE
this.text = string(anio)
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type cb_cargar from commandbutton within w_ocup_sal
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3049
integer y = 284
integer width = 265
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;//Parametros enviados al DW
long ll_row, ll_rows_mad
string salon, ls_clase_aula
salon	=	em_sal.text
ll_row = dw_clase_aula.GetRow()
SetPointer(HourGlass!)
if ll_row> 0 then
	ls_clase_aula = dw_clase_aula.GetItemString(ll_row, "clase_aula")
	IF ls_clase_aula = 'TODAS' THEN
		ls_clase_aula = '%'
	END IF
else 
	ls_clase_aula = '%'
end if

if len(salon)	<	4 and len(salon) >=	1 then
	salon = salon +'%'
end if

periodo_x=uo_periodos.iuo_periodo_servicios.f_recupera_id( uo_periodos.em_per.text, "L")

dw_dkwf.reset()
ll_rows_mad = dw_mad.retrieve(periodo_x,long(em_año.text),salon,ls_clase_aula)
st_tot.text	=	"Total : "+string(ll_rows_mad)
w_ocup_sal.llena()


end event

event constructor;TabOrder = 4
end event

type st_tot from statictext within w_ocup_sal
integer x = 2962
integer y = 72
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_20 from groupbox within w_ocup_sal
integer x = 480
integer y = 132
integer width = 1335
integer height = 264
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Periodo"
end type

type gb_11 from groupbox within w_ocup_sal
boolean visible = false
integer x = 471
integer y = 236
integer width = 315
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Año"
end type

type gb_8 from groupbox within w_ocup_sal
integer x = 3017
integer y = 232
integer width = 329
integer height = 176
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ocup_sal
integer x = 434
integer width = 2999
integer height = 432
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Criterios de Busqueda"
end type

type dw_dkwf from u_dw within w_ocup_sal
integer x = 46
integer y = 452
integer width = 3753
integer height = 1464
integer taborder = 90
string dataobject = "dw_rep_horario_salon"
boolean resizable = true
end type

event rbuttondown;zoomout(this)
end event

event clicked;zoomin(this)
end event

type dw_mad from u_dw within w_ocup_sal
integer x = 238
integer y = 1044
integer width = 3154
integer height = 360
integer taborder = 80
string dataobject = "dw_repo_mad_mod_total_sal"
end type

event constructor;SetTransobject(gtr_sce)
end event

