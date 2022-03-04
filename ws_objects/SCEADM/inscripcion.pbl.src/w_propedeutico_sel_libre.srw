$PBExportHeader$w_propedeutico_sel_libre.srw
forward
global type w_propedeutico_sel_libre from window
end type
type dw_prope from datawindow within w_propedeutico_sel_libre
end type
type sle_examen from singlelineedit within w_propedeutico_sel_libre
end type
type sle_folio from singlelineedit within w_propedeutico_sel_libre
end type
type cbx_perdes from checkbox within w_propedeutico_sel_libre
end type
type dw_upd from datawindow within w_propedeutico_sel_libre
end type
type cb_importar from commandbutton within w_propedeutico_sel_libre
end type
type cb_exportar from commandbutton within w_propedeutico_sel_libre
end type
type cb_eliminar from commandbutton within w_propedeutico_sel_libre
end type
type cb_guardar from commandbutton within w_propedeutico_sel_libre
end type
type cb_cargar from commandbutton within w_propedeutico_sel_libre
end type
type cb_salir from commandbutton within w_propedeutico_sel_libre
end type
type uo_per_ani from uo_per_ani_admision within w_propedeutico_sel_libre
end type
type cb_asignar from commandbutton within w_propedeutico_sel_libre
end type
type dw_propedéuticos from datawindow within w_propedeutico_sel_libre
end type
type gb_1 from groupbox within w_propedeutico_sel_libre
end type
type gb_2 from groupbox within w_propedeutico_sel_libre
end type
type gb_3 from groupbox within w_propedeutico_sel_libre
end type
type gb_4 from groupbox within w_propedeutico_sel_libre
end type
type gb_6 from groupbox within w_propedeutico_sel_libre
end type
type uo_per_ani2 from uo_per_ani_admision within w_propedeutico_sel_libre
end type
type dw_crit from datawindow within w_propedeutico_sel_libre
end type
type gb_5 from groupbox within w_propedeutico_sel_libre
end type
type gb_7 from groupbox within w_propedeutico_sel_libre
end type
end forward

global type w_propedeutico_sel_libre from window
integer width = 5376
integer height = 2468
boolean titlebar = true
string title = "Asignación de cursos Propedéuticos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_cargar ( )
dw_prope dw_prope
sle_examen sle_examen
sle_folio sle_folio
cbx_perdes cbx_perdes
dw_upd dw_upd
cb_importar cb_importar
cb_exportar cb_exportar
cb_eliminar cb_eliminar
cb_guardar cb_guardar
cb_cargar cb_cargar
cb_salir cb_salir
uo_per_ani uo_per_ani
cb_asignar cb_asignar
dw_propedéuticos dw_propedéuticos
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_6 gb_6
uo_per_ani2 uo_per_ani2
dw_crit dw_crit
gb_5 gb_5
gb_7 gb_7
end type
global w_propedeutico_sel_libre w_propedeutico_sel_libre

type variables
INTEGER ie_periodo, ie_anio , le_periodo2, le_anio2 
Integer ii_val = 0 , ii_row
uo_paquetes_materias iuo_paquetes_materias


end variables

event ue_cargar();Integer  ll_exa, ll_version 
Long ll_folio 
String ls_prop


dw_crit.AcceptText ( )

//ll_folio  = dw_crit.object.folio[dw_crit.getrow()] 
ll_folio =Long(sle_folio.text)
ll_version = dw_crit.object.version[dw_crit.getrow()] 
ls_prop = dw_prope.object.cve[dw_prope.getrow()] 

ll_exa = long(sle_examen.text)

if ll_folio = 0  then ll_folio = -1
if isnull(ll_version) then ll_version = -1
if ll_exa = 0  then ll_exa = -1
if isnull(le_periodo2) then le_periodo2 = -1
if isnull( le_anio2) then  le_anio2 = -1

