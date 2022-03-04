$PBExportHeader$w_mat_preinsc_ant.srw
forward
global type w_mat_preinsc_ant from w_ancestral
end type
type cb_1 from commandbutton within w_mat_preinsc_ant
end type
type dw_mat_preinsc from uo_dw_captura within w_mat_preinsc_ant
end type
end forward

global type w_mat_preinsc_ant from w_ancestral
int Height=2371
boolean TitleBar=true
string Title="Captura de Materias Preinscritas con Lector"
string MenuName="m_menu"
cb_1 cb_1
dw_mat_preinsc dw_mat_preinsc
end type
global w_mat_preinsc_ant w_mat_preinsc_ant

type variables
int ii_error_file
end variables

forward prototypes
public function string val_grupo (string grupo)
end prototypes

public function string val_grupo (string grupo);if len(grupo)=3 then
	if mid(grupo,2,1)=' ' then
		return mid(grupo,1,1)+mid(grupo,3,1)
	else
		return grupo
	end if
else
	return trim(grupo)
end if
end function

event close;call super::close;/*
DESCRIPCIÓN: Al cerrar la ventana cierra el archivo, si es que este se abrió.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
IF ii_error_file <> 999 THEN
	FileClose(ii_error_file)
end if
end event

event open;/*
DESCRIPCIÓN: Pide el nombre de un archivo, ahí se escribirán los errores de lectura del
				 lector óptico. Pon la ventana en el extremo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/

int li_value
string ls_docname, ls_named

li_value = GetFileSaveName("Selecciona Archivo",+ ls_docname, ls_named, "TXT",+ "Archivo de ERROR (*.TXT),*.TXT,")

IF li_value = 1 THEN
	ii_error_file = FileOpen(ls_docname,LineMode!, Write!, LockWrite!, Replace!)
else
	ii_error_file = 999
end if

x=1
y=1

dw_mat_preinsc.settransobject(gtr_sce)
end event

on w_mat_preinsc_ant.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.dw_mat_preinsc=create dw_mat_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_mat_preinsc
end on

on w_mat_preinsc_ant.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_mat_preinsc)
end on

type p_uia from w_ancestral`p_uia within w_mat_preinsc_ant
int Y=3
end type

type cb_1 from commandbutton within w_mat_preinsc_ant
event clicked pbm_bnclicked
int X=1357
int Y=106
int Width=834
int Height=109
string Text="Lee Archivo del Lector Óptico"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*
DESCRIPCIÓN: Pide el nombre del archivo del lector óptico. Leelo línea por línea y pasalo 
				 al evento agrega de dw_mat_preinsc.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
int li_value, li_lee_file
long ll_bytes_read
string ls_docname, ls_named, ls_s

li_value = GetFileOpenName("Selecciona Archivo",+ ls_docname, ls_named, "DLM",+ "Archivo Actas (*.DLM),*.DLM,")

IF li_value = 1 THEN
	li_lee_file = FileOpen(ls_docname,LineMode!, Read!, LockReadWrite!)

	SetPointer(HourGlass!)
	
	ll_bytes_read = FileRead(li_lee_file, ls_s)
	DO UNTIL ll_bytes_read<0
		if ll_bytes_read>0 then
			dw_mat_preinsc.event agrega(ls_s)
		end if
		ll_bytes_read = FileRead(li_lee_file, ls_s)
	LOOP
	FileClose(li_lee_file)
end if

dw_mat_preinsc.insertrow(0)
dw_mat_preinsc.deleterow(dw_mat_preinsc.rowcount())
end event

type dw_mat_preinsc from uo_dw_captura within w_mat_preinsc_ant
event constructor pbm_constructor
event borra ( )
event agrega ( string linea )
event type integer busca ( long materia )
int X=0
int Y=416
int Width=3525
int Height=1744
int TabOrder=0
string DataObject="d_mat_preinsc"
end type

event borra;/*
DESCRIPCIÓN: En caso de que se desee editar manualmente las materias, con este evento se
				 podrá una de ellas.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
setfocus()
deleterow(getrow())
end event

event agrega;call super::agrega;/*
DESCRIPCIÓN: Verifica que la cuenta sea válida y este preinscrita. Checa carrera, plan y
				 nivel. Lee las materias que eligió. Carga las materias que ya tenía
				 preinscritas. Complétalas o corrígelas. Verifica el nuevo status de cada una y 
				 guarda los cambios.
PARÁMETROS: linea leída del archivo del lector óptico.
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
string ls_cuenta, ls_clave[10], ls_grupo[10], ls_nivel
int li_a,li_cont,li_status,li_carr,li_plan
long ll_renglon,ll_cuenta,ll_folio

li_a=Pos (linea, ",")
ls_cuenta=Left (linea, li_a -1)

if obten_digito(long(mid(ls_cuenta,1,len(ls_cuenta) -1))) = mid(ls_cuenta,len(ls_cuenta),1) then
	ls_cuenta=mid(ls_cuenta,1,len(ls_cuenta) -1)
else
	IF ii_error_file <> 999 THEN
		FileWrite(ii_error_file, "Cuenta Inexistente:	"+linea)
	end if
	return
end if

ll_cuenta=long(ls_cuenta)

if ll_cuenta=0 then
	IF ii_error_file <> 999 THEN
		FileWrite(ii_error_file, "Cuenta Inexistente:	"+linea)
	end if
	return
end if

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
CHOOSE CASE Left (linea, li_a -1)
	CASE 'P'
		gi_periodo=0
	CASE 'V'
		gi_periodo=1
	CASE 'O'
		gi_periodo=2
END CHOOSE

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
gi_anio=long(Left (linea, li_a -1))

setnull(ll_folio)

SELECT preinsc.folio
INTO :ll_folio
FROM preinsc
WHERE preinsc.cuenta = :ll_cuenta and periodo=:gi_periodo and anio=:gi_anio
USING gtr_sce;

if isnull(ll_folio) then
	SELECT max(preinsc.folio)
	INTO :ll_folio
	FROM preinsc
	WHERE preinsc.folio < 1000 and periodo=:gi_periodo and anio=:gi_anio
	USING gtr_sce;
	
	if isnull(ll_folio) then
		ll_folio = 0
	end if
	ll_folio=ll_folio+1
	
	INSERT INTO dbo.preinsc
		( cuenta,folio,status,periodo,anio,noimpresiones )
	VALUES ( :ll_cuenta,:ll_folio,0,:gi_periodo,:gi_anio,0 )
	USING gtr_sce;
	commit using gtr_sce;
end if

SELECT academicos.nivel,academicos.cve_carrera,academicos.cve_plan
INTO :ls_nivel,:li_carr,:li_plan
FROM academicos
WHERE academicos.cuenta = :ll_cuenta
USING gtr_sce;

UPDATE preinsc
SET status = 2
WHERE preinsc.cuenta = :ll_cuenta and periodo=:gi_periodo and anio=:gi_anio
USING gtr_sce;
COMMIT USING gtr_sce;

FOR li_cont=1 TO 10
	linea=mid(linea,li_a+1)
	li_a=Pos (linea, ",")
	ls_clave[li_cont]=Left (linea, li_a -1)
	
	linea=mid(linea,li_a+1)
	li_a=Pos (linea, ",")
	if li_a=0 then
		ls_grupo[li_cont]=linea
	else
		ls_grupo[li_cont]=Left (linea, li_a -1)
	end if
NEXT

retrieve(ll_cuenta)
FOR li_cont=1 TO 10
	if long(ls_clave[li_cont])<>0 then
		if ls_grupo[li_cont]=' ' then
			ls_grupo[li_cont]='A'
		end if
		ll_renglon=event busca(long(ls_clave[li_cont]))
		if ll_renglon=0 then
			insertrow(0)
			ll_renglon=rowcount()
			object.cuenta[ll_renglon]=ll_cuenta
			object.cve_mat[ll_renglon]=long(ls_clave[li_cont])
			object.gpo[ll_renglon]=val_grupo(ls_grupo[li_cont])
			object.periodo[ll_renglon]=gi_periodo
			object.anio[ll_renglon]=gi_anio
		else
			object.gpo[ll_renglon]=val_grupo(ls_grupo[li_cont])
		end if
	end if
NEXT

FOR ll_renglon=1 TO rowcount()
	if gi_periodo=object.periodo[ll_renglon] and gi_anio=object.anio[ll_renglon] then
		li_status=f_e_mat(object.cve_mat[ll_renglon])
		li_status=f_e_grup(object.cve_mat[ll_renglon],val_grupo(object.gpo[ll_renglon]))+li_status
		li_status=f_e_plan(ls_nivel,li_carr,li_plan,object.cve_mat[ll_renglon])+li_status
		li_status=f_no_curso(ll_cuenta,object.cve_mat[ll_renglon])+li_status
		object.status[ll_renglon]=li_status
	end if
NEXT

event actualiza_0_int()
/*

messagebox(CUENTA+' '+periodo+' '+año+' ',CLAVE[cont]+' '+GRUPO[cont])

Formato: 

CUENTA, PERIODO, AÑO, CLAVE01, GRUPO01, CLAVE02, GRUPO02, CLAVE03, GRUPO03, CLAVE04, GRUPO04,
CLAVE05, GRUPO05, CLAVE06, GRUPO06, CLAVE07, GRUPO07, CLAVE08, GRUPO08, CLAVE09, GRUPO09,
CLAVE10, GRUPO10
*/
end event

event busca;call super::busca;/*
DESCRIPCIÓN: Busca la materia que se pasa de parámetro dentro de las de este dw.
PARÁMETROS: materia
REGRESA: Posición de la materia en el dw, 0 si no la encuentra.
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
long ll_cont
FOR ll_cont=1 TO rowcount()
	if materia=object.cve_mat[ll_cont] and gi_periodo=object.periodo[ll_cont] and &
		gi_anio=object.anio[ll_cont] then
		return ll_cont
	end if
NEXT

return 0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event actualiza_0_int;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				Este evento no presenta interacción con el usuario
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 17 Junio 1998
MODIFICACIÓN:
*/
AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
/*Función que solo actualiza*/
	if update(true) = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		commit using gtr_sce;	
		return 1
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using gtr_sce;		
		return -1
	end if
else
	return 1
end if
end event

event carga;/*
DESCRIPCIÓN: Carga todas las materias que se han preinscrito.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
return retrieve(0)
end event

