-- Library management system project 2
create database library_project_p2;

-- creating branch table
drop table if exists branch;
create table branch (
branch_id varchar(10)  primary key,
	manager_id varchar(10),
	branch_address varchar(50),
	contact_no varchar(10)
       );
       
alter table branch
modify column contact_no  varchar(20);
-- creating employee table

drop table if exists employees;
create table employees (
emp_id varchar(10) primary key,
	emp_name varchar(20),
    position  varchar(15),
	salary float,
	branch_id  varchar(10) -- FK
);

drop table if exists books;
create table books(
     isbn varchar(20) primary key,
     book_title varchar(70), 
     category varchar(20),
     rental_price float,
     status varchar(15),
     author varchar(25),
     publisher varchar(40)
     );
     
     drop table if exists members;
     create table members (
     member_id varchar(10) primary key,
     member_name varchar(20),
     member_address varchar(20),
     reg_date date
);
     
	drop table if exists return_status;
     create table return_status (
     return_id varchar(10) primary key,
     issued_id varchar(10),  -- FK
     return_book_name varchar(75),
     return_date date,
     return_book_isbn varchar(20)
);
     
	drop table if exists issued_status;
     create table issued_status(
     issued_id  varchar(10) primary key,
     issued_member_id varchar(10), -- FK
     issued_book_name varchar(70), 
     issued_date date,
     issued_book_isbn varchar(25), -- FK
     issued_emp_id varchar(10) -- FK
);
     
-- Forgein key
alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);

alter table issued_status
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);

alter table employees
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);

alter table return_status
add constraint fk_issued_status
foreign key (issued_id)
references issued_status(issued_id);

-- -- Project TASK


-- ### 2. CRUD Operations


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

-- Task 2: Update an Existing Member's Address


-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS104' from the issued_status table.

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.


-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.


-- ### 3. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt


-- ### 4. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:


-- Task 8: Find Total Rental Income by Category:


-- Task 9. **List Members Who Registered in the Last 180 Days**:

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

-- Task 12: Retrieve the List of Books Not Yet Returned

    
/*
### Advanced SQL Operations

Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.


Task 14: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.


Task 15: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 6 months.



Task 16: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.





     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     