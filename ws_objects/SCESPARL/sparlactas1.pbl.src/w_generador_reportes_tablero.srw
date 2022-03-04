$PBExportHeader$w_generador_reportes_tablero.srw
forward
global type w_generador_reportes_tablero from w_catalogo
end type
type rb_todos from radiobutton within w_generador_reportes_tablero
end type
type rb_depto from radiobutton within w_generador_reportes_tablero
end type
type rb_mat from radiobutton within w_generador_reportes_tablero
end type
type rb_matgpo from radiobutton within w_generador_reportes_tablero
end type
type lb_lista from listbox within w_generador_reportes_tablero
end type
type rb_lista from radiobutton within w_generador_reportes_tablero
end type
type gb_lista from groupbox within w_generador_reportes_tablero
end type
type gb_2 from groupbox within w_generador_reportes_tablero
end type
type gb_1 from groupbox within w_generador_reportes_tablero
end type
type sle_clave from singlelineedit within w_generador_reportes_tablero
end type
type st_clave from statictext within w_generador_reportes_tablero
end type
type cb_genera from commandbutton within w_generador_reportes_tablero
end type
type cb_borra from commandbutton within w_generador_reportes_tablero
end type
type cb_borra_elemento from commandbutton within w_generador_reportes_tablero
end type
type cbx_status from checkbox within w_generador_reportes_tablero
end type
type rb_carrera from radiobutton within w_generador_reportes_tablero
end type
type uo_1 from uo_per_ani within w_generador_reportes_tablero
end type
end forward

global type w_generador_reportes_tablero from w_catalogo
int X=37
int Width=3617
int Height=2224
boolean TitleBar=true
string Title="Generador de Reportes de Tablero"
string MenuName="m_gen_rep_tab"
long BackColor=0
event imprime ( )
rb_todos rb_todos
rb_depto rb_depto
rb_mat rb_mat
rb_matgpo rb_matgpo
lb_lista lb_lista
rb_lista rb_lista
gb_lista gb_lista
gb_2 gb_2
gb_1 gb_1
sle_clave sle_clave
st_clave st_clave
cb_genera cb_genera
cb_borra cb_borra
cb_borra_elemento cb_borra_elemento
cbx_status cbx_status
rb_carrera rb_carrera
uo_1 uo_1
end type
global w_generador_reportes_tablero w_generador_reportes_tablero

forward prototypes
public function integer verifica_depto (long depto)
public function integer verifica_mat (long mat)
public function integer verifica_carrera (long carrera)
public function integer procesa_cvegpo (string texto, ref string cve_mat_gpo)
public function integer verifica_gpo (long cve_mat, string gpo, ref string mat_gpo)
end prototypes

event imprime;long cont,total

//if cbx_status.checked = false then
		total =	dw_catalogo.rowcount() 
		for cont = 1 to total
			if dw_catalogo.getitemnumber(cont,"actas_evaluacion_status") =1 then		
				dw_catalogo.setitem(cont,"actas_evaluacion_status",2)
			end if
		next
		if dw_catalogo.update(True) = 1 then
			commit using gtr_sce;
		else
			rollback using gtr_sce;
		end if
//end if
end event

public function integer verifica_depto (long depto);//Funcion que revisa si el parametro recibido es un número de departamento 
//valido. Regresa 1 si el depto existe y 0 en caso contrario
//Abril 1998 CAMP DkWf
 
 SELECT dbo.departamentos.cve_depto  
    INTO :depto  
    FROM dbo.departamentos  
   WHERE dbo.departamentos.cve_depto = :depto   
	USING gtr_sce;
	
if gtr_sce.sqlcode = 0 then
	return 1
else
	return 0
end if

end function

public function integer verifica_mat (long mat);//Funcion que revisa si el parametro recibido es un número de materia
//valido. Regresa 1 si la mat existe y 0 en caso contrario
//Abril 1998 CAMP DkWf
 
  SELECT dbo.materias.cve_mat  
    INTO :mat  
    FROM dbo.materias  
   WHERE dbo.materias.cve_mat = :mat   
	USING gtr_sce;
	
if gtr_sce.sqlcode = 0 then
	return 1
else
	return 0
end if

end function

public function integer verifica_carrera (long carrera);//Funcion que revisa si el parametro recibido es un número de carrera
//valido. Regresa 1 si el depto existe y 0 en caso contrario
//Abril 1998 CAMP DkWf
 
  SELECT dbo.carreras.cve_carrera  
    INTO :carrera  
    FROM dbo.carreras  
   WHERE cdbo.arreras.cve_carrera = :carrera   
	USING gtr_sce;
	
if gtr_sce.sqlcode = 0 then
	return 1
else
	return 0
end if

end function

