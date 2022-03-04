$PBExportHeader$w_revision_estudios.srw
forward
global type w_revision_estudios from window
end type
type st_regularizacion from statictext within w_revision_estudios
end type
type cbx_legal from checkbox within w_revision_estudios
end type
type em_fecha from editmask within w_revision_estudios
end type
type st_nivel from statictext within w_revision_estudios
end type
type em_numero from editmask within w_revision_estudios
end type
type st_con_fecha from statictext within w_revision_estudios
end type
type rb_expediente from radiobutton within w_revision_estudios
end type
type rb_folio from radiobutton within w_revision_estudios
end type
type rb_oficio from radiobutton within w_revision_estudios
end type
type st_prerrequisito from statictext within w_revision_estudios
end type
type st_plan from statictext within w_revision_estudios
end type
type st_carrera from statictext within w_revision_estudios
end type
type st_subsistema from statictext within w_revision_estudios
end type
type st_18 from statictext within w_revision_estudios
end type
type st_15 from statictext within w_revision_estudios
end type
type st_14 from statictext within w_revision_estudios
end type
type st_1 from statictext within w_revision_estudios
end type
type uo_1 from uo_nombre_alumno within w_revision_estudios
end type
type cb_2 from commandbutton within w_revision_estudios
end type
type st_13 from statictext within w_revision_estudios
end type
type st_12 from statictext within w_revision_estudios
end type
type st_11 from statictext within w_revision_estudios
end type
type st_10 from statictext within w_revision_estudios
end type
type st_9 from statictext within w_revision_estudios
end type
type st_8 from statictext within w_revision_estudios
end type
type st_7 from statictext within w_revision_estudios
end type
type st_6 from statictext within w_revision_estudios
end type
type st_5 from statictext within w_revision_estudios
end type
type st_4 from statictext within w_revision_estudios
end type
type st_3 from statictext within w_revision_estudios
end type
type st_2 from statictext within w_revision_estudios
end type
type dw_revision_est_fmc from datawindow within w_revision_estudios
end type
type dw_prueba from datawindow within w_revision_estudios
end type
type gb_revalidacion from groupbox within w_revision_estudios
end type
type r_1 from rectangle within w_revision_estudios
end type
end forward

global type w_revision_estudios from window
integer x = 832
integer y = 352
integer width = 3369
integer height = 2412
boolean titlebar = true
string title = "Revision de Estudios"
string menuname = "m_revision_estudios"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 8421376
st_regularizacion st_regularizacion
cbx_legal cbx_legal
em_fecha em_fecha
st_nivel st_nivel
em_numero em_numero
st_con_fecha st_con_fecha
rb_expediente rb_expediente
rb_folio rb_folio
rb_oficio rb_oficio
st_prerrequisito st_prerrequisito
st_plan st_plan
st_carrera st_carrera
st_subsistema st_subsistema
st_18 st_18
st_15 st_15
st_14 st_14
st_1 st_1
uo_1 uo_1
cb_2 cb_2
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
dw_revision_est_fmc dw_revision_est_fmc
dw_prueba dw_prueba
gb_revalidacion gb_revalidacion
r_1 r_1
end type
global w_revision_estudios w_revision_estudios

type variables
long il_cve_carrera = 0, il_cve_plan = 0
string is_nivel = ""
boolean ib_legalizado = false
n_cortes in_cortes

end variables

forward prototypes
public subroutine visual (boolean vis)
public function string alinea (ref string linea, integer tamanio)
end prototypes

public subroutine visual (boolean vis);gb_revalidacion.visible = vis
rb_oficio.visible = vis
rb_folio.visible = vis
rb_expediente.visible = vis
em_numero.visible = vis
em_fecha.visible = vis
st_con_fecha.visible = vis
rb_oficio.checked = true
em_numero.text = "0"
em_fecha.text = "00/00/0000"
end subroutine

public function string alinea (ref string linea, integer tamanio);int li_Tam, li_i, li_j
li_i = 1
li_j = 1
string ls_LineaReg = "     "

li_Tam = len (Linea)
if li_Tam <= Tamanio then
	return ""
else
	if trim(Mid(Linea,Tamanio+1)) = "" then
	//if Mid(Linea,Tamanio+1,1) = " " then
		Linea = Left(linea, Tamanio)
		return ls_LineaReg + Mid(Linea, Tamanio+2)
	else
		do while li_j < tamanio
			li_i = li_j
			li_j = Pos(Linea," ",li_i + 1)
			if li_j = 0 then li_j = tamanio + 1
		loop
		ls_LineaReg += Mid(Linea, li_i + 1)
		Linea = Left(linea,li_i - 1)
		return ls_LineaReg
	end if
