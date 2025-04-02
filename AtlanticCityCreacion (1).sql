use Atlantic_City;
create table Usuario_Sistema(
	ID_Usuario int primary key,
	Nombre Varchar(100) not null, 
	Rol Varchar(50) not null,
	Correo varchar(150) not null, 
	Contraseña Varchar (50) not null
); 
CREATE TABLE Clientes(
	ID_Cliente int primary key auto_increment,
	Nombre Varchar(100) not null, 
	Correo Varchar(100) not null,
	Telefono Varchar(9) not null, 
	DNI int unique not null,
	Saldo decimal(10,2) default 0.00,
	ID_Usuario int, 

	foreign key (ID_Usuario) references Usuario_Sistema(ID_Usuario)
);

Create table Juegos(
	ID_Juego int primary key auto_increment,
	Nombre Varchar(100) Not null,
	Tipo Varchar(50) not null,
	descripcion Varchar (500),
	Apuesta_min decimal(10,2) not null check(Apuesta_min >=0),
	Apuesta_max Decimal(10,2) not null check(Apuesta_max > 1.00)
);
Create table Promociones(
	ID_Promocion INT primary key auto_increment,
	ID_Juego int not null,
	Nombre varchar(100) not null, 
	Descripción Varchar(500),
	Descuento decimal(5,2) check (Descuento between 0 and 100),
	Fecha_Inicio Datetime not null,
	Fecha_Fin datetime not null,
	Foreign key (ID_Juego) references Juegos(ID_Juego) on delete cascade

);
Create table Cliente_Promocion (
	ID_Cliente int not null,
	ID_Promocion int not null,
	Asignacion Datetime,
	Fecha_Uso datetime,

	Primary key (ID_Cliente, ID_Promocion),
	foreign key (ID_Cliente) references Clientes(ID_Cliente) on delete cascade,
	foreign key (ID_Promocion) references Promociones(ID_Promocion)on delete cascade 
);
Create table Premios (
	ID_Premio int primary key auto_increment,
	ID_Cliente int not null,
	Fecha_hora Datetime,
	Monto decimal(10,2) not null check (Monto>0),

	Foreign key (ID_Cliente) references Clientes(ID_Cliente) on delete cascade
);
Create table Transacciones(
	ID_Transaccion int primary key auto_increment,
	ID_Cliente int not null,
	Fecha_Hora datetime,
	Monto Decimal(10,2) not null Check (Monto>0),
	Tipo Varchar(50) not null,

	foreign key (ID_Cliente) references Clientes(ID_Cliente) on delete cascade
);
create table Visitas (
	ID_Visita int primary key auto_increment,
	ID_Usuario int not null,
	ID_Cliente int not null,
	Fecha_Entrada datetime, 
	Fecha_salida datetime, 

	foreign key (ID_Usuario) references Usuario_Sistema(ID_Usuario) on delete cascade,
	foreign key (ID_Cliente) references Clientes(ID_Cliente) on delete cascade
);
create table Quejas (
	ID_Queja int primary key auto_increment,
	ID_Cliente int not null,
	Descripción varchar(500) not null,
	Fecha_Queja  datetime,
	Estado Varchar (50),
	ID_Usuario int,  
	
	foreign key (ID_Cliente) references Clientes(ID_CLiente) on delete cascade,
	foreign key (ID_Usuario) references Usuario_Sistema(ID_Usuario) on delete set null
);
create table Registro_Actividades(
	ID_Registro Int primary key auto_increment,
	Fecha datetime,
	ID_Visita int,
	ID_Promocion int,
	ID_Queja int,
	ID_Cliente int not null,
	ID_Juego int,
	ID_Usuario int not null,
	Tipo Varchar(100),

	foreign key (ID_Visita) references Visitas(ID_Visita) on delete set null,
	foreign key (ID_Promocion) references Promociones(ID_Promocion) on delete set null,
	foreign key (ID_Queja) references Quejas(ID_Queja) on delete set null,
	foreign key (ID_Cliente) references Clientes(ID_Cliente) on delete cascade,
	foreign key (ID_Juego) references Juegos(ID_Juego) on delete set null,
	foreign key (ID_Usuario) references Usuario_Sistema(ID_Usuario) on delete cascade
)
