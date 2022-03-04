$PBExportHeader$uo_tv_menu.sru
$PBExportComments$TreeView con las propiedades necesarias para convertirse en un navegador atravez de la aplicación.(CAMP(DkWf)).
forward
global type uo_tv_menu from treeview
end type
end forward

global type uo_tv_menu from treeview
int Width=494
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LinesAtRoot=true
string PictureName[]={"Custom039!",&
"Window!",&
"Table!",&
"DosEdit5!"}
long PictureMaskColor=553648127
long StatePictureMaskColor=536870912
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_populate_menu ( menu am_menu,  integer ai_roothandle,  integer ai_index )
event ue_limpia_menu ( integer ai_itemhandle_inicial )
end type
global uo_tv_menu uo_tv_menu

type variables
menu im_menu
window iw_ventana
end variables

forward prototypes
public function string of_procesa_texto (character as_texto[])
end prototypes

event ue_populate_menu;/*
DESCRIPCIÓN: Funcion que recibe un menu y regresa el texto de los menus en un arreglo.
PARÁMETROS: am_menu,as_texto[]
REGRESA: Nada
AUTOR: Carlos Armando Melgoza Piña
FECHA: Diciembre 7, 1998
MODIFICACIÓN:
*/     
integer li_numero_items,li_cont,li_roothandle
treeviewitem lt_tvi


li_numero_items = upperbound(am_menu.item[])
for li_cont = 1 to li_numero_items	
	//Agrega item en el treeview	
	if am_menu.item[li_cont].enabled = true and am_menu.item[li_cont].visible = true then
		lt_tvi.label = of_procesa_texto(am_menu.item[li_cont].text)
		lt_tvi.pictureindex = ai_index
		lt_tvi.selectedpictureindex = ai_index
		lt_tvi.data = am_menu.item[li_cont]		
		if lt_tvi.label <> "-" then
			li_roothandle = InsertItemLast(ai_roothandle,lt_tvi)
			event ue_populate_menu(am_menu.item[li_cont],li_roothandle,ai_index+1)
		end if
	end if
next

end event

event ue_limpia_menu;long ll_tv
long ll_cont 

ll_tv = finditem(ChildTreeItem!,ai_itemhandle_inicial)
if ll_tv = -1 then
	return
end if
for ll_cont = 1 to 99999
	ll_tv = finditem(ChildTreeItem!,ai_itemhandle_inicial)
	if ll_tv = -1 then
		ll_cont = 99999
	else 
		deleteItem(ll_tv)
	end if
next

	


	
end event

public function string of_procesa_texto (character as_texto[]);int li_numero_caracteres,li_cont,li_cont1 = 1
char ls_texto[]
li_numero_caracteres = upperbound(as_texto)

for li_cont = 1 to li_numero_caracteres
	if as_texto[li_cont] = '&' then
		
	elseif as_texto[li_cont] = '	' then
       return ls_texto
	else
		ls_texto[li_cont1] = as_texto[li_cont]
		li_cont1++
	end if	
next

return ls_texto
end function

event constructor;if isvalid(parent) then
	iw_ventana = parent
	if isvalid(iw_ventana.menuid) then
		im_menu = iw_ventana.menuid
		event ue_populate_menu(im_menu,0,1)
	end if
end if
end event

event doubleclicked;treeviewitem tvi_origen
menu lm_menu

if handle = 0 then
	event constructor()
	return
end if

getitem(handle,tvi_origen)

lm_menu = tvi_origen.data
if isvalid(lm_menu) then
	lm_menu.event clicked()
end if
end event

