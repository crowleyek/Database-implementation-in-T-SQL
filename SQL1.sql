USE master;

DROP DATABASE IF EXISTS ebilet;
GO
CREATE DATABASE ebilet;
GO
USE ebilet;
GO

DROP TABLE IF EXISTS Bilety;
DROP TABLE IF EXISTS Sklad;
DROP TABLE IF EXISTS Wystepy;
DROP TABLE IF EXISTS Sprzedaz;
DROP TABLE IF EXISTS Harmonogram;
DROP TABLE IF EXISTS Imprezy;
DROP TABLE IF EXISTS Obiekty;
DROP TABLE IF EXISTS Zamowienia;
DROP TABLE IF EXISTS Zespoly;
DROP TABLE IF EXISTS Sprzedaz;

GO
------------ CREATE - UTWÓRZ TABELE I POWI¥ZANIA ------------



CREATE TABLE Obiekty
(
  nazwa_obiektu       VARCHAR(40) PRIMARY KEY,
  liczba_miejsc       INT
)


CREATE TABLE Imprezy
(
  nazwa_imprezy       VARCHAR(50) PRIMARY KEY,
  miasto              VARCHAR(30) NOT NULL,
  dostepnosc	      INT,
  data_rozpoczecia    DATE,
  data_zakonczenia    DATE,
  statusk             VARCHAR(20) CHECK (statusk IN ('wyprzedane', 'dostêpne')),
  typ                 VARCHAR(20) CHECK(typ IN( 'muzyka', 'sport', 'wystawa', 'teatr', 'taniec')),
  czas_trwania        FLOAT,
  obiekt              VARCHAR(40) REFERENCES Obiekty(nazwa_obiektu),
 

);


CREATE TABLE Harmonogram
(
  id_harmonogramu     CHAR(2)  PRIMARY KEY,
  wydarzenie          VARCHAR(50),
  godzina             TIME,
  impreza             VARCHAR(50) REFERENCES Imprezy(nazwa_imprezy)
);


 CREATE TABLE Zamowienia
(
  numer_zamowienia    CHAR(10) PRIMARY KEY,
  data_sprzedania     DATE,
  nazwisko_kupujacego VARCHAR(30)  CHECK (nazwisko_kupujacego LIKE '[A-Z]%'),
  imie_kupujacego     VARCHAR(30)  CHECK (imie_kupujacego LIKE '[A-Z]%'),
);


CREATE TABLE Bilety
(
  id_biletu           INT PRIMARY KEY,
  cena                FLOAT,
  miejsce             INT,
  kategoria           CHAR(10),
  zamowienie          CHAR(10) REFERENCES Zamowienia(numer_zamowienia),
  impreza             VARCHAR(50) REFERENCES Imprezy(nazwa_imprezy)
);


CREATE TABLE Zespoly
(
  nazwa_zespolu       VARCHAR(55)  PRIMARY KEY,
  kraj_pochodzenia    VARCHAR(20) DEFAULT 'Polska'
);


CREATE TABLE Sklad
(
  imie                VARCHAR(30)  CHECK (imie LIKE '[A-Z]%'),
  nazwisko            VARCHAR(30)  CHECK (nazwisko LIKE '[A-Z]%'),
  zespol              VARCHAR(55) REFERENCES Zespoly(nazwa_zespolu)
);


CREATE TABLE Wystepy
(
  zespol              VARCHAR(55) REFERENCES Zespoly(nazwa_zespolu),
  impreza             VARCHAR(50) REFERENCES Imprezy(nazwa_imprezy),
  PRIMARY KEY (zespol, impreza)
);

CREATE TABLE Sprzedaz
(
  zamowienie           CHAR(10) REFERENCES Zamowienia(numer_zamowienia),
  impreza              VARCHAR(50) REFERENCES Imprezy(nazwa_imprezy),
  PRIMARY KEY (zamowienie, impreza)

);

GO

------------ INSERT - WSTAW DANE ------------


INSERT INTO Obiekty VALUES
('Filharmonia Warmiñsko-Mazurska'  ,2500 ),
('Spodek'                          ,11500),
('ERGO Arena'                      ,15000 ),
('ATLAS Arena'                     ,13806),
('Hala Torwar'                     ,4824 ),
('PGE Narodowy'                    ,72900 ),
('Stegu Arena'                     ,3500  ),
('Hala Stulecia'                   ,10000 ),
('Teatr Syrena'                    ,1500  ),
('Tauron Arena'                    ,20400 ),
('Galeria Metropolia'              ,NULL  );


