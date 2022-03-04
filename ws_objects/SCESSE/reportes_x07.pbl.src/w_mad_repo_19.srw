$PBExportHeader$w_mad_repo_19.srw
$PBExportComments$Ventana para el Reporte de Plan Grupos
forward
global type w_mad_repo_19 from w_master_main_rep
end type
type tab_1 from tab within w_mad_repo_19
end type
type tabpage_general from userobject within tab_1
end type
type ddlb_tipo_imp from dropdownlistbox within tabpage_general
end type
type st_2 from statictext within tabpage_general
end type
type cbx_sin_gpos_zz from checkbox within tabpage_general
end type
type gb_5 from groupbox within tabpage_general
end type
type hsb_1 from hscrollbar within tabpage_general
end type
type em_1 from editmask within tabpage_general
end type
type rb_15 from radiobutton within tabpage_general
end type
type rb_14 from radiobutton within tabpage_general
end type
type cb_40x from commandbutton within tabpage_general
end type
type cb_20x from commandbutton within tabpage_general
end type
type lb_3 from listbox within tabpage_general
end type
type em_2x from editmask within tabpage_general
end type
type cb_10x from commandbutton within tabpage_general
end type
type rb_5 from radiobutton within tabpage_general
end type
type cbx_1 from checkbox within tabpage_general
end type
type cbx_2 from checkbox within tabpage_general
end type
type cbx_3 from checkbox within tabpage_general
end type
type cbx_4 from checkbox within tabpage_general
end type
type cbx_5 from checkbox within tabpage_general
end type
type st_1 from statictext within tabpage_general
end type
type cb_1 from commandbutton within tabpage_general
end type
type cbx_6 from checkbox within tabpage_general
end type
type cbx_2x from checkbox within tabpage_general
end type
type rb_1x from radiobutton within tabpage_general
end type
type rb_2x from radiobutton within tabpage_general
end type
type cb_5x from commandbutton within tabpage_general
end type
type rb_3x from radiobutton within tabpage_general
end type
type rb_7 from radiobutton within tabpage_general
end type
type rb_1 from radiobutton within tabpage_general
end type
type rb_3 from radiobutton within tabpage_general
end type
type rb_4 from radiobutton within tabpage_general
end type
type rb_6 from radiobutton within tabpage_general
end type
type gb_13 from groupbox within tabpage_general
end type
type gb_12 from groupbox within tabpage_general
end type
type gb_4 from groupbox within tabpage_general
end type
type gb_7 from groupbox within tabpage_general
end type
type gb_2 from groupbox within tabpage_general
end type
type gb_9 from groupbox within tabpage_general
end type
type gb_8 from groupbox within tabpage_general
end type
type gb_10 from groupbox within tabpage_general
end type
type gb_20 from groupbox within tabpage_general
end type
type gb_3 from groupbox within tabpage_general
end type
type gb_6 from groupbox within tabpage_general
end type
type gb_11 from groupbox within tabpage_general
end type
type lb_4 from listbox within tabpage_general
end type
type dw_2z from datawindow within tabpage_general
end type
type dw_2x from datawindow within tabpage_general
end type
type uo_lb_division from uo_pfc_list_box_multiple within tabpage_general
end type
type uo_nivel from uo_nivel_2013 within tabpage_general
end type
type uo_periodo from uo_periodo_variable_tipos within tabpage_general
end type
type gb_1 from groupbox within tabpage_general
end type
type tabpage_general from userobject within tab_1
ddlb_tipo_imp ddlb_tipo_imp
st_2 st_2
cbx_sin_gpos_zz cbx_sin_gpos_zz
gb_5 gb_5
hsb_1 hsb_1
em_1 em_1
rb_15 rb_15
rb_14 rb_14
cb_40x cb_40x
cb_20x cb_20x
lb_3 lb_3
em_2x em_2x
cb_10x cb_10x
rb_5 rb_5
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
st_1 st_1
cb_1 cb_1
cbx_6 cbx_6
cbx_2x cbx_2x
rb_1x rb_1x
rb_2x rb_2x
cb_5x cb_5x
rb_3x rb_3x
rb_7 rb_7
rb_1 rb_1
rb_3 rb_3
rb_4 rb_4
rb_6 rb_6
gb_13 gb_13
gb_12 gb_12
gb_4 gb_4
gb_7 gb_7
gb_2 gb_2
gb_9 gb_9
gb_8 gb_8
gb_10 gb_10
gb_20 gb_20
gb_3 gb_3
gb_6 gb_6
gb_11 gb_11
lb_4 lb_4
dw_2z dw_2z
dw_2x dw_2x
uo_lb_division uo_lb_division
uo_nivel uo_nivel
uo_periodo uo_periodo
gb_1 gb_1
end type
type tab_1 from tab within w_mad_repo_19
tabpage_general tabpage_general
end type
type dw_depto_0 from datawindow within w_mad_repo_19
end type
type dw_depto_5 from datawindow within w_mad_repo_19
end type
type dw_depto_4 from datawindow within w_mad_repo_19
end type
type dw_depto_3 from datawindow within w_mad_repo_19
end type
type dw_depto_2 from datawindow within w_mad_repo_19
end type
type dw_depto_1 from datawindow within w_mad_repo_19
end type
end forward

global type w_mad_repo_19 from w_master_main_rep
integer x = 9
integer y = 4
integer width = 4014
integer height = 2804
string title = "Reporte de Plan - Grupos"
string menuname = "m_repo_mad_4"
boolean resizable = true
tab_1 tab_1
dw_depto_0 dw_depto_0
dw_depto_5 dw_depto_5
dw_depto_4 dw_depto_4
dw_depto_3 dw_depto_3
dw_depto_2 dw_depto_2
dw_depto_1 dw_depto_1
end type
global w_mad_repo_19 w_mad_repo_19

type variables
string nivel
int agrupa, ii_num_resize = 0
integer ii_tipo_imp
string division_x
int ii_dw_width = 0, ii_dw_height = 0
string is_descripcion_periodo


Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

