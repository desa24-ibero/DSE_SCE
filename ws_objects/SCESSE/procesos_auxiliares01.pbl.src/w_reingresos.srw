$PBExportHeader$w_reingresos.srw
forward
global type w_reingresos from window
end type
type st_replica from statictext within w_reingresos
end type
type uo_1 from uo_per_ani within w_reingresos
end type
type uo_nombre from uo_nombre_alumno within w_reingresos
end type
type dw_reingresos_hist_indulto from datawindow within w_reingresos
end type
type dw_hist_reingreso from datawindow within w_reingresos
end type
end forward

global type w_reingresos from window
integer x = 5
integer y = 4
integer width = 3529
integer height = 1772
boolean titlebar = true
string menuname = "m_reingresos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 27291696
st_replica st_replica
uo_1 uo_1
uo_nombre uo_nombre
dw_reingresos_hist_indulto dw_reingresos_hist_indulto
dw_hist_reingreso dw_hist_reingreso
end type
global w_reingresos w_reingresos

type variables
long cuenta = 0
boolean cap_anio 
end variables

on w_reingresos.create
if this.MenuName = "m_reingresos" then this.MenuID = create m_reingresos
this.st_replica=create st_replica
this.uo_1=create uo_1
this.uo_nombre=create uo_nombre
this.dw_reingresos_hist_indulto=create dw_reingresos_hist_indulto
this.dw_hist_reingreso=create dw_hist_reingreso
this.Control[]={this.st_replica,&
this.uo_1,&
this.uo_nombre,&
this.dw_reingresos_hist_indulto,&
this.dw_hist_reingreso}
end on

on w_reingresos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.uo_1)
destroy(this.uo_nombre)
destroy(this.dw_reingresos_hist_indulto)
destroy(this.dw_hist_reingreso)
end on

event open;// Juan Campos. Abril-1997.

this.x = 1
this.y = 1
String  Parametro 

Parametro = Message.StringParm 

dw_hist_reingreso.SetTransObject(gtr_sce)
dw_reingresos_hist_indulto.SetTransObject(gtr_sce)
w_reingresos.uo_nombre.em_cuenta.setfocus()
 
If Parametro = "REINGRESOS_E_INDULTOS" Then
	w_reingresos.title = "REINGRESOS E INDULTOS"	   
End If     

If Parametro = "INDULTOS_EXTEMPORANEOS" Then
	w_reingresos.title = "INDULTOS_EXTEMPORÁNEOS"	 
End If     


end event

event doubleclicked;// Juan Campos. Abril-1997.
int res
Cuenta = long(w_reingresos.uo_nombre.em_cuenta.text)

if cuenta <> 0 then  
	if w_reingresos.title = "REINGRESOS E INDULTOS"	 THEN
		if dw_hist_reingreso.retrieve(Cuenta) = 0 Then 
			dw_hist_reingreso.insertrow(0)
		else
			if (MessageBox("Atención", "Este alumno ya tiene un reingreso desea insertar uno nuevo?",&
				Information! , YesNo!, 2) = 1) then
				dw_hist_reingreso.insertrow(0)
			end if
		end if
	end if
	if w_reingresos.title = "INDULTOS_EXTEMPORÁNEOS" Then
		dw_hist_reingreso.settaborder(2,3)
		dw_hist_reingreso.settaborder(4,2)
		dw_hist_reingreso.settaborder(3,1)
		dw_hist_reingreso.setcolumn(3)
		dw_hist_reingreso.retrieve(0)
		dw_hist_reingreso.insertrow(0)
	end if	
	dw_hist_reingreso.setfocus()
else
	w_reingresos.uo_nombre.em_cuenta.setfocus()
end if
end event

type st_replica from statictext within w_reingresos
integer x = 3328
integer y = 36
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

