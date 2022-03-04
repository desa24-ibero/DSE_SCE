$PBExportHeader$w_ingles.srw
forward
global type w_ingles from w_ancestral
end type
type dw_2 from datawindow within w_ingles
end type
type dw_3 from datawindow within w_ingles
end type
type st_2 from statictext within w_ingles
end type
type st_1 from statictext within w_ingles
end type
type cb_1 from commandbutton within w_ingles
end type
type dw_1 from datawindow within w_ingles
end type
type uo_1 from uo_per_ani within w_ingles
end type
end forward

global type w_ingles from w_ancestral
integer width = 3470
integer height = 1612
string title = "Corte de Inglés"
dw_2 dw_2
dw_3 dw_3
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
end type
global w_ingles w_ingles

type variables
INTEGER ie_ext_cred_prim
INTEGER ie_ext_cred_ver
INTEGER ie_ext_cred_oto
end variables

on w_ingles.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.uo_1
end on

on w_ingles.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;call super::open;//periodo_actual(gi_periodo,gi_anio,gtr_sce)

SELECT valor_minimo 
INTO :ie_ext_cred_prim
FROM parametros_banderas 
WHERE bandera = 'exten_cred_ing' 
AND periodo = 0 
USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la Extensión de Créditos por Prerrequisito de Inglés para Primavera: " + gtr_sce.SQLERRTEXT)
	MESSAGEBOX("Error", "FAVOR DE VERIFICAR ANTES DE REALIZAR LOS CORTES")
	ie_ext_cred_prim = 20
END IF

SELECT valor_minimo 
INTO :ie_ext_cred_ver 
FROM parametros_banderas 
WHERE bandera = 'exten_cred_ing' 
AND periodo = 1 
USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la Extensión de Créditos por Prerrequisito de Inglés para Verano: " + gtr_sce.SQLERRTEXT)
	MESSAGEBOX("Error", "FAVOR DE VERIFICAR ANTES DE REALIZAR LOS CORTES")
	ie_ext_cred_ver = 40
END IF


SELECT valor_minimo 
INTO :ie_ext_cred_oto 
FROM parametros_banderas 
WHERE bandera = 'exten_cred_ing' 
AND periodo = 2
USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la Extensión de Créditos por Prerrequisito de Inglés para Otoño: " + gtr_sce.SQLERRTEXT)
	MESSAGEBOX("Error", "FAVOR DE VERIFICAR ANTES DE REALIZAR LOS CORTES")
	ie_ext_cred_oto = 40
END IF





end event

