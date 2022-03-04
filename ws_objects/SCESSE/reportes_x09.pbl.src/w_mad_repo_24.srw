$PBExportHeader$w_mad_repo_24.srw
$PBExportComments$Ventana para el Reporte de Listas de Asistencia
forward
global type w_mad_repo_24 from w_master_main_rep
end type
type tab_1 from tab within w_mad_repo_24
end type
type tabpage_general from userobject within tab_1
end type
type uo_periodo from uo_periodo_variable_tipos within tabpage_general
end type
type uo_nivel from uo_nivel_2013 within tabpage_general
end type
type uo_lb_division from uo_pfc_list_box_multiple within tabpage_general
end type
type cbx_2 from checkbox within tabpage_general
end type
type em_2 from editmask within tabpage_general
end type
type hsb_1 from hscrollbar within tabpage_general
end type
type em_1 from editmask within tabpage_general
end type
type lb_3 from listbox within tabpage_general
end type
type em_2x from editmask within tabpage_general
end type
type cb_10x from commandbutton within tabpage_general
end type
type rb_5 from radiobutton within tabpage_general
end type
type st_1 from statictext within tabpage_general
end type
type cb_1 from commandbutton within tabpage_general
end type
type cbx_6 from checkbox within tabpage_general
end type
type dw_2z from datawindow within tabpage_general
end type
type rb_7 from radiobutton within tabpage_general
end type
type rb_1 from radiobutton within tabpage_general
end type
type rb_2 from radiobutton within tabpage_general
end type
type rb_3 from radiobutton within tabpage_general
end type
type rb_4 from radiobutton within tabpage_general
end type
type rb_6 from radiobutton within tabpage_general
end type
type gb_12 from groupbox within tabpage_general
end type
type gb_14 from groupbox within tabpage_general
end type
type gb_6 from groupbox within tabpage_general
end type
type gb_2 from groupbox within tabpage_general
end type
type gb_4 from groupbox within tabpage_general
end type
type gb_7 from groupbox within tabpage_general
end type
type gb_8 from groupbox within tabpage_general
end type
type cb_20x from commandbutton within tabpage_general
end type
type cb_40x from commandbutton within tabpage_general
end type
type gb_3 from groupbox within tabpage_general
end type
type gb_1 from groupbox within tabpage_general
end type
type lb_4 from listbox within tabpage_general
end type
type tabpage_general from userobject within tab_1
uo_periodo uo_periodo
uo_nivel uo_nivel
uo_lb_division uo_lb_division
cbx_2 cbx_2
em_2 em_2
hsb_1 hsb_1
em_1 em_1
lb_3 lb_3
em_2x em_2x
cb_10x cb_10x
rb_5 rb_5
st_1 st_1
cb_1 cb_1
cbx_6 cbx_6
dw_2z dw_2z
rb_7 rb_7
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_6 rb_6
gb_12 gb_12
gb_14 gb_14
gb_6 gb_6
gb_2 gb_2
gb_4 gb_4
gb_7 gb_7
gb_8 gb_8
cb_20x cb_20x
cb_40x cb_40x
gb_3 gb_3
gb_1 gb_1
lb_4 lb_4
end type
type tabpage_individual from userobject within tab_1
end type
type uo_periodo2 from uo_periodo_variable_tipos within tabpage_individual
end type
type cbx_4 from checkbox within tabpage_individual
end type
type em_4 from editmask within tabpage_individual
end type
type em_3 from editmask within tabpage_individual
end type
type hsb_2 from hscrollbar within tabpage_individual
end type
type cbx_1 from checkbox within tabpage_individual
end type
type lb_1 from listbox within tabpage_individual
end type
type cb_3x from commandbutton within tabpage_individual
end type
type dw_1z from datawindow within tabpage_individual
end type
type st_1x from statictext within tabpage_individual
end type
type cb_4x from commandbutton within tabpage_individual
end type
type cb_2x from commandbutton within tabpage_individual
end type
type cb_1x from commandbutton within tabpage_individual
end type
type em_1x from editmask within tabpage_individual
end type
type gb_22 from groupbox within tabpage_individual
end type
type gb_11 from groupbox within tabpage_individual
end type
type gb_10 from groupbox within tabpage_individual
end type
type gb_9 from groupbox within tabpage_individual
end type
type gb_15 from groupbox within tabpage_individual
end type
type gb_18 from groupbox within tabpage_individual
end type
type gb_17 from groupbox within tabpage_individual
end type
type lb_2 from listbox within tabpage_individual
end type
type gb_24 from groupbox within tabpage_individual
end type
type gb_13 from groupbox within tabpage_individual
end type
type gb_25 from groupbox within tabpage_individual
end type
type tabpage_individual from userobject within tab_1
uo_periodo2 uo_periodo2
cbx_4 cbx_4
em_4 em_4
em_3 em_3
hsb_2 hsb_2
cbx_1 cbx_1
lb_1 lb_1
cb_3x cb_3x
dw_1z dw_1z
st_1x st_1x
cb_4x cb_4x
cb_2x cb_2x
cb_1x cb_1x
em_1x em_1x
gb_22 gb_22
gb_11 gb_11
gb_10 gb_10
gb_9 gb_9
gb_15 gb_15
gb_18 gb_18
gb_17 gb_17
lb_2 lb_2
gb_24 gb_24
gb_13 gb_13
gb_25 gb_25
end type
type tab_1 from tab within w_mad_repo_24
tabpage_general tabpage_general
tabpage_individual tabpage_individual
end type
type dw_depto_0 from datawindow within w_mad_repo_24
end type
type dw_depto_5 from datawindow within w_mad_repo_24
end type
type dw_depto_4 from datawindow within w_mad_repo_24
end type
type dw_depto_3 from datawindow within w_mad_repo_24
end type
type dw_depto_2 from datawindow within w_mad_repo_24
end type
type dw_depto_1 from datawindow within w_mad_repo_24
end type
type st_2 from statictext within w_mad_repo_24
end type
type ddlb_tipo_imp from dropdownlistbox within w_mad_repo_24
end type
end forward

