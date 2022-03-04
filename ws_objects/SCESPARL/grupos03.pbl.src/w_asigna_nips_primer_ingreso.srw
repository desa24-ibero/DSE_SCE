$PBExportHeader$w_asigna_nips_primer_ingreso.srw
forward
global type w_asigna_nips_primer_ingreso from w_master
end type
type cb_asignar_nips from u_cb within w_asigna_nips_primer_ingreso
end type
type uo_progressbar from u_progressbar within w_asigna_nips_primer_ingreso
end type
type uo_1 from uo_per_ani within w_asigna_nips_primer_ingreso
end type
type cb_establece_periodo from u_cb within w_asigna_nips_primer_ingreso
end type
type st_periodo_establecido from statictext within w_asigna_nips_primer_ingreso
end type
end forward

global type w_asigna_nips_primer_ingreso from w_master
integer x = 0
integer y = 0
integer width = 2717
integer height = 781
string title = "Asignación de Nips a Primer Ingreso"
cb_asignar_nips cb_asignar_nips
uo_progressbar uo_progressbar
uo_1 uo_1
cb_establece_periodo cb_establece_periodo
st_periodo_establecido st_periodo_establecido
end type
global w_asigna_nips_primer_ingreso w_asigna_nips_primer_ingreso

type variables
integer ii_periodo, ii_anio
st_confirma_usuario ist_confirma_usuario
end variables

on w_asigna_nips_primer_ingreso.create
int iCurrent
call super::create
this.cb_asignar_nips=create cb_asignar_nips
this.uo_progressbar=create uo_progressbar
this.uo_1=create uo_1
this.cb_establece_periodo=create cb_establece_periodo
this.st_periodo_establecido=create st_periodo_establecido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_asignar_nips
this.Control[iCurrent+2]=this.uo_progressbar
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.cb_establece_periodo
this.Control[iCurrent+5]=this.st_periodo_establecido
end on

on w_asigna_nips_primer_ingreso.destroy
call super::destroy
destroy(this.cb_asignar_nips)
destroy(this.uo_progressbar)
destroy(this.uo_1)
destroy(this.cb_establece_periodo)
destroy(this.st_periodo_establecido)
end on

event open;call super::open;x=1
y=1
end event

event closequery;	RETURN 0
end event

event pfc_postopen;call super::pfc_postopen;cb_establece_periodo.event Clicked()
end event

type cb_asignar_nips from u_cb within w_asigna_nips_primer_ingreso
integer x = 827
integer y = 426
integer width = 399
integer height = 93
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "Asignar Nips"
end type

event clicked;call super::clicked;
integer li_confirma, li_sql_codigo
string ls_periodo_establecido, ls_sql_mensaje
ls_periodo_establecido= st_periodo_establecido.text

li_confirma=MessageBox("Confirme Eliminación", "¿Desea asignar los nips correspondiente a primer ingreso de ["+ls_periodo_establecido+"] ?",Question!, YesNo!)
							 
IF li_confirma <> 1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF
END IF

SetPointer(HourGlass!)

UPDATE nips
SET  nip2 =  CONVERT(char(2),a.fecha_nac,104)+CONVERT(char(2),a.fecha_nac,1)
FROM nips n, alumnos a, academicos ac
WHERE a.cuenta = n.cuenta 
and n.nip2 in ("0000",null, "")
and a.cuenta = ac.cuenta
and ac.periodo_ing = :ii_periodo
and ac.anio_ing = :ii_anio
USING gtr_sce;

li_sql_codigo = gtr_sce.SQLCode
ls_sql_mensaje = gtr_sce.SQLErrText

IF li_sql_codigo= -1 THEN
	ROLLBACK USING gtr_sce;
	MessageBox("Error al actualizar los nips de primer ingreso",ls_sql_mensaje,StopSign!)
ELSEIF li_sql_codigo= 100 THEN
	ROLLBACK USING gtr_sce;
	MessageBox("No existen alumnos con nips a actualizar",ls_sql_mensaje,StopSign!)
ELSEIF li_sql_codigo= 0 THEN
	COMMIT USING gtr_sce;
	MessageBox("Actualización Exitosa","Los nips de los alumnos han sido actualizados",Information!)
END IF


	




end event

type uo_progressbar from u_progressbar within w_asigna_nips_primer_ingreso
integer x = 662
integer y = 282
integer height = 74
integer taborder = 30
end type

on uo_progressbar.destroy
call u_progressbar::destroy
end on

type uo_1 from uo_per_ani within w_asigna_nips_primer_ingreso
integer x = 18
integer y = 16
integer width = 1251
integer height = 166
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_establece_periodo from u_cb within w_asigna_nips_primer_ingreso
integer x = 1320
integer y = 58
integer width = 461
integer height = 93
integer taborder = 20
boolean bringtotop = true
string text = "Establece Periodo"
end type

event clicked;call super::clicked;string ls_periodo, ls_anio, ls_periodo_anio
long ll_total_items_origen, ll_total_items_destino

CHOOSE CASE gi_periodo
	CASE 0
		ls_periodo= "PRIMAVERA"
	CASE 1
		ls_periodo= "VERANO"
	CASE 2
		ls_periodo= "OTOÑO"
	CASE ELSE 
		ls_periodo= "ERROR GRAVE"		
END CHOOSE

ls_periodo_anio = ls_periodo + " "+ STRING(gi_anio) 

st_periodo_establecido.text = ls_periodo_anio

ii_periodo= gi_periodo
ii_anio = gi_anio


end event

type st_periodo_establecido from statictext within w_asigna_nips_primer_ingreso
integer x = 1858
integer y = 61
integer width = 720
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

