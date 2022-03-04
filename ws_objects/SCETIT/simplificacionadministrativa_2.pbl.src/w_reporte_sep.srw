$PBExportHeader$w_reporte_sep.srw
forward
global type w_reporte_sep from Window
end type
type cb_guardar from commandbutton within w_reporte_sep
end type
type dw_reporte_sep from datawindow within w_reporte_sep
end type
type cb_imprimir from commandbutton within w_reporte_sep
end type
type cb_nuevo from commandbutton within w_reporte_sep
end type
type cb_eliminar from commandbutton within w_reporte_sep
end type
type cb_agregar from commandbutton within w_reporte_sep
end type
type lb_orden_cobro from uolb_datastorenum within w_reporte_sep
end type
type lb_reporte_sep_con_orden from uolb_datastorenum within w_reporte_sep
end type
type lb_reporte_sep_sin_orden from uolb_datastorenum within w_reporte_sep
end type
end forward

global type w_reporte_sep from Window
int X=845
int Y=371
int Width=2055
int Height=1261
boolean TitleBar=true
string Title="Reporte escrito de las listas capturadas (Titulación)"
string MenuName="m_reporte_sep"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_guardar cb_guardar
dw_reporte_sep dw_reporte_sep
cb_imprimir cb_imprimir
cb_nuevo cb_nuevo
cb_eliminar cb_eliminar
cb_agregar cb_agregar
lb_orden_cobro lb_orden_cobro
lb_reporte_sep_con_orden lb_reporte_sep_con_orden
lb_reporte_sep_sin_orden lb_reporte_sep_sin_orden
end type
global w_reporte_sep w_reporte_sep

event open;X=1
Y=1
string ls_null
SetNull(ls_null)
lb_reporte_sep_sin_orden.llena("d_reporte_sep",gtr_sce,3,0,'0')
lb_orden_cobro.llena("d_orden_cobro",gtr_sce,1,1,ls_null)

end event

on w_reporte_sep.create
if this.MenuName = "m_reporte_sep" then this.MenuID = create m_reporte_sep
this.cb_guardar=create cb_guardar
this.dw_reporte_sep=create dw_reporte_sep
this.cb_imprimir=create cb_imprimir
this.cb_nuevo=create cb_nuevo
this.cb_eliminar=create cb_eliminar
this.cb_agregar=create cb_agregar
this.lb_orden_cobro=create lb_orden_cobro
this.lb_reporte_sep_con_orden=create lb_reporte_sep_con_orden
this.lb_reporte_sep_sin_orden=create lb_reporte_sep_sin_orden
this.Control[]={this.cb_guardar,&
this.dw_reporte_sep,&
this.cb_imprimir,&
this.cb_nuevo,&
this.cb_eliminar,&
this.cb_agregar,&
this.lb_orden_cobro,&
this.lb_reporte_sep_con_orden,&
this.lb_reporte_sep_sin_orden}
end on

on w_reporte_sep.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_guardar)
destroy(this.dw_reporte_sep)
destroy(this.cb_imprimir)
destroy(this.cb_nuevo)
destroy(this.cb_eliminar)
destroy(this.cb_agregar)
destroy(this.lb_orden_cobro)
destroy(this.lb_reporte_sep_con_orden)
destroy(this.lb_reporte_sep_sin_orden)
end on

