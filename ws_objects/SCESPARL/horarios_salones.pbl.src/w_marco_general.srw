﻿$PBExportHeader$w_marco_general.srw
forward
global type w_marco_general from window
end type
type mdi_1 from mdiclient within w_marco_general
end type
end forward

global type w_marco_general from window
integer width = 3653
integer height = 2256
boolean titlebar = true
string menuname = "m_menu_margo_general"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
mdi_1 mdi_1
end type
global w_marco_general w_marco_general

on w_marco_general.create
if this.MenuName = "m_menu_margo_general" then this.MenuID = create m_menu_margo_general
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_marco_general.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_marco_general
long BackColor=268435456
end type

on mdi_1.destroy
end on

