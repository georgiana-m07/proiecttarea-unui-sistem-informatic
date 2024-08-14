USE PSI;

-- Crearea tabelului 'Pacienti'
CREATE TABLE Pacienti (
    PacientID INT PRIMARY KEY IDENTITY(1,1),
    Nume VARCHAR(100),
    Prenume VARCHAR(100),
    DataNasterii DATE,
    Telefon VARCHAR(15),
    Email VARCHAR(100),
    Adresa VARCHAR(255)
);

-- Crearea tabelului 'Tratamente'
CREATE TABLE Tratamente (
    TratamentID INT PRIMARY KEY IDENTITY(1,1),
    Denumire VARCHAR(100),
    Descriere TEXT
);


-- Crearea tabelului 'Programari'
CREATE TABLE Programari (
    ProgramareID INT PRIMARY KEY IDENTITY(1,1),
    PacientID INT,
    TratamentID INT,
    DataProgramare DATE,
    OraProgramare TIME,
    Descriere VARCHAR(255),
    Status VARCHAR(50),
    FOREIGN KEY (PacientID) REFERENCES Pacienti(PacientID),
    FOREIGN KEY (TratamentID) REFERENCES Tratamente(TratamentID)
);


-- Crearea tabelului 'Furnizori'
CREATE TABLE Furnizori (
    FurnizorID INT PRIMARY KEY IDENTITY(1,1),
    NumeFirma VARCHAR(100),
    Contact VARCHAR(255),
    Telefon VARCHAR(15),
    Email VARCHAR(100),
    Adresa VARCHAR(255)
);

-- Crearea tabelului 'Materiale'
CREATE TABLE Materiale (
    MaterialID INT PRIMARY KEY IDENTITY(1,1),
    Denumire VARCHAR(100),
    Descriere TEXT,
    Cantitate INT,
    PretUnitar DECIMAL(10, 2),
    FurnizorID INT,
    FOREIGN KEY (FurnizorID) REFERENCES Furnizori(FurnizorID)
);

-- Crearea tabelului 'LucrariDentare'
CREATE TABLE LucrariDentare (
    LucrareDentaraID INT PRIMARY KEY IDENTITY(1,1),
    PacientID INT,
    TratamentID INT,
    MaterialID INT,
    Descriere TEXT,
    DataInceput DATE,
    DataFinalizare DATE,
    Cost DECIMAL(10, 2),
    FOREIGN KEY (PacientID) REFERENCES Pacienti(PacientID),
    FOREIGN KEY (TratamentID) REFERENCES Tratamente(TratamentID),
    FOREIGN KEY (MaterialID) REFERENCES Materiale(MaterialID)
);

-- Crearea tabelului 'Facturi'
CREATE TABLE Facturi (
    FacturaID INT PRIMARY KEY IDENTITY(1,1),
    LucrareDentaraID INT,
    UtilizatorID INT,
    DataEmitere DATE,
    SumaTotala DECIMAL(10, 2),
    StatusPlata VARCHAR(50),
    FOREIGN KEY (LucrareDentaraID) REFERENCES LucrariDentare(LucrareDentaraID),
);

-- Crearea tabelului 'IstoricMedical'
CREATE TABLE IstoricMedical (
    IstoricID INT PRIMARY KEY IDENTITY(1,1),
    PacientID INT,
    DetaliiIstoric TEXT,
    DataInregistrarii DATE,
    FOREIGN KEY (PacientID) REFERENCES Pacienti(PacientID)
);

-- Crearea tabelului 'Utilizatori'
CREATE TABLE Utilizatori (
    UtilizatorID INT PRIMARY KEY IDENTITY(1,1),
    NumeUtilizator VARCHAR(100),
    ParolaHash VARCHAR(255),
    Rol VARCHAR(50),
    DataCrearii DATE
);

-- Inserarea datelor în 'Utilizatori' cu criptarea parolei
INSERT INTO Utilizatori (NumeUtilizator, ParolaHash, Rol, DataCrearii)
VALUES 
    ('admin', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'passwordAdmin'), 2), 'Admin', GETDATE()),
    ('user1', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'password1'), 2), 'User', GETDATE()),
    ('user2', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'password2'), 2), 'User', GETDATE()),
    ('user3', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'password3'), 2), 'User', GETDATE());

SELECT * FROM Utilizatori

EXEC sp_help Utilizatori;

CREATE TABLE Jurnalizare (
    JurnalizareID INT PRIMARY KEY IDENTITY(1,1),
    UtilizatorID INT,
    Operatiune VARCHAR(100),
    DataOra DATETIME,
    FOREIGN KEY (UtilizatorID) REFERENCES Utilizatori(UtilizatorID)
);

INSERT INTO Jurnalizare (UtilizatorID, Operatiune, DataOra)
VALUES 
    (1, 'Logare în aplicație', GETDATE()), 
    (2, 'Accesare setări cont', GETDATE()),  
    (3, 'Modificare parolă', GETDATE()),
	(4, 'Schimbare preferințe sistem', GETDATE()), 
    (1, 'Actualizare profil', GETDATE()), 
    (2, 'Verificare documente', GETDATE());  

Select * from Jurnalizare;