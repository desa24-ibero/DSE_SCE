$PBExportHeader$w_imp_kardex_2013.srw
forward
global type w_imp_kardex_2013 from w_master_main
end type
type lds_prueba from datawindow within w_imp_kardex_2013
end type
type lds_revision_est from datawindow within w_imp_kardex_2013
end type
type dw_alumnos_carrera from uo_master_dw within w_imp_kardex_2013
end type
type dw_carreras from uo_master_dw within w_imp_kardex_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_imp_kardex_2013
end type
type rb_1 from radiobutton within w_imp_kardex_2013
end type
type rb_2 from radiobutton within w_imp_kardex_2013
end type
type gb_1 from groupbox within w_imp_kardex_2013
end type
type gb_2 from groupbox within w_imp_kardex_2013
end type
type dw_preview_kardex from uo_master_dw within w_imp_kardex_2013
end type
end forward

global type w_imp_kardex_2013 from w_master_main
integer width = 5179
integer height = 3412
string title = "Impresión de Kárdex"
string menuname = "m_imprime_kardex_2013"
event ue_imprime_todos ( )
event ue_imprime_kardex ( )
event ue_elimina_cuenta ( )
event ue_limpiar_sel ( )
lds_prueba lds_prueba
lds_revision_est lds_revision_est
dw_alumnos_carrera dw_alumnos_carrera
dw_carreras dw_carreras
uo_nombre uo_nombre
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
gb_2 gb_2
dw_preview_kardex dw_preview_kardex
end type
global w_imp_kardex_2013 w_imp_kardex_2013

type variables
datawindowchild idwc_carreras
long il_cuentas[], il_carreras[],il_carrera_alumno[]
end variables

forward prototypes
public subroutine wf_recupera_lista_cuenta ()
public function integer wf_genera_consulta_kardex (long an_renglon)
end prototypes

event ue_imprime_todos();int li_i

for li_i = 1 to dw_alumnos_carrera.Rowcount()
	if wf_genera_consulta_kardex(li_i) = 1 then
		dw_preview_kardex.Print()
	end if
end for
end event

event ue_imprime_kardex();SetPointer(HourGlass!)
openwithparm(conf_impr,dw_preview_kardex)
end event

event ue_elimina_cuenta();if dw_alumnos_carrera.Getrow() > 0 then
	dw_alumnos_carrera.Deleterow(dw_alumnos_carrera.Getrow())
else
	messagebox('Aviso','Debe de escoger una cuenta a eliminar de la lista')
end if
end event

event ue_limpiar_sel();long ll_var[]

il_cuentas[] = ll_var[]
il_carreras[] = ll_var[]
il_carrera_alumno[] = ll_var[]
dw_alumnos_carrera.Reset()
dw_preview_kardex.Reset()
uo_nombre.dw_nombre_alumno.Reset()
uo_nombre.dw_nombre_alumno.Insertrow(0)
uo_nombre.dw_carreras.Reset()
uo_nombre.dw_carreras.Insertrow(0)
dw_carreras.Reset()
dw_carreras.Insertrow(0)
uo_nombre.em_cuenta.text = ''
uo_nombre.em_digito.text = ''
rb_1.checked = false
rb_2.checked = false

end event

public subroutine wf_recupera_lista_cuenta ();string ls_query_ori,ls_query_mod,ls_query, ls_cadena_cuentas,ls_cadena_carreras,ls_cadena_alumnos
int li_i,li_sw

ls_query_ori = dw_alumnos_carrera.GetSqlSelect()

for li_i = 1 to upperbound(il_cuentas[]) 
	if li_i = 1 then 
		ls_cadena_cuentas = string(il_cuentas[li_i]) +  ','
	else
		ls_cadena_cuentas = ls_cadena_cuentas  +string(il_cuentas[li_i]) +  ','
	end if
end for

for li_i = 1 to upperbound(il_carreras[]) 
	if li_i = 1 then 
		ls_cadena_carreras = string(il_carreras[li_i]) +  ','
	else
		ls_cadena_carreras = ls_cadena_carreras + string(il_carreras[li_i]) +  ','
	end if
end for

for li_i = 1 to upperbound(il_carrera_alumno[]) 
	if li_i = 1 then 
		ls_cadena_alumnos = string(il_carrera_alumno[li_i]) +  ','
	else
		ls_cadena_alumnos = ls_cadena_alumnos + string(il_carrera_alumno[li_i]) +  ','
	end if
end for

if len(ls_cadena_cuentas) > 0 then
	ls_cadena_cuentas = mid(ls_cadena_cuentas,1,(len(ls_cadena_cuentas) - 1))
	ls_cadena_alumnos = mid(ls_cadena_alumnos,1,(len(ls_cadena_alumnos) - 1))
	ls_query = 	ls_query + ' and ( ( alumnos.cuenta in ( '+ ls_cadena_cuentas + ' ) and v_sce_carreras_cursadas.cve_carrera in ('+ ls_cadena_alumnos+') ) '
else
	ls_query = 	ls_query + ' and ( ( alumnos.cuenta in ( null ) ) '