choose case ls_prop
	case 'T'
		dw_propedéuticos.DataObject = 'd_propedeutico_admision' 
		dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
		IF cbx_perdes.checked = true then
			  dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , le_periodo2 , le_anio2)
		else
			dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , -1 , -1)
		End if
	case 'S'
         dw_propedéuticos.DataObject = 'd_propedeutico_admision_sp' 
		dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
		IF cbx_perdes.checked = true then
			  dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , le_periodo2 , le_anio2)
		else
			dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , -1 , -1)
		End if
    CASE 'M' , 'Q', 'E'
             dw_propedéuticos.DataObject = 'd_propedeutico_admision_xp' 
			dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
			IF cbx_perdes.checked = true then
				  dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , le_periodo2 , le_anio2, ls_prop)
			else
				dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , -1 , -1, ls_prop)
			End if
End choose


end event

on w_propedeutico_sel_libre.create
this.dw_prope=create dw_prope
this.sle_examen=create sle_examen
this.sle_folio=create sle_folio
this.cbx_perdes=create cbx_perdes
this.dw_upd=create dw_upd
this.cb_importar=create cb_importar
this.cb_exportar=create cb_exportar
this.cb_eliminar=create cb_eliminar
this.cb_guardar=create cb_guardar
this.cb_cargar=create cb_cargar
this.cb_salir=create cb_salir
this.uo_per_ani=create uo_per_ani
this.cb_asignar=create cb_asignar
this.dw_propedéuticos=create dw_propedéuticos
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_6=create gb_6
this.uo_per_ani2=create uo_per_ani2
this.dw_crit=create dw_crit
this.gb_5=create gb_5
this.gb_7=create gb_7
this.Control[]={this.dw_prope,&
this.sle_examen,&
this.sle_folio,&
this.cbx_perdes,&
this.dw_upd,&
this.cb_importar,&
this.cb_exportar,&
this.cb_eliminar,&
this.cb_guardar,&
this.cb_cargar,&
this.cb_salir,&
this.uo_per_ani,&
this.cb_asignar,&
this.dw_propedéuticos,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_6,&
this.uo_per_ani2,&
this.dw_crit,&
this.gb_5,&
this.gb_7}
end on

on w_propedeutico_sel_libre.destroy
destroy(this.dw_prope)
destroy(this.sle_examen)
destroy(this.sle_folio)
destroy(this.cbx_perdes)
destroy(this.dw_upd)
destroy(this.cb_importar)
destroy(this.cb_exportar)
destroy(this.cb_eliminar)
destroy(this.cb_guardar)
destroy(this.cb_cargar)
destroy(this.cb_salir)
destroy(this.uo_per_ani)
destroy(this.cb_asignar)
destroy(this.dw_propedéuticos)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_6)
destroy(this.uo_per_ani2)
destroy(this.dw_crit)
destroy(this.gb_5)
destroy(this.gb_7)
end on

event open;iuo_paquetes_materias = CREATE uo_paquetes_materias 

//dw_propedéuticos.SETROWFOCUSINDICATOR(Hand!)
dw_propedéuticos.SETTRANSOBJECT(gtr_sadm)  
dw_upd.SETTRANSOBJECT(gtr_sadm)  
dw_crit.SETTRANSOBJECT(gtr_sadm)  
dw_prope.SETTRANSOBJECT(gtr_sadm)  
dw_crit.insertrow(0)
dw_prope.retrieve()


//Data store de los datos 

gds_datos           = Create n_ds 
gds_datos.DataObject = 'dddw_propedeutico' 
gds_datos.SetTransObject( gtr_sadm ) 

gds_datos.retrieve()

THIS.uo_per_ani.TRIGGEREVENT("ue_modifica")
THIS.uo_per_ani2.TRIGGEREVENT("ue_modifica")
//ue_per_ani.ie_periodo = 0
//gi_anio = 2021

le_periodo = this.uo_per_ani.ie_periodo
le_anio = this.uo_per_ani.ie_anio

le_periodo2 = this.uo_per_ani2.ie_periodo
le_anio2 = this.uo_per_ani2.ie_anio
end event

event close;IF ISVALID(gtr_sfeb) THEN 
	DISCONNECT USING gtr_sfeb; 
END IF
end event

