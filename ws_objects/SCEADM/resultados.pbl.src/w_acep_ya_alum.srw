$PBExportHeader$w_acep_ya_alum.srw
$PBExportComments$Aspirantes aceptados con mismo sexo y fecha de nac. que algún alumno
forward
global type w_acep_ya_alum from window
end type
type ddlb_opcion from dropdownlistbox within w_acep_ya_alum
end type
type em_max from editmask within w_acep_ya_alum
end type
type em_min from editmask within w_acep_ya_alum
end type
type st_1 from statictext within w_acep_ya_alum
end type
type dw_1 from datawindow within w_acep_ya_alum
end type
type cb_1 from commandbutton within w_acep_ya_alum
end type
type uo_1 from uo_ver_per_ani within w_acep_ya_alum
end type
end forward

global type w_acep_ya_alum from window
integer x = 832
integer y = 360
integer width = 2866
integer height = 656
boolean titlebar = true
string title = "Aceptados ya Alumnos"
string menuname = "m_menu"
event type long num_folios ( integer min_max )
ddlb_opcion ddlb_opcion
em_max em_max
em_min em_min
st_1 st_1
dw_1 dw_1
cb_1 cb_1
uo_1 uo_1
end type
global w_acep_ya_alum w_acep_ya_alum

type variables

end variables

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

on w_acep_ya_alum.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.ddlb_opcion=create ddlb_opcion
this.em_max=create em_max
this.em_min=create em_min
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={this.ddlb_opcion,&
this.em_max,&
this.em_min,&
this.st_1,&
this.dw_1,&
this.cb_1,&
this.uo_1}
end on

on w_acep_ya_alum.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_opcion)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sce)
end event

type ddlb_opcion from dropdownlistbox within w_acep_ya_alum
integer x = 928
integer y = 224
integer width = 489
integer height = 228
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"NORMAL","DIFERIDOS"}
end type

type em_max from editmask within w_acep_ya_alum
integer x = 2377
integer y = 172
integer width = 407
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ","
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_acep_ya_alum
integer x = 2377
integer y = 44
integer width = 407
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type st_1 from statictext within w_acep_ya_alum
integer x = 27
integer y = 364
integer width = 2286
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_acep_ya_alum
event type integer carga ( character sex,  datetime fecha )
integer x = 59
integer y = 536
integer width = 1088
integer height = 436
string dataobject = "dw_alumnos"
boolean vscrollbar = true
end type

event type integer carga(character sex, datetime fecha);SetPointer(HourGlass!)

IF Isnull(sex) OR Isnull(fecha) THEN RETURN 0

return retrieve(sex,fecha)
end event

event constructor;m_menu.dw = this

end event

type cb_1 from commandbutton within w_acep_ya_alum
integer x = 2359
integer y = 320
integer width = 430
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Busca"
end type

event clicked;long fol,min,max,cuen
int cont,esc_file,flag,value,opcion
char sex
datetime fecha
string r,docname,named,nombre

min=long(em_min.text)
max=long(em_max.text)

IF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=4
else
	opcion=1
END IF

value = GetFileSaveName("Selecciona Archivo",+ docname, named, "TXT",+ "Archivo Texto (*.TXT),*.TXT,")

IF value = 1 THEN 	
	SetPointer(HourGlass!)
	esc_file = FileOpen(docname,LineMode!, Write!, LockReadWrite!, Replace!)

	FOR fol=min TO max
		st_1.text='Buscando al Folio '+string(fol)+' de '+string(max)

	  SELECT aspiran.status
   	 INTO :flag
	    FROM aspiran
   	WHERE ( aspiran.clv_ver = :gi_version ) AND  
	         ( aspiran.clv_per = :gi_periodo ) AND  
   	      ( aspiran.anio = :gi_anio )   AND
				( aspiran.folio = :fol )
		USING gtr_sadm;
		if gtr_sadm.SQLCode = 100 then
			st_1.text='No existe el folio '+string(fol)
		else
			if flag=opcion then
			
			  SELECT general.sexo  
				 INTO :sex
				 FROM general  
				WHERE ( general.clv_ver = :gi_version ) AND  
						( general.clv_per = :gi_periodo ) AND  
						( general.anio = :gi_anio )   AND
						( general.folio = :fol )
				USING gtr_sadm;
	
			  SELECT general.fecha_nac
				 INTO :fecha
				 FROM general  
				WHERE ( general.clv_ver = :gi_version ) AND  
						( general.clv_per = :gi_periodo ) AND  
						( general.anio = :gi_anio )   AND
						( general.folio = :fol )
				USING gtr_sadm;
		
				if dw_1.event carga(sex,fecha)>0 then
	
					SELECT general.nombre+' '+general.apaterno+' '+general.amaterno
					INTO :nombre
					FROM general  
					WHERE ( general.clv_ver = :gi_version ) AND  
						( general.clv_per = :gi_periodo ) AND  
						( general.anio = :gi_anio )   AND
						( general.folio = :fol )
					USING gtr_sadm;
	
					for cont=1 to dw_1.rowcount()
						r=string(fol)+' '+nombre
						FileWrite(esc_file, r)
						r=string(dw_1.object.cuenta[cont])+'--'+obten_digito(dw_1.object.cuenta[cont])+&
							' '+dw_1.object.nombre[cont]
						FileWrite(esc_file, r)
						r=dw_1.object.apaterno[cont]
						FileWrite(esc_file, r)
						r=dw_1.object.amaterno[cont]
						FileWrite(esc_file, r)
						r="--------"
						FileWrite(esc_file, r)
					next/*cont=1 to dw_1.rowcount()*/
				end if/*dw_1.event carga(sex,fecha)>0*/
			end if/*flag>opcion*/
		end if/*gtr_sadm.SQLCode = 100*/
	NEXT/*fol=min TO max*/
	FileClose(esc_file)
end if/*value = 1*/
st_1.text='Listo'
end event

type uo_1 from uo_ver_per_ani within w_acep_ya_alum
integer x = 27
integer y = 48
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

