$PBExportHeader$w_pago_examen_especial.srw
$PBExportComments$Altas, bajas, despliegue, consulta y modificación de datos básicos de un aspirante.
forward
global type w_pago_examen_especial from window
end type
type cb_4 from commandbutton within w_pago_examen_especial
end type
type uo_nombre from uo_nombre_aspirante2 within w_pago_examen_especial
end type
type cb_3 from commandbutton within w_pago_examen_especial
end type
type cb_1 from commandbutton within w_pago_examen_especial
end type
type dw_solicitud from datawindow within w_pago_examen_especial
end type
type cb_2 from commandbutton within w_pago_examen_especial
end type
type dw_1 from datawindow within w_pago_examen_especial
end type
type dw_3 from datawindow within w_pago_examen_especial
end type
type dw_2 from datawindow within w_pago_examen_especial
end type
end forward

global type w_pago_examen_especial from window
integer x = 5
integer y = 4
integer width = 3470
integer height = 1660
boolean titlebar = true
string title = "Pago de Examen Especial"
string menuname = "m_menu_pago_examen_esp"
cb_4 cb_4
uo_nombre uo_nombre
cb_3 cb_3
cb_1 cb_1
dw_solicitud dw_solicitud
cb_2 cb_2
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
end type
global w_pago_examen_especial w_pago_examen_especial

type variables
string st_salones[]
int in_num_salones
boolean ib_nueva_insercion = false
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
public function integer wf_valida_folio (boolean ab_nueva_insercion)
end prototypes

public function long obten_foto (long cuenta, ref string foto);return 0
end function

public function integer wf_valida_folio (boolean ab_nueva_insercion);//wf_valida_folio()
//boolean 	ab_nueva_insercion

//uo_nombre.cbx_nuevo.Checked = FALSE
long ll_rowcount_3, ll_folio_test_vocacional, ll_folio, ll_rowcount_2
integer li_clv_ver, li_clv_per, li_anio, li_pago_exam
long al_ref_folio
integer ai_ref_clv_ver, ai_ref_clv_per, ai_ref_anio, li_existe_folio_test_vocacional
string as_ref_apaterno, as_ref_amaterno,	as_ref_nombre	
integer li_dw_2_Update, li_dw_3_Update
		
ll_rowcount_3 = dw_3.RowCount()
ll_rowcount_2 = dw_2.RowCount()

//Valida que ya se haya insertado un folio
if ab_nueva_insercion then
	//Si se desea guardar un registro exige que se este insertando
	if ll_rowcount_3 = 0 then
		MessageBox("Error de Inserción", "Favor de Insertar antes de actualizar",StopSign!)
		return -1
	end if
else
	//Si no es una inserción esta bien...
	if ll_rowcount_3 = 0 then
		return 0
	end if
end if

dw_3.AcceptText()

ll_folio_test_vocacional = dw_3.GetItemNumber(ll_rowcount_3,"folio_test_vocacional")
ll_folio = dw_3.GetItemNumber(ll_rowcount_3,"folio")
li_clv_ver = dw_3.GetItemNumber(ll_rowcount_3,"clv_ver")
li_clv_per = dw_3.GetItemNumber(ll_rowcount_3,"clv_per")
li_anio = dw_3.GetItemNumber(ll_rowcount_3,"anio")
li_pago_exam = dw_3.GetItemNumber(ll_rowcount_3,"pago_exam")

//Valida que no sea un folio nulo
if isnull(ll_folio_test_vocacional) then
		MessageBox("Folio Incorrecto", "Favor de escribir un folio válido",StopSign!)
	return -1
end if

//Valida que el folio sea positivo
if ll_folio_test_vocacional<=0 then
		MessageBox("Folio Incorrecto", "Favor de escribir un folio mayor que 0",StopSign!)
	return -1
end if


//Se solicitó comentar 31-mayo-2011
//li_existe_folio_test_vocacional = f_existe_folio_test_vocacional(ll_folio_test_vocacional, ll_folio, li_clv_ver, li_clv_per, li_anio, &
//al_ref_folio, ai_ref_clv_ver, ai_ref_clv_per, ai_ref_anio, as_ref_apaterno, as_ref_amaterno, as_ref_nombre)


