$PBExportHeader$w_3ry4i.srw
forward
global type w_3ry4i from w_ancestral
end type
type dw_2 from datawindow within w_3ry4i
end type
type st_2 from statictext within w_3ry4i
end type
type st_1 from statictext within w_3ry4i
end type
type cb_1 from commandbutton within w_3ry4i
end type
type dw_1 from datawindow within w_3ry4i
end type
type uo_1 from uo_per_ani within w_3ry4i
end type
end forward

global type w_3ry4i from w_ancestral
integer width = 3456
integer height = 1628
string title = "Cortes de 3 Reprobadas Y/O 4 Inscritas"
dw_2 dw_2
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
end type
global w_3ry4i w_3ry4i

on w_3ry4i.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_1
end on

on w_3ry4i.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;call super::open;//periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_3ry4i
end type

type dw_2 from datawindow within w_3ry4i
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 567
integer y = 1080
integer width = 2277
integer height = 432
integer taborder = 20
string dataobject = "d_mat_calif"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long ll_cont_1,ll_cont_2,ll_cuenta,ll_materia
int li_cursadas,li_reprobadas, li_esc_file

st_2.text='Terminada la Carga'

/*Prepara el archivo temporal para el reporte*/
li_esc_file = FileOpen("3ry4i.txt",LineMode!, Write!, LockReadWrite!, Replace!)

/*Se hace para TODAS las materias con posibilidad de dar de baja al alumno*/
FOR ll_cont_1=1 TO dw_2.rowcount()
	
	st_2.text=string(ll_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	/*Si estoy en el mismo número de cuenta...*/
	
	if ll_cuenta=dw_2.object.historico_cuenta[ll_cont_1] then
		
		/*Si estoy en la misma materia...*/
		if ll_materia=dw_2.object.historico_cve_mat[ll_cont_1] then
			/*Aumenta el número de materias*/
			li_cursadas=li_cursadas+1
			/*Si la materia en cuestión se reprobó...*/
			if integer(dw_2.object.historico_calificacion[ll_cont_1])=5 or &
					dw_2.object.historico_calificacion[ll_cont_1]='NA' then
				li_reprobadas=li_reprobadas+1
			end if
		else
			/*Ve que materia es, empieza la cuenta desde 1*/
			ll_materia=dw_2.object.historico_cve_mat[ll_cont_1]			
			li_cursadas=1
			/*Si la materia en cuestión se reprobó...*/
			if integer(dw_2.object.historico_calificacion[ll_cont_1])=5 or &
					dw_2.object.historico_calificacion[ll_cont_1]='NA' then
				li_reprobadas=1
			else
				li_reprobadas=0
			end if
		end if/*ll_materia=dw_2.object.historico_cve_mat[ll_cont_1]*/
		
	else
		
		/*Ve que cuenta y que materia son, empieza la cuenta desde 1*/
		ll_cuenta=dw_2.object.historico_cuenta[ll_cont_1]
		ll_materia=dw_2.object.historico_cve_mat[ll_cont_1]
		li_cursadas=1
		/*Si la materia en cuestión se reprobó...*/
		if integer(dw_2.object.historico_calificacion[ll_cont_1])=5 or &
				dw_2.object.historico_calificacion[ll_cont_1]='NA' then
			li_reprobadas=1
		else
			li_reprobadas=0
		end if
	end if/*ll_cuenta=dw_2.object.historico_cuenta[ll_cont_1]*/
	
	/*Si la materia se cursó en el periodo y en el año actuales...*/
	if (gi_anio=dw_2.object.historico_anio[ll_cont_1] and gi_periodo=dw_2.object.historico_periodo[ll_cont_1]) then
		
		/*Si la calificación es de 5 y es la tercera vez...*/
		if integer(dw_2.object.historico_calificacion[ll_cont_1])=5 or &
				dw_2.object.historico_calificacion[ll_cont_1]='NA' then
			if li_reprobadas>=3 then
				//messagebox("Baja por 3 reprobadas","")
				ll_cont_2=1
				DO UNTIL dw_1.object.banderas_cuenta[ll_cont_2]=ll_cuenta
					ll_cont_2=ll_cont_2+1 /*Busca el número de cuenta para modificar la bandera resp.*/
				LOOP
				dw_1.object.banderas_baja_3_reprob[ll_cont_2]=1
				FileWrite(li_esc_file, string(ll_cuenta)+'	'+string(ll_materia)+'	0')
			end if
		end if
		
		/*Si la calificación es de 5 o 'BA' y es la cuarta vez...*/
		if dw_2.object.historico_calificacion[ll_cont_1]='BA' or &
				integer(dw_2.object.historico_calificacion[ll_cont_1])=5 or &
				dw_2.object.historico_calificacion[ll_cont_1]='BJ' or &
				dw_2.object.historico_calificacion[ll_cont_1]='IN' or &
				dw_2.object.historico_calificacion[ll_cont_1]='NA' then
			if li_cursadas>=4 then
				//messagebox("Baja por 4 inscritas","")
				ll_cont_2=1
				DO UNTIL dw_1.object.banderas_cuenta[ll_cont_2]=ll_cuenta
					ll_cont_2=ll_cont_2+1 /*Busca el número de cuenta para modificar la bandera resp.*/
				LOOP
				dw_1.object.banderas_baja_4_insc[ll_cont_2]=1
				FileWrite(li_esc_file, string(ll_cuenta)+'	0	'+string(ll_materia))
			end if
		end if
		
	end if
	
NEXT
FileClose(li_esc_file)
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

type st_2 from statictext within w_3ry4i
integer x = 37
integer y = 988
integer width = 3355
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

type st_1 from statictext within w_3ry4i
integer x = 27
integer y = 440
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

type cb_1 from commandbutton within w_3ry4i
event clicked pbm_bnclicked
integer x = 1161
integer y = 248
integer width = 1079
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Corte de 3 Reprobadas Y/O 4 Inscritas"
end type

event clicked;/*Carga las banderas de los que cursaron materias en el semestre (Banderas)*/
dw_1.retrieve('?', gs_tipo_periodo) 
end event

type dw_1 from datawindow within w_3ry4i
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 27
integer y = 528
integer width = 3360
integer height = 448
integer taborder = 10
string dataobject = "d_cortes"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;st_1.text='Terminada la Carga'
/*Carga los datos de los que cursaron materias en el semestre (Academicos)*/
dw_2.retrieve(gs_tipo_periodo) 



end event

event retrieverow;/*Despliega un mensaje cad vez que se carga un renglón (para mostrar que no te has trabado)*/
st_1.text='Cargando '+string(row)
end event

type uo_1 from uo_per_ani within w_3ry4i
integer x = 1083
integer y = 44
integer taborder = 1
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

