$PBExportHeader$w_grupos_bloqueados.srw
forward
global type w_grupos_bloqueados from w_teoria_lab
end type
type st_descripcion from statictext within w_grupos_bloqueados
end type
type cb_elimina_bloqueados from commandbutton within w_grupos_bloqueados
end type
end forward

global type w_grupos_bloqueados from w_teoria_lab
int Height=1670
boolean TitleBar=true
string Title="Grupos Bloqueados para Reinscripcion"
long BackColor=1090519039
st_descripcion st_descripcion
cb_elimina_bloqueados cb_elimina_bloqueados
end type
global w_grupos_bloqueados w_grupos_bloqueados

type variables
st_confirma_usuario ist_confirma_usuario
end variables

on w_grupos_bloqueados.create
int iCurrent
call super::create
this.st_descripcion=create st_descripcion
this.cb_elimina_bloqueados=create cb_elimina_bloqueados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_descripcion
this.Control[iCurrent+2]=this.cb_elimina_bloqueados
end on

on w_grupos_bloqueados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_descripcion)
destroy(this.cb_elimina_bloqueados)
end on

type st_1 from w_teoria_lab`st_1 within w_grupos_bloqueados
int X=88
int Y=96
int Width=1979
string Text="Carreras a las que SI se puede y SE DEBE inscribir la materia-grupo"
Alignment Alignment=Left!
long BackColor=16777215
int Weight=700
FontCharSet FontCharSet=DefaultCharSet!
end type

type cb_ver_planes_por_mat from w_teoria_lab`cb_ver_planes_por_mat within w_grupos_bloqueados
int TabOrder=10
end type

type dw_teoria_lab from w_teoria_lab`dw_teoria_lab within w_grupos_bloqueados
int TabOrder=20
string DataObject="d_reinscripcion_materias"
end type

type st_descripcion from statictext within w_grupos_bloqueados
int X=88
int Y=96
int Width=1979
int Height=77
boolean Enabled=false
string Text="Carreras a las que SI se puede y SE DEBE inscribir la materia-grupo"
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_elimina_bloqueados from commandbutton within w_grupos_bloqueados
int X=1137
int Y=1331
int Width=1086
int Height=106
int TabOrder=30
boolean BringToTop=true
string Text="Eliminar Todos los Grupos Bloqueados"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_confirma, li_resultado_elimina
long ll_cant_grupos

ll_cant_grupos = f_cuenta_grupos_bloqueados()

IF ll_cant_grupos= -1 THEN
	RETURN	
END IF

li_confirma=MessageBox("Confirme Eliminación", "¿Desea eliminar los ["+string(ll_cant_grupos)+"] grupos bloqueados?",Question!, YesNo!)
							 
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


li_resultado_elimina= f_elimina_grupos_bloqueados()

IF li_resultado_elimina <> -1 THEN
	dw_teoria_lab.Reset()
	MessageBox("Eliminación Exitosa", "Los grupos bloqueados han sido eliminados exitosamente", Information!)
	RETURN
END IF

end event

