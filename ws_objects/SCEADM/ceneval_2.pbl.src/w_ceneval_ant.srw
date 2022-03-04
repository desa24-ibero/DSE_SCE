$PBExportHeader$w_ceneval_ant.srw
forward
global type w_ceneval_ant from Window
end type
type cb_2 from commandbutton within w_ceneval_ant
end type
type cbx_trabajo from checkbox within w_ceneval_ant
end type
type cbx_civil from checkbox within w_ceneval_ant
end type
type cbx_estado from checkbox within w_ceneval_ant
end type
type cbx_nombre from checkbox within w_ceneval_ant
end type
type cb_1 from commandbutton within w_ceneval_ant
end type
type cbx_sexo from checkbox within w_ceneval_ant
end type
type uo_1 from uo_ver_per_ani within w_ceneval_ant
end type
type dw_1 from uo_dw_reporte within w_ceneval_ant
end type
end forward

global type w_ceneval_ant from Window
int X=833
int Y=361
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos dados por el CENEVAL"
string MenuName="m_menu"
long BackColor=30976088
cb_2 cb_2
cbx_trabajo cbx_trabajo
cbx_civil cbx_civil
cbx_estado cbx_estado
cbx_nombre cbx_nombre
cb_1 cb_1
cbx_sexo cbx_sexo
uo_1 uo_1
dw_1 dw_1
end type
global w_ceneval_ant w_ceneval_ant

type variables

end variables

forward prototypes
public function integer horas (string horas_sem)
public function integer trabajo (string ocupacion)
public function string nombre (string nomb)
public function integer edo_civil (string edo)
end prototypes

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

public function string nombre (string nomb);int posicion

DO
	posicion=Pos(nomb, "&")
	if posicion<>0 then
		nomb=Left(nomb, posicion -1)+'Ñ'+Mid(nomb, posicion+1)
	end if
LOOP UNTIL posicion=0

DO
	posicion=Pos(nomb, "DE LA ")
	if posicion=1 then
		nomb=Mid(nomb, posicion+6)
	end if
LOOP UNTIL posicion<>1

DO
	posicion=Pos(nomb, "DEL ")
	if posicion=1 then
		nomb=Mid(nomb, posicion+4)
	end if
LOOP UNTIL posicion<>1

DO
	posicion=Pos(nomb, "DE ")
	if posicion=1 then
		nomb=Mid(nomb, posicion+3)
	end if
LOOP UNTIL posicion<>1

posicion=Pos(nomb, " DE LA")
if posicion=len(nomb) -5 then
	nomb=Left(nomb, posicion -1)
end if

posicion=Pos(nomb, " DEL")
if posicion=len(nomb) -3 then
	nomb=Left(nomb, posicion -1)
end if

posicion=Pos(nomb, " DE")
if posicion=len(nomb) -2 then
	nomb=Left(nomb, posicion -1)
end if

DO
	posicion=Pos(nomb, " DE LA ")
	if posicion<>0 then
		nomb=Left(nomb, posicion -7)+Mid(nomb, posicion+7)
	end if
LOOP UNTIL posicion=0

DO
	posicion=Pos(nomb, " DEL ")
	if posicion<>0 then
		nomb=Left(nomb, posicion -5)+Mid(nomb, posicion+5)
	end if
LOOP UNTIL posicion=0

DO
	posicion=Pos(nomb, " DE ")
	if posicion<>0 then
		nomb=Left(nomb, posicion -4)+Mid(nomb, posicion+4)
	end if
LOOP UNTIL posicion=0

return nomb
end function

public function integer edo_civil (string edo);CHOOSE CASE edo
	CASE "S"
		return 0
	CASE "C"
		return 1
	CASE "V"
		return 3
	CASE "D"
		return 2
	CASE ELSE
		return 999
END CHOOSE
end function

