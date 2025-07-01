--****Eden Sivan Nizri
--****9297-47

-- Create a new database

create database SportsDB

go

use SportsDB

-- Create Teams table
create table Teams (
    TeamID int primary key identity(1,1),
    TeamName nvarchar(50) not null unique,
    City nvarchar(50),
    CoachName nvarchar(50)
)

-- Create Players table
create table Players (
    PlayerID int primary key identity(1,1),
    PlayerName nvarchar(50) not null,
    Age int check (Age > 15 and Age < 50),
    Position nvarchar(20),
    TeamID int references Teams(TeamID) on delete cascade
)

-- Create Stadiums table
create table Stadiums (
    StadiumID int primary key identity(1,1),
    StadiumName nvarchar(50) not null unique,
    Capacity int check (Capacity > 0),
    Location nvarchar(50)
)

-- Create Matches table
create table Matches (
    MatchID int primary key identity(1,1),
    MatchDate datetime not null,
    HomeTeamID int references Teams(TeamID) on delete cascade, -- שמירה על מחיקה מתגלגלת
    AwayTeamID int references Teams(TeamID) on delete no action, -- מניעת מחיקה מתגלגלת כפולה
    StadiumID int references Stadiums(StadiumID) on delete cascade,
    HomeScore int check (HomeScore >= 0),
    AwayScore int check (AwayScore >= 0)
)

-- Create PlayerStats table
create table PlayerStats (
    StatID int primary key identity(1,1),
    PlayerID int references Players(PlayerID) on delete cascade,
    MatchID int references Matches(MatchID) on delete no action, -- מניעת מחיקה כפולה
    Goals int default 0 check (Goals >= 0),
    Assists int default 0 check (Assists >= 0),
    YellowCards int default 0 check (YellowCards >= 0),
    RedCards int default 0 check (RedCards >= 0)
)

-- Create TeamStats table
create table TeamStats (
    StatID int primary key identity(1,1),
    TeamID int references Teams(TeamID) on delete cascade,
    MatchesPlayed int default 0 check (MatchesPlayed >= 0),
    Wins int default 0 check (Wins >= 0),
    Draws int default 0 check (Draws >= 0),
    Losses int default 0 check (Losses >= 0),
    Points int default 0 check (Points >= 0)
)

-- Create Referees table
create table Referees (
    RefereeID int primary key identity(1,1),
    RefereeName nvarchar(50) not null,
    ExperienceYears int check (ExperienceYears >= 0)
)

-- Create MatchOfficials table
create table MatchOfficials (
    OfficialID int primary key identity(1,1),
    MatchID int references Matches(MatchID) on delete cascade,
    RefereeID int references Referees(RefereeID) on delete cascade
)

-- Create Tickets table
create table Tickets (
    TicketID int primary key identity(1,1),
    MatchID int references Matches(MatchID) on delete no action, -- מניעת מחיקה כפולה
    BuyerName nvarchar(50),
    SeatNumber nvarchar(10) not null unique
)

-- Create Sponsors table
CREATE TABLE Sponsors (
    SponsorID INT PRIMARY KEY IDENTITY(1,1),
    SponsorName NVARCHAR(50) NOT NULL UNIQUE,
    Budget MONEY CHECK (Budget > 0)
);
  -- Create SponsorMatches table
CREATE TABLE SponsorMatches (
    SponsorMatchID INT PRIMARY KEY IDENTITY(1,1),
    SponsorID INT REFERENCES Sponsors(SponsorID),
    MatchID INT REFERENCES Matches(MatchID),
    SponsorshipAmount MONEY CHECK (SponsorshipAmount > 0)
);



