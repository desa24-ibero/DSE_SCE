$PBExportHeader$w_mad_repo_29.srw
$PBExportComments$Ventana para el Reporte de Planes de Estudio
forward
global type w_mad_repo_29 from w_master_main_rep
end type
type lb_carreras_plan_por_coordinacion from uo_lb_carreras_plan_por_coordinacion_2013 within w_mad_repo_29
end type
type rb_13 from radiobutton within w_mad_repo_29
end type
type rb_12 from radiobutton within w_mad_repo_29
end type
type rb_11 from radiobutton within w_mad_repo_29
end type
type gb_8 from groupbox within w_mad_repo_29
end type
type dw_6 from datawindow within w_mad_repo_29
end type
type cbx_7 from checkbox within w_mad_repo_29
end type
type st_2 from statictext within w_mad_repo_29
end type
type st_1 from statictext within w_mad_repo_29
end type
type dw_4 from datawindow within w_mad_repo_29
end type
type dw_1 from datawindow within w_mad_repo_29
end type
type dw_3 from datawindow within w_mad_repo_29
end type
type cb_1 from commandbutton within w_mad_repo_29
end type
type gb_2 from groupbox within w_mad_repo_29
end type
type lb_4 from listbox within w_mad_repo_29
end type
type dw_2 from datawindow within w_mad_repo_29
end type
type dw_7 from datawindow within w_mad_repo_29
end type
type dw_5 from datawindow within w_mad_repo_29
end type
end forward

global type w_mad_repo_29 from w_master_main_rep
integer x = 832
integer y = 360
integer width = 3986
integer height = 3272
string title = "Reporte de Planes de Estudios"
string menuname = "m_repo_mad5"
boolean resizable = true
lb_carreras_plan_por_coordinacion lb_carreras_plan_por_coordinacion
rb_13 rb_13
rb_12 rb_12
rb_11 rb_11
gb_8 gb_8
dw_6 dw_6
cbx_7 cbx_7
st_2 st_2
st_1 st_1
dw_4 dw_4
dw_1 dw_1
dw_3 dw_3
cb_1 cb_1
gb_2 gb_2
lb_4 lb_4
dw_2 dw_2
dw_7 dw_7
dw_5 dw_5
end type
global w_mad_repo_29 w_mad_repo_29

type variables
string division_x
string nivel_x
int carrera_temp
int plan_temp
end variables

forward prototypes
public subroutine separa (string texto, ref integer carrera, ref integer plan)
public function string obten_plan (integer cve_plan)
end prototypes

public subroutine separa (string texto, ref integer carrera, ref integer plan);string Texto_Temporal
int Longitud


Texto_Temporal=Right(Texto, 1)
Plan = integer(Texto_Temporal)

Longitud=Len(Texto)
Longitud=Longitud - 1

Texto_Temporal=Left(Texto,Longitud)
Carrera = integer(Texto_Temporal)

end subroutine

public function string obten_plan (integer cve_plan);string Plan
SELECT nombre_plan INTO :Plan FROM nombre_plan WHERE cve_plan = :cve_plan using gtr_sce;
return Plan
//if cve_plan=1 then
//	Plan="Viejo"
//	return Plan
//end if
//if cve_plan=2 then
//	Plan="Nuevo"
//	return Plan	
//end if
//if cve_plan=3 then
//	Plan="Sta Fe I"
//	return Plan
//end if
//if cve_plan=4 then
//	Plan="Sta Fe II"
//	return Plan
//end if
end function

on w_mad_repo_29.create
int iCurrent
call super::create
if this.MenuName = "m_repo_mad5" then this.MenuID = create m_repo_mad5
this.lb_carreras_plan_por_coordinacion=create lb_carreras_plan_por_coordinacion
this.rb_13=create rb_13
this.rb_12=create rb_12
this.rb_11=create rb_11
this.gb_8=create gb_8
this.dw_6=create dw_6
this.cbx_7=create cbx_7
this.st_2=create st_2
this.st_1=create st_1
this.dw_4=create dw_4
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_1=create cb_1
this.gb_2=create gb_2
this.lb_4=create lb_4
this.dw_2=create dw_2
this.dw_7=create dw_7
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_carreras_plan_por_coordinacion
this.Control[iCurrent+2]=this.rb_13
this.Control[iCurrent+3]=this.rb_12
this.Control[iCurrent+4]=this.rb_11
this.Control[iCurrent+5]=this.gb_8
this.Control[iCurrent+6]=this.dw_6
this.Control[iCurrent+7]=this.cbx_7
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.lb_4
this.Control[iCurrent+16]=this.dw_2
this.Control[iCurrent+17]=this.dw_7
this.Control[iCurrent+18]=this.dw_5
end on

