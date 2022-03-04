$PBExportHeader$w_archivo_ceneval.srw
forward
global type w_archivo_ceneval from window
end type
type cb_generar from commandbutton within w_archivo_ceneval
end type
type sle_version from singlelineedit within w_archivo_ceneval
end type
type sle_periodo from singlelineedit within w_archivo_ceneval
end type
type sle_anio from singlelineedit within w_archivo_ceneval
end type
type st_3 from statictext within w_archivo_ceneval
end type
type st_2 from statictext within w_archivo_ceneval
end type
type st_1 from statictext within w_archivo_ceneval
end type
end forward

global type w_archivo_ceneval from window
integer width = 1545
integer height = 528
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_generar cb_generar
sle_version sle_version
sle_periodo sle_periodo
sle_anio sle_anio
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_archivo_ceneval w_archivo_ceneval

type variables
transaction gtr_sumuia, itr_sumuia
end variables

on w_archivo_ceneval.create
this.cb_generar=create cb_generar
this.sle_version=create sle_version
this.sle_periodo=create sle_periodo
this.sle_anio=create sle_anio
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_generar,&
this.sle_version,&
this.sle_periodo,&
this.sle_anio,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_archivo_ceneval.destroy
destroy(this.cb_generar)
destroy(this.sle_version)
destroy(this.sle_periodo)
destroy(this.sle_anio)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;if conecta_bd(itr_sumuia,gs_sumuia,gs_usuario,gs_password)=1 then
	
else 
	desconecta_bd(itr_sumuia)
	return
end if


end event

type cb_generar from commandbutton within w_archivo_ceneval
integer x = 475
integer y = 260
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
boolean default = true
end type

event clicked;integer li_anio,li_periodo,li_version
datastore lds_uia,lds_ceneval,lds_archivo,lds_carreras,lds_lugar,lds_nacionalidades
long i,ll_linea,ll_busca,ll_busca_preg,ll_folio,edad
string ls_pregunta

setpointer(hourglass!)
//VERIFICAMOS QUE SE INGRESARON LOS PARAMETROS
if not(isnumber(sle_anio.text)) or not(isnumber(sle_periodo.text)) or not(isnumber(sle_version.text)) then
	messagebox("Mensaje de Error","Los parámetros son incorrectos, verifiquelos e intente nuevamente",stopsign!)
