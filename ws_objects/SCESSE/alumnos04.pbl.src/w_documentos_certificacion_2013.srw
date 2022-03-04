$PBExportHeader$w_documentos_certificacion_2013.srw
forward
global type w_documentos_certificacion_2013 from w_master_main
end type
type dw_telefono from uo_master_dw within w_documentos_certificacion_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_documentos_certificacion_2013
end type
type r_1 from rectangle within w_documentos_certificacion_2013
end type
type uo_nombre_adm from uo_nombre_alumno_adm_2013 within w_documentos_certificacion_2013
end type
end forward

global type w_documentos_certificacion_2013 from w_master_main
integer width = 3538
integer height = 1156
string title = "Documentos"
string menuname = "m_documentos_2013"
dw_telefono dw_telefono
uo_nombre uo_nombre
r_1 r_1
uo_nombre_adm uo_nombre_adm
end type
global w_documentos_certificacion_2013 w_documentos_certificacion_2013

type variables
int ii_sw = 0
end variables

on w_documentos_certificacion_2013.create
int iCurrent
call super::create
if this.MenuName = "m_documentos_2013" then this.MenuID = create m_documentos_2013
this.dw_telefono=create dw_telefono
this.uo_nombre=create uo_nombre
this.r_1=create r_1
this.uo_nombre_adm=create uo_nombre_adm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_telefono
this.Control[iCurrent+2]=this.uo_nombre
this.Control[iCurrent+3]=this.r_1
this.Control[iCurrent+4]=this.uo_nombre_adm
end on

on w_documentos_certificacion_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_telefono)
destroy(this.uo_nombre)
destroy(this.r_1)
destroy(this.uo_nombre_adm)
end on

event close;if gi_numsadm = 1 then
	if desconecta_bd(gtr_sadm) <> 1 then
		return
	end if
end if
gi_numsadm --
end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;long ll_cuenta

if ii_sw = 0 then
	ll_cuenta = uo_nombre.of_obten_cuenta()
else
	ll_cuenta = uo_nombre_adm.of_obten_cuenta()
end if

dw_telefono.retrieve(ll_cuenta)



end event

event open;call super::open;m_documentos_2013.m_registro.m_nuevo.enabled = False
m_documentos_2013.m_registro.m_actualiza.enabled = False
m_documentos_2013.m_registro.m_borraregistro.enabled = False
dw_telefono.settransobject(gtr_sce)

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce)
luo_periodo_servicios.f_modifica_lista_columna( dw_telefono, "academicos_periodo_ing", "L") 



uo_nombre.em_cuenta.text = " "

triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event ue_imprime;call super::ue_imprime;long ll_cuenta

ll_cuenta = long(uo_nombre.of_obten_cuenta())

if ll_cuenta <> 0 then
	openwithparm(w_recibo_documentos_certificacion_2013,ll_cuenta)
else
	MessageBox("Aviso","No se puede generar el recibo de documentos de la cuenta 0")
end if
end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Documentos"
end event

type st_sistema from w_master_main`st_sistema within w_documentos_certificacion_2013
end type

type p_ibero from w_master_main`p_ibero within w_documentos_certificacion_2013
end type

type dw_telefono from uo_master_dw within w_documentos_certificacion_2013
integer x = 91
integer y = 668
integer width = 3040
integer height = 216
integer taborder = 0
string dataobject = "dw_tel_ing_doc_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

type uo_nombre from uo_nombre_alumno_2013 within w_documentos_certificacion_2013
integer x = 46
integer y = 324
integer taborder = 10
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_documentos_2013.objeto = this
end event

type r_1 from rectangle within w_documentos_certificacion_2013
long linecolor = 128
integer linethickness = 3
long fillcolor = 16777215
integer x = 55
integer y = 656
integer width = 3209
integer height = 248
end type

type uo_nombre_adm from uo_nombre_alumno_adm_2013 within w_documentos_certificacion_2013
boolean visible = false
integer x = 46
integer y = 324
integer taborder = 40
end type

on uo_nombre_adm.destroy
call uo_nombre_alumno_adm_2013::destroy
end on