INSERT INTO Imprezy VALUES
('Siatkówka mê¿czyzn: Polska-Holandia'  , 'Opole'          ,210  ,'2019-07-27', '2019-07-27', 'dostêpne'    , 'sport'  , 3.0   , 'Stegu Arena'),
('Flume koncert'                        , 'Warszawa'       ,0  ,'2019-10-28', '2019-10-28',   'wyprzedane'  , 'muzyka' , 3.0   , 'Hala Torwar'),
('Space Adventure'                      , 'Wroc³aw'        ,NULL  ,'2019-03-21', '2019-06-18', 'dostêpne'    , 'wystawa', NULL  , 'Hala Stulecia'),
('Rodzina Addamsów'                     , 'Warszawa'       ,534 ,'2019-05-16', '2019-06-30',   'dostêpne'    , 'teatr'  , 2.5   , 'Teatr Syrena'),
('Koncert Muzyki Filmowej'              , 'Kraków'         ,0 ,'2020-03-21', '2019-03-21',     'wyprzedane'  , 'muzyka' , 4.0   , 'Tauron Arena'),
('Body Worlds'                          , 'Gdañsk'         ,NULL  ,'2019-03-12', '2019-06-26', 'dostêpne'    , 'wystawa', NULL  ,'Galeria Metropolia'),
('Metallica Symfonicznie'               , 'Olsztyn'        ,134  ,'2020-01-25', '2020-01-25', 'dostêpne'    , 'muzyka' , 2.0   , 'Filharmonia Warmiñsko-Mazurska');


INSERT INTO Harmonogram VALUES
('1A', 'rozpoczêcie meczu'         ,'17:00:00', 'Siatkówka mê¿czyzn: Polska-Holandia' ),
('1B', 'przerwa'                   ,'18:30:00', 'Siatkówka mê¿czyzn: Polska-Holandia'),
('1C', 'przewidywany koniec meczu' ,'20:00:00', 'Siatkówka mê¿czyzn: Polska-Holandia'),
('2A', 'rozpoczêcie koncertu'      ,'20:00:00', 'Flume koncert'),
('2B', 'koniec koncertu'           ,'23:00:00', 'Flume koncert'),
('3A',  NULL                       , NULL     , 'Space Adventure'),
('4A', 'rozpoczêcie spektaklu'     ,'17:00:00', 'Rodzina Addamsów'),
('4B', 'przerwa'                   ,'18:30:00', 'Rodzina Addamsów'),
('4C', 'zakoñczenie spektaklu'     ,'19:30:00', 'Rodzina Addamsów'),
('5A','rozpoczêcie koncertu'      ,'20:00:00', 'Koncert Muzyki Filmowej'),
('5B','wystêp gwiazdy wieczoru'   ,'22:00:00', 'Koncert Muzyki Filmowej'),
('5C','zakonczenie koncertu'      ,'00:00:00', 'Koncert Muzyki Filmowej'),
('6A', NULL                       ,NULL      , 'Body Worlds'),
('7A','rozpoczêcie koncertu'      ,'20:00:00', 'Metallica Symfonicznie'),
('7B','zakonczenie koncertu'      ,'22:00:00', 'Metallica Symfonicznie');

INSERT INTO Zamowienia VALUES
('10AFG' , '2018-07-10', 'Wróblewska', 'Monika'  ),
('HYU20' , '2019-06-23', 'Sikorski'  , 'Bogdan'   ),
('GHY78' , '2018-12-01', 'Czajka'    , 'Sylwia'    ),
('YY678' , '2019-05-08', 'Kawka'     , 'Aleksandra'),
('H789G' , '2018-12-29', 'Kruk'      , 'Pawe³'     ),
('97YUI' , '2019-05-04', 'Sikora'    , 'El¿bieta' ),
('GTY76' , '2018-02-03', 'Bocian'    , 'Izabela'  ),
('09KLO' , '2019-05-09', 'Czapla'    , 'Krzysztof' ),
('HH543' , '2019-06-01', 'Dudek'     , 'Stanis³aw' ),
('0996H' , '2018-09-30', 'Bielik'    , 'Zuzanna'   );

