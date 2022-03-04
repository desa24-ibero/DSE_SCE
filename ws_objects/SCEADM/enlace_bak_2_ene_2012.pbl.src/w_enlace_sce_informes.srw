$PBExportHeader$w_enlace_sce_informes.srw
forward
global type w_enlace_sce_informes from Window
end type
type st_1 from statictext within w_enlace_sce_informes
end type
type dw_1 from uo_dw_reporte within w_enlace_sce_informes
end type
type em_max from editmask within w_enlace_sce_informes
end type
type em_min from editmask within w_enlace_sce_informes
end type
end forward

global type w_enlace_sce_informes from Window
int X=833
int Y=361
int Width=3562
int Height=1697
boolean TitleBar=true
string Title="Enlace del Sistema de Control Escolar al Sistema de Informes"
string MenuName="m_menu"
long BackColor=30976088
event type long num_folios ( integer min_max )
event enlace ( )
event lee_dw_1 ( )
event informes ( )
st_1 st_1
dw_1 dw_1
em_max em_max
em_min em_min
end type
global w_enlace_sce_informes w_enlace_sce_informes

type variables
int al_carr
long il_cont,il_cuenta
string al_nombre,al_apaterno,al_amaterno,al_nivel
transaction itr_sinf
end variables

event num_folios;long folios

if min_max=0 then
	SELECT min(cuenta)
	INTO :folios
	FROM dbo.alumnos
	USING gtr_sce;
else
	SELECT max(cuenta)
	INTO :folios
	FROM dbo.alumnos
	USING gtr_sce;
end if

return folios
end event

event enlace;SetPointer(HourGlass!)

for il_cont=1 to dw_1.rowcount()
	il_cuenta=dw_1.object.academicos_cuenta[il_cont]
	st_1.text="Leyendo datos de "+string(il_cuenta)
	event informes()
next

st_1.text="Ya acabe"
end event

event lee_dw_1;al_nombre=dw_1.object.alumnos_nombre[il_cont]
al_apaterno=dw_1.object.alumnos_apaterno[il_cont]
al_amaterno=dw_1.object.alumnos_amaterno[il_cont]
al_carr=dw_1.object.academicos_cve_carrera[il_cont]
if dw_1.object.academicos_nivel[il_cont]='L' then
	al_nivel='LICENCIATURA'
else
	al_nivel='POSGRADO'
end if
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
	VALUES ( :ls_numcarr,:ls_carrera_1,:ls_carrera_2,:ls_nombre_1,:ls_nombre_2,:ls_cuenta,'ALUMNO',:al_nivel,:ls_banda,null,:ls_vence )
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
		plesup = :al_nivel,
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

on w_enlace_sce_informes.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_1=create st_1
this.dw_1=create dw_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={ this.st_1,&
this.dw_1,&
this.em_max,&
this.em_min}
end on

on w_enlace_sce_informes.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.em_max)
destroy(this.em_min)
end on

event open;x=1
y=1

if conecta_bd(itr_sinf,"sinf","admin","")=0 then
	close(this)
end if

dw_1.settransobject(gtr_sce)
end event

event close;desconecta_bd(itr_sinf)
end event

type st_1 from statictext within w_enlace_sce_informes
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

type dw_1 from uo_dw_reporte within w_enlace_sce_informes
int X=19
int Y=333
int Width=3521
int Height=1177
int TabOrder=0
string DataObject="dw_enlace_sce"
boolean HScrollBar=true
end type

event carga;return retrieve(long(em_min.text),long(em_max.text))
end event

event retrieveend;call super::retrieveend;parent.event enlace()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type em_max from editmask within w_enlace_sce_informes
int X=1783
int Y=49
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

type em_min from editmask within w_enlace_sce_informes
int X=1427
int Y=49
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

