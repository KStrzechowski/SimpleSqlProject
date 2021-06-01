-- Tworzenie tabel

CREATE TABLE Leki
(
	LekID int Primary Key NOT NULL,
	NazwaHandlowa varchar(25) NOT NULL,
	SubstancjaCzynna varchar(50) NOT NULL,
);

CREATE TABLE Miejscowosc
(
	MiejscowoscID int Primary Key NOT NULL,
	Wojewodztwo varchar(25) NOT NULL,
	Miejscowosc varchar(25) NOT NULL
);

CREATE TABLE Pacjenci
(
	PacjentID int Primary Key NOT NULL,
	Imie varchar(25) NOT NULL,
	Nazwisko varchar(25) NOT NULL,
	MiejscowoscID int Foreign Key References Miejscowosc(MiejscowoscID) NOT NULL,
	AdresZamieszkania varchar(50) NOT NULL,
	NumerTelefonu int NOT NULL
);

CREATE TABLE PacjentLek
(
	PacjentID int Foreign Key References Pacjenci(PacjentID) NOT NULL,
	LekID int Foreign Key References Leki(LekID) NOT NULL,
	Primary Key (PacjentID, LekID)
);

CREATE TABLE Specjalnosc
(
	SpecjalnoscID int Primary Key NOT NULL,
	Nazwa varchar(50) NOT NULL
);

CREATE TABLE Lekarze
(
	LekarzID int Primary Key NOT NULL,
	Imie varchar(25) NOT NULL,
	Nazwisko varchar(25) NOT NULL,
	SpecjalnoscID int Foreign Key References Specjalnosc(SpecjalnoscID) NOT NULL,
	NumerPrawaWykonywaniaZawodu int NOT NULL
);

CREATE TABLE Szczepionki
(
	SzczepionkaID int Primary Key NOT NULL,
	NazwaSzczepionki varchar(50) NOT NULL
);

CREATE TABLE Szczepienia
(
	SzczepienieID int Primary Key NOT NULL,
	LekarzID int Foreign Key References Lekarze(LekarzID) NOT NULL,
	PacjentID int Foreign Key References Pacjenci(PacjentID) NULL,
	SzczepionkaID int Foreign Key References Szczepionki(SzczepionkaID) NOT NULL,
	DataSzczepienia datetime NOT NULL,
);

CREATE TABLE [Typ Odczynu]
(
	OdczynID int Primary Key NOT NULL,
	[Nazwa Odczynu] varchar(50) NOT NULL
);

CREATE TABLE Odczyny
(
	OdczynID int Foreign Key References [Typ Odczynu](OdczynID) NOT NULL,
	SzczepienieID int Foreign Key References Szczepienia(SzczepienieID) NOT NULL,
	OpisOdczynu text NULL,
	Zdjecie binary(1000) NULL
	Primary Key (OdczynID, SzczepienieID)
);

--Wpisywanie danych do tabel
Insert into Leki
	([LekID], [NazwaHandlowa], [SubstancjaCzynna])
	Values
		(1,'Gardlox', 'Diosmina'),
		(2,'Aspiryna', 'Paracetamol'),
		(3, 'Ibuprom', 'Ibuprofen'),
		(4, 'Ketanol', 'Nifuroksazyd'),
		(5, 'Starazolin', 'Metformina'),
		(6, 'SlowaMag', 'Diosmina'),
		(7, 'Recigar', 'Paracetamol'),
		(8, 'Cerutin', 'Ibuprofen'),
		(9, 'Nurofen', 'Ibuprofen'),
		(10, 'Essentiale', 'Diosmina');

