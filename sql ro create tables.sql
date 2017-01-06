//auto increment
create table Author
(
	ID integer,
	Name varchar(100) constraint "Author_Name_CHK_NL"  not null,
	Gender char(1) constraint "Author_Gender_CHK_NL"  not null,
	Qualification varchar(50),
	constraint "Author_Gender_CHK" check (Gender in ('M', 'F')),
	constraint "Author_ID_PK" primary key (ID)
);

CREATE TABLE  "PUBLISHER" 
(	"ID" integer, 
	"NAME" VARCHAR2(100) CONSTRAINT "Publisher_Name_CHK_NL" NOT NULL ENABLE, 
	"CITY" VARCHAR2(50), 
	"ZIP" VARCHAR2(5), 
	CONSTRAINT "Publisher_ID_PK" PRIMARY KEY ("ID") ENABLE, 
	CONSTRAINT "Publisher_Zip_CHK" CHECK ( "ZIP" like '_____') ENABLE
);


create table Customer
(
	ID integer,
	Name varchar(100)  constraint "Customer_Name_CHK_NL"  not null,
	Email varchar(100),
	Phone varchar(11),
	City varchar(50),
	Zip varchar(4),
	constraint "Customer_Zip_CHK" check (Zip like '_____'),
	constraint "Customer_Phone_CHK" check (Phone like '0%'),
	constraint "Customer_Phone_UK" unique (Phone),
	constraint "Customer_Email_CHK" check (Email like '%@%.%'),
	constraint "Customer_ID_PK" primary key (ID)
);

create table Branch
(
	ID varchar(3),
	Street varchar(50),
	City varchar(50) constraint "Branch_City_CHK_NL" not null,
	constraint "Branch_ID_PK" primary key (ID),
	constraint "Branch_ID_CHK" check (ID like '___')
);

create table Employee
(
	ID integer,
	Branch_ID varchar(3) constraint "Employee_Br_ID_CHK" not null,
	Salary numeric(10, 2),
	Name varchar(100) constraint "Employee_Dt_Name_CHK_NL"  not null,
	Gender char(1) constraint "Employee_Dt_Gender_CHK_NL"  not null,
	Phone varchar(11) constraint "Employee_Dt_Phone_CHK_NL"  not null,
	City varchar(50) constraint "Employee_Dt_City_CHK_NL" not null,
	Street varchar(50),
	constraint "Employee_Salary_CHK" check (Salary >= 2000),
	constraint "Employee_Branch_ID_FK" foreign key (Branch_ID)
		references Branch(ID) on delete cascade,
	constraint "Employee_Phone_CHK" check (Phone like '0%'),
	constraint "Employee_Phone_UK" unique (Phone),
	constraint "Employee_ID_PK" primary key (ID)
);

create table Books
(
	ID integer,
	Name varchar(100),
	ISBN varchar(30) constraint "Books_ISBN_CHK1" not null,
	Author_ID numeric(10),
	Publisher_ID numeric(10),
	No_of_Books numeric(10, 0),
	constraint "Books_No_Of_Bks_CHK2" check (No_of_Books >= 0),
	constraint "Books_ISBN_CHK" check (ISBN like '%-%-%-%'),
	constraint "Books_ISBN_UK" unique (ISBN),
	constraint "Books_Author_ID_FK" foreign key (Author_ID) 
		references Author(ID) on delete set null,
	constraint "Books_Publish_ID_FK" foreign key (Publisher_ID)
		references Publisher(ID) on delete set null,
	constraint "Books_ID_PK" primary key (ID)
);

create table Issue
(
	Customer_ID integer constraint "Issue_Cust_ID_CHK" not null,
	Book_ID integer constraint "Issue_BK_ID_CHK" not null,
	Branch_ID varchar(3) constraint "Issue_Br_ID_CHK" not null,
	Employee_ID integer constraint "Emp_ID_CHK" not null,
	Issue_Date date,
	Return_Date date,
	constraint "Issue_Cust_ID_FK" foreign key (Customer_ID)
		references Customer(ID),
	constraint "Issue_Book_ID_FK" foreign key (Book_ID)
		references Books(ID),
	constraint "Issue_Branch_ID_FK" foreign key (Branch_ID)
		references Branch(ID),
	constraint "Issue_Emp_ID_FK" foreign key (Employee_ID)
		references Employee(ID),
	constraint "Issue_PK" primary key (Customer_ID, Book_ID)
);