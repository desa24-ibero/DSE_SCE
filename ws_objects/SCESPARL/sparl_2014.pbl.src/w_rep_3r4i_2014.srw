$PBExportHeader$w_rep_3r4i_2014.srw
forward
global type w_rep_3r4i_2014 from w_ancestral
end type
type cb_1 from commandbutton within w_rep_3r4i_2014
end type
type dw_1 from datawindow within w_rep_3r4i_2014
end type
type uo_1 from uo_per_ani within w_rep_3r4i_2014
end type
type p_ibero from picture within w_rep_3r4i_2014
end type
type st_sistema from statictext within w_rep_3r4i_2014
end type
end forward

global type w_rep_3r4i_2014 from w_ancestral
integer width = 3858
integer height = 2672
string title = "Reporte de Cortes de 3 Reprobadas y/o 4 Inscritas"
string menuname = "m_menu"
long backcolor = 16777215
event agrega ( string linea )
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
p_ibero p_ibero
st_sistema st_sistema
end type
global w_rep_3r4i_2014 w_rep_3r4i_2014

event agrega(string linea);int in_a
long lo_cuenta,lo_materia_r,lo_materia_i,lo_carrera,lo_renglon
string st_nom,st_apa,st_ama

in_a=Pos (linea, "	")
lo_cuenta=long(Left (linea, in_a))

  SELECT alumnos.nombre, alumnos.apaterno, alumnos.amaterno  
    INTO :st_nom, :st_apa, :st_ama  
    FROM alumnos  
   WHERE alumnos.cuenta = :lo_cuenta
	USING gtr_sce;
	
	if isnull(st_nom) then
		st_nom=""
	end if
	
	if isnull(st_apa) then
		st_apa=""
	else
		st_apa=st_apa+' '
	end if

	if isnull(st_ama) then
		st_ama=""
	else
		st_ama=st_ama+' '
	end if
	
	  SELECT v_sce_carreras_cursadas.cve_carrera  
    INTO :lo_carrera  
    FROM v_sce_carreras_cursadas  
   WHERE  v_sce_carreras_cursadas.vigente = 1
	and v_sce_carreras_cursadas.cuenta = :lo_cuenta
	USING gtr_sce;

linea=mid(linea,in_a+1)
in_a=Pos (linea, "	")
lo_materia_r=long(Left (linea, in_a))

linea=mid(linea,in_a+1)
lo_materia_i=real(linea)

lo_renglon=dw_1.insertrow(lo_renglon)
dw_1.scrolltorow(lo_renglon)

dw_1.object.cuenta[lo_renglon]=lo_cuenta
dw_1.object.carrera[lo_renglon]=lo_carrera
dw_1.object.nombre[lo_renglon]=st_apa+st_ama+st_nom
dw_1.object.materia_r[lo_renglon]=lo_materia_r
dw_1.object.materia_i[lo_renglon]=lo_materia_i

/* Formato: 

70911	7766	0
72994	5460	0
72994	0	5460

*/
end event

on w_rep_3r4i_2014.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.p_ibero=create p_ibero
this.st_sistema=create st_sistema
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.p_ibero
this.Control[iCurrent+5]=this.st_sistema
end on

on w_rep_3r4i_2014.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.p_ibero)
destroy(this.st_sistema)
end on

event open;call super::open;periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_rep_3r4i_2014
boolean visible = false
end type

type cb_1 from commandbutton within w_rep_3r4i_2014
event clicked pbm_bnclicked
integer x = 1353
integer y = 164
integer width = 229
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga"
end type

event clicked;long lo_bytes_read
string st_s
int in_lee_file

in_lee_file = FileOpen("3ry4i.txt",LineMode!, Read!, LockReadWrite!)

CHOOSE CASE gi_periodo
	CASE 0
		dw_1.object.titulo.text='PRIMAVERA '+string(gi_anio)
	CASE 1
		dw_1.object.titulo.text='VERANO '+string(gi_anio)
	CASE 2
		dw_1.object.titulo.text='OTOÑO '+string(gi_anio)
END CHOOSE

lo_bytes_read = FileRead(in_lee_file, st_s)
DO UNTIL lo_bytes_read=-100
	if lo_bytes_read>0 then
		event agrega(st_s)
	end if
	lo_bytes_read = FileRead(in_lee_file, st_s)
LOOP	
FileClose(in_lee_file)

dw_1.Sort()
dw_1.GroupCalc()
end event

type dw_1 from datawindow within w_rep_3r4i_2014
event constructor pbm_constructor
integer y = 424
integer width = 3771
integer height = 1916
integer taborder = 20
string dataobject = "d_rep_3r4i"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;m_menu.dw = this

DataWindowChild carr
getchild("carrera",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

type uo_1 from uo_per_ani within w_rep_3r4i_2014
integer x = 1856
integer y = 124
integer taborder = 2
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type p_ibero from picture within w_rep_3r4i_2014
integer x = 59
integer y = 40
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_sistema from statictext within w_rep_3r4i_2014
integer x = 805
integer y = 124
integer width = 229
integer height = 100
boolean bringtotop = true
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

