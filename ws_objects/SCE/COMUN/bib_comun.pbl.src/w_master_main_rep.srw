$PBExportHeader$w_master_main_rep.srw
forward
global type w_master_main_rep from w_main
end type
type st_sistema from statictext within w_master_main_rep
end type
type p_ibero from picture within w_master_main_rep
end type
end forward

global type w_master_main_rep from w_main
integer width = 2738
integer height = 1772
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = false
long backcolor = 16777215
event ue_nuevo ( )
event ue_carga ( )
event ue_actualiza ( )
event ue_borra ( )
event ue_imprime ( )
event ue_inicia_proceso ( )
st_sistema st_sistema
p_ibero p_ibero
end type
global w_master_main_rep w_master_main_rep

type variables
datawindow idw_trabajo
end variables

forward prototypes
public function integer wf_validar ()
public subroutine wf_limpiar ()
end prototypes

public function integer wf_validar ();return 1
end function

public subroutine wf_limpiar ();
end subroutine

on w_master_main_rep.create
int iCurrent
call super::create
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sistema
this.Control[iCurrent+2]=this.p_ibero
end on

on w_master_main_rep.destroy
call super::destroy
destroy(this.st_sistema)
destroy(this.p_ibero)
end on

event close;call super::close;//dwItemStatus l_status
//
//l_status = idw_trabajo.GetItemStatus(1, 0, Primary!)
//
//if l_status <> NotModified!	then
//	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
//		if wf_validar () <> 1 then 	
//			rollback using gtr_sce;
//			messagebox("Información","No se han guardado los cambios")	
//			return 
//		else
//			 triggerevent("ue_actualiza")
//		end if
//	end if
//end if
end event

event activate;//
end event

event open;call super::open;x = 1
y = 1

p_ibero.PictureName = gs_logo
end event

event closequery;return 0
end event

type st_sistema from statictext within w_master_main_rep
integer x = 709
integer y = 104
integer width = 229
integer height = 100
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

type p_ibero from picture within w_master_main_rep
integer x = 18
integer y = 20
integer width = 681
integer height = 264
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

