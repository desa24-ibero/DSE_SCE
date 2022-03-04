$PBExportHeader$w_reingresos_2013.srw
forward
global type w_reingresos_2013 from w_master_main
end type
type st_replica from statictext within w_reingresos_2013
end type
type dw_hist_reingreso from uo_master_dw within w_reingresos_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_reingresos_2013
end type
type dw_reingresos_hist_indulto from uo_master_dw within w_reingresos_2013
end type
type uo_1 from uo_per_ani within w_reingresos_2013
end type
type r_2 from rectangle within w_reingresos_2013
end type
type r_1 from rectangle within w_reingresos_2013
end type
end forward

global type w_reingresos_2013 from w_master_main
integer width = 4439
integer height = 2724
string title = "Reingresos e indultos"
string menuname = "m_reingresos_2013"
boolean clientedge = true
event double ( )
st_replica st_replica
dw_hist_reingreso dw_hist_reingreso
uo_nombre uo_nombre
dw_reingresos_hist_indulto dw_reingresos_hist_indulto
uo_1 uo_1
r_2 r_2
r_1 r_1
end type
global w_reingresos_2013 w_reingresos_2013

type variables
boolean ib_modificando=false
Datawindowchild dwc_subsis,dwc_carrera,dwc_plan
integer ii_sw
long il_cuenta,il_carrera, il_plan
integer	FlagInscSemAnterior, FlagPromedio, FlagBaja3Reprobadas, FlagBaja4Inscritas, &
        			IndultoAmonestadoPromedio, IndultoBaja3Reprobadas, ActualizaOK, &
				IndultoBaja4Inscritas, IndultoSituacion, /*Periodo,*/ CveFormaIngresoNuevo, &
				Flagbaja_disciplina,Flagbaja_documentos/*,Año*/
Boolean	InscritoAnterior
Datawindowchild dwc_periodo
end variables

forward prototypes
public function integer wf_validar ()
public function integer wf_busca_indulto (string an_indulto)
end prototypes

public function integer wf_validar ();
return 1


end function

public function integer wf_busca_indulto (string an_indulto);int existe

select count(*)
  into :Existe
  from hist_indulto
 where (cuenta      = :il_cuenta) and
       (cve_indulto = :an_indulto) and
		 (periodo     = :gi_periodo) and
		 (anio        = :gi_anio) using gtr_sce;
		 
if gtr_sce.sqlcode <> 0 then
	existe = 0
end if

return Existe
end function

on w_reingresos_2013.create
int iCurrent
call super::create
if this.MenuName = "m_reingresos_2013" then this.MenuID = create m_reingresos_2013
this.st_replica=create st_replica
this.dw_hist_reingreso=create dw_hist_reingreso
this.uo_nombre=create uo_nombre
this.dw_reingresos_hist_indulto=create dw_reingresos_hist_indulto
this.uo_1=create uo_1
this.r_2=create r_2
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_replica
this.Control[iCurrent+2]=this.dw_hist_reingreso
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.dw_reingresos_hist_indulto
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.r_2
this.Control[iCurrent+7]=this.r_1
end on

on w_reingresos_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_hist_reingreso)
destroy(this.uo_nombre)
destroy(this.dw_reingresos_hist_indulto)
destroy(this.uo_1)
destroy(this.r_2)
destroy(this.r_1)
end on

event doubleclicked;call super::doubleclicked;long cuentalocal,ll_ren
int sub_sist

il_cuenta = long(uo_nombre.of_obten_cuenta())

if il_cuenta = 0 then return

if dw_hist_reingreso.retrieve(uo_nombre.of_obten_cuenta()) = 0 then
	triggerevent('ue_nuevo')
else
	if (MessageBox("Atención", "Este alumno ya tiene un reingreso desea insertar uno nuevo?",Information! , YesNo!, 2) = 1) then
		triggerevent('ue_nuevo')
	else
		dw_reingresos_hist_indulto.retrieve(uo_nombre.of_obten_cuenta())
	end if
end if




end event

event open;call super::open;//m_menu_general_2013.m_registro.m_nuevo.enabled = False
//m_menu_general_2013.m_archivo.m_imprimir.enabled = true

dw_hist_reingreso.settransobject(gtr_sce)
dw_reingresos_hist_indulto.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!) 
/**/gnv_app.inv_security.of_SetSecurity(this)

//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_hist_reingreso, dwc_periodo, "periodo_ing")

end event

event ue_actualiza;call super::ue_actualiza;Int  Carrera,Plan,li_res,li_replica_activa
Boolean MovimientoOk = True