type dw_prope from datawindow within w_propedeutico_sel_libre
integer x = 1682
integer y = 128
integer width = 805
integer height = 108
integer taborder = 40
string title = "none"
string dataobject = "dddw_propedeutico_todos"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_examen from singlelineedit within w_propedeutico_sel_libre
integer x = 2994
integer y = 372
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_folio from singlelineedit within w_propedeutico_sel_libre
integer x = 315
integer y = 380
integer width = 338
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_perdes from checkbox within w_propedeutico_sel_libre
integer x = 3333
integer y = 116
integer width = 873
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filtrar por Periodo de Registro"
end type

type dw_upd from datawindow within w_propedeutico_sel_libre
boolean visible = false
integer x = 2766
integer y = 56
integer width = 859
integer height = 144
integer taborder = 40
string title = "none"
string dataobject = "d_dds_update_asignacion_prope"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_importar from commandbutton within w_propedeutico_sel_libre
integer x = 3922
integer y = 380
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar"
end type

event clicked;n_ds                     lds_datos

//Data store de los datos 

lds_datos           = Create n_ds 
lds_datos.DataObject = 'd_ext_import_prop' 
lds_datos.SetTransObject( gtr_sadm ) 

String ls_file ,  ls_nom , ls_apat , ls_amat , ls_carrera , ls_prop
Long ll_rows , ll_i , ll_new , ll_folio , ll_cvevarr, ll_find

setnull(ls_file)

ll_rows = lds_datos.ImportFile(ls_file ) 

ll_rows = lds_datos.rowcount( ) 

 If ll_rows <= 0 Then 
	 MessageBox( "Aviso", "El archivo no contiene información para importar..", Question! ) 
      destroy lds_datos 
	  Return  
else
	   for ll_i = 1 to lds_datos.rowcount()
			ll_folio =  lds_datos.object.folio[ll_i]
			ls_prop =  lds_datos.object.propedeutico[ll_i]
			
			dw_upd.retrieve(ll_folio, 	ls_prop)
		 if  dw_upd.rowcount() < 1 then 
		
			
		ll_find = dw_propedéuticos.Find( "aspiran_folio = " + String( ll_folio ) +" and propedeutico = '" +  ls_prop  +"'  ", 1, dw_propedéuticos.Rowcount()) 


 				if ll_find < 1 then
					
					select nombre , apaterno , amaterno 
					into :ls_nom , :ls_apat , :ls_amat
					from general 
					where folio =  :ll_folio
					USING gtr_sadm;
					
					if sqlca.sqlcode = 0 then
							select a.clv_carr , c.carrera
							  into :ll_cvevarr , :ls_carrera
							 from aspiran  a , v_carreras c
							where a.clv_carr = c.cve_carrera and
										 a.folio = :ll_folio
							USING gtr_sadm;
							
								if sqlca.sqlcode = 0 then
									 ll_new = dw_propedéuticos.insertrow(0)
									 dw_propedéuticos.object.aspiran_folio[ll_new] = lds_datos.object.folio[ll_i]
									 dw_propedéuticos.object.general_cuenta[ll_new] = lds_datos.object.cuenta[ll_i]
									dw_propedéuticos.object.general_nombre[ll_new] = ls_nom + ' ' + ls_apat + ' ' + ls_amat
									dw_propedéuticos.object.aspiran_clv_carr[ll_new] = ll_cvevarr 
									dw_propedéuticos.object.v_carreras_carrera[ll_new] = ls_carrera
									dw_propedéuticos.object.propedeutico[ll_new] = lds_datos.object.propedeutico[ll_i]
								end if
				end if
			end if
		end if
		Next
 End If 
end event

type cb_exportar from commandbutton within w_propedeutico_sel_libre
integer x = 3502
integer y = 380
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;If dw_propedéuticos.RowCount() > 0 Then 
                  // Exportar a Excel 
              dw_propedéuticos.SaveAs( "", Excel!, False ) 
Else 
               MessageBox( 'Aviso', 'No existe información para Exportar!', StopSign! ) 
End If 


end event