////Valida que el folio sea positivo
//if li_existe_folio_test_vocacional >=1 then
//		MessageBox("Folio Duplicado", "El folio ["+string(ll_folio_test_vocacional)+"] ya ha sido asignado al aspirante:~n"+&
//		"["+as_ref_apaterno+" "+as_ref_amaterno+" "+as_ref_nombre+"] con folio ["+string(al_ref_folio)+"] "+&
//		"versión ["+string(ai_ref_clv_ver)+"] periodo ["+string(ai_ref_clv_per)+"] año ["+string(ai_ref_anio)+"]", StopSign!)
//	return -1
//end if

return 0
end function

on w_pago_examen_especial.create
if this.MenuName = "m_menu_pago_examen_esp" then this.MenuID = create m_menu_pago_examen_esp
this.cb_4=create cb_4
this.uo_nombre=create uo_nombre
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_solicitud=create dw_solicitud
this.cb_2=create cb_2
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.cb_4,&
this.uo_nombre,&
this.cb_3,&
this.cb_1,&
this.dw_solicitud,&
this.cb_2,&
this.dw_1,&
this.dw_3,&
this.dw_2}
end on

on w_pago_examen_especial.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_4)
destroy(this.uo_nombre)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_solicitud)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_2)
end on

event open;boolean lb_seguridad
//g_nv_security.fnv_secure_window(this)

lb_seguridad= true
//Seguridad via PFC
lb_seguridad= gnv_app.inv_security.of_SetSecurity(this)


IF NOT lb_seguridad THEN
	
//	   MessageBox("Security", "Unable to set security")
//	   Close(this)
END IF


this.x = 1
this.y = 1

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = true
uo_nombre.cbx_nuevo.enabled = true
end event

event doubleclicked;uo_nombre.cbx_nuevo.checked = false

int in_flag
in_flag = 0

if dw_2.event carga(long(uo_nombre.em_cuenta.text)) = 0 then
	in_flag = in_flag + 1
else
	dw_2.modify("lugar_nac.width=887")		
end if	

if in_flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if

//dw_3.setitem(1,"nombre",uo_nombre.dw_nombre_aspirante.getitemstring(1,"nombre"))
//dw_3.setitem(1,"apaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"apaterno"))
//dw_3.setitem(1,"amaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"amaterno"))
end event

type cb_4 from commandbutton within w_pago_examen_especial
integer x = 2542
integer y = 520
integer width = 407
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar Pago"
end type

event clicked;long ll_rowcount_2, ll_rowcount_3, ll_row_insert, ll_folio, ll_clv_carr, ll_folio_test_vocacional=0
integer li_clv_ver, li_clv_per, li_anio, li_pago_exam=1
real lr_promedio 
integer li_existe_pago_en_cajas, li_confirmacion
ll_rowcount_2 = dw_2.RowCount()
ll_rowcount_3 = dw_3.RowCount()

if ll_rowcount_2 = 0 then
	MessageBox("Error", "Favor de eligir un aspirante válido para cargar el pago con folio del test vocacional ",StopSign!)	
	return
end if	



if ll_rowcount_3 = 0 then

	ll_folio = dw_2.GetItemNumber(ll_rowcount_2,"folio")
	li_clv_ver = dw_2.GetItemNumber(ll_rowcount_2,"clv_ver")
	li_clv_per = dw_2.GetItemNumber(ll_rowcount_2,"clv_per")
	li_anio = dw_2.GetItemNumber(ll_rowcount_2,"anio")
	
	li_existe_pago_en_cajas = f_existe_pago_en_cajas(ll_folio, li_clv_ver, li_clv_per, li_anio)
	
	if	li_existe_pago_en_cajas>0 then
		li_confirmacion = MessageBox("Confirmación", "Se encontró que el aspirante realizó alguna vez el pago de examen en cajas~n"+&
												"¿Desea insertar la información del folio del test vocacional?", Question!, YesNo!,2	)												
		if li_confirmacion <>1 then
			MessageBox("Mensaje", "No se insertará el folio del test vocacional", Information!)
			return
		end if
	end if
	
	ll_row_insert = dw_3.InsertRow(0)	
	ll_clv_carr = dw_2.GetItemNumber(ll_rowcount_2,"clv_carr")
 	lr_promedio = dw_2.GetItemNumber(ll_rowcount_2,"promedio")
	dw_3.SetItem(ll_row_insert,"folio",ll_folio)
	dw_3.SetItem(ll_row_insert,"clv_ver",li_clv_ver)
	dw_3.SetItem(ll_row_insert,"clv_per",li_clv_per)
	dw_3.SetItem(ll_row_insert,"anio",li_anio)
	dw_3.SetItem(ll_row_insert,"clv_carr",ll_clv_carr)
	dw_3.SetItem(ll_row_insert,"promedio",lr_promedio)	 
	dw_3.SetItem(ll_row_insert,"folio_test_vocacional",ll_folio_test_vocacional)	 
	dw_3.SetItem(ll_row_insert,"pago_exam",li_pago_exam)	 
	ib_nueva_insercion = true