on w_mad_repo_29.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lb_carreras_plan_por_coordinacion)
destroy(this.rb_13)
destroy(this.rb_12)
destroy(this.rb_11)
destroy(this.gb_8)
destroy(this.dw_6)
destroy(this.cbx_7)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.lb_4)
destroy(this.dw_2)
destroy(this.dw_7)
destroy(this.dw_5)
end on

event open;/*Cuando se abra la ventana w_certificados...*/



/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1
nivel_x = 'T'
division_x = 'T'

carrera_temp=0
plan_temp=0

lb_carreras_plan_por_coordinacion.inicializa(f_coordinacion_por_usuario(gs_usuario))




end event

type st_sistema from w_master_main_rep`st_sistema within w_mad_repo_29
end type

type p_ibero from w_master_main_rep`p_ibero within w_mad_repo_29
end type

type lb_carreras_plan_por_coordinacion from uo_lb_carreras_plan_por_coordinacion_2013 within w_mad_repo_29
event destroy ( )
integer x = 64
integer y = 636
integer taborder = 50
end type

on lb_carreras_plan_por_coordinacion.destroy
call uo_lb_carreras_plan_por_coordinacion_2013::destroy
end on

type rb_13 from radiobutton within w_mad_repo_29
event clicked pbm_bnclicked
integer x = 2395
integer y = 484
integer width = 722
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Diagnóstico X Subs."
boolean lefttext = true
end type

event clicked;dw_6.visible =FALSE
dw_5.visible =FALSE
dw_7.visible =TRUE

end event

type rb_12 from radiobutton within w_mad_repo_29
integer x = 2395
integer y = 544
integer width = 722
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Materias"
boolean lefttext = true
end type

event clicked;dw_5.visible =FALSE
dw_7.visible =FALSE
dw_6.visible =TRUE

end event

type rb_11 from radiobutton within w_mad_repo_29
integer x = 2395
integer y = 420
integer width = 722
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Diagnóstico General "
boolean checked = true
boolean lefttext = true
end type

event clicked;dw_6.visible =FALSE
dw_7.visible =FALSE
dw_5.visible =TRUE

end event

type gb_8 from groupbox within w_mad_repo_29
integer x = 2373
integer y = 356
integer width = 786
integer height = 288
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Visualizar"
borderstyle borderstyle = styleraised!
end type

type dw_6 from datawindow within w_mad_repo_29
integer x = 18
integer y = 1180
integer width = 3808
integer height = 1740
string dataobject = "dw_repo_mad_29_gz_c_manresa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;visible=FALSE
end event

type cbx_7 from checkbox within w_mad_repo_29
integer x = 82
integer y = 532
integer width = 421
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Auto - View"
boolean lefttext = true
end type

type st_2 from statictext within w_mad_repo_29
boolean visible = false
integer x = 3854
integer y = 592
integer width = 265
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Posgrado"
boolean focusrectangle = false
end type

type st_1 from statictext within w_mad_repo_29
boolean visible = false
integer x = 3835
integer y = 260
integer width = 334
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Licenciatura"
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_mad_repo_29
boolean visible = false
integer x = 3831
integer y = 984
integer width = 590
integer height = 284
string dataobject = "dw_repo_mad_29_gx_c_manresa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;m_repo_mad5.dw3 = this

end event

type dw_1 from datawindow within w_mad_repo_29
boolean visible = false
integer x = 4183
integer y = 756
integer width = 183
integer height = 148
string dataobject = "dw_repo_mad_29_gx_a_manresa"
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_repo_mad5.dw = this

end event

event retrieveend;this.Object.DataWindow.Zoom = 95
this.Object.DataWindow.Print.Margin.Left	 = 200
end event

type dw_3 from datawindow within w_mad_repo_29
boolean visible = false
integer x = 3822
integer y = 776
integer width = 306
integer height = 164
string dataobject = "dw_repo_mad_29_gx_b"
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

type cb_1 from commandbutton within w_mad_repo_29
event inicio ( integer carrera,  integer plan )
event proceso ( string codigo_x,  integer codigo_y,  string codigo_z,  integer cve_area,  string nombre,  integer carrera,  integer plan )
event trae_datos ( integer carrera,  integer plan )
event imprime_todos ( )
integer x = 87
integer y = 408
integer width = 411
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event inicio(integer carrera, integer plan);int area_basica,area_mayor_obl,area_mayor_opt , area_sint_eva_obl , area_sint_eva_opt
string Nivel

