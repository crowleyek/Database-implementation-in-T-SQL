--WIDOKI--

/*Widok IloscBiletow- liczba biletów kupionych na jednym zamówieniu */

SELECT*FROM IloscBiletow

 /*Widok SredniaIloscBiletow - srednia ilosc biletow na jednym zamowieniu*/

SELECT*FROM SredniaIloscBiletow

--PROCEDURY--

/*funkcjonalnosc kup bilet*/

select*from bilety
select*from zamowienia
/*Kiedy nie mo¿na kupiæ biletu*/
EXECUTE SprzedajBilet 'Flume koncert', 'Jatsrz¹b', 'Aneta', 'K2921', 0249726, '2019-08-08';
/*Kiedy mo¿na kupiæ bile */
EXECUTE SprzedajBilet 'Metallica Symfonicznie', 'Sokó³', 'Anna', 'KGB55', 67771, '2019-08-08';
UPDATE Bilety SET zamowienie = NULL where id_biletu = 67771


/*procedura pokazuj¹ca liczbê obiektów w danym mieœcie - raportuj¹ca*/

EXECUTE PokazObiekt 'Warszawa'
EXECUTE PokazObiekt 'Poznañ'

/*funkcjonalnosc dodaj zamówienie*/
select*from zamowienia
EXECUTE DodajZamowienie 'YY88', '2019-06-05', 'Gilowska', 'Joanna' /* dodanie nowego wiersza*/

DELETE FROM ZAMowienia where nazwisko_kupujacego = 'Gilowska'
/*funckjonalnosc podwy¿szaj¹ca cenê biletu o dan¹ kwotê @cena*/

EXECUTE ZmienCene 50.00, 'Flume koncert', 'VIP' /*zmiana ceny*/
select* from bilety
UPDATE Bilety SET cena = 250.00 where impreza = 'Flume koncert'


--FUNKCJE--

/*pokazywanie ró¿nych daty kupna biletów na dany koncert*/

SELECT*from dbo.DataSprzedazy('Rodzina Addamsów')


/*pokazywanie ile jest imprez danego typu*/

SELECT* from dbo.KazdyTypImprezy('muzyka')
SELECT* from dbo.KazdyTypImprezy('western')

/* funkcja sprawdza dane klienta danego zamówienia*/

SELECT dbo.SprawdzZamowienie ('09KLO')

--WYZWALACZE--

/*komunikat o zmianach w tabeli 'Zamowienie'*/

UPDATE Zamowienia
 SET nazwisko_kupujacego = 'Myszolow'
WHERE  numer_zamowienia = '0996H'

select*from Zamowienia