public function integer procesa_cvegpo (string texto, ref string cve_mat_gpo);//Función que recibe un string y lo descompone en
//Un Long clave de mat y un string grupo
//Regresa 0 si ocurre un error y 1 en caso contrario
//Mayo 1998 CAMP DkWf
string temp,cve,gpo
long cve_mat
int cont

for cont = 1 to len(texto)
	temp = mid(texto,cont,1)
	if temp = '-'  or temp = ' ' or cont = 5 then		
		cve_mat = long(cve)
		if temp = '-' or temp =' ' then
			cont++
		end if
		exit		
	end if
	cve = cve + temp	
next
for cont = cont to len(texto)
	gpo = gpo + upper(mid(texto,cont,1))
next

if verifica_mat(cve_mat)=1 then
	if verifica_gpo(cve_mat,gpo,cve_mat_gpo) = 1 then		
		return 1
	else
		messagebox("GRUPO NO VALIDO","El GRUPO "+gpo+" no existe para la MATERIA "+string(cve_mat)+".",stopsign!)
		return 0
	end if
else
	messagebox("CLAVE NO VALIDA","La Clave especificada "+string(cve_mat)+" no es un número de materia valido",stopsign!)
	return 0
end if
end function

public function integer verifica_gpo (long cve_mat, string gpo, ref string mat_gpo);//Funcion que revisa si el parametro recibido es un número de materia y gpo
//valido. Regresa 1 si la mat existe y 0 en caso contrario
//Abril 1998 CAMP DkWf
 
    SELECT dbo.grupos.cve_mat_gpo
    INTO :mat_gpo  
    FROM dbo.grupos  
   WHERE ( dbo.grupos.cve_mat = :cve_mat ) AND  
				( dbo.grupos.gpo = :gpo )  AND
				( dbo.grupos.periodo	= :gi_periodo) AND
				( dbo.grupos.anio	= :gi_anio )	
	USING gtr_sce;

	
if gtr_sce.sqlcode = 0 then
	return 1
else
	return 0
end if

end function

on w_generador_reportes_tablero.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_gen_rep_tab" then this.MenuID = create m_gen_rep_tab
this.rb_todos=create rb_todos
this.rb_depto=create rb_depto
this.rb_mat=create rb_mat
this.rb_matgpo=create rb_matgpo
this.lb_lista=create lb_lista
this.rb_lista=create rb_lista
this.gb_lista=create gb_lista
this.gb_2=create gb_2
this.gb_1=create gb_1
this.sle_clave=create sle_clave
this.st_clave=create st_clave
this.cb_genera=create cb_genera
this.cb_borra=create cb_borra
this.cb_borra_elemento=create cb_borra_elemento
this.cbx_status=create cbx_status
this.rb_carrera=create rb_carrera
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_todos
this.Control[iCurrent+2]=this.rb_depto
this.Control[iCurrent+3]=this.rb_mat
this.Control[iCurrent+4]=this.rb_matgpo
this.Control[iCurrent+5]=this.lb_lista
this.Control[iCurrent+6]=this.rb_lista
this.Control[iCurrent+7]=this.gb_lista
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.sle_clave
this.Control[iCurrent+11]=this.st_clave
this.Control[iCurrent+12]=this.cb_genera
this.Control[iCurrent+13]=this.cb_borra
this.Control[iCurrent+14]=this.cb_borra_elemento
this.Control[iCurrent+15]=this.cbx_status
this.Control[iCurrent+16]=this.rb_carrera
this.Control[iCurrent+17]=this.uo_1
end on

on w_generador_reportes_tablero.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_todos)
destroy(this.rb_depto)
destroy(this.rb_mat)
destroy(this.rb_matgpo)
destroy(this.lb_lista)
destroy(this.rb_lista)
destroy(this.gb_lista)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.sle_clave)
destroy(this.st_clave)
destroy(this.cb_genera)
destroy(this.cb_borra)
destroy(this.cb_borra_elemento)
destroy(this.cbx_status)
destroy(this.rb_carrera)
destroy(this.uo_1)
end on

event open;
this.x=1
this.y=1
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_generador_reportes_tablero
int X=95
int Y=525
int Width=3401
int Height=1341
int TabOrder=10
string DataObject="dw_rep_tablero"
boolean HScrollBar=true
end type

event dw_catalogo::clicked;call super::clicked;zoomin(this)
end event

event dw_catalogo::rbuttondown;call super::rbuttondown;zoomout(this)
end event

event dw_catalogo::constructor;m_gen_rep_tab.dw	=	this
end event

type rb_todos from radiobutton within w_generador_reportes_tablero
int X=176
int Y=77
int Width=680
int Height=77
boolean BringToTop=true
string Text="Todos los Reportes"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int status[]//status = 0 acta generada,1 acta leida(imprimible), 2 acta impresa
	if cbx_status.checked = false then
		status[1]	=	1
	else
		status[1]	=	0
		status[2]	=	1
		status[3]	=	2
	end if
	