INSERT INTO Bilety VALUES
(168589, 250.00, 23  , 'VIP'       , '10AFG' , 'Flume koncert'),
(107689, 250.00, 24  , 'VIP'       , '10AFG' , 'Flume koncert'),
(117800, 150.00, 10  , 'Balkon'    , '0996H' , 'Rodzina Addamsów'),
(567771, 200.00, 2   , 'A'         , 'H789G' , 'Metallica Symfonicznie'),
(900001, 25.00 , NULL,  NULL       , 'HH543' , 'Space Adventure'),
(746394, 25.00 , NULL,  NULL       , 'HH543' , 'Body Worlds'),
(807801, 50.00 , 13  , 'Trybuny G' , '09KLO' , 'Siatkówka mê¿czyzn: Polska-Holandia'),
(674785, 300.00, 98  , 'Balkon'    , 'YY678' , 'Koncert Muzyki Filmowej' ),
(674775, 300.00, 99  , 'Balkon'    , 'YY678' , 'Koncert Muzyki Filmowej' ),
(677785, 300.00, 97  , 'Balkon'    , 'YY678' , 'Koncert Muzyki Filmowej' ),
(749333, 50.00 , NULL,  NULL       , 'HYU20' , 'Body Worlds'),
(037583, 25.00 , 22  ,  'Trybuny A', 'GHY78' , 'Siatkówka mê¿czyzn: Polska-Holandia'),
(883365, 25.00 , NULL,  NULL       , '97YUI' , 'Body Worlds'),
(028432, 120.00, 21  , 'Scena A'   , 'GTY76' , 'Rodzina Addamsów'),
(453465, 25.00 , NULL,  NULL       ,  NULL   , 'Body Worlds'),
(128301, 25.00 , NULL,  NULL       ,  NULL , 'Space Adventure'),
(067771, 170.00, 18   , 'B'        ,  NULL , 'Metallica Symfonicznie');

INSERT INTO Zespoly VALUES
('Flume'                                     ,'Australia'),
('Scream Inc'                                ,'Ukraina'),
('Syrena'                                    ,'Polska'),
('Hans Zimmer Tribute Orchestra'             ,'Polska'),
('Reprezentacja Polski Mê¿czyzn w Siatkówce' ,'Polska'),
('NASA'                                      ,'USA'),
('Gunther von Hagens'                        ,'Niemcy');


INSERT INTO Sklad VALUES
('Harley Edward', 'Streten'      ,'Flume'),
('Taras'        , 'Karpenko'     ,'Scream Inc'),
('Mike'         , 'Rubanov'      ,'Scream Inc'),
('Max'          , 'Rozkrut'      ,'Scream Inc'),
('Andrew'       , 'Liutyi'       ,'Scream Inc'),
('Anna'         , 'Terpi³owska'  ,'Syrena'),
('Tomasz'       , 'Steciuk'      ,'Syrena'),
('Agnieszka'    , 'Tylutki'      ,'Syrena'),
('Jakub'        , 'Strach'       ,'Syrena'),
('Damian'       , 'Aleksander'   ,'Syrena'),
('Anna'         , 'Lasota'       ,'Hans Zimmer Tribute Orchestra'),
('Jasin'        , 'Rammal-Ryka³a','Hans Zimmer Tribute Orchestra'),
('Maciej'       , 'Sztor'        ,'Hans Zimmer Tribute Orchestra'),
('Magda'        , 'Jackowska'    ,'Hans Zimmer Tribute Orchestra'),
('Bartosz'      , 'Bednorz'      ,'Reprezentacja Polski Mê¿czyzn w Siatkówce'),
('Mateusz'      , 'Bieniek'      ,'Reprezentacja Polski Mê¿czyzn w Siatkówce'),
('Bar³omiej'    , 'Bo³¹dŸ'       ,'Reprezentacja Polski Mê¿czyzn w Siatkówce'),
('Fabuan'       , 'Drzyzga'      ,'Reprezentacja Polski Mê¿czyzn w Siatkówce'),
('Bartosz'      , 'Filipiak'     ,'Reprezentacja Polski Mê¿czyzn w Siatkówce'),
('Jan'          , 'Firlej'       ,'Reprezentacja Polski Mê¿czyzn w Siatkówce'),
(NULL           , NULL           ,'NASA'),
('Gunther'      ,'Von Hagens'    ,'Gunther von Hagens')

