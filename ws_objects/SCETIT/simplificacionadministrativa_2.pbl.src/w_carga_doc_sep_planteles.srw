$PBExportHeader$w_carga_doc_sep_planteles.srw
forward
global type w_carga_doc_sep_planteles from Window
end type
type dw_escuela_ant_planteles from datawindow within w_carga_doc_sep_planteles
end type
type dw_doc_sep_planteles_upd from datawindow within w_carga_doc_sep_planteles
end type
type st_2 from statictext within w_carga_doc_sep_planteles
end type
type st_1 from statictext within w_carga_doc_sep_planteles
end type
type uo_w_planteles from uo_planteles within w_carga_doc_sep_planteles
end type
type uo_w_doc_control_sep from uo_doc_control_sep within w_carga_doc_sep_planteles
end type
type cb_2 from commandbutton within w_carga_doc_sep_planteles
end type
type dw_doc_sep_planteles from datawindow within w_carga_doc_sep_planteles
end type
type cb_1 from commandbutton within w_carga_doc_sep_planteles
end type
end forward

global type w_carga_doc_sep_planteles from Window
int X=834
int Y=362
int Width=3372
int Height=1747
boolean TitleBar=true
string Title="Carga de Planteles para Certificados"
string MenuName="m_menu_doc_planteles"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event inicia_proceso ( )
dw_escuela_ant_planteles dw_escuela_ant_planteles
dw_doc_sep_planteles_upd dw_doc_sep_planteles_upd
st_2 st_2
st_1 st_1
uo_w_planteles uo_w_planteles
uo_w_doc_control_sep uo_w_doc_control_sep
cb_2 cb_2
dw_doc_sep_planteles dw_doc_sep_planteles
cb_1 cb_1
end type
global w_carga_doc_sep_planteles w_carga_doc_sep_planteles

type variables
boolean ib_importacion_exitosa= false
long il_cve_plantel, il_cve_doc_control_sep, il_array_numero[]
string is_plantel, is_doc_control_sep
end variables

forward prototypes
public function boolean wf_existen_repetidos ()
public function integer wf_actualiza_doc_plantel ()
public function integer wf_imprime_formato5 ()
public function boolean wf_importacion_valida ()
end prototypes

public function boolean wf_existen_repetidos ();long ll_num_rows, ll_row_actual, ll_row_buscado
long ll_cuenta_actual, ll_cuenta_buscada
string ls_nivel_est_ant_actual, ls_nivel_est_ant_buscado
string ls_escuela_ant_actual, ls_escuela_ant_buscada
//Campos del Result Set
//nombre_completo
//cuenta
//nacionalidad
//sexo
//nivel_cursado
//carrera
//fecha_acuerdo
//numero_acuerdo
//ciclos_cursados
//nivel_est_ant
//escuela_ant
//escuela_pais
//escuela_periodo
//escuela_num_cert

ll_num_rows= dw_doc_sep_planteles.RowCount()
for ll_row_actual = 1 to ll_num_rows
	ll_cuenta_actual = dw_doc_sep_planteles.GetItemNumber(ll_row_actual,"cuenta")	
	ls_nivel_est_ant_actual = dw_doc_sep_planteles.GetItemString(ll_row_actual,"nivel_est_ant")	
	ls_escuela_ant_actual = dw_doc_sep_planteles.GetItemString(ll_row_actual,"escuela_ant")	

	for ll_row_buscado = 1 to ll_num_rows
		ll_cuenta_buscada = dw_doc_sep_planteles.GetItemNumber(ll_row_buscado,"cuenta")	
		ls_nivel_est_ant_buscado = dw_doc_sep_planteles.GetItemString(ll_row_buscado,"nivel_est_ant")	
		ls_escuela_ant_buscada = dw_doc_sep_planteles.GetItemString(ll_row_buscado,"escuela_ant")	
		
		if ll_row_buscado <> ll_row_actual and &
		   ll_cuenta_buscada =ll_cuenta_actual and &
			ls_nivel_est_ant_buscado = ls_nivel_est_ant_actual and &
			ls_escuela_ant_buscada = ls_escuela_ant_actual  then
			MessageBox("Registro Repetido en renglones "+string(ll_row_actual)+" y "+string(ll_row_buscado), &
			           "Cuenta  : "+string(ll_cuenta_buscada)+"~n"+ &
			           "Nivel   : "+ls_nivel_est_ant_buscado+"~n"+ &			           
			           "Escuela : "+ls_escuela_ant_buscada+"~n")
			return true
		end if
	next