on w_ceneval_ant.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_2=create cb_2
this.cbx_trabajo=create cbx_trabajo
this.cbx_civil=create cbx_civil
this.cbx_estado=create cbx_estado
this.cbx_nombre=create cbx_nombre
this.cb_1=create cb_1
this.cbx_sexo=create cbx_sexo
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.cb_2,&
this.cbx_trabajo,&
this.cbx_civil,&
this.cbx_estado,&
this.cbx_nombre,&
this.cb_1,&
this.cbx_sexo,&
this.uo_1,&
this.dw_1}
end on

on w_ceneval_ant.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.cbx_trabajo)
destroy(this.cbx_civil)
destroy(this.cbx_estado)
destroy(this.cbx_nombre)
destroy(this.cb_1)
destroy(this.cbx_sexo)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type cb_2 from commandbutton within w_ceneval_ant
event clicked pbm_bnclicked
int X=3109
int Y=97
int Width=412
int Height=73
int TabOrder=10
string Text="Lee Horas Trab"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long renglon,folio,horas_trab
string temp

SetPointer(HourGlass!)

dw_1.SetFilter("p29 <>''")
dw_1.Filter()
dw_1.sort()

FOR renglon=1 TO dw_1.rowcount()
	folio=long(dw_1.object.folio[renglon])
	horas_trab=horas(dw_1.object.p29[renglon])
	if horas_trab=999 then
		temp=dw_1.object.p29[renglon]
		messagebox("Problemas con las horas de trabajo de: "+string(folio),temp)
	else
		UPDATE general  
		SET trab_hor = :horas_trab  
		WHERE ( general.folio = :folio ) AND  
			( general.clv_ver = :gi_version ) AND  
			( general.clv_per = :gi_periodo ) AND  
			( general.anio = :gi_anio )
		USING gtr_sadm;
	end if			
NEXT

IF gtr_sadm.SQLNRows > 0 THEN
	COMMIT USING gtr_sadm;
END IF
end event

type cbx_trabajo from checkbox within w_ceneval_ant
int X=2821
int Y=105
int Width=275
int Height=61
string Text="Trabajo"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_civil from checkbox within w_ceneval_ant
int X=2414
int Y=105
int Width=394
int Height=61
string Text="Estado Civil"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_estado from checkbox within w_ceneval_ant
int X=2935
int Y=25
int Width=261
int Height=61
string Text="Estado"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_nombre from checkbox within w_ceneval_ant
int X=2414
int Y=25
int Width=275
int Height=61
string Text="Nombre"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_ceneval_ant
int X=3214
int Y=21
int Width=252
int Height=73
int TabOrder=20
string Text="Verifica"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long renglon,folio
string nombre,sexo,temp_1,temp_2,temp_3,temp_4
int lugar_nac, edo_civil,trabajo
int value,esc_file
string docname, named

value = GetFileSaveName("Selecciona Archivo",+ docname, named, "TXT",+ "Archivo de Diferencias (*.TXT),*.TXT,")
SetPointer(HourGlass!)

IF value = 1 THEN 	
	esc_file = FileOpen(docname,LineMode!, Write!, LockReadWrite!, Replace!)
	FOR renglon=1 TO dw_1.rowcount()
		folio=long(dw_1.object.folio[renglon])
		
		SELECT general.apaterno+' '+general.amaterno+' '+general.nombre,   
			general.lugar_nac, general.sexo, general.edo_civil, general.trabajo  
		INTO :nombre, :lugar_nac, :sexo, :edo_civil, :trabajo  
		FROM general  
		WHERE ( general.folio = :folio ) AND ( general.clv_ver = :gi_version ) AND  
			( general.clv_per = :gi_periodo ) AND ( general.anio = :gi_anio )   
		USING gtr_sadm;
	
		if gtr_sadm.SQLCode = 100 then
			MessageBox("Folio no encontrado",string(folio))
		elseif gtr_sadm.SQLCode > 0 then
			MessageBox("Error en la Base de Datos",gtr_sadm.SQLErrText, Exclamation!)
			else
				temp_1=dw_1.object.nombre[renglon]
				temp_2=dw_1.object.p5[renglon]
				temp_3=dw_1.object.p3[renglon]
				temp_4=dw_1.object.p31_3[renglon]
				if (nombre(nombre)<>nombre(dw_1.object.nombre[renglon]) and cbx_nombre.checked) then
