$PBExportHeader$u_codigo_titulo.sru
forward
global type u_codigo_titulo from nonvisualobject
end type
end forward

global type u_codigo_titulo from nonvisualobject
end type
global u_codigo_titulo u_codigo_titulo

type variables
n_cryptoapi ln_crypto

end variables

forward prototypes
public function string pon_ceros_izquierda (long an_numero, integer an_num_ceros)
public function long dispersion (long numero)
public function real strcod (string cad)
public function real gen2seguro (long n_titulo, long n_acta, long n_libro, long n_hoja, date f_examen, date f_exped, string nombres, string a_pat, string a_mat, long id_carrera, long id_plantel, long id_univ, long id_titulo)
public function long clavex (long titulo, date fecha1, date fecha2, string nom, long carrera, long plantel)
public function string borrainter (string cadena)
public function string of_obten_seguro (long n_titulo, long n_acta, long n_libro, long n_hoja, date f_examen, date f_exped, string nombres, string a_pat, string a_mat, long id_carrera, long id_plantel, long id_univ, long id_titulo)
public function double of_obten_codigo (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_id_titulo, long al_n_titulo)
public function double of_obten_codigo (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_secuencia)
public function string quita_espacio (string cadena)
public function string of_obten_nvo_seguro (long n_titulo, long n_acta, long n_libro, long n_hoja, date f_examen, date f_exped, string nombres, string a_pat, string a_mat, long id_carrera, readonly long id_plantel, long id_univ, long id_titulo)
public function string of_obten_nvo_codigo (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_id_titulo, long al_n_titulo)
end prototypes

public function string pon_ceros_izquierda (long an_numero, integer an_num_ceros);//pon_ceros_izquierda
//Recibe : an_numero
//			an_num_ceros

string ls_numero, ls_numero_con_formato, ls_string_ceros
long ll_tamanio_numero, ll_num_ceros, li_ceros

ls_numero = string(an_numero)
ll_tamanio_numero = len(ls_numero) 


IF ll_tamanio_numero >= an_num_ceros then
	return ls_numero
end if

ll_num_ceros= an_num_ceros -ll_tamanio_numero 

ls_string_ceros= "0"

for li_ceros = 1 to ll_num_ceros
	ls_string_ceros =ls_string_ceros + "0"
next

ls_numero_con_formato = ls_string_ceros + ls_numero

return ls_numero_con_formato

end function

public function long dispersion (long numero);//* *********************************[dispersion]*******************************************
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
real i , primo, dispersion
   i= 0.618034
   primo = 99929
	dispersion = LONG(primo * (DOUBLE(numero*i) - LONG(numero*i)) )	
RETURN dispersion

end function

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

LONG i, acumula, strcod
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
	strcod = acumula / LEN(TRIM(cad)) * 100
RETURN strcod



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
string ls_codigo_02, ls_id_univ, ls_id_titulo, ls_codigo_01
   numero = clavex( n_titulo+ n_acta+ n_libro+ n_hoja, &
       f_examen,  f_exped, borrainter( nombres)+borrainter( a_pat)+ &
      borrainter( a_mat),  id_carrera,  id_plantel)
   codigo = dispersion(numero)
	ls_id_univ   = pon_ceros_izquierda(id_univ,2)
	ls_id_titulo = pon_ceros_izquierda(id_titulo,5)
	ls_codigo_01 = pon_ceros_izquierda(codigo,5)
	ls_codigo_02= ls_id_univ + ls_id_titulo+ ls_codigo_01
//   ls_codigo = (STRING(TRIM(STRING( id_univ)),"00")+&
//      STRING(TRIM(STRING( id_titulo)),"00000")+&
//      STRING(TRIM(STRING(codigo)),"00000"))
	codigo = real(ls_codigo_02)	
RETURN  codigo




end function

public function long clavex (long titulo, date fecha1, date fecha2, string nom, long carrera, long plantel);//* *********************************[clavex]*******************************************
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