global type w_mad_repo_24 from w_master_main_rep
integer x = 9
integer y = 4
integer width = 4014
integer height = 2800
string title = "Listas de Asistencia"
string menuname = "m_repo_mad6"
boolean resizable = true
tab_1 tab_1
dw_depto_0 dw_depto_0
dw_depto_5 dw_depto_5
dw_depto_4 dw_depto_4
dw_depto_3 dw_depto_3
dw_depto_2 dw_depto_2
dw_depto_1 dw_depto_1
st_2 st_2
ddlb_tipo_imp ddlb_tipo_imp
end type
global w_mad_repo_24 w_mad_repo_24

type variables
string nivel
string division_x
integer ii_tipo_imp
int periodo_x[]
int ii_dw_width = 0, ii_dw_height = 0, ii_num_resize = 0

STRING is_descripcion_periodo 

Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"


end variables

forward prototypes
public subroutine separa_cve_grupo (string texto, ref long cve_mat, ref string grupo)
public subroutine wf_actualiza_lista_coordina (boolean ab_todas)
end prototypes

public subroutine separa_cve_grupo (string texto, ref long cve_mat, ref string grupo);string Texto_Temporal
int Longitud,Posicion

Posicion=Pos(texto, "-")
Texto_Temporal=Left(texto,(Posicion - 1))
cve_mat = long(Texto_Temporal)

Longitud=Len(Texto)
Longitud=Longitud - Posicion

Texto_Temporal=Right(Texto, Longitud)
grupo = upper(Texto_Temporal)

end subroutine

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
		if (nivel = ls_nivel_actual OR nivel = 'A') then
			ls_cve_coordinacion = string(ll_cve_coordinaciones[ll_indice_coord],"###000")
			ls_aux_coordinacion = ls_cve_coordinacion + " - "+ls_coordinaciones[ll_indice_coord]
			tab_1.tabpage_general.lb_4.AddItem(ls_cve_coordinacion)
			tab_1.tabpage_general.lb_3.AddItem(ls_aux_coordinacion)
		end if	
	NEXT

END IF


end subroutine

on w_mad_repo_24.create
int iCurrent
call super::create
if this.MenuName = "m_repo_mad6" then this.MenuID = create m_repo_mad6
this.tab_1=create tab_1
this.dw_depto_0=create dw_depto_0
this.dw_depto_5=create dw_depto_5
this.dw_depto_4=create dw_depto_4
this.dw_depto_3=create dw_depto_3
this.dw_depto_2=create dw_depto_2
this.dw_depto_1=create dw_depto_1
this.st_2=create st_2
this.ddlb_tipo_imp=create ddlb_tipo_imp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_depto_0
this.Control[iCurrent+3]=this.dw_depto_5
this.Control[iCurrent+4]=this.dw_depto_4
this.Control[iCurrent+5]=this.dw_depto_3
this.Control[iCurrent+6]=this.dw_depto_2
this.Control[iCurrent+7]=this.dw_depto_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.ddlb_tipo_imp
end on

on w_mad_repo_24.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_depto_0)
destroy(this.dw_depto_5)
destroy(this.dw_depto_4)
destroy(this.dw_depto_3)
destroy(this.dw_depto_2)
destroy(this.dw_depto_1)
destroy(this.st_2)
destroy(this.ddlb_tipo_imp)
end on

event open;
// Se inicializa el objeto de periodos
tab_1.tabpage_general.uo_periodo.of_inicializa_servicio( "V", "L", "L", "S", gtr_sce)
tab_1.tabpage_individual.uo_periodo2.of_inicializa_servicio( "V", "L", "L", "S", gtr_sce)


int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual
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
ii_dw_height = tab_1.tabpage_general.dw_2z.height
ii_dw_width = tab_1.tabpage_general.dw_2z.width

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/

tab_1.tabpage_general.dw_2z.settransobject(gtr_sce)
tab_1.tabpage_individual.dw_1z.settransobject(gtr_sce)




/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1
//nivel = 'T'
nivel = 'A'
division_x = 'T'



///*Desabilita las opciones nuevo, actualiza y borra del menú*/

m_repo_mad6.Individual_si = 2


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
ddlb_tipo_imp.selectitem(2)

end event

event resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final
long ll_height_dw_ind