INSERT INTO Wystepy VALUES
('Flume'                                     , 'Flume koncert' ),
('Hans Zimmer Tribute Orchestra'             , 'Koncert Muzyki Filmowej'),
('Scream Inc'                                , 'Metallica Symfonicznie'),
('Syrena'                                    , 'Rodzina Addamsów') ,
('Reprezentacja Polski Mê¿czyzn w Siatkówce' , 'Siatkówka mê¿czyzn: Polska-Holandia'),
('NASA'                                      , 'Space Adventure'),
('Gunther von Hagens'                        , 'Body Worlds');

INSERT INTO Sprzedaz VALUES
('10AFG', 'Flume koncert'),
('0996H', 'Rodzina Addamsów'),
('H789G', 'Metallica symfonicznie'),
('HH543', 'Space Adventure'),
('HH543', 'Body Worlds'),
('09KLO', 'Siatkówka mê¿czyzn: Polska-Holandia'),
('YY678', 'Koncert Muzyki Filmowej'),
('HYU20' , 'Body Worlds'),
('GHY78' , 'Siatkówka mê¿czyzn: Polska-Holandia'),
('97YUI' , 'Body Worlds'),
('GTY76' , 'Rodzina Addamsów');

SELECT* FROM Obiekty
SELECT* FROM Imprezy
SELECT* FROM Harmonogram
SELECT* FROM Zamowienia
SELECT* FROM Bilety
SELECT* FROM Zespoly
SELECT* FROM Sklad
SELECT* FROM Wystepy
SELECT* FROM Sprzedaz


----WIDOK----
/* liczba biletów kupionych na jednym zamówieniu */
DROP VIEW IF EXISTS IloscBiletow;
GO
CREATE VIEW IloscBiletow (liczba_zamowien, numer_zamowienia, nazwisko_kupujacego)
AS
( SELECT count(zamowienie), B.zamowienie, Z.nazwisko_kupujacego
  FROM Bilety B JOIN Zamowienie Z ON B.zamowienie = Z.numer_zamowienia
  GROUP BY B.zamowienie, Z.nazwisko_kupujacego

  );
  GO
 SELECT*FROM IloscBiletow

 /*srednia ilosc biletow na jednym zamowieniu*/
 DROP VIEW IF EXISTS SredniaIloscBiletow;
 GO

 CREATE VIEW SredniaIloscBiletow(srednia)
 AS
 (	SELECT avg(liczba_zamowien) 
	FROM IloscBiletow
 );
 GO
 SELECT*FROM SredniaIloscBiletow

----PROCEDURY----


/*funkcjonalnosc kup bilet*/

DROP PROCEDURE IF EXISTS SprzedajBilet
GO

CREATE PROCEDURE SprzedajBilet
	@impreza VARCHAR(50),
	@nazwisko VARCHAR(30),
	@imie VARCHAR(30),
	@zamowienie CHAR(10),
	@id_biletu INT,
	@data DATE
AS
BEGIN
	
	IF EXISTS(select I.nazwa_imprezy from Imprezy I JOIN Bilety B ON I.nazwa_imprezy = B.impreza
    WHERE I.nazwa_imprezy = @impreza and B.zamowienie is null and (I.dostepnosc!=0 or I.dostepnosc is null ))
		BEGIN
	UPDATE  Bilety SET zamowienie = @zamowienie where id_biletu = @id_biletu;
	INSERT INTO Zamowienia
	(numer_zamowienia, data_sprzedania, nazwisko_kupujacego, imie_kupujacego)
	VALUES( @zamowienie, @data, @nazwisko, @imie)
		END;
	ELSE PRINT('Brak imprezy w bazie')
		END;

	GO

/*procedura pokazuj¹ca liczbê obiektów w danym mieœcie - raportuj¹ca*/

DROP PROCEDURE IF EXISTS PokazObiekt;
GO

CREATE PROCEDURE PokazObiekt
	@nazwa_miasta  VARCHAR(30)
AS
BEGIN
	DECLARE @liczbaobiektow INT;
	SELECT @liczbaobiektow = COUNT(obiekt)
	FROM Imprezy
	WHERE miasto = @nazwa_miasta;
	PRINT 'Liczba obiektów w mieœcie ' +  @nazwa_miasta + ' wynosi: ';
	PRINT @liczbaobiektow;
END;
GO


/*EXECUTE PokazObiekt 'Warszawa'*/

/*funkcjonalnosc dodaj zamówienie*/