real acumula, acum2,valnom, clavex

   valnom = strcod(nom)
   acumula = valnom
   acum2 = 1
   IF Titulo > 0 THEN
      acum2 = Titulo
   END IF
   acumula = acumula + LONG(STRING(fecha1,"yyyymmdd"))-1900
   acumula = acumula + LONG(STRING(fecha2,"yyyymmdd"))-1900
	clavex = (acumula/acum2) + carrera + plantel
RETURN  clavex



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
INT actual, resto

//   cadena = TRIM(cadena)
//   cadenaaux = cadena
//   DO WHILE  POS(cadena, " ") >0
//      actual = POS(cadena," ")
//      cadenaaux = MID(cadena,1,actual - 1)
//		resto = LEN(cadena)- actual 
//      cadenaaux = cadenaaux + MID(cadena,actual + 1, resto)
//      cadena = cadenaaux
//   LOOP


   cadena = TRIM(cadena)
   cadenaaux = cadena
   DO WHILE  POS(cadena, "  ") >0
      actual = POS(cadena,"  ")
      cadenaaux = MID(cadena,1,actual - 1)
		resto = LEN(cadena)- actual + 1
      cadenaaux = cadenaaux + MID(cadena,actual + 2, resto)
      cadena = cadenaaux
   LOOP




RETURN cadenaaux


end function

public function string of_obten_seguro (long n_titulo, long n_acta, long n_libro, long n_hoja, date f_examen, date f_exped, string nombres, string a_pat, string a_mat, long id_carrera, long id_plantel, long id_univ, long id_titulo);///***************[getcodigo]***********************************
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
//FUNCTION of_obten_seguro 
////PARAMETERS n_titulo, n_acta, n_libro, n_hoja, f_examen, f_exped, nombres, a_pat, a_mat, id_carrera, id_palntel, id_iniv, id_titulo
//Autor: Antonio Pica Ruiz
integer result
real codigo
string ls_codigo,ls_a_pat
OLEObject myoleobject
ANY ls_any

myoleobject = CREATE OLEObject

//Funcion de FoxPro desarrollada por Osvaldo Vargas
result = myoleobject.ConnectToNewObject( &
		"seguro.seguro")

IF result = 0 THEN
	myoleobject.n_titulo = n_titulo
	myoleobject.n_acta = n_acta
	myoleobject.n_libro = n_libro
	myoleobject.n_hoja = n_hoja
	myoleobject.f_examen = f_examen
	myoleobject.f_exped = f_exped
	myoleobject.nombres = nombres
	myoleobject.a_pat = a_pat
	myoleobject.a_mat = a_mat
	myoleobject.id_plantel = id_plantel
	myoleobject.id_carrera = id_carrera
	myoleobject.id_univ = id_univ
	myoleobject.id_titulo = id_titulo
	

	ls_codigo = myoleobject.getcodigo()
ELSE
	DESTROY myoleobject
	return "-1"
END IF

DESTROY myoleobject

RETURN  ls_codigo




end function

public function double of_obten_codigo (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_id_titulo, long al_n_titulo);//of_obten_codigo
//Obtiene los datos del alumno al que se le va a calcular el codigo de seguridad
//Recibe	al_cuenta	long
//	al_cve_carrera		long
//	al_cve_plan			long
//	al_id_titulo		long
//	al_n_titulo			long


