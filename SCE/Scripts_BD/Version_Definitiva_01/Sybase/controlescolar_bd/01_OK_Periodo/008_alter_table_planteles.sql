use controlescolar_bd
go

alter table planteles 
     add multiple_periodo varchar(3) default 'N' null 
go


 
UPDATE planteles SET multiple_periodo = 'N'
go