-- Insert data into Teams table
insert into Teams (TeamName, City, CoachName) values
('Tigers', 'New York', 'John Smith'),
('Eagles', 'Los Angeles', 'Emily Johnson'),
('Wolves', 'Chicago', 'Robert Brown'),
('Lions', 'Houston', 'Michael Davis'),
('Bears', 'Phoenix', 'Sarah Wilson'),
('Panthers', 'Miami', 'David Adams'),
('Sharks', 'San Diego', 'Laura Scott'),
('Hawks', 'Atlanta', 'George Clark'),
('Cheetahs', 'San Francisco', 'Angela Hall'),
('Dragons', 'Seattle', 'Matthew Lee'),
('Cobras', 'Denver', 'Susan Walker'),
('Raptors', 'Boston', 'Mark Young'),
('Falcons', 'Dallas', 'Steven Harris'),
('Vipers', 'Philadelphia', 'Patricia Wright'),
('Rhinos', 'Detroit', 'Andrew Robinson'),
('Bulls', 'Charlotte', 'Barbara Lewis'),
('Cougars', 'Orlando', 'Thomas Martinez'),
('Mustangs', 'San Antonio', 'Karen Thompson'),
('Foxes', 'Portland', 'Richard Hernandez'),
('Otters', 'Minneapolis', 'Linda Rodriguez');

-- Insert data into Players table
insert into Players (PlayerName, Age, Position, TeamID) values
('Michael Jordan', 35, 'Forward', 1),
('Kobe Bryant', 30, 'Guard', 2),
('Derrick Rose', 28, 'Guard', 3),
('James Harden', 31, 'Forward', 4),
('Stephen Curry', 33, 'Guard', 5),
('LeBron James', 36, 'Forward', 6),
('Kevin Durant', 32, 'Forward', 7),
('Chris Paul', 35, 'Guard', 8),
('Damian Lillard', 30, 'Guard', 9),
('Giannis Antetokounmpo', 26, 'Forward', 10),
('Kawhi Leonard', 30, 'Forward', 11),
('Anthony Davis', 28, 'Center', 12),
('Luka Doncic', 22, 'Guard', 13),
('Zion Williamson', 21, 'Forward', 14),
('Jayson Tatum', 23, 'Forward', 15),
('Joel Embiid', 27, 'Center', 16),
('Nikola Jokic', 26, 'Center', 17),
('Jimmy Butler', 31, 'Forward', 18),
('Bradley Beal', 28, 'Guard', 19),
('Trae Young', 23, 'Guard', 20);

-- Insert data into Stadiums table
insert into Stadiums (StadiumName, Capacity, Location) values
('Madison Square Garden', 20000, 'New York'),
('Staples Center', 19000, 'Los Angeles'),
('United Center', 21000, 'Chicago'),
('Toyota Center', 18000, 'Houston'),
('Footprint Center', 17000, 'Phoenix'),
('Chase Center', 18000, 'San Francisco'),
('American Airlines Arena', 20000, 'Miami'),
('Barclays Center', 19000, 'Brooklyn'),
('Moda Center', 19000, 'Portland'),
('Vivint Arena', 18000, 'Salt Lake City'),
('Spectrum Center', 19000, 'Charlotte'),
('Capital One Arena', 20000, 'Washington'),
('Amway Center', 18000, 'Orlando'),
('Smoothie King Center', 17000, 'New Orleans'),
('Rocket Mortgage FieldHouse', 19000, 'Cleveland'),
('TD Garden', 19500, 'Boston'),
('Wells Fargo Center', 19000, 'Philadelphia'),
('Pepsi Center', 20000, 'Denver'),
('AT&T Center', 19000, 'San Antonio'),
('Little Caesars Arena', 20000, 'Detroit');


-- Insert data into Matches table
insert into Matches (MatchDate, HomeTeamID, AwayTeamID, StadiumID, HomeScore, AwayScore) values
('2025-01-01', 1, 2, 1, 95, 90),
('2025-01-02', 3, 4, 3, 110, 105),
('2025-01-03', 5, 6, 5, 100, 98),
('2025-01-04', 7, 8, 2, 120, 115),
('2025-01-05', 9, 10, 4, 98, 96),
('2025-01-06', 11, 12, 6, 101, 99),
('2025-01-07', 13, 14, 7, 105, 100),
('2025-01-08', 15, 16, 8, 110, 108),
('2025-01-09', 17, 18, 9, 115, 110),
('2025-01-10', 19, 20, 10, 120, 115),
('2025-01-11', 1, 3, 11, 95, 89),
('2025-01-12', 2, 4, 12, 100, 95),
('2025-01-13', 5, 7, 13, 110, 109),
('2025-01-14', 6, 8, 14, 90, 85),
('2025-01-15', 9, 11, 15, 105, 102),
('2025-01-16', 10, 12, 16, 115, 110),
('2025-01-17', 13, 15, 17, 120, 115),
('2025-01-18', 14, 16, 18, 90, 88),
('2025-01-19', 17, 19, 19, 105, 100),
('2025-01-20', 18, 20, 20, 110, 108);