u_DataStore lds_maximo
long ll_num_rows, ll_row_actual
long	ll_n_titulo, ll_n_acta, ll_n_libro, ll_n_hoja
datetime ldttm_f_examen, ldttm_f_exped
date ldt_f_examen, ldt_f_exped
string ls_nombres, ls_a_pat, ls_a_mat
long	ll_id_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo
decimal ll_codigo
string ls_codigo

	
lds_maximo = Create u_DataStore
lds_maximo.dataobject = "d_datos_codigo_individual"
lds_maximo.SetTrans(gtr_sce)
ll_num_rows = lds_maximo.Retrieve(al_cuenta, al_cve_carrera, al_cve_plan)
IF ll_num_rows> 0 THEN
	ll_row_actual = lds_maximo.GetRow()

	ll_n_titulo = lds_maximo.getitemnumber(ll_row_actual,"n_titulo") 
	ll_n_acta = lds_maximo.getitemnumber(ll_row_actual,"n_acta")
	ll_n_libro = lds_maximo.getitemnumber(ll_row_actual,"n_libro")
	ll_n_hoja = lds_maximo.getitemnumber(ll_row_actual,"n_hoja")

	ldttm_f_examen = lds_maximo.getitemDatetime(ll_row_actual,"f_examen")
	ldttm_f_exped = lds_maximo.getitemDatetime(ll_row_actual,"f_exped")
	ldt_f_examen = date(ldttm_f_examen)
	ldt_f_exped = date(ldttm_f_examen)

	ls_nombres = lds_maximo.getitemstring(ll_row_actual,"nombres")
	ls_a_pat = lds_maximo.getitemstring(ll_row_actual,"a_pat")
	ls_a_mat = lds_maximo.getitemstring(ll_row_actual,"a_mat")

	ll_id_carrera = lds_maximo.getitemnumber(ll_row_actual,"id_carrera")
	ll_id_plantel = lds_maximo.getitemnumber(ll_row_actual,"id_plantel")
	ll_id_univ = lds_maximo.getitemnumber(ll_row_actual,"id_univ")
	ll_id_titulo = lds_maximo.getitemnumber(ll_row_actual,"id_titulo")
ELSEIF ll_num_rows=-1 THEN
	Destroy lds_maximo
	return -1
END IF
Destroy lds_maximo


ll_id_titulo = al_id_titulo
ll_n_titulo = al_n_titulo

ls_codigo = this.of_obten_seguro(ll_n_titulo, ll_n_acta, ll_n_libro, ll_n_hoja,&
							ldt_f_examen, ldt_f_exped, ls_nombres, ls_a_pat, ls_a_mat,&
							ll_id_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo)



return double(ls_codigo)


end function

public function double of_obten_codigo (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_cve_secuencia);//of_obten_codigo
//Obtiene los datos del alumno al que se le va a calcular el codigo de seguridad
//Recibe	al_cuenta	long
//	al_cve_carrera		long
//	al_cve_plan			long
// al_cve_secuencia	long

u_DataStore lds_maximo
long ll_num_rows, ll_row_actual
long	ll_n_titulo, ll_n_acta, ll_n_libro, ll_n_hoja
datetime ldttm_f_examen, ldttm_f_exped
date ldt_f_examen, ldt_f_exped
string ls_nombres, ls_a_pat, ls_a_mat
long	ll_id_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo
decimal ll_codigo
string ls_codigo
long ll_max_id_titulo, ll_max_n_titulo, ll_cve_secuencia= 1
	
lds_maximo = Create u_DataStore
lds_maximo.dataobject = "d_datos_codigo_individual"
lds_maximo.SetTrans(gtr_sce)
ll_num_rows = lds_maximo.Retrieve(al_cuenta, al_cve_carrera, al_cve_plan)
IF ll_num_rows> 0 THEN
	ll_row_actual = lds_maximo.GetRow()

	ll_n_titulo = lds_maximo.getitemnumber(ll_row_actual,"n_titulo") 
	ll_n_acta = lds_maximo.getitemnumber(ll_row_actual,"n_acta")
	ll_n_libro = lds_maximo.getitemnumber(ll_row_actual,"n_libro")
	ll_n_hoja = lds_maximo.getitemnumber(ll_row_actual,"n_hoja")

	ldttm_f_examen = lds_maximo.getitemDatetime(ll_row_actual,"f_examen")
	ldttm_f_exped = lds_maximo.getitemDatetime(ll_row_actual,"f_exped")
	ldt_f_examen = date(ldttm_f_examen)
	ldt_f_exped = date(ldttm_f_examen)

	ls_nombres = lds_maximo.getitemstring(ll_row_actual,"nombres")
	ls_a_pat = lds_maximo.getitemstring(ll_row_actual,"a_pat")
	ls_a_mat = lds_maximo.getitemstring(ll_row_actual,"a_mat")

	ll_id_carrera = lds_maximo.getitemnumber(ll_row_actual,"id_carrera")
	ll_id_plantel = lds_maximo.getitemnumber(ll_row_actual,"id_plantel")
	ll_id_univ = lds_maximo.getitemnumber(ll_row_actual,"id_univ")
	ll_id_titulo = lds_maximo.getitemnumber(ll_row_actual,"id_titulo")
