$PBExportHeader$w_mat_preinsc.srw
$PBExportComments$Captura con lector de materias preinscritas
forward
global type w_mat_preinsc from w_ancestral
end type
type cb_1 from commandbutton within w_mat_preinsc
end type
type dw_mat_preinsc from uo_dw_captura within w_mat_preinsc
end type
end forward

global type w_mat_preinsc from w_ancestral
integer height = 2372
string title = "Captura de Materias Preinscritas con Lector"
string menuname = "m_menu"
cb_1 cb_1
dw_mat_preinsc dw_mat_preinsc
end type
global w_mat_preinsc w_mat_preinsc

type variables
int ii_error_file
transaction itr_web
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

if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

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

//if conecta_bd(itr_web,gs_sweb, "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb,gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_mat_preinsc.SetTransObject(itr_web)
end if

li_value = GetFileSaveName("Selecciona Archivo",+ ls_docname, ls_named, "TXT",+ "Archivo de ERROR (*.TXT),*.TXT,")

IF li_value = 1 THEN
	ii_error_file = FileOpen(ls_docname,LineMode!, Write!, LockWrite!, Replace!)
else
	ii_error_file = 999
end if

x=1
y=1

end event

on w_mat_preinsc.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.dw_mat_preinsc=create dw_mat_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_mat_preinsc
end on

on w_mat_preinsc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_mat_preinsc)
end on

type p_uia from w_ancestral`p_uia within w_mat_preinsc
integer y = 4
end type

type cb_1 from commandbutton within w_mat_preinsc
event clicked pbm_bnclicked
integer x = 1358
integer y = 108
integer width = 832
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lee Archivo del Lector Óptico"
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

type dw_mat_preinsc from uo_dw_captura within w_mat_preinsc
event constructor pbm_constructor
event borra ( )
event agrega ( string linea )
event type integer busca ( long materia )
integer x = 0
integer y = 416
integer width = 3525
integer height = 1744
integer taborder = 0
string dataobject = "d_mat_preinsc"
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

event agrega(string linea);/*
DESCRIPCIÓN: Verifica que la cuenta sea válida y este preinscrita. Checa carrera, plan y
				 nivel. Lee las materias que eligió. Carga las materias que ya tenía
				 preinscritas. Complétalas o corrígelas. Verifica el nuevo status de cada una y 
				 guarda los cambios.
PARÁMETROS: linea leída del archivo del lector óptico.
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:26 de Junio 2001
AUTOR: Antonio Pica Ruiz
*/
string ls_cuenta, ls_clave[10], ls_grupo[10], ls_nivel,ls_grupo_actual, ls_cond_busqueda
int li_a,li_cont,li_status,li_carr,li_plan
long ll_renglon,ll_cuenta,ll_folio,ll_cve_mat, ll_periodo, ll_anio, ll_rows

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

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

gi_periodo = luo_periodo_servicios.f_recupera_id_periodo_x_desc_corta(gtr_sce, Left (linea, li_a -1))

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN 
END IF

//CHOOSE CASE Left (linea, li_a -1)
//	CASE 'P'
//		gi_periodo=0
//	CASE 'V'
//		gi_periodo=1
//	CASE 'O'
//		gi_periodo=2
//END CHOOSE

linea=mid(linea,li_a+1)
li_a=Pos (linea, ",")
gi_anio=long(Left (linea, li_a -1))

setnull(ll_folio)

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

ll_rows = retrieve(ll_cuenta)
FOR li_cont=1 TO 10
	if long(ls_clave[li_cont])<>0 then
		if ls_grupo[li_cont]=' ' then
			ls_grupo[li_cont]='A'
		end if
//		ll_renglon=event busca(long(ls_clave[li_cont]))
		ll_cve_mat = long(ls_clave[li_cont])
		ls_grupo_actual = val_grupo(ls_grupo[li_cont])
		ls_cond_busqueda = "cve_mat = "+string(ll_cve_mat)+" and periodo = "+string(gi_periodo)+&
		                      " and anio = "+string( gi_anio)+" and gpo = '"+ls_grupo_actual+"'"
		ll_renglon= this.find(ls_cond_busqueda ,1, this.rowcount() )
		if ll_renglon=0 then
			insertrow(0)
			ll_renglon=rowcount()
			object.cuenta[ll_renglon]=ll_cuenta
			object.cve_mat[ll_renglon]=long(ls_clave[li_cont])
			object.gpo[ll_renglon]=val_grupo(ls_grupo[li_cont])
			object.periodo[ll_renglon]=gi_periodo
			object.anio[ll_renglon]=gi_anio
			object.status[ll_renglon]=0
			if	event actualiza_0_int() = -1 then
				IF ii_error_file <> 999 THEN
					FileWrite(ii_error_file, "Error al insertar materia C:¨["+string(itr_web.SqlCode)+"] E:"+itr_web.SqlErrText)
				end if
			end if 
		end if
	end if
NEXT

UPDATE preinsc
SET status = 2
WHERE preinsc.cuenta = :ll_cuenta and periodo=:gi_periodo and anio=:gi_anio
USING itr_web;
if itr_web. SqlCode = -1 then
	IF ii_error_file <> 999 THEN
		FileWrite(ii_error_file, "Error al actualizar estatus preinsc a 2 C:¨["+string(itr_web.SqlCode)+"] E: "+itr_web.SqlErrText)
	end if
	ROLLBACK USING itr_web;
else
	COMMIT USING itr_web;
end if

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

event inicia_transaction_object();call super::inicia_transaction_object;tr_dw_propio = itr_web

end event

event type integer actualiza_0_int();/*
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
		commit using itr_web;	
		return 1
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using itr_web;		
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

