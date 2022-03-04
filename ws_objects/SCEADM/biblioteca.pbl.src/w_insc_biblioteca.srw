$PBExportHeader$w_insc_biblioteca.srw
forward
global type w_insc_biblioteca from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_insc_biblioteca
end type
type cb_9 from commandbutton within w_insc_biblioteca
end type
type uo_2 from uo_carrera within w_insc_biblioteca
end type
type uo_1 from uo_ver_per_ani within w_insc_biblioteca
end type
type dw_1 from uo_dw_reporte within w_insc_biblioteca
end type
end forward

global type w_insc_biblioteca from Window
int X=834
int Y=362
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Listados para Biblioteca"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cb_9 cb_9
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_insc_biblioteca w_insc_biblioteca

type variables

end variables

on w_insc_biblioteca.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cb_9=create cb_9
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.cb_9,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_insc_biblioteca.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.cb_9)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

uo_tipo_periodo_ing.rb_registro.checked= false
uo_tipo_periodo_ing.rb_ingreso.checked= true

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_insc_biblioteca
int X=2289
int Y=22
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cb_9 from commandbutton within w_insc_biblioteca
int X=1236
int Y=250
int Width=658
int Height=74
int TabOrder=20
string Text="Archivo para Biblioteca"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int value,esc_file,row,clv_carr
string docname, named
string nombre,apellido,calle,colonia,cp,telefono,carrera
long folio,cuenta

value = GetFileSaveName("Selecciona Archivo",+ docname, named, "TXT",+ "Archivo de Biblioteca (*.txt),*.txt,")

IF value = 1 THEN 	
	esc_file = FileOpen(docname,LineMode!, Write!, LockReadWrite!, Replace!)
	SetPointer(HourGlass!)
	FOR row=1 TO dw_1.rowcount()
		cuenta=dw_1.object.general_cuenta[row]
		if isnull(cuenta) then
			cuenta=0
		end if
		folio=dw_1.object.aspiran_folio[row]
		nombre=dw_1.object.general_nombre[row]
		apellido=dw_1.object.general_apaterno[row]+' '+dw_1.object.general_amaterno[row]
		clv_carr=dw_1.object.aspiran_clv_carr[row]
		calle=dw_1.object.general_calle[row]
		if isnull(calle) then
			calle=''
		end if
		cp=dw_1.object.general_codigo_pos[row]
		if isnull(cp) then
			cp=''
		end if
		colonia=dw_1.object.general_colonia[row]
		if isnull(colonia) then
			colonia=''
		end if
		telefono=dw_1.object.general_telefono[row]
		if isnull(telefono) then
			telefono=''
		end if
		
		SELECT carreras.carrera
		INTO :carrera
		FROM carreras
		WHERE carreras.cve_carrera = :clv_carr
		USING gtr_sce;
		
		FileWrite(esc_file,'LIBRARY : UIA')
		FileWrite(esc_file,'ID : 130'+string(cuenta,"000000")+'-'+obten_digito(cuenta))
		FileWrite(esc_file,'NAME : '+nombre)
		FileWrite(esc_file,'SURNAME : '+apellido)
		FileWrite(esc_file,'UPDATE : '+string(today(),"yymmdd"))
		FileWrite(esc_file,'BO-TYPE : AL')
		FileWrite(esc_file,'BO-STATUS : 04')
		FileWrite(esc_file,'PERM-ADDRESS : '+calle)
		FileWrite(esc_file,'PERM-ADDRESS : '+colonia)
		FileWrite(esc_file,'PERM-ADDRESS : '+cp)
		FileWrite(esc_file,'TELEPHONE : 01'+telefono)
		FileWrite(esc_file,'ACAD-CODE : '+string(clv_carr,"000"))
		FileWrite(esc_file,'ACAD-NAME : '+carrera)
		FileWrite(esc_file,'')
	NEXT
	FileClose(esc_file)
end if
end event

type uo_2 from uo_carrera within w_insc_biblioteca
int X=2304
int Y=182
boolean Enabled=true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_insc_biblioteca
int X=4
int Y=6
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_insc_biblioteca
int X=15
int Y=387
int Width=3639
int Height=1402
int TabOrder=0
string DataObject="dw_insc_biblioteca"
boolean HScrollBar=true
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_insc_biblioteca"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_insc_biblioteca_ing"
	this.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

object.st_1.text=tit1
event primero()
return retrieve(gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

