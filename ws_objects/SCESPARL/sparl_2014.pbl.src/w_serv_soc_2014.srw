$PBExportHeader$w_serv_soc_2014.srw
forward
global type w_serv_soc_2014 from w_ancestral
end type
type dw_4 from datawindow within w_serv_soc_2014
end type
type dw_3 from datawindow within w_serv_soc_2014
end type
type dw_2 from datawindow within w_serv_soc_2014
end type
type st_2 from statictext within w_serv_soc_2014
end type
type st_1 from statictext within w_serv_soc_2014
end type
type cb_1 from commandbutton within w_serv_soc_2014
end type
type dw_1 from datawindow within w_serv_soc_2014
end type
type uo_1 from uo_per_ani within w_serv_soc_2014
end type
type st_sistema from statictext within w_serv_soc_2014
end type
type p_ibero from picture within w_serv_soc_2014
end type
end forward

global type w_serv_soc_2014 from w_ancestral
integer width = 5189
integer height = 3272
string title = "Corte de Servicio Social"
long backcolor = 16777215
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
st_sistema st_sistema
p_ibero p_ibero
end type
global w_serv_soc_2014 w_serv_soc_2014

on w_serv_soc_2014.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.st_sistema
this.Control[iCurrent+10]=this.p_ibero
end on

on w_serv_soc_2014.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.st_sistema)
destroy(this.p_ibero)
end on

event open;call super::open;//periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_serv_soc_2014
boolean visible = false
end type

type dw_4 from datawindow within w_serv_soc_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 18
integer y = 2276
integer width = 594
integer height = 692
integer taborder = 40
string dataobject = "d_mat_ss_2014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cont_1,lo_cont_2,lo_cuenta

st_2.text='Terminada la Carga'

dw_1.setsort("banderas_cuenta")
dw_4.setsort("historico_cuenta")
dw_1.sort()
dw_4.sort()

lo_cont_2=1
/*Se hace para TODOS los Servicios Sociales acreditados o incompletos que se cursaron en el periodo*/
FOR lo_cont_1=1 TO rowcount
	lo_cuenta=dw_4.object.historico_cuenta[lo_cont_1]
	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	DO UNTIL lo_cuenta=dw_1.object.banderas_cuenta[lo_cont_2]
		lo_cont_2=lo_cont_2+1 /*Búscalos en las banderas*/
	LOOP
	dw_1.object.banderas_cve_flag_serv_social[lo_cont_2]=2 /*Ya cursó o Está Cursando*/
NEXT

st_2.text='Terminado el Cálculo' /*Avisa que ya terminaste*/

if dw_1.modifiedcount() > 0 then
	dw_1.AcceptText()
	messagebox("A punto de hacer COMMIT; y update()","Deje de hacer lo que este haciendo")
	if dw_1.update(true)>= 1 then		
		commit using gtr_sce;
	else
		rollback using gtr_sce;
	end if
end if
end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type dw_3 from datawindow within w_serv_soc_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 2021
integer y = 1572
integer width = 1349
integer height = 692
integer taborder = 50
string dataobject = "d_cred_75_ss"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cont_1,lo_cont_2,lo_cuenta
int in_carrera,in_plan

st_2.text='Terminada la Carga'

/*Se hace para TODOS los alumnos que se inscribieron en el semestre (cuentas_cortes)*/
//FOR lo_cont_1=1 TO dw_2.rowcount()
//	lo_cuenta=dw_2.object.academicos_cuenta[lo_cont_1]
//	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
//	in_carrera=dw_2.object.academicos_cve_carrera[lo_cont_1]
//	in_plan=dw_2.object.academicos_cve_plan[lo_cont_1]
//	
//	lo_cont_2=1
//	DO UNTIL ((object.plan_estudios_cve_plan[lo_cont_2]=in_plan &
//					and object.plan_estudios_cve_carrera[lo_cont_2]=in_carrera))
//		lo_cont_2=lo_cont_2+1 /*Busca el renglón que coincide con la in_carrera y el plan (DEBE APARECER)*/
//	LOOP
//	
//	/*Si ya se puede cursar el SS y no está o no lo ha cursado...*/
//	if (dw_2.object.academicos_creditos_cursados[lo_cont_1] >= &
//			object.plan_estudios_cred_serv_social[lo_cont_2])  and &
//			dw_1.object.banderas_cve_flag_serv_social[lo_cont_1]<>2 then
//		dw_1.object.banderas_cve_flag_serv_social[lo_cont_1]=1 /*YA PUEDE*/
//	end if
//	
//NEXT
///*Avisa que ya se terminó la actualización*/
//st_2.text='Terminada la Actualización'
//
/*Carga los datos de los que cursaron el prerrequisito de inglés en el semestre (Academicos)*/
dw_4.retrieve(gi_periodo,gi_anio)
end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type dw_2 from datawindow within w_serv_soc_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 18
integer y = 1572
integer width = 1984
integer height = 692
integer taborder = 30
string dataobject = "d_prom_cred_sem_2014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;st_2.text='Terminada la Carga'
/*Busca los créditos para SS de calidad de las carreras que tuvieron alumnos inscritos (plan_estudios)*/
dw_3.retrieve('L')
end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type st_2 from statictext within w_serv_soc_2014
integer x = 18
integer y = 1476
integer width = 3360
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_serv_soc_2014
integer x = 18
integer y = 400
integer width = 3360
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_serv_soc_2014
event clicked pbm_bnclicked
integer x = 1353
integer y = 256
integer width = 690
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Corte de Servicio Social"
end type

event clicked;/*Carga las banderas de los que cursaron materias en el semestre (Banderas)*/
dw_1.retrieve('L')
end event

type dw_1 from datawindow within w_serv_soc_2014
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 18
integer y = 492
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
dw_2.retrieve('L')
end event

event retrieverow;/*Despliega un mensaje cad vez que se carga un renglón (para mostrar que no te has trabado)*/
st_1.text='Cargando '+string(row)
end event

type uo_1 from uo_per_ani within w_serv_soc_2014
integer x = 1074
integer y = 40
integer taborder = 11
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_sistema from statictext within w_serv_soc_2014
integer x = 791
integer y = 124
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

type p_ibero from picture within w_serv_soc_2014
integer x = 46
integer y = 40
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

