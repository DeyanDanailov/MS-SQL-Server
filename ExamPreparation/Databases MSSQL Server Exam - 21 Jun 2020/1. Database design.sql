--CREATE DATABASE TripService
--USE TripService

CREATE TABLE Cities
(
    Id          int PRIMARY KEY IDENTITY,
    Name        nvarchar(20) NOT NULL,
    CountryCode char(2)      NOT NULL 

)

CREATE TABLE Hotels
(
    Id            int PRIMARY KEY IDENTITY,
    Name          nvarchar(30) NOT NULL,
    CityId        int          NOT NULL REFERENCES Cities (Id),
    EmployeeCount int          NOT NULL,
    BaseRate      decimal(18, 2)

)

CREATE TABLE Rooms
(
    Id      int PRIMARY KEY IDENTITY,
    Price   decimal(18, 2) NOT NULL,
    Type    nvarchar(20)   NOT NULL,
    Beds    int            NOT NULL,
    HotelId int            NOT NULL REFERENCES Hotels (Id)

)
CREATE TABLE Trips
(
    Id          INT PRIMARY KEY IDENTITY,
    RoomId      INT      NOT NULL REFERENCES Rooms (Id),
    BookDate    DATETIME NOT NULL,
    ArrivalDate DATETIME NOT NULL,
    ReturnDate  DATETIME NOT NULL,
    CancelDate  DATETIME,

    CONSTRAINT bookDate_ArrivalDate CHECK (BookDate < ArrivalDate),
    CONSTRAINT arrivalDate_ReturnDate CHECK (ArrivalDate < ReturnDate)
)

CREATE TABLE Accounts
(
    Id         int PRIMARY KEY IDENTITY,
    FirstName  nvarchar(50)         NOT NULL,
    MiddleName nvarchar(20),
    LastName   nvarchar(50)         NOT NULL,
    CityId     int                  NOT NULL REFERENCES Cities (Id),
    BirthDate  date                 NOT NULL,
    Email      varchar(100) UNIQUE NOT NULL

)

CREATE TABLE AccountsTrips
(
    AccountId int NOT NULL REFERENCES Accounts (Id),
    TripId    int NOT NULL REFERENCES Trips (Id),
    Luggage   int NOT NULL CHECK (Luggage >= 0),
    PRIMARY KEY (AccountId, TripId)

)