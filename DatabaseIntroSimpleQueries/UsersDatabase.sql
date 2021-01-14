
--•	Id – unique number for every user. There will be no more than 263-1 users. (Auto incremented)
--•	Username – unique identifier of the user will be no more than 30 characters (non Unicode). (Required)
--•	Password – password will be no longer than 26 characters (non Unicode). (Required)
--•	ProfilePicture – image with size up to 900 KB. 
--•	LastLoginTime
--•	IsDeleted – shows if the user deleted his/her profile. Possible states are true or false.
--Make Id primary key. Populate the table with exactly 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.

USE Minions

CREATE TABLE Users (
  Id BIGINT NOT NULL IDENTITY PRIMARY KEY,
  Username VARCHAR(30) NOT NULL,
  [Password] VARCHAR(26) NOT NULL,
  ProfilePicture VARBINARY(MAX) NULL,
  LastLoginTime DATETIME NOT NULL,
  IsDeleted BIT NOT NULL
)
	INSERT INTO Users(Username, [Password],ProfilePicture, LastLoginTime,IsDeleted) VALUES
	('Gosho','addad', Null, 1989-12-23, 1),
	('Pesho','kojm', Null, 1959-08-13, 0),
	('Stamat','salnasfasfnsdkf', Null, 1999-03-09, 0),
	('Dimitrichko','smdvs', Null, 1979-11-03, 0),
	('Kurti','iwrwow', Null, 1939-12-23, 1)

	ALTER TABLE Users
	ADD CONSTRAINT PK_Id PRIMARY KEY (Id)

	ALTER TABLE Users
	ADD CONSTRAINT CH_IfPUsernameIs3SymbolsOrMore CHECK (LEN(Username) > 3)

	ALTER TABLE Users
	ADD CONSTRAINT DF_LoginTime 
	DEFAULT GETdATE() FOR LastLoginTime