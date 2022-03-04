$PBExportHeader$u_oc_fox.sru
forward
global type u_oc_fox from u_oc
end type
end forward

global type u_oc_fox from u_oc
end type
global u_oc_fox u_oc_fox

forward prototypes
public function real strcod (string cad)
public function real gen2seguro (long n_titulo, long n_acta, long n_libro, long n_hoja, date f_examen, date f_exped, string nombres, string a_pat, string a_mat, long id_carrera, long id_plantel, long id_univ, long id_titulo)
public function string borrainter (string cadena)
public function real clavex (long titulo, date fecha1, date fecha2, string nom, long carrera, long plantel)
public function real dispersion (long numero)
end prototypes

public function real strcod (string cad);//* *********************************[strcod]***********************************************
//*	Encripta solo el nombre del alumno
//*
//*	Parámetros:
//*		cadena		(String) cadena de texto que contiene el nombre del alumno al cual se le aplicará la función
//*
//*	Regresa:	
//*		Integer : dígito verificador de la cadena que llega como parámetro
//*			
//* *****************************************************************************************
//FUNCTION strcod
//   PARAMETERS cad

LONG i, acumula
   IF LEN(TRIM(cad)) = 0 THEN
      RETURN 0
   END IF
   i = 1
   cad = UPPER(cad)
//   * suma el valor ascii de cada letra de la cadena 	
   acumula = 0
   DO WHILE  i  <= LEN(TRIM(cad))
      acumula = acumula + ASC(MID(cad,i,1))
      i = i +1
   LOOP
RETURN acumula / LEN(TRIM(cad)) * 100



end function

public function real gen2seguro (long n_titulo, long n_acta, long n_libro, long n_hoja, date f_examen, date f_exped, string nombres, string a_pat, string a_mat, long id_carrera, long id_plantel, long id_univ, long id_titulo);///***************[funciongen2seguro]***********************************
//*	Parámetros:
//*
//*		n_titulo		Numérico  Número del titulo
//*		n_acta			Numérico  Número de acta
//*		n_libro			Numérico  Número de libro
//*		n_hoja			Numérico  Número de hoja
//*		f_examen		Fecha     Fecha de examen
//*		f_exped			Fecha     Fecha Expedida
//*		nombres			Carácter  Nombres de alumno
//*		a_pat			Carácter  Apellido Paterno del Alumno
//*		a_mat			Carácter  Apellido Materno del Alumno
//*		id_carrera		Numérico  Identificador de la carrera
//*		id_palntel		Numérico  Identificador del plantel
//*		id_iniv			Numérico  Identificador de la univesidad
//*		id_titulo		Numérico  Identificador del titulo
//*	
//*	Regresa:
//*		Integer 
//***********************************************************************
//FUNCTION gen2seguro*/
////PARAMETERS n_titulo, n_acta, n_libro, n_hoja, f_examen, f_exped, nombres, a_pat, a_mat, id_carrera, id_palntel, id_iniv, id_titulo
real numero, codigo
   numero = clavex( n_titulo+ n_acta+ n_libro+ n_hoja, &
       f_examen,  f_exped, borrainter( nombres)+borrainter( a_pat)+ &
      borrainter( a_mat),  id_carrera,  id_plantel)
   codigo = dispersion(numero)
   codigo = real(STRING(TRIM(STRING( id_univ)),"00")+&
      STRING(TRIM(STRING( id_titulo)),"00000")+&
      STRING(TRIM(STRING(codigo)),"00000"))
RETURN  codigo




end function

public function string borrainter (string cadena);//* *********************************[borrainter]*******************************************
//*	Borra espacios en blanco en el nombre del alumno
//*
//*	Parámetros:
//*		cadena		(String) cadena de texto a la cual se le aplicará la función
//*
//*	Regresa:	
//*		String : Cadena sin espacions en blanco
//* *****************************************************************************************
//FUNCTION borrainter
//   PARAMETERS cadena
STRING  cadenaaux
INT actual
   cadena = TRIM(cadena)
   cadenaaux = cadena
   DO WHILE  POS(cadena, "  ") >0
      actual = POS(cadena,"  ")
      cadenaaux = MID(cadena,1,actual)
      cadenaaux = cadenaaux + MID(cadena,actual +2, LEN(cadena)-actual+2)
      cadena = cadenaaux
   LOOP

RETURN cadenaaux


end function

public function real clavex (long titulo, date fecha1, date fecha2, string nom, long carrera, long plantel);//* *********************************[clavex]*******************************************
//*	Realiza la dispersión de un número de entrada
//*
//*	Parámetros:
//*		Titulo		(Integer) Número del título a encriptar
//*		fecha1		(Date) 
//*		fecha2		(Date) 
//*		nom		(String) Nombre del alumno
//*		carrera		(Integer) Clave de de carrera del alumno
//*		plantel		(Integer) Clave del plantel
//*
//*	Regresa:	
//*		Integer 
//* *****************************************************************************************
//FUNCTION clavex
//   PARAMETERS Titulo, fecha1, fecha2, nom, carrera,plantel

real acumula, acum2,valnom

   valnom = strcod(nom)
   acumula = valnom
   acum2 = 1
   IF Titulo > 0 THEN
      acum2 = Titulo
   END IF
   acumula = acumula + REAL(STRING(fecha1,"yyyymmdd"))-1900
   acumula = acumula + REAL(STRING(fecha2,"yyyymmdd"))-1900

RETURN  (acumula/acum2) + carrera + plantel



end function

public function real dispersion (long numero);//* *********************************[dispersion]*******************************************
//*	Realiza la dispersión de un número de entrada
//*
//*	Parámetros:
//*		numero		(Integer) número al cual se le aplicará la función
//*
//*	Regresa:	
//*		Integer 
//* *****************************************************************************************
//FUNCTION  dispersion
//   PARAMETERS numero
real i , primo
   i= 0.618034
   primo = 99929
RETURN REAL(primo * ((numero*i) - REAL(numero*i)) )

end function

on u_oc_fox.create
end on

on u_oc_fox.destroy
end on