type cb_eliminar from commandbutton within w_propedeutico_sel_libre
integer x = 4672
integer y = 832
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;String ls_null
setnull(ls_null)
if dw_propedéuticos.rowcount() > 0 then
//		dw_propedéuticos.deleterow(dw_propedéuticos.getrow())
  dw_propedéuticos.object.propedeutico[dw_propedéuticos.getrow()] = ls_null
//    dw_propedéuticos.object.id_prop[dw_propedéuticos.getrow()] = ls_null
else
	MessageBox("Aviso", "Debes Consultar Antes de Agregar.", StopSign!)
	return
end if
//
end event

type cb_guardar from commandbutton within w_propedeutico_sel_libre
integer x = 4672
integer y = 1184
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;Long ll_i , ll_folio , 	ll_new , ll_upd
String ls_prope, ls_idprop , 	 ls_idp
Integer li_find


dw_propedéuticos.accepttext()
For ll_i = 1 to dw_propedéuticos.rowcount()
	 ll_folio = dw_propedéuticos.object.aspiran_folio[  ll_i ]
	 ls_prope = dw_propedéuticos.object.propedeutico[  ll_i ]
	 ls_idp = dw_propedéuticos.object.id_prop[  ll_i ]
 
 	if   ls_idp <> '' then
	 gds_datos.SetFilter("id_prop = '"+  ls_idp +"'" )
		gds_datos.Filter()
		if gds_datos.rowcount() > 0 then
			 ls_idprop = gds_datos.object.id_prop[1]
		else
				gds_datos.SetFilter('')
			    gds_datos.Filter()
				 
				gds_datos.SetFilter("descripcion = '"+ ls_prope +"'" )
				gds_datos.Filter()
				if gds_datos.rowcount() > 0 then
			 		ls_idprop = gds_datos.object.id_prop[1]
				 end if
		end if 
	end if
	 dw_upd.retrieve(ll_folio, ls_idprop)
	 if  dw_upd.rowcount() > 0 then
		 if  isnull(ls_prope) or  ls_prope = '' then
			 dw_upd.deleterow(1)
			 If dw_upd.update() = -1 then
				Rollback  USING gtr_sadm;
				MessageBox( 'Aviso', 'Error al guardar los datos, Verifique.', StopSign! )
				Return -1
			else
				  Commit   USING gtr_sadm;
				  ll_upd = ll_upd + 1
//				 MESSAGEBOX("Aviso", "La información ha sido actualizada con éxito")
			End if
		 end if
	else
		if ls_prope <> ''   then
		    dw_upd.reset()
			 li_find =  gds_datos.Find( "id_prop = '" + String(  ls_prope ) +"'  ", 1, 	 gds_datos.Rowcount()) 
			 
			 if li_find > 0 then
			ll_new =  dw_upd.insertrow(1)
		     dw_upd.object.cuenta[ll_new] =  dw_propedéuticos.object.general_cuenta[   ll_i ]
			 dw_upd.object.folio[ll_new] =  dw_propedéuticos.object.aspiran_folio[    ll_i ]
		      dw_upd.object.periodo[ll_new] =  le_periodo
			 dw_upd.object.anio[ll_new] =   le_anio 
		      dw_upd.object.cve_carrera[ll_new] =  dw_propedéuticos.object.aspiran_clv_carr[   ll_i ]
			  dw_upd.object.porcentaje_aciertos[ll_new] = 0
			  dw_upd.object.id_prop[ll_new] =    ls_prope
			  dw_upd.object.modificado[ll_new] = 'M'
			
			 If dw_upd.update() = -1 then
				Rollback  USING gtr_sadm;
				MessageBox( 'Aviso', 'Error al guardad los datos, Verifique.', StopSign! )
				Return -1
			else
				  Commit   USING gtr_sadm;
				  		  ll_upd = ll_upd + 1
