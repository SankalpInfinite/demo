
select*from role,Grade,employee

-- Create Role table
CREATE TABLE Role (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(100) NOT NULL
);
 
-- Create Grade table
CREATE TABLE Grade (
    GradeID INT PRIMARY KEY,
    GradeName VARCHAR(100) NOT NULL,
    TotalCasualLeave INT NOT NULL CHECK (TotalCasualLeave >= 0)
);
 
-- Create Project table
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    ProjectStartDate DATE NOT NULL,
    ProjectEndDate DATE NOT NULL,
    CHECK (ProjectStartDate <= ProjectEndDate)
);

-- Create Leave table
CREATE TABLE Leave (
    LeaveID INT PRIMARY KEY,
    LeaveType VARCHAR(50) UNIQUE NOT NULL
);
 
-- Create Admin table
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY,
    AdminName VARCHAR(100) NOT NULL,
    AdminUsername VARCHAR(50) UNIQUE NOT NULL,
    AdminPassword VARCHAR(100) NOT NULL,
    AdminEmail VARCHAR(100) NOT NULL,
    AdminNumber VARCHAR(20) NOT NULL,
    RoleID INT NOT NULL,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);
 
-- Create Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    RoleID INT NOT NULL,
    GradeID INT NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    EmailID VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    HireDate DATE NOT NULL,
    ManagerID INT,
    Status VARCHAR(2) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (GradeID) REFERENCES Grade(GradeID)
);
 
-- Create LeaveRequest table with FromDate, ToDate, and TotalDays columns
CREATE TABLE LeaveRequest (
    LeaveRequestID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    LeaveID INT NOT NULL,
    FromDate DATE NOT NULL,
    ToDate DATE NOT NULL,
    TotalDays INT NOT NULL, -- Total number of days for the leave request
    LeaveDate DATE NOT NULL,
    AppliedDate DATE DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Pending' NOT NULL,
    Reason TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (LeaveID) REFERENCES Leave(LeaveID),
    CHECK (Status IN ('Pending', 'Approved', 'Rejected'))
);
 
-- Create Attendance table with IsPending column
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,
    AttendanceDate DATE NOT NULL,
    HoursWorked DECIMAL(5, 2) NOT NULL,
    IsPending BIT NOT NULL DEFAULT 0, -- Indicates if the attendance is pending
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
 
-- Create LeaveBalance table
CREATE TABLE LeaveBalance (
    LeaveBalanceID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    LeaveID INT NOT NULL,
    Balance INT NOT NULL CHECK (Balance >= 0),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (LeaveID) REFERENCES Leave(LeaveID)
);
 
-- Create LeaveHistory table
CREATE TABLE LeaveHistory (
    LeaveHistoryID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    LeaveID INT NOT NULL,
    LeaveDate DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (LeaveID) REFERENCES Leave(LeaveID)
);
 
-- Create LeaveInfo table
CREATE TABLE LeaveInfo (
    LeaveInfoID INT PRIMARY KEY,
    DayOfWeek VARCHAR(20) NOT NULL,
    LeaveDate DATE NOT NULL,
    LeaveTypeID INT NOT NULL,
    HolidayName VARCHAR(100),
    FOREIGN KEY (LeaveTypeID) REFERENCES Leave(LeaveID)
);
