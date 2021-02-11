--CREATE DATABASE WMS

CREATE TABLE Clients
(
    ClientId  int PRIMARY KEY IDENTITY,
    FirstName varchar(50) NOT NULL,
    LastName  varchar(50) NOT NULL,
    Phone     char(12) CHECK (LEN(Phone) = 12)

)

CREATE TABLE Mechanics
(
    MechanicId int PRIMARY KEY IDENTITY,
    FirstName  varchar(50)  NOT NULL,
    LastName   varchar(50)  NOT NULL,
    Address    varchar(max) NOT NULL

)

CREATE TABLE Models
(
    ModelId int PRIMARY KEY IDENTITY,
    Name    varchar(50) NOT NULL UNIQUE

)


CREATE TABLE Jobs
(
    JobId      int PRIMARY KEY IDENTITY,
    ModelId    int  NOT NULL REFERENCES Models (ModelId),
    Status     varchar(11) CHECK (Status IN ('Pending', 'In Progress', 'Finished')) DEFAULT 'Pending',
    ClientId   int  NOT NULL REFERENCES Clients (ClientId),
    MechanicId int REFERENCES Mechanics (MechanicId),
    IssueDate  date NOT NULL,
    FinishDate date

)
CREATE TABLE Orders
(
    OrderId   int PRIMARY KEY IDENTITY,
    JobId     int NOT NULL REFERENCES Jobs (JobId),
    IssueDate date,
    Delivered bit NOT NULL DEFAULT 0

)
CREATE TABLE Vendors
(
    VendorId int PRIMARY KEY IDENTITY,
    Name     varchar(50) NOT NULL UNIQUE

)
CREATE TABLE Parts
(
    PartId       int PRIMARY KEY IDENTITY,
    SerialNumber varchar(50)   NOT NULL UNIQUE,
    Description  varchar(max),
    Price        decimal(6, 2) NOT NULL CHECK (Price > 0),
    VendorId     int           NOT NULL REFERENCES Vendors (VendorId),
    StockQty     int           NOT NULL CHECK (StockQty >= 0) DEFAULT 0

)

CREATE TABLE OrderParts
(
    OrderId  int NOT NULL REFERENCES Orders (OrderId),
    PartId   int NOT NULL REFERENCES Parts (PartId),
    Quantity int NOT NULL CHECK (Quantity > 0) DEFAULT 1
        PRIMARY KEY (OrderId, PartId)
)
CREATE TABLE PartsNeeded
(
    JobId    int NOT NULL REFERENCES Jobs (JobId),
    PartId   int NOT NULL REFERENCES Parts (PartId),
    Quantity int NOT NULL CHECK (Quantity > 0) DEFAULT 1
        PRIMARY KEY (JobId, PartId)

)