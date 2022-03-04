$PBExportHeader$w_cap_ceneval.srw
forward
global type w_cap_ceneval from Window
end type
type cb_2 from commandbutton within w_cap_ceneval
end type
type cb_1 from commandbutton within w_cap_ceneval
end type
type dw_1 from uo_dw_captura within w_cap_ceneval
end type
type uo_1 from uo_ver_per_ani within w_cap_ceneval
end type
end forward

global type w_cap_ceneval from Window
int X=834
int Y=362
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos dados por el CENEVAL"
string MenuName="m_menu"
long BackColor=30976088
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
end type
global w_cap_ceneval w_cap_ceneval

type variables
integer ii_FileNum
end variables

forward prototypes
public function character sexo (string sex)
public function integer edo_civil (string edo_civ)
public function integer estado (string entidad)
public function integer horas (string horas_sem)
public function integer trabajo (string ocupacion)
end prototypes

public function character sexo (string sex);CHOOSE CASE sex
	CASE "MASCULINO"
		return 'M'
	CASE "FEMENINO"
		return 'F'
	CASE ELSE
		return '?'
END CHOOSE

end function

public function integer edo_civil (string edo_civ);CHOOSE CASE edo_civ
	CASE "SOLTERO (A)"
		return 0
	CASE "CASADO (A) O UNION LIBRE"
		return 1
	CASE "DIVORCIADO"
		return 2
	CASE "VIUDO (A)"
		return 3
	CASE ELSE
		return 999
END CHOOSE
end function

public function integer estado (string entidad);CHOOSE CASE entidad
	CASE "AGUASCALIENTES"
		RETURN 2
	CASE "BAJA CALIFORNIA"
		RETURN 3
	CASE "BAJA CALIFORNIA SUR"
		RETURN 4
	CASE "CAMPECHE"
		RETURN 5
	CASE "COAHUILA"
		RETURN 6
	CASE "COLIMA"
		RETURN 7
	CASE "CHIAPAS"
		RETURN 8
	CASE "CHIHUAHUA"
		RETURN 9
	CASE "DISTRITO FEDERAL"
		RETURN 1
	CASE "DURANGO"
		RETURN 10
	CASE "GUANAJUATO"
		RETURN 11
	CASE "GUERRERO"
		RETURN 12
	CASE "HIDALGO"
		RETURN 13
	CASE "JALISCO"
		RETURN 14
	CASE "MEXICO"
		RETURN 33
	CASE "MICHOACAN"
		RETURN 16
	CASE "MORELOS"
		RETURN 17
	CASE "NAYARIT"
		RETURN 18
	CASE "NUEVO LEON"
		RETURN 19
	CASE "OAXACA"
		RETURN 20
	CASE "PUEBLA"
		RETURN 21
	CASE "QUERETARO"
		RETURN 22
	CASE "QUINTANA ROO"
		RETURN 23
	CASE "SAN LUIS POTOSI"
		RETURN 24
	CASE "SINALOA"
		RETURN 25
	CASE "SONORA"
		RETURN 26
	CASE "TABASCO"
		RETURN 27
	CASE "TAMAULIPAS"
		RETURN 28
	CASE "TLAXCALA"
		RETURN 29
	CASE "VERACRUZ"
		RETURN 30
	CASE "YUCATAN"
		RETURN 31
	CASE "ZACATECAS"
		RETURN 32
	CASE "EXTRANJERO"
		RETURN 49		
	CASE ELSE
		return 999
END CHOOSE

end function

public function integer horas (string horas_sem);CHOOSE CASE horas_sem
	CASE "MENOS DE 10"
		return 1
	CASE "DE 11 A 20"
		return 3
	CASE "DE 21 A 30"
		return 5
	CASE "DE 31 A 40"
		return 7
	CASE "MAS DE 40"
		return 10 		
	CASE ELSE
		return 999
END CHOOSE
end function

public function integer trabajo (string ocupacion);CHOOSE CASE ocupacion
	CASE "NO TRABAJA"
		return 0
	CASE "ESTUDIANTE"
		return 0
	CASE "FUNCIONARIO O GERENTE (NIVEL DIRECTIVO CON PERSONAL A SU CARGO)"
		return 999
	CASE "DUEÑO DE NEGOCIO, EMPRESA, DESPACHO O COMERCIO ESTABLECIDO"
		return 6
	CASE "PROFESIONAL QUE EJERCE POR SU CUENTA"
		return 6
	CASE "PROFESOR, INVESTIGADOR O ARTISTA"
		return 7
	CASE "BUROCRATA O MIEMBRO DE LAS FUERZAS ARMADAS"
		return 1
	CASE "EMPLEADO DE CONFIANZA O PROFESIONAL"
		return 999
	CASE "OFICINISTA O SECRETARIA"
		return 999
	CASE "OBRERO"
		return 5
	CASE "VENDEDOR EN COMERCIO O EMPRESAS"
		return 4
	CASE "VENDEDOR POR SU CUENTA O AMBULANTE"
		return 6
	CASE "GANADERO, AGRICULTOR O SIMILARES"
		return 999
	CASE "CAMPESINO, JORNALERO, PESCADOR O SIMILARES"
		return 999
	CASE "TRABAJADOR DE OFICIOS CON PERSONAL AUXILIAR A SU CARGO"
		return 999
	CASE "PEON, AYUDANTE, SIRVIENTE O MOZO"
		return 999
	CASE "JUBILADO O PENSIONADO"
		return 0
	CASE "LABORES DEL HOGAR"
		return 0
	CASE "NO LO SE"
		return 999
	CASE "OTRA"
		return 999		
	CASE ELSE
		return 999
END CHOOSE
end function

on w_cap_ceneval.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1,&
this.uo_1}
end on

on w_cap_ceneval.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)

ii_filenum = FileOpen("C:\MAL.TXT",LineMode!, Write!, LockWrite!, Replace!)

FileWrite(ii_FileNum, 'folio,RV,RN,MC,CN,CS,MAT,ESP,cve_carr,lugar')

end event

type cb_2 from commandbutton within w_cap_ceneval
int X=3083
int Y=54
int Width=249
int Height=74
int TabOrder=10
string Text="Ordena"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SetSort("folio")
dw_1.Sort( )
end event

type cb_1 from commandbutton within w_cap_ceneval
int X=2575
int Y=54
int Width=380
int Height=74
int TabOrder=20
string Text="Leer Archivo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int value, lee_file
long bytes_read, ll_regs
string docname, named, s

value = GetFileOpenName("Selecciona Archivo",+ docname, named, "TXT",+ "Archivo CENEVAL (*.TXT),*.TXT,")

IF value = 1 THEN
	lee_file = FileOpen(docname,LineMode!, Read!, LockReadWrite!)

	SetPointer(HourGlass!)

	bytes_read = FileRead(lee_file, s)
	ll_regs= 0
	DO UNTIL bytes_read=-100
		ll_regs= ll_regs+1
		if bytes_read>0 then
//			dw_1.event agrega_ceneval_2_1(s)
			dw_1.event agrega_ceneval_califs(s)
		end if
		bytes_read = FileRead(lee_file, s)
	LOOP
	FileClose(lee_file)
end if

MessageBox("Informacion","Se termino el proceso")
dw_1.insertrow(0)

end event

type dw_1 from uo_dw_captura within w_cap_ceneval
event agrega ( string linea )
event agrega2 ( string linea )
event type integer inc_calif ( long folio,  integer area,  integer seccion,  real calificacion )
event agrega_ceneval_2_1 ( string linea )
event agrega_ceneval_2_2 ( string linea )
event type integer inc_calif_2 ( long folio,  integer area,  integer seccion,  real calificacion )
event agrega_ceneval_califs ( string linea )
event agrega_ceneval_2_3 ( string linea )
int X=15
int Y=192
int Width=3632
int Height=1456
int TabOrder=30
string DataObject="dw_cap_ceneval"
boolean HScrollBar=true
end type

event agrega;call super::agrega;string CABECERA1,POSICION,FOLIO,NOMBRE,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17_1,P17_2,P17_3
string P17_4,P17_5,P17_6,P17_7,P17_8,P17_9,P17_10,P17_11,P17_12,P17_13,P17_14,P17_15,P17_16
string P17_17,P18_1,P18_2,P18_3,P18_4,P18_5,P19,P20,P21,P22,P23,P24,P25_1,P25_2,P25_3,P25_4
string P25_5,P25_6,P25_7,P25_8,P25_9,P25_10,P25_11,P25_12,P25_13,P26,P27,P28,P29,P30,P31_1
string P31_2,P31_3,P32,P33,P35
int a, temp
long renglon,fol

//a=Pos (linea, "	")
//CABECERA1=Left (linea, a -1)
//linea=mid(linea,a+1)
//
//a=Pos (linea, "	")
//POSICION=Left (linea, a -1)
//linea=mid(linea,a+1)

a=Pos (linea, "	")
FOLIO=Left (linea, a -1)

fol=long(FOLIO)
if fol=0 then
	messagebox("ERROR EN",linea)
	return
end if

ok=fol

linea=mid(linea,a+1)
a=Pos (linea, "	")
NOMBRE=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P2=Left (linea, a -1)

if len(P2)<>0 then
	SELECT clave
	INTO :P2
	FROM sexo
	WHERE nombre = :P2
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Sexo)",P2)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P3=Left (linea, a -1)

if len(P3)<>0 then
	SELECT clave
	INTO :P3
	FROM edo_civil
	WHERE nombre = :P3
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Edo. Civil)",P3)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P4=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P5=Left (linea, a -1)

if len(P5)<>0 then
	SELECT cve_estado
	INTO :temp
	FROM estados
	WHERE estado like  "%"+:P5+"%"
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Estados)",P5)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
	P5=string(temp)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P6=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P7=Left (linea, a -1)

if len(P7)<>0 then
	SELECT clave
	INTO :P7
	FROM tipo_escuela
	WHERE nombre = :P7
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Tipo de Escuela)",P7)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P8=Left (linea, a -1)

if len(P8)<>0 then
	SELECT clave
	INTO :P8
	FROM sistema
	WHERE nombre = :P8
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Sistema Escolar)",P8)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P9=Left (linea, a -1)

if len(P9)<>0 then
	SELECT clave
	INTO :P9
	FROM dur_plan
	WHERE nombre = :P9
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Duración del Plan)",P9)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P10=Left (linea, a -1)

if len(P10)<>0 then
	SELECT clave
	INTO :P10
	FROM tip_plan
	WHERE nombre = :P10
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Tipo del Plan)",P10+' '+string(len(P10)))
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P11=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P12=Left (linea, a -1)

P12=left(P12,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P13=Left (linea, a -1)

if len(P13)<>0 then
	SELECT clave
	INTO :P13
	FROM motivos
	WHERE nombre = :P13
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Motivos)",P13)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P14=Left (linea, a -1)

if len(P14)<>0 then
	SELECT clave
	INTO :P14
	FROM razones
	WHERE nombre = :P14
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Razones)",P14)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P15=Left (linea, a -1)

P15=left(P15,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P16=Left (linea, a -1)

if len(P16)<>0 then
	SELECT clave
	INTO :P16
	FROM ran_prom
	WHERE nombre = :P16
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Promedio de Bach.)",P16)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_1=Left (linea, a -1)

