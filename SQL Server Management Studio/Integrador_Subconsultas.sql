-- 1 �Cu�les son el/los paciente/s que se atendieron m�s veces?
Select P.IDPACIENTE,P.APELLIDO,P.NOMBRE,
		(Select count (*) From TURNOS T
where T.Idpaciente=P.IdPaciente) As Atenciones
From Pacientes P
Order by Atenciones desc

-- 2 �Cu�ntos pacientes distintos se atendieron en turnos que duraron m�s que la duraci�n promedio?
Select count (dISTINCT pT.IDPACIENTE) From Pacientes Pt
	Inner Join Turnos T On Pt.IDPACIENTE=T.IDPACIENTE
Where T.DURACION >(Select avg (Duracion) From Pacientes P
		Inner join TURNOS T On P.IDPACIENTE=T.IDPACIENTE)
		 
-- 3 �Cu�ntas m�dicas cobran sus honorarios de consulta un costo mayor a $1000?	
Select * From MEDICOS
Where COSTO_CONSULTA >=1000 aND SEXO='f'

--4 �Cu�l es el apellido del m�dico (sexo masculino) con m�s antig�edad de la cl�nica?
Select M.IDMEDICO, M.Apellido,M.NOMBRE, FECHAINGRESO, M.SEXO From MEDICOS M
	Where M.SEXO ='m'
Order by FECHAINGRESO asc

--5 �Cu�l es el costo de la consulta promedio de cualquier especialista en "Oftalmolog�a"?
Select Avg(COSTO_CONSULTA) From MEDICOS M
Inner Join ESPECIALIDADES E On M.IDESPECIALIDAD=E.IDESPECIALIDAD
Where E.NOMBRE='Oftalmolog�a'

Select * From ESPECIALIDADES

--6  �Cu�l es la cantidad de pacientes que no se atendieron en el a�o 2015?
Select 
	count (distinct M.IDPACIENTE) As Cantidad 
FROM PACIENTES M
	Where M.IDPACIENTE not in (Select distinct M.IDPACIENTE As Cantidad FROM PACIENTES M
							Inner join TURNOS T on T.IDPACIENTE=M.IDPACIENTE
							Where year(T.FECHAHORA)=2015)  

Select distinct M.IDPACIENTE As Cantidad FROM PACIENTES M
Inner join TURNOS T on T.IDPACIENTE=M.IDPACIENTE
Where year(T.FECHAHORA)=2015


SELECT
count (DISTINCT p.IDPACIENTE) as 'Cantidad no se atendieron en 2015'
from pacientes p
WHERE P.IDPACIENTE not IN
(select
P.IDPACIENTE
FROM PACIENTES P
INNER JOIN TURNOS T ON T.IDPACIENTE=p.IDPACIENTE
where (year(t.FECHAHORA)=2015))

--7 �Qu� Obras Sociales cubren a pacientes que se hayan atendido en 
--alg�n turno con alg�n m�dico de especialidad 'Odontolog�a'?

Select  O.IDOBRASOCIAL, o.NOMBRE, COBERTURA From OBRAS_SOCIALES O
	Inner Join PACIENTES P on O.IDOBRASOCIAL= P.IDOBRASOCIAL
	Inner Join TURNOS T On T.IDPACIENTE=P.IDPACIENTE
	Inner Join MEDICOS M On M.IDESPECIALIDAD=T.IDMEDICO
	Inner Join ESPECIALIDADES E on E.IDESPECIALIDAD=M.IDESPECIALIDAD
wHERE COBERTURA > 0 AND  E.NOMBRE='Odontolog�a'

Where E.NOMBRE='Odontolog�a' aND COBERTURA > 0



--8 �Cu�ntos turnos fueron atendidos por la doctora Flavia Rice?

Select count (*) As Cantidad From  Turnos T
	Inner JOin MEDICOS M On T.IDMEDICO = M.IDMEDICO
	Where M.APELLIDO='Rice' and M.NOMBRE='Flavia'

Select * From Medicos
Where APELLIDO='Rice' and NOMBRE='Flavia'

-- 9 �Cu�ntos m�dicos tienen la especialidad "Gastroenterolog�a" � "Pediatr�a"?
Select count (*) From MEDICOS M 
	Inner join ESPECIALIDADES E On M.IDESPECIALIDAD=E.IDESPECIALIDAD
	Where E.NOMBRE = 'Gastroenterolog�a' or E.NOMBRE='Pediatr�a'

--10 �Cu�nto tuvo que pagar la consulta el paciente con el turno nro 146?

Select 
	COSTO_CONSULTA * (1-COBERTURA) as cOSTO
	From TURNOS T
Inner Join MEDICOS M On T.IDMEDICO=M.IDMEDICO
Inner Join Pacientes P On P.IDPACIENTE= T.IDPACIENTE
Inner Join OBRAS_SOCIALES O On O.IDOBRASOCIAL= P.IDOBRASOCIAL
Where T.IDTURNO=146
 /*
Select* From Pacientes P
Where P.IDPACIENTE=76
*/
Select* From OBRAS_SOCIALES P