int Cve_Subsistema,Cve_Area_Subsistema
string Nombre_Subsistema,Clase_Subsistema,Nombre_Final
int Total_Subsistemas,contador



if dw_1.rowcount() > 0 then
// ----------------------------------------------------------------------------------------	
	dw_4.object.st_carrera.text=dw_1.object.carreras_carrera[1]
	dw_4.object.st_plan.text=dw_1.object.nombre_plan_nombre_plan[1]	
	Nivel=dw_1.object.carreras_nivel[1]
	//if Nivel = 'L' then
	if Nivel <> 'P' then 
      		//dw_4.object.st_nivel.text="Licenciatura"
			dw_4.object.st_nivel.text = f_decodifica_nivel(Nivel)  
			dw_3.DataObject = "dw_repo_mad_29_gx_b"
	else
   		dw_4.object.st_nivel.text="Posgrado"
   		dw_3.DataObject = "dw_repo_mad_29_gx_bpos"
	end if	
	dw_3.SetTransObject(gtr_sce)
// ----------------------------------------------------------------------------------------	
	area_basica = dw_1.object.plan_estudios_cve_area_basica[1]
	if isnull(area_basica) then
		area_basica = 0
	else
		this. EVENT proceso("A",1,"OBL",area_basica,"Area Básica",carrera,plan)
	end if
	
// ----------------------------------------------------------------------------------------		
	area_mayor_obl = dw_1.object.plan_estudios_cve_area_mayor_oblig[1]
	if isnull(area_mayor_obl) then
		area_mayor_obl=0
	else
		this. EVENT proceso("B",1,"OBL",area_mayor_obl,"Area Mayor Obligatoria",carrera,plan)
	end if
// ----------------------------------------------------------------------------------------		
	area_mayor_opt = dw_1.object.plan_estudios_cve_area_mayor_opt[1]
	if isnull(area_mayor_opt) then
		area_mayor_opt=0
	else
		this. EVENT proceso("C",1,"OPT",area_mayor_opt,"Area Mayor Optativa",carrera,plan)
	end if

// ----------------------------------------------------------------------------------------	
	area_sint_eva_obl = dw_1.object.plan_estudios_cve_area_sintesis_eval_oblig[1]
	if isnull(area_sint_eva_obl) then
		area_sint_eva_obl = 0
	else
		this. EVENT proceso("D",1,"OBL",area_sint_eva_obl ,"Area Sintesis Evaluaciòn Obligatoria",carrera,plan)
	end if
	
// ----------------------------------------------------------------------------------------		
area_sint_eva_opt = dw_1.object.plan_estudios_cve_area_sintesis_eval_opt[1]
	if isnull(area_sint_eva_opt) then
		area_sint_eva_opt = 0
	else
		this. EVENT proceso("E",1,"OPT",area_sint_eva_opt ,"Area Sintesis Evaluaciòn Optativa",carrera,plan)
	end if
	
// ----------------------------------------------------------------------------------------	

end if


if dw_2.rowcount() > 0 then
	Total_Subsistemas=dw_2.rowcount()
	FOR contador=1 TO Total_Subsistemas
       Cve_Subsistema = dw_2.object.cve_subsistema[contador]
		 Cve_Area_Subsistema = dw_2.object.cve_area[contador]
       Nombre_Subsistema = dw_2.object.subsistema[contador]
       Clase_Subsistema = dw_2.object.clase_area[contador]		 
		 this. EVENT proceso("F",Cve_Subsistema,Clase_Subsistema,Cve_Area_Subsistema,Nombre_Subsistema,carrera,plan)
   NEXT	
end if


end event

