$PBExportHeader$w_sem_cursados.srw
forward
global type w_sem_cursados from w_ancestral
end type
type em_2 from editmask within w_sem_cursados
end type
type em_1 from editmask within w_sem_cursados
end type
type cb_2 from commandbutton within w_sem_cursados
end type
type st_1 from statictext within w_sem_cursados
end type
type cb_1 from commandbutton within w_sem_cursados
end type
type dw_1 from datawindow within w_sem_cursados
end type
end forward

global type w_sem_cursados from w_ancestral
int Width=3041
int Height=1085
boolean TitleBar=true
string Title="Corte de Semestres Cursados"
em_2 em_2
em_1 em_1
cb_2 cb_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
end type
global w_sem_cursados w_sem_cursados

on w_sem_cursados.create
int iCurrent
call w_ancestral::create
this.em_2=create em_2
this.em_1=create em_1
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=em_2
this.Control[iCurrent+2]=em_1
this.Control[iCurrent+3]=cb_2
this.Control[iCurrent+4]=st_1
this.Control[iCurrent+5]=cb_1
this.Control[iCurrent+6]=dw_1
end on

on w_sem_cursados.destroy
call w_ancestral::destroy
destroy(this.em_2)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type em_2 from editmask within w_sem_cursados
int X=353
int Y=737
int Width=325
int Height=101
int TabOrder=40
Alignment Alignment=Center!
string Mask="######"
string DisplayData=""
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_sem_cursados
int X=353
int Y=593
int Width=325
int Height=101
int TabOrder=50
Alignment Alignment=Center!
string Mask="######"
string DisplayData="<Dw_integracion"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_sem_cursados
event clicked pbm_bnclicked
int X=1793
int Y=157
int Width=499
int Height=109
int TabOrder=30
string Text="Guarda Cambios"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_1.modifiedcount() > 0 then
	if messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesno!)=1 then
		dw_1.AcceptText()
		messagebox("A punto de hacer COMMIT; y update()","Deje de hacer lo que este haciendo")
		if dw_1.update(true) >= 1 then		
			commit using gtr_sce;
		else
			rollback using gtr_sce;
		end if
	else
		rollback using gtr_sce;
	end if
end if
end event

type st_1 from statictext within w_sem_cursados
int X=19
int Y=429
int Width=2967
int Height=77
boolean Enabled=false
string Text="Status"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_sem_cursados
event clicked pbm_bnclicked
int X=750
int Y=157
int Width=855
int Height=109
int TabOrder=10
string Text="Corte de Semestres Cursados"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/*Carga la bandera de semestres cursados de los que se actualizarán*/
dw_1.retrieve(long(em_1.text),long(em_2.text))
end event

type dw_1 from datawindow within w_sem_cursados
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
event retrieverow pbm_dwnretrieverow
int X=1226
int Y=525
int Width=942
int Height=445
int TabOrder=20
string DataObject="d_sem_cursados"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;long lo_cuenta,lo_cont
int in_carrera,in_plan,in_semestres

st_1.text='Terminada la Carga'
/*Carga los datos de los que cursaron materias en el semestre (Academicos)*/

FOR lo_cont=1 TO rowcount
	lo_cuenta=dw_1.object.cuenta[lo_cont]
	in_carrera=dw_1.object.cve_carrera[lo_cont]
	in_plan=dw_1.object.cve_plan[lo_cont]
	st_1.text=string(lo_cuenta) /*Despliega el número de cuenta (Para ver si ya me trabe)*/
	
	if in_carrera<>0 and in_plan<>0 then
	
		SELECT count(count(anio))
		INTO :in_semestres
		FROM historico,materias
		WHERE ( historico.periodo <> 1 ) AND  
				( historico.cuenta = :lo_cuenta ) AND
				( historico.cve_carrera = :in_carrera) AND
				( historico.cve_plan = :in_plan) AND
				( historico.cve_mat = materias.cve_mat ) AND
				( materias.creditos > 0 ) 
		GROUP BY historico.cuenta,
				historico.anio,   
				historico.periodo
		USING gtr_sce;
				
		dw_1.object.sem_cursados[lo_cont]=in_semestres
	end if
NEXT

st_1.text='Terminado el Cálculo'
end event

event retrieverow;/*Despliega un mensaje cad vez que se carga un renglón (para mostrar que no te has trabado)*/
st_1.text='Cargando '+string(row)
end event

