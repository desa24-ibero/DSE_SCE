$PBExportHeader$w_cap_historico.srw
forward
global type w_cap_historico from Window
end type
type cb_1 from commandbutton within w_cap_historico
end type
type dw_1 from uo_dw_captura within w_cap_historico
end type
end forward

global type w_cap_historico from Window
int X=833
int Y=361
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Datos Históricos"
string MenuName="m_menu"
long BackColor=30976088
cb_1 cb_1
dw_1 dw_1
end type
global w_cap_historico w_cap_historico

type variables

end variables

forward prototypes
public function integer inserta_calif (integer area, integer seccion, long folio, real calificacion)
public function integer inserta_area (integer area, long folio)
end prototypes

public function integer inserta_calif (integer area, integer seccion, long folio, real calificacion);integer li_existe
integer buenas

buenas=integer(calificacion)

if calificacion=0 then
	return 0
end if

SELECT count(folio)
INTO :li_existe
FROM cali_sec
WHERE ( cali_sec.folio = :folio ) AND
	( cali_sec.clv_ver = 1 ) AND
	( cali_sec.clv_per = :gi_periodo ) AND
	( cali_sec.anio = :gi_anio ) AND
	( cali_sec.clv_area = :area ) AND
	( cali_sec.clv_sec = :seccion )
USING gtr_sadm;
if li_existe=0 then
	INSERT INTO cali_sec
		( folio,clv_ver,clv_per,anio,clv_area,clv_sec,buenas,calif )
	VALUES ( :folio,1,:gi_periodo,:gi_anio,:area,:seccion,:buenas,:calificacion )
	USING gtr_sadm;
	if gtr_sadm.sqlerrtext<>"" then
		messagebox("",gtr_sadm.sqlerrtext)
		rollback using gtr_sadm;
		return -1
	else
		commit using gtr_sadm;
	end if		
end if
return 0
end function

public function integer inserta_area (integer area, long folio);integer li_existe

SELECT count(folio)
INTO :li_existe
FROM cali_are
WHERE ( cali_are.folio = :folio ) AND
	( cali_are.clv_ver = 1 ) AND
	( cali_are.clv_per = :gi_periodo ) AND
	( cali_are.anio = :gi_anio ) AND
	( cali_are.clv_area = :area )
USING gtr_sadm;

if li_existe=0 then
	INSERT INTO cali_are
		( folio,clv_ver,clv_per,anio,clv_area,calif )
	VALUES ( :folio,1,:gi_periodo,:gi_anio,:area,0 )
	USING gtr_sadm;
	if gtr_sadm.sqlerrtext<>"" then
		messagebox("",gtr_sadm.sqlerrtext)
		rollback using gtr_sadm;
		return -1
	else
		commit using gtr_sadm;
	end if	
end if
return 0
end function

on w_cap_historico.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_cap_historico.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type cb_1 from commandbutton within w_cap_historico
int X=1692
int Y=13
int Width=257
int Height=109
string Text="Escribe"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_cont,ll_folio,ll_cuenta,ll_borra
string ls_nombre,ls_sexo
int li_existe,li_carrera,li_escuela,li_status
real lr_promedio,lr_puntaje,lr_r_matem,lr_r_verbal,lr_gramatica,lr_historia,lr_filosofia
real lr_mundo,lr_mate_a,lr_mate_b,lr_fisica,lr_quimica,lr_ingles

