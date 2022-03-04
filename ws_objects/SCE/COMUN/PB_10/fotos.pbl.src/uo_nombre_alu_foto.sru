$PBExportHeader$uo_nombre_alu_foto.sru
forward
global type uo_nombre_alu_foto from uo_nombre_alumno
end type
type uo_foto from powerimage32 within uo_nombre_alu_foto
end type
end forward

global type uo_nombre_alu_foto from uo_nombre_alumno
int Width=3589
uo_foto uo_foto
end type
global uo_nombre_alu_foto uo_nombre_alu_foto

on uo_nombre_alu_foto.create
int iCurrent
call uo_nombre_alumno::create
this.uo_foto=create uo_foto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=uo_foto
end on

on uo_nombre_alu_foto.destroy
call uo_nombre_alumno::destroy
destroy(this.uo_foto)
end on

type em_digito from uo_nombre_alumno`em_digito within uo_nombre_alu_foto
int X=1217
int Y=33
end type

type st_2 from uo_nombre_alumno`st_2 within uo_nombre_alu_foto
int X=1175
int Y=33
end type

type st_1 from uo_nombre_alumno`st_1 within uo_nombre_alu_foto
int X=398
int Y=33
end type

type r_2 from uo_nombre_alumno`r_2 within uo_nombre_alu_foto
int X=1299
int Y=29
end type

type dw_nombre_alumno from uo_nombre_alumno`dw_nombre_alumno within uo_nombre_alu_foto
int X=389
int Y=145
int Width=3169
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

type r_1 from uo_nombre_alumno`r_1 within uo_nombre_alu_foto
int X=375
int Y=13
end type

type em_cuenta from uo_nombre_alumno`em_cuenta within uo_nombre_alu_foto
int X=892
int Y=33
boolean BringToTop=true
end type

event em_cuenta::activarbusq;int li_cont
long ll_cuenta
char lch_digito,lch_dig

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
int X=1
int Y=1
int Width=375
int Height=413
boolean Border=true
BorderStyle BorderStyle=StyleBox!
long Style=1174405121
end type

event constructor;call super::constructor;if conecta_bd(gtr_scred,"scred",gs_usuario,gs_password)=0 then
//	close(parent)
end if
end event

event destructor;call super::destructor;desconecta_bd(gtr_scred)
end event