end variables

forward prototypes
public subroutine wf_actualiza_lista_coordina (boolean ab_todas)
end prototypes

public subroutine wf_actualiza_lista_coordina (boolean ab_todas);//wf_actualiza_lista_coordina
// Recibe ab_todas	boolean
//Revisa las divisiones seleccionadas junto con el nivel
// 

long ll_cve_divisiones[], ll_indice, ll_cve_division, ll_tamanio, ll_cve_coordinaciones[], ll_indice_coord
integer li_res_coord_depto
string ls_coordinaciones[], ls_nivel[], ls_nivel_actual
string ls_cve_coordinacion, ls_aux_coordinacion

if ab_todas then
	tab_1.tabpage_general.uo_lb_division.of_obten_lista_total( ll_cve_divisiones)
else
	tab_1.tabpage_general.uo_lb_division.of_obten_lista_seleccionados( ll_cve_divisiones)
end if

ll_tamanio = UpperBound(ll_cve_divisiones)

IF ll_tamanio > 0 THEN
	tab_1.tabpage_general.cbx_6.event limpia()

	For ll_indice = 1 to ll_tamanio
		ll_cve_division = ll_cve_divisiones[ll_indice]
	//	MessageBox("Clave["+string(ll_indice)+"]", string (ll_cve_division))
	Next
	
	li_res_coord_depto = f_obten_coordinaciones_division(ll_cve_divisiones, ll_cve_coordinaciones, ls_coordinaciones, ls_nivel)

	if li_res_coord_depto = -1 then
		MessageBox("ERROR","Error en la carga de coordinaciones por división",StopSign!)
		RETURN
	end if

	FOR ll_indice_coord = 1 TO li_res_coord_depto		
		//El nivel de la coordinacion actual
		ls_nivel_actual = ls_nivel[ll_indice_coord]
	
		//Si el nivel de la coordinacion actual es igual al filtro seleccionado o el filtro dice que todos
		//añadir a la lista de coordinaciones
		//if (nivel = 'L' and ls_nivel_actual = 'L') OR (nivel = 'P'  and ls_nivel_actual = 'P') OR (nivel = 'T') then
		if (nivel = ls_nivel_actual) OR (nivel = 'A') then 
			ls_cve_coordinacion = string(ll_cve_coordinaciones[ll_indice_coord],"###000")
			ls_aux_coordinacion = ls_cve_coordinacion + " - "+ls_coordinaciones[ll_indice_coord]
			tab_1.tabpage_general.lb_4.AddItem(ls_cve_coordinacion)
			tab_1.tabpage_general.lb_3.AddItem(ls_aux_coordinacion)
		end if	
	NEXT

END IF


end subroutine

on w_mad_repo_19.create
int iCurrent
call super::create
if this.MenuName = "m_repo_mad_4" then this.MenuID = create m_repo_mad_4
this.tab_1=create tab_1
this.dw_depto_0=create dw_depto_0
this.dw_depto_5=create dw_depto_5
this.dw_depto_4=create dw_depto_4
this.dw_depto_3=create dw_depto_3
this.dw_depto_2=create dw_depto_2
this.dw_depto_1=create dw_depto_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_depto_0
this.Control[iCurrent+3]=this.dw_depto_5
this.Control[iCurrent+4]=this.dw_depto_4
this.Control[iCurrent+5]=this.dw_depto_3
this.Control[iCurrent+6]=this.dw_depto_2
this.Control[iCurrent+7]=this.dw_depto_1
end on

on w_mad_repo_19.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_depto_0)
destroy(this.dw_depto_5)
destroy(this.dw_depto_4)
destroy(this.dw_depto_3)
destroy(this.dw_depto_2)
destroy(this.dw_depto_1)
end on

event open;int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual


// Se inicializa el objeto de periodos
tab_1.tabpage_general.uo_periodo.of_inicializa_servicio( "H", "L", "L", "N", gtr_sce)

//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_chk <> 1 then return


//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//Cambio por Ajustes en Línea
//1)<-






integer ll_claves_default[]
tab_1.tabpage_general.uo_lb_division.event ue_genera_lista('d_divisiones', ll_claves_default, gtr_sce)
tab_1.tabpage_general.uo_lb_division.of_setresize( true)
ii_dw_height = tab_1.tabpage_general.dw_2x.height
ii_dw_width = tab_1.tabpage_general.dw_2x.width

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
tab_1.tabpage_general.dw_2x.settransobject(gtr_sce)
tab_1.tabpage_general.dw_2z.settransobject(gtr_sce)

	
/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1
//nivel = 'T'
nivel = 'A' 
division_x = 'T'
agrupa =1

tab_1.tabpage_general.rb_15.event clicked()
///*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_repo_mad_4.m_registro.m_nuevo.disable( )
m_repo_mad_4.m_registro.m_actualiza.disable( )
m_repo_mad_4.m_registro.m_borraregistro.disable( )

m_repo_mad_4.size_hoja = 1


//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase
dw_depto_0.SetTransObject(gtr_sce)
dw_depto_0.Retrieve(1000)

dw_depto_1.SetTransObject(gtr_sce)
dw_depto_1.Retrieve(4000)

dw_depto_2.SetTransObject(gtr_sce)
dw_depto_2.Retrieve(5000)

dw_depto_3.SetTransObject(gtr_sce)
dw_depto_3.Retrieve(6000)

dw_depto_4.SetTransObject(gtr_sce)
dw_depto_4.Retrieve(7000)

dw_depto_5.SetTransObject(gtr_sce)
dw_depto_5.Retrieve(9000)

f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

//Cambio por Ajustes en Línea
//2)<-

tab_1.tabpage_general.uo_nivel.of_carga_control(gtr_sce)
tab_1.tabpage_general.ddlb_tipo_imp.selectitem(2)
tab_1.tabpage_general.rb_14.triggerevent("clicked")

end event

event resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = tab_1.tabpage_general.dw_2x.height
	ll_height_win = this.height

	ll_height_tab = tab_1.height
	ll_width_tab = tab_1.width

	tab_1.width = newwidth - 50
	tab_1.height = newheight - 350
	
	ll_height_tab_final = tab_1.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	tab_1.tabpage_general.gb_1.width = newwidth - 200

	tab_1.tabpage_general.dw_2x.width = newwidth - 200
	tab_1.tabpage_general.dw_2x.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

event close;//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

f_obten_titulo(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)

//Cambio por Ajustes en Línea
//3)<-

end event

type st_sistema from w_master_main_rep`st_sistema within w_mad_repo_19
end type

type p_ibero from w_master_main_rep`p_ibero within w_mad_repo_19
end type

type tab_1 from tab within w_mad_repo_19
event selectionchanged pbm_tcnselchanged
event create ( )
event destroy ( )
integer y = 300
integer width = 3753
integer height = 2168
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean fixedwidth = true
boolean raggedright = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_general tabpage_general
end type

event selectionchanged;/* Se asignan los datawindows dependiendo del TAB al menu, para poder imprimirlos */
if newindex = 1 then
	 m_repo_mad_4.dw = tab_1.tabpage_general.dw_2x
   
	 tab_1.tabpage_general.gb_1.taborder =0
	 tab_1.tabpage_general.gb_2.taborder =0
	 tab_1.tabpage_general.gb_3.taborder =0
	 tab_1.tabpage_general.gb_4.taborder =0
//	 tab_1.tabpage_general.gb_5.taborder =0
	 tab_1.tabpage_general.gb_6.taborder =0
	 tab_1.tabpage_general.gb_7.taborder =0
	 tab_1.tabpage_general.gb_8.taborder =0
	 tab_1.tabpage_general.gb_9.taborder =0
	 tab_1.tabpage_general.gb_10.taborder =0
	 tab_1.tabpage_general.gb_11.taborder =0
	 tab_1.tabpage_general.gb_12.taborder =0
  	 tab_1.tabpage_general.gb_13.taborder =0
	 tab_1.tabpage_general.gb_20.taborder =0
end if

end event

on tab_1.create
this.tabpage_general=create tabpage_general
this.Control[]={this.tabpage_general}
end on

on tab_1.destroy
destroy(this.tabpage_general)
end on

type tabpage_general from userobject within tab_1
event create ( )
event destroy ( )
event ue_sincroniza ( )
integer x = 128
integer y = 16
integer width = 3607
integer height = 2136
long backcolor = 16777215
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom045!"
long picturemaskcolor = 553648127
ddlb_tipo_imp ddlb_tipo_imp
st_2 st_2
cbx_sin_gpos_zz cbx_sin_gpos_zz
gb_5 gb_5
hsb_1 hsb_1
em_1 em_1
rb_15 rb_15
rb_14 rb_14
cb_40x cb_40x
cb_20x cb_20x
lb_3 lb_3
em_2x em_2x
cb_10x cb_10x
rb_5 rb_5
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
st_1 st_1
cb_1 cb_1
cbx_6 cbx_6
cbx_2x cbx_2x
rb_1x rb_1x
rb_2x rb_2x
cb_5x cb_5x
rb_3x rb_3x
rb_7 rb_7
rb_1 rb_1
rb_3 rb_3
rb_4 rb_4
rb_6 rb_6
gb_13 gb_13
gb_12 gb_12
gb_4 gb_4
gb_7 gb_7
gb_2 gb_2
gb_9 gb_9
gb_8 gb_8
gb_10 gb_10
gb_20 gb_20
gb_3 gb_3
gb_6 gb_6
gb_11 gb_11
lb_4 lb_4
dw_2z dw_2z
dw_2x dw_2x
uo_lb_division uo_lb_division
uo_nivel uo_nivel
uo_periodo uo_periodo
gb_1 gb_1
end type

on tabpage_general.create
this.ddlb_tipo_imp=create ddlb_tipo_imp
this.st_2=create st_2
this.cbx_sin_gpos_zz=create cbx_sin_gpos_zz
this.gb_5=create gb_5
this.hsb_1=create hsb_1
this.em_1=create em_1
this.rb_15=create rb_15
this.rb_14=create rb_14
this.cb_40x=create cb_40x
this.cb_20x=create cb_20x
this.lb_3=create lb_3
this.em_2x=create em_2x
this.cb_10x=create cb_10x
this.rb_5=create rb_5
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.st_1=create st_1
this.cb_1=create cb_1
this.cbx_6=create cbx_6
this.cbx_2x=create cbx_2x
this.rb_1x=create rb_1x
this.rb_2x=create rb_2x
this.cb_5x=create cb_5x
this.rb_3x=create rb_3x
this.rb_7=create rb_7
this.rb_1=create rb_1
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_6=create rb_6
this.gb_13=create gb_13
this.gb_12=create gb_12
this.gb_4=create gb_4
this.gb_7=create gb_7
this.gb_2=create gb_2
this.gb_9=create gb_9
this.gb_8=create gb_8
this.gb_10=create gb_10
this.gb_20=create gb_20
this.gb_3=create gb_3
this.gb_6=create gb_6
this.gb_11=create gb_11
this.lb_4=create lb_4
this.dw_2z=create dw_2z
this.dw_2x=create dw_2x
this.uo_lb_division=create uo_lb_division
this.uo_nivel=create uo_nivel
this.uo_periodo=create uo_periodo
this.gb_1=create gb_1
this.Control[]={this.ddlb_tipo_imp,&
this.st_2,&
this.cbx_sin_gpos_zz,&
this.gb_5,&
this.hsb_1,&
this.em_1,&
this.rb_15,&
this.rb_14,&
this.cb_40x,&
this.cb_20x,&
this.lb_3,&
this.em_2x,&
this.cb_10x,&
this.rb_5,&
this.cbx_1,&
this.cbx_2,&
this.cbx_3,&
this.cbx_4,&
this.cbx_5,&
this.st_1,&
this.cb_1,&
this.cbx_6,&
this.cbx_2x,&
this.rb_1x,&
this.rb_2x,&
this.cb_5x,&
this.rb_3x,&
this.rb_7,&
this.rb_1,&
this.rb_3,&
this.rb_4,&
this.rb_6,&
this.gb_13,&
this.gb_12,&
this.gb_4,&
this.gb_7,&
this.gb_2,&
this.gb_9,&
this.gb_8,&
this.gb_10,&
this.gb_20,&
this.gb_3,&
this.gb_6,&
this.gb_11,&
this.lb_4,&
this.dw_2z,&
this.dw_2x,&
this.uo_lb_division,&
this.uo_nivel,&
this.uo_periodo,&
this.gb_1}
end on