else 
	MessageBox("Error", "Ya se ha registrado un folio de test vocacional para el aspirante",StopSign!)
	return
end if

end event

type uo_nombre from uo_nombre_aspirante2 within w_pago_examen_especial
integer width = 3241
integer taborder = 10
boolean enabled = true
long backcolor = 1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante2::destroy
end on

type cb_3 from commandbutton within w_pago_examen_especial
event clicked pbm_bnclicked
integer x = 2971
integer y = 520
integer width = 361
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;//dw_2.event actualiza()
//uo_nombre.cbx_nuevo.Checked = FALSE
long ll_rowcount_3, ll_folio_test_vocacional, ll_folio, ll_rowcount_2
integer li_clv_ver, li_clv_per, li_anio, li_pago_exam
long al_ref_folio
integer ai_ref_clv_ver, ai_ref_clv_per, ai_ref_anio, li_existe_folio_test_vocacional
string as_ref_apaterno, as_ref_amaterno,	as_ref_nombre	
integer li_dw_2_Update, li_dw_3_Update

if wf_valida_folio(ib_nueva_insercion)<> -1 then


	ll_rowcount_3 = dw_3.RowCount()
	ll_rowcount_2 = dw_2.RowCount()
	li_pago_exam = dw_3.GetItemNumber(ll_rowcount_3,"pago_exam")

	dw_2.SetItem(ll_rowcount_2,"pago_exam",li_pago_exam)

	li_dw_2_Update = dw_2.Update(true)  
	li_dw_3_Update = dw_3.Update(true)

	if li_dw_2_Update=1 and	li_dw_3_Update= 1 then	
		COMMIT USING gtr_sadm;
		MessageBox("Confirmación", "Se ha almacenado la información del folio correctamente",Information!)
		ib_nueva_insercion = false
	else
		ROLLBACK USING gtr_sadm;
		MessageBox("Error de Actualización", "Favor de corregir la información",StopSign!)
		ib_nueva_insercion = true
	end if
else
	MessageBox("Error de Actualización", "Favor de corregir la información",StopSign!)
end if

return

//ll_folio_test_vocacional
//al_folio				long
//ai_clv_ver			integer
//ai_clv_per			integer
//ai_anio				integer
//al_ref_folio			long
//ai_ref_clv_ver		integer
//ai_ref_clv_per		integer
//ai_ref_anio			integer
//as_ref_apaterno		string
//as_ref_amaterno		string
//as_ref_nombre		string

end event

type cb_1 from commandbutton within w_pago_examen_especial
event clicked pbm_bnclicked
boolean visible = false
integer x = 2482
integer y = 588
integer width = 329
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;parent.event doubleclicked(0,0,0)
end event

type dw_solicitud from datawindow within w_pago_examen_especial
event constructor pbm_constructor
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
boolean visible = false
integer x = 3369
integer y = 1008
integer width = 3401
integer height = 1648
string dataobject = "dw_solicitud"
end type

event constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild carr1
getchild("x",carr1)
carr1.settransobject(gtr_sce)
carr1.retrieve()

settransobject(gtr_sadm)
end event

event primero;uo_nombre.event primero()
end event

event anterior;uo_nombre.event anterior()
end event

event siguiente;uo_nombre.event siguiente()
end event

event ultimo;uo_nombre.event ultimo()
end event

event carga;return retrieve(folio,gi_version,gi_periodo,gi_anio)
end event

