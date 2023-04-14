GO
Create or Alter Procedure SP_Estadistica
As
Begin
	Select 
		 distinct Ta.Id,
		(Select Sum (Tamaño) From Archivos A Where IdTipo= TA.Id and U.IdTipo=Tipo.Id)AS TotalMBs
	From TiposArchivo TA
	Inner Join Archivos A On TA.Id=A.IDTIPO
	Inner Join Usuarios U On A.IdUsuario=U.Id
	Inner Join TiposCuenta Tipo On U.IdTipo=Tipo.Id
	Order By TotalMBs desc
End

GO
Create or Alter Trigger Tr_CompartirArchivo On Compartidos
Instead Of Insert
As
Begin
	Declare @IDArchivo	bigint 
    Declare @Fecha		date
    Declare @Permiso	char 
    Declare @IDUsuario	bigint 
	Declare @ExiteUs int
	Declare @TpCuenta int
	Declare @IDTipoCuenta Int

	Select @IDArchivo=IDArchivo, @Fecha=Fecha, @Permiso=Permiso,@IDUsuario=IDUsuario From inserted

	Select @ExiteUs=count(*) From Archivos Where IdUsuario=@IDUsuario and Id=@IDArchivo

	--Select @TpCuenta=count(*)From Usuarios Where IDTipo='R'and @IDUsuario=@IDUsuario

	Select @IDTipoCuenta=u.IDTipo From Usuarios As u Where u.ID=@IDUsuario

	If @ExiteUs=0 
	begin
		if @TpCuenta=1
		begin
			If @Permiso='W'
			Begin 
				RAISERROR ('tipo de cuenta insuficiente, se cancelar la inserción del registro.....',16,1)
			End
			Else begin 
				Insert into Compartidos (IDArchivo,Fecha,Permiso,IDUsuario) values (@IDArchivo,getDate(),'R',@IDUsuario)
			End
		end
		else begin
			Insert into Compartidos (IDArchivo,Fecha,Permiso,IDUsuario) values (@IDArchivo,getDAte(),'W',@IDUsuario)
		end
	End
End