type cb_guardar from commandbutton within w_reporte_sep
int X=677
int Y=330
int Width=567
int Height=109
int TabOrder=40
string Text="Guardar Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;DataStore lds_alumnosdbf, lds_datounidbf
int li_ret,li_i, li_cve_doc_control_sep
string ls_nombre_certificado
lds_alumnosdbf = Create DataStore
lds_datounidbf = Create DataStore
lds_alumnosdbf.DataObject = "d_alumnosdbf"
lds_datounidbf.DataObject = "d_datounidbf"
if lb_orden_cobro.SelectedIndex() > 0 then
	li_ret = dw_reporte_sep.retrieve(lb_orden_cobro.Text(lb_orden_cobro.SelectedIndex()))
	if li_ret >= 1 then
		 lds_datounidbf.InsertRow(0)	
 		 li_cve_doc_control_sep = dw_reporte_sep.GetItemNumber(1,"cve_doc_control_sep")
		 if li_cve_doc_control_sep = 4 or li_cve_doc_control_sep = 5 &
		    or li_cve_doc_control_sep = 6 then
			 ls_nombre_certificado = "TI TITULO(S)"	
       else 
			 ls_nombre_certificado= dw_reporte_sep.GetItemString(1,"doc_control_sep_doc_control_sep")
	    end if		 

		 lds_datounidbf.SetItem(1,1,dw_reporte_sep.GetItemString(1,5))
		 lds_datounidbf.SetItem(1,2,"UNIVERSIDAD IBEROAMERICANA CIUDAD DE MÉXICO")
		 lds_datounidbf.SetItem(1,3,"UN17")
		 lds_datounidbf.SetItem(1,4,string(dw_reporte_sep.RowCount()))
		 lds_datounidbf.SetItem(1,5,ls_nombre_certificado)
		 lds_datounidbf.SetItem(1,6,string(dw_reporte_sep.GetItemDateTime(1,"fecha_server"),"d/mm/yy"))
		 lds_datounidbf.SetItem(1,7,dw_reporte_sep.GetItemString(1,"datos_certificado_nombre"))
		 for li_i = 1 to li_ret
			lds_alumnosdbf.InsertRow(li_i)
			lds_alumnosdbf.SetItem(li_i,1,dw_reporte_sep.GetItemString(li_i,5))
			lds_alumnosdbf.SetItem(li_i,2,string(dw_reporte_sep.GetItemNumber(li_i,1))+&
											obten_digito(dw_reporte_sep.GetItemNumber(li_i,1)))
			lds_alumnosdbf.SetItem(li_i,3,dw_reporte_sep.GetItemString(li_i,2))
			lds_alumnosdbf.SetItem(li_i,4,string(dw_reporte_sep.GetItemNumber(li_i,"control_sep_numero"),"00-000000"))
			lds_alumnosdbf.SetItem(li_i,5,dw_reporte_sep.GetItemString(li_i,8))
		 next
		 lds_datounidbf.SaveAs("C:\datouni.dbf",dBASE3!,True)
		 lds_alumnosdbf.SaveAs("C:\alumnos.dbf",dBASE3!,True)	
	else
		MessageBox("Aviso","No hay nada que guardar")
	end if
else
	MessageBox("Atención","Debe de seleccionar una orden de cobro")
end if
Destroy(lds_alumnosdbf)
Destroy(lds_datounidbf)

end event

type dw_reporte_sep from datawindow within w_reporte_sep
int X=680
int Y=525
int Width=563
int Height=35
int TabOrder=40
string DataObject="d_reporte_sep"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;SetTransObject(gtr_sce)
end event

type cb_imprimir from commandbutton within w_reporte_sep
int X=677
int Y=192
int Width=567
int Height=109
int TabOrder=30
string Text="Imprime Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if lb_orden_cobro.SelectedIndex() > 0 then
		if dw_reporte_sep.retrieve(lb_orden_cobro.Text(lb_orden_cobro.SelectedIndex())) >= 1 then
		dw_reporte_sep.modify("Datawindow.print.preview = Yes")
		SetPointer(HourGlass!)
		openwithparm(conf_impr,dw_reporte_sep)
	else
		MessageBox("Aviso","No hay nada que imprimir ")
	end if
else
	MessageBox("Atención","Debe de seleccionar una orden de cobro")
end if
end event

type cb_nuevo from commandbutton within w_reporte_sep
int X=677
int Y=61
int Width=567
int Height=109
int TabOrder=20
string Text="Nueva orden cobro"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_orden_cobro
Open(w_orden_cobro_nueva)
ls_orden_cobro = Message.StringParm
if ls_orden_cobro <> "" then	
	lb_orden_cobro.SelectItem(lb_orden_cobro.AddItem(ls_orden_cobro))
	lb_reporte_sep_con_orden.Reset()
end if



end event

type cb_eliminar from commandbutton within w_reporte_sep
int X=677
int Y=829
int Width=567
int Height=109
int TabOrder=50
string Text="<---Eliminar----"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string  ls_numero, ls_null
long ll_numero
setnull(ls_null)
if lb_reporte_sep_con_orden.SelectedIndex() > 0 then
	ls_numero = lb_reporte_sep_con_orden.Text(lb_reporte_sep_con_orden.SelectedIndex())
	ll_numero = long(mid(ls_numero,1,1))*100000000+long(mid(ls_numero,3,2))*1000000+integer(mid(ls_numero,6,6))
	UPDATE dbo.control_sep SET dbo.control_sep.orden_cobro = NULL
	WHERE dbo.control_sep.numero = :ll_numero USING gtr_sce;
	if gtr_sce.sqlcode = 0 then
		commit using gtr_sce;
	else
		rollback using gtr_sce;
		MessageBox("Atencion","Los cambios no han sido guardados")
	end if
	lb_reporte_sep_sin_orden.llena("d_reporte_sep",gtr_sce,3,0,'0')
	lb_reporte_sep_con_orden.llena("d_reporte_sep",gtr_sce,3,0,lb_orden_cobro.Text(lb_orden_cobro.SelectedIndex()))
	lb_orden_cobro.llena("d_orden_cobro",gtr_sce,1,1,ls_null)