//					messagebox('Problemas con el Nombre de: '+string(folio),&
//						'Según Ceneval: '+temp_1+&
//						'~nSegún Nosotros: '+nombre)
					filewrite(esc_file,'Problemas con el Nombre de: '+string(folio)+&
						' Según Ceneval: '+nombre(temp_1)+&
						' Según Nosotros: '+nombre)
				end if
				if (cbx_sexo.checked and sexo<>dw_1.object.p2[renglon]) then
//					messagebox('Problemas con el Sexo de: '+string(folio),&
//						'Según Ceneval: '+string(sexo(dw_1.object.p2[renglon]))+' '+temp_1+&
//						'~nSegún Nosotros: '+sexo+' '+nombre)
					filewrite(esc_file,'Problemas con el Sexo de: '+string(folio)+&
						' Según Ceneval: '+string(dw_1.object.p2[renglon])+' '+temp_1+&
						' Según Nosotros: '+sexo+' '+nombre)
				end if
				if (cbx_estado.checked and string(lugar_nac)<>dw_1.object.p5[renglon]) then
					if (lugar_nac=31 and dw_1.object.p5[renglon]=' 1') then
						/*No hay problema*/
					elseif (lugar_nac=1 and dw_1.object.p5[renglon]='31') then
						/*No hay problema*/
						elseif (lugar_nac>=50 and dw_1.object.p5[renglon]=' 0') then
							/*No hay problema*/
//							messagebox('Problemas con el Lugar de Nacimiento de: '+string(folio),&
//								'Según Ceneval: '+temp_2+&
//								'~nSegún Nosotros: '+string(lugar_nac))
							filewrite(esc_file,'Problemas con el Lugar de Nacimiento de: '+string(folio)+&
								' Según Ceneval: '+temp_2+&
								' Según Nosotros: '+string(lugar_nac))
					end if
				end if
				if (cbx_civil.checked and edo_civil<>edo_civil(dw_1.object.p3[renglon])) then
					if (edo_civil=4 and edo_civil(dw_1.object.p3[renglon])=1) then
						/*No hay problema*/
					else
//						messagebox('Problemas con el Estado Civil de: '+string(folio),&
//							'Según Ceneval: '+temp_3+' '+&
//							'~nSegún Nosotros: '+string(edo_civil))
						filewrite(esc_file,'Problemas con el Estado Civil de: '+string(folio)+&
							' Según Ceneval: '+temp_3+' '+&
							' Según Nosotros: '+string(edo_civil))
					end if
				end if
				if (trabajo<>trabajo(dw_1.object.p31_3[renglon]) and cbx_trabajo.checked) then
//					messagebox('Problemas con el Trabajo de: '+string(folio),&
//						'Según Ceneval: '+temp_4+&
//						'~nSegún Nosotros: '+string(trabajo))
					filewrite(esc_file,'Problemas con el Trabajo de: '+string(folio)+&
						' Según Ceneval: '+temp_4+&
						' Según Nosotros: '+string(trabajo))
				end if
		End If
	NEXT
	FileClose(esc_file)
end if
end event

type cbx_sexo from checkbox within w_ceneval_ant
int X=2707
int Y=25
int Width=211
int Height=61
string Text="Sexo"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_1 from uo_ver_per_ani within w_ceneval_ant
int X=5
int Y=5
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_ceneval_ant
int X=37
int Y=201
int Width=3612
int Height=1569
int TabOrder=0
string DataObject="dw_ceneval_ant"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;event primero()
return retrieve(gi_version,gi_periodo,gi_anio)
end event