//				  MESSAGEBOX("Aviso", "La información ha sido actualizada con éxito")
			End if
			end if 
		else
			 dw_upd.retrieve(ll_folio, 	 ls_idprop)
			 If dw_upd.rowcount() > 0 then
			 dw_upd.deleterow(1)
					 If dw_upd.update() = -1 then
						Rollback  USING gtr_sadm;
						MessageBox( 'Aviso', 'Error al guardar los datos, Verifique.', StopSign! )
						Return -1
					else
						  Commit   USING gtr_sadm;
						   ll_upd = ll_upd + 1
//						 MESSAGEBOX("Aviso", "La información ha sido borrada con éxito")
					End if
			End if
		end if
	 end if
dw_upd.reset()
	gds_datos.SetFilter('')
	gds_datos.Filter()
	 ls_idprop = ''
	 	 ls_idp = ''
Next

If ll_upd > 0 then
	MESSAGEBOX("Aviso", "Se Actualizaron  " + string (ll_upd)+ " registros con éxito.")
	parent.event ue_cargar()
else
	MESSAGEBOX("Aviso", "No Existe Informaciòn por Guardar.")
//	parent.event ue_cargar()
end if

end event

type cb_cargar from commandbutton within w_propedeutico_sel_libre
integer x = 2793
integer y = 96
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;Integer  ll_exa, ll_version 
Long ll_folio 
String ls_prop

le_periodo = parent.uo_per_ani.ie_periodo
le_anio = parent.uo_per_ani.ie_anio

le_periodo2 = parent.uo_per_ani2.ie_periodo
le_anio2 = parent.uo_per_ani2.ie_anio

dw_crit.AcceptText ( )
dw_prope.AcceptText ( )

//ll_folio  = dw_crit.object.folio[dw_crit.getrow()] 
ll_folio =Long(sle_folio.text)
ll_version = dw_crit.object.version[dw_crit.getrow()] 
ls_prop = dw_prope.object.cve[dw_prope.getrow()] 

ll_exa = long(sle_examen.text)

if ll_folio = 0  then ll_folio = -1
if isnull(ll_version) then ll_version = -1
if ll_exa = 0  then ll_exa = -1
if isnull(le_periodo2) then le_periodo2 = -1
if isnull( le_anio2) then  le_anio2 = -1

choose case ls_prop
	case 'T'
		dw_propedéuticos.DataObject = 'd_propedeutico_admision' 
		dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
		IF cbx_perdes.checked = true then
			  dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , le_periodo2 , le_anio2)
		else
			dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , -1 , -1)
		End if
	case 'S'
         dw_propedéuticos.DataObject = 'd_propedeutico_admision_sp' 
		dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
		IF cbx_perdes.checked = true then
			  dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , le_periodo2 , le_anio2)
		else
			dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , -1 , -1)
		End if
    CASE 'M' , 'Q', 'E'
             dw_propedéuticos.DataObject = 'd_propedeutico_admision_xp' 
			dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
			IF cbx_perdes.checked = true then
				  dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , le_periodo2 , le_anio2, ls_prop)
			else
				dw_propedéuticos.RETRIEVE(le_periodo,  le_anio , ll_folio , ll_exa , ll_version , -1 , -1, ls_prop)
			End if
End choose




end event

type cb_salir from commandbutton within w_propedeutico_sel_libre
integer x = 4672
integer y = 1344
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 

end event

type uo_per_ani from uo_per_ani_admision within w_propedeutico_sel_libre
event destroy ( )
integer x = 142
integer y = 88
integer taborder = 20
boolean enabled = true
long backcolor = 67108864
end type

on uo_per_ani.destroy
call uo_per_ani_admision::destroy
end on

event ue_modifica;call super::ue_modifica;
PARENT.ie_periodo = THIS.ie_periodo
PARENT.ie_anio = THIS.ie_anio
dw_propedéuticos.reset()

le_periodo = parent.uo_per_ani.ie_periodo
le_anio = parent.uo_per_ani.ie_anio

le_periodo2 = parent.uo_per_ani2.ie_periodo
le_anio2 = parent.uo_per_ani2.ie_anio
end event

type cb_asignar from commandbutton within w_propedeutico_sel_libre
integer x = 4672
integer y = 676
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;INTEGER ll_new
Long ll_folio

