$PBExportHeader$w_integracion_2014.srw
forward
global type w_integracion_2014 from w_ancestral
end type
type dw_3 from datawindow within w_integracion_2014
end type
type dw_2 from datawindow within w_integracion_2014
end type
type st_2 from statictext within w_integracion_2014
end type
type st_1 from statictext within w_integracion_2014
end type
type cb_1 from commandbutton within w_integracion_2014
end type
type dw_1 from datawindow within w_integracion_2014
end type
type uo_1 from uo_per_ani within w_integracion_2014
end type
type p_ibero from picture within w_integracion_2014
end type
type st_sistema from statictext within w_integracion_2014
end type
end forward

global type w_integracion_2014 from w_ancestral
integer width = 5189
integer height = 3272
string title = "Corte de Integración"
long backcolor = 16777215
dw_3 dw_3
dw_2 dw_2
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
p_ibero p_ibero
st_sistema st_sistema
end type
global w_integracion_2014 w_integracion_2014

on w_integracion_2014.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.p_ibero=create p_ibero
this.st_sistema=create st_sistema
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.p_ibero
this.Control[iCurrent+9]=this.st_sistema
end on

on w_integracion_2014.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.p_ibero)
destroy(this.st_sistema)
end on

event open;call super::open;//periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_integracion_2014
boolean visible = false
end type

type dw_3 from datawindow within w_integracion_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 1202
integer y = 1600
integer width = 2181
integer height = 900
integer taborder = 30
string dataobject = "d_mat_integra_2014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cont_1,lo_cont_2,lo_cuenta, ll_cve_plan, ll_cve_coordinacion
string ls_tema , ls_calificacion
integer li_calificacion

st_2.text='Terminada la Carga'

dw_1.setsort("banderas_cuenta")
dw_3.setsort("historico_cuenta")
dw_1.sort()
dw_3.sort()

lo_cont_2=1
/*Se hace para TODAS las materias de Integración que se cursaron en el periodo*/
FOR lo_cont_1=1 TO rowcount
	lo_cuenta=dw_3.object.historico_cuenta[lo_cont_1]
	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	DO UNTIL lo_cuenta=dw_1.object.banderas_cuenta[lo_cont_2]
		lo_cont_2=lo_cont_2+1 /*Buscalos en las banderas*/
	LOOP
	
	ls_tema = dw_3.object.tema[lo_cont_1]
	ll_cve_coordinacion = dw_3.object.materias_cve_coordinacion[lo_cont_1]
	ll_cve_plan = dw_3.object.v_sce_carreras_cursadas_cve_plan[lo_cont_1]
	ls_calificacion = dw_3.object.historico_calificacion[lo_cont_1]
	IF ls_calificacion ="BA" OR ls_calificacion ="NA" OR ls_calificacion ="IN" OR isnull(ls_calificacion) THEN
		li_calificacion = 0
	ELSE
		li_calificacion = integer(ls_calificacion)
	END IF
	
	if ll_cve_plan <> 6 then
	
		CHOOSE CASE dw_3.object.tema[lo_cont_1]
			CASE 'INTRODUCCION AL PROBLEMA DEL HOMBRE'
				dw_1.object.banderas_tema_fundamental_1[lo_cont_2]=1
			CASE 'INTRODUCCION AL PROBLEMA SOCIAL'
				dw_1.object.banderas_tema_fundamental_2[lo_cont_2]=1
			CASE 'Tema 1'
				dw_1.object.banderas_tema_1[lo_cont_2]=1
			CASE 'Tema 2'
				dw_1.object.banderas_tema_2[lo_cont_2]=1
			CASE 'Tema 3'
				dw_1.object.banderas_tema_3[lo_cont_2]=1
			CASE 'Tema 4'
				dw_1.object.banderas_tema_4[lo_cont_2]=1
		END CHOOSE	
	else
		IF li_calificacion > 5 THEN
			CHOOSE CASE ll_cve_coordinacion
				CASE 6070
					dw_1.object.banderas_tema_1[lo_cont_2]=1
				CASE 6071
					dw_1.object.banderas_tema_2[lo_cont_2]=1
				CASE 6072
					dw_1.object.banderas_tema_3[lo_cont_2]=1
				CASE 6073
					dw_1.object.banderas_tema_4[lo_cont_2]=1
			END CHOOSE	
		END IF
	end if
NEXT

st_2.text='Terminado el Cálculo' /*Avisa que ya terminaste*/

if dw_1.modifiedcount() > 0 then
	dw_1.AcceptText()
	messagebox("A punto de hacer COMMIT; y update()","Deje de hacer lo que este haciendo")
	if dw_1.update(true) = 1 then		
		commit using gtr_sce;
	else
		rollback using gtr_sce;
	end if
end if
end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type dw_2 from datawindow within w_integracion_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer y = 1600
integer width = 1157
integer height = 900
integer taborder = 40
string dataobject = "d_cred_72_2014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cont_1,lo_cont_2,lo_cuenta

st_2.text='Terminada la Carga'

/*Para todos los que ya tienen 72 créditos o más y no se les haya puesto que ya pueden...*/	
//lo_cont_2=1
//FOR lo_cont_1=1 TO rowcount
//	lo_cuenta=dw_2.object.academicos_cuenta[lo_cont_1]
//	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
//	DO UNTIL lo_cuenta=dw_1.object.banderas_cuenta[lo_cont_2]
//		lo_cont_2=lo_cont_2+1 /*Buscalos en las banderas*/
//	LOOP
//	dw_1.object.banderas_puede_integracion[lo_cont_2]=1 /*Ya pueden*/
//NEXT
//st_2.text='Terminado el Cálculo' /*Avisa que ya terminaste*/
//
/*Carga los datos de las materias de integración que se cursaron en este periodo*/
dw_3.retrieve(gi_periodo,gi_anio)
end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type st_2 from statictext within w_integracion_2014
integer x = 27
integer y = 1504
integer width = 3355
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_integracion_2014
integer x = 18
integer y = 428
integer width = 3360
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_integracion_2014
event clicked pbm_bnclicked
integer x = 1403
integer y = 268
integer width = 585
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Corte de Integración"
end type

event clicked;/*Carga las banderas de los que cursaron materias en el semestre (Banderas)*/
dw_1.retrieve('L')
end event

type dw_1 from datawindow within w_integracion_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 18
integer y = 524
integer width = 3360
integer height = 964
integer taborder = 10
string dataobject = "d_cortes_2014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;st_1.text='Terminada la Carga'
/*Carga los datos de los que cursaron materias en el semestre (Academicos)*/
dw_2.retrieve()
end event

event retrieverow;/*Despliega un mensaje cad vez que se carga un renglón (para mostrar que no te has trabado)*/
st_1.text='Cargando '+string(row)
end event

type uo_1 from uo_per_ani within w_integracion_2014
integer x = 1074
integer y = 36
integer taborder = 11
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type p_ibero from picture within w_integracion_2014
integer x = 46
integer y = 36
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_sistema from statictext within w_integracion_2014
integer x = 791
integer y = 120
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

