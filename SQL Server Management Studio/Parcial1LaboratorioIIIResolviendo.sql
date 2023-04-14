declare @ConcursoFinalizado bit = 0
select @ConcursoFinalizado = 1 from Fotografias F inner join Concursos C on c.ID = F.IDConcurso where GETDATE() >= C.INicio and GETDATE() <= C.Fin
select @ConcursoFinalizado = 1 from Fotografias F inner join Concursos C on c.ID = F.IDConcurso where GETDATE() BETWEEN C.INicio and C.Fin
declare @Cantidad int
select @Cantidad = COUNT(*) from Fotografias F inner join Concursos C on c.ID = F.IDConcurso where GETDATE() BETWEEN C.INicio and C.Fin

IF @ConcursoFinalizado = 1
IF EXISTS (select F.ID from Fotografias F inner join Concursos C on c.ID = F.IDConcurso where GETDATE() BETWEEN C.INicio and C.Fin)
IF (select COUNT(*) from Fotografias F inner join Concursos C on c.ID = F.IDConcurso where GETDATE() BETWEEN C.INicio and C.Fin) >= 1
IF @Cantidad >= 1
begin
	--update descalidifcado en fotografia
	--delete votaciones
end

--1)	Hacer un procedimiento almacenado llamado SP_Ranking que a partir de un 
--IDParticipante se pueda obtener las tres mejores fotografías publicadas (si las hay). 
--Indicando el nombre del concurso, apellido y nombres del participante, 
--el título de la publicación, la fecha de publicación y el puntaje promedio 
--obtenido por esa publicación.
--(20 puntos)

GO
Create or Alter Procedure SP_RanKing(
	@IdParcicipante int	
)
As
Begin
	Select 
		distinct top 3 F.id,
		C.Titulo,
		P.Nombres,
		P.Apellidos,
		C.Titulo,
		F.Publicacion,
		(Select avg (Puntaje) From Votaciones V where F.ID=V.IDFotografia ) As PuntajePromedio
	From Fotografias F
	Inner Join Participantes P On F.IDParticipante=P.ID
	Inner Join Votaciones V On V.IDFotografia=F.ID
	Inner Join Concursos C On C.Id=F.IdConcurso
	Where F.IDParticipante=@IdParcicipante
End

Exec SP_RanKing 2

select * from participantes

--2)Hacer un procedimiento almacenado llamado SP_Descalificar 
--que reciba un ID de fotografía y realice la descalificación de la misma. 
--También debe eliminar todas las votaciones registradas a la fotografía en cuestión. 
--Sólo se puede descalificar una fotografía si pertenece a un concurso no finalizado.
--(20 puntos)
GO
Create Or Alter Procedure SP_Descalificar (
	@IDFotografia int
)
AS
Begin 
	Declare @NoFinalizo int
	
	Select @Nofinalizo = count (1) From  Fotografias F
	Inner Join Concursos C On C.ID=F.IdConcurso
	where F.Id=1 and  F.Publicacion>=C.Inicio and F.Publicacion<= C.Fin

	If @Nofinalizo>0
	Begin
		UpDate Fotografias set Descalificada=1 where Id=@IDFotografia
		Delete From Votaciones where IDFotografia=@IDFotografia
		print 'Fotografia Descalificada Exitosamente'
	End
End

--Select * From Fotografias F
--Inner Join Concursos C On F.IDConcurso= C.ID

-- 4)Al insertar una votación, verificar que el usuario que vota no lo haga más de una vez para 
--el mismo concurso ni se pueda votar a sí mismo. Tampoco puede votar una fotografía descalificada.
--(20 puntos)

GO
Create or Alter Trigger Tr_AgregarVotación on Votaciones
Instead Of Insert
As
Begin
      Declare @IDVotante int, @IdFotografia int, @Puntaje decimal, @ExisteV int,@Voto int 

	  Select  @IDVotante= IdVotante, @IdFotografia=IDFotografia, @Puntaje=Puntaje  From inserted

	  Select @ExisteV= count (*) From Votaciones V	Inner Join Fotografias F On V.IDFotografia=F.ID
	  Where V.IDVotante = @IDVotante  and F.ID=@IdFotografia

	  Select @Voto= count (*) From Fotografias Where ID=@IdFotografia and IDParticipante=@IDVotante	
	  IF  @ExisteV=0
	  Begin 
			If @Voto=0
			Begin
				If 0=(Select count (*)  From Fotografias Where ID=@IdFotografia and Descalificada=1)
				Begin
					Insert into Votaciones(IdVotante,IDFotografia,Fecha,Puntaje)Values(@IDVotante,@IdFotografia,Getdate(),@Puntaje)
					Print'Votacion Ingresada'
				End
			End
	  End
End 

Insert into Votaciones(IdVotante,IDFotografia,Fecha,Puntaje)Values(3,13,Getdate(),7)

Select * From Votaciones
Select * From Fotografias


--3)	Al insertar una fotografía verificar que el usuario creador de la fotografía 
--tenga el ranking suficiente para participar en el concurso. También se debe verificar que 
--el concurso haya iniciado y no finalizado. Además, el participante no debe registrar una 
--descalificación en los últimos 100 días. Si ocurriese un error, mostrarlo con un mensaje aclaratorio. 
--De lo contrario, insertar el registro teniendo en cuenta que la fecha de publicación es la fecha y 
--hora del sistema.
GO
Create or Alter Trigger Tr_AgregarFoto on Fotografias
Instead Of Insert
As
Begin
	Declare @IdPArticipante int,@IdConcurso int, @Titulo varchar(150),@Fecha date, @ranking decimal


	Select @IdPArticipante= IdParticipante ,@IdConcurso=IdConcurso, @Titulo= Titulo From inserted

	Select @ranking=  avg (V.Puntaje) From Participantes P
	Inner Join Fotografias F On P.ID=F.ID
	Inner Join Votaciones V on F.Id=V.IdFotografia
	where P.Id=@IdPArticipante


	IF EXISTS(Select top 1 Id from Concursos Where ID=2 and @ranking>=RankingMinimo) 
	Begin
		If  EXISTS (Select ID From Concursos where Id=@IDConcurso and getdate()>=Inicio and getDate()<=Fin)
		Begin 
			IF 
			(Select top 1
			DATEDIFF (day, F.Publicacion, GetDate() ) AS Diferncia
			From Participantes P
			Inner Join Fotografias F on P.Id=F.IDParticipante
			Where F.Descalificada=0 and F.IdParticipante=1
			order by Diferncia Desc) < 100
			begin
				Insert into Fotografias (IDParticipante,IDConcurso,Titulo,Descalificada,Publicacion) Values (@IdPArticipante ,@IdConcurso , @Titulo,0,getdate())
			End
			Else Begin
			    RAISERROR ('Error al intentar cargar la foto.....',16,1)
			End
		End
		Else Begin
			RAISERROR ('Error al intentar cargar la foto.....',16,1)
		End 
	End
	Else Begin
		RAISERROR ('Error al intentar cargar la foto.....',16,1)
	End
End


Insert into Fotografias (IDParticipante,IDConcurso,Titulo,Descalificada,Publicacion) Values (2 ,2 , 'FOTASA',0,getdate())

Select * from Fotografias

Select * From Concursos
Use ExamenIntegrador20222C