le_periodo = parent.uo_per_ani.ie_periodo
le_anio = parent.uo_per_ani.ie_anio

//if (conecta_bd_n_tr(gtr_sfeb,gs_sfeb,gs_usuario,gs_password) <> 1) then
//	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de becas.", StopSign!)
//	return
//end if
//
if dw_propedéuticos.rowcount() > 0 then
	ll_folio = dw_propedéuticos.object.aspiran_folio[dw_propedéuticos.getrow()]
		

	ll_new = dw_propedéuticos.insertrow(dw_propedéuticos.getrow() + 1)
	 dw_propedéuticos.object.aspiran_folio[ll_new] = ll_folio
		dw_propedéuticos.object.general_nombre[ll_new] = dw_propedéuticos.object.general_nombre[dw_propedéuticos.getrow()]
		dw_propedéuticos.object.aspiran_clv_carr[ll_new] = dw_propedéuticos.object.aspiran_clv_carr[dw_propedéuticos.getrow()]
		dw_propedéuticos.object.v_carreras_carrera[ll_new] = dw_propedéuticos.object.v_carreras_carrera[dw_propedéuticos.getrow()]
	    dw_propedéuticos.object.general_cuenta[ll_new] = dw_propedéuticos.object.general_cuenta[dw_propedéuticos.getrow()]
	  else
	MessageBox("Aviso", "Debes Consultar Antes de Agregar.", StopSign!)
	return
end if
//
//// Se carga la información pata todas las carreras. 
//iuo_paquetes_materias.f_carga_aspirantes( le_periodo,  le_anio, 9999) 
//
//// Se llama la ejecución de la asignación de propedéuticos. 
//iuo_paquetes_materias.f_asigna_propedeuticos( 9999)
//
//
//dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
//dw_propedéuticos.RETRIEVE(le_periodo,  le_anio)
//
end event

type dw_propedéuticos from datawindow within w_propedeutico_sel_libre
integer x = 50
integer y = 564
integer width = 4448
integer height = 1752
integer taborder = 10
string title = "Estimación de Propedéuticos"
string dataobject = "d_propedeutico_admision"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;
this.selectrow(0 , false)
this.selectrow(currentrow , true)



end event

event itemchanged;Long ll_prope , ll_find , ll_folio , ll_i , ll_folio2
string ls_prope, ls_null ,  ls_prope2,    ls_desc
setnull(ls_null)


this.accepttext()

ll_folio = dw_propedéuticos.object.aspiran_folio[row]
ls_prope = dw_propedéuticos.object.propedeutico[row]



	gds_datos.SetFilter('')
	gds_datos.Filter()
	
 gds_datos.SetFilter("descripcion = '"+ ls_prope +"'" )
gds_datos.Filter()
if gds_datos.rowcount() > 0 then
	 ls_desc = gds_datos.object.descripcion[1]
else 
		gds_datos.SetFilter('')
		 gds_datos.Filter()
		 
		gds_datos.SetFilter("id_prop = '"+ ls_prope +"'" )
		gds_datos.Filter()
		if gds_datos.rowcount() > 0 then
			 ls_desc = gds_datos.object.descripcion[1]
		 end if
end if 

 dw_upd.retrieve(ll_folio, ls_prope)
 if  dw_upd.rowcount() > 0 then
	MessageBox("Aviso", "El Curso Propedeutico " +    ls_desc + " ya Existe para el Folio " + string(ll_folio) + " ." , StopSign!)
	  dw_propedéuticos.object.propedeutico[row] = ls_null
	 return 1
end if	


choose case dwo.name
	case 'propedeutico'
		
		    for ll_i = 1 to this.rowcount()
				If ll_i <> row then
					ll_folio2 = dw_propedéuticos.object.aspiran_folio[ll_i]
					ls_prope2 = dw_propedéuticos.object.id_prop[ll_i]
					
				
