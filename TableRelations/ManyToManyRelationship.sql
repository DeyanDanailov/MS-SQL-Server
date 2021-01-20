CREATE DATABASE Students

USE Students

CREATE TABLE Students
(
    StudentID int PRIMARY KEY IDENTITY,
    Name      nvarchar(20) NOT NULL
)
INSERT INTO Students(Name)
VALUES ('Mila'),
       ('Toni'),
       ('Ron')

CREATE TABLE Exams
(
    ExamID int PRIMARY KEY IDENTITY (101,1),
    Name   nvarchar(20) NOT NULL
)

INSERT INTO Exams(Name)
VALUES ('SpringMVC'),
       ('Neo4j'),
       ('Oracle 11g')

CREATE TABLE StudentsExams
(
    StudentID int FOREIGN KEY REFERENCES Students (StudentID),
    ExamID    int FOREIGN KEY REFERENCES Exams (ExamID),
    PRIMARY KEY (StudentID, ExamID)
)