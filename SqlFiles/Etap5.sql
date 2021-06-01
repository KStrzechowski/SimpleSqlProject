CREATE PROCEDURE NextVaccine @wojewodztwo varchar(25), @szczepionka varchar(25)
AS
DECLARE @pacjentID int
DECLARE @LiczbaOdczynow int
DECLARE @LiczbaTygodni int
DECLARE @DataOstatniegoSzczepienia Date

DECLARE custom CURSOR LOCAL FOR
	select p.PacjentID
	from Pacjenci p
		join Miejscowosc m on m.MiejscowoscID = p.MiejscowoscID
		join Szczepienia s on s.PacjentID = p.PacjentID
		join Szczepionki szczepionka on szczepionka.SzczepionkaID = s.SzczepionkaID
		where m.Wojewodztwo = @wojewodztwo
			AND szczepionka.NazwaSzczepionki = @szczepionka
			AND not exists 
			(
				select *
				from Szczepienia s
				where s.PacjentID = p.PacjentID
					AND s.DataSzczepienia > CURRENT_TIMESTAMP
			)
	group by p.PacjentID
	having count(s.PacjentID) = 2
OPEN custom
FETCH NEXT FROM CUSTOM INTO @pacjentID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @DataOstatniegoSzczepienia =
		( 
			select top 1 s.DataSzczepienia
			from Szczepienia s
			where s.PacjentID = @pacjentID
		)

	SET @LiczbaOdczynow =
		(
			Select count(o.SzczepienieID)
			from Szczepienia s 
				left join Odczyny o on o.SzczepienieID = s.SzczepienieID
			where s.PacjentID = @pacjentID
			group by s.PacjentID
		) 

	SET @LiczbaTygodni = 0
	IF (@LiczbaOdczynow <= 1)
	BEGIN
		SET @LiczbaTygodni = 2 
	END
	ELSE IF (@LiczbaOdczynow <= 2)
	BEGIN
		SET @LiczbaTygodni = 4
	END
	
	if (@LiczbaTygodni > 0)
	BEGIN
		UPDATE Szczepienia SET PacjentID = @pacjentID
		where SzczepienieID in
		(
			Select TOP 1 s.SzczepienieID
			from Szczepienia s
				join Szczepionki szczepionka on szczepionka.SzczepionkaID = s.SzczepionkaID
			where s.PacjentID IS NULL
				AND s.DataSzczepienia > CURRENT_TIMESTAMP 
				AND s.DataSzczepienia >= DATEADD(WEEK, @LiczbaTygodni, @DataOstatniegoSzczepienia)
				AND szczepionka.NazwaSzczepionki = @szczepionka
			order by s.DataSzczepienia asc
		)
	END

	FETCH NEXT FROM custom INTO @pacjentID
END
CLOSE custom
DEALLOCATE custom