event constructor;n_transfiere_sybase_sql ln_transfiere_sybase_sql
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
integer li_replica_activa, li_obten_parametros_replicacion
li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type uo_1 from uo_per_ani within w_reingresos
integer x = 2034
integer y = 492
integer taborder = 21
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_nombre from uo_nombre_alumno within w_reingresos
integer x = 50
integer y = 36
integer width = 3241
integer height = 444
integer taborder = 20
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type dw_reingresos_hist_indulto from datawindow within w_reingresos
integer x = 2135
integer y = 1056
integer width = 928
integer height = 388
integer taborder = 10
string dataobject = "dw_reingresos_hist_indulto"
boolean border = false
boolean livescroll = true
end type

type dw_hist_reingreso from datawindow within w_reingresos
event keyboard pbm_dwnkey
integer x = 146
integer y = 928
integer width = 2999
integer height = 608
integer taborder = 30
string dataobject = "dw_hist_reingreso"
boolean border = false
boolean livescroll = true
end type

event keyboard;// Si la varieble actualiza es "True", se actualiza la tabla de banderas, 
// se inserta en la tabla de hist_indulto si se le otorga
// un indulto al alumno, se inserta en la tabla de hist_reingreso siempre que
// el alumno no este inscrito en el semestre anterior.
// Juan Campos Abril. 1997.

Boolean Actualiza = False

if key = keyenter! Then	
	String  columna
	SetRow(1)
	Columna = GetColumnname( )
	if Columna = "periodo_ing" then
		setrow(1)
      SetColumn("anio_ing")		
	end if
 	if Columna = "anio_ing" then
		setrow(1)
      	SetColumn("cve_formaingreso")		
	end if
 	if Columna = "cve_formaingreso" then
      	Actualiza = True
	else
		Actualiza = False
	end if
end if
	
if Actualiza Then
	
	integer	FlagInscSemAnterior, FlagPromedio, FlagBaja3Reprobadas, FlagBaja4Inscritas, &
         			IndultoAmonestadoPromedio, IndultoBaja3Reprobadas, ActualizaOK, &
				IndultoBaja4Inscritas, IndultoSituacion, /*Periodo,*/ CveFormaIngresoNuevo, &
				Flagbaja_disciplina,Flagbaja_documentos/*,Año*/
	Boolean	MovimientoOk,InscritoAnterior

	select insc_sem_ant, cve_flag_promedio, baja_3_reprob, baja_4_insc, baja_disciplina,baja_documentos
	into :FlagInscSemAnterior, :FlagPromedio, :FlagBaja3Reprobadas, :FlagBaja4Inscritas,:Flagbaja_disciplina,:Flagbaja_documentos
	from banderas
	where cuenta = :cuenta using gtr_sce;
	
	if gtr_sce.sqlcode = 0 Then
	 	if FlagInscSemAnterior = 0 Then   // 0 = Inscrito Anterior No
			InscritoAnterior = False
       		update banderas 
		   	set insc_sem_ant = 1        // 1 = Inscrito Anterior Si
		  	where cuenta = :cuenta using gtr_sce;
		else
			InscritoAnterior = True
		end if
		if gtr_sce.sqlcode = 0 Then
			MovimientoOk = True
		else
			Messagebox("Error","Al actualizar inscrito anterior")
			MovimientoOk = False
		end if
	else
		Messagebox("Error","Al obtener banderas del alumno")
		MovimientoOk = False
	end if

	if MovimientoOk  Then
//		integer PeriodoNuevo 
//		long    AñoNuevo
		//periodo_actual(Periodo,Año,gtr_sce)	
//	   	Choose Case periodo
//		Case 0 to 1
//			if w_reingresos.title = "REINGRESOS E INDULTOS" Then
//				PeriodoNuevo = Periodo + 1
//				AñoNuevo = Año
		   	w_reingresos.dw_hist_reingreso.SetItem(1, "periodo_ing",gi_periodo)
				w_reingresos.dw_hist_reingreso.SetItem(1, "anio_ing",gi_anio)
