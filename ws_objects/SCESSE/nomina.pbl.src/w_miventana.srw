$PBExportHeader$w_miventana.srw
forward
global type w_miventana from window
end type
type cb_3 from commandbutton within w_miventana
end type
type cb_2 from commandbutton within w_miventana
end type
type st_1 from statictext within w_miventana
end type
type cb_1 from commandbutton within w_miventana
end type
end forward

global type w_miventana from window
integer x = 832
integer y = 352
integer width = 1998
integer height = 1216
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 8421376
cb_3 cb_3
cb_2 cb_2
st_1 st_1
cb_1 cb_1
end type
global w_miventana w_miventana

forward prototypes
public function integer error (string que)
end prototypes

public function integer error (string que);if gtr_sce.sqlcode <> 0 then
	MessageBox("Error",Que)
end if
return 0
end function

on w_miventana.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.st_1,&
this.cb_1}
end on

on w_miventana.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_miventana
integer x = 759
integer y = 576
integer width = 850
integer height = 120
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Flag Servicio Social"
end type

event clicked;int li_credserv, li_cve_carrera, li_cve_plan
decimal ldc_credalu
long i  = 0, ll_cta 
real lr_promedio
text = "trabajando"

UPDATE banderas SET cve_flag_serv_social = 0 USING gtr_sce;
text = "actualizacion inicial terminada, . . . "

DECLARE TOTALUMNOS CURSOR FOR
SELECT a.cuenta, pe.cred_serv_social, a.cve_carrera, a.cve_plan 
FROM dbo.academicos a,dbo.plan_estudios pe
WHERE a.cve_carrera = pe.cve_carrera
AND a.cve_plan = pe.cve_plan USING gtr_sce;
error("DECLARE")
text = "declare, . . . "
OPEN TOTALUMNOS;
error("OPEN")
text = "open, . . . "
FETCH TOTALUMNOS INTO :ll_cta, :li_credserv, :li_cve_carrera, :li_cve_plan;
error("FETCH")	
text = "fetching, . . . "
if isnull(li_credserv) then li_credserv = 0

do while gtr_sce.sqlcode <> 100
	if li_credserv <> 0 then
		ldc_credalu = 0
		DECLARE Emp_proc procedure for calcula_promedio
    		@cuenta   = :ll_cta,
    		@cve_carr = :li_cve_carrera, 
    		@plan     = :li_cve_plan,
    		@promedio = :lr_promedio out, 
    		@creditos = :ldc_credalu out
  		USING gtr_sce;
		EXECUTE Emp_proc ;
		error("EXECUTE calcula_promedio")	
		FETCH Emp_proc INTO :lr_promedio,:ldc_credalu;
		error("FETCH calcula_promedio")	
		CLOSE Emp_proc;
		error("CLOSE calcula_promedio")	
		if isnull(ldc_credalu) then ldc_credalu = 0
		if ldc_credalu >= li_credserv then
			UPDATE banderas SET cve_flag_serv_social = 1
			WHERE cuenta = :ll_cta USING gtr_sce;
			error("UPDATE "+string(ll_cta))
		end if
	end if
	i++
	st_1.text = string(i)
	FETCH TOTALUMNOS INTO :ll_cta, :li_credserv, :li_cve_carrera, :li_cve_plan;
	error("FETCH")
loop
CLOSE TOTALUMNOS;
error("CLOSE")
commit USING gtr_sce;
text = "Actualiza Flag Servicio Social"
end event

type cb_2 from commandbutton within w_miventana
integer x = 155
integer y = 452
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;opensheet(w_ocup_sal,w_principal,4,Layered!)
end event

type st_1 from statictext within w_miventana
integer x = 1253
integer y = 124
integer width = 334
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_miventana
integer x = 503
integer y = 92
integer width = 544
integer height = 120
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Inscritos"
end type

event clicked;long ins, tip, cve_a,mat
long i  = 0

string  gpo_a, gp
text = "trabajando"
DECLARE INSCRITOS CURSOR FOR 
SELECT cve_mat, gpo, COUNT(cuenta)
FROM mat_inscritas
GROUP BY cve_mat, gpo USING gtr_sce;
error("DECLARE")	
OPEN INSCRITOS;
error("OPEN")	
FETCH INSCRITOS INTO :mat, :gp, :ins;
error("FETCH")	
do while gtr_sce.sqlcode <> 100
	SELECT tipo, cve_asimilada, gpo_asimilado INTO :tip, :cve_a, :gpo_a
	FROM grupos
	WHERE (( grupos.periodo = 2 ) AND ( grupos.anio = 2001 )) AND
			cve_mat = :mat AND gpo LIKE :gp USING gtr_sce;
	error("SELECT"+string(mat)+gp)
	if tip = 2 then
		UPDATE grupos  
		    SET inscritos = inscritos + :ins
	  	WHERE 		(( grupos.periodo = 2 ) AND ( grupos.anio = 2001 )) AND
		  				((( grupos.cve_mat = :cve_a) AND
						( grupos.gpo = :gpo_a)) OR
						(( grupos.cve_asimilada = :cve_a) AND
						( grupos.gpo_asimilado = :gpo_a))) USING gtr_sce;
	else
		UPDATE grupos  
		    SET inscritos = inscritos + :ins 
	  	WHERE 		(( grupos.periodo = 2 ) AND ( grupos.anio = 2001 )) AND
		  				((( grupos.cve_mat = :mat ) AND  
			         ( grupos.gpo = :gp )) OR
						(( grupos.cve_asimilada = :mat) AND
						( grupos.gpo_asimilado = :gp))) USING gtr_sce;
	end if
	error("UPDATE")
	i++
	st_1.text = string(i)
	FETCH INSCRITOS INTO :mat, :gp, :ins;
	error("FETCH")
loop
CLOSE INSCRITOS;
error("CLOSE")
commit USING gtr_sce;
text = "Actualiza Inscritos"
end event