DROP PROCEDURE IF EXISTS DodajZamowienie;
GO

CREATE PROCEDURE DodajZamowienie
    @numer	  CHAR(10),
    @data     DATE,
    @nazwisko VARCHAR(30),
    @imie     VARCHAR(30)
AS
BEGIN
    IF NOT EXISTS(select numer_zamowienia= @numer from Zamowienia)
	BEGIN
    INSERT INTO Zamowienia
        (numer_zamowienia, data_sprzedania, nazwisko_kupujacego, imie_kupujacego)
    VALUES
        (@numer, @data, @nazwisko, @imie);
	END;
	ELSE PRINT ('Numer zamówienia istenieje ju¿ w bazie');
END;
GO
/*SELECT * FROM Zamowienia;
EXECUTE DodajZamowienie '10AFG', '2019-06-05', 'Gil', 'Joanna'
SELECT * FROM Zamowienia;
DELETE FROM Zamowienia where nazwisko_kupujacego = 'Gil'
*/

/*funckjonalnosc podwy¿szaj¹ca cenê biletu o dan¹ kwotê @cena*/

DROP PROCEDURE IF EXISTS ZmienCene;
GO

CREATE PROCEDURE ZmienCene
	@cena	FLOAT,
	@impreza VARCHAR(50),
	@kategoria CHAR(10)
AS
BEGIN

	UPDATE Bilety 
    SET    cena = @cena + cena
    WHERE  impreza = @impreza and kategoria = @kategoria;

END;
GO
 /*EXECUTE ZmienCene 400.00, 'Flume koncert', 'VIP'*/

 ----FUNKCJE----

 --funkcja tablicowa--

DROP FUNCTION IF EXISTS DataSprzedazy;
GO

CREATE FUNCTION DataSprzedazy
(
    @impreza VARCHAR(50)
)
    RETURNS TABLE
AS

	RETURN 
    (SELECT distinct Zamowienia.data_sprzedania
	FROM Bilety JOIN Zamowienia ON Bilety.zamowienie=Zamowienia.numer_zamowienia
	WHERE Bilety.impreza = @impreza );

GO

/*SELECT*from dbo.DataSprzedazy('Flume koncert');
GO*/

DROP FUNCTION IF EXISTS KazdyTypImprezy
GO

CREATE FUNCTION KazdyTypImprezy
(
    @typ VARCHAR(10)
)
    RETURNS TABLE
AS

	RETURN (SELECT   Count(zamowienie) 'ile imprez', I.nazwa_imprezy from Imprezy I JOIN Bilety B ON I.nazwa_imprezy = B.impreza
			WHERE I.typ=@typ group by I.nazwa_imprezy  )

GO
/*select* from dbo.KazdyTypImprezy('muzyka')*/


--funkcja skalarna--
/* funkcja sprawdza dane klienta danego zamówienia*/
DROP FUNCTION IF EXISTS SprawdzZamowienie
GO

CREATE FUNCTION SprawdzZamowienie 
(
    @zamowienie CHAR(10)
)
    RETURNS VARCHAR(30)
AS
BEGIN
	RETURN (SELECT nazwisko_kupujacego
	FROM Zamowienia
	WHERE numer_zamowienia = @zamowienie);
END;
GO

/*SELECT dbo.SprawdzZamowienie ('09KLO');*/

 ----WYZWALACZE----


DROP TRIGGER IF EXISTS tr_informacja;
GO

CREATE TRIGGER tr_informacja
ON Zamowienia
AFTER INSERT, UPDATE
AS
    PRINT 'U¿ytkownik ' + USER_NAME() + ' zmieni³ wiersze';
GO

/*UPDATE Zamowienia
   SET nazwisko_kupujacego = 'Wrona'
WHERE  numer_zamowienia = '0996H'*/


--regu³a: nie mo¿na kupic na raz wiêcej ni¿  10 biletow--
DROP TRIGGER IF EXISTS tr_sprawdz_ilosc;
GO

CREATE TRIGGER tr_sprawdz_ilosc
ON Zamowienia
AFTER INSERT
AS
   IF EXISTS (select count(zamowienie), zamowienie from Bilety  group by zamowienie having count(zamowienie)<9)
		PRINT('Mozna dodac kolejny bilet');
   ELSE
	    PRINT 'Maksymalna iloœæ biletów w jednym zamówieniu wynosi 10';
GO

