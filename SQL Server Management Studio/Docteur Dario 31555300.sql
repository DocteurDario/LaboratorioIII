Use ExamenIntegrador2022C
Go
Select *From Fotografias
-- 5)Hacer un listado en el que se obtenga: 
--ID de participante, apellidos y nombres de los participantes que hayan registrado 
--al menos dos fotografías descalificadas.

Select	P.Id, P.Apellidos,P.Nombres,
		(Select count (*) From Fotografias F
			Where F.IDParticipante=P.Id ) AS CantidadFotos,
		(Select count (*) From Fotografias F
			Where F.IDParticipante=P.Id And F.Descalificada=1) As CantidaDescalificada
From Participantes P
	--Inner Join Fotografias F On P.ID=F.IDParticipante
	Where (Select count (*) From Fotografias F
			Where F.IDParticipante=P.Id And F.Descalificada=1) >=2




--Hacer un procedimiento almacenado llamado SP_Ranking que a partir 
--de un IDParticipante se pueda obtener las tres mejores fotografías publicadas 
--(si las hay). Indicando el nombre del concurso, apellido y nombres del participante, 
--el título de la publicación, la fecha de publicación y el puntaje promedio obtenido por esa publicación.

Create Procedure SP_Ranking(
	@IDParticipante Bigint
) 
As
Begin 
		Select top 3
			P.ID,
			P.Apellidos,
			P.Nombres,
			F.Titulo,
			F.Publicacion,

			(Select Avg(Puntaje) From Votaciones V
				Inner Join Fotografias F On F.ID=V.IDFotografia
			Where F.IDParticipante=P.ID
			) As PuntajePromedio			
		From Participantes P
		Inner Join Fotografias F On F.Id= P.ID
		Inner Join Votaciones V On F.ID=V.IDFotografia
		Where P.ID=@IDParticipante
		Order By F.Id,PuntajePromedio Desc

End

Exec SP_Ranking 1


--3 Hacer un procedimiento almacenado llamado SP_Descalificar que reciba un 
--ID de fotografía y realice la descalificación de la misma. También debe eliminar 
--todas las votaciones registradas a la fotografía en cuestión. Sólo se puede descalificar 
--una fotografía si pertenece a un concurso no finalizado.
Create Procedure SP_Descalificar (
	@Id bigint

)
As
Begin
	UPDATE Fotografias Set Descalificada =1
	Where Id=@Id
End

Exec SP_Descalificar 1

/*
--4) Al insertar una votación, verificar que el usuario que vota no lo haga más de una vez 
--para el mismo concurso ni se pueda votar a sí mismo. Tampoco puede votar una fotografía descalificada.
----------------------
--Tabla      : Votacion
--Tipo Tigger: After
--Accion     : Insert
----------------------
Create Trigger Tr_Nueva_Votacion On Votaciones
After Insert
As
Begin
	
	Declare @ID				bigint			
	Declare @IDVotante		bigint	
	Declare @IDFotografia	bigint	
	Declare @Fecha			date			
	Declare @Puntaje		decimal(5,2)

	Select @ID			=	ID				From Inserted
	Select @IDVotante	=	IDVotante		From Inserted	
	Select @IDFotografia=	IDFotografia	From Inserted	
	Select @Fecha		=	Fecha			From Inserted	
	Select @Puntaje		=	Puntaje			From Inserted
*/
	

