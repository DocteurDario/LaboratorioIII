GO
Alter Procedure SP_Nueva(
	--@SumaPacientes int,
	@IDO int
	

)
as
Begin
   Declare @SumaObraSociale INT

  -- Set @SumaObraSociale= (Select count(*) From OBRAS_SOCIALES Where @IDO=IDOBRASOCIAL)
	Select @SumaObraSociale= Count (*) From OBRAS_SOCIALES where @IDO=IDOBRASOCIAL  
	/*Esta opcion permite agregar mas variables  ejmplo @A=A,@B=B */
		if  @SumaObraSociale=1 Begin
			Print 'El Cliente Existe'
			Select * From OBRAS_SOCIALES where IDOBRASOCIAL=@IDO
	End
	Else Begin
		Print 'El cliente No Existe'
		End
End

	Exec SP_Nueva 1

	Select *From OBRAS_SOCIALES