if ii_num_resize > 0 then
	ll_height_dw = tab_1.tabpage_general.dw_2z.height
	ll_height_dw_ind = tab_1.tabpage_general.dw_2z.height
	ll_height_win = this.height

	ll_height_tab = tab_1.height
	ll_width_tab = tab_1.width

	tab_1.width = newwidth - 50
	tab_1.height = newheight - 350
	
	ll_height_tab_final = tab_1.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	tab_1.tabpage_general.gb_1.width = newwidth - 200
	tab_1.tabpage_individual.gb_25.width = newwidth - 200

	tab_1.tabpage_general.dw_2z.width = newwidth - 200
	tab_1.tabpage_general.dw_2z.height = ll_height_dw + ll_dif_height_tab
	
	tab_1.tabpage_individual.dw_1z.width = newwidth - 200
	tab_1.tabpage_individual.dw_1z.height = ll_height_dw_ind + ll_dif_height_tab + 200
else
	ii_num_resize = ii_num_resize + 1
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

tab_1.tabpage_general.uo_nivel.of_carga_control(gtr_sce)
end event

type st_sistema from w_master_main_rep`st_sistema within w_mad_repo_24
end type

type p_ibero from w_master_main_rep`p_ibero within w_mad_repo_24
end type

type tab_1 from tab within w_mad_repo_24
event selectionchanged pbm_tcnselchanged
event create ( )
event destroy ( )
integer x = 5
integer y = 316
integer width = 3863
integer height = 2208
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
tabpage_individual tabpage_individual
end type

event selectionchanged;/* Se asignan los datawindows dependiendo del TAB al menu, para poder imprimirlos */
if newindex = 1 then
	m_repo_mad6.Individual_si = 2
   m_repo_mad6.dw = tab_1.tabpage_general.dw_2z
   
	 tab_1.tabpage_general.gb_1.taborder =0
	 tab_1.tabpage_general.gb_2.taborder =0

	 tab_1.tabpage_general.gb_3.taborder =0
	 tab_1.tabpage_general.gb_4.taborder =0
//	 tab_1.tabpage_general.gb_5.taborder =0
	 tab_1.tabpage_general.gb_6.taborder =0

	 tab_1.tabpage_general.gb_7.taborder =0
	 tab_1.tabpage_general.gb_8.taborder =0
  	 tab_1.tabpage_general.gb_14.taborder =0
end if
if newindex = 2 then
	m_repo_mad6.Individual_si = 1
	m_repo_mad6.dw = tab_1.tabpage_individual.dw_1z
   
	 tab_1.tabpage_individual.gb_24.taborder =0

	 tab_1.tabpage_individual.gb_25.taborder =0
	 tab_1.tabpage_individual.gb_9.taborder =0
	 tab_1.tabpage_individual.gb_17.taborder =0
	 tab_1.tabpage_individual.gb_13.taborder =0

	 tab_1.tabpage_individual.gb_18.taborder =0
	 tab_1.tabpage_individual.gb_15.taborder =0
	 tab_1.tabpage_individual.gb_10.taborder =0
	 tab_1.tabpage_individual.gb_11.taborder =0
end if

end event

on tab_1.create
this.tabpage_general=create tabpage_general
this.tabpage_individual=create tabpage_individual
this.Control[]={this.tabpage_general,&
this.tabpage_individual}
end on

on tab_1.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_individual)
end on

type tabpage_general from userobject within tab_1
event create ( )
event destroy ( )
event ue_sincroniza ( )
integer x = 128
integer y = 16
integer width = 3717
integer height = 2176
long backcolor = 16777215
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom045!"
long picturemaskcolor = 553648127
uo_periodo uo_periodo
uo_nivel uo_nivel
uo_lb_division uo_lb_division
cbx_2 cbx_2
em_2 em_2
hsb_1 hsb_1
em_1 em_1
lb_3 lb_3
em_2x em_2x
cb_10x cb_10x
rb_5 rb_5
st_1 st_1
cb_1 cb_1
cbx_6 cbx_6
dw_2z dw_2z
rb_7 rb_7
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_6 rb_6
gb_12 gb_12
gb_14 gb_14
gb_6 gb_6
gb_2 gb_2
gb_4 gb_4
gb_7 gb_7
gb_8 gb_8
cb_20x cb_20x
cb_40x cb_40x
gb_3 gb_3
gb_1 gb_1
lb_4 lb_4
end type

on tabpage_general.create
this.uo_periodo=create uo_periodo
this.uo_nivel=create uo_nivel
this.uo_lb_division=create uo_lb_division
this.cbx_2=create cbx_2
this.em_2=create em_2
this.hsb_1=create hsb_1
this.em_1=create em_1
this.lb_3=create lb_3
this.em_2x=create em_2x
this.cb_10x=create cb_10x
this.rb_5=create rb_5
this.st_1=create st_1
this.cb_1=create cb_1
this.cbx_6=create cbx_6
this.dw_2z=create dw_2z
this.rb_7=create rb_7
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_6=create rb_6
this.gb_12=create gb_12
this.gb_14=create gb_14
this.gb_6=create gb_6
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_7=create gb_7
this.gb_8=create gb_8
this.cb_20x=create cb_20x
this.cb_40x=create cb_40x
this.gb_3=create gb_3
this.gb_1=create gb_1
this.lb_4=create lb_4
this.Control[]={this.uo_periodo,&
this.uo_nivel,&
this.uo_lb_division,&
this.cbx_2,&
this.em_2,&
this.hsb_1,&
this.em_1,&
this.lb_3,&
this.em_2x,&
this.cb_10x,&
this.rb_5,&
this.st_1,&
this.cb_1,&
this.cbx_6,&
this.dw_2z,&
this.rb_7,&
this.rb_1,&
this.rb_2,&
this.rb_3,&
this.rb_4,&
this.rb_6,&
this.gb_12,&
this.gb_14,&
this.gb_6,&
this.gb_2,&
this.gb_4,&
this.gb_7,&
this.gb_8,&
this.cb_20x,&
this.cb_40x,&
this.gb_3,&
this.gb_1,&
this.lb_4}
end on