-- Insert data into Referees table
insert into Referees (RefereeName, ExperienceYears) values
('John Doe', 15),
('Jane Roe', 10),
('Alex Smith', 12),
('Chris Johnson', 8),
('Pat Taylor', 5),
('Dana Lee', 7),
('Jordan Brown', 9),
('Taylor Green', 6),
('Morgan White', 14),
('Jamie Black', 11),
('Robin Clark', 13),
('Alex Jordan', 12),
('Sam Adams', 10),
('Kim West', 8),
('Lee Carter', 6),
('Chris Walker', 9),
('Taylor Lewis', 7),
('Jordan Hill', 10),
('Jamie Brown', 11),
('Morgan Black', 13);

-- Insert data into MatchOfficials table
insert into MatchOfficials (MatchID, RefereeID) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

-- Insert data into Tickets table
insert into Tickets (MatchID, BuyerName, SeatNumber) values
(1, 'Alice Johnson', 'A1'),
(1, 'Bob Brown', 'A2'),
(2, 'Charlie Davis', 'B1'),
(2, 'Diana Evans', 'B2'),
(3, 'Eve Harris', 'C1'),
(3, 'Frank Garcia', 'C2'),
(4, 'Grace Hall', 'D1'),
(4, 'Hank Allen', 'D2'),
(5, 'Ivy Young', 'E1'),
(5, 'Jack King', 'E2'),
(6, 'Karen Lopez', 'F1'),
(6, 'Larry Hill', 'F2'),
(7, 'Mona Adams', 'G1'),
(7, 'Nick Scott', 'G2'),
(8, 'Olivia Carter', 'H1'),
(8, 'Paul Nelson', 'H2'),
(9, 'Quincy Moore', 'I1'),
(9, 'Rachel Reed', 'I2'),
(10, 'Steve Brooks', 'J1'),
(10, 'Tina Turner', 'J2');

-- Insert data into Sponsors table
insert into Sponsors (SponsorName, Budget) values
('Nike', 1000000),
('Adidas', 900000),
('Puma', 800000),
('Reebok', 700000),
('Under Armour', 600000),
('New Balance', 500000),
('ASICS', 400000),
('Fila', 300000),
('Converse', 200000),
('Vans', 100000),
('Umbro', 95000),
('Diadora', 85000),
('Kappa', 75000),
('Lotto', 65000),
('Hummel', 55000),
('Joma', 45000),
('Errea', 35000),
('Mitre', 25000),
('Macron', 15000),
('Kelme', 5000);

-- Insert data into PlayerStats
INSERT INTO PlayerStats (PlayerID, MatchID, Goals, Assists, YellowCards, RedCards)
VALUES
(1, 1, 2, 1, 0, 0),
(2, 1, 1, 0, 1, 0),
(3, 2, 3, 1, 0, 0),
(4, 2, 2, 0, 1, 0),
(5, 3, 1, 2, 0, 0),
(6, 3, 2, 1, 1, 0),
(7, 4, 4, 0, 0, 0),
(8, 4, 1, 1, 0, 0),
(9, 5, 0, 1, 1, 0),
(10, 5, 1, 0, 0, 1),
(11, 6, 2, 1, 0, 0),
(12, 6, 3, 0, 0, 0),
(13, 7, 1, 2, 0, 0),
(14, 7, 2, 1, 1, 0),
(15, 8, 3, 1, 0, 0),
(16, 8, 2, 0, 0, 1),
(17, 9, 4, 0, 1, 0),
(18, 9, 1, 1, 0, 0),
(19, 10, 0, 0, 0, 0),
(20, 10, 2, 1, 0, 0);

