***************[funciongen2seguro]***********************************
*	Par�metros:
*
*		n_titulo		Num�rico  N�mero del titulo
*		n_acta			Num�rico  N�mero de acta
*		n_libro			Num�rico  N�mero de libro
*		n_hoja			Num�rico  N�mero de hoja
*		f_examen		Fecha     Fecha de examen
*		f_exped			Fecha     Fecha Expedida
*		nombres			Car�cter  Nombres de alumno
*		a_pat			Car�cter  Apellido Paterno del Alumno
*		a_mat			Car�cter  Apellido Materno del Alumno
*		id_carrera		Num�rico  Identificador del plantel
*		id_plantel		Num�rico  Identificador del plantel
*		id_iniv			Num�rico  Identificador de la univesidad
*		id_titulo		Num�rico  Identificador del titulo
*	
*	Regresa:
*		Integer 
***********************************************************************
FUNCTION gen2seguro
*PARAMETERS n_titulo, n_acta, n_libro, n_hoja, f_examen, f_exped, nombres, a_pat, a_mat, id_carrera, id_plantel, id_iniv, id_titulo
   PRIVATE numero, codigo
   numero = clavex(m.n_titulo+m.n_acta+m.n_libro+m.n_hoja, ;
      m.f_examen, m.f_exped, borrainter(m.nombres)+borrainter(m.a_pat)+;
      borrainter(m.a_mat), m.id_carrera, m.id_plantel)
   codigo = dispersion(numero)
   codigo = VAL(PADL(ALLTRIM(STR(m.id_univ)),2,"0")+;
      PADL(ALLTRIM(STR(m.id_titulo)),5,"0")+;
      PADL(ALLTRIM(STR(codigo)),5,"0"))
   n_codigo = codigo
RETURN  
ENDFUNC