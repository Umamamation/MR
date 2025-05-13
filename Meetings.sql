CREATE DATABASE Meetings;

USE Meetings;

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Department VARCHAR(50)
);

CREATE TABLE MeetingRooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomName VARCHAR(100) UNIQUE NOT NULL,
    Capacity INT NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE RoomBookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    RoomID INT NOT NULL,
    EmployeeID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Purpose VARCHAR(200),
    FOREIGN KEY (RoomID) REFERENCES MeetingRooms(RoomID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    CONSTRAINT chk_time CHECK (StartTime < EndTime)
);

CREATE INDEX idx_booking_time ON RoomBookings(RoomID, StartTime, EndTime);

DELIMITER $$

CREATE PROCEDURE CheckRoomAvailability(
    IN inRoomID INT,
    IN inStart DATETIME,
    IN inEnd DATETIME
)
BEGIN
    SELECT 
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM RoomBookings
                WHERE RoomID = inRoomID
                  AND (
                        (inStart BETWEEN StartTime AND EndTime)
                     OR (inEnd BETWEEN StartTime AND EndTime)
                     OR (StartTime BETWEEN inStart AND inEnd)
                     )
            ) THEN 'Not Available'
            ELSE 'Available'
        END AS Availability;
END$$

DELIMITER ;

INSERT INTO MeetingRooms (RoomName, Capacity, Location) VALUES
('Orion Conference', 10, 'Floor 2'),
('Sirius Board Room', 20, 'Floor 3');

INSERT INTO Employees (Name, Email, Department) VALUES
('Alice Johnson', 'alice@company.com', 'HR'),
('Bob Smith', 'bob@company.com', 'Engineering');

INSERT INTO RoomBookings (RoomID, EmployeeID, StartTime, EndTime, Purpose) VALUES
(1, 1, '2025-05-14 10:00:00', '2025-05-14 11:00:00', 'HR Review Meeting');

CALL CheckRoomAvailability(1, '2025-05-14 10:30:00', '2025-05-14 11:30:00');