end if

if len(ls_cadena_carreras) > 0 then
	ls_cadena_carreras = mid(ls_cadena_carreras,1,(len(ls_cadena_carreras) - 1))
	ls_query = 	ls_query + ' or ( v_sce_carreras_cursadas.cve_carrera in ( '+ ls_cadena_carreras + ' ) ) )'
else
	ls_query = 	ls_query + ' or ( v_sce_carreras_cursadas.cve_carrera in ( null ) ) )'
end if

ls_query_mod = ls_query_ori + ls_query + ' ORDER BY alumnos.cuenta ASC'
dw_alumnos_carrera. SetSqlSelect(ls_query_mod)
dw_alumnos_carrera.Retrieve()
dw_alumnos_carrera. SetSqlSelect(ls_query_ori)
end subroutine

public function integer wf_genera_consulta_kardex (long an_renglon);long ll_cuenta,ll_carrera,ll_plan,ll_subsis
int li_baja_disciplina,li_i
string ls_nivel
DataWindowChild ldc_revision

dw_alumnos_carrera.Selectrow(0,false)
dw_alumnos_carrera.Selectrow(an_renglon,true)

ll_cuenta = dw_alumnos_carrera.Getitemnumber(an_renglon,'cuenta')
ll_carrera = dw_alumnos_carrera.Getitemnumber(an_renglon,'v_sce_carreras_cursadas_cve_carrera')
ll_plan = dw_alumnos_carrera.Getitemnumber(an_renglon,'v_sce_carreras_cursadas_cve_plan')
ll_subsis = dw_alumnos_carrera.Getitemnumber(an_renglon,'v_sce_carreras_cursadas_cve_subsistema')
ls_nivel = dw_alumnos_carrera.Getitemstring(an_renglon,'v_sce_carreras_cursadas_nivel')

//***********************************
DATAWINDOWCHILD ldw_acreditacion
DATAWINDOWCHILD  ldw
dw_preview_kardex.GETCHILD("dw_preview_kardex", ldw)
ldw.GETCHILD("historico_observacion", ldw_acreditacion)
ldw_acreditacion.SETTRANSOBJECT(gtr_sce)
ldw_acreditacion.RETRIEVE()



//***********************************

dw_preview_kardex.Retrieve(ll_cuenta,ll_carrera,ll_plan)
li_baja_disciplina = f_obten_baja_disciplina(ll_cuenta)
if li_baja_disciplina  > 0 then
	Messagebox("Alumno Bloqueado por disciplina","No se puede imprimir el kardex de un alumno " + string(ll_cuenta) +" bloqueado por disciplina")
	m_imprime_kardex_2013.m_impresion.m_imprime.enabled = false
	m_imprime_kardex_2013.m_impresion.m_imprimirk.enabled = false
	Return -1
end if

/*************/

LONG ll_row, res 
LONG cuenta 
STRING ls_gpo, ls_filtro_intercambio 
LONG ll_cve_mat
INTEGER li_periodo
INTEGER li_anio, li_materia_en_intercambio_temp

dw_preview_kardex.GETCHILD("dw_preview_kardex", ldw)
res = ldw.ROWCOUNT() 	
if res >= 0 then
	FOR ll_row = 1 TO res
		ls_gpo = ldw.GetItemString(ll_row,"historico_gpo")

		if ls_gpo = "ZZ" then

			//ll_cuenta = cuenta
			ll_cve_mat = ldw.GetItemNumber(ll_row,"historico_cve_mat")
			li_periodo = ldw.GetItemNumber(ll_row,"historico_periodo")
			li_anio = ldw.GetItemNumber(ll_row,"historico_anio")

			li_materia_en_intercambio_temp = f_materia_en_intercambio_temp(ll_cuenta, ll_cve_mat, ls_gpo, li_periodo, li_anio)

			if li_materia_en_intercambio_temp = 1 then
					ldw.SetItem(ll_row,"hti", li_materia_en_intercambio_temp)
			end if

		end if
	NEXT
	ls_filtro_intercambio = "hti = 0"
	ldw.SetFilter(ls_filtro_intercambio)
	ldw.Filter( )
END IF
/************/


m_imprime_kardex_2013.m_impresion.m_imprime.enabled = true
m_imprime_kardex_2013.m_impresion.m_imprimirk.enabled = true
dw_preview_kardex.Getchild("dw_rev_est_fmc_child",ldc_revision)
lds_revision_est.Reset()
ldc_revision.Reset()
lds_prueba.Reset()
hist_alumno_areas(ll_cuenta,ll_carrera,ll_plan,ll_subsis,lds_prueba,lds_revision_est,ls_nivel)
for li_i = 1 to lds_revision_est.Rowcount()
	ldc_revision.insertrow(0)
	ldc_revision.SetItem(li_i,"minimos",lds_revision_est.GetItemNumber(li_i ,"minimos"))
	ldc_revision.SetItem(li_i,"cursados",lds_revision_est.GetItemNumber(li_i ,"cursados"))
next



return 1
end function