//				     ls_desc = dw_propedéuticos.object.propedeutico.object.descripcion[ll_i]
					if ll_folio = ll_folio2 and ls_prope = ls_prope2 then
							MessageBox("Aviso", "El Curso Propedeutico " +    ls_desc + " ya Existe para el Folio " + string(ll_folio) + " ." , StopSign!)
						    dw_propedéuticos.object.propedeutico[row] = ls_null
							 return 1
					end if
				else 
				 dw_propedéuticos.object.id_prop[row] = ls_prope 
			    End if 
			 Next 

end choose

end event

event itemerror;	 return 1
end event

event clicked;Long ll_i 

this.getrow() 
this.accepttext()
this.setredraw(false )
this.selectrow(0 , false)
this.selectrow(row , true)

for ll_i = 1 to this.rowcount()
	if row <> ll_i then
	this.selectrow( ll_i , false)
	end if 
next 

this.setredraw(true )


choose case dwo.name
	case 'aspiran_folio_t'
		   if ii_val = 0 then
	         this.setsort('aspiran_folio A')
		     this.sort()
			  ii_val = 1 
		else
			 this.setsort('aspiran_folio D')
		     this.sort()
			   ii_val = 0
		end if
   case 'cuenta_t'
	   if ii_val = 0 then
	         this.setsort('general_cuenta A')
		     this.sort()
			  ii_val = 1 
		else
		   this.setsort('general_cuenta D')
		     this.sort()
			   ii_val = 0
		end if
   case 'general_nombre_t'
		   if ii_val = 0 then
	         this.setsort('general_nombre A')
		     this.sort()
			  ii_val = 1 
		else
		  this.setsort('general_nombre D')
		     this.sort()
			   ii_val = 0
		end if	  
   case 'aspiran_clv_carr_t'
		  if ii_val = 0 then
	          this.setsort('aspiran_clv_carr A')
		     this.sort()
			  ii_val = 1 
		else
		  this.setsort('aspiran_clv_carr D')
		     this.sort()
			   ii_val = 0
		end if	  
	       
end choose

this.setfocus()
//this.setcolumn('propedeutico')
//this.setfocus()
this.setrow(row)
this.scrolltorow(row)
ii_row =  row
//  dw_propedéuticos.object.propedeutico[ii_row] 
end event

event getfocus;return 1
end event

event itemfocuschanged;this.setcolumn('propedeutico')
this.setfocus()
end event

type gb_1 from groupbox within w_propedeutico_sel_libre
integer x = 4539
integer y = 1076
integer width = 667
integer height = 456
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opciones"
end type

type gb_2 from groupbox within w_propedeutico_sel_libre
integer x = 4539
integer y = 548
integer width = 667
integer height = 468
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Propedeutico"
end type

type gb_3 from groupbox within w_propedeutico_sel_libre
integer x = 3456
integer y = 300
integer width = 910
integer height = 232
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_propedeutico_sel_libre
integer x = 2743
integer y = 24
integer width = 498
integer height = 232
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_6 from groupbox within w_propedeutico_sel_libre
integer x = 96
integer y = 24
integer width = 1371
integer height = 256
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingreso"
end type

type uo_per_ani2 from uo_per_ani_admision within w_propedeutico_sel_libre
event destroy ( )
integer x = 1399
integer y = 348
integer taborder = 30
boolean enabled = true
long backcolor = 67108864
end type

on uo_per_ani2.destroy
call uo_per_ani_admision::destroy
end on

event ue_modifica;call super::ue_modifica;
PARENT.ie_periodo = THIS.ie_periodo
PARENT.ie_anio = THIS.ie_anio
end event

type dw_crit from datawindow within w_propedeutico_sel_libre
integer x = 165
integer y = 380
integer width = 3241
integer height = 108
integer taborder = 30
string title = "none"
string dataobject = "ddw_ext_criprope"
boolean border = false
boolean livescroll = true
end type

event itemerror;	 return 1
end event

type gb_5 from groupbox within w_propedeutico_sel_libre
integer x = 96
integer y = 300
integer width = 3355
integer height = 232
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Examen"
end type

type gb_7 from groupbox within w_propedeutico_sel_libre
integer x = 1550
integer y = 24
integer width = 1106
integer height = 256
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Propedéutico"
end type

