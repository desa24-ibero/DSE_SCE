$PBExportHeader$w_cupo_salones.srw
forward
global type w_cupo_salones from Window
end type
type st_1 from singlelineedit within w_cupo_salones
end type
type rb_3 from radiobutton within w_cupo_salones
end type
type rb_2 from radiobutton within w_cupo_salones
end type
type rb_1 from radiobutton within w_cupo_salones
end type
type cb_2 from commandbutton within w_cupo_salones
end type
type cb_1 from commandbutton within w_cupo_salones
end type
type dw_cupo from datawindow within w_cupo_salones
end type
type gb_1 from groupbox within w_cupo_salones
end type
end forward

global type w_cupo_salones from Window
int X=832
int Y=360
int Width=1979
int Height=684
boolean TitleBar=true
string Title="Cupo Materias"
long BackColor=0
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
dw_cupo dw_cupo
gb_1 gb_1
end type
global w_cupo_salones w_cupo_salones

on w_cupo_salones.create
this.st_1=create st_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_cupo=create dw_cupo
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_2,&
this.cb_1,&
this.dw_cupo,&
this.gb_1}
end on

on w_cupo_salones.destroy
destroy(this.st_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_cupo)
destroy(this.gb_1)
end on

type st_1 from singlelineedit within w_cupo_salones
int X=91
int Y=396
int Width=192
int Height=76
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="1999"
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_cupo_salones
int X=87
int Y=304
int Width=334
int Height=76
string Text="Otoño"
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_cupo_salones
int X=87
int Y=232
int Width=334
int Height=76
string Text="Verano"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_cupo_salones
int X=87
int Y=168
int Width=334
int Height=76
string Text="Primavera"
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_cupo_salones
int X=32
int Y=16
int Width=274
int Height=64
int TabOrder=20
string Text="Renglon"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_cupo.insertrow(0)
end event

type cb_1 from commandbutton within w_cupo_salones
int X=1605
int Y=44
int Width=265
int Height=108
int TabOrder=40
string Text="Guardar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long mat,mat_a
int cupo,tipo
string gpo,gpo_a
int per, anio
anio = integer(st_1.text)
per = 2
if (rb_1.checked = true) then
	per = 0
else
	if (rb_2.checked = true) then per = 1
end if



dw_cupo.accepttext()

mat	=	dw_cupo.getitemnumber(1,1)
gpo	=	dw_cupo.getitemstring(1,2)
cupo	=	dw_cupo.getitemnumber(1,3)
tipo	=	dw_cupo.getitemnumber(1,4)
mat_a	=	dw_cupo.getitemnumber(1,5)
gpo_a	=	dw_cupo.getitemstring(1,6)

if tipo = 2 then
	 UPDATE grupos  
		    SET cupo = :cupo 
	  WHERE 			((( grupos.cve_mat = :mat_a) AND
						( grupos.gpo = :gpo_a)) OR
						(( grupos.cve_asimilada = :mat_a) AND
						( grupos.gpo_asimilado =:gpo_a))) AND
						( grupos.periodo = :per) AND
						( grupos.anio = :anio) using gtr_sce;
else
	UPDATE grupos  
		    SET cupo = :cupo
	  WHERE 			((( grupos.cve_mat = :mat ) AND  
			         ( grupos.gpo = :gpo )) OR
						(( grupos.cve_asimilada = :mat) AND
						( grupos.gpo_asimilado = :gpo))) AND
						( grupos.periodo = :per) AND
						( grupos.anio = :anio) using gtr_sce;
end if

if gtr_sce.sqlcode = 0 then
	commit using gtr_sce;
	messagebox("OK","Se realizó adecuadamente el cambio")
else
	rollback using gtr_sce;
	messagebox("ERROR"," NO se realizó el cambio")
end if

end event

type dw_cupo from datawindow within w_cupo_salones
int X=562
int Y=20
int Width=987
int Height=284
int TabOrder=30
string DataObject="dw_grupos_cupo"
boolean LiveScroll=true
end type

event itemchanged;int col, per, anio
anio = integer(st_1.text)
per = 2
if rb_1.checked = true then
	per = 0
else
	if rb_2.checked = true then per = 1
end if

col = getcolumn()
accepttext()
if col = 1 then
	setcolumn(2) 
elseif col = 2 then
	retrieve(getitemnumber(1,1),getitemstring(1,2), anio, per)
end if
end event

event constructor;settransobject(gtr_sce)
insertrow(0)
end event

type gb_1 from groupbox within w_cupo_salones
int X=32
int Y=96
int Width=503
int Height=404
int TabOrder=10
string Text="Periodo"
long TextColor=16777215
long BackColor=0
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