-- Insert corrected data into SponsorMatches
INSERT INTO SponsorMatches (SponsorID, MatchID, SponsorshipAmount)
VALUES
(1, 1, 50000),
(2, 2, 60000),
(3, 3, 70000),
(4, 4, 80000),
(5, 5, 90000),
(6, 6, 55000),
(7, 7, 62000),
(8, 8, 71000),
(9, 9, 88000),
(10, 10, 99000),
(11, 11, 40000),
(12, 12, 35000),
(13, 13, 30000),
(14, 14, 45000),
(15, 15, 28000),
(16, 16, 33000),
(17, 17, 25000),
(18, 18, 22000),
(19, 19, 20000),
(20, 20, 18000);

-- Insert data into TeamStats
INSERT INTO TeamStats (TeamID, MatchesPlayed, Wins, Draws, Losses, Points)
SELECT
    Teams.TeamID,
    COUNT(Matches.MatchID) AS MatchesPlayed,
    SUM(CASE WHEN Matches.HomeScore > Matches.AwayScore THEN 1 ELSE 0 END) AS Wins,
    SUM(CASE WHEN Matches.HomeScore = Matches.AwayScore THEN 1 ELSE 0 END) AS Draws,
    SUM(CASE WHEN Matches.HomeScore < Matches.AwayScore THEN 1 ELSE 0 END) AS Losses,
    SUM(CASE WHEN Matches.HomeScore > Matches.AwayScore THEN 3 ELSE CASE WHEN Matches.HomeScore = Matches.AwayScore THEN 1 ELSE 0 END END) AS Points
FROM Teams
LEFT JOIN Matches ON Teams.TeamID = Matches.HomeTeamID
GROUP BY Teams.TeamID;


-- הצגת כל הטבלאות, כולל SponsorMatches
SELECT
    c.TABLE_NAME AS TableName,
    c.COLUMN_NAME AS ColumnName,
    CASE
        WHEN pk.COLUMN_NAME IS NOT NULL THEN 'Primary Key'
        WHEN fk.COLUMN_NAME IS NOT NULL THEN 'Foreign Key'
        ELSE 'Regular Column'
    END AS ColumnType
FROM INFORMATION_SCHEMA.COLUMNS c
LEFT JOIN (
    SELECT ku.TABLE_NAME, ku.COLUMN_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
    INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE ku
        ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
    WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
) pk
    ON c.TABLE_NAME = pk.TABLE_NAME AND c.COLUMN_NAME = pk.COLUMN_NAME
LEFT JOIN (
    SELECT ku.TABLE_NAME, ku.COLUMN_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
    INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE ku
        ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
    WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
) fk
    ON c.TABLE_NAME = fk.TABLE_NAME AND c.COLUMN_NAME = fk.COLUMN_NAME
ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION;

-- ספירת הרשומות בכל הטבלאות 
SELECT 'Matches' AS TableName, COUNT(*) AS RecordCount FROM Matches
UNION ALL
SELECT 'MatchOfficials' AS TableName, COUNT(*) AS RecordCount FROM MatchOfficials
UNION ALL
SELECT 'Players' AS TableName, COUNT(*) AS RecordCount FROM Players
UNION ALL
SELECT 'PlayerStats' AS TableName, COUNT(*) AS RecordCount FROM PlayerStats
UNION ALL
SELECT 'Referees' AS TableName, COUNT(*) AS RecordCount FROM Referees
UNION ALL
SELECT 'Sponsors' AS TableName, COUNT(*) AS RecordCount FROM Sponsors
UNION ALL
SELECT 'Stadiums' AS TableName, COUNT(*) AS RecordCount FROM Stadiums
UNION ALL
SELECT 'Teams' AS TableName, COUNT(*) AS RecordCount FROM Teams
UNION ALL
SELECT 'TeamStats' AS TableName, COUNT(*) AS RecordCount FROM TeamStats
UNION ALL
SELECT 'Tickets' AS TableName, COUNT(*) AS RecordCount FROM Tickets
UNION ALL
SELECT 'SponsorMatches' AS TableName, COUNT(*) AS RecordCount FROM SponsorMatches;
