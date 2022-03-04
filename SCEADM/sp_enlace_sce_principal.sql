IF OBJECT_ID ('dbo.sp_enlace_sce_principal') IS NOT NULL
	DROP PROCEDURE dbo.sp_enlace_sce_principal
GO

create procedure sp_enlace_sce_principal  @version   integer = 99,

	                                       @periodo   integer = null,

                                          @anio      integer = null,

                                          @folio_ini integer = null,

                                          @folio_fin integer = null

as



declare

	@mensaje_salida varchar(255),

   @mensaje_sp varchar(255),

	@resultado_sp integer,

   @cur_folio integer,

   @cur_cuenta integer,  

   @cur_clv_ver integer,  

   @cur_clv_per integer,  

   @cur_anio integer,  

   @cur_ing_per integer,

   @cur_ing_anio integer,  

   @mensaje_error varchar(255),

	@num_error integer



-- Asignacion de variables 



-- Revision de los parametros exigidos

if @version in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar la version"

	Goto EtiquetaError

end



if @periodo in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar el periodo"

	Goto EtiquetaError

end



if @anio in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar el anio"

	Goto EtiquetaError

end



if @folio_ini in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar un folio inicial"

	Goto EtiquetaError

end



if @folio_fin in (null)  

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar un folio final"
	Goto EtiquetaError

END


	Begin transaction

	update parametros_admision
	set enlace_corriendo = 1
	if @@error != 0 
	begin
		SELECT @mensaje_error = "Error al actualizar parametros_admision"
		goto EtiquetaError
	end
	else
	begin
		commit transaction
	end


--Declara un cursor para los datos susceptibles de enlace



declare cursor_enlace_aspirantes cursor

FOR 

SELECT DISTINCT

         dbo.aspiran.folio,

         dbo.general.cuenta,  

         dbo.aspiran.clv_ver,  

         dbo.aspiran.clv_per,  

         dbo.aspiran.anio,  

         dbo.aspiran.ing_per,

         dbo.aspiran.ing_anio  

    FROM dbo.aspiran,   

         dbo.general,   

         dbo.padres

    WHERE ( dbo.aspiran.folio = dbo.padres.folio ) AND  

         ( dbo.aspiran.clv_ver = dbo.padres.clv_ver ) AND  

         ( dbo.aspiran.clv_per = dbo.padres.clv_per ) AND  

         ( dbo.aspiran.anio = dbo.padres.anio ) AND  

         ( dbo.aspiran.folio = dbo.general.folio ) AND  

         ( dbo.general.clv_ver = dbo.aspiran.clv_ver ) AND  

         ( dbo.aspiran.clv_per = dbo.general.clv_per ) AND  

         ( dbo.general.anio = dbo.aspiran.anio ) AND  

         ( ( dbo.aspiran.clv_ver = @version ) OR (@version = 99) ) AND  

		( dbo.aspiran.clv_per = @periodo ) AND
		
		( dbo.aspiran.ing_per = @periodo ) AND
		
		( dbo.aspiran.ing_anio = @anio ) AND

         ( dbo.aspiran.folio between @folio_ini and @folio_fin ) AND  

         ( dbo.general.cuenta <> 0 ) AND

		  ( dbo.aspiran.status IN (1,4)) 



-- Abre el cursor 

open cursor_enlace_aspirantes



-- Lee el primer registro 

fetch cursor_enlace_aspirantes

into 

   @cur_folio,

   @cur_cuenta,  

   @cur_clv_ver,  

   @cur_clv_per,  

   @cur_anio,  

   @cur_ing_per,

   @cur_ing_anio



-- El result set se encuentra vacío 

if (@@sqlstatus = 2)

begin

    select @mensaje_error = "No existen movimientos a Procesar."

    close cursor_enlace_aspirantes

    goto Fin

end



-- Si ocurrio un error, llamar al manejador designado 

if (@@sqlstatus = 1) 

begin

   select @num_error = 20000, @mensaje_error = "Error de lectura en el cursor: cursor_enlace_aspirantes."

	close cursor_enlace_aspirantes

	goto EtiquetaError

end



-- Si el result set contiene elementos , entonces procesar

-- cada registro de información 





-- Cambia el modo de procesamiento de transacciones

--set chained off



while (@@sqlstatus = 0)

begin

	 

                                      


		select @resultado_sp= 0

		select @mensaje_sp = null

		exec @resultado_sp = sp_enlace_sce @cuenta         = @cur_cuenta,

													  @version			= @cur_clv_ver,

                                         @periodo        = @cur_ing_per, 

                                         @anio           = @cur_ing_anio, 

                                         @mensaje_salida = @mensaje_sp output



		if @resultado_sp != 0 

		begin

--		 Revierte la insercion

                                           
			if @mensaje_sp in (null)

			begin

				select @mensaje_sp = ""

			end

	   	select @mensaje_error = "Error al ejecutar sp_enlace_sce " +

                                  " Cuenta = "+convert(varchar(255), @cur_cuenta) +

                                  " Folio = "+convert(varchar(255), @cur_folio) +

                                  " Periodo = "+convert(varchar(255), @cur_clv_per)+

                                  " Anio = "+convert(varchar(255), @cur_anio) +

                                  " Periodo Ing = "+convert(varchar(255), @cur_ing_per) +

                                  " Anio Ing= "+ convert(varchar(255), @cur_ing_anio) +"->" +

                                  @mensaje_sp 

			select @num_error = 20000

			close cursor_enlace_aspirantes

                           
			goto EtiquetaError

			

		end 

                     


-- Lee el siguiente registro del cursor

	

	fetch cursor_enlace_aspirantes

	into 

   @cur_folio,

   @cur_cuenta,  

   @cur_clv_ver,  

   @cur_clv_per,  

   @cur_anio,  

   @cur_ing_per,

   @cur_ing_anio



end





-- Si ocurrio un error, llamar al manejador designado 



if (@@sqlstatus = 1) 

begin

   select @mensaje_error = "Error de lectura en el cursor: cursor_enlace_aspirantes."

	close cursor_enlace_aspirantes

	goto Fin

end



-- Cierra el cursor

close cursor_enlace_aspirantes



-- Elimina el espacio reservado para el cursor

deallocate cursor cursor_enlace_aspirantes





Fin:

                                         


EtiquetaCorrecto:

--	Commit Transaction

	Begin transaction

	update parametros_admision
	set enlace_corriendo = 0
	if @@error != 0 
	begin
		SELECT @mensaje_error = "Error al actualizar parametros_admision"
		goto EtiquetaError
	end
	else
	begin
		commit transaction
	end

	return 0



EtiquetaError:

	raiserror @num_error,  @mensaje_error

	Rollback Transaction

	return -1
GO