next

return false


end function

public function integer wf_actualiza_doc_plantel ();long ll_num_rows, ll_row_actual, ll_row_insertado, ll_row_escuela_ant
long ll_cuenta, ll_cuenta_anterior, ll_ciclos_cursados, ll_ultimo_folio, ll_folio_actual
string ls_nombre_completo, ls_nacionalidad, ls_sexo, ls_nivel_cursado, ls_carrera
datetime ldttm_fecha_acuerdo, ldttm_fecha_emision
datetime ldttm_fecha_examen_rec, ldttm_fecha_expedicion_tit
string ls_numero_acuerdo, ls_nivel_est_ant, ls_escuela_ant, ls_escuela_pais
string ls_escuela_periodo, ls_escuela_num_cert, ls_orden_cobro, ls_escuela_doc
integer li_cancelado, li_upd_planteles, li_upd_escuelas_ant, ll_carrera_num, ll_modalidad_num
boolean lb_inserto_escuela_ant
long ll_indice_array
string ls_institucion_serv_soc, ls_entidad_serv_soc, ls_periodo_serv_soc, ls_modalidad_tit
//Campos del External Result Set 
//nombre_completo
//cuenta
//nacionalidad
//sexo
//nivel_cursado
//carrera
//fecha_acuerdo
//numero_acuerdo
//ciclos_cursados
//nivel_est_ant
//escuela_ant
//escuela_pais
//escuela_periodo
//escuela_num_cert

ll_num_rows= dw_doc_sep_planteles.RowCount()
ll_cuenta_anterior = 0
ll_ultimo_folio= f_obten_ult_fol_plant(il_cve_doc_control_sep, il_cve_plantel)
ll_folio_actual= ll_ultimo_folio 
ldttm_fecha_emision= fecha_servidor(gtr_sce)
li_cancelado= 0
SetNull(ls_orden_cobro)
lb_inserto_escuela_ant= false
ll_indice_array= 0

