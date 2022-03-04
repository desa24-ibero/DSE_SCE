$PBExportHeader$uo_nombre_alu_foto.sru
forward
global type uo_nombre_alu_foto from uo_nombre_alumno
end type
type uo_foto from powerimage32 within uo_nombre_alu_foto
end type
end forward

global type uo_nombre_alu_foto from uo_nombre_alumno
integer width = 3589
uo_foto uo_foto
end type
global uo_nombre_alu_foto uo_nombre_alu_foto

on uo_nombre_alu_foto.create
int iCurrent
call super::create
this.uo_foto=create uo_foto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_foto
end on

on uo_nombre_alu_foto.destroy
call super::destroy
destroy(this.uo_foto)
end on

type em_digito from uo_nombre_alumno`em_digito within uo_nombre_alu_foto
integer x = 1231
integer y = 32
end type

type st_2 from uo_nombre_alumno`st_2 within uo_nombre_alu_foto
integer x = 1175
integer y = 32
end type

type st_1 from uo_nombre_alumno`st_1 within uo_nombre_alu_foto
integer x = 398
integer y = 32
end type

type r_2 from uo_nombre_alumno`r_2 within uo_nombre_alu_foto
integer x = 1298
integer y = 28
end type

type dw_nombre_alumno from uo_nombre_alumno`dw_nombre_alumno within uo_nombre_alu_foto
integer x = 389
integer y = 144
integer width = 3168
end type

event dw_nombre_alumno::itemchanged;string ls_nombre,ls_apat,ls_amat,ls_columna
char lch_digito
long ll_cuenta

param_obj_nombre origen

if cbx_nuevo.checked = false then
	
	ls_columna = dw_nombre_alumno.getcolumnname()

	CHOOSE CASE ls_columna
		CASE "nombre"
		     ls_nombre ="%"+dw_nombre_alumno.gettext()+"%"
			  ls_apat="%--%"
			  ls_amat="%--%"
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.nombre like :ls_nombre
				USING gtr_sce;
		CASE "apaterno"
			  ls_nombre="%--%"
			  ls_amat="%--%"			
			  ls_apat ="%"+dw_nombre_alumno.gettext()+"%"
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.apaterno like :ls_apat
				USING gtr_sce;
		CASE "amaterno"
			  ls_nombre="%--%"
			  ls_apat="%--%"
			  ls_amat ="%"+dw_nombre_alumno.gettext()+"%"			  
			  SELECT alumnos.cuenta  
	    		 INTO :ll_cuenta  
	    	    FROM alumnos  
	   		WHERE alumnos.amaterno like :ls_amat
				USING gtr_sce;
	END CHOOSE	
	
	if gtr_sce.sqlerrtext = "Select returned more than one row" then
		origen = entrega_ventana()
		openwithparm(w_alumnosnombre,origen)
		if w_alumnosnombre.dw_nombre.retrieve(ls_nombre,ls_apat,ls_amat)  = 0 then
			messagebox("Aviso","No existe ningun "+mid(ls_nombre,2,len(ls_nombre)-2)+" "+mid(ls_apat,2,len(ls_apat)-2)+" "+mid(ls_amat,2,len(ls_amat)-2)+" dado de alta.")
			close(w_alumnosnombre)
		end if	
	else
		if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
			dw_nombre_alumno.insertrow(0)
		else 
			em_cuenta.text=string(ll_cuenta)
			lch_digito = obten_digito(ll_cuenta)
			em_digito.text=lch_digito
			uo_foto.event busca(ll_cuenta,gtr_scred,30)
			iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
		end if	
	end if	
end if
end event

type r_3 from uo_nombre_alumno`r_3 within uo_nombre_alu_foto
end type

type cbx_nuevo from uo_nombre_alumno`cbx_nuevo within uo_nombre_alu_foto
end type

type r_1 from uo_nombre_alumno`r_1 within uo_nombre_alu_foto
integer x = 375
integer y = 12
end type

