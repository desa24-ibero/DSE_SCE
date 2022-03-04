EXECUTE sp_unbindrule 'carreras.nivel'
EXECUTE sp_unbindrule 'academicos2.nivel'
EXECUTE sp_unbindrule 'materias.nivel'
EXECUTE sp_unbindrule 'hist_salon.nivel'
EXECUTE sp_unbindrule 'academicos_hist.nivel'
EXECUTE sp_unbindrule 'no_academicos_hist.nivel'
EXECUTE sp_unbindrule 'bit_academicos_hist.nivel'
EXECUTE sp_unbindrule 'hist_carreras.nivel_ant'
EXECUTE sp_unbindrule 'hist_carreras.nivel_act'
EXECUTE sp_unbindrule 'academicos.nivel'
EXECUTE sp_unbindrule 'salon.nivel'
EXECUTE sp_unbindrule 'hist_academicos.nivel' 
EXECUTE sp_unbindrule tipo_nivel
GO 


IF OBJECT_ID ('regla_nivel') IS NOT NULL
	DROP RULE regla_nivel
GO

create rule regla_nivel as @tipo_nivel in ('L','P','T','U') 
GO


EXECUTE sp_bindrule regla_nivel, 'carreras.nivel'
EXECUTE sp_bindrule regla_nivel, 'academicos2.nivel' 
EXECUTE sp_bindrule regla_nivel, 'materias.nivel'
EXECUTE sp_bindrule regla_nivel, 'hist_salon.nivel'
EXECUTE sp_bindrule regla_nivel, 'academicos_hist.nivel'
EXECUTE sp_bindrule regla_nivel, 'no_academicos_hist.nivel'
EXECUTE sp_bindrule regla_nivel, 'bit_academicos_hist.nivel'
EXECUTE sp_bindrule regla_nivel, 'hist_carreras.nivel_ant'
EXECUTE sp_bindrule regla_nivel, 'hist_carreras.nivel_act'
EXECUTE sp_bindrule regla_nivel, 'academicos.nivel'
EXECUTE sp_bindrule regla_nivel, 'salon.nivel'
EXECUTE sp_bindrule regla_nivel, 'hist_academicos.nivel' 
EXECUTE sp_bindrule regla_nivel, tipo_nivel
GO