event proceso(string codigo_x, integer codigo_y, string codigo_z, integer cve_area, string nombre, integer carrera, integer plan);long NewRow
long NewRow2
int Total
int Contador
boolean lb_plan_sigla_nueva= false
dw_3.reset()
dw_3.retrieve(cve_area,carrera,plan)
lb_plan_sigla_nueva = f_plan_sigla_nueva(plan) 
if dw_3.rowcount() > 0 then
   Total = dw_3.rowcount()
	FOR Contador=1 TO Total
	  NewRow = dw_4.InsertRow(0) 
     dw_4.object.codigo_x[NewRow]=codigo_x
	  dw_4.object.codigo_y[NewRow]=codigo_y
	  dw_4.object.codigo_z[NewRow]=codigo_z
     dw_4.object.cve_area[NewRow]=dw_3.object.area_mat_cve_area[Contador]
     dw_4.object.nombre_area[NewRow]=nombre
     dw_4.object.cve_mat[NewRow]=dw_3.object.materias_cve_mat[Contador]	  
     dw_4.object.materia[NewRow]=dw_3.object.materias_materia[Contador]	    
     dw_4.object.creditos[NewRow]=dw_3.object.materias_creditos[Contador]	    
     dw_4.object.laboratorio[NewRow]=dw_3.object.teoria_lab_cve_lab[Contador]	    	  
     dw_4.object.prerrequisito[NewRow]=dw_3.object.prerrequisitos_cve_prerreq[Contador]	    	  
     if lb_plan_sigla_nueva then 
	     dw_4.object.sigla[NewRow]=dw_3.object.materias_sigla[Contador]	    	  
     else  
	     dw_4.object.sigla[NewRow]=dw_3.object.materias_sigla_anterior[Contador]	    	       
	  end if	  
     dw_4.object.horas_teoria[NewRow]=dw_3.object.materias_horas_teoria[Contador]	    	  
     dw_4.object.horas_lab[NewRow]=dw_3.object.materias_horas_practica[Contador]	    	  
     dw_4.object.sem_ideal[NewRow]=dw_3.object.mat_prerrequisito_semestre_ideal[Contador]
	  dw_4.object.orden[NewRow]=dw_3.object.prerrequisitos_orden[Contador]	    	  
     dw_4.object.cursativa[NewRow]=dw_3.object.mat_prerrequisito_cursativa[Contador]
	  dw_4.object.enlace[NewRow]=dw_3.object.prerrequisitos_enlace[Contador]	
	 dw_4.object.horas_ind[NewRow]=dw_3.object.materias_horas_individuales[Contador]	    	  
     dw_4.object.horas_aula[NewRow]=dw_3.object.materias_horas_aula[Contador]	  
	  
	  
	  NewRow2 = dw_6.InsertRow(0) 
     dw_6.object.codigo_x[NewRow2]=codigo_x
	  dw_6.object.codigo_y[NewRow2]=codigo_y
	  dw_6.object.codigo_z[NewRow2]=codigo_z
     dw_6.object.cve_area[NewRow2]=dw_3.object.area_mat_cve_area[Contador]
     dw_6.object.nombre_area[NewRow2]=nombre
     dw_6.object.cve_mat[NewRow2]=dw_3.object.materias_cve_mat[Contador]	  
     dw_6.object.materia[NewRow2]=dw_3.object.materias_materia[Contador]	    
     dw_6.object.creditos[NewRow2]=dw_3.object.materias_creditos[Contador]	    
     dw_6.object.laboratorio[NewRow2]=dw_3.object.teoria_lab_cve_lab[Contador]	    	  
     dw_6.object.prerrequisito[NewRow2]=dw_3.object.prerrequisitos_cve_prerreq[Contador]	    	  
     if lb_plan_sigla_nueva then 
        dw_6.object.sigla[NewRow2]=dw_3.object.materias_sigla[Contador]	    	  
     else	  
        dw_6.object.sigla[NewRow2]=dw_3.object.materias_sigla_anterior[Contador]	    	  
     end if
     dw_6.object.horas_teoria[NewRow2]=dw_3.object.materias_horas_teoria[Contador]	    	  
     dw_6.object.horas_lab[NewRow2]=dw_3.object.materias_horas_practica[Contador]	    	  
     dw_6.object.sem_ideal[NewRow2]=dw_3.object.mat_prerrequisito_semestre_ideal[Contador]
	  dw_6.object.orden[NewRow2]=dw_3.object.prerrequisitos_orden[Contador]	    	  
     dw_6.object.cursativa[NewRow2]=dw_3.object.mat_prerrequisito_cursativa[Contador]
	  dw_6.object.enlace[NewRow2]=dw_3.object.prerrequisitos_enlace[Contador]  
	 dw_6.object.horas_ind[NewRow2]=dw_3.object.materias_horas_individuales[Contador]	    	  
     dw_6.object.horas_aula[NewRow2]=dw_3.object.materias_horas_aula[Contador]	  
	  
	NEXT

end if

dw_6.Sort()
dw_6.GroupCalc( )
end event

event trae_datos;
setpointer(Hourglass!)

dw_1.reset()
dw_2.reset()
dw_3.reset()
dw_4.reset()
dw_5.reset()
dw_6.reset()
dw_7.reset()
dw_4.object.st_carrera.text=""
dw_4.object.st_plan.text=""