on tabpage_general.destroy
destroy(this.uo_periodo)
destroy(this.uo_nivel)
destroy(this.uo_lb_division)
destroy(this.cbx_2)
destroy(this.em_2)
destroy(this.hsb_1)
destroy(this.em_1)
destroy(this.lb_3)
destroy(this.em_2x)
destroy(this.cb_10x)
destroy(this.rb_5)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cbx_6)
destroy(this.dw_2z)
destroy(this.rb_7)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_6)
destroy(this.gb_12)
destroy(this.gb_14)
destroy(this.gb_6)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.cb_20x)
destroy(this.cb_40x)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.lb_4)
end on

event ue_sincroniza();//ue_sincroniza
//Ejectuta las funciones requeridas al seleccionar divisiones
//

//Actualiza la lista de las coordinaciones
wf_actualiza_lista_coordina(false)

end event

type uo_periodo from uo_periodo_variable_tipos within tabpage_general
integer x = 1083
integer y = 64
integer width = 873
integer height = 348
integer taborder = 93
long backcolor = 1073741824
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_nivel from uo_nivel_2013 within tabpage_general
event destroy ( )
integer x = 1984
integer y = 52
integer taborder = 93
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type uo_lb_division from uo_pfc_list_box_multiple within tabpage_general
integer x = 37
integer y = 112
integer height = 256
integer taborder = 93
end type

on uo_lb_division.destroy
call uo_pfc_list_box_multiple::destroy
end on

type cbx_2 from checkbox within tabpage_general
integer x = 2679
integer y = 604
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "DSE"
end type

type em_2 from editmask within tabpage_general
integer x = 3246
integer y = 240
integer width = 357
integer height = 80
integer taborder = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

event constructor;taborder=4
this.text = string(today())
end event

type hsb_1 from hscrollbar within tabpage_general
event constructor pbm_constructor
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
integer x = 2779
integer y = 780
integer width = 215
integer height = 112
boolean stdheight = false
end type

event constructor;TabOrder = 0
end event

event lineleft;dw_2z.ScrollPriorPage ( ) 
end event

event lineright;dw_2z.ScrollNextPage ( ) 

end event

type em_1 from editmask within tabpage_general
integer x = 2697
integer y = 244
integer width = 357
integer height = 80
integer taborder = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "today()"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

event constructor;taborder=3
this.text = string(today())
end event

type lb_3 from listbox within tabpage_general
event constructor pbm_constructor
event doubleclicked pbm_lbndblclk
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 590
integer y = 544
integer width = 1682
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
integer x = 37
integer y = 584
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
integer x = 306
integer y = 580
integer width = 261
integer height = 92
integer taborder = 61
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
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

event type integer verifica();/* Se verifica que el Depto exista y que no se repita
en la lista*/

string Depto,Nombre
int Depto_A,Depto_B,Division_X2
Depto=em_2x.text
Depto_A=integer(Depto)

  SELECT coordinaciones.cve_coordinacion, coordinaciones.coordinacion, departamentos.cve_division  
    INTO :Depto_B, :Nombre, :Division_X2 
    FROM departamentos, coordinaciones 
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
integer x = 553
integer y = 172
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

type st_1 from statictext within tabpage_general
event constructor pbm_constructor
integer x = 2821
integer y = 80
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
integer x = 3227
integer y = 784
integer width = 306
integer height = 92
integer taborder = 61
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
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

setpointer(Hourglass!)

IF cbx_2.checked = false THEN 
	dw_2z.dataobject = "dw_repo_mad_24_gx_wrong_sin_tel"
ELSE
	dw_2z.dataobject = "dw_repo_fmc_24_gx"
END IF
dw_2z.settransobject(gtr_sce)

Total=lb_4.totalitems()
// Se verifica si existen Carreras
if ( Total > 0 )  then
   // Se limpian los datawindows
//	dw_2x.Reset() 
	dw_2z.Reset()
	contador=1
	FOR contador=1 TO Total
		Textito=lb_4.text(contador)
		Departamentos[contador]=integer(Textito)
  	NEXT
  
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
	
	PARENT.uo_periodo.of_recupera_periodos() 
	
	periodo_x[] = le_periodo[]
	is_descripcion_periodo = ""
	
	FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
		IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
		is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
		periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
		ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
	NEXT 	

	//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
	//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
	
	IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional
	
	//If dw_2z.retrieve(Departamentos,ls_array_nivel[]) <= 0 Then
	If dw_2z.retrieve(Departamentos,ls_array_nivel[], periodo_x[],ii_tipo_imp) <= 0 Then
		Messagebox("Mensaje de Sistema","No existe información para la consulta realizada")	
	  	return
	End If 
	
	dw_2z.object.st_inicio.text=em_1.text
	dw_2z.object.st_fin.text=em_2.text
	dw_2z.object.t_periodo.text = is_descripcion_periodo + " de " + STRING(dw_2z.GETITEMNUMBER(1, "mat_inscritas_anio"))