FOR ll_cont=dw_1.rowcount() TO 1 step -1
	ll_borra=1
	ll_folio=dw_1.object.folio[ll_cont]
	ls_nombre=dw_1.object.nombre[ll_cont]
	li_carrera=dw_1.object.carrera[ll_cont]
	IF dw_1.object.sexo[ll_cont]=1 THEN
		ls_sexo='M'
	else
		ls_sexo='F'
	END IF
	lr_r_matem=dw_1.object.r_matem[ll_cont]
	lr_r_verbal=dw_1.object.r_verbal[ll_cont]
	lr_gramatica=dw_1.object.gramatica[ll_cont]
	lr_historia=dw_1.object.historia[ll_cont]
	lr_filosofia=dw_1.object.filosofia[ll_cont]
	lr_mundo=dw_1.object.mundo[ll_cont]
	lr_mate_a=dw_1.object.mate_a[ll_cont]
	lr_mate_b=dw_1.object.mate_b[ll_cont]
	lr_fisica=dw_1.object.fisica[ll_cont]
	lr_quimica=dw_1.object.quimica[ll_cont]
	lr_ingles=dw_1.object.ingles[ll_cont]
	li_escuela=dw_1.object.escuela[ll_cont]
	lr_promedio=dw_1.object.promedio[ll_cont]
	li_status=dw_1.object.resultado[ll_cont]
	ll_cuenta=dw_1.object.cuenta[ll_cont]
	if dw_1.object.periodo[ll_cont]='P' then
		gi_periodo=0
	else
		gi_periodo=2
	end if
	gi_anio=dw_1.object.anio[ll_cont]
	lr_puntaje=dw_1.object.puntaje[ll_cont]
			
	SELECT count(clv_carr)  
	INTO :li_existe  
	FROM sol_foli  
	WHERE ( sol_foli.clv_ver = 1 ) AND  
		( sol_foli.clv_carr = :li_carrera ) AND  
		( sol_foli.clv_per = :gi_periodo ) AND  
		( sol_foli.anio = :gi_anio )
	USING gtr_sadm;	
	if li_existe=0 then
		INSERT INTO sol_foli
			( clv_ver,clv_carr,clv_per,anio,folios,lugares )
		VALUES ( 1,:li_carrera,:gi_periodo,:gi_anio,0,0 )
		USING gtr_sadm;
		if gtr_sadm.sqlerrtext<>"" then
			dw_1.scrolltorow(ll_cont)
			messagebox("",gtr_sadm.sqlerrtext)
			ll_borra=0
			rollback using gtr_sadm;
		else
			commit using gtr_sadm;
		end if
	end if
		
	SELECT count(salon)  
	INTO :li_existe  
	FROM carr_sal  
	WHERE ( carr_sal.clv_ver = 1 ) AND  
		( carr_sal.clv_carr = :li_carrera ) AND  
		( carr_sal.clv_per = :gi_periodo ) AND  
		( carr_sal.anio = :gi_anio ) AND  
		( carr_sal.salon = 'A101' )
	USING gtr_sadm;	
	if li_existe=0 then
		INSERT INTO carr_sal
			( clv_ver,salon,clv_carr,clv_per,anio,folios )
		VALUES ( 1,'A101',:li_carrera,:gi_periodo,:gi_anio,0 )
		USING gtr_sadm;
		if gtr_sadm.sqlerrtext<>"" then
			dw_1.scrolltorow(ll_cont)
			messagebox("",gtr_sadm.sqlerrtext)
			ll_borra=0
			rollback using gtr_sadm;
		else
			commit using gtr_sadm;
		end if
	end if
	
	SELECT count(folio)
	INTO :li_existe
	FROM aspiran
	WHERE ( aspiran.folio = :ll_folio ) AND
		( aspiran.clv_ver = 1 ) AND
		( aspiran.clv_per = :gi_periodo ) AND
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
	if li_existe=0 then
		INSERT INTO aspiran
		( folio,clv_ver,clv_per,anio,clv_carr,promedio,status,puntaje,pago_exam,salon,   
			lugar_gen,lugar_car,num_paq,pago_insc )
		VALUES ( :ll_folio,1,:gi_periodo,:gi_anio,:li_carrera,:lr_promedio,:li_status,
			:lr_puntaje,1,'A101',0,0,0,0 )
		USING gtr_sadm;
		if gtr_sadm.sqlerrtext<>"" then
			dw_1.scrolltorow(ll_cont)
			messagebox("",gtr_sadm.sqlerrtext)
			ll_borra=0
			rollback using gtr_sadm;
		else
			commit using gtr_sadm;
		end if		
	end if
		
	SELECT count(folio)
	INTO :li_existe
	FROM general
	WHERE ( general.folio = :ll_folio ) AND
		( general.clv_ver = 1 ) AND
		( general.clv_per = :gi_periodo ) AND
		( general.anio = :gi_anio )
	USING gtr_sadm;
	if li_existe=0 then
		INSERT INTO general
			( folio,clv_ver,clv_per,anio,nombre,apaterno,amaterno,calle,codigo_pos,colonia,
			estado,telefono,fecha_nac,lugar_nac,nacional,sexo,edo_civil,religion,bachillera,
			trabajo,trab_hor,ya_inscri,cuenta,transporte )
		VALUES ( :ll_folio,1,:gi_periodo,:gi_anio,:ls_nombre,null,null,null,null,null,   
				null,null,null,null,null,:ls_sexo,null,null,:li_escuela,
				null,null,null,:ll_cuenta,null )
		USING gtr_sadm;
		if gtr_sadm.sqlerrtext<>"" then
			dw_1.scrolltorow(ll_cont)
			messagebox("",gtr_sadm.sqlerrtext)
			ll_borra=0
			rollback using gtr_sadm;
		else
			commit using gtr_sadm;
		end if		
	end if

	if inserta_area(1,ll_folio)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if

	if inserta_calif(1,1,ll_folio,lr_r_verbal)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if
	
	if inserta_calif(1,2,ll_folio,lr_r_matem)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if
	
	if inserta_calif(1,3,ll_folio,lr_ingles)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if
	
	if inserta_area(2,ll_folio)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if

	if inserta_calif(2,1,ll_folio,lr_mundo)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if
	
	if inserta_calif(2,2,ll_folio,(lr_fisica+lr_quimica)/2.0)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if
	
	lr_historia=(lr_historia+lr_filosofia)/2.0
	if inserta_calif(2,3,ll_folio,lr_historia)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if

	if lr_mate_a=0 then
		lr_mate_a=lr_mate_b
	end if
	if inserta_calif(2,4,ll_folio,lr_mate_a)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if
	
	if inserta_calif(2,5,ll_folio,lr_gramatica)=-1 then
		dw_1.scrolltorow(ll_cont)
		ll_borra=0
	end if
	
	dw_1.scrolltorow(ll_cont)
	if ll_borra=1 then
		dw_1.deleterow(ll_cont)
	end if
	
NEXT
end event

type dw_1 from uo_dw_captura within w_cap_historico
int X=5
int Y=129
int Width=3630
int Height=1649
int TabOrder=20
string DataObject="dw_cap_historico"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