for ll_row_actual = 1 to ll_num_rows
	ls_nombre_completo = dw_doc_sep_planteles.GetItemString(ll_row_actual,"nombre_completo")	
	ll_cuenta = dw_doc_sep_planteles.GetItemNumber(ll_row_actual,"cuenta")	
	ls_nacionalidad = dw_doc_sep_planteles.GetItemString(ll_row_actual,"nacionalidad")	
	ls_sexo = dw_doc_sep_planteles.GetItemString(ll_row_actual,"sexo")	
	ls_nivel_cursado = dw_doc_sep_planteles.GetItemString(ll_row_actual,"nivel_cursado")	
	ls_carrera = dw_doc_sep_planteles.GetItemString(ll_row_actual,"carrera")
	ll_carrera_num = dw_doc_sep_planteles.GetItemNumber(ll_row_actual,"carrera_num")
	ldttm_fecha_acuerdo = dw_doc_sep_planteles.GetItemDateTime(ll_row_actual,"fecha_acuerdo")	
	ls_numero_acuerdo = dw_doc_sep_planteles.GetItemString(ll_row_actual,"numero_acuerdo")	
	ll_ciclos_cursados = dw_doc_sep_planteles.GetItemNumber(ll_row_actual,"ciclos_cursados")	
	ls_nivel_est_ant = dw_doc_sep_planteles.GetItemString(ll_row_actual,"nivel_est_ant")	
	ls_escuela_ant = dw_doc_sep_planteles.GetItemString(ll_row_actual,"escuela_ant")	
	ls_escuela_pais = dw_doc_sep_planteles.GetItemString(ll_row_actual,"escuela_pais")	
	ls_escuela_periodo = dw_doc_sep_planteles.GetItemString(ll_row_actual,"escuela_periodo")	
	ls_escuela_num_cert = dw_doc_sep_planteles.GetItemString(ll_row_actual,"escuela_num_cert")
	ls_escuela_doc= dw_doc_sep_planteles.GetItemString(ll_row_actual,"escuela_doc")
	ls_escuela_doc = UPPER(ls_escuela_doc)
	if il_cve_doc_control_sep>= 3 then
		ls_institucion_serv_soc= dw_doc_sep_planteles.GetItemString(ll_row_actual,"institucion_serv_soc")
		ls_entidad_serv_soc= dw_doc_sep_planteles.GetItemString(ll_row_actual,"entidad_serv_soc")
		ls_periodo_serv_soc= dw_doc_sep_planteles.GetItemString(ll_row_actual,"periodo_serv_soc")
		ls_modalidad_tit= dw_doc_sep_planteles.GetItemString(ll_row_actual,"modalidad_tit")
		ll_modalidad_num= dw_doc_sep_planteles.GetItemNumber(ll_row_actual,"modalidad_num")
		ldttm_fecha_examen_rec= dw_doc_sep_planteles.GetItemDateTime(ll_row_actual,"fecha_examen_rec")
		ldttm_fecha_expedicion_tit= dw_doc_sep_planteles.GetItemDateTime(ll_row_actual,"fecha_expedicion_tit")
	end if
	
	if ll_cuenta <> ll_cuenta_anterior then

		ll_row_insertado= dw_doc_sep_planteles_upd.InsertRow(0)
		
		if isnull(ll_row_insertado) or ll_row_insertado= -1 then
			return -1		
		end if
		ll_indice_array= ll_indice_array + 1
		ll_folio_actual= ll_folio_actual + 1	
		
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "cve_plantel", il_cve_plantel)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "cuenta", ll_cuenta)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "numero", ll_folio_actual)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "fecha_emision", ldttm_fecha_emision)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "cancelado", li_cancelado)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "orden_cobro", ls_orden_cobro)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "cve_doc_control_sep", il_cve_doc_control_sep)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "nombre_completo", ls_nombre_completo)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "nacionalidad", ls_nacionalidad)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "sexo", ls_sexo)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "nivel", ls_nivel_cursado)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "carrera", ls_carrera)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "carrera_num", ll_carrera_num)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "ciclos_cursados", ll_ciclos_cursados)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "fecha_acuerdo", ldttm_fecha_acuerdo)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "numero_acuerdo", ls_numero_acuerdo)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "nivel_est_ant", ls_nivel_est_ant)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "escuela_ant", ls_escuela_ant)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "escuela_pais", ls_escuela_pais)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "escuela_periodo", ls_escuela_periodo)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "escuela_num_cert", ls_escuela_num_cert)
		dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "escuela_doc", ls_escuela_doc)
		if il_cve_doc_control_sep>= 3 then
			dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "institucion_serv_soc", ls_institucion_serv_soc)
			dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "entidad_serv_soc", ls_entidad_serv_soc)
			dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "periodo_serv_soc", ls_periodo_serv_soc)
			dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "modalidad_tit", ls_modalidad_tit)
			dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "modalidad_num", ll_modalidad_num)
			dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "fecha_examen_rec", ldttm_fecha_examen_rec)
			dw_doc_sep_planteles_upd.SetItem(ll_row_insertado, "fecha_expedicion_tit", ldttm_fecha_expedicion_tit)
		end if
		
		il_array_numero[ll_indice_array]= ll_folio_actual
		lb_inserto_escuela_ant= true
	else 
		lb_inserto_escuela_ant= true
	end if

	if lb_inserto_escuela_ant then
		ll_row_escuela_ant = dw_escuela_ant_planteles.InsertRow(0)
		
		if isnull(ll_row_escuela_ant) or ll_row_escuela_ant= -1 then
			return -1		
		end if
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "numero", ll_folio_actual)
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "cuenta", ll_cuenta)		
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "nivel", ls_nivel_est_ant)
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "escuela", ls_escuela_ant)
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "escuela_pais", ls_escuela_pais)
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "escuela_periodo", ls_escuela_periodo)
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "escuela_num_cert", ls_escuela_num_cert)
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "escuela_doc", ls_escuela_doc)
		dw_escuela_ant_planteles.SetItem(ll_row_escuela_ant, "cve_plantel", il_cve_plantel)

	end if	
	ll_cuenta_anterior= ll_cuenta
