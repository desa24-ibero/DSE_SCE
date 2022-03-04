$PBExportHeader$w_ancestral_base.srw
forward
global type w_ancestral_base from Window
end type
end forward

global type w_ancestral_base from Window
int X=5
int Y=4
int Width=3730
int Height=2460
boolean TitleBar=true
string MenuName="m_ancestro_menu"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_inicia_seguridad ( )
event ue_destruye_seguridad ( )
event ue_proceso_inicial ( )
event ue_proceso_final ( )
event ue_ajuste_workspace ( integer ai_width,  integer ai_height )
event ue_cambia_periodo ( )
end type
global w_ancestral_base w_ancestral_base

type variables
treeviewitem tvi_padre
uo_tv_menu itv_menu
integer ii_periodo,ii_anio
end variables

forward prototypes
public subroutine of_agrega_menu_ventana ()
end prototypes

event ue_proceso_inicial;


//treeviewitem lt_tvi
int li_roothandle,indice,cont

//lt_tvi.label = "Procesos"
//lt_tvi.pictureindex = 1
//lt_tvi.selectedpictureindex = 1
//lt_tvi.data = im_menu.m_registro		
//li_roothandle = w_principal.tv_menu.InsertItemLast(tvi_padre.itemhandle,lt_tvi)

	
//w_principal.tv_menu.event ue_populate_menu(im_menu.m_proceso,li_roothandle,3)//SE ELIMINA EL AGREGAR EL MENU AL TREEVIEW 13/01/1999


//indice = upperbound(w_principal.ventanas)
//
//for cont = 1 to indice
//	if w_principal.ventanas[cont] = this then
//		return
//	elseif isvalid(w_principal.ventanas[cont]) = false then
//		w_principal.ventanas[cont] = this
//		return
//	end if	
//next
//indice++
//
//w_principal.ventanas[indice] = this
//
//sit_cobranzas.toolbarsheettitle = this.title
//
end event

event ue_proceso_final;//w_principal.tv_menu.event ue_limpia_menu(tvi_padre.itemhandle)

w_principal.postevent("ue_refresh_ventana")


end event

event ue_ajuste_workspace;Resize(ai_width, ai_height)
end event

public subroutine of_agrega_menu_ventana ();//long ll_contador,ll_maximo,ll_cont2,ll_max
//m_ancestro_ventana lm_ventana
//menu lm_menu_temporal
//
//ll_maximo = upperbound(this.menuid.item[])
//
//for ll_contador = 1 to ll_maximo
//	if this.menuid.item[ll_contador].text = as_titulo then
//		lm_ventana = create m_ancestro_ventana
//		Messagebox("1er cambio",string(this.changemenu(lm_ventana)))
//		Messagebox("2do Cambio",string(this.changemenu(lm_ventana.item[1])))
//		this.changemenu(lm_ventana.item[1])
////		messagebox("INV",classname(this.menuid.item[ll_contador]))
////		messagebox("INV",classname(lm_ventana.item[1]))
////		if classname(this.menuid.item[ll_contador]) = classname(lm_ventana.item[1]) then
////			messagebox("SON IGUALES","")
////		end if
////		this.menuid.item[ll_contador].text = lm_ventana.item[1].text
////		for ll_cont2 = 1 to upperbound(lm_ventana.item[1].item[])
////					this.menuid.item[ll_contador].item[ll_cont2] = lm_ventana.item[1].item[ll_cont2]
////		next
////		lm_menu_temporal = this.menuid
////		this.changemenu(lm_menu_temporal)
//		/*this.menuid.item[ll_contador+1] = lm_ventana.item[1]
//		this.menuid.item[ll_contador] = this.menuid.item[ll_contador+1]*/
//		
////		messagebox("YA","")		
////
////		messagebox("INV",classname(this.menuid.item[ll_contador]))
//		
//	end if
//next
//
//return lm_ventana
end subroutine

on w_ancestral_base.create
if this.MenuName = "m_ancestro_menu" then this.MenuID = create m_ancestro_menu
end on

on w_ancestral_base.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;x	=	1
y	=	1
//itv_menu = w_principal.tv_menu
//tvi_padre = w_principal.tvi_actual
//title = tvi_padre.Label

//w_principal.i_ventana_tree[1].ventana = this



postevent("ue_proceso_inicial")
postevent("ue_inicia_seguridad")

end event

event close;triggerevent("ue_destruye_seguridad")
triggerevent("ue_proceso_final")
end event

event activate;//if w_principal.ii_bandera_hojas = 0 then
//	event ue_ajuste_workspace(w_principal.mdi_1.width,w_principal.mdi_1.height)
//end if

//itv_menu.SelectItem (tvi_padre.ItemHandle	 )
//itv_menu.setfocus()
//
end event

event rbuttondown;menuid.PopMenu ( xpos, ypos )
end event

event resize;if width < 3730 then
	hscrollbar = true
else
	hscrollbar = false
end if
if height < 2460 then
	vscrollbar = true
else
	vscrollbar = false	
end if
end event