on tabpage_general.destroy
destroy(this.ddlb_tipo_imp)
destroy(this.st_2)
destroy(this.cbx_sin_gpos_zz)
destroy(this.gb_5)
destroy(this.hsb_1)
destroy(this.em_1)
destroy(this.rb_15)
destroy(this.rb_14)
destroy(this.cb_40x)
destroy(this.cb_20x)
destroy(this.lb_3)
destroy(this.em_2x)
destroy(this.cb_10x)
destroy(this.rb_5)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cbx_6)
destroy(this.cbx_2x)
destroy(this.rb_1x)
destroy(this.rb_2x)
destroy(this.cb_5x)
destroy(this.rb_3x)
destroy(this.rb_7)
destroy(this.rb_1)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_6)
destroy(this.gb_13)
destroy(this.gb_12)
destroy(this.gb_4)
destroy(this.gb_7)
destroy(this.gb_2)
destroy(this.gb_9)
destroy(this.gb_8)
destroy(this.gb_10)
destroy(this.gb_20)
destroy(this.gb_3)
destroy(this.gb_6)
destroy(this.gb_11)
destroy(this.lb_4)
destroy(this.dw_2z)
destroy(this.dw_2x)
destroy(this.uo_lb_division)
destroy(this.uo_nivel)
destroy(this.uo_periodo)
destroy(this.gb_1)
end on

event ue_sincroniza();//ue_sincroniza
//Ejectuta las funciones requeridas al seleccionar divisiones
//

//Actualiza la lista de las coordinaciones
wf_actualiza_lista_coordina(false)


end event

type ddlb_tipo_imp from dropdownlistbox within tabpage_general
integer x = 2491
integer y = 528
integer width = 549
integer height = 384
integer taborder = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
boolean vscrollbar = true
string item[] = {"Tradicional","Modular"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_descripcion

IF Lower(This.text) = 'modular' THEN
	ii_tipo_imp = 2 
ELSE
	ii_tipo_imp = 1 // 1 = Tradicional
END IF
end event

type st_2 from statictext within tabpage_general
integer x = 1984
integer y = 536
integer width = 498
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Tipo impartición:"
boolean focusrectangle = false
end type

type cbx_sin_gpos_zz from checkbox within tabpage_general
integer x = 2898
integer y = 300
integer width = 567
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Sin Grupos ZZ"
boolean checked = true
end type

type gb_5 from groupbox within tabpage_general
integer x = 2871
integer y = 260
integer width = 617
integer height = 128
integer taborder = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type hsb_1 from hscrollbar within tabpage_general
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
integer x = 3154
integer y = 836
integer width = 215
integer height = 108
boolean stdheight = false
end type

event lineleft;dw_2x.ScrollPriorPage ( ) 
end event

event lineright;dw_2x.ScrollNextPage ( ) 

end event

event constructor;TabOrder = 0
end event

type em_1 from editmask within tabpage_general
integer x = 78
integer y = 432
integer width = 215
integer height = 80
integer taborder = 86
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
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

//CHOOSE CASE periodo
//	CASE 0
//		periodo_x = 0
//		rb_11.checked = TRUE
//	CASE 1
//		periodo_x = 1
//      rb_12.checked = TRUE
//	CASE 2
//		periodo_x = 2
//      rb_13.checked = TRUE
//
//END CHOOSE
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

type rb_15 from radiobutton within tabpage_general
integer x = 2437
integer y = 424
integer width = 603
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Doble Carta (100%)"
end type

event clicked;dw_2x.Object.DataWindow.Zoom = 112
//dw_2x.Object.DataWindow.Print.Margin.Left = 367
dw_2x.Object.DataWindow.Print.Margin.Left = 260
m_repo_mad_4.size_hoja = 1

end event

event constructor;dw_2x.Object.DataWindow.Zoom = 89
//dw_2x.Object.DataWindow.Print.Margin.Left = 110
dw_2x.Object.DataWindow.Print.Margin.Left = 260
m_repo_mad_4.size_hoja = 1
TabOrder = 0
end event

type rb_14 from radiobutton within tabpage_general
integer x = 1957
integer y = 424
integer width = 448
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Carta (66%)"
boolean checked = true
end type

event clicked;dw_2x.Object.DataWindow.Zoom = 66
//dw_2x.Object.DataWindow.Print.Margin.Left = 500
dw_2x.Object.DataWindow.Print.Margin.Left = 260
m_repo_mad_4.size_hoja = 2
end event

event constructor;TabOrder = 0
end event

type cb_40x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2414
integer y = 848
integer width = 279
integer height = 108
integer taborder = 62
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
int Total


setpointer(Hourglass!)
Total=lb_3.totalitems()
DO UNTIL Total=0
		lb_3.DeleteItem(1)
		lb_4.DeleteItem(1)
		Total=lb_3.totalitems()
LOOP

// Se deselecciona la opcion de "Todas las Carreras"
if (cbx_6.checked = TRUE) then
  	 cbx_6.checked = FALSE
end if

dw_2x.Reset() 
dw_2z.Reset()

st_1.text='Total Gen. : 0'
end event

event constructor;TabOrder = 0
end event

type cb_20x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2414
integer y = 700
integer width = 279
integer height = 108
integer taborder = 61
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
setpointer(Hourglass!)
// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_3.SelectedIndex( )
// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_3.DeleteItem(li_Index)
	lb_4.DeleteItem(li_Index)
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_3.SelectedIndex( )
LOOP

// Se deselecciona la opcion de "Todas las Carreras"
if (cbx_6.checked = TRUE) then
  	 cbx_6.checked = FALSE
end if


end event

event constructor;TabOrder = 0
end event

type lb_3 from listbox within tabpage_general
event constructor pbm_constructor
event doubleclicked pbm_lbndblclk
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 654
integer y = 660
integer width = 1728
integer height = 352
integer taborder = 82
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

event doubleclicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index

li_Index = lb_3.SelectedIndex( )
lb_3.DeleteItem(li_Index)
lb_4.DeleteItem(li_Index)

// Se deselecciona la opcion de "Todas las Carreras"
if (cbx_6.checked = TRUE) then
  	 cbx_6.checked = FALSE
end if
end event

event invierte_seleccion;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items - Inverting each item
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, (Not this.State(ll_item)=1) )
	Next