next

li_upd_planteles= dw_doc_sep_planteles_upd.Update()
IF li_upd_planteles = 1 THEN	
	li_upd_escuelas_ant= dw_escuela_ant_planteles.Update()
	IF li_upd_escuelas_ant = 1 THEN		
		COMMIT USING gtr_sce;
//		MessageBox("Importacion Exitosa","Se ha almacenado la informacion del plantel", Information!)
		RETURN 1
	ELSE
		ROLLBACK USING gtr_sce;
//		MessageBox("Error de Importacion","No se ha almacenado la informacion del plantel", StopSign!)
		RETURN -1
	END IF	
ELSE
	ROLLBACK USING gtr_sce;
//	MessageBox("Error de Importacion","No se ha almacenado la informacion del plantel", StopSign!)
	RETURN -1
END IF

RETURN 0


end function

public function integer wf_imprime_formato5 ();//Devuelve:	 integer

datastore lds_data_report
int li_ret, li_i, li_res_impresion
long ll_res_retrieve, ll_tamanio_array, ll_indice_array, ll_numero

lds_data_report= create datastore

lds_data_report.DataObject = 'd_formato5_planteles_2'
lds_data_report.SetTransObject(gtr_sce)
lds_data_report.Reset()

ll_tamanio_array= UpperBound(il_array_numero)

for ll_indice_array= 1 to ll_tamanio_array
	ll_numero = il_array_numero[ll_indice_array]
	ll_res_retrieve= lds_data_report.Retrieve(ll_numero,il_cve_plantel)	
	if ll_res_retrieve > 0 then
		lds_data_report.Object.DataWindow.Print.Copies = 2
		li_res_impresion= lds_data_report.Print()
		if li_res_impresion <> 1 then
			MessageBox("Error de Impresion", "Error en la impresion del folio: "+string(ll_numero),StopSign!)
			return -1					
		end if 
	else
		MessageBox("Error de Generacion", "Error en la generacion del folio: "+string(ll_numero),StopSign!)
		return -1		
	end if	
next

return 1

end function

public function boolean wf_importacion_valida ();long ll_num_rows, ll_row_actual, ll_row_buscado
long ll_cuenta_actual, ll_cuenta_buscada
string ls_nivel_est_ant_actual, ls_nivel_est_ant_buscado, ls_digito, ls_digito_calculado
string ls_escuela_ant_actual, ls_escuela_ant_buscada
//Campos del Result Set
//nombre_completo
//cuenta
//digito
//nacionalidad
//sexo
//nivel_cursado
//carrera
//fecha_acuerdo
//numero_acuerdo
//ciclos_cursados
//nivel_est_ant
//escuela_ant
//escuela_pais
//escuela_periodo
//escuela_num_cert

ll_num_rows= dw_doc_sep_planteles.RowCount()
for ll_row_actual = 1 to ll_num_rows
	ll_cuenta_actual = dw_doc_sep_planteles.GetItemNumber(ll_row_actual,"cuenta")	
	ls_digito = dw_doc_sep_planteles.GetItemString(ll_row_actual,"digito")	
	ls_digito_calculado = obten_digito(ll_cuenta_actual)
	if ls_digito<>ls_digito_calculado then
			MessageBox("Inconsistencia en Digito", &
			"Digito mal capturado en el renglon "+string(ll_row_actual)+"~n" +&
			           "Digito Incorrecto  : "+ls_digito+"~n"+&
			           "Digito Correcto    : "+ls_digito_calculado+"~n", StopSign!)
						  
		return false
	end if
next

return true


end function