if rb_todos.checked	=	true then
	lb_lista.enabled = false
	sle_clave.enabled	=	false
	cb_borra.enabled	=	false
	cb_borra_elemento.enabled	=	false
	cb_genera.enabled	=	false
	if messagebox("Atención","¿Realmente QUIERE GENERAR todos los REPORTES de TABLERO?",question!,Yesno!,2) = 1 then
		dw_catalogo.dataobject="dw_rep_tablero"
		setpointer(Hourglass!)
		dw_catalogo.settransobject(gtr_sce)
		dw_catalogo.modify("Datawindow.print.preview = Yes")
		dw_catalogo.retrieve(gi_periodo,gi_anio,status)
	else
		return 0
	end if
end if
end event

type rb_depto from radiobutton within w_generador_reportes_tablero
int X=874
int Y=74
int Width=453
int Height=77
boolean BringToTop=true
string Text="Departamento"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_depto.checked = true then
	st_clave.text	=	"Clave del Departamento"
	lb_lista.enabled = false
	sle_clave.enabled	=	true
	cb_borra.enabled	=	false
	cb_borra_elemento.enabled	=	false
	cb_genera.enabled	=	false
end if
end event

type rb_mat from radiobutton within w_generador_reportes_tablero
int X=874
int Y=234
int Width=453
int Height=77
boolean BringToTop=true
string Text="Materia"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_mat.checked = true then
	st_clave.text	=	"Clave de la Materia"
	lb_lista.enabled = false
	sle_clave.enabled	=	true
	cb_borra.enabled	=	false
	cb_borra_elemento.enabled	=	false
	cb_genera.enabled	=	false
end if
end event

type rb_matgpo from radiobutton within w_generador_reportes_tablero
int X=176
int Y=234
int Width=680
int Height=77
boolean BringToTop=true
string Text="Materia y Grupo"
boolean LeftText=true
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_matgpo.checked = true then
	st_clave.text	=	"Clave de la Materia y Grupo"
	sle_clave.setfocus()
	sle_clave.text	=	"1503-C"
	sle_clave.selecttext(1,len(sle_clave.text))
	lb_lista.enabled = false
	sle_clave.enabled	=	true
	cb_borra.enabled	=	false
	cb_borra_elemento.enabled	=	false
	cb_genera.enabled	=	false
end if
end event

type lb_lista from listbox within w_generador_reportes_tablero
int X=2465
int Y=112
int Width=494
int Height=362
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_lista from radiobutton within w_generador_reportes_tablero
int X=176
int Y=157
int Width=680
int Height=77
boolean BringToTop=true
string Text="Selección de Reportes"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_lista.checked = true then
	st_clave.text	=	"Clave de la Materia y Grupo"
	lb_lista.enabled = true
	sle_clave.enabled	=	true
	cb_borra.enabled	=	true
	cb_borra_elemento.enabled	=	true
	cb_genera.enabled	=	true
end if
end event

type gb_lista from groupbox within w_generador_reportes_tablero
int X=2432
int Y=45
int Width=1064
int Height=461
int TabOrder=30
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_generador_reportes_tablero
int X=1467
int Width=841
int Height=346
int TabOrder=60
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_generador_reportes_tablero
int X=154
int Width=1200
int Height=346
int TabOrder=90
string Text="Tipo de Reporte"
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_clave from singlelineedit within w_generador_reportes_tablero
int X=1671
int Y=202
int Width=435
int Height=93
int TabOrder=80
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long clave[],alter[],mat, ll_numrows
string gpo,cve,alterno[],matgpo,matgp[]

int status[]//status = 0 acta generada,1 acta leida(imprimible), 2 acta impresa
	if cbx_status.checked = false then
		status[1]	=	1
	else
		status[1]	=	0
		status[2]	=	1
		status[3]	=	2
	end if
alter[1]	=	0
alterno[1]=	"0"
cve =sle_clave.text

dw_catalogo.dataobject="dw_rep_tablero_op2"
dw_catalogo.settransobject(gtr_sce)
dw_catalogo.modify("Datawindow.print.preview = Yes")

if rb_depto.checked = true then
	if len(cve) > 4 then
		messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de departamento valido",stopsign!)
		return 0
	else
		if  long(cve)=0 then
			messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de departamento valido",stopsign!)
			return 0
		else
			clave[1] = long(cve)
			if verifica_depto(clave[1]) = 0 then//Funcion que revisa si cve es una clave valida de departamento
				messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de departamento valido",stopsign!)
				return 0
			else
				ll_numrows =dw_catalogo.retrieve(gi_periodo,gi_anio,status,clave,alter,alterno) 
			end if
		end if
	end if	
elseif rb_lista.checked = true then	
	lb_lista.additem(cve)
	sle_clave.selecttext(1,len(sle_clave.text))