end if
end function

on w_revision_estudios.create
if this.MenuName = "m_revision_estudios" then this.MenuID = create m_revision_estudios
this.st_regularizacion=create st_regularizacion
this.cbx_legal=create cbx_legal
this.em_fecha=create em_fecha
this.st_nivel=create st_nivel
this.em_numero=create em_numero
this.st_con_fecha=create st_con_fecha
this.rb_expediente=create rb_expediente
this.rb_folio=create rb_folio
this.rb_oficio=create rb_oficio
this.st_prerrequisito=create st_prerrequisito
this.st_plan=create st_plan
this.st_carrera=create st_carrera
this.st_subsistema=create st_subsistema
this.st_18=create st_18
this.st_15=create st_15
this.st_14=create st_14
this.st_1=create st_1
this.uo_1=create uo_1
this.cb_2=create cb_2
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_revision_est_fmc=create dw_revision_est_fmc
this.dw_prueba=create dw_prueba
this.gb_revalidacion=create gb_revalidacion
this.r_1=create r_1
this.Control[]={this.st_regularizacion,&
this.cbx_legal,&
this.em_fecha,&
this.st_nivel,&
this.em_numero,&
this.st_con_fecha,&
this.rb_expediente,&
this.rb_folio,&
this.rb_oficio,&
this.st_prerrequisito,&
this.st_plan,&
this.st_carrera,&
this.st_subsistema,&
this.st_18,&
this.st_15,&
this.st_14,&
this.st_1,&
this.uo_1,&
this.cb_2,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_revision_est_fmc,&
this.dw_prueba,&
this.gb_revalidacion,&
this.r_1}
end on

on w_revision_estudios.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_regularizacion)
destroy(this.cbx_legal)
destroy(this.em_fecha)
destroy(this.st_nivel)
destroy(this.em_numero)
destroy(this.st_con_fecha)
destroy(this.rb_expediente)
destroy(this.rb_folio)
destroy(this.rb_oficio)
destroy(this.st_prerrequisito)
destroy(this.st_plan)
destroy(this.st_carrera)
destroy(this.st_subsistema)
destroy(this.st_18)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.cb_2)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_revision_est_fmc)
destroy(this.dw_prueba)
destroy(this.gb_revalidacion)
destroy(this.r_1)
end on

event doubleclicked;boolean rev = false
int li_baja_laboratorio, li_baja_disciplina
long cue, ll_cuenta
int car, pla, sub, mat, li_valida_historia_acad
string nivel
string subs, vigs

integer  li_PEgre, li_egresado_anterior, li_carrera_plan_sub_niv, li_actualiza_egresado, li_confirma_periodo
long ll_AEgre, ll_creditos
Decimal ld_promedio

long ll_cve_Carrera, ll_cve_Plan, ll_Cve_Subsistema
string ls_Nivel, ls_nombre_periodo
integer li_res_periodo_egreso, li_AEgre


cue = long(uo_1.em_cuenta.text)
ll_cuenta = cue

visual(false)
st_regularizacion.visible = false

SELECT cve_carrera, cve_plan, cve_subsistema, nivel INTO :car, :pla, :sub ,:Nivel
FROM academicos WHERE cuenta = :cue using gtr_sce;


il_cve_carrera = car
il_cve_plan = pla
is_nivel = Nivel

li_valida_historia_acad = f_valida_historia_academica(cue, car, pla)
IF li_valida_historia_acad> 0 THEN
	MessageBox("Inconsistencia En Materias", "Favor de revisar materias aprobadas repetidas",StopSign!)
	RETURN
ELSEIF li_valida_historia_acad= -1 THEN
	MessageBox("Error en validación de Materias", "Favor de intentar nuevamente",StopSign!)
	RETURN	
END IF

//Revisa que el alumno no este dado de baja por adeudo de material de laboratorio
li_baja_laboratorio = f_obten_baja_laboratorio(ll_cuenta)
if li_baja_laboratorio = 1 then
	MessageBox("Adeudo de Laboratorio","El alumno tiene adeudos de material de laboratorio",StopSign!)
	RETURN			
elseif li_baja_laboratorio = -1 then
	MessageBox("Error en Laboratorio","No es posible consultar la baja por laboratorio",StopSign!)
	RETURN			