if P17_1='10' then
	P17_1='A'
else
	P17_1=right(P17_1,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_2=Left (linea, a -1)

if P17_2='10' then
	P17_2='A'
else
	P17_2=right(P17_2,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_3=Left (linea, a -1)

if P17_3='10' then
	P17_3='A'
else
	P17_3=right(P17_3,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_4=Left (linea, a -1)

if P17_4='10' then
	P17_4='A'
else
	P17_4=right(P17_4,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_5=Left (linea, a -1)

if P17_5='10' then
	P17_5='A'
else
	P17_5=right(P17_5,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_6=Left (linea, a -1)

if P17_6='10' then
	P17_6='A'
else
	P17_6=right(P17_6,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_7=Left (linea, a -1)

if P17_7='10' then
	P17_7='A'
else
	P17_7=right(P17_7,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_8=Left (linea, a -1)

if P17_8='10' then
	P17_8='A'
else
	P17_8=right(P17_8,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_9=Left (linea, a -1)

if P17_9='10' then
	P17_9='A'
else
	P17_9=right(P17_9,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_10=Left (linea, a -1)

if P17_10='10' then
	P17_10='A'
else
	P17_10=right(P17_10,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_11=Left (linea, a -1)

if P17_11='10' then
	P17_11='A'
else
	P17_11=right(P17_11,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_12=Left (linea, a -1)

if P17_12='10' then
	P17_12='A'
else
	P17_12=right(P17_12,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_13=Left (linea, a -1)

if P17_13='10' then
	P17_13='A'
else
	P17_13=right(P17_13,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_14=Left (linea, a -1)

if P17_14='10' then
	P17_14='A'
else
	P17_14=right(P17_14,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_15=Left (linea, a -1)

if P17_15='10' then
	P17_15='A'
else
	P17_15=right(P17_15,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_16=Left (linea, a -1)

if P17_16='10' then
	P17_16='A'
else
	P17_16=right(P17_16,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P17_17=Left (linea, a -1)

if P17_17='10' then
	P17_17='A'
else
	P17_17=right(P17_17,1)
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P18_1=Left (linea, a -1)

if len(P18_1)<>0 then
	SELECT clave
	INTO :P18_1
	FROM nivel_est
	WHERE nombre = :P18_1
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Nivel de Estudios)",P18_1)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P18_2=Left (linea, a -1)

if len(P18_2)<>0 then
	SELECT clave
	INTO :P18_2
	FROM nivel_est
	WHERE nombre = :P18_2
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Nivel de Estudios)",P18_2)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P18_3=Left (linea, a -1)

if len(P18_3)<>0 then
	SELECT clave
	INTO :P18_3
	FROM nivel_est
	WHERE nombre = :P18_3
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Nivel de Estudios)",P18_3)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P18_4=Left (linea, a -1)

if len(P18_4)<>0 then
	SELECT clave
	INTO :P18_4
	FROM nivel_est
	WHERE nombre = :P18_4
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Nivel de Estudios)",P18_4)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P18_5=Left (linea, a -1)

if len(P18_5)<>0 then
	SELECT clave
	INTO :P18_5
	FROM nivel_est
	WHERE nombre = :P18_5
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Nivel de Estudios)",P18_5)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P19=Left (linea, a -1)

if len(P19)<>0 then
	SELECT clave
	INTO :P19
	FROM familiares
	WHERE nombre = :P19
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Familiares)",P19)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P20=Left (linea, a -1)

if len(P20)<>0 then
	SELECT clave
	INTO :P20
	FROM familiares
	WHERE nombre = :P20
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Familiares)",P20)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P21=Left (linea, a -1)

CHOOSE CASE P21
	CASE 'UNO'
		P21='1'
	CASE 'DOS'
		P21='2'
	CASE 'TRES'
		P21='3'
	CASE 'CUATRO'
		P21='4'
	CASE 'CINCO'
		P21='5'
	CASE 'SEIS'
		P21='6'
	CASE 'MAS DE 6'
		P21='M'
	CASE ELSE
		P21='*'
END CHOOSE

linea=mid(linea,a+1)
a=Pos (linea, "	")
P22=Left (linea, a -1)

if len(P22)<>0 then
	SELECT clave
	INTO :P22
	FROM casa
	WHERE nombre = :P22
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Casa)",P22)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P23=Left (linea, a -1)

P23=right(P23,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P24=Left (linea, a -1)

CHOOSE CASE P24
	CASE 'UNO'
		P24='1'
	CASE 'DOS'
		P24='2'
	CASE 'TRES'
		P24='3'
	CASE 'CUATRO'
		P24='4'
	CASE 'CINCO'
		P24='5'
	CASE 'SEIS'
		P24='6'
	CASE 'SIETE'
		P24='7'
	CASE 'OCHO'
		P24='8'
	CASE 'NUEVE'
		P24='9'
	CASE 'MAS DE 9'
		P24='M'
	CASE ELSE
		P24='*'
END CHOOSE

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_1=Left (linea, a -1)

if len(P25_1)<>0 then
	SELECT clave
	INTO :P25_1
	FROM bienes
	WHERE nombre = :P25_1
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_1)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_2=Left (linea, a -1)

if len(P25_2)<>0 then
	SELECT clave
	INTO :P25_2
	FROM bienes
	WHERE nombre = :P25_2
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_2)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_3=Left (linea, a -1)

if len(P25_3)<>0 then
	SELECT clave
	INTO :P25_3
	FROM bienes
	WHERE nombre = :P25_3
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_3)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_4=Left (linea, a -1)

if len(P25_4)<>0 then
	SELECT clave
	INTO :P25_4
	FROM bienes
	WHERE nombre = :P25_4
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_4)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_5=Left (linea, a -1)

if len(P25_5)<>0 then
	SELECT clave
	INTO :P25_5
	FROM bienes
	WHERE nombre = :P25_5
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_5)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_6=Left (linea, a -1)

if len(P25_6)<>0 then
	SELECT clave
	INTO :P25_6
	FROM bienes
	WHERE nombre = :P25_6
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_6)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_7=Left (linea, a -1)

if len(P25_7)<>0 then
	SELECT clave
	INTO :P25_7
	FROM bienes
	WHERE nombre = :P25_7
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_7)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_8=Left (linea, a -1)

if len(P25_8)<>0 then
	SELECT clave
	INTO :P25_8
	FROM bienes
	WHERE nombre = :P25_8
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_8)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_9=Left (linea, a -1)

if len(P25_9)<>0 then
	SELECT clave
	INTO :P25_9
	FROM bienes
	WHERE nombre = :P25_9
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_9)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_10=Left (linea, a -1)

if len(P25_10)<>0 then
	SELECT clave
	INTO :P25_10
	FROM bienes
	WHERE :P25_10 like "%"+nombre+"%"
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_10)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_11=Left (linea, a -1)

if len(P25_11)<>0 then
	SELECT clave
	INTO :P25_11
	FROM bienes
	WHERE nombre = :P25_11
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_11)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_12=Left (linea, a -1)

if len(P25_12)<>0 then
	SELECT clave
	INTO :P25_12
	FROM bienes
	WHERE nombre = :P25_12
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_12)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P25_13=Left (linea, a -1)

if len(P25_13)<>0 then
	SELECT clave
	INTO :P25_13
	FROM bienes
	WHERE nombre = :P25_13
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Bienes)",P25_13)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P26=Left (linea, a -1)

if len(P26)<>0 then
	SELECT clave
	INTO :P26
	FROM ingresos
	WHERE nombre = :P26
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Ingresos)",P26)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P27=Left (linea, a -1)

P27=left(P27,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P28=Left (linea, a -1)

P28=left(P28,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P29=Left (linea, a -1)

if len(P29)<>0 then
	SELECT clave
	INTO :P29
	FROM hor_trab
	WHERE nombre = :P29
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Horas de Trabajo)",P29)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P30=Left (linea, a -1)

if len(P30)<>0 then
	SELECT clave
	INTO :P30
	FROM ingresos
	WHERE nombre = :P30
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Ingresos)",P30)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P31_1=Left (linea, a -1)

if len(P31_1)<>0 then
	SELECT clave
	INTO :P31_1
	FROM ocupacion
	WHERE :P31_1 like "%"+nombre+"%"
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Ocupación)",P31_1)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P31_2=Left (linea, a -1)

if len(P31_2)<>0 then
	SELECT clave
	INTO :P31_2
	FROM ocupacion
	WHERE :P31_2 like "%"+nombre+"%"
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Ocupación)",P31_2)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P31_3=Left (linea, a -1)

if len(P31_3)<>0 then
	SELECT clave
	INTO :P31_3
	FROM ocupacion
	WHERE :P31_3 like "%"+nombre+"%"
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Ocupación)",P31_3)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P32=Left (linea, a -1)

if len(P32)<>0 then
	SELECT clave
	INTO :P32
	FROM serv_barrio
	WHERE nombre = :P32
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Servicios de Barrio)",P32)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P33=Left (linea, a -1)

if len(P33)<>0 then
	SELECT clave
	INTO :P33
	FROM niv_barrio
	WHERE nombre = :P33
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Servicios de Barrio)",P33)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
P35=Left (linea, a -1)

