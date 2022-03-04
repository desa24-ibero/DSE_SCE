$PBExportHeader$w_enlace_cobranzas.srw
forward
global type w_enlace_cobranzas from window
end type
type st_1 from statictext within w_enlace_cobranzas
end type
type dw_1 from uo_dw_reporte within w_enlace_cobranzas
end type
type uo_1 from uo_ver_per_ani within w_enlace_cobranzas
end type
type em_max from editmask within w_enlace_cobranzas
end type
type em_min from editmask within w_enlace_cobranzas
end type
end forward

global type w_enlace_cobranzas from window
integer x = 832
integer y = 360
integer width = 3561
integer height = 1696
boolean titlebar = true
string title = "Enlace del Sistema de Admisión al Sistema de Cobranzas"
string menuname = "m_menu"
long backcolor = 30976088
event type long num_folios ( integer min_max )
event enlace ( )
event lee_dw_1 ( )
event cobranzas ( )
st_1 st_1
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
end type
global w_enlace_cobranzas w_enlace_cobranzas

type variables
int al_carr
long il_cont,il_cuenta
string al_nombre,al_apaterno,al_amaterno,al_calle,al_colonia,al_cp,al_tele
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
	event cobranzas()
next

st_1.text="Ya acabe"
end event

event lee_dw_1;		al_nombre=dw_1.object.general_nombre[il_cont]
		al_apaterno=dw_1.object.general_apaterno[il_cont]
		al_amaterno=dw_1.object.general_amaterno[il_cont]
		al_calle=dw_1.object.general_calle[il_cont]
		al_cp=dw_1.object.general_codigo_pos[il_cont]
		al_colonia=dw_1.object.general_colonia[il_cont]
		al_tele=dw_1.object.general_telefono[il_cont]
		al_carr=dw_1.object.aspiran_clv_carr[il_cont]
end event

event cobranzas;int existe
long cp
string digito,nombre,domicilio

event lee_dw_1()
digito=obten_digito(il_cuenta)
cp=long(al_cp)
nombre=al_apaterno+' '+al_amaterno+' '+al_nombre
domicilio=al_calle+' '+al_colonia

if isnull(al_tele) then
	al_tele=""
end if

if isnull(cp) then
	cp=0
end if
	
  SELECT count(alumnos.cuenta)  
    INTO :existe
    FROM alumnos  
   WHERE alumnos.cuenta = :il_cuenta
   USING gtr_scob;

al_carr=carreras_equiv(al_carr)

if existe=0 then	
  INSERT INTO alumnos  
         ( cuenta,digito,nombre,domicilio,cod_pos,tel,cve_carrera,nivel,estado,promedio )  
  VALUES ( :il_cuenta,:digito,:nombre,:domicilio,:cp,:al_tele,:al_carr,'L','I',0 )
  USING gtr_scob;
  if gtr_scob.sqlerrtext<>"" then
	  messagebox("Insert",gtr_scob.sqlerrtext)
	  return
  end if

  commit using gtr_scob;

else
	UPDATE alumnos
	SET cve_carrera = :al_carr,
	cod_pos = :cp
	WHERE alumnos.cuenta = :il_cuenta
	USING gtr_scob;
	if gtr_scob.sqlerrtext<>"" then
		messagebox("Update",gtr_scob.sqlerrtext)	
		return
	end if

	commit using gtr_scob;
end if
end event

on w_enlace_cobranzas.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_1=create st_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.Control[]={this.st_1,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min}
end on

on w_enlace_cobranzas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
end on

event open;x=1
y=1

if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)=0 then
	close(this)
end if

dw_1.settransobject(gtr_sadm)
end event

event close;desconecta_bd(gtr_scob)
end event

type st_1 from statictext within w_enlace_cobranzas
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

type dw_1 from uo_dw_reporte within w_enlace_cobranzas
integer x = 18
integer y = 332
integer width = 3520
integer height = 1176
integer taborder = 0
string dataobject = "dw_aspi-aceptados"
boolean hscrollbar = true
end type

event carga;st_1.text="Leyendo datos de los aspirantes que han pagado"
return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text),0)
end event

event retrieveend;call super::retrieveend;parent.event enlace()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_1 from uo_ver_per_ani within w_enlace_cobranzas
integer x = 27
integer y = 24
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_enlace_cobranzas
integer x = 2912
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

type em_min from editmask within w_enlace_cobranzas
integer x = 2555
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

