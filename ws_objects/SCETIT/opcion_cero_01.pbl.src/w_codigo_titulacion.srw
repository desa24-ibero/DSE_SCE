$PBExportHeader$w_codigo_titulacion.srw
forward
global type w_codigo_titulacion from window
end type
type em_cve_plan from editmask within w_codigo_titulacion
end type
type em_cve_carrera from editmask within w_codigo_titulacion
end type
type em_cuenta from editmask within w_codigo_titulacion
end type
type cb_1 from commandbutton within w_codigo_titulacion
end type
end forward

global type w_codigo_titulacion from window
integer width = 2026
integer height = 1126
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
em_cve_plan em_cve_plan
em_cve_carrera em_cve_carrera
em_cuenta em_cuenta
cb_1 cb_1
end type
global w_codigo_titulacion w_codigo_titulacion

type variables
u_codigo_titulo iu_codigo_titulo
end variables

event open;
iu_codigo_titulo= create u_codigo_titulo 
end event

event close;if isvalid(iu_codigo_titulo) then
	destroy iu_codigo_titulo
end if


end event

on w_codigo_titulacion.create
this.em_cve_plan=create em_cve_plan
this.em_cve_carrera=create em_cve_carrera
this.em_cuenta=create em_cuenta
this.cb_1=create cb_1
this.Control[]={this.em_cve_plan,&
this.em_cve_carrera,&
this.em_cuenta,&
this.cb_1}
end on

on w_codigo_titulacion.destroy
destroy(this.em_cve_plan)
destroy(this.em_cve_carrera)
destroy(this.em_cuenta)
destroy(this.cb_1)
end on

type em_cve_plan from editmask within w_codigo_titulacion
integer x = 1371
integer y = 134
integer width = 413
integer height = 106
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type em_cve_carrera from editmask within w_codigo_titulacion
integer x = 717
integer y = 134
integer width = 413
integer height = 106
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type em_cuenta from editmask within w_codigo_titulacion
integer x = 62
integer y = 134
integer width = 413
integer height = 106
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type cb_1 from commandbutton within w_codigo_titulacion
integer x = 720
integer y = 368
integer width = 413
integer height = 106
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Prueba"
end type

event clicked;DOUBLE lr_codigo 
STRING lS_codigo 
LONG ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_secuencia = 1

//10	1	17557	10	CARLOS RUBEN DE LA	TORRE	FLORES	01-09-03	01-09-03	45606	0	0	0	101755774393	367	1		ADMINISTRACI?N DE EMPRESAS	Universidad Iberoamericana   Plantel  Santa  Fe	M?xico, D.F.	2	1	Rector del Plantel	Mtro. Enrique Gonzßlez Torres.	Director de Servicios Escolares	Mat. Graciela Rojas Gonzßlez.	Rector del Plantel	Mtro. Enrique Gonzßlez Torres.	Director de Regulaci?n de Instituciones Particulares S.E.P.	Lic. Jos? Gabriel Carre±o Camacho	Jefe del Departamento de Certificaci?n Escolar	Lic. Jes·s Mendoza Vargas	118877-1	0	FALSO	FALSO	1	11	Opci?n Cero


//lr_codigo = iu_codigo_titulo.gen2seguro( &
//21525, &
//35, &
//9, &
//35, &
//date("01-08-96"), &
//date("04-08-96"), &
//"Fernanda", &
//"Aguilar", &
//"Jiménez", &
//10, &
//1, &
//10, &
//1)

ll_cuenta = long(em_cuenta.text) 
ll_cve_carrera= long(em_cve_carrera.text) 
ll_cve_plan= long(em_cve_plan.text) 


lr_codigo = iu_codigo_titulo.of_obten_codigo(ll_cuenta,ll_cve_carrera, ll_cve_plan,ll_cve_secuencia )


//lS_codigo = iu_codigo_titulo.of_obten_seguro( &
//21526, &
//39, &
//9, &
//39, &
//date("01-19-96"), &
//date("04-08-96"), &
//"Jorge Federico", &
//"Aguilera", &
//"Villanueva", &
//10, &
//1, &
//10, &
//2)
//
MessageBox("Codigo", string(lr_codigo,"###############"))


//MessageBox("Codigo", ls_codigo)

end event