type em_cuenta from uo_nombre_alumno`em_cuenta within uo_nombre_alu_foto
integer x = 891
integer y = 32
end type

event em_cuenta::activarbusq;int li_cont
long ll_cuenta
char lch_digito,lch_dig
STRING ls_tipo_periodo, descripcion_tipo

	ll_cuenta = long(mid(em_cuenta.text,1,len(em_cuenta.text) - 1))
	if ll_cuenta > 1 then
		em_digito.text = upper(mid(em_cuenta.text,len(em_cuenta.text),1))
 
		em_cuenta.text = string(ll_cuenta)

		 SELECT alumnos.cuenta  
			   INTO :ll_cuenta  
		    FROM alumnos  
	      WHERE alumnos.cuenta = :ll_cuenta
			USING gtr_sce;

		if cbx_nuevo.checked = true then
			
			em_digito.text =obten_digito(long(em_cuenta.text))
			uo_foto.event busca(ll_cuenta,gtr_scred,30)
			iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
			iw_ventana.triggerevent(doubleclicked!)
			if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
			   dw_nombre_alumno.insertrow(0)
			end if
		elseif cbx_nuevo.checked = false then
			if gtr_sce.sqlcode = 100 then
				messagebox("Atención","El alumno con clave "+string(ll_cuenta)+" no existe.")
				em_cuenta.text = " "
				em_digito.text=" "
				uo_foto.event busca(ll_cuenta,gtr_scred,30)
				iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
				iw_ventana.triggerevent(doubleclicked!)
				if dw_nombre_alumno.retrieve(0) = 0 then
			  		 dw_nombre_alumno.insertrow(0)
				end if
				goto fin
			end if
			
			//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
			SELECT pe.tipo_periodo 
			INTO :ls_tipo_periodo 
			FROM academicos ac, plan_estudios pe
			WHERE ac.cve_plan = pe.cve_plan
			AND ac.cve_carrera = pe.cve_carrera 
			AND ac.cuenta = :ll_cuenta 
			USING gtr_sce;
			// Se verifica el tipo de periodo. 
			IF ls_tipo_periodo <> gs_tipo_periodo THEN 
				SELECT descripcion 
				INTO :descripcion_tipo 
				FROM periodo_tipo 
				WHERE id_tipo = :gs_tipo_periodo 
				USING gtr_sce;
				messagebox("Atención","El alumno con clave "+string(ll_cuenta)+" no es de tipo " + descripcion_tipo + ".")			
				em_cuenta.text = " " 
				em_digito.text=" " 
				dw_nombre_alumno.RESET() 
				dw_nombre_alumno.INSERTROW(0) 
				goto fin
			END IF
			//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**					
			
			
			em_cuenta.text = string(ll_cuenta)
			if em_digito.text = "" then
//			em_digito.setfocus()
			else	
				lch_digito = upper(em_digito.text)
				lch_dig = obten_digito(ll_cuenta)
				if lch_digito = lch_dig then	
					if dw_nombre_alumno.retrieve(ll_cuenta) = 0 then
					   dw_nombre_alumno.insertrow(0)
					end if
					uo_foto.event busca(ll_cuenta,gtr_scred,30)
				   iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
					iw_ventana.triggerevent(doubleclicked!)
				else
					messagebox("Atención","Revise que el dígito verificador esté correcto",StopSign!)			
				end if	
			
			end if	
		end if
	else 
		em_digito.text=" "
		em_cuenta.text = " "
		uo_foto.event busca(ll_cuenta,gtr_scred,30)
		iw_ventana.triggerevent("inicia_proceso",0,ll_cuenta)
		iw_ventana.triggerevent(doubleclicked!)
		if dw_nombre_alumno.retrieve(0) = 0 then
			  dw_nombre_alumno.insertrow(0)
		end if
		em_cuenta.setfocus()
	end if
fin:
end event

type uo_foto from powerimage32 within uo_nombre_alu_foto
integer width = 375
integer height = 412
boolean border = true
end type

event constructor;call super::constructor;if conecta_bd(gtr_scred,gs_scred,gs_usuario,gs_password)=0 then
//	close(parent)
end if
end event

event destructor;call super::destructor;desconecta_bd(gtr_scred)
end event