Insert into Miejscowosc
	([MiejscowoscID], [Wojewodztwo], [Miejscowosc])
	Values
		(1, 'Lodzkie', 'Tomaszow Mazowiecki'),
		(2, 'Lodzkie', 'Piotrkow Trybunalski'),
		(3, 'Lodzkie', 'Lodz'),
		(4, 'Mazowieckie', 'Warszawa'),
		(5, 'Pomorskie', 'Gdynia'),
		(6, 'Pomorskie', 'Gdansk'),
		(7, 'Pomorskie', 'Sopot'),
		(8, 'Slaskie', 'Katowice'),
		(9, 'Opolskie', 'Opole'),
		(10, 'Malopolskie', 'Krakow');

Insert into Pacjenci
	([PacjentID], [imie], [nazwisko], [MiejscowoscID], [AdresZamieszkania], [NumerTelefonu])
	Values
		(1, 'Adam', 'Ma≥ysz', 3, 'Dzieci Polskich 15', 605923100),
		(2, 'Karol', 'Wochtman', 1, 'Grota Roweckiego 12/2', 933998997),
		(3, 'Robert', 'Lewandowski', 4, 'Aleje Jerozolimskie 15', 600800534),
		(4, 'Arkadiusz', 'Milik', 4, 'Chopina 107/2', 654976823),
		(5, 'Piotr', 'Zielinski', 5, 'Bosmanska 97', 605605605),
		(6, 'Jan', 'Pewniak', 3, 'Warszawska 17', 907908609),
		(7, 'Karol', 'Kostrzewa', 1, 'Grota Roweckiego 22/1', 987654321),
		(8, 'Robert', 'Radowslaw', 4, 'Aleje Jerozolimskie 137/23', 123456789),
		(9, 'Zdzislawa', 'Rydz', 4, 'Bora Komorowskiego 76/12', 347263734),
		(10, 'Anna', 'Rak', 2, 'Jana Pawla 23', 678876907),
		(11, 'Michal', 'Aryz', 4, 'Olejarza 15', 609604653),
		(12, 'Kinga', 'Tur', 4, 'Rakowa 4', 888465954),
		(13, 'Adam', 'Bednarek', 4, 'Stylowa 22/2', 607324018),
		(14, 'Stefan', 'Bednarek', 4, 'Stylowa 22/2', 608524123),
		(15, 'Kuba', 'Szadkowski', 4, 'Raclawicka 83/70', 823805678),
		(16, 'Jerzy', 'Mol', 4, 'Gorska 31/4', 607609581);


Insert into PacjentLek
	([PacjentID], [LekID])
	Values
		(1, 1),
		(2, 2),
		(3, 3),
		(3, 5),
		(3, 4),
		(3, 2),
		(3, 1),
		(2, 1),
		(5, 3),
		(5, 5),
		(2, 3),
		(12, 8),
		(11, 7);

Insert into Specjalnosc
	([SpecjalnoscID], [Nazwa])
	Values
		(1, 'Neurolog'),
		(2, 'Chirurg'),
		(3, 'Kardiolog'),
		(4, 'Geriatra'),
		(5, 'Ortopeda');


Insert into Lekarze
	([LekarzID], [imie], [Nazwisko], [SpecjalnoscID], [NumerPrawaWykonywaniaZawodu])
	Values
		(1, 'Pawe≥', 'Goüdzik', 1, 146132),
		(2, 'Ania', 'Bπk', 2, 825423),
		(3, 'Jan', 'Rydz', 3, 146132),
		(4, 'Karol', 'Kies', 5, 825423),
		(5, 'Ela', 'Goüdzik', 1, 146132),
		(6, 'Ania', 'Maj', 4, 825423);

Insert into Szczepionki
	([SzczepionkaID], [NazwaSzczepionki])
	Values
		(1, 'Astra Zeneca'),
		(2, 'Pfitzer'),
		(3, 'Johnson'),
		(4, 'Moderna'),
		(5, 'Kass');

