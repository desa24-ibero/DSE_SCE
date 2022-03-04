﻿$PBExportHeader$w_eti_exped.srw
$PBExportComments$Etiquetas para expedientes, selecciona la carrera
forward
global type w_eti_exped from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_eti_exped
end type
type uo_2 from uo_carrera within w_eti_exped
end type
type uo_1 from uo_ver_per_ani within w_eti_exped
end type
type dw_1 from uo_dw_reporte within w_eti_exped
end type
end forward

global type w_eti_exped from Window
int X=834
int Y=362
int Width=3683
int Height=1869
boolean TitleBar=true
string Title="Etiquetas para Expedientes"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_eti_exped w_eti_exped

on w_eti_exped.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_eti_exped.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_eti_exped
int X=1280
int Y=32
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_2 from uo_carrera within w_eti_exped
int X=2297
int Y=13
boolean Enabled=true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_eti_exped
int X=37
int Y=13
int Width=1243
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_eti_exped
int X=37
int Y=237
int Width=3606
int Height=1427
int TabOrder=0
string DataObject="dw_eti_exped"
boolean HScrollBar=true
end type

event constructor;call super::constructor;//DataWindowChild carr
//getchild("clv_carr",carr)
//carr.settransobject(gtr_sce)
//carr.retrieve()
end event

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_eti_exped"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_eti_exped_ing"
	this.SetTransObject(gtr_sadm)	
END IF
event primero()
return retrieve(gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