type cb_2 from commandbutton within w_pago_examen_especial
event clicked pbm_bnclicked
boolean visible = false
integer x = 3383
integer y = 452
integer width = 827
integer height = 384
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Solicitud"
end type

event clicked;if dw_2.rowcount()>0 then
	dw_solicitud.event carga(dw_2.object.folio[1])
	openwithparm(conf_impr,dw_solicitud)
end if
end event

type dw_1 from datawindow within w_pago_examen_especial
boolean visible = false
integer x = 3369
integer y = 60
integer width = 832
integer height = 940
string dataobject = "dw_salonxcarrera"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sadm)
end event

event retrieverow;in_num_salones=in_num_salones+1
st_salones[in_num_salones]=object.salon[row]

end event

type dw_3 from datawindow within w_pago_examen_especial
integer x = 5
integer y = 772
integer width = 3333
integer height = 268
integer taborder = 40
string dataobject = "dw_aspiran_pago_examen_especial"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sadm)
end event

event itemchanged;long cuenta
string nombre

if row>0 and getcolumnname() = "cuenta" then
	cuenta=long(data)
	if cuenta<>0 then
		SELECT apaterno+' '+amaterno+' '+nombre
		INTO :nombre
		FROM alumnos
		WHERE alumnos.cuenta = :cuenta
		USING gtr_SCE;
		commit using gtr_SCE;
		
		if nombre="" then
			object.ya_inscri[row]=0
		else
			object.ya_inscri[row]=1
		end if
		messagebox(string(cuenta)+'-'+string(obten_digito(cuenta)),nombre)
	else
		object.ya_inscri[row]=0		
	end if
end if
end event

event dberror;MessageBox("Error de Actualización", sqlerrtext + "~n" + sqlsyntax, StopSign!)

return 0
end event

type dw_2 from datawindow within w_pago_examen_especial
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
integer x = 9
integer y = 420
integer width = 2533
integer height = 308
integer taborder = 30
string dataobject = "dw_aspiran_limitado"
end type

event primero();//event actualiza()
if wf_valida_folio(ib_nueva_insercion)<> -1 and not ib_nueva_insercion then
	uo_nombre.event primero()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if

end event

event anterior();//event actualiza()

if wf_valida_folio(ib_nueva_insercion)<> -1 and not ib_nueva_insercion then
	uo_nombre.event anterior()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if

end event

event siguiente();//event actualiza()

if wf_valida_folio(ib_nueva_insercion)<> -1 and not ib_nueva_insercion then
	uo_nombre.event siguiente()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if
end event

event ultimo();//event actualiza()

if wf_valida_folio(ib_nueva_insercion)<> -1  and not ib_nueva_insercion then
	uo_nombre.event ultimo()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if
end event

