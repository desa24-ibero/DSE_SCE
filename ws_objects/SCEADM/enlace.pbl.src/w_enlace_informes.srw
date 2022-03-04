$PBExportHeader$w_enlace_informes.srw
forward
global type w_enlace_informes from window
end type
type cbx_pagado from checkbox within w_enlace_informes
end type
type st_1 from statictext within w_enlace_informes
end type
type dw_1 from uo_dw_reporte within w_enlace_informes
end type
type uo_1 from uo_ver_per_ani within w_enlace_informes
end type
type em_max from editmask within w_enlace_informes
end type
type em_min from editmask within w_enlace_informes
end type
end forward

global type w_enlace_informes from window
integer x = 832
integer y = 360
integer width = 3561
integer height = 1696
boolean titlebar = true
string title = "Enlace del Sistema de Admisión al Sistema de Informes"
string menuname = "m_menu"
long backcolor = 30976088
event type long num_folios ( integer min_max )
event enlace ( )
event lee_dw_1 ( )
event informes ( )
cbx_pagado cbx_pagado
st_1 st_1
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_enlace_informes w_enlace_informes

type variables
int al_carr
long il_cont,il_cuenta
string al_nombre,al_apaterno,al_amaterno
transaction itr_sinf
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
	event informes()
next

st_1.text="Ya acabe"
end event

event lee_dw_1;		al_nombre=dw_1.object.general_nombre[il_cont]
		al_apaterno=dw_1.object.general_apaterno[il_cont]
		al_amaterno=dw_1.object.general_amaterno[il_cont]
		al_carr=dw_1.object.aspiran_clv_carr[il_cont]
end event

event informes;int li_existe,li_a
string ls_nombre_1,ls_nombre_2,ls_carrera_1,ls_carrera_2
string ls_cuenta,ls_numcarr,ls_banda,ls_vence,ls_digito_raro
boolean lb_acabe

ls_vence='0600'
event lee_dw_1()
ls_cuenta=trim(String(il_cuenta,'0000000')+'-'+string(obten_digito(il_cuenta),'@'))
ls_nombre_2=al_apaterno+' '+al_amaterno+' '+al_nombre

ls_nombre_1=""
//messagebox(string(len(ls_nombre_1))+' '+ls_nombre_1,string(len(ls_nombre_2))+' '+ls_nombre_2)
li_a=99
lb_acabe=FALSE
DO UNTIL len(ls_nombre_2)=0 or li_a=0 or lb_acabe
	li_a=pos(ls_nombre_2," ")
	if li_a<>0 then
		if len(ls_nombre_1+left(ls_nombre_2,li_a))<=27 then
			ls_nombre_1=ls_nombre_1+left(ls_nombre_2,li_a)
			ls_nombre_2=mid(ls_nombre_2,li_a+1)
		else
			lb_acabe=TRUE
		end if
	else
		if len(ls_nombre_1+ls_nombre_2)<=27 then
			ls_nombre_1=ls_nombre_1+ls_nombre_2
			ls_nombre_2=""
		end if
	end if
LOOP
//messagebox(string(len(ls_nombre_1))+' '+ls_nombre_1,string(len(ls_nombre_2))+' '+ls_nombre_2)

SELECT carreras.carrera  
INTO :ls_carrera_2
FROM carreras  
WHERE carreras.cve_carrera = :al_carr
USING gtr_sce;

ls_carrera_1=""
//messagebox(string(len(ls_carrera_1))+' '+ls_carrera_1,string(len(ls_carrera_2))+' '+ls_carrera_2)
li_a=99
lb_acabe=FALSE
DO UNTIL len(ls_carrera_2)=0 or li_a=0 or lb_acabe
	li_a=pos(ls_carrera_2," ")
	if li_a<>0 then
		if len(ls_carrera_1+left(ls_carrera_2,li_a))<=27 then
			ls_carrera_1=ls_carrera_1+left(ls_carrera_2,li_a)
			ls_carrera_2=mid(ls_carrera_2,li_a+1)
		else
			lb_acabe=TRUE
		end if
	else
		if len(ls_carrera_1+ls_carrera_2)<=27 then
			ls_carrera_1=ls_carrera_1+ls_carrera_2
			ls_carrera_2=""
		end if
	end if
LOOP
//messagebox(string(len(ls_carrera_1))+' '+ls_carrera_1,string(len(ls_carrera_2))+' '+ls_carrera_2)
		
al_carr = carreras_equiv(al_carr)
ls_numcarr=string(al_carr)

SELECT count(iberoal.cuenta)
INTO :li_existe
FROM iberoal
WHERE iberoal.cuenta = :ls_cuenta
USING itr_sinf;

ls_digito_raro=obten_digito(il_cuenta)
if ls_digito_raro='A' then
	ls_digito_raro=':'
end if
ls_banda='13'+string(il_cuenta,"0000000")+'00'+string(al_carr,"000")+'0000='+ls_vence+'101'+ls_digito_raro

if li_existe=0 then	
	INSERT INTO iberoal
	( numcarr,carrera1,carrera2,alumno1,alumno2,cuenta,pleinf,plesup,banda,foto,vence )
	VALUES ( :ls_numcarr,:ls_carrera_1,:ls_carrera_2,:ls_nombre_1,:ls_nombre_2,:ls_cuenta,'ALUMNO','LICENCIATURA',:ls_banda,null,:ls_vence )
	USING itr_sinf;
	if itr_sinf.sqlerrtext<>"" then
		messagebox("",itr_sinf.sqlerrtext)
		return
	end if
	commit using itr_sinf;	
else	
	UPDATE iberoal
	SET numcarr = :ls_numcarr,
		carrera1 = :ls_carrera_1,
		carrera2 = :ls_carrera_2,
		alumno1 = :ls_nombre_1,
		alumno2 = :ls_nombre_2,
		pleinf = 'ALUMNO',
		plesup = 'LICENCIATURA',
		banda = :ls_banda,
		vence = :ls_vence
	WHERE iberoal.cuenta = :ls_cuenta
	USING itr_sinf;
	if itr_sinf.sqlerrtext<>"" then
		messagebox("",itr_sinf.sqlerrtext)
		return
	end if
	commit using itr_sinf;
end if
end event

on w_enlace_informes.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_pagado=create cbx_pagado
this.st_1=create st_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={this.cbx_pagado,&
this.st_1,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_enlace_informes.destroy
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

if conecta_bd(itr_sinf,gs_sinf,"admin","")=0 then
	close(this)
end if

IF IsValid(This) THEN 
	dw_1.settransobject(gtr_sadm)
END IF	
end event

event close;desconecta_bd(itr_sinf)
end event

type cbx_pagado from checkbox within w_enlace_informes
integer x = 3072
integer y = 64
integer width = 430
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Insc. Pagada"
end type

type st_1 from statictext within w_enlace_informes
integer x = 9
integer y = 208
integer width = 3520
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;text=""
end event

type dw_1 from uo_dw_reporte within w_enlace_informes
integer x = 18
integer y = 332
integer width = 3520
integer height = 1176
integer taborder = 0
string dataobject = "dw_aspi-aceptados"
boolean hscrollbar = true
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

type uo_1 from uo_ver_per_ani within w_enlace_informes
integer x = 27
integer y = 24
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_enlace_informes
integer x = 2715
integer y = 52
integer width = 338
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_enlace_informes
integer x = 2359
integer y = 52
integer width = 338
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