on w_carga_doc_sep_planteles.create
if this.MenuName = "m_menu_doc_planteles" then this.MenuID = create m_menu_doc_planteles
this.dw_escuela_ant_planteles=create dw_escuela_ant_planteles
this.dw_doc_sep_planteles_upd=create dw_doc_sep_planteles_upd
this.st_2=create st_2
this.st_1=create st_1
this.uo_w_planteles=create uo_w_planteles
this.uo_w_doc_control_sep=create uo_w_doc_control_sep
this.cb_2=create cb_2
this.dw_doc_sep_planteles=create dw_doc_sep_planteles
this.cb_1=create cb_1
this.Control[]={this.dw_escuela_ant_planteles,&
this.dw_doc_sep_planteles_upd,&
this.st_2,&
this.st_1,&
this.uo_w_planteles,&
this.uo_w_doc_control_sep,&
this.cb_2,&
this.dw_doc_sep_planteles,&
this.cb_1}
end on

on w_carga_doc_sep_planteles.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_escuela_ant_planteles)
destroy(this.dw_doc_sep_planteles_upd)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_w_planteles)
destroy(this.uo_w_doc_control_sep)
destroy(this.cb_2)
destroy(this.dw_doc_sep_planteles)
destroy(this.cb_1)
end on

event open;x=1
y=1

end event

type dw_escuela_ant_planteles from datawindow within w_carga_doc_sep_planteles
int X=33
int Y=1270
int Width=3233
int Height=230
int TabOrder=70
boolean Visible=false
string DataObject="d_escuela_ant_planteles"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event dberror;//Para que muestre el error del manejedor de base de datos

return 0
end event

event constructor;SetTransObject(gtr_sce)
end event

type dw_doc_sep_planteles_upd from datawindow within w_carga_doc_sep_planteles
int X=33
int Y=1174
int Width=3233
int Height=368
int TabOrder=60
boolean Visible=false
string DataObject="d_doc_sep_planteles"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event dberror;//Para que muestre el error del manejedor de base de datos

return 0
end event

event constructor;SetTransObject(gtr_sce)
end event

type st_2 from statictext within w_carga_doc_sep_planteles
int X=88
int Y=118
int Width=252
int Height=77
boolean Enabled=false
string Text="Plantel :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_carga_doc_sep_planteles
int X=1543
int Y=118
int Width=571
int Height=77
boolean Enabled=false
string Text="Tipo de Documento :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_w_planteles from uo_planteles within w_carga_doc_sep_planteles
int X=453
int Y=99
int Width=651
int Height=118
int TabOrder=20
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_w_planteles.destroy
call uo_planteles::destroy
end on

type uo_w_doc_control_sep from uo_doc_control_sep within w_carga_doc_sep_planteles
int X=2121
int Y=99
int Width=1148
int Height=118
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_w_doc_control_sep.destroy
call uo_doc_control_sep::destroy
end on

type cb_2 from commandbutton within w_carga_doc_sep_planteles
int X=2000
int Y=381
int Width=680
int Height=106
int TabOrder=40
boolean Enabled=false
string Text="Almacenar Informacion"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer rtn, li_res
long ll_row_plantel, ll_row_doc, ll_cve_plantel, ll_cve_doc_control_sep
integer li_res_continuar
string ls_plantel, ls_doc_control_sep



ll_row_plantel = uo_w_planteles.dw_1.GetRow()
ll_row_doc = uo_w_doc_control_sep.dw_1.GetRow()

if ll_row_plantel <=0 then
	MessageBox("Plantel Invalido","Favor de seleccionar un plantel")
	return	
end if

if ll_row_doc <=0 then
	MessageBox("Documento Invalido","Favor de seleccionar un documento")
	return	
end if


ll_cve_plantel = uo_w_planteles.dw_1.object.cve_plantel[ll_row_plantel]
ll_cve_doc_control_sep = uo_w_doc_control_sep.dw_1.object.cve_doc_control_sep[ll_row_doc]

if ll_cve_doc_control_sep <> il_cve_doc_control_sep then
	if (ll_cve_doc_control_sep<3 and il_cve_doc_control_sep >= 3) or &
		(ll_cve_doc_control_sep>=3 and il_cve_doc_control_sep <3 ) then
		MessageBox("Documento Invalido","El formato del archivo leido es distinto al documento especificado", StopSign!)			
		return		
	end if
end if

il_cve_plantel= ll_cve_plantel
il_cve_doc_control_sep = ll_cve_doc_control_sep