event actualiza();//datetime ldFechaNace
//int respuesta, liAnio, liPeriodo, liVersion
//long fol
//string lsApaterno, lsAmaterno, lsNombre
//
///*Cuando se dispara el evento actualiza...*/
//	/*Acepta el texto de la última columna editada*/
//	w_pago_examen_especial.uo_nombre.dw_nombre_aspirante.AcceptText()
//	AcceptText()
//	dw_3.AcceptText()
//	/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
//	if (ModifiedCount()+dw_3.ModifiedCount()) > 0 Then
//		/*Pregunta si se desean guardar los cambios hechos*/
//		//respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
//		respuesta=1
//		if respuesta = 1 then
//			if object.salon[1]="INVA" then
//				rollback using gtr_sadm;
//				messagebox("Carrera Inválida","Deberás cambiarla ya que no tiene salones asignados")
//			else
//				if w_pago_examen_especial.uo_nombre.cbx_nuevo.text = "Nuevo" then
//				
//					tit1=""
//					DO UNTIL tit1<>""
//						open(w_folio_ceneval)
//						fol=long(tit1)
//					LOOP
//					tit1=uo_nombre.uo_1.dw_ver.object.version[uo_nombre.uo_1.dw_ver.getrow()]+' '+&
//						uo_nombre.uo_1.dw_per.object.periodo[uo_nombre.uo_1.dw_per.getrow()]+' '+&
//						uo_nombre.uo_1.em_ani.text
//					
//					w_pago_examen_especial.uo_nombre.em_cuenta.text = string(fol)
//					w_pago_examen_especial.uo_nombre.em_digito.text = obten_digito(fol)
//					object.folio[1]=fol
//					object.clv_ver[1]=gi_version
//					object.clv_per[1]=gi_periodo
//					object.anio[1]=gi_anio
//					object.ing_per[1]=gi_periodo
//					object.ing_anio[1]=gi_anio
//					object.sol_per[1]=gi_periodo
//					object.sol_anio[1]=gi_anio
//					dw_3.object.folio[1]=fol
//					dw_3.object.clv_ver[1]=gi_version
//					dw_3.object.clv_per[1]=gi_periodo
//					dw_3.object.anio[1]=gi_anio
//				
//				end if /*w_pago_examen_especial.uo_nombre.cbx_nuevo.text = "Nuevo"*/
//			
//				/*Checa que los renglones cumplan con las reglas de validación*/
//				if update(true) = 1 then
//					dw_3.update(true)
//					/*Si es asi, guardalo en la tabla y avisa.*/
//					commit using gtr_sadm;
////					liAnio
////					liPeriodo
////					liVersion
////					lsApaterno
////					lsAmaterno
////					lsNombre
//					//messagebox("Información","Se han guardado los cambios")			
//					w_pago_examen_especial.uo_nombre.cbx_nuevo.text = "Modificar"
//				else
//					/*De lo contrario, desecha los cambios (todos) y avisa*/
//					rollback using gtr_sadm;
//					messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
//				end if
//			
//			end if /*object.salon[1]="INVA"*/
//		else
//			/*De lo contrario, solo avisa que no se guardó nada.*/
//			messagebox("Información","No se han guardado los cambios")
//		end if /*respuesta = 1*/
//	end if /*(ModifiedCount()+dw_3.ModifiedCount()) > 0*/
end event

event nuevo;event actualiza()

if gi_version<>99 then
	uo_nombre.cbx_nuevo.text = "Nuevo"

	uo_nombre.cbx_nuevo.checked = true

	uo_nombre.em_cuenta.text = ""
	uo_nombre.em_digito.text = ""

	event carga(1)
	insertrow(getrow())
	dw_3.insertrow(dw_3.getrow())

	uo_nombre.dw_nombre_aspirante.event carga(1)
	uo_nombre.dw_nombre_aspirante.insertrow(uo_nombre.dw_nombre_aspirante.getrow())

	object.salon[1]="INVA"
	object.num_paq[1]=0
	object.status[1]=0
	object.pago_exam[1]=0
	object.pago_insc[1]=0
	object.clv_carr[1]=0
	dw_3.object.ya_inscri[1]=0
	dw_3.object.cuenta[1]=0
	dw_3.object.sexo[1]='M'
	dw_3.object.religion[1]=2

	dw_3.object.lugar_nac[1]=1
	dw_3.object.nacional[1]=1
	dw_3.object.edo_civil[1]=0
	dw_3.object.trabajo[1]=0
	dw_3.object.transporte[1]=2
	uo_nombre.dw_nombre_aspirante.setfocus()
end if
end event

event borra();long fol
int carr,num_paq, li_num_error
string salon_ant, ls_error

