$PBExportHeader$w_ancestral_base.srw
forward
global type w_ancestral_base from window
end type
end forward

global type w_ancestral_base from window
integer x = 4
integer y = 3
integer width = 3730
integer height = 2461
boolean titlebar = true
string menuname = "m_ancestro_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
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

event ue_proceso_inicial();int li_roothandle,indice,cont


end event

event ue_proceso_final();
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



postevent("ue_proceso_inicial")
postevent("ue_inicia_seguridad")

end event

event close;triggerevent("ue_destruye_seguridad")
triggerevent("ue_proceso_final")
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