type p_uia from w_ancestral`p_uia within w_ingles
end type

type dw_2 from datawindow within w_ingles
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 896
integer y = 1068
integer width = 594
integer height = 432
integer taborder = 30
string dataobject = "d_1_sem_ingles"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cont_1,lo_cont_2,lo_cuenta
int in_esc_file, li_extension, li_actualiza_extension

st_2.text='Terminada la Carga'

in_esc_file = FileOpen("ingles.txt",LineMode!, Write!, LockReadWrite!, Replace!)
FileWrite(in_esc_file,string(dw_2.rowcount()))

/*Se hace para TODOS los que están por ingresar al 4 semestre o más alla y que 
no han (o habían) cursado el prerrequisito*/
lo_cont_2=1
FOR lo_cont_1=1 TO rowcount
	lo_cuenta=dw_2.object.academicos_cuenta[lo_cont_1]
	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	DO UNTIL lo_cuenta=dw_1.object.banderas_cuenta[lo_cont_2]
		lo_cont_2=lo_cont_2+1 /*Buscalos en las banderas*/
	LOOP
	/*Si en las banderas todavía no aparece NORMAL...*/
//****
//	if dw_1.object.banderas_cve_flag_prerreq_ingles[lo_cont_2]<>0 then
//****		
		/*Si ya se cursaron 4 o más semestres...*/
//Se modifico que sea desde los semestres cursados en 3		
		if dw_2.object.academicos_sem_cursados[lo_cont_1]>=3 then
			dw_1.object.banderas_cve_flag_prerreq_ingles[lo_cont_2]=1 /*Pon ADEUDA*/
//   Se quita la extension para evitar que se sobreescriban extensiones previas			
//			dw_1.object.banderas_exten_cred[lo_cont_2]=48 /*"Extensión" de Créditos a 48*/
			FileWrite(in_esc_file,string(lo_cuenta)+'	'+&
				string(dw_2.object.academicos_sem_cursados[lo_cont_1]))
		else
			dw_1.object.banderas_cve_flag_prerreq_ingles[lo_cont_2]=2 /*Pon AVISO si solo lleva un semestre*/
			//dw_1.object.banderas_exten_cred[lo_cont_2]=0 /*Pon la Extensión de Créditos a 0*/
		end if

//****		
//	else /*Si aparece NORMAL...*/
//		//dw_1.object.banderas_exten_cred[lo_cont_2]=0 /*Pon la Extensión de Créditos a 0*/
//	end if
//****

NEXT
FileClose(in_esc_file)
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

if gi_periodo = 0 then 	
	//li_extension = 20
	li_extension = ie_ext_cred_prim
elseif gi_periodo = 1 then 	
	//li_extension = 48
	li_extension = ie_ext_cred_ver
elseif gi_periodo = 2 then 	
	//li_extension = 48
	li_extension = ie_ext_cred_oto
end if
//Solo para los alumnos que quedaron adeudando el prerrequisito de ingles
//les mueve la extensión de créditos al valor correspondiente establecido
li_actualiza_extension = f_actualiza_exten_cred_adeudos(li_extension) 

if li_actualiza_extension=0 then
	MessageBox("Actualización exitosa","Se ha efectuado la extension (reducción) de creditos~n a los alumnos bloqueados", Information!)
elseif li_actualiza_extension=0 then	
	MessageBox("Actualización fallida","NO se ha efectuado la extension (reducción) de creditos", StopSign!)	
end if




end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type dw_3 from datawindow within w_ingles
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 2226
integer y = 1068
integer width = 594
integer height = 432
integer taborder = 40
string dataobject = "d_mat_ingles"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cont_1,lo_cont_2,lo_cuenta

st_2.text='Terminada la Carga'

dw_1.setsort("banderas_cuenta")
dw_3.setsort("historico_cuenta")
dw_1.sort()
dw_3.sort()

/*Se hace para TODOS los prerrequisitos aprobados que se cursaron en el periodo*/
lo_cont_2=1
FOR lo_cont_1=1 TO rowcount
	lo_cuenta=dw_3.object.historico_cuenta[lo_cont_1]
	st_2.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	DO UNTIL lo_cuenta=dw_1.object.banderas_cuenta[lo_cont_2] and lo_cont_2 <= dw_1.RowCount()
		lo_cont_2=lo_cont_2+1 /*Buscalos en las banderas*/
	LOOP
	if lo_cont_2 <= dw_1.RowCount() then
		dw_1.object.banderas_cve_flag_prerreq_ingles[lo_cont_2]=0 /*Normal (Ya cursó)*/
	end if
NEXT

st_2.text='Terminado el Cálculo' /*Avisa que ya terminaste*/

dw_2.retrieve(gs_tipo_periodo)
end event

event retrieverow;/*Despliega un mensaje cada vez que se carga un renglón (para mostrar que no te has trabado)*/
st_2.text='Cargando '+string(row)
end event

type st_2 from statictext within w_ingles
integer x = 59
integer y = 976
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

type st_1 from statictext within w_ingles
integer x = 50
integer y = 428
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

type cb_1 from commandbutton within w_ingles
event clicked pbm_bnclicked
integer x = 1435
integer y = 256
integer width = 585
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Corte de Inglés"
end type

event clicked;/*Carga las banderas de los que cursaron materias en el semestre (Banderas)*/
if gi_periodo <> 0 then
	dw_1.retrieve('L', gs_tipo_periodo)
else
	MessageBox("Atencion","En primavera no hay corte de Ingles")
end if 



end event

type dw_1 from datawindow within w_ingles
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
integer x = 50
integer y = 524
integer width = 3360
integer height = 452
integer taborder = 10
string dataobject = "d_cortes"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;st_1.text='Terminada la Carga'

/*Carga los datos de los que cursaron el prerrequisito de inglés en el semestre (Academicos)*/
//Correccion para que barra un año atrás en lugar de los 3
dw_3.retrieve(gi_periodo,gi_anio - 1, gs_tipo_periodo)
end event

event retrieverow;/*Despliega un mensaje cad vez que se carga un renglón (para mostrar que no te has trabado)*/
st_1.text='Cargando '+string(row)
end event

type uo_1 from uo_per_ani within w_ingles
integer x = 1106
integer y = 44
integer width = 1253
integer height = 168
integer taborder = 1
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