on w_imp_kardex_2013.create
int iCurrent
call super::create
if this.MenuName = "m_imprime_kardex_2013" then this.MenuID = create m_imprime_kardex_2013
this.lds_prueba=create lds_prueba
this.lds_revision_est=create lds_revision_est
this.dw_alumnos_carrera=create dw_alumnos_carrera
this.dw_carreras=create dw_carreras
this.uo_nombre=create uo_nombre
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_preview_kardex=create dw_preview_kardex
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lds_prueba
this.Control[iCurrent+2]=this.lds_revision_est
this.Control[iCurrent+3]=this.dw_alumnos_carrera
this.Control[iCurrent+4]=this.dw_carreras
this.Control[iCurrent+5]=this.uo_nombre
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.dw_preview_kardex
end on

on w_imp_kardex_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lds_prueba)
destroy(this.lds_revision_est)
destroy(this.dw_alumnos_carrera)
destroy(this.dw_carreras)
destroy(this.uo_nombre)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_preview_kardex)
end on

event open;call super::open;dw_alumnos_carrera.Settransobject(gtr_sce)
dw_preview_kardex.Settransobject(gtr_sce)
dw_carreras.Getchild('cve_carrera',idwc_carreras)
idwc_carreras.Settransobject(gtr_sce)
idwc_carreras.Retrieve()
dw_carreras.insertrow(0)
end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;int li_cont
long ll_cuenta,ll_carrera
char lch_digito,lch_dig

ll_cuenta = long(uo_nombre.of_obten_cuenta())
ll_carrera = uo_nombre.istr_carrera.str_cve_carrera

if ll_carrera = 0 then return

if ll_cuenta > 1 then
	li_cont = upperbound(il_cuentas[])
	li_cont ++
	il_cuentas[li_cont] = ll_cuenta
	li_cont = upperbound(il_carrera_alumno[])
	li_cont ++
	il_carrera_alumno[li_cont] = ll_carrera
	wf_recupera_lista_cuenta()
end if
end event

type st_sistema from w_master_main`st_sistema within w_imp_kardex_2013
integer x = 722
end type

type p_ibero from w_master_main`p_ibero within w_imp_kardex_2013
integer x = 23
integer y = 16
end type

type lds_prueba from datawindow within w_imp_kardex_2013
boolean visible = false
integer x = 2382
integer y = 2204
integer width = 494
integer height = 68
string dataobject = "dw_certificado_ext2"
boolean livescroll = true
end type

type lds_revision_est from datawindow within w_imp_kardex_2013
boolean visible = false
integer x = 1865
integer y = 2204
integer width = 489
integer height = 76
string dataobject = "dw_rev_est_fmc"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_alumnos_carrera from uo_master_dw within w_imp_kardex_2013
integer x = 3310
integer y = 392
integer width = 1723
integer height = 400
integer taborder = 40
string dataobject = "dw_alumnos_carrera_2013"
boolean hscrollbar = false
boolean border = true
end type

event itemchanged;call super::itemchanged;if row = 0 then return

wf_genera_consulta_kardex(row)
end event

event clicked;call super::clicked;if row = 0 then return

wf_genera_consulta_kardex(row)
end event

type dw_carreras from uo_master_dw within w_imp_kardex_2013
event ue_imprime_todos ( )
event ue_imprime_kardex ( )
event ue_elimina_cuenta ( )
event ue_limpiar_sel ( )
integer x = 1728
integer y = 180
integer width = 1193
integer height = 84
integer taborder = 20
string dataobject = "dddw_lista_carreras_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;int li_cont
long ll_carrera

ll_carrera = idwc_carreras.Getitemnumber(idwc_carreras.Getrow(),'cve_carrera')

li_cont = upperbound(il_carreras[])
li_cont ++
il_carreras[li_cont] = ll_carrera
wf_recupera_lista_cuenta()
end event

type uo_nombre from uo_carreras_alumno_lista within w_imp_kardex_2013
integer x = 18
integer y = 296
integer width = 3241
integer height = 512
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;//m_imprime_kardex_2013.objeto = this
end event

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

type rb_1 from radiobutton within w_imp_kardex_2013
integer x = 1175
integer y = 80
integer width = 398
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Por cuenta"
end type

event clicked;uo_nombre.Setfocus()
end event

type rb_2 from radiobutton within w_imp_kardex_2013
integer x = 1175
integer y = 180
integer width = 398
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Por carrera"
end type

event clicked;dw_carreras.Setfocus()
end event

type gb_1 from groupbox within w_imp_kardex_2013
integer x = 3273
integer y = 264
integer width = 1783
integer height = 548
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Cuentas a Imprimir"
end type

type gb_2 from groupbox within w_imp_kardex_2013
integer x = 1056
integer width = 2181
integer height = 288
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Imprimir por"
end type

type dw_preview_kardex from uo_master_dw within w_imp_kardex_2013
integer x = 18
integer y = 844
integer width = 5042
integer height = 2140
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_composite_kardex_2013"
boolean resizable = true
boolean border = true
end type

event constructor;call super::constructor;idw_trabajo = this
end event