end if

end event

event constructor;TabOrder = 5
end event

type cbx_6 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event limpia ( )
integer x = 160
integer y = 776
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
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

type dw_2z from datawindow within tabpage_general
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
integer y = 968
integer width = 3680
integer height = 1212
integer taborder = 61
string dataobject = "dw_repo_mad_24_gx_wrong_sin_tel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;TabOrder = 0

end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


//string Cont
//Cont = '0'
///*Verifica si se bajo más de un dato*/
//if rowcount >= 1 then
//	// Se actualiza el numero de datos traidos
//	Cont =string(dw_2z.object.cuantos[1])
//	st_1.text='Total Gen. : '+Cont
//else
//	st_1.text='Total Gen. : '+Cont
//end if
//
////this.Object.DataWindow.Zoom = 76
end event

event dberror;RETURN 1
end event

type rb_7 from radiobutton within tabpage_general
event clicked pbm_bnclicked
integer x = 590
integer y = 240
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
integer y = 112
integer width = 471
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Estudios Disc."
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

type rb_2 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 553
integer y = 112
integer width = 494
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Historia"
end type

event clicked;division_x='2'
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
		 
		  if (this. EVENT verifica(2,Depto_A) = 1 ) then
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
boolean visible = false
integer x = 672
integer y = 104
integer width = 494
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Vicerrectoria"
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
integer y = 172
integer width = 475
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Centros"
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
boolean visible = false
integer x = 672
integer y = 176
integer width = 494
integer height = 48
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
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

type gb_12 from groupbox within tabpage_general
integer x = 2642
integer y = 540
integer width = 297
integer height = 156
integer taborder = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Uso"
borderstyle borderstyle = styleraised!
end type

type gb_14 from groupbox within tabpage_general
integer x = 2642
integer y = 712
integer width = 498
integer height = 204
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

type gb_6 from groupbox within tabpage_general
integer x = 3195
integer y = 172
integer width = 457
integer height = 176
integer taborder = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Fin Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_general
integer x = 2647
integer y = 172
integer width = 462
integer height = 176
integer taborder = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Inicio Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_general
integer x = 18
integer y = 52
integer width = 1033
integer height = 336
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
integer x = 114
integer y = 728
integer width = 325
integer height = 144
integer taborder = 63
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
end type

type gb_8 from groupbox within tabpage_general
integer x = 3200
integer y = 736
integer width = 366
integer height = 156
integer taborder = 62
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type cb_20x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2286
integer y = 576
integer width = 261
integer height = 100
integer taborder = 61
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
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

type cb_40x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2290
integer y = 728
integer width = 261
integer height = 100
integer taborder = 62
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
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


dw_2z.Reset()

st_1.text='Total Gen. : 0'
dw_2z.object.st_inicio.text="00/00/0000"
dw_2z.object.st_fin.text="00/00/0000"
end event

event constructor;TabOrder = 0
end event

type gb_3 from groupbox within tabpage_general
integer x = 18
integer y = 488
integer width = 2551
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

type gb_1 from groupbox within tabpage_general
integer x = 14
integer width = 3666
integer height = 956
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

type lb_4 from listbox within tabpage_general
event constructor pbm_constructor
integer x = 2725
integer y = 652
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

type tabpage_individual from userobject within tab_1
event create ( )
event destroy ( )
integer x = 128
integer y = 16
integer width = 3717
integer height = 2176
long backcolor = 16777215
string text = "individual"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
string picturename = "Move!"
long picturemaskcolor = 553648127
uo_periodo2 uo_periodo2
cbx_4 cbx_4
em_4 em_4
em_3 em_3
hsb_2 hsb_2
cbx_1 cbx_1
lb_1 lb_1
cb_3x cb_3x
dw_1z dw_1z
st_1x st_1x
cb_4x cb_4x
cb_2x cb_2x
cb_1x cb_1x
em_1x em_1x
gb_22 gb_22
gb_11 gb_11
gb_10 gb_10
gb_9 gb_9
gb_15 gb_15
gb_18 gb_18
gb_17 gb_17
lb_2 lb_2
gb_24 gb_24
gb_13 gb_13
gb_25 gb_25
end type

