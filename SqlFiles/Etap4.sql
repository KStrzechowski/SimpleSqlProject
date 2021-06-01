-- 1
-- Wypisa�em tylko szczepienia, na kt�re jest zapisana osoba. Je�li chcemy wypisa� te� te bez zapisanych os�b wystarczy zmieni� pierwsz� komend� join na left join.
Select s.SzczepienieID, s.PacjentID, p.Imie, p.Nazwisko, count(pl.PacjentID) as [Ilosc lekow]
from Szczepienia s 
	join Pacjenci p on s.PacjentID = p.PacjentID
	left join PacjentLek pl on pl.PacjentID = p.PacjentID
group by s.SzczepienieID, s.PacjentID, p.Imie, p.Nazwisko
order by 5 desc

-- 2
-- Przy za�o�eniu, �e lekarz zaszczepi osob� nawet gdy nikt nie wpisa� si� jeszcze na szczepienie.
Select l.LekarzID, l.Imie, l.Nazwisko, count(s.LekarzID) as [Liczba szczepien]
from Lekarze l
	join Szczepienia s on s.LekarzID = l.LekarzID
group by l.LekarzID, l.Imie, l.Nazwisko
having count(s.LekarzID) > 	
	(
		select avg(cast(number as float)) 
		from 
		( 
			select count(s.LekarzID) as number
			from Lekarze l
				left join Szczepienia s on s.LekarzID = l.LekarzID
			group by l.LekarzID, l.Imie, l.Nazwisko
		) as number
	) * 1.05;

-- Liczymy tylko szczepienia, na kt�re jest ju� zapisana osoba.
Select l.LekarzID, l.Imie, l.Nazwisko, count(s.LekarzID) as [Liczba szczepien]
from Lekarze l
	join Szczepienia s on s.LekarzID = l.LekarzID
	where s.PacjentID IS NOT NULL
group by l.LekarzID, l.Imie, l.Nazwisko
having count(s.LekarzID) >	
	(
		select sum(cast(number as float)) 
		from 
		( 
			select count(s.LekarzID) as number
			from Szczepienia s
			where s.PacjentID IS NOT NULL
			group by s.LekarzID
		) as number
	) /
	(
		select cast(count(*) as float)
		from Lekarze
	) * 1.05;

-- 3
Select p.PacjentID, p.Imie, p.Nazwisko
from Pacjenci p
	join Szczepienia s on s.PacjentID = p.PacjentID
	left join Odczyny o on o.SzczepienieID = s.SzczepienieID
group by p.PacjentID, p.Imie, p.Nazwisko
having count(o.SzczepienieID) <= 1

-- 4
-- �rednia szczepionek przypadaj�ca na jedno wojew�dztwo. Bierzemy pod uwag� tylko wojew�dztwa, w kt�rych jest co najmniej jedno szczepienie.
Select Avg(cast(number as float)) as Srednia
from 
(
	Select m.Wojewodztwo, count(m.Wojewodztwo) as number
	from Miejscowosc m
		join Pacjenci p on  p.MiejscowoscID = m.MiejscowoscID
		join Szczepienia s on s.PacjentID = p.PacjentID
	group by m.Wojewodztwo
) as number

-- �rednia szczepionek bior�ca pod uwag� wszystkie wojew�dztwa.
select [Ilosc szczepien], [Ilosc wojewodztw], (cast([Ilosc szczepien] as float) / [Ilosc wojewodztw]) as [Srednia na wojewodztwo]
from
(
	select 
	(
		select count(s.SzczepienieID) as [Ilosc szczepien]
		from Szczepienia s
		where s.PacjentID IS NOT NULL
	) as [Ilosc szczepien],
	(
		select count([Ilosc wojewodztw])
		from
			(
				select count(*) as [Ilosc wojewodztw]
				from Miejscowosc m
				group by m.Wojewodztwo
			) as [Ilosc wojewodztw]
	) as [Ilosc wojewodztw]
)Zadanie4

-- 5
select m.MiejscowoscID, m.Wojewodztwo, m.Miejscowosc, count(p.MiejscowoscID)
from Miejscowosc m
	left join Pacjenci p on p.MiejscowoscID = m.MiejscowoscID
where not exists
(
	select *
	from Pacjenci p
		join Szczepienia s on s.PacjentID = p.PacjentID
			where p.MiejscowoscID = m.MiejscowoscID and exists 
		(
			select *
			from Odczyny o
			where o.SzczepienieID = s.SzczepienieID
		)
)
group by m.MiejscowoscID, m.Wojewodztwo, m.Miejscowosc

-- Etap 5
EXECUTE NextVaccine @wojewodztwo = 'Mazowieckie',  @szczepionka = 'Pfitzer'