else
	li_anio=integer(sle_anio.text)
	li_periodo=integer(sle_periodo.text)
	li_version=integer(sle_version.text)
	//CREAMOS LOS OBJETOS PORTADORES DE DATOS
	lds_uia=CREATE Datastore
	lds_uia.dataobject='d_datos_uia'
	lds_uia.settransobject(gtr_sadm)
	lds_ceneval=CREATE Datastore
	lds_ceneval.dataobject='d_respuestas_ceneval'
	lds_ceneval.settransobject(gtr_sadm)
	lds_archivo=CREATE Datastore
	lds_archivo.dataobject='d_archivo_admision_ceneval'
	lds_carreras=CREATE Datastore
	lds_carreras.dataobject='d_carreras_disponibles'
	lds_carreras.settransobject(itr_sumuia)
	ll_busca=lds_carreras.retrieve()
	lds_lugar=CREATE Datastore
	lds_lugar.dataobject='d_posiciones_uia_ceneval'
	lds_nacionalidades=CREATE Datastore
	lds_nacionalidades.dataobject='d_nacionalidades'
	lds_nacionalidades.settransobject(itr_sumuia)
	lds_nacionalidades.retrieve()

		
	//TRAEMOS LOS DATOS DE LA UIA
	lds_uia.retrieve(li_anio,li_periodo,li_version)
	for i=1 to lds_uia.rowcount()
		ll_linea=lds_archivo.insertrow(0)
		//FOLIO
		lds_archivo.setitem(ll_linea,'folio',lds_uia.getitemnumber(i,'folio'))
		//NOMBRE
		lds_archivo.setitem(ll_linea,'nombre',lds_uia.getitemstring(i,'nombre_completo'))		
		//BACHILLERATO
		lds_archivo.setitem(ll_linea,'esc_proc',string(lds_uia.getitemnumber(i,'bachillera')))		
		// RANGO DE EDAD
		edad=year(today()) - year(date(lds_uia.getitemdatetime(i,'fecha_nac')))
		choose case edad
			case is<17
				lds_archivo.setitem(ll_linea,'edad','1')
			case 17
				lds_archivo.setitem(ll_linea,'edad','2')
			case 18
				lds_archivo.setitem(ll_linea,'edad','3')
			case 19
				lds_archivo.setitem(ll_linea,'edad','4')
			case 20
				lds_archivo.setitem(ll_linea,'edad','5')
			case 21 to 24
				lds_archivo.setitem(ll_linea,'edad','6')
			case is >= 25
				lds_archivo.setitem(ll_linea,'edad','7')
			case else 
				lds_archivo.setitem(ll_linea,'edad','0')
		end choose
		//FECHA DE NACIMIENTO
		lds_archivo.setitem(ll_linea,'dia_nac',string(day(date(lds_uia.getitemdatetime(i,'fecha_nac'))),"00"))
		lds_archivo.setitem(ll_linea,'mes_nac',string(month(date(lds_uia.getitemdatetime(i,'fecha_nac'))),"00"))
		lds_archivo.setitem(ll_linea,'ano_nac',string(year(date(lds_uia.getitemdatetime(i,'fecha_nac'))),"0000"))
		//ESTADO DE NACIMIENTO
		if lds_uia.getitemnumber(i,'lugar_nac')<=50 then		
			//ESTADO DE LA REPUBLICA
			//BUSCA EQUIVALENCIA DE LA SEP
			ll_busca=lds_nacionalidades.find("cve_estado="+string(lds_uia.getitemnumber(i,'lugar_nac')),1,lds_nacionalidades.rowcount())
			if ll_busca>0 then				
				lds_archivo.setitem(ll_linea,'edo_naci',string(lds_nacionalidades.getitemnumber(ll_busca,'cve_sep'),"00") )
			else
				lds_archivo.setitem(ll_linea,'edo_naci','00' )
			end if
		else
			//EXTRANJERO
			lds_archivo.setitem(ll_linea,'edo_naci','99' )
		end if
		//SEXO
		if lds_uia.getitemstring(i,'sexo')='F' then
			lds_archivo.setitem(ll_linea,'sexo','2')
		else
			lds_archivo.setitem(ll_linea,'sexo','1')
		end if
		//ESTADO CIVIL
		CHOOSE CASE lds_uia.getitemnumber(i,'edo_civil')
			CASE 0,2,3
			lds_archivo.setitem(ll_linea,'edo_civi','1')
			CASE 1,4
			lds_archivo.setitem(ll_linea,'edo_civi','2')
		END CHOOSE		
		//TRABAJA?
		lds_archivo.setitem(ll_linea,'trabaja',string(lds_uia.getitemnumber(i,'trabajo')))
		//HRS DE TRABAJO SEMANAL
		CHOOSE CASE lds_uia.getitemnumber(i,'trab_hor')*5
			CASE is <=10
			lds_archivo.setitem(ll_linea,'hrs_trab','1')
			CASE 11 to 20
			lds_archivo.setitem(ll_linea,'hrs_trab','2')
			CASE 21 to 30
			lds_archivo.setitem(ll_linea,'hrs_trab','3')
			CASE 31 to 40
			lds_archivo.setitem(ll_linea,'hrs_trab','4')
			CASE is> 40
			lds_archivo.setitem(ll_linea,'hrs_trab','5')
			CASE ELSE 
			lds_archivo.setitem(ll_linea,'hrs_trab','0')
		END CHOOSE		
		//CARRERA DESCRIPCION
		ll_busca=lds_carreras.find("cve_carrera="+string(lds_uia.getitemnumber(i,'clv_carr')),1,lds_carreras.rowcount())
		if ll_busca>0 then
			lds_archivo.setitem(ll_linea,'nom_carr',lds_carreras.getitemstring(ll_busca,'carrera'))
		else
			lds_archivo.setitem(ll_linea,'nom_carr','')
		end if
		//PROMEDIO
		CHOOSE CASE lds_uia.getitemdecimal(i,'promedio')
			CASE 60 to 65
			lds_archivo.setitem(ll_linea,'pro_bach','1')
			CASE 66 to 70
			lds_archivo.setitem(ll_linea,'pro_bach','2')
			CASE 71 to 75
			lds_archivo.setitem(ll_linea,'pro_bach','3')
			CASE 76 to 80
			lds_archivo.setitem(ll_linea,'pro_bach','4')
			CASE 81 to 85
			lds_archivo.setitem(ll_linea,'pro_bach','5')
			CASE 86 to 90
			lds_archivo.setitem(ll_linea,'pro_bach','6')
			CASE 91 to 95
			lds_archivo.setitem(ll_linea,'pro_bach','7')
			CASE 96 to 100
			lds_archivo.setitem(ll_linea,'pro_bach','8')
			CASE ELSE 
			lds_archivo.setitem(ll_linea,'pro_bach','0')
		END CHOOSE		
	next
	lds_ceneval.retrieve(li_anio,li_periodo,li_version)	
	for i=1 to lds_ceneval.rowcount()		
		ll_folio=lds_ceneval.getitemnumber(i,'folio')
		ls_pregunta=lds_ceneval.getitemstring(i,'pregunta')
		if (ls_pregunta>='P2101' and ls_pregunta <='P2111') then
			//SE TRATA DE LA PREGUNTA DEL MULTIPLE CHECKBOX QUE ORIGINALMENTE PODIAN SELECCIONAR MAS DE UNA RESPUESTA
			if lds_ceneval.getitemnumber(i,'valor')=1 then
				ll_busca=lds_archivo.find('folio='+string(ll_folio),1,lds_archivo.rowcount())
				lds_archivo.setitem(ll_busca,'trab_des',mid(ls_pregunta,4,2))		
			end if
		else
			ll_busca=lds_archivo.find('folio='+string(ll_folio),1,lds_archivo.rowcount())
			if ll_busca>0 then
				ll_busca_preg=lds_lugar.find('pregunta="'+ls_pregunta+'"',1,lds_lugar.rowcount())
				if ll_busca_preg>0 then
					lds_archivo.setitem(ll_busca,lds_lugar.getitemstring(ll_busca_preg,'ubicacion'),string(lds_ceneval.getitemnumber(i,'valor'),lds_lugar.getitemstring(ll_busca_preg,'posiciones')))		
				end if
			end if
		end if
	next
	
