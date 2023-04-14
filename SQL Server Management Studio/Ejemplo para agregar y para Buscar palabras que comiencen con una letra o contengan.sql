--insert into dbo.Areas (ID, Nombre, Presupuesto, EMail) values (5, 'RRHH',500, 'ramon')

select * from Areas where Nombre like '%v%'   --Comience 
select * from Areas where Nombre like 'v%'    --contenga
select * from Areas where Nombre like '%v'    --Finalice 
--Revisar bien para ver si funcianan de esta manera