ELSEIF ll_num_rows=-1 THEN
	Destroy lds_maximo
	return -1
END IF
Destroy lds_maximo

ll_max_id_titulo = of_obten_id_titulo(al_cve_secuencia)
ll_max_n_titulo = of_obten_n_titulo(al_cve_secuencia)
ll_id_titulo = ll_max_id_titulo + 1
ll_n_titulo = ll_max_n_titulo + 1

ls_codigo = this.of_obten_seguro(ll_n_titulo, ll_n_acta, ll_n_libro, ll_n_hoja,&
							ldt_f_examen, ldt_f_exped, ls_nombres, ls_a_pat, ls_a_mat,&
							ll_id_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo)



return double(ls_codigo)


end function

public function string quita_espacio (string cadena);STRING  cadenaaux
INT actual, resto

cadena = TRIM(cadena)
cadenaaux = cadena
DO WHILE  POS(cadena, " ") >0
	actual = POS(cadena," ")
	cadenaaux = MID(cadena,1,actual - 1)
	resto = LEN(cadena)- actual 
	cadenaaux = cadenaaux + MID(cadena,actual + 1, resto)
	cadena = cadenaaux
LOOP

RETURN cadenaaux
end function

public function string of_obten_nvo_seguro (long n_titulo, long n_acta, long n_libro, long n_hoja, date f_examen, date f_exped, string nombres, string a_pat, string a_mat, long id_carrera, readonly long id_plantel, long id_univ, long id_titulo);///***************[getcodigo]***********************************
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
//*		id_univ			Numérico  Identificador de la univesidad
//*		id_titulo		Numérico  Identificador del titulo
//*	
//*	Regresa:
//*		Integer 
//***********************************************************************
//FUNCTION of_obten_nvo_seguro 
////PARAMETERS n_titulo, n_acta, n_libro, n_hoja, f_examen, f_exped, nombres, a_pat, a_mat, id_carrera, id_palntel, id_iniv, id_titulo
//Autor: Salvador Frayle Flores
integer result
real codigo
string ls_codigo,ls_a_pat, ls_provider, ls_entrada, ls_fecha_exa , ls_fecha_exp
ANY ls_any
real numero
string ls_id_univ, ls_id_titulo, ls_codigo_01


If IsNull(n_titulo) Then
	Return "-1"
End If

If IsNull(n_acta) Then
	Return "-1"
End If

If IsNull(n_libro) Then
	Return "-1"
End If

If IsNull(n_hoja) Then
	Return "-1"
End If

If IsNull(f_examen) Then
	Return "-1"
End If	

If IsNull(f_exped) Then
	Return "-1"
End If	

If IsNull(nombres) Then
	nombres = ""
Else 
	nombres = quita_espacio(nombres)
End If	

If IsNull(a_pat) Then
	a_pat = ""
Else
	a_pat = quita_espacio(a_pat)
End If	

If IsNull(a_mat) Then
	a_mat = ""
Else
	a_mat = quita_espacio(a_mat)
End If	

If IsNull(id_carrera) Then
	Return "-1"
End If
If IsNull(id_plantel) Then
	Return "-1"
End If
If IsNull(id_univ) Then
	Return "-1"
End If
If IsNull(id_titulo) Then
	Return "-1"
End If

ls_fecha_exa = mid(string(f_examen),7,4) + mid(string(f_examen),4,2)  + mid(string(f_examen),1,2)
ls_fecha_exp = mid(string(f_exped),7,4) + mid(string(f_exped),4,2)  + mid(string(f_exped),1,2)

ls_entrada = 	string(id_univ) + string(id_titulo) + &
					string(n_titulo) + string(n_acta) + string(n_libro) + string(n_hoja) + &
					ls_fecha_exa + ls_fecha_exp + &
					nombres + a_pat + a_mat + &
					string(id_carrera) + string(id_plantel)

