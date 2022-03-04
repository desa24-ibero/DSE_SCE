$PBExportHeader$w_ancestro_rep_sce.srw
forward
global type w_ancestro_rep_sce from w_main
end type
type tab_1 from tab within w_ancestro_rep_sce
end type
type tabpage_general from userobject within tab_1
end type
type tabpage_general from userobject within tab_1
end type
type tabpage_individual from userobject within tab_1
end type
type tabpage_individual from userobject within tab_1
end type
type tab_1 from tab within w_ancestro_rep_sce
tabpage_general tabpage_general
tabpage_individual tabpage_individual
end type
end forward

global type w_ancestro_rep_sce from w_main
integer width = 4288
integer height = 2152
string title = "Ancestro de Reportes"
string menuname = "m_ancestro_rep_sce"
tab_1 tab_1
end type
global w_ancestro_rep_sce w_ancestro_rep_sce

on w_ancestro_rep_sce.create
int iCurrent
call super::create
if this.MenuName = "m_ancestro_rep_sce" then this.MenuID = create m_ancestro_rep_sce
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ancestro_rep_sce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

type tab_1 from tab within w_ancestro_rep_sce
integer x = 27
integer width = 4151
integer height = 1932
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_individual tabpage_individual
end type

on tab_1.create
this.tabpage_general=create tabpage_general
this.tabpage_individual=create tabpage_individual
this.Control[]={this.tabpage_general,&
this.tabpage_individual}
end on

on tab_1.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_individual)
end on

type tabpage_general from userobject within tab_1
integer x = 18
integer y = 128
integer width = 4114
integer height = 1788
long backcolor = 79741120
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_individual from userobject within tab_1
integer x = 18
integer y = 128
integer width = 4114
integer height = 1788
long backcolor = 79741120
string text = "Individual"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

