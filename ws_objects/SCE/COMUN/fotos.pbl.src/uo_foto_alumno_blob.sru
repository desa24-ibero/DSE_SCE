$PBExportHeader$uo_foto_alumno_blob.sru
forward
global type uo_foto_alumno_blob from u_base
end type
type p_photo from u_p within uo_foto_alumno_blob
end type
end forward

global type uo_foto_alumno_blob from u_base
integer width = 475
integer height = 476
boolean border = true
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = styleraised!
long picturemaskcolor = 536870912
p_photo p_photo
end type
global uo_foto_alumno_blob uo_foto_alumno_blob

forward prototypes
public subroutine of_blobtofile (string as_filename, blob ablb_blob)
public function blob of_getphoto (long al_cuenta, integer ai_tipo, transaction atr_fotos)
public function string of_loadphoto (long al_cuenta, integer ai_tipo, transaction atr_transaction, integer ai_borra_archivo_foto)
end prototypes

public subroutine of_blobtofile (string as_filename, blob ablb_blob);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_blobtofile
//
//	Access:  public
//
//	Arguments:
//	as_filename		La ruta y el nombre del archivo a grabar.
//	ablb_blob		Objeto tipo BLOB que se va a guardar como
//						archivo.
//
//	Returns:
//	None
//
//	Description:
//	Recibe un objeto tipo BLOB y lo guarda en un archivo en formato binario
//	con el nombre dado por el usuario.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
Long    ll_FileLength
Integer li_Loops, li_Index, li_FileNum
Blob    lblb_Temp

ll_FileLength = Len(ablb_blob)

IF ll_FileLength > 32765 THEN
  IF Mod(ll_FileLength, 32765) = 0 THEN
    li_Loops = ll_FileLength / 32765
  ELSE
    li_Loops = (ll_FileLength / 32765) + 1
  END IF
ELSE
  li_Loops = 1
END IF
  
li_FileNum = FileOpen(as_filename, StreamMode!, Write!, LockReadWrite!, Replace!)
FOR li_Index = 1 TO li_Loops
  lblb_Temp = BlobMid(ablb_blob, ((32765 * li_Index) - 32765 + 1), 32765)
  FileWrite(li_FileNum, lblb_Temp)
NEXT

FileClose(li_FileNum)
end subroutine

public function blob of_getphoto (long al_cuenta, integer ai_tipo, transaction atr_fotos);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_getphoto
//
//	Access:  public
//
//	Arguments:
//	al_cuenta		Número de cuenta de un alumno.
//	ai_tipo			Identificador de la fuente de donde tomará la fotografía:
//						1 = fotos_alumnos
//						2 = fotos_alumnos_dica
//
//	Returns:
//	Blob
//
//	Description:
//	Recupera de la base de datos la fotografía de un alumno que tiene la
//	cuenta indicada y que corresponde al tipo solicitado.
//	La imagen es devuelta como una variable de tipo blob.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer li_tipoAl
Blob lblob_foto

li_tipoAl =ai_tipo

// Seleccion del blob de foto del alumno segun el argumento 'al_cuenta'
if li_tipoAl =1 then

	SELECTBLOB foto
	INTO :lblob_foto 
	FROM fotos_alumnos
	WHERE cuenta = :al_cuenta
	Using atr_fotos;
end if

if li_tipoAl =2 then

	SELECTBLOB foto
	INTO :lblob_foto 
	FROM fotos_alumnos_dica
	WHERE cuenta = :al_cuenta
	Using atr_fotos;
end if


if atr_fotos.sqlcode <> 0 then
     MessageBox ('No se encontro la fotografía', atr_fotos.sqlerrtext,StopSign!)
     SetNull(lblob_foto)
end if

Return lblob_foto
end function

public function string of_loadphoto (long al_cuenta, integer ai_tipo, transaction atr_transaction, integer ai_borra_archivo_foto);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_loadphoto
//
//	Access:  public
//
//	Arguments:
//	al_cuenta		Número de cuenta de un alumno.
//						Este parámetro es necesario porque lo requiere la función
//						of_getphoto (vea la documentación de la función)
//	ai_tipo			Identificador de la fuente de donde tomará la fotografía.
//						Este parámetro es necesario porque lo requiere la función
//						of_getphoto (vea la documentación de la función)
//atr_transaction Transaccion de base de datos de fotos
//
//ai_borra_archivo_foto Indica si se borrara la foto del directorio una vez mostrada
//
//	Returns:
//	None
//
//	Description:
//	Primero. Recupera de la base de datos la imagen asociada a la cuenta.
//	Segundo. La guarda como un archivo en formato jpg.
//	Tercero. Carga la fotografía del alumno en el control gvbox.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
string ls_filename, ls_filename_aux = "QWERTPOUY.jpg"
blob lblob_photo
long ll_width = 494, ll_height = 496

ls_filename = "photo_" + string(al_cuenta) + ".jpg"
if not FileExists(ls_filename) then
	lblob_photo = this.of_getphoto(al_cuenta,ai_tipo,atr_transaction)
	if not isnull(lblob_photo) then
		this.of_blobtofile(ls_filename,lblob_photo)
		p_photo.picturename = ls_filename_aux
		p_photo.picturename = ls_filename
	
//SI EL PARAMETRO LO INDICA BORRA LA FOTO
		if ai_borra_archivo_foto = 1 then
			FileDelete(ls_filename)
		end if
	else
		p_photo.picturename = ''
		MessageBox("Foto no encontrada", "No se ha podido mostrar la foto",StopSign!)
		//	this.of_filename("")
	end if
else	
	p_photo.picturename = ls_filename_aux
	p_photo.picturename = ls_filename
//SI EL PARAMETRO LO INDICA BORRA LA FOTO
	if ai_borra_archivo_foto = 1 then
		FileDelete(ls_filename)
	end if
end if


	
return ls_filename



end function

on uo_foto_alumno_blob.create
int iCurrent
call super::create
this.p_photo=create p_photo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_photo
end on

on uo_foto_alumno_blob.destroy
call super::destroy
destroy(this.p_photo)
end on

event constructor;call super::constructor;this.of_SetResize(TRUE)

end event

event resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//	Send resize notification to services
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_inc_width, li_inc_height


li_inc_width = newwidth - This.Width 
li_inc_height = newheight - This.Height 


//this.p_photo.Width  = p_photo.Width  + li_inc_width
//this.p_photo.Height = p_photo.Height + li_inc_height

this.p_photo.Width  = This.Width * 1.05
this.p_photo.Height = This.Width


// Notify the resize service that the object size has changed.
If IsValid (inv_resize) Then
	inv_resize.Event pfc_resize (sizetype, This.Width , This.Width)
End If


end event

type p_photo from u_p within uo_foto_alumno_blob
integer width = 475
integer height = 476
borderstyle borderstyle = styleraised!
end type