if ib_modificando then
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if

	if dw_hist_reingreso.update(true) = 1 then
	 	if FlagInscSemAnterior = 0 Then   // 0 = Inscrito Anterior No
			InscritoAnterior = False
       		update banderas 
		   	set insc_sem_ant = 1        // 1 = Inscrito Anterior Si
		  	where cuenta = :il_cuenta using gtr_sce;
			if gtr_sce.sqlcode = 0 then
				MovimientoOk = True
			else
				Messagebox("Error","Al actualizar inscrito anterior")
				MovimientoOk = False
			end if
		else
			InscritoAnterior = True
		end if
		
		if MovimientoOk  Then
			if FlagPromedio = 2 Then           // 2 = Baja
		 		if IndultoAmonestadoPromedio = 1 Then
	            		update banderas 
 					set cve_flag_promedio = 1 // 1 = Amonestado
					where cuenta = :il_cuenta using gtr_sce;
					if gtr_sce.sqlcode = 0 Then
						if dw_reingresos_hist_indulto.update(true) = 1 then
							MovimientoOk = True
						else
							MovimientoOk = False
						end if
					else
						Messagebox("Error","Al actualizar bandera de promedio")
						MovimientoOk = False
         	   		end if					
         		end if
	      	end if
		end if
	
		if MovimientoOk  Then
			if FlagBaja3Reprobadas = 1 Then         // 1 = Si
      	 		if IndultoBaja3Reprobadas = 1 Then
	            		update banderas 
 					set baja_3_reprob = 0          // 0 = No
					where cuenta = :il_cuenta using gtr_sce;
					if gtr_sce.sqlcode = 0 Then
						if dw_reingresos_hist_indulto.update(true) = 1 then
						   MovimientoOk = True
						else
							MovimientoOk = False
						end if					
					else
						Messagebox("Error","Al actualizar bandera de 3 reprobadas")
						MovimientoOk = False
         	   		end if					
		      	end if
		 	end if
		end if
	
		if MovimientoOk  Then
			if FlagBaja4Inscritas = 1 Then         // 1 = Si
				if IndultoBaja4Inscritas = 1 Then
					update banderas 
					set baja_4_insc = 0           // 0 = No
					where cuenta = :il_cuenta using gtr_sce;
					if gtr_sce.sqlcode = 0 Then
						if dw_reingresos_hist_indulto.update(true) = 1 then			
							MovimientoOk = True
						else
							MovimientoOk = False
						end if						 
					else
						Messagebox("Error","Al actualizar bandera de 4 inscripciones")
						MovimientoOk = False
					end if					
				end if
			end if
		end if	

		if MovimientoOk  Then
			if FlagBaja_Disciplina = 1 Then		// 1 = True baja por disciplina
				if IndultoSituacion = 1 Then
					update banderas 
					set baja_disciplina = 0 		// 0 = False baja por disciplina
					where cuenta = :il_cuenta using gtr_sce;
					if gtr_sce.sqlcode = 0 Then
						if dw_reingresos_hist_indulto.update(true) = 1 then			
							MovimientoOk = True
						else
							MovimientoOk = False
						end if						 
					else
						Messagebox("Error","Al actualizar bandera de disciplina")
						MovimientoOk = False
					end if					
				end if
			end if
		end if		
		
		if MovimientoOk  Then
			commit using gtr_sce;	
		
			//INICIO:Replica a Internet
			li_replica_activa = f_replica_Activa()
			if li_replica_activa = 1 then
				f_replica_internet(this,il_cuenta)
				st_replica.text = 'A'
				st_replica.BackColor =RGB(0,255,0)
			else
				st_replica.text = 'I'
				st_replica.BackColor =RGB(255,0,0)
			end if
			//FIN:Replica a Internet						
				
			messagebox("Información","Se han guardado los cambios")				
		else
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return
		end if
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if
else
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if
end event

event activate;//
end event

event closequery;//
end event

event ue_nuevo;call super::ue_nuevo;long ll_ren

ll_ren = dw_hist_reingreso.insertrow(0)

dw_hist_reingreso.Setitem(ll_ren,'periodo_ing',gi_periodo)
dw_hist_reingreso.Setitem(ll_ren,'anio_ing',gi_anio)
dw_hist_reingreso.Setitem(ll_ren,'cuenta',il_cuenta)

select insc_sem_ant, cve_flag_promedio, baja_3_reprob, baja_4_insc, baja_disciplina,baja_documentos
into :FlagInscSemAnterior, :FlagPromedio, :FlagBaja3Reprobadas, :FlagBaja4Inscritas,:Flagbaja_disciplina,:Flagbaja_documentos
from banderas
where cuenta = :il_cuenta using gtr_sce;
	
if gtr_sce.sqlcode = 0 Then
 	if FlagInscSemAnterior = 0 Then   // 0 = Inscrito Anterior No
		InscritoAnterior = False
	else
		InscritoAnterior = True
	end if
else
	Messagebox("Error","Al obtener banderas del alumno")
end if
	
