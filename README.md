# 🗓️ Meeting Room Management System

A MySQL-based relational database designed to manage meeting room bookings in a company. This system covers entities such as employees, meeting rooms, room bookings, and ensures room availability checks. It includes a sample stored procedure to query the availability of a meeting room during a specific time range.

---

## 🗃️ Overview

This project demonstrates the design and setup of a meeting room booking database with proper use of foreign keys, stored procedures, and sample data. It can be used for company office management systems, projects, or as a base for building meeting room reservation systems.

---

## 📐 Entity-Relationship Model

**Main Entities:**
- **Employee**
- **Meeting Room**
- **Room Booking**

---

## 🧱 Database Schema

### 1. `Employees`
Stores employee details.

| Column     | Type          | Constraint     |
|------------|---------------|----------------|
| EmployeeID | INT           | Primary Key, AUTO_INCREMENT |
| Name       | VARCHAR(100)  | NOT NULL       |
| Email      | VARCHAR(100)  | UNIQUE, NOT NULL |
| Department | VARCHAR(50)   | NULLABLE       |

---

### 2. `MeetingRooms`
Stores meeting room details.

| Column      | Type          | Constraint     |
|-------------|---------------|----------------|
| RoomID      | INT           | Primary Key, AUTO_INCREMENT |
| RoomName    | VARCHAR(100)  | UNIQUE, NOT NULL |
| Capacity    | INT           | NOT NULL       |
| Location    | VARCHAR(100)  | NULLABLE       |

---

### 3. `RoomBookings`
Stores room booking details.

| Column     | Type          | Constraint       |
|------------|---------------|------------------|
| BookingID  | INT           | Primary Key, AUTO_INCREMENT |
| RoomID     | INT           | Foreign Key → MeetingRooms(RoomID) |
| EmployeeID | INT           | Foreign Key → Employees(EmployeeID) |
| StartTime  | DATETIME      | NOT NULL         |
| EndTime    | DATETIME      | NOT NULL         |
| Purpose    | VARCHAR(200)  | NULLABLE         |

---

