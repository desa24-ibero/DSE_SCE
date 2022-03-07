﻿$PBExportHeader$w_enlace_credenciales.srw
forward
global type w_enlace_credenciales from Window
end type
type cbx_pagado from checkbox within w_enlace_credenciales
end type
type st_1 from statictext within w_enlace_credenciales
end type
type dw_1 from uo_dw_reporte within w_enlace_credenciales
end type
type uo_1 from uo_ver_per_ani within w_enlace_credenciales
end type
type em_max from editmask within w_enlace_credenciales
end type
type em_min from editmask within w_enlace_credenciales
end type
end forward

global type w_enlace_credenciales from Window
int X=833
int Y=361
int Width=3562
int Height=1697
boolean TitleBar=true
string Title="Enlace del Sistema de Admisión al Sistema de Credenciales"
string MenuName="m_menu"
long BackColor=30976088
event type long num_folios ( integer min_max )
event enlace ( )
event lee_dw_1 ( )
event credenciales ( )
cbx_pagado cbx_pagado
st_1 st_1
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_enlace_credenciales w_enlace_credenciales

type variables
int al_carr
long il_cont,il_cuenta
string al_nombre,al_apaterno,al_amaterno
transaction itr_scred
end variables

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

event enlace;SetPointer(HourGlass!)

for il_cont=1 to dw_1.rowcount()
	il_cuenta=dw_1.object.general_cuenta[il_cont]
	st_1.text="Leyendo datos de "+string(il_cuenta)
	event credenciales()
next

st_1.text="Ya acabe"
end event

event lee_dw_1;al_nombre=dw_1.object.general_nombre[il_cont]
al_apaterno=dw_1.object.general_apaterno[il_cont]
al_amaterno=dw_1.object.general_amaterno[il_cont]
al_carr=dw_1.object.aspiran_clv_carr[il_cont]
al_carr = carreras_equiv(al_carr)
end event

event credenciales;int li_existe,li_a
string ls_numcarr,ls_banda,ls_digito_raro,ls_vence,ls_digito,ls_nombre,ls_periodo
boolean lb_acabe

if gi_periodo=2 then
	ls_periodo='O'
else
	ls_periodo='P'
end if

ls_vence='0600'
event lee_dw_1()
ls_digito=obten_digito(il_cuenta)

ls_numcarr=string(al_carr)

ls_digito_raro=obten_digito(il_cuenta)
if ls_digito_raro='A' then
	ls_digito_raro=':'
end if
ls_banda='13'+string(il_cuenta,"0000000")+'00'+string(al_carr,"000")+'0000='+ls_vence+'101'+ls_digito_raro

SELECT count(alumnos.cuenta)
INTO :li_existe
FROM alumnos
WHERE alumnos.cuenta = :il_cuenta
USING itr_scred;
if li_existe=0 then	
	INSERT INTO alumnos
	( cuenta,nombre,apaterno,amaterno,banda,foto,cve_carrera )
	VALUES ( :il_cuenta,:al_nombre,:al_apaterno,:al_amaterno,:ls_banda,null,:al_carr )
	USING itr_scred;
	if itr_scred.sqlerrtext<>"" then
		messagebox("",itr_scred.sqlerrtext)
		return
	end if
	commit using itr_scred;	
else	
	UPDATE alumnos
	SET cuenta=:il_cuenta,
	nombre=:al_nombre,
	apaterno=:al_apaterno,
	amaterno=:al_amaterno,
	banda=:ls_banda,
	cve_carrera=:al_carr
	WHERE alumnos.cuenta = :il_cuenta
	USING itr_scred;
	if itr_scred.sqlerrtext<>"" then
		messagebox("",itr_scred.sqlerrtext)
		return
	end if
	commit using itr_scred;
end if

//if isnull(al_apaterno) then
//	al_apaterno=''
//end if
//
//if isnull(al_amaterno) then
//	al_amaterno=''
//end if
//
//if isnull(al_nombre) then
//	al_nombre=''
//end if
//
//ls_nombre=al_apaterno+' '+al_amaterno+' '+al_nombre
//
//SELECT count(generales.cuenta)
//INTO :li_existe
//FROM generales
//WHERE generales.cuenta = :il_cuenta
//USING itr_scred;
//if li_existe=0 then	
//	INSERT INTO generales
//	( cuenta,digito,nombre,clave_carrera,nivel,tipo,nip,num_credencial,periodo,anio )
//	VALUES ( :il_cuenta,:ls_digito,:ls_nombre,:ls_numcarr,'LI',13,'0000',0,:ls_periodo,:gi_anio )
//	USING itr_scred;
//	if itr_scred.sqlerrtext<>"" then
//		messagebox("",itr_scred.sqlerrtext)
//		return
//	end if
//	commit using itr_scred;	
//else	
//	UPDATE generales
//	SET cuenta=:il_cuenta,
//	digito=:ls_digito,
//	nombre=:ls_nombre,
//	clave_carrera=:ls_numcarr,
//	nivel='LI',
//	tipo=13,
//	num_credencial=0,
//	periodo=:ls_periodo,
//	anio=:gi_anio
//	WHERE generales.cuenta = :il_cuenta
//	USING itr_scred;
//	if itr_scred.sqlerrtext<>"" then
//		messagebox("",itr_scred.sqlerrtext)
//		return
//	end if
//	commit using itr_scred;
//end if
end event

on w_enlace_credenciales.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_pagado=create cbx_pagado
this.st_1=create st_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={ this.cbx_pagado,&
this.st_1,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_enlace_credenciales.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_pagado)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
end on

event open;x=1
y=1

if conecta_bd(itr_scred,"scred",gs_usuario,gs_password)=0 then
	close(this)
end if

dw_1.settransobject(gtr_sadm)
end event

event close;desconecta_bd(itr_scred)
end event

type cbx_pagado from checkbox within w_enlace_credenciales
int X=3073
int Y=65
int Width=430
int Height=77
string Text="Insc. Pagada"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_enlace_credenciales
int X=10
int Y=209
int Width=3521
int Height=77
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=""
end event

type dw_1 from uo_dw_reporte within w_enlace_credenciales
int X=19
int Y=333
int Width=3521
int Height=1177
int TabOrder=0
string DataObject="dw_aspi-aceptados"
boolean HScrollBar=true
end type

event carga;if cbx_pagado.checked then
	st_1.text="Leyendo datos de los aspirantes que han pagado"
	return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text),1)
else
	st_1.text="Leyendo datos de los aspirantes que No han pagado"
	return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text),0)
end if
end event

event retrieveend;call super::retrieveend;parent.event enlace()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_enlace_credenciales
int X=28
int Y=25
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_enlace_credenciales
int X=2716
int Y=53
int Width=339
int Height=101
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_enlace_credenciales
int X=2359
int Y=53
int Width=339
int Height=101
Alignment Alignment=Center!
string Mask="######"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="2~~999999"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event
