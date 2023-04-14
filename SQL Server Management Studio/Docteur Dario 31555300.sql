Use ExamenIntegrador2022C
Go
Select *From Fotografias
-- 5)Hacer un listado en el que se obtenga: 
--ID de participante, apellidos y nombres de los participantes que hayan registrado 
--al menos dos fotograf�as descalificadas.

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
--de un IDParticipante se pueda obtener las tres mejores fotograf�as publicadas 
--(si las hay). Indicando el nombre del concurso, apellido y nombres del participante, 
--el t�tulo de la publicaci�n, la fecha de publicaci�n y el puntaje promedio obtenido por esa publicaci�n.

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
--ID de fotograf�a y realice la descalificaci�n de la misma. Tambi�n debe eliminar 
--todas las votaciones registradas a la fotograf�a en cuesti�n. S�lo se puede descalificar 
--una fotograf�a si pertenece a un concurso no finalizado.
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
--4) Al insertar una votaci�n, verificar que el usuario que vota no lo haga m�s de una vez 
--para el mismo concurso ni se pueda votar a s� mismo. Tampoco puede votar una fotograf�a descalificada.
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
	