ls_plantel = f_obten_plantel(ll_cve_plantel)
ls_doc_control_sep = f_obten_doc_control_sep(ll_cve_doc_control_sep)
is_plantel= ls_plantel
is_doc_control_sep= ls_doc_control_sep

if ll_cve_plantel =0 or ll_cve_plantel= 17 then
	MessageBox("Plantel Invalido","Favor de seleccionar otro Plantel")
	return	
end if

if ll_cve_doc_control_sep =0 then
	MessageBox("Documento Invalido","Favor de seleccionar otro Tipo de Documento")
	return	
end if



li_res = MessageBox("Confirmación",&
					"¿Desea almacenar la información importada del ~n documento ["+ls_doc_control_sep+&
					 "] ~n en el plantel ["+ls_plantel+"]?", Question!, YesNo!)
					
if li_res <>1 then
	return
end if

if il_cve_doc_control_sep= 0 and il_cve_plantel= 0 then
	MessageBox("Importacion ejecutada Anteriormente",&
					"Es necesario volver a Importar Archivo para Actualizar los cambios", StopSign!)
	return
end if

if not ib_importacion_exitosa then
	MessageBox("Error durante Importacion",&
					"Es necesario importar los datos correctamente antes de almacenarlos", StopSign!)
	return
	
end if

if not wf_importacion_valida() then
	MessageBox("Error de Importacion","Existe informacion incorrect en el archivo origen", StopSign!)
	return
end if

if wf_existen_repetidos() then
	MessageBox("Error de Importacion","No se ha almacenado la información del plantel", StopSign!)
	return
end if

if wf_actualiza_doc_plantel() = 1 then
	MessageBox("Información Registrada ","Se ha registrado la información del plantel", Information!)
	this.enabled = false	
	MessageBox("Preparar Impresion","Favor de poner el papel correspondiente en la impresora", Information!)
	if wf_imprime_formato5() = 1 then
		MessageBox("Impresion Terminada ","Se han impreso satisfactoriamente los formatos generados", Information!)
	end if
	il_cve_doc_control_sep= 0
	il_cve_plantel= 0
	return
else
	MessageBox("Información Incorrecta ","NO se ha podido registrar la información del plantel", StopSign!)
	this.enabled = true
	return	
end if


end event

type dw_doc_sep_planteles from datawindow within w_carga_doc_sep_planteles
int X=33
int Y=534
int Width=3233
int Height=966
int TabOrder=50
string DataObject="d_ext_doc_sep_planteles"
boolean Border=false
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
m_menu_doc_planteles.dw = this

end event

event dberror;//Para que muestre el error del manejedor de base de datos

return 0
end event

type cb_1 from commandbutton within w_carga_doc_sep_planteles
int X=728
int Y=371
int Width=563
int Height=106
int TabOrder=30
boolean BringToTop=true
string Text="Importar Archivo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_null, ls_mensaje_import, ls_cuenta, ls_plantel, ls_doc_control_sep,ls_nombre_completo
long ll_res_import, ll_num_rows, ll_cuenta, ll_cve_plantel, ll_cve_doc_control_sep
long ll_row_plantel, ll_row_doc, ll_row_actual
integer li_res_continuar
string ls_filtro, ls_nivel_est_ant, ls_nivel_cursado
SetNull(ls_null)

ll_row_plantel = uo_w_planteles.dw_1.GetRow()
ll_row_doc = uo_w_doc_control_sep.dw_1.GetRow()

if ll_row_plantel <=0 then
	MessageBox("Plantel Invalido","Favor de seleccionar un plantel")
	return	
end if

if ll_row_doc <=0 then
	MessageBox("Documento Invalido","Favor de seleccionar un documento")
	return	
end if


ll_cve_plantel = uo_w_planteles.dw_1.object.cve_plantel[ll_row_plantel]
ll_cve_doc_control_sep = uo_w_doc_control_sep.dw_1.object.cve_doc_control_sep[ll_row_doc]
il_cve_plantel= ll_cve_plantel
il_cve_doc_control_sep = ll_cve_doc_control_sep

