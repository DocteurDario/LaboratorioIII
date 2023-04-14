-- 1 ¿Cuáles son el/los paciente/s que se atendieron más veces?
Select P.IDPACIENTE,P.APELLIDO,P.NOMBRE,
		(Select count (*) From TURNOS T
where T.Idpaciente=P.IdPaciente) As Atenciones
From Pacientes P
Order by Atenciones desc

-- 2 ¿Cuántos pacientes distintos se atendieron en turnos que duraron más que la duración promedio?
Select count (dISTINCT pT.IDPACIENTE) From Pacientes Pt
	Inner Join Turnos T On Pt.IDPACIENTE=T.IDPACIENTE
Where T.DURACION >(Select avg (Duracion) From Pacientes P
		Inner join TURNOS T On P.IDPACIENTE=T.IDPACIENTE)
		 
-- 3 ¿Cuántas médicas cobran sus honorarios de consulta un costo mayor a $1000?	
Select * From MEDICOS
Where COSTO_CONSULTA >=1000 aND SEXO='f'

--4 ¿Cuál es el apellido del médico (sexo masculino) con más antigüedad de la clínica?
Select M.IDMEDICO, M.Apellido,M.NOMBRE, FECHAINGRESO, M.SEXO From MEDICOS M
	Where M.SEXO ='m'
Order by FECHAINGRESO asc

--5 ¿Cuál es el costo de la consulta promedio de cualquier especialista en "Oftalmología"?
Select Avg(COSTO_CONSULTA) From MEDICOS M
Inner Join ESPECIALIDADES E On M.IDESPECIALIDAD=E.IDESPECIALIDAD
Where E.NOMBRE='Oftalmología'

Select * From ESPECIALIDADES

--6  ¿Cuál es la cantidad de pacientes que no se atendieron en el año 2015?
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

--7 ¿Qué Obras Sociales cubren a pacientes que se hayan atendido en 
--algún turno con algún médico de especialidad 'Odontología'?

Select  O.IDOBRASOCIAL, o.NOMBRE, COBERTURA From OBRAS_SOCIALES O
	Inner Join PACIENTES P on O.IDOBRASOCIAL= P.IDOBRASOCIAL
	Inner Join TURNOS T On T.IDPACIENTE=P.IDPACIENTE
	Inner Join MEDICOS M On M.IDESPECIALIDAD=T.IDMEDICO
	Inner Join ESPECIALIDADES E on E.IDESPECIALIDAD=M.IDESPECIALIDAD
wHERE COBERTURA > 0 AND  E.NOMBRE='Odontología'

Where E.NOMBRE='Odontología' aND COBERTURA > 0



--8 ¿Cuántos turnos fueron atendidos por la doctora Flavia Rice?

Select count (*) As Cantidad From  Turnos T
	Inner JOin MEDICOS M On T.IDMEDICO = M.IDMEDICO
	Where M.APELLIDO='Rice' and M.NOMBRE='Flavia'

Select * From Medicos
Where APELLIDO='Rice' and NOMBRE='Flavia'

-- 9 ¿Cuántos médicos tienen la especialidad "Gastroenterología" ó "Pediatría"?
Select count (*) From MEDICOS M 
	Inner join ESPECIALIDADES E On M.IDESPECIALIDAD=E.IDESPECIALIDAD
	Where E.NOMBRE = 'Gastroenterología' or E.NOMBRE='Pediatría'

--10 ¿Cuánto tuvo que pagar la consulta el paciente con el turno nro 146?

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
