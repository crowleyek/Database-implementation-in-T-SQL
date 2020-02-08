--WIDOKI--

/*Widok IloscBiletow- liczba bilet�w kupionych na jednym zam�wieniu */

SELECT*FROM IloscBiletow

 /*Widok SredniaIloscBiletow - srednia ilosc biletow na jednym zamowieniu*/

SELECT*FROM SredniaIloscBiletow

--PROCEDURY--

/*funkcjonalnosc kup bilet*/

select*from bilety
select*from zamowienia
/*Kiedy nie mo�na kupi� biletu*/
EXECUTE SprzedajBilet 'Flume koncert', 'Jatsrz�b', 'Aneta', 'K2921', 0249726, '2019-08-08';
/*Kiedy mo�na kupi� bile */
EXECUTE SprzedajBilet 'Metallica Symfonicznie', 'Sok�', 'Anna', 'KGB55', 67771, '2019-08-08';
UPDATE Bilety SET zamowienie = NULL where id_biletu = 67771


/*procedura pokazuj�ca liczb� obiekt�w w danym mie�cie - raportuj�ca*/

EXECUTE PokazObiekt 'Warszawa'
EXECUTE PokazObiekt 'Pozna�'

/*funkcjonalnosc dodaj zam�wienie*/
select*from zamowienia
EXECUTE DodajZamowienie 'YY88', '2019-06-05', 'Gilowska', 'Joanna' /* dodanie nowego wiersza*/

DELETE FROM ZAMowienia where nazwisko_kupujacego = 'Gilowska'
/*funckjonalnosc podwy�szaj�ca cen� biletu o dan� kwot� @cena*/

EXECUTE ZmienCene 50.00, 'Flume koncert', 'VIP' /*zmiana ceny*/
select* from bilety
UPDATE Bilety SET cena = 250.00 where impreza = 'Flume koncert'


--FUNKCJE--

/*pokazywanie r�nych daty kupna bilet�w na dany koncert*/

SELECT*from dbo.DataSprzedazy('Rodzina Addams�w')


/*pokazywanie ile jest imprez danego typu*/

SELECT* from dbo.KazdyTypImprezy('muzyka')
SELECT* from dbo.KazdyTypImprezy('western')

/* funkcja sprawdza dane klienta danego zam�wienia*/

SELECT dbo.SprawdzZamowienie ('09KLO')

--WYZWALACZE--

/*komunikat o zmianach w tabeli 'Zamowienie'*/

UPDATE Zamowienia
 SET nazwisko_kupujacego = 'Myszolow'
WHERE  numer_zamowienia = '0996H'

select*from Zamowienia