create database Timesheet
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY,
    AdminName VARCHAR(100),
    AdminPassword VARCHAR(100),
    AdminEmail VARCHAR(100),
    AdminNumber VARCHAR(20)
);

CREATE TABLE Grade (
    GradeID INT PRIMARY KEY,
    TotalCasualLeave INT
);

CREATE TABLE Designation (
    DesignationID INT PRIMARY KEY,
    GradeID INT,
    DesignationName VARCHAR(100),
    FOREIGN KEY (GradeID) REFERENCES Grade(GradeID)
);

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Description TEXT,
    ProjectStartDate DATE,
    ProjectEndDate DATE
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    RoleID INT,
    ProjectID INT,
    FullName VARCHAR(100),
    EmailID VARCHAR(100),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    HireDate DATE,
    ManagerID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (RoleID) REFERENCES Designation(DesignationID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Leave (
    LeaveID INT PRIMARY KEY,
    LeaveType VARCHAR(50)
);

CREATE TABLE LeaveInfo (
    Date DATE,
    Day VARCHAR(20),
    LeaveName VARCHAR(100)
);

CREATE TABLE LeaveRequest (
    LeaveRequestID INT PRIMARY KEY,
    LeaveID INT,
    EmployeeID INT,
    LeaveDate DATE,
    LeaveType VARCHAR(50),
    AppliedDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (LeaveID) REFERENCES Leave(LeaveID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    AttendanceDate DATE,
    HoursWorked DECIMAL(5, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

CREATE TABLE PendingAttendanceRequest (
    RequestID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    RequestDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

CREATE TABLE AvailableLeave (
    AvailableLeaveID INT PRIMARY KEY,
    EmployeeID INT,
    LeaveID INT,
    AvailableLeaves INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (LeaveID) REFERENCES Leave(LeaveID)
);