ls_plantel = uo_w_planteles.dw_1.object.plantel[ll_row_plantel]
ls_doc_control_sep = uo_w_doc_control_sep.dw_1.object.doc_control_sep[ll_row_doc]
is_plantel= ls_plantel
is_doc_control_sep= ls_doc_control_sep

if ll_cve_plantel =0 or ll_cve_plantel= 17 then
	MessageBox("Plantel Invalido","Favor de seleccionar otro Plantel")
	return	
end if

if ll_cve_doc_control_sep =0 then
	MessageBox("Documento Invalido","Favor de seleccionar otro Tipo de Documento")
	return	
end if


if ib_importacion_exitosa then
	li_res_continuar= MessageBox("Importacion previa Exitosa", "¿Desea Realizar otra importacion?", Question!, YesNo!)
 	if li_res_continuar <> 1 then
		return
	else
		dw_doc_sep_planteles.Reset()
	end if	
	ib_importacion_exitosa= false	
end if

if ll_cve_doc_control_sep < 3 then
	dw_doc_sep_planteles.DataObject = 'd_ext_doc_sep_planteles'
elseif ll_cve_doc_control_sep >= 3 then
	dw_doc_sep_planteles.DataObject = 'd_ext_doc_sep_planteles_2'
end if

dw_doc_sep_planteles.SetTransObject(gtr_sce)

ll_num_rows = dw_doc_sep_planteles.RowCount()

//dw_doc_sep_planteles.ImportFile ( filename {, startrow {, endrow {, startcolumn 	{, endcolumn {, dwstartcolumn } } } } } )
ll_res_import= dw_doc_sep_planteles.ImportFile(ls_null, 1)

//Long. Returns the number of rows that were imported if it succeeds and
//one of the following negative integers if an error occurs:
choose case ll_res_import
	case 0  
	ls_mensaje_import= "Fin de archivo; demasiados registros"
	case -1  
		ls_mensaje_import= "No hay registros"
	case -2  
		ls_mensaje_import= "Archivo vacio"
	case -3  
		ls_mensaje_import= "Argumento invalido"
	case -4  
		ls_mensaje_import= "Entrada invalid "
	case -5  
		ls_mensaje_import= "No es posible abrir el archivo"
	case -6  
		ls_mensaje_import= "No es posible cerrar el archivo"
	case -7  
		ls_mensaje_import= "Error leyendo el archivo de texto"
	case -8  
		ls_mensaje_import= "No es un archivo TXT "
	case -9  
		ls_mensaje_import= "El usuario cancelo la importacion"
	case -10 
		ls_mensaje_import= "Formato de archivo dBase no permitido (no es version 2 ni 3)"
end choose


if ll_res_import <=0 then
	MessageBox("Error de importacion", ls_mensaje_import, StopSign!)
	ib_importacion_exitosa= false
	cb_2.Enabled = false
else
	
	ls_mensaje_import= "Importacion efectuada correctamente"
	MessageBox("Importacion exitosa", ls_mensaje_import, Information!)
	ib_importacion_exitosa= true
	ll_num_rows = dw_doc_sep_planteles.RowCount()
	for ll_row_actual = 1 to ll_num_rows
		ls_nivel_est_ant =  dw_doc_sep_planteles.GetItemString(ll_row_actual,"nivel_est_ant" )
		ls_nivel_cursado =  dw_doc_sep_planteles.GetItemString(ll_row_actual,"nivel_cursado" )
		dw_doc_sep_planteles.SetItem(ll_row_actual,"nivel_est_ant", trim(ls_nivel_est_ant))
		dw_doc_sep_planteles.SetItem(ll_row_actual,"nivel_cursado", trim(ls_nivel_cursado))
	next
	ls_filtro = "cuenta >0"
	dw_doc_sep_planteles.SetFilter(ls_filtro)
	dw_doc_sep_planteles.Filter( )
	dw_doc_sep_planteles.SetSort("cuenta A")
	dw_doc_sep_planteles.Sort()
	cb_2.Enabled = true
end if


//dw_doc_sep_planteles.ImportFile ( filename {, startrow {, endrow {, startcolumn 	{, endcolumn {, dwstartcolumn } } } } } )
end event

