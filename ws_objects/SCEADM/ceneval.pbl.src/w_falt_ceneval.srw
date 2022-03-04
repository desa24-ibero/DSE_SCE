$PBExportHeader$w_falt_ceneval.srw
forward
global type w_falt_ceneval from Window
end type
type uo_1 from uo_ver_per_ani within w_falt_ceneval
end type
type dw_1 from uo_dw_reporte within w_falt_ceneval
end type
end forward

global type w_falt_ceneval from Window
int X=833
int Y=361
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos faltantes del CENEVAL"
string MenuName="m_menu"
long BackColor=30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_falt_ceneval w_falt_ceneval

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

on w_falt_ceneval.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.uo_1,&
this.dw_1}
end on

on w_falt_ceneval.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_falt_ceneval
int X=5
int Y=5
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_falt_ceneval
int X=37
int Y=201
int Width=3612
int Height=1569
int TabOrder=0
string DataObject="dw_falt_ceneval"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;event primero()
return retrieve(gi_version,gi_periodo,gi_anio)
end event

