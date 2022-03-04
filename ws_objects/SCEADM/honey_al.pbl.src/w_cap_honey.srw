$PBExportHeader$w_cap_honey.srw
forward
global type w_cap_honey from Window
end type
type em_hoy from editmask within w_cap_honey
end type
type dw_2 from datawindow within w_cap_honey
end type
type cb_faltan from commandbutton within w_cap_honey
end type
type cb_dobles from commandbutton within w_cap_honey
end type
type cb_1 from commandbutton within w_cap_honey
end type
type dw_1 from uo_dw_captura within w_cap_honey
end type
type uo_1 from uo_ver_per_ani within w_cap_honey
end type
end forward

global type w_cap_honey from Window
int X=833
int Y=361
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos dados por el Honey-Alonso"
string MenuName="m_menu"
long BackColor=30976088
em_hoy em_hoy
dw_2 dw_2
cb_faltan cb_faltan
cb_dobles cb_dobles
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
end type
global w_cap_honey w_cap_honey

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

on w_cap_honey.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_hoy=create em_hoy
this.dw_2=create dw_2
this.cb_faltan=create cb_faltan
this.cb_dobles=create cb_dobles
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.em_hoy,&
this.dw_2,&
this.cb_faltan,&
this.cb_dobles,&
this.cb_1,&
this.dw_1,&
this.uo_1}
end on

on w_cap_honey.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_hoy)
destroy(this.dw_2)
destroy(this.cb_faltan)
destroy(this.cb_dobles)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)
end event

type em_hoy from editmask within w_cap_honey
int X=1770
int Y=9
int Width=403
int Height=73
Alignment Alignment=Center!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
string DisplayData=""
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(today())
end event

type dw_2 from datawindow within w_cap_honey
int X=33
int Y=1049
int Width=3612
int Height=721
string DataObject="dw_honey_resp"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type cb_faltan from commandbutton within w_cap_honey
event clicked pbm_bnclicked
int X=2359
int Y=101
int Width=380
int Height=73
string Text="Borra Faltan"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cont,cuenta_1,cuenta_2

dw_1.SetSort("cuenta")
dw_1.Sort( )
dw_2.SetSort("cuenta")
dw_2.Sort( )

SetPointer(HourGlass!)

if dw_1.rowcount()>0 then

	FOR cont=dw_1.rowcount() TO 1 STEP -1
		cuenta_1=dw_1.object.cuenta[cont]
	
		SELECT isnull(general.cuenta,0)
		INTO :cuenta_2
		FROM general
		WHERE ( general.clv_per = :gi_periodo ) AND  
				( general.anio = :gi_anio ) AND  
				( general.cuenta = :cuenta_1 )
		USING gtr_sadm;
		commit USING gtr_sadm;

		if cuenta_1<>cuenta_2 then
			dw_1.deleterow(cont)
			dw_2.deleterow(cont)
		end if
	NEXT
end if
end event

type cb_dobles from commandbutton within w_cap_honey
event clicked pbm_bnclicked
int X=2359
int Y=13
int Width=380
int Height=73
string Text="Borra Doble"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long cont_1,cont_2,cont_3,cuenta[],borrame

dw_1.SetSort("cuenta")
dw_1.Sort( )
dw_2.SetSort("cuenta")
dw_2.Sort( )

SetPointer(HourGlass!)

cont_2=0

FOR cont_1=1 TO dw_1.rowcount() -1
	borrame=dw_1.object.cuenta[cont_1]
	if borrame=dw_1.object.cuenta[cont_1+1] then
		cont_2=cont_2+1
		cuenta[cont_2]=borrame
	end if
NEXT

FOR cont_1=dw_1.rowcount() TO 1 STEP -1
	FOR cont_3=1 to cont_2
		if cuenta[cont_3]=dw_1.object.cuenta[cont_1] then
			dw_1.deleterow(cont_1)
			dw_2.deleterow(cont_1)
		end if
	NEXT
NEXT
end event

type cb_1 from commandbutton within w_cap_honey
int X=1783
int Y=101
int Width=380
int Height=73
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

//dw_1.event carga()
value = GetFileOpenName("Selecciona Archivo",+ docname, named, "SDF",+ "Archivo Honey-Alonso (*.SDF),*.SDF,")

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

cb_dobles.TriggerEvent(Clicked!)
cb_faltan.TriggerEvent(Clicked!)
end event