//	//Number of selected items
//	Return this.TotalSelected()
End If

//Not a valid operation
//Return 0
end event

event selecciona_todo;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, True)
	Next
	//Number of selected items
//	Return li_totalitems
End If

//Not a valid operation
//Return 0
end event

type em_2x from editmask within tabpage_general
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 64
integer y = 700
integer width = 247
integer height = 84
integer taborder = 61
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###xxxxxx"
string displaydata = ""
end type

event constructor;TabOrder = 1
end event

event modified;string Departamento

/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_10x*/
if keydown(keyenter!) then	
	Departamento=this.text
	if (Departamento <> '') then
   	  cb_10x.triggerevent("clicked")
	end if	
end if

end event

type cb_10x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( )
event type integer verifica_2 ( string depto )
integer x = 361
integer y = 688
integer width = 261
integer height = 108
integer taborder = 61
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Agregar"
end type

event clicked;/* Se verifica que exista el alumno y que no este en la lista y que su digito verificador este
correcto */
string Depto
	Depto=em_2x.text
	if (Depto <> '') then
		if this. EVENT verifica() = 1 then
		else
			em_2x.SelectText(1, Len(em_2x.Text))
			em_2x.setfocus()
		end if	  
end if
end event

event constructor;TabOrder = 2
end event

event verifica;/* Se verifica que el Depto exista y que no se repita
en la lista*/

string Depto,Nombre
int Depto_A,Depto_B,Division_X2
Depto=em_2x.text
Depto_A=integer(Depto)

  SELECT coordinaciones.cve_coordinacion, coordinaciones.coordinacion, departamentos.cve_division  
    INTO :Depto_B, :Nombre, :Division_X2 
    FROM coordinaciones, departamentos
	 WHERE coordinaciones.cve_depto = departamentos.cve_depto AND 
	 		 coordinaciones.cve_coordinacion = :Depto_A using gtr_sce;

 	 if gtr_sce.sqlcode = 100 then
		   /* Depto no existe */
	      messagebox("Atención","La Coordinación con clave "+Depto+" no existe.")
			return 0
	 else		
   	Depto=string(Depto_A,"####0000")
	// Se verifica la Division Seleccionada
      if( division_x = 'T' or Division_X2  = integer(division_x)) then
			if this. EVENT verifica_2(Depto) = 1 then
			   lb_4.additem (Depto)
				lb_3.additem (Depto+" - "+Nombre)
			   em_2x.text=''
		      return 1 /* Todo esta bien */
	      else
   			/* Ya esta en la lista */
	   		return 0
		   end if	
		else
			// Division del Depto Erroneo
			messagebox("Atención","La Coordinación NO pertenece a la DIVISION seleccionada")
			return 0
      end if
		
end if






end event

event verifica_2;/* Se verifica que no se encuentre en la lista */
int Total
int contador
string Textito
int Bandera

Bandera=0
Total=lb_4.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_4.text(contador)
	   if depto=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	messagebox("Atención","La Coordinación que desea introducir "+&
	                   "~r~ YA SE ENCUENTRA LA LISTA    ")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

type rb_5 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 37
integer y = 252
integer width = 443
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Planteles"
end type