on tabpage_individual.create
this.uo_periodo2=create uo_periodo2
this.cbx_4=create cbx_4
this.em_4=create em_4
this.em_3=create em_3
this.hsb_2=create hsb_2
this.cbx_1=create cbx_1
this.lb_1=create lb_1
this.cb_3x=create cb_3x
this.dw_1z=create dw_1z
this.st_1x=create st_1x
this.cb_4x=create cb_4x
this.cb_2x=create cb_2x
this.cb_1x=create cb_1x
this.em_1x=create em_1x
this.gb_22=create gb_22
this.gb_11=create gb_11
this.gb_10=create gb_10
this.gb_9=create gb_9
this.gb_15=create gb_15
this.gb_18=create gb_18
this.gb_17=create gb_17
this.lb_2=create lb_2
this.gb_24=create gb_24
this.gb_13=create gb_13
this.gb_25=create gb_25
this.Control[]={this.uo_periodo2,&
this.cbx_4,&
this.em_4,&
this.em_3,&
this.hsb_2,&
this.cbx_1,&
this.lb_1,&
this.cb_3x,&
this.dw_1z,&
this.st_1x,&
this.cb_4x,&
this.cb_2x,&
this.cb_1x,&
this.em_1x,&
this.gb_22,&
this.gb_11,&
this.gb_10,&
this.gb_9,&
this.gb_15,&
this.gb_18,&
this.gb_17,&
this.lb_2,&
this.gb_24,&
this.gb_13,&
this.gb_25}
end on

on tabpage_individual.destroy
destroy(this.uo_periodo2)
destroy(this.cbx_4)
destroy(this.em_4)
destroy(this.em_3)
destroy(this.hsb_2)
destroy(this.cbx_1)
destroy(this.lb_1)
destroy(this.cb_3x)
destroy(this.dw_1z)
destroy(this.st_1x)
destroy(this.cb_4x)
destroy(this.cb_2x)
destroy(this.cb_1x)
destroy(this.em_1x)
destroy(this.gb_22)
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.gb_9)
destroy(this.gb_15)
destroy(this.gb_18)
destroy(this.gb_17)
destroy(this.lb_2)
destroy(this.gb_24)
destroy(this.gb_13)
destroy(this.gb_25)
end on

type uo_periodo2 from uo_periodo_variable_tipos within tabpage_individual
integer x = 1431
integer y = 92
integer height = 344
integer taborder = 72
end type

on uo_periodo2.destroy
call uo_periodo_variable_tipos::destroy
end on

type cbx_4 from checkbox within tabpage_individual
integer x = 2030
integer y = 488
integer width = 201
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "DSE"
end type

type em_4 from editmask within tabpage_individual
integer x = 2985
integer y = 260
integer width = 343
integer height = 80
integer taborder = 63
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

event constructor;taborder=4
this.text = string(today())
end event

type em_3 from editmask within tabpage_individual
integer x = 2574
integer y = 260
integer width = 343
integer height = 80
integer taborder = 63
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

event constructor;taborder=3
this.text = string(today())
end event

type hsb_2 from hscrollbar within tabpage_individual
event constructor pbm_constructor
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
integer x = 2455
integer y = 596
integer width = 229
integer height = 104
boolean stdheight = false
end type

event constructor;TabOrder = 0
end event

event lineleft;dw_1z.ScrollPriorPage ( ) 
end event

event lineright;dw_1z.ScrollNextPage ( ) 

end event

type cbx_1 from checkbox within tabpage_individual
integer x = 1463
integer y = 488
integer width = 430
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Auto - View"
end type

event constructor;taborder=0
end event

type lb_1 from listbox within tabpage_individual
event constructor pbm_constructor
event doubleclicked pbm_lbndblclk
event selectionchanged pbm_lbnselchange
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 709
integer y = 136
integer width = 590
integer height = 332
integer taborder = 62
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

event doubleclicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
string Texto


li_Index = lb_1.SelectedIndex( )
Texto = lb_2.text(li_index)


lb_1.DeleteItem(li_Index)
lb_2.DeleteItem(li_Index)
st_1x.text="Total : "+string(lb_1.totalitems())
end event

event selectionchanged;long Cve_Mat_X
string Grupo_X
long ll_Index
string Texto

ll_Index = lb_1.SelectedIndex( )
Texto = lb_2.text(ll_Index)
separa_cve_grupo(Texto,Cve_Mat_X,Grupo_X)

if cbx_1.checked = TRUE then
	// Se dispara de nuevo el evento clicked
	cb_3x.TRIGGEREVENT(CLICKED!)	
	//cb_3x.EVENT trae_datos(Cve_Mat_X,Grupo_X)
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

type cb_3x from commandbutton within tabpage_individual
event trae_datos ( long cve_mat,  string grupo )
event imprime_todos ( )
integer x = 2976
integer y = 604
integer width = 261
integer height = 96
integer taborder = 62
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event trae_datos;
setpointer(Hourglass!)
dw_1z.reset()
dw_1z.retrieve(cve_mat,grupo)
dw_1z.object.st_inicio.text=em_3.text
dw_1z.object.st_fin.text=em_4.text

end event

event imprime_todos;int Respuesta
int carrera
int plan
long ll_Index, Cve_Mat_X, Cont, Total
string Texto,Grupo_X

Respuesta=messagebox("Pregunta", " Desea Imprimir TODOS las Materias-Grupos de la Lista ? "+&
                                 "~r~ Recuerde colocar el Papel OFICIO de Manera Horizontal"+&
											"~r~       Si NO LO SABE consulte al ADMINISTRADOR ",Question!,YesNo!,2);