type dw_1 from uo_dw_captura within w_cap_honey
event agrega ( string linea )
int X=14
int Y=193
int Width=3630
int Height=805
int TabOrder=0
string DataObject="dw_honey_datos"
boolean HScrollBar=true
end type

event agrega;call super::agrega;string digito
integer contador,i,prof_madre,estudios_madre,num_hermanos,calif_altas,calif_bajas,resp[80]
long cuenta,renglon
date hoy

hoy=date(em_hoy.text)
cuenta=long(mid(linea,1,6))
digito=mid(linea,7,1)

if obten_digito(cuenta)<>digito or cuenta=0 then
	return
end if

prof_madre=integer(mid(linea,8,1))
if prof_madre>5 then
	prof_madre=0
end if

estudios_madre=integer(mid(linea,9,1))
if estudios_madre>7 then
	estudios_madre=0
end if

num_hermanos=integer(mid(linea,10,1))
if num_hermanos>5 then
	num_hermanos=0
end if

calif_altas=integer(mid(linea,11,1))
if calif_altas>6 then
	calif_altas=0
end if

calif_bajas=integer(mid(linea,12,1))
if calif_bajas>6 then
	calif_bajas=0
end if

contador=13
for i=1 to 79
	resp[i]=integer(mid(linea,contador,1))
	contador++
next

resp[80]=integer(mid(linea,len(linea),1))

event nuevo()
renglon=rowcount()
object.cuenta[renglon]=cuenta
object.fecha[renglon]=hoy
object.profesion_madre[renglon]=prof_madre
object.estudios_madre[renglon]=estudios_madre
object.numero_hermanos[renglon]=num_hermanos
object.calif_alta_prepa[renglon]=calif_altas
object.calif_baja_prepa[renglon]=calif_bajas
object.activo[renglon]=resp[3]+resp[5]+resp[7]+resp[9]+resp[13]+resp[20]+resp[26]+resp[27]+resp[35]+resp[37]+resp[41]+resp[43]+resp[46]+resp[48]+resp[51]+resp[61]+resp[67]+resp[74]+resp[75]+resp[77]
object.reflexivo[renglon]=resp[10]+resp[16]+resp[18]+resp[19]+resp[28]+resp[31]+resp[32]+resp[34]+resp[36]+resp[39]+resp[42]+resp[44]+resp[49]+resp[55]+resp[58]+resp[63]+resp[65]+resp[69]+resp[70]+resp[79]
object.teorico[renglon]=resp[2]+resp[4]+resp[6]+resp[11]+resp[15]+resp[17]+resp[21]+resp[23]+resp[25]+resp[29]+resp[33]+resp[45]+resp[50]+resp[54]+resp[60]+resp[64]+resp[66]+resp[71]+resp[78]+resp[80]
object.pragmatico[renglon]=resp[1]+resp[8]+resp[12]+resp[14]+resp[22]+resp[24]+resp[30]+resp[38]+resp[40]+resp[47]+resp[52]+resp[53]+resp[56]+resp[57]+resp[59]+resp[62]+resp[68]+resp[72]+resp[73]+resp[76]