event clicked;division_x='5'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(5,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type cbx_1 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1088
integer y = 128
integer width = 247
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Salón"
boolean checked = true
end type

event clicked;If (this.checked = TRUE) and (cbx_2.checked = TRUE) and (cbx_3.checked = TRUE)and (cbx_4.checked = TRUE) then
	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type cbx_2 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1088
integer y = 200
integer width = 247
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Taller"
boolean checked = true
end type

event clicked;If (this.checked = TRUE) and (cbx_1.checked = TRUE) and (cbx_3.checked = TRUE)and (cbx_4.checked = TRUE) then
	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type cbx_3 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1417
integer y = 128
integer width = 270
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Lab."
boolean checked = true
boolean lefttext = true
end type

event clicked;If (this.checked = TRUE) and (cbx_2.checked = TRUE) and (cbx_1.checked = TRUE)and (cbx_4.checked = TRUE) then
  	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type cbx_4 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1417
integer y = 200
integer width = 270
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Otros"
boolean checked = true
boolean lefttext = true
end type

event clicked;If (this.checked = TRUE) and (cbx_2.checked = TRUE) and (cbx_3.checked = TRUE)and (cbx_1.checked = TRUE) then
  	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type cbx_5 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1243
integer y = 276
integer width = 288
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Todos"
boolean checked = true
end type

event clicked;
If (this.checked = TRUE) then
	cbx_1.enabled = FALSE
	cbx_2.enabled = FALSE
	cbx_3.enabled = FALSE
	cbx_4.enabled = FALSE
	
	cbx_1.checked = TRUE
	cbx_2.checked = TRUE
	cbx_3.checked = TRUE
	cbx_4.checked = TRUE
	
else
	cbx_1.enabled = TRUE
	cbx_2.enabled = TRUE
	cbx_3.enabled = TRUE
	cbx_4.enabled = TRUE
  	cbx_1.checked = FALSE
	cbx_2.checked = FALSE
	cbx_3.checked = FALSE
	cbx_4.checked = FALSE

end if

end event

event constructor;TabOrder = 0
end event

type st_1 from statictext within tabpage_general
event constructor pbm_constructor
integer x = 2843
integer y = 84
integer width = 690
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total Gen. : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type cb_1 from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3127
integer y = 588
integer width = 265
integer height = 108
integer taborder = 61
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event clicked;/* Se le pasa el arreglo al datawindow*/

int Total, Plan_GO
int contador
string Textito


int Departamentos[]
int Salones[]
long Anio_X
string ls_array_nivel[]
string ls_filtro_vacio = ""
long  ll_cont

setpointer(Hourglass!)

if (cbx_1.checked = true or cbx_2.checked = true or cbx_3.checked = true or cbx_4.checked = true) then
   Plan_GO = 1
else
	Plan_GO = 0
end if


//long ll_cve_divisiones[], ll_indice, ll_cve_division, ll_tamanio, ll_cve_coordinaciones[]
//integer li_res_coord_depto
//string ls_coordinaciones[],ls_nivel[]
//tab_1.tabpage_general.uo_lb_division.of_obten_lista_seleccionados( ll_cve_divisiones)
//ll_tamanio = UpperBound(ll_cve_divisiones)
//For ll_indice = 1 to ll_tamanio
//	ll_cve_division = ll_cve_divisiones[ll_indice]
//	MessageBox("Clave["+string(ll_indice)+"]", string (ll_cve_division))
//Next
//	
//li_res_coord_depto = f_obten_coordinaciones_division(ll_cve_divisiones, ll_cve_coordinaciones, ls_coordinaciones, ls_nivel)
//
//
//if li_res_coord_depto = -1 then
//	MessageBox("ERROR","Error en la carga de coordinaciones por división",StopSign!)
//	RETURN
//end if

Total=lb_4.totalitems()
// Se verifica si existen Carreras
if ( Total > 0 and Plan_GO = 1)  then
   // Se limpian los datawindows
	dw_2x.Reset() 
	dw_2z.Reset()
	contador=1
	FOR contador=1 TO Total
		Textito=lb_4.text(contador)
		Departamentos[contador]=integer(Textito)
  	NEXT
   // Se Obtienen los tipos de Salon
	contador=0
	contador  = upperbound (Salones[])
   if (cbx_1.checked = true) THEN
		  Salones[contador+1]=0
	END IF	
	contador  = upperbound (Salones[])
   if (cbx_2.checked = true) THEN
		  Salones[contador+1]=1
	END IF
	contador  = upperbound (Salones[]) 
   if (cbx_3.checked = true) THEN
		  Salones[contador+1]=2
	END IF
	contador  = upperbound (Salones[])
   if (cbx_4.checked = true) THEN
		  Salones[contador+1]=3
	END IF
	Anio_X=long(em_1.text)

//tab_1.tabpage_general.uo_nivel.	
//	if nivel='T' then
//        Nivel_X[1]='L'
//		  Nivel_X[2]='P'
//	else
//		  Nivel_X[1]=nivel
//	end if
	
tab_1.tabpage_general.uo_nivel.of_carga_arreglo_nivel( )
tab_1.tabpage_general.uo_nivel.of_obtiene_array( ls_array_nivel[])

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar un nivel",StopSign!)
	return
End If
	
	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo

PARENT.uo_periodo.of_recupera_periodos() 

is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	

IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional

//If	dw_2x.retrieve(agrupa,Departamentos,Salones,periodo_x,Anio_X,ls_array_nivel[]) <= 0 Then
IF dw_2x.retrieve(agrupa,Departamentos,Salones,le_periodo,Anio_X,ls_array_nivel[], ii_tipo_imp) <= 0 Then
	Messagebox("Mensaje de Sistema","No existe información para la consulta realizada")	
  	RETURN
END IF
  
//Utilizado anteriormente solo para desplegar en la ventana
//	dw_2z.retrieve(agrupa,Departamentos,Salones,periodo_x,Anio_X,Nivel_X)

// Filtramos los grupos ZZ
if cbx_sin_gpos_zz.checked then
	dw_2x.SetFilter("grupos_gpo not in ('ZZ')")  
else
	dw_2x.SetFilter(ls_filtro_vacio)
end if

dw_2x.Filter()

ll_cont = dw_2x.rowcount() 
if ll_cont > 0 then
	// Se actualiza el numero de datos recuperados
	st_1.text='Total Gen. : ' + string(ll_cont)
	dw_2x.ScrollToRow(1)
end if	

	
// Se Ordenan deacuerdo a los criterios establecidos
   cb_5x.triggerevent("clicked") 

end if

end event

event constructor;TabOrder = 4
end event

type cbx_6 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event limpia ( )
integer x = 242
integer y = 892
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Todos"
end type

event clicked;// Se verifica que tipo de carrera se desea insertar
int total, cont
setpointer(Hourglass!)

If (this.checked = TRUE) then
	// Se limpian los datos
	this. EVENT limpia()
	
	wf_actualiza_lista_coordina(true)
	return
	
//	if division_x = 'T' then
//// Se insertan todos los Departamentos en las listas		
//		if dw_depto_0.rowcount() > 0 then
//			total=dw_depto_0.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_0.object.coordinacion[cont]))
//			NEXT			
//		end if
//			
//		if dw_depto_1.rowcount() > 0 then
//			total=dw_depto_1.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_1.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//		if dw_depto_2.rowcount() > 0 then
//			total=dw_depto_2.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_2.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//		if dw_depto_3.rowcount() > 0 then
//			total=dw_depto_3.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_3.object.coordinacion[cont]))
//			NEXT			
//		end if
//		if dw_depto_4.rowcount() > 0 then
//			total=dw_depto_4.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_4.object.coordinacion[cont]))
//			NEXT			
//		end if
//		if dw_depto_5.rowcount() > 0 then
//			total=dw_depto_5.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_5.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//	end if
//	
//	if division_x = '0' then
//		// Se insertan todos los departamentos (Sin Division)		
//		if dw_depto_0.rowcount() > 0 then
//			total=dw_depto_0.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_0.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//	end if		
//	if division_x = '1' then
//			// Se insertan todos los departamentos (Arte)
//			
//		if dw_depto_1.rowcount() > 0 then
//			total=dw_depto_1.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_1.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//	end if
//
//	if division_x = '2' then
//		// Se insertan todos los departamentos (C. Econom. Admon.)		
//		if dw_depto_2.rowcount() > 0 then
//			total=dw_depto_2.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_2.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//
//	end if
//
//	if division_x = '3' then
//			// Se insertan todos los departamentos (Ciencias e Ing.)
//		if dw_depto_3.rowcount() > 0 then
//			total=dw_depto_3.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_3.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//	end if
//	if division_x = '4' then
//		// Se insertan todos los departamentos (Ciencias del Hombre)		
//		if dw_depto_4.rowcount() > 0 then
//			total=dw_depto_4.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_4.object.coordinacion[cont]))
//			NEXT			
//		end if
//	end if
//
//	if division_x = '5' then
//			// Se insertan todos los departamentos (Humanidades)
//		if dw_depto_5.rowcount() > 0 then
//			total=dw_depto_5.rowcount()
//			FOR cont=1 TO total
//				lb_4.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000"))
//				lb_3.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_5.object.coordinacion[cont]))
//			NEXT			
//		end if
//		
//	end if
//
else
	// Se Limpian las listas, para evitar duplicidad
	this. EVENT limpia()
end if	


end event

event constructor;TabOrder = 0
end event

event limpia;// Se limpian los datos de las listas
int Total
long Number[]
setpointer(Hourglass!)
Total=lb_3.totalitems()
DO UNTIL Total=0
		lb_3.DeleteItem(1)
		lb_4.DeleteItem(1)
		Total=lb_3.totalitems()
LOOP
end event

type cbx_2x from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2898
integer y = 176
integer width = 567
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Agrup. por Coord."
boolean checked = true
end type

event clicked;
// Se cambia la opción de Agrupación 

if (this.checked = TRUE) then
    agrupa = 1    // CON Agrupación
else
	 agrupa = 2    // SIN Agrupación
end if
end event

event constructor;TabOrder = 3
end event

type rb_1x from radiobutton within tabpage_general
event constructor pbm_constructor
integer x = 2382
integer y = 124
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Cve. Mat"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type rb_2x from radiobutton within tabpage_general
event constructor pbm_constructor
event clicked pbm_bnclicked
integer x = 2382
integer y = 192
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Cve. Prof"
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type cb_5x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3122
integer y = 432
integer width = 270
integer height = 96
integer taborder = 81
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ordenar"
end type

event clicked;/* Se verifica que opcion de Ordenamiento que se requiere por medio de los checks*/
setpointer(Hourglass!)
if (rb_1x.checked=TRUE) then
	// Ordenamiento por Cve_Materia 
   dw_2x.setsort("materias_cve_mat A, grupos_gpo A ")
	dw_2x.sort()
	// Se recalcula el grupo
	dw_2x.GroupCalc ( )

   dw_2z.setsort("materias_cve_mat A, grupos_gpo A ")
	dw_2z.sort()
	// Se recalcula el grupo
	dw_2z.GroupCalc ( )

   
   if (cbx_2x.checked=TRUE) then
		// Se ordenan por departamento y por clave de departamento
      dw_2x.setsort("materias_cve_coordinacion A, materias_cve_mat A, grupos_gpo A ")
		dw_2x.sort()
		// Se recalcula el grupo
		dw_2x.GroupCalc ( )

      dw_2z.setsort("materias_cve_coordinacion A, materias_cve_mat A, grupos_gpo A ")
		dw_2z.sort()
		// Se recalcula el grupo
		dw_2z.GroupCalc ( )

	end if		
end if

if (rb_2x.checked=TRUE) then
	// Ordenamiento por clave de profesor
   dw_2x.setsort("profesor_cve_profesor A")
	dw_2x.sort()
	// Se recalcula el grupo
	dw_2x.GroupCalc ( )

   dw_2z.setsort("profesor_cve_profesor A")
	dw_2z.sort()
	// Se recalcula el grupo
	dw_2z.GroupCalc ( )

	if (cbx_2x.checked=TRUE) then
		// Se ordenan por departamento y por clave del profesor
      dw_2x.setsort("materias_cve_coordinacion A, profesor_cve_profesor A")
		dw_2x.sort()
		// Se recalcula el grupo
		dw_2x.GroupCalc ( )

	   dw_2z.setsort("materias_cve_coordinacion A, profesor_cve_profesor A")
		dw_2z.sort()
		// Se recalcula el grupo
		dw_2z.GroupCalc ( )

	end if	
	
end if

if (rb_3x.checked=TRUE) then
	// Ordenamiento por Nombre del Profesor
   dw_2x.setsort("profesor_nombre_completo A")
	dw_2x.sort()
	// Se recalcula el grupo
	dw_2x.GroupCalc ( )

   dw_2z.setsort("profesor_nombre_completo A")
	dw_2z.sort()
	// Se recalcula el grupo
	dw_2z.GroupCalc ( )

	if (cbx_2x.checked=TRUE) then
		// Se ordenan por departamento y por nombre del profesor
      dw_2x.setsort("materias_cve_coordinacion A, profesor_nombre_completo A")
		dw_2x.sort()
		// Se recalcula el grupo
		dw_2x.GroupCalc ( )

	   dw_2z.setsort("materias_cve_coordinacion A, profesor_nombre_completo A")
		dw_2z.sort()
		// Se recalcula el grupo
		dw_2z.GroupCalc ( )

	end if	
	
end if

if dw_2z.rowcount() > 0 then
	dw_2z.scrolltorow(1)
	dw_2x.scrolltorow(1)
end if
end event

event constructor;TabOrder = 0
end event

type rb_3x from radiobutton within tabpage_general
integer x = 2382
integer y = 260
integer width = 434
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Nombre Prof."
boolean lefttext = true
end type

type rb_7 from radiobutton within tabpage_general
event clicked pbm_bnclicked
integer x = 338
integer y = 316
integer width = 283
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "TODAS"
boolean checked = true
end type

event clicked;division_x = 'T'

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()

end if

end event

event constructor;TabOrder = 0
end event

type rb_1 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 37
integer y = 124
integer width = 471
integer height = 44
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Estudios Disc"
end type

event clicked;division_x='1'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(1,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type rb_3 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 553
integer y = 180
integer width = 494
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Centros"
end type

event clicked;division_x='3'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(3,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type rb_4 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 37
integer y = 188
integer width = 475
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Vicerrectoria"
end type

event clicked;division_x='4'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(4,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type rb_6 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 553
integer y = 252
integer width = 494
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Estudios Prof"
end type

event clicked;division_x='0'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(0,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type gb_13 from groupbox within tabpage_general
integer x = 3022
integer y = 760
integer width = 498
integer height = 208
integer taborder = 63
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Mov. entre Pág."
borderstyle borderstyle = styleraised!
end type

type gb_12 from groupbox within tabpage_general
integer x = 1938
integer y = 364
integer width = 1125
integer height = 160
integer taborder = 83
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Uso :"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_general
integer x = 18
integer y = 60
integer width = 1029
integer height = 316
integer taborder = 81
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "División"
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within tabpage_general
integer x = 197
integer y = 844
integer width = 325
integer height = 144
integer taborder = 63
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type gb_2 from groupbox within tabpage_general
integer x = 2359
integer y = 60
integer width = 466
integer height = 284
integer taborder = 82
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Ordenamiento"
borderstyle borderstyle = styleraised!
end type

type gb_9 from groupbox within tabpage_general
integer x = 3090
integer y = 380
integer width = 334
integer height = 172
integer taborder = 83
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_8 from groupbox within tabpage_general
integer x = 3095
integer y = 540
integer width = 329
integer height = 176
integer taborder = 62
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_10 from groupbox within tabpage_general
integer x = 2871
integer y = 136
integer width = 617
integer height = 128
integer taborder = 82
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within tabpage_general
boolean visible = false
integer x = 992
integer y = 448
integer width = 1056
integer height = 160
integer taborder = 81
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within tabpage_general
integer x = 18
integer y = 604
integer width = 2738
integer height = 428
integer taborder = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Coordinaciones"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_general
integer x = 1065
integer y = 60
integer width = 658
integer height = 284
integer taborder = 82
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Salones"
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within tabpage_general
integer x = 32
integer y = 372
integer width = 315
integer height = 160
integer taborder = 82
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type lb_4 from listbox within tabpage_general
event constructor pbm_constructor
integer x = 2638
integer y = 700
integer width = 91
integer height = 76
integer taborder = 62
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean sorted = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

type dw_2z from datawindow within tabpage_general
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
integer y = 1064
integer width = 3447
integer height = 832
integer taborder = 61
string dataobject = "dw_repo_mad_19_gz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(rowcount)
	st_1.text='Total Gen. : '+Cont
else
	st_1.text='Total Gen. : '+Cont
end if

this.Object.DataWindow.Zoom = 76
end event

type dw_2x from datawindow within tabpage_general
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
integer y = 1064
integer width = 3552
integer height = 1056
integer taborder = 31
boolean bringtotop = true
string dataobject = "dw_repo_mad_19_gx"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

event retrieveend;// Se coloca el Periodo en la impresión

int periodo
long anio
string periodo_2


//CHOOSE CASE periodo_x
//	CASE 0
//		periodo_2="Primavera"
//	CASE 1
//		periodo_2="Verano"
//	CASE 2
//		periodo_2="Otoño"
//
//END CHOOSE
//
//this.object.st_periodo.text="Periodo : "+periodo_2+" - "+string(em_1.text)

this.object.st_periodo.text="Periodo : " + is_descripcion_periodo + " - " + string(em_1.text)


/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(rowcount)
	st_1.text='Total Gen. : '+Cont
else
	st_1.text='Total Gen. : '+Cont
end if

//this.Object.DataWindow.Zoom = 76


end event

event dberror;RETURN 1
end event

type uo_lb_division from uo_pfc_list_box_multiple within tabpage_general
integer x = 32
integer y = 116
integer width = 992
integer height = 248
integer taborder = 91
boolean bringtotop = true
end type

on uo_lb_division.destroy
call uo_pfc_list_box_multiple::destroy
end on

type uo_nivel from uo_nivel_2013 within tabpage_general
event destroy ( )
integer x = 1755
integer taborder = 92
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type uo_periodo from uo_periodo_variable_tipos within tabpage_general
integer x = 361
integer y = 388
integer width = 1563
integer height = 196
integer taborder = 93
long backcolor = 12639424
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type gb_1 from groupbox within tabpage_general
integer x = 9
integer width = 3561
integer height = 1048
integer taborder = 1
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

type dw_depto_0 from datawindow within w_mad_repo_19
event constructor pbm_constructor
boolean visible = false
integer x = 4658
integer y = 844
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(1000)
end event

type dw_depto_5 from datawindow within w_mad_repo_19
event constructor pbm_constructor
boolean visible = false
integer x = 3726
integer y = 1172
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(9000)
end event

type dw_depto_4 from datawindow within w_mad_repo_19
event constructor pbm_constructor
boolean visible = false
integer x = 4722
integer y = 432
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(7000)
end event

type dw_depto_3 from datawindow within w_mad_repo_19
event constructor pbm_constructor
boolean visible = false
integer x = 3712
integer y = 772
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(6000)
end event

type dw_depto_2 from datawindow within w_mad_repo_19
event constructor pbm_constructor
boolean visible = false
integer x = 4709
integer y = 52
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(5000)
end event

type dw_depto_1 from datawindow within w_mad_repo_19
boolean visible = false
integer x = 3730
integer y = 364
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(4000)
end event