if gtr_sce.sqlcode = 0  Then
	if FlagPromedio = 2 Then           // 2 = Baja
		if wf_busca_indulto('P') = 0 then
			IndultoAmonestadoPromedio = MessageBox("Aviso","EL alumno esta dado de baja por puntaje, ~r¿Desea Indultarlo?",question!,YesNo!,1)
   		   	if IndultoAmonestadoPromedio = 1 Then
				ll_ren = dw_reingresos_hist_indulto.insertrow(0)
				dw_reingresos_hist_indulto.SetItem(ll_ren, "cve_indulto","P")
				dw_reingresos_hist_indulto.Setitem(ll_ren,'cuenta',il_cuenta)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'periodo',gi_periodo)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'anio',gi_anio)
				ib_modificando = true
      		end if
		else
			dw_reingresos_hist_indulto.retrieve(uo_nombre.of_obten_cuenta())				
		end if
	end if
	
	if FlagBaja3Reprobadas = 1 Then         // 1 = Si
		if wf_busca_indulto('3') = 0 then
			IndultoBaja3Reprobadas = MessageBox("Aviso","EL alumno esta dado de baja por 3 reprobadas~r¿Desea Indultarlo?",question!,YesNo!,1)
   	 		if IndultoBaja3Reprobadas = 1 Then
				ll_ren =  dw_reingresos_hist_indulto.insertrow(0)
				dw_reingresos_hist_indulto.SetItem(ll_ren, "cve_indulto","3")
				dw_reingresos_hist_indulto.Setitem(ll_ren,'cuenta',il_cuenta)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'periodo',gi_periodo)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'anio',gi_anio)
				ib_modificando = true
			end if
		else
			dw_reingresos_hist_indulto.retrieve(uo_nombre.of_obten_cuenta())						
      	end if
 	end if
	
	if FlagBaja4Inscritas = 1 Then         // 1 = Si
		if wf_busca_indulto('4') = 0 then
			IndultoBaja4Inscritas = MessageBox("Aviso","EL alumno esta dado de baja por 4 inscripciones, ~r¿Desea Indultarlo?",question!,YesNo!,1)
    			if IndultoBaja4Inscritas = 1 Then
				ll_ren = dw_reingresos_hist_indulto.insertrow(0)
				dw_reingresos_hist_indulto.SetItem(ll_ren, "cve_indulto","4")
				dw_reingresos_hist_indulto.Setitem(ll_ren,'cuenta',il_cuenta)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'periodo',gi_periodo)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'anio',gi_anio)
				ib_modificando = true
			end if
		else
			dw_reingresos_hist_indulto.retrieve(uo_nombre.of_obten_cuenta())			
      	end if
   	end if	

	if FlagBaja_Disciplina = 1 Then		// 1 = True baja por disciplina
		if wf_busca_indulto('D') = 0 then
			IndultoSituacion = MessageBox("Aviso","EL alumno esta dado de baja por disciplina,¿Desea Indultarlo?",question!,YesNo!,1)
   	 		if IndultoSituacion = 1 Then
				ll_ren = dw_reingresos_hist_indulto.insertrow(0)
				dw_reingresos_hist_indulto.SetItem(ll_ren, "cve_indulto","D")
				dw_reingresos_hist_indulto.Setitem(ll_ren,'cuenta',il_cuenta)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'periodo',gi_periodo)
				dw_reingresos_hist_indulto.Setitem(ll_ren,'anio',gi_anio)
				ib_modificando = true
			end if
		else
			dw_reingresos_hist_indulto.retrieve(uo_nombre.of_obten_cuenta())			
      	end if
   	end if		
end if
end event

event close;if ib_modificando then
	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
		if wf_validar () <> 1 then 	
			rollback using gtr_sce;
			messagebox("Información","No se han guardado los cambios")	
			return 
		else
			 triggerevent("ue_actualiza")
		end if
	end if
end if
end event

event ue_imprime;call super::ue_imprime;
setpointer(Hourglass!) 

OpenSheet(w_imprime_hist_reingresos,w_reingresos_2013,4,Original!)  

end event

type st_sistema from w_master_main`st_sistema within w_reingresos_2013
end type

type p_ibero from w_master_main`p_ibero within w_reingresos_2013
end type

type st_replica from statictext within w_reingresos_2013
integer x = 3342
integer y = 328
integer width = 110
integer height = 88
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;integer li_replica_activa

li_replica_activa = f_replica_Activa()

if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type dw_hist_reingreso from uo_master_dw within w_reingresos_2013
integer x = 119
integer y = 1044
integer width = 1728
integer height = 444
integer taborder = 40
string dataobject = "dw_hist_reingreso_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;ib_modificando = true
idw_trabajo = this

end event

event constructor;call super::constructor;idw_trabajo = this
m_reingresos_2013.dw = this
end event

type uo_nombre from uo_nombre_alumno_2013 within w_reingresos_2013
integer x = 101
integer y = 324
integer width = 3250
integer height = 320
integer taborder = 20
end type

event constructor;call super::constructor;m_reingresos_2013.objeto =this

end event

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type dw_reingresos_hist_indulto from uo_master_dw within w_reingresos_2013
integer x = 1893
integer y = 1044
integer width = 1413
integer height = 500
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_reingresos_hist_indulto_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;idw_trabajo = this
end event

type uo_1 from uo_per_ani within w_reingresos_2013
integer x = 1088
integer y = 724
integer width = 1253
integer height = 168
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type r_2 from rectangle within w_reingresos_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 1870
integer y = 1012
integer width = 1445
integer height = 548
end type

type r_1 from rectangle within w_reingresos_2013
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 110
integer y = 1012
integer width = 1746
integer height = 548
end type