CHOOSE CASE Respuesta
	CASE 1
	setpointer(Hourglass!)
	Total=lb_2.totalitems()
	if Total > 0 then
		FOR Cont=1 TO Total
			dw_1z.reset()
			dw_1z.object.st_inicio.text=em_3.text
			dw_1z.object.st_fin.text=em_4.text
			Texto = lb_2.text(Cont)
			separa_cve_grupo(Texto,Cve_Mat_X,Grupo_X)
			dw_1z.retrieve(Cve_Mat_X,Grupo_X)
			dw_1z.print()
		NEXT

	end if
	
	CASE 2

END CHOOSE
end event

event constructor;taborder=5
end event

event clicked;long Cve_Mat_X
string Grupo_X
integer li_Index
string Texto



setpointer(Hourglass!)
if cbx_4.checked = false THEN
	dw_1z.dataobject = "dw_repo_mad_24_lx_wrong_sin_tel"
ELSE
	dw_1z.dataobject = "dw_repo_fmc_24_lx"
END IF
dw_1z.settransobject(gtr_sce)

dw_1z.reset()

li_Index = lb_1.SelectedIndex( )
if li_index=-1 then
	messagebox("Información","Por Favor SELECCIONE una Clave - Grupo de la Lista",Exclamation!)
else
	
	
		//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
		//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
		INTEGER le_index
		INTEGER le_periodo[] 
		STRING ls_tipo_periodo[]
		//STRING is_descripcion_periodo
		
		uo_periodo2.of_recupera_periodos() 
		
		periodo_x[] = le_periodo[]
		is_descripcion_periodo = ""
		FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo2.istr_periodos[])
			IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
			is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo2.istr_periodos[le_index].descripcion 
			periodo_x[le_index] = PARENT.uo_periodo2.istr_periodos[le_index].periodo
			ls_tipo_periodo[le_index] = PARENT.uo_periodo2.istr_periodos[le_index].tipo
		NEXT 	
		//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
		//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		

		IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional	
	
		Texto = lb_2.text(li_Index)
		separa_cve_grupo(Texto,Cve_Mat_X,Grupo_X)
		
		If dw_1z.retrieve(Cve_Mat_X,Grupo_X, periodo_x[], ii_tipo_imp)  <= 0 Then
			Messagebox("Mensaje de Sistema","No existe información para la consulta realizada")	
		End If 

		dw_1z.object.st_inicio.text=em_3.text
		dw_1z.object.st_fin.text=em_4.text
		STRING ls_anio
		IF dw_1z.ROWCOUNT() > 0 THEN 
			ls_anio = STRING(dw_1z.GETITEMNUMBER(1, "mat_inscritas_anio"))
			dw_1z.object.t_periodo.text = is_descripcion_periodo + " de " + ls_anio
		END IF
		
end if

end event

type dw_1z from datawindow within tabpage_individual
integer x = 5
integer y = 756
integer width = 3429
integer height = 1408
integer taborder = 62
string dataobject = "dw_repo_mad_24_lx_wrong_sin_tel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


//string Cont
//Cont = '0'
///*Verifica si se bajo más de un dato*/
//if rowcount >= 1 then
//	// Se actualiza el numero de datos traidos
//	Cont =string(dw_1z.object.cuantos[1])
//	st_1x.text='Total Gen. : '+Cont
//else
//	st_1x.text='Total Gen. : '+Cont
//end if


end event

event constructor;taborder=0
end event

event dberror;RETURN 1
end event

type st_1x from statictext within tabpage_individual
event constructor pbm_constructor
integer x = 2569
integer y = 100
integer width = 677
integer height = 76
integer textsize = -9
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

event constructor;TabOrder = 0
end event

type cb_4x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1010
integer y = 496
integer width = 293
integer height = 96
integer taborder = 85
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
int Total
setpointer(Hourglass!)
Total=lb_1.totalitems()
DO UNTIL Total=0
		lb_1.DeleteItem(1)
      lb_2.DeleteItem(1)
		Total=lb_1.totalitems()
LOOP
// Se limpian los Datawindows

dw_1z.reset()
st_1x.text='Total : 0'
dw_1z.object.st_inicio.text="00/00/0000"
dw_1z.object.st_fin.text="00/00/0000"


end event

event constructor;TabOrder = 0
end event

type cb_2x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 704
integer y = 496
integer width = 293
integer height = 96
integer taborder = 83
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
setpointer(Hourglass!)
// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_1.SelectedIndex( )

// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_1.DeleteItem(li_Index)
	lb_2.DeleteItem(li_Index)
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_1.SelectedIndex( )
LOOP
st_1x.text="Total : "+string(lb_1.totalitems())


end event

event constructor;TabOrder = 0
end event

type cb_1x from commandbutton within tabpage_individual
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( )
event type integer verifica_2 ( string cuenta )
integer x = 315
integer y = 280
integer width = 279
integer height = 108
integer taborder = 83
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Agregar"
end type

event clicked;/* Se verifica que exista el alumno y que no este en la lista y que su digito verificador este
correcto */
string Cuenta
	Cuenta=em_1x.text
	if (Cuenta <> '') then
		if this. EVENT verifica() = 1 then
		else
			em_1x.SelectText(1, Len(em_1x.Text))
			em_1x.setfocus()
		end if	  
end if
st_1x.text="Total : "+string(lb_1.totalitems())
end event

event constructor;TabOrder = 2
end event

event verifica;/* Se verifica que el alumno exista y que el digito verificador corresponda y que no se 
   encuentre en la lista*/