end if
//Revisa que el alumno no este dado de baja por disciplina
li_baja_disciplina = f_obten_baja_disciplina(ll_cuenta)
if li_baja_disciplina = 1 then
	MessageBox("Baja por Disciplina","El alumno esta dado de baja por disciplina",StopSign!)
	RETURN			
elseif li_baja_disciplina = -1 then
	MessageBox("Error en  Disciplina","No es posible consultar la baja por disciplina",StopSign!)
	RETURN			
end if


if isnull(sub) then sub = 0

if sub = 0 then
	st_subsistema.text = "Subsistema:  No Registrado"
else
	SELECT subsistema INTO :subs FROM subsistema
	WHERE cve_carrera = :car AND cve_plan = :pla AND cve_subsistema = :sub using gtr_sce;
	st_subsistema.text = "Subsistema:  "+subs
end if

if car = 0 then
	st_carrera.text = "Carrera:        No Registrada"
else
	SELECT carrera INTO :subs FROM carreras
	WHERE cve_carrera = :car using gtr_sce;
	st_carrera.text = "Carrera:        "+subs
end if

if pla = 0 then
	st_plan.text = "Plan:             No Registrado"
	st_nivel.text = "0000 "
else
	SELECT nombre_plan INTO :subs FROM nombre_plan
	WHERE cve_plan = :pla using gtr_sce;
	st_plan.text = "Plan:             "+subs
	st_nivel.text = "0000/0000 "
	SELECT vigencia INTO :vigs FROM plan_estudios
	WHERE cve_plan = :pla AND cve_carrera = :car using gtr_sce;
	if gtr_sce.sqlcode = 0 and not isnull(vigs) then st_nivel.text = vigs+" "
end if
	
//if nivel = "L" then
if nivel <> "P" then
	st_nivel.text += "LICENCIATURA"
else
	st_nivel.text += "POSGRADO"
end if

SELECT COUNT(cve_mat) INTO :mat FROM historico 
WHERE cuenta = :cue AND cve_mat = 4078 ANd calificacion = "AC" using gtr_sce;

if gtr_sce.sqlcode = 0 and mat >= 1 then	
		st_prerrequisito.text = "Ya cursó Prerrequisito de Ingles"
else
		st_prerrequisito.text = "No cursó Prerrequisito de Ingles"	
end if

dw_prueba.reset()
dw_revision_est_fmc.reset()


rev = hist_alumno_areas(cue,car,pla,sub,dw_prueba, dw_revision_est_fmc,nivel)
if dw_prueba.RowCount() >= 2 then
	if dw_prueba.GetItemString(2,"obs") = " *" then	st_regularizacion.visible = true
end if
if rev then	
	visual(rev)
	em_numero.setfocus()
end if


end event

event open;//g_nv_security.fnv_secure_window (this)

this.x=1
this.y=1
if not isvalid(in_cortes) then
	in_cortes = create n_cortes
end if

uo_1.r_1.FillColor = RGB(0,	128,	    128)
uo_1.dw_nombre_alumno.object.datawindow.color = RGB(0,	128,	    128)
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event close;if isvalid(in_cortes) then
	destroy in_cortes 
end if

end event

type st_regularizacion from statictext within w_revision_estudios
boolean visible = false
integer x = 69
integer y = 1852
integer width = 1330
integer height = 152
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
string text = "Certificado Regularizado"
boolean focusrectangle = false
end type

type cbx_legal from checkbox within w_revision_estudios
integer x = 119
integer y = 1188
integer width = 389
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
string text = "legalizado"
end type

event clicked;//Legalizado
if this.checked= true then
	ib_legalizado = true
else
	ib_legalizado = false	
end if

end event

type em_fecha from editmask within w_revision_estudios
boolean visible = false
integer x = 1202
integer y = 1452
integer width = 347
integer height = 84
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "2"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

type st_nivel from statictext within w_revision_estudios
integer x = 87
integer y = 1004
integer width = 617
integer height = 132
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
boolean enabled = false
string text = "0000 LICENCIATURA"
boolean focusrectangle = false
end type

type em_numero from editmask within w_revision_estudios
string tag = "1"
boolean visible = false
integer x = 411
integer y = 1452
integer width = 512
integer height = 84
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!"
string displaydata = ""
end type

type st_con_fecha from statictext within w_revision_estudios
boolean visible = false
integer x = 928
integer y = 1452
integer width = 270
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
boolean enabled = false
string text = "con fecha"
boolean focusrectangle = false
end type

