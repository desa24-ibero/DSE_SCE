use controlescolar_bd
go

alter table security_user_app 
     add periodo_default varchar(3) default 'S' null
go


UPDATE security_user_app SET periodo_default = 'S'
GO