Insert into Szczepienia
	([SzczepienieID], [PacjentID], [LekarzID], [SzczepionkaID], [DataSzczepienia])
	Values
	(1, 1, 1, 1, '2020-05-14 12:00:00'),
	(2, 5, 1, 1, '2020-05-15 12:00:00'),
	(3, 2, 1, 3, '2020-05-16 12:00:00'),
	(4, 5, 2, 1, '2021-10-16 15:15:00'),
	(5, 3, 2, 2, '2021-10-16 15:45:00'),
	(11, 6, 1, 1, '2020-05-14 12:30:00'),
	(12, 7, 1, 1, '2020-05-15 12:30:00'),
	(13, 8, 1, 1, '2020-05-16 12:30:00'),
	(14, 9, 2, 3, '2021-10-16 17:15:00'),
	(15, 10, 4, 2, '2021-10-16 17:45:00'),
	(16, 11, 5, 2, '2020-02-01 10:00:00'),
	(17, 11, 5, 2, '2020-08-01 10:00:00'),
	(18, 11, 4, 2, '2021-03-04 15:00:00'),
	(19, 12, 2, 1, '2020-02-08 10:00:00'),
	(20, 12, 3, 1, '2021-01-03 10:30:00'),
	(21, 13, 1, 2, '2020-04-02 12:00:00'),
	(22, 13, 1, 2, '2021-05-20 12:00:00'),
	(23, 14, 2, 2, '2020-10-05 11:00:00'),
	(24, 14, 3, 2, '2021-05-28 12:15:00'),
	(25, 15, 2, 2, '2020-10-05 17:00:00'),
	(26, 15, 2, 2, '2021-07-30 12:00:00'),
	(27, 16, 1, 2, '2020-11-30 10:30:00'),
	(28, 16, 2, 2, '2021-01-15 11:15:00'),
	(29, 16, 2, 2, '2021-06-19 13:00:00');

-- Bez zapisanego pacjenta
Insert into Szczepienia
	([SzczepienieID], [LekarzID], [SzczepionkaID], [DataSzczepienia])
	Values
	(6, 3, 1, '2020-05-14 12:15:00'),
	(7, 2, 1, '2021-10-16 16:15:00'),
	(8, 3, 2, '2021-10-16 16:45:00'),
	(9, 4, 3, '2021-8-15 15:15:00'),
	(10, 4, 4, '2021-8-15 15:45:00'),
	(30, 2, 2, '2020-05-15 12:00:00'),
	(31, 2, 2, '2021-06-08 13:10:00'),
	(32, 1, 2, '2021-06-08 13:10:00'),
	(33, 1, 2, '2021-06-30 13:10:00'),
	(34, 1, 2, '2021-06-15 12:15:00'),
	(35, 3, 2, '2021-06-02 15:10:00'),
	(36, 3, 2, '2021-06-18 13:45:00');


Insert into [Typ Odczynu]
	([OdczynID], [Nazwa Odczynu])
	Values
	(1, 'Kaszel'),
	(2, 'Goraczka'),
	(3, 'Bol glowy'),
	(4, 'Oslabienie'),
	(5, 'Dreszcze'),
	(6, 'Wysypka'),
	(7, 'Wymioty'),
	(8, 'Utrata smaku'),
	(9, 'Utrata wechu');

Insert into Odczyny
	([OdczynID], [SzczepienieID], [OpisOdczynu])
	Values
	(2, 1, 'Bardzo Wysoka goraczka 40 stopni'),
	(4, 5, 'Dreszcze, szczegolnie w nocy'),
	(2, 11, 'Bardzo Wysoka goraczka 40 stopni'),
	(6, 2, 'Wysypka na twarzy i rekach'),
	(4, 2, 'Pacjent nie ma sily nawet na krotkie spacery');
	
Insert into .Odczyny
	([OdczynID], [SzczepienieID])
	Values
	(1, 1),
	(2, 3),
	(6, 16),
	(7, 17),
	(8, 18),
	(9, 19),
	(2, 20),
	(2, 21),
	(4, 23),
	(6, 25),
	(8, 25),
	(1, 27);

-- Dodawanie kolumny z cenπ
ALTER TABLE Task2.dbo.Szczepionki
ADD Cena money