dw_2.object.cuenta[renglon]=cuenta
dw_2.object.fecha[renglon]=hoy
dw_2.object.resp_1[renglon]=resp[1]
dw_2.object.resp_2[renglon]=resp[2]
dw_2.object.resp_3[renglon]=resp[3]
dw_2.object.resp_4[renglon]=resp[4]
dw_2.object.resp_5[renglon]=resp[5]
dw_2.object.resp_6[renglon]=resp[6]
dw_2.object.resp_7[renglon]=resp[7]
dw_2.object.resp_8[renglon]=resp[8]
dw_2.object.resp_9[renglon]=resp[9]
dw_2.object.resp_10[renglon]=resp[10]
dw_2.object.resp_11[renglon]=resp[11]
dw_2.object.resp_12[renglon]=resp[12]
dw_2.object.resp_13[renglon]=resp[13]
dw_2.object.resp_14[renglon]=resp[14]
dw_2.object.resp_15[renglon]=resp[15]
dw_2.object.resp_16[renglon]=resp[16]
dw_2.object.resp_17[renglon]=resp[17]
dw_2.object.resp_18[renglon]=resp[18]
dw_2.object.resp_19[renglon]=resp[19]
dw_2.object.resp_20[renglon]=resp[20]
dw_2.object.resp_21[renglon]=resp[21]
dw_2.object.resp_22[renglon]=resp[22]
dw_2.object.resp_23[renglon]=resp[23]
dw_2.object.resp_24[renglon]=resp[24]
dw_2.object.resp_25[renglon]=resp[25]
dw_2.object.resp_26[renglon]=resp[26]
dw_2.object.resp_27[renglon]=resp[27]
dw_2.object.resp_28[renglon]=resp[28]
dw_2.object.resp_29[renglon]=resp[29]
dw_2.object.resp_30[renglon]=resp[30]
dw_2.object.resp_31[renglon]=resp[31]
dw_2.object.resp_32[renglon]=resp[32]
dw_2.object.resp_33[renglon]=resp[33]
dw_2.object.resp_34[renglon]=resp[34]
dw_2.object.resp_35[renglon]=resp[35]
dw_2.object.resp_36[renglon]=resp[36]
dw_2.object.resp_37[renglon]=resp[37]
dw_2.object.resp_38[renglon]=resp[38]
dw_2.object.resp_39[renglon]=resp[39]
dw_2.object.resp_40[renglon]=resp[40]
dw_2.object.resp_41[renglon]=resp[41]
dw_2.object.resp_42[renglon]=resp[42]
dw_2.object.resp_43[renglon]=resp[43]
dw_2.object.resp_44[renglon]=resp[44]
dw_2.object.resp_45[renglon]=resp[45]
dw_2.object.resp_46[renglon]=resp[46]
dw_2.object.resp_47[renglon]=resp[47]
dw_2.object.resp_48[renglon]=resp[48]
dw_2.object.resp_49[renglon]=resp[49]
dw_2.object.resp_50[renglon]=resp[50]
dw_2.object.resp_51[renglon]=resp[51]
dw_2.object.resp_52[renglon]=resp[52]
dw_2.object.resp_53[renglon]=resp[53]
dw_2.object.resp_54[renglon]=resp[54]
dw_2.object.resp_55[renglon]=resp[55]
dw_2.object.resp_56[renglon]=resp[56]
dw_2.object.resp_57[renglon]=resp[57]
dw_2.object.resp_58[renglon]=resp[58]
dw_2.object.resp_59[renglon]=resp[59]
dw_2.object.resp_60[renglon]=resp[60]
dw_2.object.resp_61[renglon]=resp[61]
dw_2.object.resp_62[renglon]=resp[62]
dw_2.object.resp_63[renglon]=resp[63]
dw_2.object.resp_64[renglon]=resp[64]
dw_2.object.resp_65[renglon]=resp[65]
dw_2.object.resp_66[renglon]=resp[66]
dw_2.object.resp_67[renglon]=resp[67]
dw_2.object.resp_68[renglon]=resp[68]
dw_2.object.resp_69[renglon]=resp[69]
dw_2.object.resp_70[renglon]=resp[70]
dw_2.object.resp_71[renglon]=resp[71]
dw_2.object.resp_72[renglon]=resp[72]
dw_2.object.resp_73[renglon]=resp[73]
dw_2.object.resp_74[renglon]=resp[74]
dw_2.object.resp_75[renglon]=resp[75]
dw_2.object.resp_76[renglon]=resp[76]
dw_2.object.resp_77[renglon]=resp[77]
dw_2.object.resp_78[renglon]=resp[78]
dw_2.object.resp_79[renglon]=resp[79]
dw_2.object.resp_80[renglon]=resp[80]
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	dw_2.retrieve(gi_periodo,gi_anio)
	return retrieve(gi_periodo,gi_anio)
end if
end event

event actualiza;int li_respuesta

AcceptText()
dw_2.AcceptText()

if ModifiedCount()+DeletedCount()+dw_2.ModifiedCount()+dw_2.DeletedCount() > 0 Then
	li_respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
	if li_respuesta = 1 then
		if update(true)+dw_2.update(true) = 2 then
			commit using tr_dw_propio;
			return 1
		else
			rollback using tr_dw_propio;
			return -1
		end if
	else
		return 1
	end if
else
	return 1
end if
end event

event nuevo;setfocus()
scrolltorow(insertrow(0))
setcolumn(1)
dw_2.scrolltorow(dw_2.insertrow(0))
dw_2.setcolumn(1)
end event

event borra;/**/
end event

type uo_1 from uo_ver_per_ani within w_cap_honey
int X=5
int Y=5
int Width=1244
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