long Cve_Mat_X,Cve_Mat_Y
string Grupo_X,Grupo_Y
string Texto,Texto_OK

Texto=em_1x.text
separa_cve_grupo(Texto,Cve_Mat_X,Grupo_X)

  SELECT mat_inscritas.cve_mat,   
         mat_inscritas.gpo  
    INTO :Cve_Mat_Y, :Grupo_Y   
    FROM mat_inscritas  
   WHERE ( mat_inscritas.cve_mat =: Cve_Mat_X ) AND  
         ( mat_inscritas.gpo =: Grupo_X )  using gtr_sce;

	 if gtr_sce.sqlcode = 100 then
			messagebox("Atención","La Materia con clave : "+string(Cve_Mat_X)+" y grupo : "+Grupo_X+" no existe.")
		   /* Alumno no existe */
			return 0
	 else		
		   Texto_OK=string(Cve_Mat_X)+"-"+Grupo_X
	      if this. EVENT verifica_2(Texto_OK) = 1 then
			   lb_1.additem (Texto_OK)
            lb_2.additem (Texto_OK)
			   em_1x.text=''
		      return 1 /* Todo esta bien */
	      else
   			/* Ya esta en la lista */
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
Total=lb_2.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_2.text(contador)
	   if Cuenta=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	messagebox("Atención","La Materia con el Grupo que desea introducir ~r~ "+&
	                      "        YA SE ENCUENTRA LA LISTA")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

type em_1x from editmask within tabpage_individual
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 105
integer y = 124
integer width = 475
integer height = 84
integer taborder = 83
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
end type

event constructor;TabOrder = 1
end event

event modified;string Texto
int Hay_Guion
string Digito
/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_1x*/
if keydown(keyenter!) then	
	Texto=this.text
	if (Texto <> '') then
		  Hay_Guion=pos(Texto,"-")
		  if (Hay_Guion = 0 ) then
			  messagebox("Información","La información NO CUMPLE con el formato predeterminado."+&
			                        "~r~Sintaxis: [Cve_mat]-[Grupo], ejemplos : 2201-A,2345-A1 ",Exclamation!)
		  else
	   	  cb_1x.triggerevent("clicked")
		  end if
	end if	
end if

end event

type gb_22 from groupbox within tabpage_individual
integer x = 1961
integer y = 424
integer width = 343
integer height = 160
integer taborder = 65
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Uso"
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within tabpage_individual
integer x = 2958
integer y = 188
integer width = 393
integer height = 176
integer taborder = 63
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Fin Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_10 from groupbox within tabpage_individual
integer x = 2514
integer y = 188
integer width = 457
integer height = 176
integer taborder = 85
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Inicio Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_9 from groupbox within tabpage_individual
integer x = 1431
integer y = 424
integer width = 503
integer height = 160
integer taborder = 65
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_15 from groupbox within tabpage_individual
integer x = 2386
integer y = 528
integer width = 370
integer height = 196
integer taborder = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Mov. Pág."
borderstyle borderstyle = styleraised!
end type

type gb_18 from groupbox within tabpage_individual
integer x = 2935
integer y = 548
integer width = 347
integer height = 176
integer taborder = 83
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_17 from groupbox within tabpage_individual
integer x = 667
integer y = 56
integer width = 672
integer height = 564
integer taborder = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = " Lista  "
borderstyle borderstyle = styleraised!
end type

type lb_2 from listbox within tabpage_individual
event constructor pbm_constructor
integer x = 1074
integer y = 112
integer width = 142
integer height = 92
integer taborder = 83
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

type gb_24 from groupbox within tabpage_individual
integer x = 59
integer y = 60
integer width = 581
integer height = 180
integer taborder = 82
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = " Cve. Mat - Grupo"
borderstyle borderstyle = styleraised!
end type

type gb_13 from groupbox within tabpage_individual
integer x = 270
integer y = 228
integer width = 366
integer height = 180
integer taborder = 83
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_25 from groupbox within tabpage_individual
integer width = 3438
integer height = 744
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

type dw_depto_0 from datawindow within w_mad_repo_24
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

type dw_depto_5 from datawindow within w_mad_repo_24
event constructor pbm_constructor
boolean visible = false
integer x = 3726
integer y = 828
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(9000)
end event

type dw_depto_4 from datawindow within w_mad_repo_24
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

type dw_depto_3 from datawindow within w_mad_repo_24
event constructor pbm_constructor
boolean visible = false
integer x = 3712
integer y = 436
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(6000)
end event

type dw_depto_2 from datawindow within w_mad_repo_24
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

type dw_depto_1 from datawindow within w_mad_repo_24
boolean visible = false
integer x = 3730
integer y = 20
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(4000)
end event

type st_2 from statictext within w_mad_repo_24
integer x = 2715
integer y = 768
integer width = 498
integer height = 64
boolean bringtotop = true
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

type ddlb_tipo_imp from dropdownlistbox within w_mad_repo_24
integer x = 3237
integer y = 756
integer width = 549
integer height = 384
integer taborder = 122
boolean bringtotop = true
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

event selectionchanged;IF Lower(This.text) = 'modular' THEN
	ii_tipo_imp = 2 
ELSE
	ii_tipo_imp = 1 // 1 = Tradicional
END IF
end event