elseif rb_carrera.checked = true then
	if len(cve) > 4 then
		messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de carrera valida",stopsign!)
		return 0
	else
		if  long(cve)=0 then
			messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de carrera valida",stopsign!)
			return 0
		else
			clave[1] = long(cve)
			if verifica_carrera(clave[1]) = 0 then//Funcion que revisa si cve es una clave valida de departamento
				messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de carrera valida",stopsign!)
				return 0
			else
//				dw_catalogo.retrieve(gi_periodo,gi_anio,status,clave,alter,alterno)
			end if
		end if
	end if	
elseif rb_mat.checked = true then
		if len(cve) > 4 then
		messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de materia valido",stopsign!)
		return 0
	else
		if  long(cve)=0 then
			messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de materia valido",stopsign!)
			return 0
		else
			clave[1] = long(cve)
			if verifica_mat(clave[1]) = 0 then//Funcion que revisa si cve es una clave valida de materia
				messagebox("CLAVE NO VALIDA","La Clave especificada "+cve+" no es un número de materia valido",stopsign!)
				return 0
			else
				ll_numrows = dw_catalogo.retrieve(gi_periodo,gi_anio,status,alter,clave,alterno)
			end if
		end if
	end if		
elseif rb_matgpo.checked = true then	
	if procesa_cvegpo(cve,matgpo)  = 1 then
		matgp[1]	=	matgpo
		ll_numrows = dw_catalogo.retrieve(gi_periodo,gi_anio,status,alter,alter,matgp)		
	else
		return 0
	end if	
end if
end event

type st_clave from statictext within w_generador_reportes_tablero
int X=1518
int Y=74
int Width=746
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Clave de la Materia y Grupo"
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_genera from commandbutton within w_generador_reportes_tablero
int X=2981
int Y=394
int Width=490
int Height=74
int TabOrder=50
boolean BringToTop=true
string Text="Generar Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long mat[],depto[],clave
string gpo,cve,matgpo,matgp[]
int cont,cont1[3],status[]//status = 0 acta generada,1 acta leida(imprimible), 2 acta impresa

if cbx_status.checked = false then
	status[1]	=	1
else
	status[1]	=	0
	status[2]	=	1
	status[3]	=	2
end if

for cont	= 1 to 3
	cont1[cont]=1
next
for cont = 1 to lb_lista.totalitems()
	lb_lista.selectitem(cont)
	cve	= lb_lista.selecteditem()
	clave = long(cve)
	if clave > 0 then
		if verifica_mat(long(cve)) = 1 then
			mat[cont1[1]]	= long(cve)
			cont1[1]++
		elseif verifica_depto(long(cve))	=	1 then
			depto[cont1[2]]	=	long(cve)
			cont1[2]++
		else
			lb_lista.deleteitem(cont)
			cont --
		end if
	elseif procesa_cvegpo(cve,matgpo) =	1 then
		matgp[cont1[3]]	= matgpo
		cont1[3]++		
	end if		 	
next

if cont1[1] = 1 then
	mat[cont1[1]]	= 0
end if
if cont1[2] = 1 then
	depto[cont1[2]]	=	0
end if
if cont1[3] = 1 then
	matgp[cont1[3]]	= "0"
end if

//dw_catalogo.retrieve(gi_periodo,gi_anio,
dw_catalogo.retrieve(gi_periodo,gi_anio,status,depto,mat,matgp) 

end event

type cb_borra from commandbutton within w_generador_reportes_tablero
int X=2984
int Y=112
int Width=490
int Height=74
int TabOrder=40
boolean BringToTop=true
string Text="Borrar Lista"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;lb_lista.reset()
end event

type cb_borra_elemento from commandbutton within w_generador_reportes_tablero
int X=2981
int Y=195
int Width=490
int Height=74
int TabOrder=70
boolean BringToTop=true
string Text="Borrar Elemento"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;lb_lista.deleteitem(lb_lista.selectedindex())
end event

type cbx_status from checkbox within w_generador_reportes_tablero
int X=135
int Y=400
int Width=841
int Height=77
boolean BringToTop=true
string Text="Reportes sin Importar Status"
BorderStyle BorderStyle=StyleLowered!
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_carrera from radiobutton within w_generador_reportes_tablero
int X=874
int Y=154
int Width=453
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Carrera"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=15793151
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_depto.checked = true then
	st_clave.text	=	"Clave de la Carrera"
	lb_lista.enabled = false
	sle_clave.enabled	=	true
	cb_borra.enabled	=	false
	cb_borra_elemento.enabled	=	false
	cb_genera.enabled	=	false
end if
end event

type uo_1 from uo_per_ani within w_generador_reportes_tablero
int X=1064
int Y=352
int TabOrder=51
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