//			else 
//				PeriodoNuevo = w_reingresos.dw_hist_reingreso.GetItemNumber(1, "periodo_ing")	
//			  	AñoNuevo = 	w_reingresos.dw_hist_reingreso.GetItemNumber(1, "anio_ing")			
//		   	end if
//			if w_reingresos.dw_hist_reingreso.AcceptText( ) = 1 then
//            		MovimientoOk = True
// 			else
//			  	MovimientoOk = False
//         		end if
//		Case 2
//			if w_reingresos.title = "REINGRESOS E INDULTOS" Then
//				PeriodoNuevo = Periodo - 2
//   				AñoNuevo = Año + 1 
//				w_reingresos.dw_hist_reingreso.SetItem(1, "periodo_ing",PeriodoNuevo)
//		   		w_reingresos.dw_hist_reingreso.SetItem(1, "anio_ing",AñoNuevo)
//			else 
//				PeriodoNuevo = w_reingresos.dw_hist_reingreso.GetItemNumber(1, "periodo_ing")	
//			   	AñoNuevo = 	w_reingresos.dw_hist_reingreso.GetItemNumber(1, "anio_ing")						
//			end if
//			if w_reingresos.dw_hist_reingreso.AcceptText( ) = 1 then
//            		MovimientoOk = True
// 			else
//			   	MovimientoOk = False
//         		end if
//		Case else	
//			MovimientoOk = False
//			Messagebox("Error","Al obtener el Periodo y año siguiente")
//		End Choose
	end if	
	
	if MovimientoOk  Then
		if FlagPromedio = 2 Then           // 2 = Baja
			IndultoAmonestadoPromedio = MessageBox("EL alumno esta dado de baja por puntaje","Desea Indultarlo",question!,YesNo!,1)
         		if IndultoAmonestadoPromedio = 1 Then
            		update banderas 
 				set cve_flag_promedio = 1 // 1 = Amonestado
				where cuenta = :cuenta using gtr_sce;
				if gtr_sce.sqlcode = 0 Then
					w_reingresos.dw_reingresos_hist_indulto.insertrow(0)
					w_reingresos.dw_reingresos_hist_indulto.SetItem(1, "cve_indulto","P")
					if w_reingresos.dw_reingresos_hist_indulto.AcceptText( ) = 1 then
						if inserta_hist_indulto(Cuenta,"P",gi_periodo,gi_anio) then
							MovimientoOk = True
						else
							MovimientoOk = False
						end if
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
			IndultoBaja3Reprobadas = MessageBox("EL alumno esta dado de baja por 3 reprobadas","Desea Indultarlo",question!,YesNo!,1)
       		if IndultoBaja3Reprobadas = 1 Then
            		update banderas 
 				set baja_3_reprob = 0          // 0 = No
				where cuenta = :cuenta using gtr_sce;
				if gtr_sce.sqlcode = 0 Then
				   	w_reingresos.dw_reingresos_hist_indulto.insertrow(0)
					w_reingresos.dw_reingresos_hist_indulto.SetItem(1, "cve_indulto","3")
					if w_reingresos.dw_reingresos_hist_indulto.AcceptText( ) = 1 then
						if inserta_hist_indulto(Cuenta,"3",gi_periodo,gi_anio) then		
						   MovimientoOk = True
						else
							MovimientoOk = False
						end if					
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
			IndultoBaja4Inscritas = MessageBox("EL alumno esta dado de baja por 4 inscripciones","Desea Indultarlo",question!,YesNo!,1)
         		if IndultoBaja4Inscritas = 1 Then
            		update banderas 
 				set baja_4_insc = 0           // 0 = No
				where cuenta = :cuenta using gtr_sce;
				if gtr_sce.sqlcode = 0 Then
					w_reingresos.dw_reingresos_hist_indulto.insertrow(0)
					w_reingresos.dw_reingresos_hist_indulto.SetItem(1, "cve_indulto","4")
					if w_reingresos.dw_reingresos_hist_indulto.AcceptText( ) = 1 then
						if inserta_hist_indulto(Cuenta,"4",gi_periodo,gi_anio) then					
						   MovimientoOk = True
						else
							MovimientoOk = False
						end if						 
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
			IndultoSituacion = MessageBox("EL alumno esta dado de baja por disciplina","Desea Indultarlo",question!,YesNo!,1)
         		if IndultoSituacion = 1 Then
            		update banderas 
 				set baja_disciplina = 0 		// 0 = False baja por disciplina
				where cuenta = :cuenta using gtr_sce;
				if gtr_sce.sqlcode = 0 Then
					w_reingresos.dw_reingresos_hist_indulto.insertrow(0)
					w_reingresos.dw_reingresos_hist_indulto.SetItem(1, "cve_indulto","D")
					if w_reingresos.dw_reingresos_hist_indulto.AcceptText( ) = 1 then
						if inserta_hist_indulto(Cuenta,"D",gi_periodo,gi_anio) then					
						   MovimientoOk = True
						else
							MovimientoOk = False
						end if						 
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
		CveFormaIngresoNuevo = w_reingresos.dw_hist_reingreso.GetItemNumber(1, "cve_formaingreso")		
		if inserta_hist_reingreso(Cuenta,CveFormaIngresoNuevo,gi_periodo,gi_anio) then
			MovimientoOk = True
		else
			MovimientoOk = False
		end if
		
	end if

	if MovimientoOk  Then
		ActualizaOK = Messagebox("Aviso","Desea guardar los cambios",Question!,YesNo!,1)
		if ActualizaOK = 1 Then 
			Commit Using gtr_sce;		
			
			//INICIO:Replica a Internet
			transaction ltr_web
			n_transfiere_sybase_sql ln_transfiere_sybase_sql
			ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
			string ls_classname
			long ll_cuentas[]
			integer li_replica_activa, li_obten_parametros_replicacion, li_res_actualizacion
				li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
				if li_replica_activa = 1 then
					w_reingresos.st_replica.text = 'A'
					w_reingresos.st_replica.BackColor =RGB(0,255,0)
					ls_classname =	w_reingresos.ClassName()
					ll_cuentas[1] = cuenta
					li_res_actualizacion = ln_transfiere_sybase_sql.of_actualizacion_objeto_replica(ll_cuentas, ls_classname, gtr_sce, ltr_web)
				else
					w_reingresos.st_replica.text = 'I'
					w_reingresos.st_replica.BackColor =RGB(255,0,0)
				end if
			//FIN:Replica a Internet		
			
		else
		 	Rollback using gtr_sce;	
		end If
	else
		Rollback using gtr_sce;	
		Messagebox("Aviso","No se han guardado los cambios")
	end if
	dw_hist_reingreso.Retrieve(0)
	dw_reingresos_hist_indulto.Retrieve(0)
	w_reingresos.uo_nombre.em_cuenta.setfocus()