type rb_expediente from radiobutton within w_revision_estudios
boolean visible = false
integer x = 105
integer y = 1620
integer width = 379
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
string text = "Expediente"
end type

type rb_folio from radiobutton within w_revision_estudios
boolean visible = false
integer x = 105
integer y = 1532
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
string text = "Folio"
end type

type rb_oficio from radiobutton within w_revision_estudios
boolean visible = false
integer x = 105
integer y = 1436
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
string text = "Oficio"
boolean checked = true
end type

type st_prerrequisito from statictext within w_revision_estudios
integer x = 87
integer y = 908
integer width = 1426
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
boolean enabled = false
string text = "No cursó Prerrequisito de Ingles"
boolean focusrectangle = false
end type

type st_plan from statictext within w_revision_estudios
integer x = 87
integer y = 612
integer width = 1426
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
boolean enabled = false
string text = "Plan:             No Registrado"
boolean focusrectangle = false
end type

type st_carrera from statictext within w_revision_estudios
integer x = 82
integer y = 460
integer width = 1426
integer height = 156
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
boolean enabled = false
string text = "Carrrera:       No Registrada"
boolean focusrectangle = false
end type

type st_subsistema from statictext within w_revision_estudios
integer x = 87
integer y = 756
integer width = 1426
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
boolean enabled = false
string text = "Subsistema:  No Registrado"
boolean focusrectangle = false
end type

type st_18 from statictext within w_revision_estudios
integer x = 2729
integer y = 464
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Faltantes"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_15 from statictext within w_revision_estudios
integer x = 2976
integer y = 464
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Completa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_14 from statictext within w_revision_estudios
integer x = 2482
integer y = 464
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Cursados"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_revision_estudios
integer x = 2235
integer y = 464
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mínimos"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_nombre_alumno within w_revision_estudios
integer x = 27
integer y = 12
integer height = 428
integer taborder = 10
boolean enabled = true
long backcolor = 8421376
end type

on uo_1.destroy
call uo_nombre_alumno::destroy
end on

type cb_2 from commandbutton within w_revision_estudios
integer x = 1714
integer y = 464
integer width = 503
integer height = 96
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime"
end type

event clicked;if dw_prueba.rowcount() >= 2 then
	open(w_opciones_imprimir,w_revision_estudios)
	parent.triggerevent(" doubleclicked")
else
	messagebox("Error","No hay algo que imprimir "+string(dw_prueba.rowcount()))
end if


end event

type st_13 from statictext within w_revision_estudios
integer x = 1705
integer y = 1548
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Menor Optativa"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_12 from statictext within w_revision_estudios
integer x = 1705
integer y = 1456
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mayor Optativa"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_11 from statictext within w_revision_estudios
integer x = 1705
integer y = 1372
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema IV"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_10 from statictext within w_revision_estudios
integer x = 1705
integer y = 1280
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema III"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_9 from statictext within w_revision_estudios
integer x = 1705
integer y = 1196
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema II"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within w_revision_estudios
integer x = 1705
integer y = 1104
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema I"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_7 from statictext within w_revision_estudios
integer x = 1705
integer y = 1020
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Fundamental"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_revision_estudios
integer x = 1705
integer y = 928
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Menor Obligatoria"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_revision_estudios
integer x = 1705
integer y = 844
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Servicio Social"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_revision_estudios
integer x = 1705
integer y = 752
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Opción Terminal"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_revision_estudios
integer x = 1705
integer y = 668
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mayor Obligatoria"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_revision_estudios
integer x = 1705
integer y = 576
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Básica"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_revision_est_fmc from datawindow within w_revision_estudios
integer x = 2231
integer y = 576
integer width = 997
integer height = 1180
integer taborder = 30
string dataobject = "dw_rev_est_fmc"
boolean border = false
boolean livescroll = true
end type

type dw_prueba from datawindow within w_revision_estudios
integer x = 485
integer y = 2220
integer width = 1486
integer height = 420
integer taborder = 20
string dataobject = "dw_certificado_ext2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_revalidacion from groupbox within w_revision_estudios
boolean visible = false
integer x = 69
integer y = 1356
integer width = 1504
integer height = 400
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8421376
string text = "Materias equivalentes segun "
end type

type r_1 from rectangle within w_revision_estudios
integer linethickness = 3
integer x = 1664
integer y = 428
integer width = 1595
integer height = 1324
end type

