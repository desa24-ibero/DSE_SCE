$PBExportHeader$w_academicos.srw
forward
global type w_academicos from w_ancestral
end type
type dw_academicos from uo_dw_captura within w_academicos
end type
type cb_1 from commandbutton within w_academicos
end type
type uo_1 from uo_per_ani within w_academicos
end type
end forward

global type w_academicos from w_ancestral
int Height=2285
boolean TitleBar=true
string Title="Respalda Académicos"
string MenuName="m_menu"
dw_academicos dw_academicos
cb_1 cb_1
uo_1 uo_1
end type
global w_academicos w_academicos

on w_academicos.create
int iCurrent
call w_ancestral::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_academicos=create dw_academicos
this.cb_1=create cb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_academicos
this.Control[iCurrent+2]=cb_1
this.Control[iCurrent+3]=uo_1
end on

on w_academicos.destroy
call w_ancestral::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_academicos)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;call super::open;periodo_actual(gi_periodo,gi_anio,gtr_sce)
end event

type dw_academicos from uo_dw_captura within w_academicos
int X=1
int Y=417
int Width=3534
int Height=1669
int TabOrder=10
string DataObject="d_academicos"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type cb_1 from commandbutton within w_academicos
int X=1459
int Y=261
int Width=650
int Height=109
int TabOrder=20
boolean BringToTop=true
string Text="Respalda Académicos"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_total
string ls_usuario
datetime hoy,hace_rato
dw_academicos.settransobject(gtr_sce)
SetPointer(HourGlass!)

SELECT cortes.usuario
INTO :ls_usuario
FROM cortes
WHERE ( cortes.periodo = :gi_periodo ) AND
	( cortes.anio = :gi_anio ) AND
	( cortes.cve_actividad = 1 ) AND
	( cortes.cve_status = 5 )
USING gtr_sce;

if ls_usuario<>"" then
	messagebox(ls_usuario,"ya realizó el respaldo.")
	close(parent)
	return
end if

hoy=fecha_servidor(gtr_sce)
INSERT INTO cortes
	( anio,periodo,cve_actividad,fecha_inicio,fecha_fin,usuario,cve_status )
VALUES ( :gi_anio,:gi_periodo,1,:hoy,:hoy,:gs_usuario,0 )
USING gtr_sce;
if gtr_sce.sqlerrtext<>"" then
		messagebox("Error en cortes",gtr_sce.sqlerrtext)
		rollback using gtr_sce;
		close(parent)
		return
	else
		commit using gtr_sce;
end if

if dw_academicos.event carga()>0 then
	IF FileExists("c:\academicos.txt") THEN
		if MessageBox("Salvar encontró un respaldo anterior","¿Sobreescribo c:\academicos.txt?",Question!, YesNo!)=2 then
			close(parent)
			return
		end if
	end if
	if dw_academicos.SaveAs("c:\academicos.txt",Text!, FALSE)<>1 then
		messagebox("No se pudo respaldar.","Verifique si tiene espacio en c:\")
		close(parent)
		return
	end if
	
	//TRUNCATE TABLE academicos2 using gtr_sce;
	DELETE FROM academicos2 using gtr_sce;
	if gtr_sce.sqlerrtext<>"" then
		messagebox("Error en Académicos 2, Borrar",gtr_sce.sqlerrtext)
		rollback using gtr_sce;
		close(parent)
		return
	else
		commit using gtr_sce;
	end if
	
	INSERT INTO academicos2
	SELECT *
	FROM academicos  
	using gtr_sce;
	if gtr_sce.sqlerrtext<>"" then
		messagebox("Error en Académicos 2, Salvar",gtr_sce.sqlerrtext)
		rollback using gtr_sce;
		close(parent)
		return
	else
		commit using gtr_sce;
	end if

	hace_rato=hoy
	hoy=fecha_servidor(gtr_sce)
	UPDATE cortes
	SET cve_status = 5, fecha_fin = :hoy
	WHERE ( cortes.anio = :gi_anio ) AND
		( cortes.periodo = :gi_periodo ) AND
		( cortes.cve_actividad = 1 ) AND
		( cortes.fecha_inicio = :hace_rato ) AND
		( cortes.usuario = :gs_usuario )
	USING gtr_sce;
	if gtr_sce.sqlerrtext<>"" then
		messagebox("Error en cortes",gtr_sce.sqlerrtext)
		rollback using gtr_sce;
		close(parent)
		return
	else
		commit using gtr_sce;
	end if
	close(parent)
	messagebox("Información Respaldada.","No elimine c:\academicos.txt")
else
	SELECT count(cuenta)
	INTO :ll_total
	FROM academicos2
	using gtr_sce;
	if ll_total=0 then	
		IF FileExists("c:\academicos.txt") THEN
			if dw_academicos.ImportFile("c:\academicos.txt")<1 then
				messagebox("PROBLEMA GRAVE","No se pudo leer el respaldo.")
			else
				messagebox("Información Recuperada","")
			end if
		ELSE
			messagebox("PROBLEMA GRAVE","No se pudo leer el respaldo.")
		END IF
	else
		INSERT INTO academicos
		SELECT *
		FROM academicos2
		using gtr_sce;
		if gtr_sce.sqlerrtext<>"" then
			messagebox("Error en Académicos, Salvar",gtr_sce.sqlerrtext)
			rollback using gtr_sce;
		else
			commit using gtr_sce;
			dw_academicos.event carga()
			close(parent)
			messagebox("Información Recuperada","")
		end if
	end if
end if
end event

type uo_1 from uo_per_ani within w_academicos
int X=1162
int Y=57
int TabOrder=1
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