end if  
  
keydown (keyA!)
end event

event itemchanged;// Juan Campos. Abril-1997.

long	añoaux
string	columna

SetRow(1)
Columna = GetColumnname( )

if Columna = "anio_ing" Then  // año 
	if dw_hist_reingreso.AcceptText( ) = 1 Then
		AñoAux = GetitemNumber(1,"anio_ing")	
		if AñoAux < 100 then
			SetItem(1,"anio_ing", 1900 + AñoAux)
			AcceptText( )
			AñoAux = GetitemNumber(1,"anio_ing")			   
		End if
		if AñoAux > 1950  And AñoAux < 2100 Then
//		  cap_anio = true
//		  IF keydown(keyenter!) then
//	        SetColumn("cve_indulto")
//        end if
//		  IF keydown(keytab!) then
//	        SetColumn("anio_ing")	
//        end if
			Filter()
		  	return 0  // acepta el valor
		Else
			cap_anio = False
			Messagebox("Años Validos","1950 al 2100]")
      		setitem(1,"anio_ing","")
			Return 1 // rechaza el valor y no deja cambiar de focus
		end if		
	else
		cap_anio = false
      	setitem(1,"anio_ing","")
	   	Return 1 // rechaza el valor y no deja cambiar de focus
	end if
end if

end event

