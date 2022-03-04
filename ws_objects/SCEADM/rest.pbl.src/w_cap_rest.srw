$PBExportHeader$w_cap_rest.srw
forward
global type w_cap_rest from Window
end type
type cb_5 from commandbutton within w_cap_rest
end type
type cb_4 from commandbutton within w_cap_rest
end type
type cb_1 from commandbutton within w_cap_rest
end type
type dw_1 from uo_dw_captura within w_cap_rest
end type
type uo_1 from uo_ver_per_ani within w_cap_rest
end type
end forward

global type w_cap_rest from Window
int X=833
int Y=361
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos dados por el REST"
string MenuName="m_menu"
long BackColor=30976088
cb_5 cb_5
cb_4 cb_4
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
end type
global w_cap_rest w_cap_rest

type variables

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

on w_cap_rest.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.cb_5,&
this.cb_4,&
this.cb_1,&
this.dw_1,&
this.uo_1}
end on

on w_cap_rest.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type cb_5 from commandbutton within w_cap_rest
event clicked pbm_bnclicked
int X=3155
int Y=105
int Width=380
int Height=73
int TabOrder=10
string Text="Borra Faltan"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int ani,per,ver
long cont,folio_1,folio_2

dw_1.SetSort("folio")
dw_1.Sort( )

SetPointer(HourGlass!)

if dw_1.rowcount()>0 then
	
	per=dw_1.object.clv_per[1]
	ver=dw_1.object.clv_ver[1]
	ani=dw_1.object.anio[1]
	
	FOR cont=dw_1.rowcount() TO 1 STEP -1
		folio_1=dw_1.object.folio[cont]
	
		SELECT isnull(aspiran.folio,0)
		INTO :folio_2
		FROM aspiran  
		WHERE ( aspiran.clv_ver = :ver ) AND  
				( aspiran.clv_per = :per ) AND  
				( aspiran.anio = :ani ) AND  
				( aspiran.folio = :folio_1 )
		USING gtr_sadm;

		if folio_1<>folio_2 then
			dw_1.deleterow(cont)
		end if
	NEXT
end if
end event

type cb_4 from commandbutton within w_cap_rest
event clicked pbm_bnclicked
int X=3155
int Y=17
int Width=380
int Height=73
int TabOrder=20
string Text="Borra Doble"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cont_1,cont_2,cont_3,folio[],borrame
dw_1.SetSort("folio")
dw_1.Sort( )

SetPointer(HourGlass!)

cont_2=0

FOR cont_1=1 TO dw_1.rowcount() -1
	borrame=dw_1.object.folio[cont_1]
	if borrame=dw_1.object.folio[cont_1+1] then
		cont_2=cont_2+1
		folio[cont_2]=borrame
	end if
NEXT

FOR cont_1=dw_1.rowcount() TO 1 STEP -1
	FOR cont_3=1 to cont_2
		if folio[cont_3]=dw_1.object.folio[cont_1] then
			dw_1.deleterow(cont_1)
		end if
	NEXT
NEXT
end event

type cb_1 from commandbutton within w_cap_rest
int X=2579
int Y=49
int Width=380
int Height=73
int TabOrder=30
string Text="Leer Archivo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int value, lee_file
long bytes_read
string docname, named, s

value = GetFileOpenName("Selecciona Archivo",+ docname, named, "CSV",+ "Archivo REST (*.CSV),*.CSV,")

IF value = 1 THEN
	lee_file = FileOpen(docname,LineMode!, Read!, LockReadWrite!)

	SetPointer(HourGlass!)

	bytes_read = FileRead(lee_file, s)
	DO UNTIL bytes_read=-100
		if bytes_read>0 then
			dw_1.event agrega(s)
		end if
		bytes_read = FileRead(lee_file, s)
	LOOP
	FileClose(lee_file)
end if

dw_1.insertrow(0)
end event

type dw_1 from uo_dw_captura within w_cap_rest
event agrega ( string linea )
int X=14
int Y=193
int Width=3630
int Height=1577
int TabOrder=40
string DataObject="dw_cap_rest"
boolean HScrollBar=true
end type

event agrega;call super::agrega;string FOLIO,LEIDO,ETAPA_2,ETAPA_3,ETAPA_4,ETAPA_5A,ETAPA_5B,ETAPA_6,ETAPA_A,ETAPA_M
STRING ETAPA_P,INDICE_D,INDICE_U
int a, temp
long renglon,fol

a=Pos (linea, ",")
FOLIO=Left (linea, a -1)

fol=long(FOLIO)
if fol=0 then
	messagebox("ERROR EN",linea)
	return
end if

linea=mid(linea,a+1)
a=Pos (linea, ",")
LEIDO=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_2=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_3=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_4=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_5A=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_5B=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_6=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_A=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_M=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
ETAPA_P=Left (linea, a -1)

linea=mid(linea,a+1)
a=Pos (linea, ",")
INDICE_D=Left (linea, a -1)

linea=mid(linea,a+1)
INDICE_U=linea

event nuevo()
renglon=rowcount()
object.folio[renglon]=fol
object.clv_ver[renglon]=gi_version
object.clv_per[renglon]=gi_periodo
object.anio[renglon]=gi_anio
object.leido[renglon]=LEIDO
object.etapa_2[renglon]=round(real(ETAPA_2),1)
object.etapa_3[renglon]=round(real(ETAPA_3),1)
object.etapa_4[renglon]=round(real(ETAPA_4),1)
object.etapa_5a[renglon]=round(real(ETAPA_5A),1)
object.etapa_5b[renglon]=round(real(ETAPA_5B),1)
object.etapa_6[renglon]=round(real(ETAPA_6),1)
object.etapa_a[renglon]=round(real(ETAPA_A),1)
object.etapa_m[renglon]=round(real(ETAPA_M),1)
object.etapa_p[renglon]=round(real(ETAPA_P),1)
object.indice_D[renglon]=round(real(INDICE_D),3)
object.indice_u[renglon]=round(real(INDICE_U),4)

/*
	messagebox(FOLIO+' '+LEIDO+' '+ETAPA_2+' '+ETAPA_3+' '+ETAPA_4+' '+ETAPA_5A+' '+ETAPA_5B,&
		ETAPA_6+' '+ETAPA_A+' '+ETAPA_M+' '+ETAPA_P+' '+INDICE_D+' '+INDICE_U)

Formato: 

FOLIO,LEIDO,ETAPA_2,ETAPA_3,ETAPA_4,ETAPA_5A,ETAPA_5B,ETAPA_6,ETAPA_A,ETAPA_M,ETAPA_P,INDICE_D,INDICE_U
*/
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

type uo_1 from uo_ver_per_ani within w_cap_rest
int X=5
int Y=5
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