end if

lds_archivo.setSort("folio A");
lds_archivo.sort();
i=lds_archivo.saveas("CENEVAL.XLS", excel!, TRUE)
i=lds_archivo.saveas("CENEVAL.CSV", CSV!, TRUE)
i=lds_archivo.saveas("CENEVAL.BDF",dBase3!,TRUE)
i=lds_archivo.saveas("CENEVAL.TXT", text!, TRUE)
messagebox("Mensaje del Sistema","El archivo se ha generado con éxito",exclamation!)
end event

type sle_version from singlelineedit within w_archivo_ceneval
integer x = 1234
integer y = 48
integer width = 197
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
integer limit = 1
borderstyle borderstyle = stylelowered!
end type

type sle_periodo from singlelineedit within w_archivo_ceneval
integer x = 713
integer y = 52
integer width = 229
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2"
integer limit = 1
borderstyle borderstyle = stylelowered!
end type

type sle_anio from singlelineedit within w_archivo_ceneval
integer x = 174
integer y = 52
integer width = 293
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2003"
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_archivo_ceneval
integer x = 1006
integer y = 52
integer width = 238
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Versión"
boolean focusrectangle = false
end type

type st_2 from statictext within w_archivo_ceneval
integer x = 507
integer y = 52
integer width = 229
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo"
boolean focusrectangle = false
end type

type st_1 from statictext within w_archivo_ceneval
integer x = 46
integer y = 52
integer width = 133
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
boolean focusrectangle = false
end type