if len(P35)<>0 then
	SELECT clave
	INTO :P35
	FROM tipo_carr
	WHERE nombre = :P35
	USING gtr_sadm;
	if gtr_sadm.SQLCode = 100 then
		MessageBox("Error de Catálogo (Tipo de Carrera)",P35)
		return
	elseif gtr_sadm.SQLCode > 0 then
		MessageBox("Error de Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
		return
	End If
end if

linea=mid(linea,a+1)

event nuevo()
renglon=rowcount()
object.folio[renglon]=fol
object.clv_ver[renglon]=gi_version
object.clv_per[renglon]=gi_periodo
object.anio[renglon]=gi_anio
object.nombre[renglon]=NOMBRE
object.p2[renglon]=P2
object.p3[renglon]=P3
object.p4[renglon]=P4
object.p5[renglon]=P5
object.p6[renglon]=P6
object.p7[renglon]=P7
object.p8[renglon]=P8
object.p9[renglon]=P9
object.p10[renglon]=P10
object.p11[renglon]=P11
object.p12[renglon]=P12
object.p13[renglon]=P13
object.p14[renglon]=P14
object.p15[renglon]=P15
object.p16[renglon]=P16
object.p17_1[renglon]=P17_1
object.p17_2[renglon]=P17_2
object.p17_3[renglon]=P17_3
object.p17_4[renglon]=P17_4
object.p17_5[renglon]=P17_5
object.p17_6[renglon]=P17_6
object.p17_7[renglon]=P17_7
object.p17_8[renglon]=P17_8
object.p17_9[renglon]=P17_9
object.p17_10[renglon]=P17_10
object.p17_11[renglon]=P17_11
object.p17_12[renglon]=P17_12
object.p17_13[renglon]=P17_13
object.p17_14[renglon]=P17_14
object.p17_15[renglon]=P17_15
object.p17_16[renglon]=P17_16
object.p17_17[renglon]=P17_17
object.p18_1[renglon]=P18_1
object.p18_2[renglon]=P18_2
object.p18_3[renglon]=P18_3
object.p18_4[renglon]=P18_4
object.p18_5[renglon]=P18_5
object.p19[renglon]=P19
object.p20[renglon]=P20
object.p21[renglon]=P21
object.p22[renglon]=P22
object.p23[renglon]=P23
object.p24[renglon]=P24
object.p25_1[renglon]=P25_1
object.p25_2[renglon]=P25_2
object.p25_3[renglon]=P25_3
object.p25_4[renglon]=P25_4
object.p25_5[renglon]=P25_5
object.p25_6[renglon]=P25_6
object.p25_7[renglon]=P25_7
object.p25_8[renglon]=P25_8
object.p25_9[renglon]=P25_9
object.p25_10[renglon]=P25_10
object.p25_11[renglon]=P25_11
object.p25_12[renglon]=P25_12
object.p25_13[renglon]=P25_13
object.p26[renglon]=P26
object.p27[renglon]=P27
object.p28[renglon]=P28
object.p29[renglon]=P29
object.p30[renglon]=P30
object.p31_1[renglon]=P31_1
object.p31_2[renglon]=P31_2
object.p31_3[renglon]=P31_3
object.p32[renglon]=P32
object.p33[renglon]=P33
object.p35[renglon]=P35

event agrega2(linea)
/*
	messagebox(FOLIO+' '+NOMBRE+' '+P2+' '+P3+' '+P4+' '+P5+' '+P6+' '+P7+' '+P8+' '+P9+' '+P10,P11+' '+P12+' '+P13+' '+P14+' '+P15+' '+P16+' '+P17_1+' '+P17_2+' '+P17_3+' '+P17_4+' '+P17_5+' '+P17_6+' '+P17_7+' '+P17_8+' '+P17_9+' '+P17_10+' '+P17_11+' '+P17_12+' '+P17_13+' '+P17_14+' '+P17_15+' '+P17_16+' '+P17_17+' '+P18_1+' '+P18_2+' '+&
	P18_3+' '+P18_4+' '+P18_5+' '+P19+' '+P20+' '+P21+' '+P22+' '+P23+' '+P24+' '+P25_1+' '+P25_2+' '+P25_3+' '+P25_4+' '+P25_5+' '+P25_6+' '+P25_7+' '+P25_8+' '+P25_9+' '+P25_10+' '+P25_11+' '+P25_12+' '+P25_13+' '+P26+' '+P27+' '+P28+' '+P29+' '+P30+' '+P31_1+' '+P31_2+' '+P31_3+' '+P32+' '+P33+' '+P35+' '+FOLIOA+' '+P36_1+' '+P36_2+' '+P36_3+' '+&
	P36_4+' '+P36_5+' '+P36_6+' '+P36_7+' '+P36_8+' '+P36_9+' '+P36_10+' '+P36_11+' '+P36_12+' '+P36_13+' '+P36_14+' '+P36_15+' '+P36_16+' '+P36_17+' '+P36_18+' '+P36_19+' '+P36_20+' '+P36_21+' '+P37_1+' '+P37_2+' '+P37_3+' '+P37_4+' '+P37_5+' '+P37_6+' '+P37_7+' '+P37_8+' '+P37_9+' '+P37_10+' '+P37_11+' '+P37_12+' '+P37_13+' '+&
	P38_1+' '+P38_2+' '+P38_3+' '+P38_4+' '+P38_5+' '+P38_6+' '+P38_7+' '+P38_8+' '+P38_9+' '+P38_10+' '+P38_11+' '+P38_12+' '+P38_13+' '+P38_14+' '+P39A_1+' '+P39A_2+' '+P39A_3+' '+P39A_4+' '+P39B_1+' '+P39B_2+' '+P39B_3+' '+P39B_4+' '+P39C_1+' '+P39C_2+' '+P39C_3+' '+P39C_4+' '+P39D_1+' '+P39D_2+' '+P39D_3+' '+P39D_4)

Formato: 

FOLIO	NOMBRE	P2	P3	P4	P5	P6	P7	P8	P9	P10	P11	P12	P13	P14	P15	P16	P17_1	P17_2	P17_3	P17_4	P17_5	P17_6	P17_7	P17_8	P17_9	P17_10	P17_11	P17_12	P17_13	P17_14	P17_15	P17_16	P17_17	P18_1	P18_2	P18_3	P18_4	P18_5	P19	P20	P21	P22	P23	P24	P25_1	P25_2	P25_3	P25_4	P25_5	P25_6	P25_7	P25_8	P25_9	P25_10	P25_11	P25_12	P25_13	P26	P27	P28	P29	P30	P31_1	P31_2	P31_3	P32	P33	P35	FOLIOA	P36_1	P36_2	P36_3	P36_4	P36_5	P36_6	P36_7	P36_8	P36_9	P36_10	P36_11	P36_12	P36_13	P36_14	P36_15	P36_16	P36_17	P36_18	P36_19	P36_20	P36_21	P37_1	P37_2	P37_3	P37_4	P37_5	P37_6	P37_7	P37_8	P37_9	P37_10	P37_11	P37_12	P37_13	P38_1	P38_2	P38_3	P38_4	P38_5	P38_6	P38_7	P38_8	P38_9	P38_10	P38_11	P38_12	P38_13	P38_14	P39A_1	P39A_2	P39A_3	P39A_4	P39B_1	P39B_2	P39B_3	P39B_4	P39C_1	P39C_2	P39C_3	P39C_4	P39D_1	P39D_2	P39D_3	P39D_4
*/
end event

event agrega2;call super::agrega2;string FOLIOA,P36_1,P36_2,P36_3,P36_4,P36_5,P36_6,P36_7,P36_8,P36_9
string P36_10,P36_11,P36_12,P36_13,P36_14,P36_15,P36_16,P36_17,P36_18,P36_19,P36_20,P36_21
string P37_1,P37_2,P37_3,P37_4,P37_5,P37_6,P37_7,P37_8,P37_9,P37_10,P37_11,P37_12,P37_13
string P38_1,P38_2,P38_3,P38_4,P38_5,P38_6,P38_7,P38_8,P38_9,P38_10,P38_11,P38_12,P38_13
string P38_14,P39A_1,P39A_2,P39A_3,P39A_4,P39B_1,P39B_2,P39B_3,P39B_4,P39C_1,P39C_2,P39C_3
string P39C_4,P39D_1,P39D_2,P39D_3,P39D_4,CARRERA,NUMERO,GLOBA,PORCNE,PERCENTIL
real RV,RN,MC,CN,CS,MAT,ESP,calif
int a, temp
long renglon,fol,error_examen,cve_carr,lugar

error_examen=0

a=Pos (linea, "	")
FOLIOA=Left (linea, a -1)

fol=ok

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_1=Left (linea, a -1)

P36_1=left(P36_1,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_2=Left (linea, a -1)

P36_2=left(P36_2,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_3=Left (linea, a -1)

P36_3=left(P36_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_4=Left (linea, a -1)

P36_4=left(P36_4,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_5=Left (linea, a -1)

P36_5=left(P36_5,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_6=Left (linea, a -1)

P36_6=left(P36_6,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_7=Left (linea, a -1)

P36_7=left(P36_7,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_8=Left (linea, a -1)

P36_8=left(P36_8,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_9=Left (linea, a -1)

P36_9=left(P36_9,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_10=Left (linea, a -1)

P36_10=left(P36_10,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_11=Left (linea, a -1)

P36_11=left(P36_11,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_12=Left (linea, a -1)

P36_12=left(P36_12,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_13=Left (linea, a -1)

P36_13=left(P36_13,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_14=Left (linea, a -1)

P36_14=left(P36_14,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_15=Left (linea, a -1)

P36_15=left(P36_15,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_16=Left (linea, a -1)

P36_16=left(P36_16,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_17=Left (linea, a -1)

P36_17=left(P36_17,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_18=Left (linea, a -1)

P36_18=left(P36_18,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_19=Left (linea, a -1)

P36_19=left(P36_19,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_20=Left (linea, a -1)

P36_20=left(P36_20,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P36_21=Left (linea, a -1)

P36_21=left(P36_21,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_1=Left (linea, a -1)

P37_1=left(P37_1,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_2=Left (linea, a -1)

P37_2=left(P37_2,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_3=Left (linea, a -1)

P37_3=left(P37_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_4=Left (linea, a -1)

P37_4=left(P37_4,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_5=Left (linea, a -1)

P37_5=left(P37_5,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_6=Left (linea, a -1)

P37_6=left(P37_6,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_7=Left (linea, a -1)

P37_7=left(P37_7,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_8=Left (linea, a -1)

P37_8=left(P37_8,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_9=Left (linea, a -1)

P37_9=left(P37_9,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_10=Left (linea, a -1)

P37_10=left(P37_10,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_11=Left (linea, a -1)

P37_11=left(P37_11,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_12=Left (linea, a -1)

P37_12=left(P37_12,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P37_13=Left (linea, a -1)

P37_13=left(P37_13,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_1=Left (linea, a -1)

P38_1=left(P38_1,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_2=Left (linea, a -1)

P38_2=left(P38_2,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_3=Left (linea, a -1)

P38_3=left(P38_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_4=Left (linea, a -1)

P38_4=left(P38_4,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_5=Left (linea, a -1)

P38_5=left(P38_5,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_6=Left (linea, a -1)

P38_6=left(P38_6,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_7=Left (linea, a -1)

P38_7=left(P38_7,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_8=Left (linea, a -1)

P38_8=left(P38_8,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_9=Left (linea, a -1)

P38_9=left(P38_9,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_10=Left (linea, a -1)

P38_10=left(P38_10,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_11=Left (linea, a -1)

P38_11=left(P38_11,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_12=Left (linea, a -1)

P38_12=left(P38_12,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_13=Left (linea, a -1)

P38_13=left(P38_13,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P38_14=Left (linea, a -1)

P38_14=left(P38_14,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39A_1=Left (linea, a -1)

P39A_1=left(P39A_1,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39A_2=Left (linea, a -1)

P39A_2=left(P39A_2,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39A_3=Left (linea, a -1)

P39A_3=left(P39A_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39A_4=Left (linea, a -1)

P39A_4=left(P39A_4,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39B_1=Left (linea, a -1)

P39B_1=left(P39B_1,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39B_2=Left (linea, a -1)

P39B_2=left(P39B_2,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39B_3=Left (linea, a -1)

P39B_3=left(P39B_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39B_4=Left (linea, a -1)

P39B_4=left(P39B_4,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39C_1=Left (linea, a -1)

P39C_1=left(P39C_1,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39C_2=Left (linea, a -1)

P39C_2=left(P39C_2,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39C_3=Left (linea, a -1)

P39C_3=left(P39C_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39C_4=Left (linea, a -1)

P39C_4=left(P39C_4,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39D_1=Left (linea, a -1)

P39D_1=left(P39D_1,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39D_2=Left (linea, a -1)

P39D_2=left(P39D_2,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39D_3=Left (linea, a -1)

P39D_3=left(P39D_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
P39D_4=Left (linea, a -1)

P39D_4=left(P39D_3,1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
CARRERA=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
NUMERO=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
GLOBA=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
PORCNE=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
PERCENTIL=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, "	")
RV=(real(Left (linea, a -1))-700)/6.0
//RV=real(Left (linea, a -1))
IF RV<0 THEN
	RV=0
END IF

calif=event inc_calif(fol,1,1,RV)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(RV))>1 then
	error_examen=1
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
RN=(real(Left (linea, a -1))-700)/6.0
//RN=real(Left (linea, a -1))
IF RN<0 THEN
	RN=0
END IF

calif=event inc_calif(fol,1,2,RN)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(RN))>1 then
	error_examen=1
end if


linea=mid(linea,a+1)
a=Pos (linea, "	")
MC=(real(Left (linea, a -1))-700)/6.0
//MC=real(Left (linea, a -1))
IF MC<0 THEN
	MC=0
END IF

calif=event inc_calif(fol,2,1,MC)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(MC))>1 then
	error_examen=1
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
CN=(real(Left (linea, a -1))-700)/6.0
//CN=real(Left (linea, a -1))
IF CN<0 THEN
	CN=0
END IF

calif=event inc_calif(fol,2,2,CN)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(CN))>1 then
	error_examen=1
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
CS=(real(Left (linea, a -1))-700)/6.0
//CS=real(Left (linea, a -1))
IF CS<0 THEN
	CS=0
END IF

calif=event inc_calif(fol,2,3,CS)
if calif=-1 then
	return
end if
if abs(integer(calif)-integer(CS))>1 then
	error_examen=1
end if

linea=mid(linea,a+1)
a=Pos (linea, "	")
MAT=(real(Left (linea, a -1))-700)/6.0
//MAT=real(Left (linea, a -1))
IF MAT<0 THEN
	MAT=0
END IF

calif=event inc_calif(fol,2,4,MAT)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(MAT))>1 then
	error_examen=1
end if

linea=mid(linea,a+1)
ESP=(real(linea)-700)/6.0
//ESP=real(linea)
IF ESP<0 THEN
	ESP=0
END IF

calif=event inc_calif(fol,2,5,ESP)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(ESP))>1 then
	error_examen=1
end if

if error_examen=1 then
	
	SELECT aspiran.clv_carr,aspiran.lugar_car
	INTO :cve_carr,:lugar
	FROM aspiran
	WHERE ( aspiran.folio = :fol ) AND
		( aspiran.clv_ver = :gi_version ) AND
		( aspiran.clv_per = :gi_periodo ) AND
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
	
	FileWrite(ii_FileNum, string(fol)+','+string(integer(RV))+','+string(integer(RN))+','+&
		string(integer(MC))+','+string(integer(CN))+','+string(integer(CS))+','+&
		string(integer(MAT))+','+string(integer(ESP))+','+string(cve_carr)+','+string(lugar))
end if

renglon=rowcount()
object.p36_1[renglon]=P36_1
object.p36_2[renglon]=P36_2
object.p36_3[renglon]=P36_3
object.p36_4[renglon]=P36_4
object.p36_5[renglon]=P36_5
object.p36_6[renglon]=P36_6
object.p36_7[renglon]=P36_7
object.p36_8[renglon]=P36_8
object.p36_9[renglon]=P36_9
object.p36_10[renglon]=P36_10
object.p36_11[renglon]=P36_11
object.p36_12[renglon]=P36_12
object.p36_13[renglon]=P36_13
object.p36_14[renglon]=P36_14
object.p36_15[renglon]=P36_15
object.p36_16[renglon]=P36_16
object.p36_17[renglon]=P36_17
object.p36_18[renglon]=P36_18
object.p36_19[renglon]=P36_19
object.p36_20[renglon]=P36_20
object.p36_21[renglon]=P36_21
object.p37_1[renglon]=P37_1
object.p37_2[renglon]=P37_2
object.p37_3[renglon]=P37_3
object.p37_4[renglon]=P37_4
object.p37_5[renglon]=P37_5
object.p37_6[renglon]=P37_6
object.p37_7[renglon]=P37_7
object.p37_8[renglon]=P37_8
object.p37_9[renglon]=P37_9
object.p37_10[renglon]=P37_10
object.p37_11[renglon]=P37_11
object.p37_12[renglon]=P37_12
object.p37_13[renglon]=P37_13
object.p38_1[renglon]=P38_1
object.p38_2[renglon]=P38_2
object.p38_3[renglon]=P38_3
object.p38_4[renglon]=P38_4
object.p38_5[renglon]=P38_5
object.p38_6[renglon]=P38_6
object.p38_7[renglon]=P38_7
object.p38_8[renglon]=P38_8
object.p38_9[renglon]=P38_9
object.p38_10[renglon]=P38_10
object.p38_11[renglon]=P38_11
object.p38_12[renglon]=P38_12
object.p38_13[renglon]=P38_13
object.p38_14[renglon]=P38_14
object.p39A_1[renglon]=P39A_1
object.p39A_2[renglon]=P39A_2
object.p39A_3[renglon]=P39A_3
object.p39A_4[renglon]=P39A_4
object.p39B_1[renglon]=P39B_1
object.p39B_2[renglon]=P39B_2
object.p39B_3[renglon]=P39B_3
object.p39B_4[renglon]=P39B_4
object.p39C_1[renglon]=P39C_1
object.p39C_2[renglon]=P39C_2
object.p39C_3[renglon]=P39C_3
object.p39C_4[renglon]=P39C_4
object.p39D_1[renglon]=P39D_1
object.p39D_2[renglon]=P39D_2
object.p39D_3[renglon]=P39D_3
object.p39D_4[renglon]=P39D_4
end event

event inc_calif;call super::inc_calif;real calif

SetNull(calif)
SELECT cali_sec.calif  
INTO :calif  
FROM cali_sec  
WHERE ( cali_sec.folio = :folio ) AND  
	( cali_sec.clv_ver = :gi_version ) AND  
	( cali_sec.clv_per = :gi_periodo ) AND  
	( cali_sec.anio = :gi_anio ) AND  
	( cali_sec.clv_area = :area ) AND  
	( cali_sec.clv_sec = :seccion )
USING gtr_sadm;

IF gtr_sadm.sqlcode=100 THEN

	SELECT cali_are.calif
	INTO :calif
	FROM cali_are
	WHERE ( cali_are.folio = :folio ) AND  
		( cali_are.clv_ver = :gi_version ) AND  
		( cali_are.clv_per = :gi_periodo ) AND  
		( cali_are.anio = :gi_anio ) AND  
		( cali_are.clv_area = :area )
	USING gtr_sadm;
	
	IF gtr_sadm.sqlcode=100 THEN
		INSERT INTO cali_are
			( folio,clv_ver,clv_per,anio,clv_area,calif )
		VALUES ( :folio,:gi_version,:gi_periodo,:gi_anio,:area,0 )
		USING gtr_sadm;
		if gtr_sadm.sqlerrtext<>"" then
			messagebox("Error en CALI_ARE",gtr_sadm.sqlerrtext)
			rollback using gtr_sadm;
			return -1
		else
			commit using gtr_sadm;
			return calif
		end if	
		messagebox(string(folio),string(area)+' '+string(seccion))
	end if
	
	calif=calificacion
	INSERT INTO cali_sec
		( folio,clv_ver,clv_per,anio,clv_area,clv_sec,calif )
	VALUES ( :folio,:gi_version,:gi_periodo,:gi_anio,:area,:seccion,:calif )
	USING gtr_sadm;
	if gtr_sadm.sqlerrtext<>"" then
		messagebox("Error en CALI_SEC",gtr_sadm.sqlerrtext)
		rollback using gtr_sadm;
		return -1
	else
		commit using gtr_sadm;
		return calif
	end if
end if

return calif
end event

event agrega_ceneval_2_1;string CABECERA1,POSICION,FOLIO,NOMBRE,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16
string P16_1,P16_2,P16_3
string P16_4,P16_5,P16_6,P16_7,P16_8,P16_9,P16_10,P16_11,P16_12,P16_13,P16_14,P16_15,P16_16
string P16_17, P17_1,P17_2,P17_3, P17_4,P17_5, P18,P19,P20,P21,P22,P23,P24,P25_1,P25_2,P25_3,P25_4
string P25_5,P25_6,P25_7,P25_8,P25_9,P25_10,P25_11,P25_12,P25_13,P26,P27, P27_1, P27_2,P28,P29,P30
string P31, P32_1,P32_2,P32_3
string P32_4, P32_5, P32_6, P32_7,P32_8,P32_9,P32_10,P32_11
string P33,P34,P35,P36, IDENT_CARR, FOLIO_REPETIDO
int a, temp
long renglon,fol

a =0

//Identificador de la Carrera
IDENT_CARR=f_obten_siguiente_campo (linea, a)

//Folio Exámen
FOLIO=f_obten_siguiente_campo (linea, a)

fol=long(FOLIO)
if fol=0 then
	messagebox("ERROR EN",linea)
	return
end if

ok=fol
//Nombre Aspirante
NOMBRE=f_obten_siguiente_campo (linea, a)

/*
//Datos Bachillerato
P2=f_obten_siguiente_campo (linea, a)
*/

//Código de Escuela
P3=f_obten_siguiente_campo (linea, a)

//Regimen Bachillerato
P4=f_obten_siguiente_campo (linea, a)

P4 = f_valida_regimen_bachi(P4)

//Tipo plan de estudios
P5=f_obten_siguiente_campo (linea, a)

P5 = f_valida_tip_plan(P5)

//Sistema
P6=f_obten_siguiente_campo (linea, a)

P6 = f_valida_sistema(P6)

//Duración plan de estudios
P7=f_obten_siguiente_campo (linea, a)

P7 = f_valida_dur_plan(P7)

//Estado Civil
P8=f_obten_siguiente_campo (linea, a)

P8 = f_valida_edo_civil_2(P8)

//Edad
P9=f_obten_siguiente_campo (linea, a)

P9 = f_valida_edad(P9)

//Sexo
P10=f_obten_siguiente_campo (linea, a)

P10 = f_valida_sexo(P10)

//Terminación del Bachillerato
P11=f_obten_siguiente_campo (linea, a)

//Causa de Prolongación
P12=f_obten_siguiente_campo (linea, a)

P12=f_valida_motivos (P12)

//Causa de Interrupción
P13=f_obten_siguiente_campo (linea, a)

P13=f_valida_razones (P13)

//Reprobadas en el Bachillerato
P14=f_obten_siguiente_campo (linea, a)

//Promedio del Bachillerato
P15=f_obten_siguiente_campo (linea, a)

P15=f_valida_ran_prom (P15)

//Evaluación al Bachillerato
//Aulas
P16_1=f_obten_siguiente_campo (linea, a)

P16_1=f_valida_esc_proced (P16_1)

//Laboratorios
P16_2=f_obten_siguiente_campo (linea, a)

P16_2=f_valida_esc_proced (P16_2)

//Biblioteca
P16_3=f_obten_siguiente_campo (linea, a)

P16_3=f_valida_esc_proced (P16_3)

//Cómputo
P16_4=f_obten_siguiente_campo (linea, a)

P16_4=f_valida_esc_proced (P16_4)

//Auditorio
P16_5=f_obten_siguiente_campo (linea, a)

P16_5=f_valida_esc_proced (P16_5)

//Espacios Deportivos
P16_6=f_obten_siguiente_campo (linea, a)

P16_6=f_valida_esc_proced (P16_6)

//Areas Verdes
P16_7=f_obten_siguiente_campo (linea, a)

P16_7=f_valida_esc_proced (P16_7)

//Cafetería o Comedor
P16_8=f_obten_siguiente_campo (linea, a)

P16_8=f_valida_esc_proced (P16_8)

//Conocimientos
P16_9=f_obten_siguiente_campo (linea, a)

P16_9=f_valida_esc_proced (P16_9)

//Asistencia y Puntualidad
P16_10=f_obten_siguiente_campo (linea, a)

P16_10=f_valida_esc_proced (P16_10)

//Equidad y Justicia
P16_11=f_obten_siguiente_campo (linea, a)

P16_11=f_valida_esc_proced (P16_11)

//Trato y Atención
P16_12=f_obten_siguiente_campo (linea, a)

P16_12=f_valida_esc_proced (P16_12)

//Orden y Disciplina
P16_13=f_obten_siguiente_campo (linea, a)

P16_13=f_valida_esc_proced (P16_13)

//Compañerismo
P16_14=f_obten_siguiente_campo (linea, a)

P16_14=f_valida_esc_proced (P16_14)

//Interés Académico
P16_15=f_obten_siguiente_campo (linea, a)

P16_15=f_valida_esc_proced (P16_15)

//Actividades Culturales
P16_16=f_obten_siguiente_campo (linea, a)

P16_16=f_valida_esc_proced (P16_16)

//Calificación Global
P16_17=f_obten_siguiente_campo (linea, a)

P16_17=f_valida_esc_proced (P16_17)

//Nivel Máximo de Estudios
//Padre
P17_1=f_obten_siguiente_campo (linea, a)

P17_1=f_valida_nivel_est (P17_1)

//Madre
P17_2=f_obten_siguiente_campo (linea, a)

P17_2=f_valida_nivel_est (P17_2)

//Hermano A
P17_3=f_obten_siguiente_campo (linea, a)

P17_3=f_valida_nivel_est (P17_3)

//Hermano B
P17_4=f_obten_siguiente_campo (linea, a)

P17_4=f_valida_nivel_est (P17_4)

//Hermano C
P17_5=f_obten_siguiente_campo (linea, a)

P17_5=f_valida_nivel_est (P17_5)

//Con quién se vive
P18=f_obten_siguiente_campo (linea, a)

P18=f_valida_familiares (P18)

//Principal sustento económico
P19=f_obten_siguiente_campo (linea, a)

P19=f_valida_familiares (P19)

//Número de dependientes económicos del principal sustento
P20=f_obten_siguiente_campo (linea, a)

P20=f_valida_dep_econ (P20)

//Tipo de Casa
P21=f_obten_siguiente_campo (linea, a)

P21=f_valida_casa (P21)

//Número de Cuartos
P22=f_obten_siguiente_campo (linea, a)

//Habitantes de la Casa
P23=f_obten_siguiente_campo (linea, a)

//P23=f_valida_habit_casa (P23)

//Num Focos Casa
P24=f_obten_siguiente_campo (linea, a)

//Bienes y Servicios
//Drenaje
P25_1=f_obten_siguiente_campo (linea, a)

P25_1=f_valida_bienes (P25_1)

//Agua Corriente
P25_2=f_obten_siguiente_campo (linea, a)

P25_2=f_valida_bienes (P25_2)

//Alumbrado Público
P25_3=f_obten_siguiente_campo (linea, a)

P25_3=f_valida_bienes (P25_3)

//Calles Pavimentados
P25_4=f_obten_siguiente_campo (linea, a)

P25_4=f_valida_bienes (P25_4)

//Recolección de Basura
P25_5=f_obten_siguiente_campo (linea, a)

P25_5=f_valida_bienes (P25_5)

//Teléfono
P25_6=f_obten_siguiente_campo (linea, a)

P25_6=f_valida_bienes (P25_6)

//Calentador de Agua
P25_7=f_obten_siguiente_campo (linea, a)

P25_7=f_valida_bienes (P25_7)

//Automóvil
P25_8=f_obten_siguiente_campo (linea, a)

P25_8=f_valida_bienes (P25_8)

//Videograbadora
P25_9=f_obten_siguiente_campo (linea, a)

P25_9=f_valida_bienes (P25_9)

//Televisión por Clave
P25_10=f_obten_siguiente_campo (linea, a)

P25_10=f_valida_bienes (P25_10)

//Computadora
P25_11=f_obten_siguiente_campo (linea, a)

P25_11=f_valida_bienes (P25_11)

//Diccionario o Enciclopedia
P25_12=f_obten_siguiente_campo (linea, a)

P25_12=f_valida_bienes (P25_12)

//Atlas o Mapas
P25_13=f_obten_siguiente_campo (linea, a)

P25_13=f_valida_bienes (P25_13)


//Ingresos Mensuales Familiares
P26=f_obten_siguiente_campo (linea, a)

P26=f_valida_ingresos_2 (P26)

//Ocupación
//Madre
P27_1=f_obten_siguiente_campo (linea, a)

P27_1=f_valida_ocupacion (P27_1)

//Padre
P27_2=f_obten_siguiente_campo (linea, a)

P27_2=f_valida_ocupacion (P27_2)

//Trabajo de Ingresos
P28=f_obten_siguiente_campo (linea, a)

//Tipo de Trabajo 
P29=f_obten_siguiente_campo (linea, a)

//Horas trabajadas
P30=f_obten_siguiente_campo (linea, a)

P30=f_valida_hor_trab (P30)

//Ingresos Mensuales Personales
P31=f_obten_siguiente_campo (linea, a)

P31=f_valida_ingresos_2 (P31)

//Ocupación Propia
//Nivel Directivo
P32_1=f_obten_siguiente_campo (linea, a)

P32_1=f_valida_ocupacion_prop (P32_1)

////Dueño de Negocio
//P32_2=f_obten_siguiente_campo (linea, a)
//
//P32_2=f_valida_ocupacion_prop (P32_2)
//
////Oficinista
//P32_3=f_obten_siguiente_campo (linea, a)
//
//P32_3=f_valida_ocupacion_prop (P32_3)
//
////Empleado de confianza
//P32_4=f_obten_siguiente_campo (linea, a)
//
//P32_4=f_valida_ocupacion_prop (P32_4)
//
////Obrero
//P32_5=f_obten_siguiente_campo (linea, a)
//
//P32_5=f_valida_ocupacion_prop (P32_5)
//
////Vendedor en Comercio
//P32_6=f_obten_siguiente_campo (linea, a)
//
//P32_6=f_valida_ocupacion_prop (P32_6)
//
////Vendedor por su cuenta
//P32_7=f_obten_siguiente_campo (linea, a)
//
//P32_7=f_valida_ocupacion_prop (P32_7)
//
////Campesino
//P32_8=f_obten_siguiente_campo (linea, a)
//
//P32_8=f_valida_ocupacion_prop (P32_8)
//
////Trabajador de Oficio
//P32_9=f_obten_siguiente_campo (linea, a)
//
//P32_9=f_valida_ocupacion_prop (P32_9)
//
////Peon
//P32_10=f_obten_siguiente_campo (linea, a)
//
//P32_10=f_valida_ocupacion_prop (P32_10)
//
////Otra
//P32_11=f_obten_siguiente_campo (linea, a)
//
//P32_11=f_valida_ocupacion_prop (P32_11)
//

//Servicios Culturales Colonia
P33=f_obten_siguiente_campo (linea, a)

P33=f_valida_serv_barrio (P33)

//Nivel Colonia
P34=f_obten_siguiente_campo (linea, a)

P34=f_valida_niv_barrio (P34)

//Grupo Ubicación Carrera
P35=f_obten_siguiente_campo (linea, a)

P35=f_valida_tipo_carr (P35)

//Repite la lectura del folio
FOLIO_REPETIDO=f_obten_siguiente_campo (linea, a)


linea=mid(linea,a+1)

event nuevo()
renglon=rowcount()
object.folio[renglon]=fol
object.clv_ver[renglon]=gi_version
object.clv_per[renglon]=gi_periodo
object.anio[renglon]=gi_anio
object.nombre[renglon]=NOMBRE
object.ident_carr[renglon]=IDENT_CARR
object.p2[renglon]=P2
object.p3[renglon]=P3
object.p4[renglon]=P4
object.p5[renglon]=P5
object.p6[renglon]=P6
object.p7[renglon]=P7
object.p8[renglon]=P8
object.p9[renglon]=P9
object.p10[renglon]=P10
object.p11[renglon]=P11
object.p12[renglon]=P12
object.p13[renglon]=P13
object.p14[renglon]=P14
object.p15[renglon]=P15
object.p16_1[renglon]=P16_1
object.p16_2[renglon]=P16_2
object.p16_3[renglon]=P16_3
object.p16_4[renglon]=P16_4
object.p16_5[renglon]=P16_5
object.p16_6[renglon]=P16_6
object.p16_7[renglon]=P16_7
object.p16_8[renglon]=P16_8
object.p16_9[renglon]=P16_9
object.p16_10[renglon]=P16_10
object.p16_11[renglon]=P16_11
object.p16_12[renglon]=P16_12
object.p16_13[renglon]=P16_13
object.p16_14[renglon]=P16_14
object.p16_15[renglon]=P16_15
object.p16_16[renglon]=P16_16
object.p16_17[renglon]=P16_17
object.p17_1[renglon]=P17_1
object.p17_2[renglon]=P17_2
object.p17_3[renglon]=P17_3
object.p17_4[renglon]=P17_4
object.p17_5[renglon]=P17_5
object.p18[renglon]=P18
object.p19[renglon]=P19
object.p20[renglon]=P20
object.p21[renglon]=P21
object.p22[renglon]=P22
object.p23[renglon]=P23
object.p24[renglon]=P24
object.p25_1[renglon]=P25_1
object.p25_2[renglon]=P25_2
object.p25_3[renglon]=P25_3
object.p25_4[renglon]=P25_4
object.p25_5[renglon]=P25_5
object.p25_6[renglon]=P25_6
object.p25_7[renglon]=P25_7
object.p25_8[renglon]=P25_8
object.p25_9[renglon]=P25_9
object.p25_10[renglon]=P25_10
object.p25_11[renglon]=P25_11
object.p25_12[renglon]=P25_12
object.p25_13[renglon]=P25_13
object.p26[renglon]=P26
object.p27_1[renglon]=P27_1
object.p27_2[renglon]=P27_2
object.p28[renglon]=P28
object.p29[renglon]=P29
object.p30[renglon]=P30
object.p31[renglon]=P31
object.p32_1[renglon]=P32_1
object.p32_2[renglon]=P32_2
object.p32_3[renglon]=P32_3
object.p32_4[renglon]=P32_4
object.p32_5[renglon]=P32_5
object.p32_6[renglon]=P32_6
object.p32_7[renglon]=P32_7
object.p32_8[renglon]=P32_8
object.p32_9[renglon]=P32_9
object.p32_10[renglon]=P32_10
object.p32_11[renglon]=P32_11
object.p33[renglon]=P33
object.p34[renglon]=P34
object.p35[renglon]=P35
object.p36[renglon]=P36

event agrega_ceneval_2_3(linea)

/*
	messagebox(FOLIO+' '+NOMBRE+' '+P2+' '+P3+' '+P4+' '+P5+' '+P6+' '+P7+' '+P8+' '+P9+' '+P10,P11+' '+P12+' '+P13+' '+P14+' '+P15+' '+P16+' '+P17_1+' '+P17_2+' '+P17_3+' '+P17_4+' '+P17_5+' '+P17_6+' '+P17_7+' '+P17_8+' '+P17_9+' '+P17_10+' '+P17_11+' '+P17_12+' '+P17_13+' '+P17_14+' '+P17_15+' '+P17_16+' '+P17_17+' '+P18_1+' '+P18_2+' '+&
	P18_3+' '+P18_4+' '+P18_5+' '+P19+' '+P20+' '+P21+' '+P22+' '+P23+' '+P24+' '+P25_1+' '+P25_2+' '+P25_3+' '+P25_4+' '+P25_5+' '+P25_6+' '+P25_7+' '+P25_8+' '+P25_9+' '+P25_10+' '+P25_11+' '+P25_12+' '+P25_13+' '+P26+' '+P27+' '+P28+' '+P29+' '+P30+' '+P31_1+' '+P31_2+' '+P31_3+' '+P32+' '+P33+' '+P35+' '+FOLIOA+' '+P36_1+' '+P36_2+' '+P36_3+' '+&
	P36_4+' '+P36_5+' '+P36_6+' '+P36_7+' '+P36_8+' '+P36_9+' '+P36_10+' '+P36_11+' '+P36_12+' '+P36_13+' '+P36_14+' '+P36_15+' '+P36_16+' '+P36_17+' '+P36_18+' '+P36_19+' '+P36_20+' '+P36_21+' '+P37_1+' '+P37_2+' '+P37_3+' '+P37_4+' '+P37_5+' '+P37_6+' '+P37_7+' '+P37_8+' '+P37_9+' '+P37_10+' '+P37_11+' '+P37_12+' '+P37_13+' '+&
	P38_1+' '+P38_2+' '+P38_3+' '+P38_4+' '+P38_5+' '+P38_6+' '+P38_7+' '+P38_8+' '+P38_9+' '+P38_10+' '+P38_11+' '+P38_12+' '+P38_13+' '+P38_14+' '+P39A_1+' '+P39A_2+' '+P39A_3+' '+P39A_4+' '+P39B_1+' '+P39B_2+' '+P39B_3+' '+P39B_4+' '+P39C_1+' '+P39C_2+' '+P39C_3+' '+P39C_4+' '+P39D_1+' '+P39D_2+' '+P39D_3+' '+P39D_4)

Formato: 

FOLIO	NOMBRE	P2	P3	P4	P5	P6	P7	P8	P9	P10	P11	P12	P13	P14	P15	P16	P17_1	P17_2	P17_3	P17_4	P17_5	P17_6	P17_7	P17_8	P17_9	P17_10	P17_11	P17_12	P17_13	P17_14	P17_15	P17_16	P17_17	P18_1	P18_2	P18_3	P18_4	P18_5	P19	P20	P21	P22	P23	P24	P25_1	P25_2	P25_3	P25_4	P25_5	P25_6	P25_7	P25_8	P25_9	P25_10	P25_11	P25_12	P25_13	P26	P27	P28	P29	P30	P31_1	P31_2	P31_3	P32	P33	P35	FOLIOA	P36_1	P36_2	P36_3	P36_4	P36_5	P36_6	P36_7	P36_8	P36_9	P36_10	P36_11	P36_12	P36_13	P36_14	P36_15	P36_16	P36_17	P36_18	P36_19	P36_20	P36_21	P37_1	P37_2	P37_3	P37_4	P37_5	P37_6	P37_7	P37_8	P37_9	P37_10	P37_11	P37_12	P37_13	P38_1	P38_2	P38_3	P38_4	P38_5	P38_6	P38_7	P38_8	P38_9	P38_10	P38_11	P38_12	P38_13	P38_14	P39A_1	P39A_2	P39A_3	P39A_4	P39B_1	P39B_2	P39B_3	P39B_4	P39C_1	P39C_2	P39C_3	P39C_4	P39D_1	P39D_2	P39D_3	P39D_4
*/


end event

event agrega_ceneval_2_2;string FOLIOA,P37_1,P37_2,P37_3,P37_4,P37_5,P37_6,P37_7,P37_8,P37_9
string P37_10,P37_11,P37_12,P37_13,P37_14,P37_15,P37_16,P37_17,P37_18,P37_19,P37_20,P37_21,P37_22
string P38_1,P38_2,P38_3,P38_4,P38_5,P38_6,P38_7,P38_8,P38_9,P38_10,P38_11,P38_12,P38_13
string P39_1,P39_2,P39_3,P39_4,P39_5,P39_6,P39_7,P39_8,P39_9,P39_10,P39_11,P39_12,P39_13
string P39_14,P39A_1,P39A_2,P39A_3,P39A_4,P39B_1,P39B_2,P39B_3,P39B_4,P39C_1,P39C_2,P39C_3
string P39C_4,P39D_1,P39D_2,P39D_3,P39D_4,P40_1,P40_2,P40_3,P40_4,CARRERA,NUMERO,GLOBA,PORCNE,PERCENTIL
real RV,RN,MC,CN,CS,MAT,ESP,calif
int a, temp
long renglon,fol,error_examen,cve_carr,lugar

error_examen=0
a =0


//a=Pos (linea, "	")
//FOLIOA=f_obten_siguiente_campo (linea, a)
//
fol=ok





//Razón de la selección de la carrera
//Ubicación Cercana
P37_1=f_obten_siguiente_campo (linea, a)

P37_1=left(P37_1,1)

//Barata
P37_2=f_obten_siguiente_campo (linea, a)

P37_2=left(P37_2,1)

//Relaciones y Colocación
P37_3=f_obten_siguiente_campo (linea, a)

P37_3=left(P37_3,1)

//Preparación para el trabajo
P37_4=f_obten_siguiente_campo (linea, a)

P37_4=left(P37_4,1)

//Materias Interesantes
P37_5=f_obten_siguiente_campo (linea, a)

P37_5=left(P37_5,1)

//Cursado Rápido
P37_6=f_obten_siguiente_campo (linea, a)

P37_6=left(P37_6,1)

//Permite Estudiar y Trabajar
P37_7=f_obten_siguiente_campo (linea, a)

P37_7=left(P37_7,1)

//Pocos Profesionistas en el Campo
P37_8=f_obten_siguiente_campo (linea, a)

P37_8=left(P37_8,1)

//Poca Demanda
P37_9=f_obten_siguiente_campo (linea, a)

P37_9=left(P37_9,1)

//Nivel Académico
P37_10=f_obten_siguiente_campo (linea, a)

P37_10=left(P37_10,1)

//Fácil de Cursar
P37_11=f_obten_siguiente_campo (linea, a)

P37_11=left(P37_11,1)

//Buen Profesorado
P37_12=f_obten_siguiente_campo (linea, a)

P37_12=left(P37_12,1)

//Tronco Común que permite definición Posterior
P37_13=f_obten_siguiente_campo (linea, a)

P37_13=left(P37_13,1)

//Area Prioritaria en el País
P37_14=f_obten_siguiente_campo (linea, a)

P37_14=left(P37_14,1)

//Permite ser Independiente
P37_15=f_obten_siguiente_campo (linea, a)

P37_15=left(P37_15,1)

//Fácil incorporación a Grandes Empresas
P37_16=f_obten_siguiente_campo (linea, a)

P37_16=left(P37_16,1)

//Cultura General
P37_17=f_obten_siguiente_campo (linea, a)

P37_17=left(P37_17,1)

//Bien Pagada
P37_18=f_obten_siguiente_campo (linea, a)

P37_18=left(P37_18,1)

//Respuestas Existenciales
P37_19=f_obten_siguiente_campo (linea, a)

P37_19=left(P37_19,1)

//Profesión Familiar
P37_20=f_obten_siguiente_campo (linea, a)

P37_20=left(P37_20,1)

//Le Gusta
P37_21=f_obten_siguiente_campo (linea, a)

P37_21=left(P37_21,1)

//Otra
P37_22=f_obten_siguiente_campo (linea, a)

P37_22=left(P37_22,1)


//Interés en Campos
//Cs. Físico Matemáticas
P38_1=f_obten_siguiente_campo (linea, a)

P38_1=left(P38_1,1)

//Cs. Químico Biológicas
P38_2=f_obten_siguiente_campo (linea, a)

P38_2=left(P38_2,1)

//Disciplinas Contables y Administrativas
P38_3=f_obten_siguiente_campo (linea, a)

P38_3=left(P38_3,1)

//Humanidades
P38_4=f_obten_siguiente_campo (linea, a)

P38_4=left(P38_4,1)

//Cs. Sociales
P38_5=f_obten_siguiente_campo (linea, a)

P38_5=left(P38_5,1)

//Cs. de la Conducta y Educación
P38_6=f_obten_siguiente_campo (linea, a)

P38_6=left(P38_6,1)

//Dominio de Idiomas
P38_7=f_obten_siguiente_campo (linea, a)

P38_7=left(P38_7,1)

//Comunicaciones e Informática
P38_8=f_obten_siguiente_campo (linea, a)

P38_8=left(P38_8,1)

//Artes Plásticas
P38_9=f_obten_siguiente_campo (linea, a)

P38_9=left(P38_9,1)

//Artes Escénicas
P38_10=f_obten_siguiente_campo (linea, a)

P38_10=left(P38_10,1)

//Música
P38_11=f_obten_siguiente_campo (linea, a)

P38_11=left(P38_11,1)

//Manualidades
P38_12=f_obten_siguiente_campo (linea, a)

P38_12=left(P38_12,1)

//Desarrollo Físico y Deportivo
P38_13=f_obten_siguiente_campo (linea, a)

P38_13=left(P38_13,1)


//Preparación de Exámen
//Visto en Clase
P39_1=f_obten_siguiente_campo (linea, a)

P39_1=left(P39_1,1)

//Libros y Apuntes
P39_2=f_obten_siguiente_campo (linea, a)

P39_2=left(P39_2,1)

//Monografías Comerciales
P39_3=f_obten_siguiente_campo (linea, a)

P39_3=left(P39_3,1)

//Otros Libros
P39_4=f_obten_siguiente_campo (linea, a)

P39_4=left(P39_4,1)

//Revistas y Periódicos
P39_5=f_obten_siguiente_campo (linea, a)

P39_5=left(P39_5,1)

//Películas y Videos
P39_6=f_obten_siguiente_campo (linea, a)

P39_6=left(P39_6,1)

//Computadora
P39_7=f_obten_siguiente_campo (linea, a)

P39_7=left(P39_7,1)

//Museos y Exposiciones
P39_8=f_obten_siguiente_campo (linea, a)

P39_8=left(P39_8,1)

//Biblioteca
P39_9=f_obten_siguiente_campo (linea, a)

P39_9=left(P39_9,1)

//Ejercicios, Experimentos y Prácticas
P39_10=f_obten_siguiente_campo (linea, a)

P39_10=left(P39_10,1)

//Trabajo de Campo y Entrevistaa
P39_11=f_obten_siguiente_campo (linea, a)

P39_11=left(P39_11,1)

//Pregunta a Profesores
P39_12=f_obten_siguiente_campo (linea, a)

P39_12=left(P39_12,1)

//Acudir a Compañeros
P39_13=f_obten_siguiente_campo (linea, a)

P39_13=left(P39_13,1)

//Acudir a Familiares
P39_14=f_obten_siguiente_campo (linea, a)

P39_14=left(P39_14,1)

//Dominio de otros Idiomas
//Inglés
P40_1=f_obten_siguiente_campo (linea, a)

//P40_1=f_valida_nivel_idioma(P40_1)

//Francés
P40_2=f_obten_siguiente_campo (linea, a)

//P40_2=f_valida_nivel_idioma(P40_2)

//Modernos o Clásicos
P40_3=f_obten_siguiente_campo (linea, a)

//P40_3=f_valida_nivel_idioma(P40_3)

//Autóctonos
P40_4=f_obten_siguiente_campo (linea, a)

//P40_4=f_valida_nivel_idioma(P40_4)

////Identificador
//CARRERA=f_obten_siguiente_campo (linea, a)

//Número
NUMERO=f_obten_siguiente_campo (linea, a)

//Global
GLOBA=f_obten_siguiente_campo (linea, a)

//Porcentaje
PORCNE=f_obten_siguiente_campo (linea, a)

//Percentil
PERCENTIL=f_obten_siguiente_campo (linea, a)

//Razonamiento Verbal
RV=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,1,1,RV)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(RV))>1 then
	error_examen=1
end if

//Razonamiento Numérico
RN=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,1,2,RN)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(RN))>1 then
	error_examen=1
end if

//Mundo Contemporáneo
MC=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,1,MC)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(MC))>1 then
	error_examen=1
end if

//Ciencias Naturales
CN=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,2,CN)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(CN))>1 then
	error_examen=1
end if

//Ciencias Sociales
CS=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,3,CS)
if calif=-1 then
	return
end if
if abs(integer(calif)-integer(CS))>1 then
	error_examen=1
end if

//Matemáticas
MAT=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,4,MAT)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(MAT))>1 then
	error_examen=1
end if

linea=mid(linea,a+1)
ESP=(real(linea)-700)/6.0
//ESP=real(linea)
IF ESP<0 THEN
	ESP=0
END IF

calif=event inc_calif_2(fol,2,5,ESP)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(ESP))>1 then
	error_examen=1
end if

if error_examen=1 then
	
	SELECT aspiran.clv_carr,aspiran.lugar_car
	INTO :cve_carr,:lugar
	FROM aspiran
	WHERE ( aspiran.folio = :fol ) AND
		( aspiran.clv_ver = :gi_version ) AND
		( aspiran.clv_per = :gi_periodo ) AND
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
	
	FileWrite(ii_FileNum, string(fol)+','+string(integer(RV))+','+string(integer(RN))+','+&
		string(integer(MC))+','+string(integer(CN))+','+string(integer(CS))+','+&
		string(integer(MAT))+','+string(integer(ESP))+','+string(cve_carr)+','+string(lugar))
end if

renglon=rowcount()
object.p37_1[renglon]=P37_1
object.p37_2[renglon]=P37_2
object.p37_3[renglon]=P37_3
object.p37_4[renglon]=P37_4
object.p37_5[renglon]=P37_5
object.p37_6[renglon]=P37_6
object.p37_7[renglon]=P37_7
object.p37_8[renglon]=P37_8
object.p37_9[renglon]=P37_9
object.p37_10[renglon]=P37_10
object.p37_11[renglon]=P37_11
object.p37_12[renglon]=P37_12
object.p37_13[renglon]=P37_13
object.p37_14[renglon]=P37_14
object.p37_15[renglon]=P37_15
object.p37_16[renglon]=P37_16
object.p37_17[renglon]=P37_17
object.p37_18[renglon]=P37_18
object.p37_19[renglon]=P37_19
object.p37_20[renglon]=P37_20
object.p37_21[renglon]=P37_21
object.p38_1[renglon]=P38_1
object.p38_2[renglon]=P38_2
object.p38_3[renglon]=P38_3
object.p38_4[renglon]=P38_4
object.p38_5[renglon]=P38_5
object.p38_6[renglon]=P38_6
object.p38_7[renglon]=P38_7
object.p38_8[renglon]=P38_8
object.p38_9[renglon]=P38_9
object.p38_10[renglon]=P38_10
object.p38_11[renglon]=P38_11
object.p38_12[renglon]=P38_12
object.p38_13[renglon]=P38_13
object.p39_1[renglon]=P39_1
object.p39_2[renglon]=P39_2
object.p39_3[renglon]=P39_3
object.p39_4[renglon]=P39_4
object.p39_5[renglon]=P39_5
object.p39_6[renglon]=P39_6
object.p39_7[renglon]=P39_7
object.p39_8[renglon]=P39_8
object.p39_9[renglon]=P39_9
object.p39_10[renglon]=P39_10
object.p39_11[renglon]=P39_11
object.p39_12[renglon]=P39_12
object.p39_13[renglon]=P39_13
object.p39_14[renglon]=P39_14
object.p40_1[renglon]=P40_1
object.p40_2[renglon]=P40_2
object.p40_3[renglon]=P40_3
object.p40_4[renglon]=P40_4


end event

event inc_calif_2;call super::inc_calif_2;real calif

SetNull(calif)
SELECT cali_sec.calif  
INTO :calif  
FROM cali_sec  
WHERE ( cali_sec.folio = :folio ) AND  
	( cali_sec.clv_ver = :gi_version ) AND  
	( cali_sec.clv_per = :gi_periodo ) AND  
	( cali_sec.anio = :gi_anio ) AND  
	( cali_sec.clv_area = :area ) AND  
	( cali_sec.clv_sec = :seccion )
USING gtr_sadm;

IF gtr_sadm.sqlcode=100 THEN

	SELECT cali_are.calif
	INTO :calif
	FROM cali_are
	WHERE ( cali_are.folio = :folio ) AND  
		( cali_are.clv_ver = :gi_version ) AND  
		( cali_are.clv_per = :gi_periodo ) AND  
		( cali_are.anio = :gi_anio ) AND  
		( cali_are.clv_area = :area )
	USING gtr_sadm;
	
	IF gtr_sadm.sqlcode=100 THEN
		INSERT INTO cali_are
			( folio,clv_ver,clv_per,anio,clv_area,calif )
		VALUES ( :folio,:gi_version,:gi_periodo,:gi_anio,:area,0 )
		USING gtr_sadm;
		if gtr_sadm.sqlerrtext<>"" then
			messagebox("Error en CALI_ARE",gtr_sadm.sqlerrtext)
			rollback using gtr_sadm;
			return -1
		else
			commit using gtr_sadm;
//			return calif
		end if	
//		messagebox(string(folio),string(area)+' '+string(seccion))
	end if
	
	calif=calificacion
	INSERT INTO cali_sec
	
	( folio,clv_ver,clv_per,anio,clv_area,clv_sec,calif )
	VALUES ( :folio,:gi_version,:gi_periodo,:gi_anio,:area,:seccion,:calif )
	USING gtr_sadm;
	if gtr_sadm.sqlerrtext<>"" then
		messagebox("Error en CALI_SEC",gtr_sadm.sqlerrtext)
		rollback using gtr_sadm;
		return -1
	else
		commit using gtr_sadm;
		return calif
	end if
end if

return calif
end event

event agrega_ceneval_califs;string CABECERA1,POSICION,FOLIO,NOMBRE,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16
string P16_1,P16_2,P16_3
string P16_4,P16_5,P16_6,P16_7,P16_8,P16_9,P16_10,P16_11,P16_12,P16_13,P16_14,P16_15,P16_16
string P16_17, P17_1,P17_2,P17_3, P17_4,P17_5, P18,P19,P20,P21,P22,P23,P24,P25_1,P25_2,P25_3,P25_4
string P25_5,P25_6,P25_7,P25_8,P25_9,P25_10,P25_11,P25_12,P25_13,P26,P27, P27_1, P27_2,P28,P29,P30
string P31,P32,P33,P34,P35,P36
int a, temp
long renglon,fol

string FOLIOA,P37_1,P37_2,P37_3,P37_4,P37_5,P37_6,P37_7,P37_8,P37_9
string P37_10,P37_11,P37_12,P37_13,P37_14,P37_15,P37_16,P37_17,P37_18,P37_19,P37_20,P37_21,P37_22
string P38_1,P38_2,P38_3,P38_4,P38_5,P38_6,P38_7,P38_8,P38_9,P38_10,P38_11,P38_12,P38_13
string P39_1,P39_2,P39_3,P39_4,P39_5,P39_6,P39_7,P39_8,P39_9,P39_10,P39_11,P39_12,P39_13
string P39_14,P39A_1,P39A_2,P39A_3,P39A_4,P39B_1,P39B_2,P39B_3,P39B_4,P39C_1,P39C_2,P39C_3
string P39C_4,P39D_1,P39D_2,P39D_3,P39D_4,P40_1,P40_2,P40_3,P40_4,CARRERA,NUMERO,GLOBA,PORCNE,PERCENTIL
real RV,RN,MC,CN,CS,MAT,ESP,calif

long  error_examen,cve_carr,lugar


a =0
//Folio Exámen
FOLIO=f_obten_siguiente_campo (linea, a)

fol=long(FOLIO)
if fol=0 then
	messagebox("ERROR EN",linea)
	return
end if

ok=fol
error_examen=0

//a=Pos (linea, "	")
//FOLIOA=f_obten_siguiente_campo (linea, a)
//

fol=ok

//Razonamiento Verbal
RV=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,1,1,RV)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(RV))>1 then
	error_examen=1
end if

//Razonamiento Numérico
RN=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,1,2,RN)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(RN))>1 then
	error_examen=1
end if

//Mundo Contemporáneo
MC=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,1,MC)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(MC))>1 then
	error_examen=1
end if

//Ciencias Naturales
CN=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,2,CN)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(CN))>1 then
	error_examen=1
end if

//Ciencias Sociales
CS=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,3,CS)
if calif=-1 then
	return
end if
if abs(integer(calif)-integer(CS))>1 then
	error_examen=1
end if

//Matemáticas
MAT=f_obten_siguiente_campo_real (linea, a)

calif=event inc_calif_2(fol,2,4,MAT)
if calif=-1 then
	return
end if
if abs(integer(calif)- integer(MAT))>1 then
	error_examen=1
end if

linea=mid(linea,a+1)
ESP=(real(linea)-700)/6.0
//ESP=real(linea)
IF ESP<0 THEN
	ESP=0
END IF

calif=event inc_calif_2(fol,2,5,ESP)
if calif=-1 then
	return
end if	
if abs(integer(calif)- integer(ESP))>1 then
	error_examen=1
end if

if error_examen=1 then
	
	SELECT aspiran.clv_carr,aspiran.lugar_car
	INTO :cve_carr,:lugar
	FROM aspiran
	WHERE ( aspiran.folio = :fol ) AND
		( aspiran.clv_ver = :gi_version ) AND
		( aspiran.clv_per = :gi_periodo ) AND
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
	
	FileWrite(ii_FileNum, string(fol)+','+string(integer(RV))+','+string(integer(RN))+','+&
		string(integer(MC))+','+string(integer(CN))+','+string(integer(CS))+','+&
		string(integer(MAT))+','+string(integer(ESP))+','+string(cve_carr)+','+string(lugar))
end if

renglon=rowcount()
//object.p37_1[renglon]=P37_1



end event

event agrega_ceneval_2_3;string FOLIOA,P37_1,P37_2,P37_3,P37_4,P37_5,P37_6,P37_7,P37_8,P37_9
string P37_10,P37_11,P37_12,P37_13,P37_14,P37_15,P37_16,P37_17,P37_18,P37_19,P37_20,P37_21,P37_22
string P38_1,P38_2,P38_3,P38_4,P38_5,P38_6,P38_7,P38_8,P38_9,P38_10,P38_11,P38_12,P38_13
string P39_1,P39_2,P39_3,P39_4,P39_5,P39_6,P39_7,P39_8,P39_9,P39_10,P39_11,P39_12,P39_13
string P39_14,P39A_1,P39A_2,P39A_3,P39A_4,P39B_1,P39B_2,P39B_3,P39B_4,P39C_1,P39C_2,P39C_3
string P39C_4,P39D_1,P39D_2,P39D_3,P39D_4,P40_1,P40_2,P40_3,P40_4,CARRERA,NUMERO,GLOBA,PORCNE,PERCENTIL
real RV,RN,MC,CN,CS,MAT,ESP,calif
int a, temp
long renglon,fol,error_examen,cve_carr,lugar

error_examen=0
a =0


//a=Pos (linea, "	")
//FOLIOA=f_obten_siguiente_campo (linea, a)
//
fol=ok





//Razón de la selección de la carrera
//Ubicación Cercana
P37_1=f_obten_siguiente_campo (linea, a)

P37_1=left(P37_1,1)

//Barata
P37_2=f_obten_siguiente_campo (linea, a)

P37_2=left(P37_2,1)

//Relaciones y Colocación
P37_3=f_obten_siguiente_campo (linea, a)

P37_3=left(P37_3,1)

//Preparación para el trabajo
P37_4=f_obten_siguiente_campo (linea, a)

P37_4=left(P37_4,1)

//Materias Interesantes
P37_5=f_obten_siguiente_campo (linea, a)

P37_5=left(P37_5,1)

//Cursado Rápido
P37_6=f_obten_siguiente_campo (linea, a)

P37_6=left(P37_6,1)

//Permite Estudiar y Trabajar
P37_7=f_obten_siguiente_campo (linea, a)

P37_7=left(P37_7,1)

//Pocos Profesionistas en el Campo
P37_8=f_obten_siguiente_campo (linea, a)

P37_8=left(P37_8,1)

//Poca Demanda
P37_9=f_obten_siguiente_campo (linea, a)

P37_9=left(P37_9,1)

//Nivel Académico
P37_10=f_obten_siguiente_campo (linea, a)

P37_10=left(P37_10,1)

//Fácil de Cursar
P37_11=f_obten_siguiente_campo (linea, a)

P37_11=left(P37_11,1)

//Buen Profesorado
P37_12=f_obten_siguiente_campo (linea, a)

P37_12=left(P37_12,1)

//Tronco Común que permite definición Posterior
P37_13=f_obten_siguiente_campo (linea, a)

P37_13=left(P37_13,1)

//Area Prioritaria en el País
P37_14=f_obten_siguiente_campo (linea, a)

P37_14=left(P37_14,1)

//Permite ser Independiente
P37_15=f_obten_siguiente_campo (linea, a)

P37_15=left(P37_15,1)

//Fácil incorporación a Grandes Empresas
P37_16=f_obten_siguiente_campo (linea, a)

P37_16=left(P37_16,1)

//Cultura General
P37_17=f_obten_siguiente_campo (linea, a)

P37_17=left(P37_17,1)

//Bien Pagada
P37_18=f_obten_siguiente_campo (linea, a)

P37_18=left(P37_18,1)

//Respuestas Existenciales
P37_19=f_obten_siguiente_campo (linea, a)

P37_19=left(P37_19,1)

//Profesión Familiar
P37_20=f_obten_siguiente_campo (linea, a)

P37_20=left(P37_20,1)

//Le Gusta
P37_21=f_obten_siguiente_campo (linea, a)

P37_21=left(P37_21,1)

//Otra
P37_22=f_obten_siguiente_campo (linea, a)

P37_22=left(P37_22,1)


//Interés en Campos
//Cs. Físico Matemáticas
P38_1=f_obten_siguiente_campo (linea, a)

P38_1=left(P38_1,1)

//Cs. Químico Biológicas
P38_2=f_obten_siguiente_campo (linea, a)

P38_2=left(P38_2,1)

//Disciplinas Contables y Administrativas
P38_3=f_obten_siguiente_campo (linea, a)

P38_3=left(P38_3,1)

//Humanidades
P38_4=f_obten_siguiente_campo (linea, a)

P38_4=left(P38_4,1)

//Cs. Sociales
P38_5=f_obten_siguiente_campo (linea, a)

P38_5=left(P38_5,1)

//Cs. de la Conducta y Educación
P38_6=f_obten_siguiente_campo (linea, a)

P38_6=left(P38_6,1)

//Dominio de Idiomas
P38_7=f_obten_siguiente_campo (linea, a)

P38_7=left(P38_7,1)

//Comunicaciones e Informática
P38_8=f_obten_siguiente_campo (linea, a)

P38_8=left(P38_8,1)

//Artes Plásticas
P38_9=f_obten_siguiente_campo (linea, a)

P38_9=left(P38_9,1)

//Artes Escénicas
P38_10=f_obten_siguiente_campo (linea, a)

P38_10=left(P38_10,1)

//Música
P38_11=f_obten_siguiente_campo (linea, a)

P38_11=left(P38_11,1)

//Manualidades
P38_12=f_obten_siguiente_campo (linea, a)

P38_12=left(P38_12,1)

//Desarrollo Físico y Deportivo
P38_13=f_obten_siguiente_campo (linea, a)

P38_13=left(P38_13,1)


//Preparación de Exámen
//Visto en Clase
P39_1=f_obten_siguiente_campo (linea, a)

P39_1=left(P39_1,1)

//Libros y Apuntes
P39_2=f_obten_siguiente_campo (linea, a)

P39_2=left(P39_2,1)

//Monografías Comerciales
P39_3=f_obten_siguiente_campo (linea, a)

P39_3=left(P39_3,1)

//Otros Libros
P39_4=f_obten_siguiente_campo (linea, a)

P39_4=left(P39_4,1)

//Revistas y Periódicos
P39_5=f_obten_siguiente_campo (linea, a)

P39_5=left(P39_5,1)

//Películas y Videos
P39_6=f_obten_siguiente_campo (linea, a)

P39_6=left(P39_6,1)

//Computadora
P39_7=f_obten_siguiente_campo (linea, a)

P39_7=left(P39_7,1)

//Museos y Exposiciones
P39_8=f_obten_siguiente_campo (linea, a)

P39_8=left(P39_8,1)

//Biblioteca
P39_9=f_obten_siguiente_campo (linea, a)

P39_9=left(P39_9,1)

//Ejercicios, Experimentos y Prácticas
P39_10=f_obten_siguiente_campo (linea, a)

P39_10=left(P39_10,1)

//Trabajo de Campo y Entrevistaa
P39_11=f_obten_siguiente_campo (linea, a)

P39_11=left(P39_11,1)

//Pregunta a Profesores
P39_12=f_obten_siguiente_campo (linea, a)

P39_12=left(P39_12,1)

//Acudir a Compañeros
P39_13=f_obten_siguiente_campo (linea, a)

P39_13=left(P39_13,1)

//Acudir a Familiares
P39_14=f_obten_siguiente_campo (linea, a)

P39_14=left(P39_14,1)

//Dominio de otros Idiomas
//Inglés
P40_1=f_obten_siguiente_campo (linea, a)

//P40_1=f_valida_nivel_idioma(P40_1)

//Francés
P40_2=f_obten_siguiente_campo (linea, a)

//P40_2=f_valida_nivel_idioma(P40_2)

//Modernos o Clásicos
P40_3=f_obten_siguiente_campo (linea, a)

//P40_3=f_valida_nivel_idioma(P40_3)

//Autóctonos
P40_4=f_obten_siguiente_campo (linea, a)

//P40_4=f_valida_nivel_idioma(P40_4)

////Identificador
//CARRERA=f_obten_siguiente_campo (linea, a)


renglon=rowcount()
object.p37_1[renglon]=P37_1
object.p37_2[renglon]=P37_2
object.p37_3[renglon]=P37_3
object.p37_4[renglon]=P37_4
object.p37_5[renglon]=P37_5
object.p37_6[renglon]=P37_6
object.p37_7[renglon]=P37_7
object.p37_8[renglon]=P37_8
object.p37_9[renglon]=P37_9
object.p37_10[renglon]=P37_10
object.p37_11[renglon]=P37_11
object.p37_12[renglon]=P37_12
object.p37_13[renglon]=P37_13
object.p37_14[renglon]=P37_14
object.p37_15[renglon]=P37_15
object.p37_16[renglon]=P37_16
object.p37_17[renglon]=P37_17
object.p37_18[renglon]=P37_18
object.p37_19[renglon]=P37_19
object.p37_20[renglon]=P37_20
object.p37_21[renglon]=P37_21
object.p38_1[renglon]=P38_1
object.p38_2[renglon]=P38_2
object.p38_3[renglon]=P38_3
object.p38_4[renglon]=P38_4
object.p38_5[renglon]=P38_5
object.p38_6[renglon]=P38_6
object.p38_7[renglon]=P38_7
object.p38_8[renglon]=P38_8
object.p38_9[renglon]=P38_9
object.p38_10[renglon]=P38_10
object.p38_11[renglon]=P38_11
object.p38_12[renglon]=P38_12
object.p38_13[renglon]=P38_13
object.p39_1[renglon]=P39_1
object.p39_2[renglon]=P39_2
object.p39_3[renglon]=P39_3
object.p39_4[renglon]=P39_4
object.p39_5[renglon]=P39_5
object.p39_6[renglon]=P39_6
object.p39_7[renglon]=P39_7
object.p39_8[renglon]=P39_8
object.p39_9[renglon]=P39_9
object.p39_10[renglon]=P39_10
object.p39_11[renglon]=P39_11
object.p39_12[renglon]=P39_12
object.p39_13[renglon]=P39_13
object.p39_14[renglon]=P39_14
object.p40_1[renglon]=P40_1
object.p40_2[renglon]=P40_2
object.p40_3[renglon]=P40_3
object.p40_4[renglon]=P40_4


end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

type uo_1 from uo_ver_per_ani within w_cap_ceneval
int X=4
int Y=6
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

