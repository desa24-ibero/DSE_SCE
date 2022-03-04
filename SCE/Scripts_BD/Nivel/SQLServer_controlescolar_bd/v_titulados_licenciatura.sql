USE controlescolar_bd 
GO


ALTER VIEW v_titulados_licenciatura
as
  SELECT cuenta = titulacion.cuenta  
    FROM academicos,   
         titulacion,   
         carreras  
   WHERE ( academicos.cuenta = titulacion.cuenta ) and  
         ( academicos.cve_carrera = titulacion.cve_carrera ) and  
         ( academicos.cve_plan = titulacion.cve_plan ) and  
         ( titulacion.cve_carrera = carreras.cve_carrera ) and  
         ( ( titulacion.aprobado = 1 ) AND  
         ( carreras.nivel <> 'P' ) )    

GO

