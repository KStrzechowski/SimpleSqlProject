CREATE NONCLUSTERED INDEX PacjentLek_PacjentID_Index
on PacjentLek (PacjentID)

CREATE NONCLUSTERED INDEX PacjentLek_LekID_Index
on PacjentLek (LekID)

CREATE NONCLUSTERED INDEX Pacjent_Miejscowosc_Index
on Pacjenci (MiejscowoscID)

CREATE NONCLUSTERED INDEX Szczepienia_PacjentID_Index
on Szczepienia (PacjentID)

CREATE NONCLUSTERED INDEX Szczepienia_LekarzID_Index
on Szczepienia (LekarzID)

CREATE NONCLUSTERED INDEX Szczepienia_SzczepionkaID_Index
on Szczepienia (SzczepionkaID)

CREATE NONCLUSTERED INDEX Szczepienia_Data_Index
on Szczepienia (DataSzczepienia)

CREATE NONCLUSTERED INDEX Lekarze_Specjalnosc_Index
on Lekarze (SpecjalnoscID)

CREATE NONCLUSTERED INDEX Odczyny_Szczepionka_Index
on Odczyny (SzczepienieID)

CREATE NONCLUSTERED INDEX Odczyny_Typ_Index
on Odczyny (OdczynID)