If IsNull(ls_entrada) Or ls_entrada = ""  Then
	Return "-1"
Else	/* Generación de Código */
	ln_crypto = CREATE n_cryptoapi
	
	// get default provider
	ls_provider = ln_crypto.of_GetDefaultProvider()
	
	// update settings
	ln_crypto.iCryptoProvider		= ls_provider
	ln_crypto.iProviderType		= ln_crypto.PROV_RSA_FULL
	ln_crypto.iEncryptAlgorithm	= ln_crypto.CALG_RC4
	ln_crypto.iHashAlgorithm		= ln_crypto.CALG_MD5
	
	ls_codigo = ln_crypto.of_GetHashValue(ls_entrada)
	
//	DESTROY ln_crypto
End If

RETURN  ls_codigo
end function

public function string of_obten_nvo_codigo (long al_cuenta, long al_cve_carrera, long al_cve_plan, long al_id_titulo, long al_n_titulo);//of_obten_nvo_codigo
//Obtiene los datos del alumno al que se le va a calcular el nuevo codigo de seguridad Jun2013
//Recibe	al_cuenta	long
//	al_cve_carrera		long
//	al_cve_plan			long
//	al_id_titulo		long
//	al_n_titulo			long


u_DataStore lds_maximo
long ll_num_rows, ll_row_actual
long	ll_n_titulo, ll_n_acta, ll_n_libro, ll_n_hoja
datetime ldttm_f_examen, ldttm_f_exped
date ldt_f_examen, ldt_f_exped
string ls_nombres, ls_a_pat, ls_a_mat
long	ll_id_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo
decimal ll_codigo
string ls_codigo

	
lds_maximo = Create u_DataStore
lds_maximo.dataobject = "d_datos_codigo_individual"
lds_maximo.SetTrans(gtr_sce)
ll_num_rows = lds_maximo.Retrieve(al_cuenta, al_cve_carrera, al_cve_plan)
IF ll_num_rows> 0 THEN
	ll_row_actual = lds_maximo.GetRow()

	ll_n_titulo = lds_maximo.getitemnumber(ll_row_actual,"n_titulo") 
	ll_n_acta = lds_maximo.getitemnumber(ll_row_actual,"n_acta")
	ll_n_libro = lds_maximo.getitemnumber(ll_row_actual,"n_libro")
	ll_n_hoja = lds_maximo.getitemnumber(ll_row_actual,"n_hoja")

	ldttm_f_examen = lds_maximo.getitemDatetime(ll_row_actual,"f_examen")
	ldttm_f_exped = lds_maximo.getitemDatetime(ll_row_actual,"f_exped")
	ldt_f_examen = date(ldttm_f_examen)
	ldt_f_exped = date(ldttm_f_examen)

	ls_nombres = lds_maximo.getitemstring(ll_row_actual,"nombres")
	ls_a_pat = lds_maximo.getitemstring(ll_row_actual,"a_pat")
	ls_a_mat = lds_maximo.getitemstring(ll_row_actual,"a_mat")

	ll_id_carrera = lds_maximo.getitemnumber(ll_row_actual,"id_carrera")
	ll_id_plantel = lds_maximo.getitemnumber(ll_row_actual,"id_plantel")
	ll_id_univ = lds_maximo.getitemnumber(ll_row_actual,"id_univ")
	ll_id_titulo = lds_maximo.getitemnumber(ll_row_actual,"id_titulo")
ELSEIF ll_num_rows=-1 THEN
	Destroy lds_maximo
	return "-1"
END IF
Destroy lds_maximo


ll_id_titulo = al_id_titulo
ll_n_titulo = al_n_titulo

ls_codigo = this.of_obten_nvo_seguro (ll_n_titulo, ll_n_acta, ll_n_libro, ll_n_hoja,&
							ldt_f_examen, ldt_f_exped, ls_nombres, ls_a_pat, ls_a_mat,&
							ll_id_carrera, ll_id_plantel, ll_id_univ, ll_id_titulo)



return ls_codigo


end function

on u_codigo_titulo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_codigo_titulo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

type ln_crypto from n_cryptoapi within u_codigo_titulo
end type