dw_1.retrieve(carrera,plan)
dw_2.retrieve(carrera,plan)
dw_5.retrieve(carrera,plan)
dw_7.retrieve(carrera,plan)
this. EVENT inicio(carrera,plan)
dw_4.Sort()
dw_4.GroupCalc( )
dw_4.Object.DataWindow.Zoom = 95
dw_4.Object.DataWindow.Print.Margin.Left	 = 200
dw_6.Sort()
dw_6.GroupCalc( )

end event

event imprime_todos;int Respuesta
int carrera
int plan,Total,Cont
integer li_Index
string Texto

Respuesta=messagebox("Pregunta", " Desea Imprimir TODOS los Planes de Estudio de la Lista ?",Question!,YesNo!,2);

CHOOSE CASE Respuesta
	CASE 1
	setpointer(Hourglass!)
	Total=lb_4.totalitems()
	if Total > 0 then
		FOR Cont=1 TO Total
			dw_1.reset()
			dw_2.reset()
			dw_3.reset()
			dw_4.reset()
			dw_6.reset()
			
			dw_4.object.st_carrera.text=""
			dw_4.object.st_plan.text=""
			
			Texto = lb_4.text(Cont)
			separa(Texto,carrera,plan)
			dw_1.retrieve(carrera,plan)
			dw_2.retrieve(carrera,plan)
			this. EVENT inicio(carrera,plan)
			dw_4.Sort()
			dw_4.GroupCalc( )
			dw_4.Object.DataWindow.Zoom = 95
			dw_4.Object.DataWindow.Print.Margin.Left	 = 200
			dw_1.print()
			dw_2.print()
			dw_4.print()
			//dw_4.SaveAs("D:\planes\"+string(carrera)+string(plan)+".xls",Excel!,false)
			
		NEXT
	dw_6.reset()
	end if

	CASE 2

END CHOOSE











end event

event clicked;int carrera
int plan
string ls_array_aux[]



setpointer(Hourglass!)

dw_1.reset()
dw_2.reset()
dw_3.reset()
dw_4.reset()
dw_5.reset()
dw_6.reset()
dw_7.reset()

dw_4.object.st_carrera.text=""
dw_4.object.st_plan.text=""

lb_carreras_plan_por_coordinacion.uo_nivel.of_carga_arreglo_nivel( )
lb_carreras_plan_por_coordinacion.uo_nivel.of_obtiene_array(ls_array_aux[])

If UpperBound(ls_array_aux[]) <= 0 Then
	MessageBox(" Mensaje del Sistema ","Debe seleccionar un nivel",StopSign!)
	return
End If

lb_carreras_plan_por_coordinacion.carreraplanseleccionada(carrera, plan)
carrera_temp = carrera
plan_temp=plan
dw_1.retrieve(carrera,plan)
dw_2.retrieve(carrera,plan)
dw_5.retrieve(carrera,plan)

dw_7.retrieve(carrera,plan)
this. EVENT inicio(carrera,plan)
dw_4.Sort()
dw_4.GroupCalc( )
dw_4.Object.DataWindow.Zoom = 95
dw_4.Object.DataWindow.Print.Margin.Left	 = 200
dw_6.Sort()
dw_6.GroupCalc( )	

end event

type gb_2 from groupbox within w_mad_repo_29
integer x = 23
integer y = 320
integer width = 3799
integer height = 852
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

type lb_4 from listbox within w_mad_repo_29
event constructor pbm_constructor
integer x = 2926
integer y = 864
integer width = 91
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

type dw_2 from datawindow within w_mad_repo_29
boolean visible = false
integer x = 3826
integer y = 1348
integer width = 581
integer height = 392
boolean bringtotop = true
string dataobject = "dw_repo_mad_29_gx_a1"
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_repo_mad5.dw2 = this
end event

event retrieveend;this.Object.DataWindow.Zoom = 95
this.Object.DataWindow.Print.Margin.Left	 = 200
end event

type dw_7 from datawindow within w_mad_repo_29
event constructor pbm_constructor
integer x = 18
integer y = 1180
integer width = 3808
integer height = 1756
string dataobject = "dw_repo_mad_29_gz_a1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
visible =FALSE
end event

type dw_5 from datawindow within w_mad_repo_29
integer x = 18
integer y = 1180
integer width = 3808
integer height = 1744
string dataobject = "dw_repo_mad_29_gz_a_manresa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