if rowcount()>0 then
	if w_pago_examen_especial.uo_nombre.cbx_nuevo.checked then
		if RowCount()>0 then
			if object.pago_exam[1]=0 then
				if object.pago_insc[1]=0 then
					carr=object.clv_carr[1]
					fol=object.folio[1]
					salon_ant=object.salon[1]
					num_paq=object.num_paq[1]
		
					if num_paq>0 then
						UPDATE paquetes
						SET inscritos = inscritos-1
						WHERE paquetes.num_paq = :num_paq
						USING gtr_SADM;
						li_num_error = gtr_SADM.SQLCode
						ls_error= gtr_SADM.SQLErrtext
						if li_num_error = 0 then
							COMMIT USING gtr_SADM;
						else 
							ROLLBACK USING gtr_SADM;
							MessageBox("Error en el update de paquetes",ls_error)
						end if
					end if
					
					DELETE FROM bita_bachi
					WHERE (bita_bachi.folio=:fol) AND
						(bita_bachi.clv_ver=:gi_version) AND
						(bita_bachi.clv_per=:gi_periodo) AND
						(bita_bachi.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_bachi",ls_error)
					end if

					
					DELETE FROM bita_res
					WHERE (bita_res.folio=:fol) AND
						(bita_res.clv_ver=:gi_version) AND
						(bita_res.clv_per=:gi_periodo) AND
						(bita_res.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_res",ls_error)
					end if

					
					DELETE FROM bita_carr
					WHERE (bita_carr.folio=:fol) AND
						(bita_carr.clv_ver=:gi_version) AND
						(bita_carr.clv_per=:gi_periodo) AND
						(bita_carr.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_carr",ls_error)
					end if
					
					DELETE FROM padres
					WHERE (padres.folio=:fol) AND
						(padres.clv_ver=:gi_version) AND
						(padres.clv_per=:gi_periodo) AND
						(padres.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de padres",ls_error)
					end if
			
			
					// Si fue un apartado de lugar no hay que hacer la disminución
	            if gi_version <> 0 then		
 						UPDATE carr_sal
						SET folios = folios -1
						WHERE (clv_ver= :gi_version) AND
								(clv_per= :gi_periodo) AND
								(anio= :gi_anio) AND
								(salon= :salon_ant) AND
								(clv_carr= :carr)
						USING gtr_SADM;
						li_num_error = gtr_SADM.SQLCode
						ls_error= gtr_SADM.SQLErrtext
						if li_num_error = 0 then
							COMMIT USING gtr_SADM;
						else 
							ROLLBACK USING gtr_SADM;
							MessageBox("Error en el update de carr_sal",ls_error)
						end if
					end if
			
			
					DELETE FROM cali_sec
					WHERE (cali_sec.folio=:fol) AND
						(cali_sec.clv_ver=:gi_version) AND
						(cali_sec.clv_per=:gi_periodo) AND
						(cali_sec.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de cali_sec",ls_error)
					end if
					
					
					DELETE FROM cali_are
					WHERE (cali_are.folio=:fol) AND
						(cali_are.clv_ver=:gi_version) AND
						(cali_are.clv_per=:gi_periodo) AND
						(cali_are.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de cali_are",ls_error)
					end if

					
					dw_3.deleterow(1)		
					if dw_3.update(true) = 1 then
						deleterow(1)		
						if update(true) = 1 then
							commit using gtr_SADM;
						end if
					end if
				else
					messagebox("No se puede borrar","Cajas no le ha hecho el rembolso de su Inscripción")
				end if
			else
				messagebox("No se puede borrar","Cajas no le ha hecho el rembolso de su Examen")
			end if
		end if
	end if
end if
end event

event carga;/*event actualiza()*/
integer li_version

li_version = gi_sol_version

if gi_version = 99 then
	dw_3.retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)
end if

//dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)


if gi_version = 99 then
   return retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	return retrieve(folio,gi_version,gi_periodo,gi_anio)
end if

//return retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

event itemchanged;long columna,fol
int carr_act,carr_ant,cupo,cont,usados
string salon_ant
datetime hoy
real prom_ant,prom_nue,porc_uso_salon

columna = getcolumn()

//if columna=2 then
//	em_carrera.event modified()
//end if

if columna=3 then

	uo_nombre.cbx_nuevo.checked = true

	hoy=datetime(today(),now())
	fol=object.folio[1]
	prom_ant=object.promedio[1]
	prom_nue=real(data)
	
	INSERT INTO bita_bachi  
		( folio, clv_ver, clv_per, anio, fecha, nuevo, anterior, usuario )  
	VALUES ( :fol,:gi_version,:gi_periodo,:gi_anio,:hoy,:prom_nue,:prom_ant,:gs_usuario)
	using gtr_SADM;
	commit using gtr_sadm;

	event actualiza()
	
end if
end event

event constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

settransobject(gtr_sadm)
m_menu_pago_examen_esp.dw = this
end event

event retrieveend;//if rowcount>0 then
//	em_carrera.text=string(object.clv_carr[1])
//else
//	em_carrera.text=""
//end if
end event

event dberror;MessageBox("Error de Actualización", sqlerrtext + "~n" + sqlsyntax, StopSign!)

return 0
end event