else
	MessageBox("Atención","Hay que seleccionar un numero de folio")
end if
end event

type cb_agregar from commandbutton within w_reporte_sep
int X=677
int Y=691
int Width=567
int Height=109
int TabOrder=60
string Text="----Agregar---->"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_orden_cobro, ls_numero, ls_tipo_orden, ls_tipo_folio, ls_sub_tipo_orden, ls_tipo_orden_equiv
long ll_numero, ll_num_rows, ls_row_actual
datastore lds_data
if lb_reporte_sep_sin_orden.SelectedIndex() > 0 then
	if lb_orden_cobro.SelectedIndex() > 0 then
		ls_numero = lb_reporte_sep_sin_orden.Text(lb_reporte_sep_sin_orden.SelectedIndex())
		ll_numero = long(mid(ls_numero,1,1))*100000000+long(mid(ls_numero,3,2))*1000000+integer(mid(ls_numero,6,6))
		ls_orden_cobro = lb_orden_cobro.Text(lb_orden_cobro.SelectedIndex())
		ls_tipo_folio = mid(ls_numero,13,2)

		lds_data = CREATE datastore 
		lds_data.DataObject = 'd_docs_orden_cobro'
		lds_data.SetTransObject(gtr_sce)
		ll_num_rows = lds_data.Retrieve(ls_orden_cobro)
		for ls_row_actual= 1 to ll_num_rows
			ls_tipo_orden= lds_data.GetItemString(ls_row_actual, "doc_control_sep")
			ls_sub_tipo_orden = mid(ls_tipo_orden,1,2)
			if ( ls_sub_tipo_orden = "TI" or ls_sub_tipo_orden = "DI" or &
				  ls_sub_tipo_orden = "GR") and (ls_tipo_folio = "TI" or &
				  ls_tipo_folio = "DI" or ls_tipo_folio = "GR") then
				ls_sub_tipo_orden= ls_tipo_folio	
			elseif ( ls_sub_tipo_orden = "TI" or ls_sub_tipo_orden = "DI" or &
				  ls_sub_tipo_orden = "GR") and not (ls_tipo_folio = "TI" or &
				  ls_tipo_folio = "DI" or ls_tipo_folio = "GR") then
				  exit 
			end if
		next
		
//		SELECT DISTINCT dbo.doc_control_sep.doc_control_sep INTO :ls_tipo_orden 
//		FROM dbo.control_sep, dbo.doc_control_sep
//		WHERE dbo.control_sep.cve_doc_control_sep = dbo.doc_control_sep.cve_doc_control_sep
//		AND dbo.control_sep.orden_cobro = :ls_orden_cobro USING gtr_sce;
		
		if ll_num_rows  >= 0 then
			if ls_tipo_folio = ls_sub_tipo_orden OR ll_num_rows = 0 then
				UPDATE dbo.control_sep SET dbo.control_sep.orden_cobro = :ls_orden_cobro
				WHERE dbo.control_sep.numero = :ll_numero USING gtr_sce;
				if gtr_sce.sqlcode = 0 then
					commit using gtr_sce;
				else
					rollback using gtr_sce;
					MessageBox("Atencion","Los cambios no han sido guardados")
				end if
				lb_reporte_sep_sin_orden.llena("d_reporte_sep",gtr_sce,3,0,'0')
				lb_reporte_sep_con_orden.llena("d_reporte_sep",gtr_sce,3,0,lb_orden_cobro.Text(lb_orden_cobro.SelectedIndex()))
			else
				MessageBox("Atención","No se pueden poner diferentes tipos de documentos en una misma orden de cobro")
			end if
		else
			MessageBox("ErrorBD","Error al consultar los tipos de documentos para la orden de cobro")
		end if
	else
		MessageBox("Atención","Hay que seleccionar una orden de cobro")
	end if
else
	MessageBox("Atención","Hay que seleccionar un numero de folio")
end if
			

		
		
		
end event

type lb_orden_cobro from uolb_datastorenum within w_reporte_sep
int X=1306
int Y=16
int Width=592
int Height=509
end type

event selectionchanged;call super::selectionchanged;lb_reporte_sep_con_orden.llena("d_reporte_sep",gtr_sce,3,0,text(index))
end event

type lb_reporte_sep_con_orden from uolb_datastorenum within w_reporte_sep
int X=1306
int Y=557
int Width=592
int Height=509
int TabOrder=80
end type

event doubleclicked;call super::doubleclicked;cb_eliminar.event clicked()
end event

type lb_reporte_sep_sin_orden from uolb_datastorenum within w_reporte_sep
int X=59
int Y=19
int Width=585
int Height=1040
int TabOrder=70
end type

event doubleclicked;cb_agregar.event clicked()
end event

