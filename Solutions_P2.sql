select * from branch;
select * from books;
select * from employees;
select * from issued_status;
select * from return_status;
select * from members;

-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books (isbn, book_title, category, rental_price, status, author, publisher)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Task 2: Update an Existing Member's Address

update members
set member_address = '125 Main St'
where member_id = 'c101';

-- Task 3: Delete a Record from the Issued Status Table
 -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
 
 delete from issued_status
 where issued_id = 'is121';
 
 -- Task 4: Retrieve All Books Issued by a Specific Employee
 -- Objective: Select all books issued by the employee with emp_id = 'E101'.
 
select * from issued_status
where issued_emp_id = 'e101';

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

select issued_emp_id, count(issued_id) from issued_status
group by 1
having count(issued_id) >1;

-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

create table book_cnts
as
select isbn, b.book_title, count(ist.issued_book_isbn)
from issued_status ist
join
books b on b.isbn = ist.issued_book_isbn
group by 1,2
order by 3 desc;

select *from book_cnts;

-- Task 7. Retrieve All Books in a Specific Category

select * from books
where category = 'fantasy';

-- Task 8: Find Total Rental Income by Category:
 
 select category, sum(rental_price) total_rent, count(*)
 from issued_status ist
join
books b on b.isbn = ist.issued_book_isbn
 group by 1
 order by 3 desc;
 
 -- Task 9: List Members Who Registered in the Last 180 Days:
select * from members
where reg_date >= current_date - '180 days';

insert into members values
('c120', 'sam', '145 Main street', '2025-07-01'),
('c121', 'Michel', '156 Main street', '2025-06-01');

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:

select e1.*,b.manager_id ,e2.emp_name as manager_name
 from employees e1
 join 
 branch b on e1.branch_id = b.branch_id
 join
 employees e2 on e2.emp_id = b.manager_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD

drop table if exists books_seven;
create table books_seven
as
select * from books
where rental_price > 7;

select * from books_seven;

-- Task 12: Retrieve the List of Books Not Yet Returned

select distinct ist.issued_book_name
 from issued_status ist
 left join return_status rst
 on ist.issued_id = rst.issued_id
where rst.return_id is null;

/*
Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.
*/

select 
ist.issued_member_id, m.member_name, b.book_title, ist.issued_date, current_date - ist.issued_date over_due_days
 from members m
 join 
issued_status ist on 
ist.issued_member_id = m.member_id
join 
books b on b.isbn = ist.issued_book_isbn
left join
return_status rs on rs.issued_id = ist.issued_id
where 
rs.return_date is null
and
 (current_date - ist.issued_date) > 30
order by 1;

  /*
  Task 14: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/

select * from branch;

select * from books;

select * from return_status;
create table Branch_report
as
select b.branch_id, b.manager_id,
 count(ist.issued_id) number_books_issued, 
 count(rst.return_id) number_books_retured, 
 sum(bk.rental_price) total_revenue
from issued_status ist
join employees e on e.emp_id = ist.issued_emp_id
join branch b on b.branch_id = e.branch_id
left join return_status rst on rst.issued_id = ist.issued_id
join books bk on bk.isbn = ist.issued_book_isbn
group by 1, 2;

select * from branch_report;

/*
Task 15: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 3 months.
*/

drop table  if exists active_members;
create table active_members
as
select * from members
where member_id in (
select issued_member_id 
from issued_status 
where issued_date >= date_sub(current_date, interval 30 day)
);

select * from active_members;

/*
Task 16: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
*/

select e.emp_name, count(ist.issued_book_isbn) no_of_books, b.branch_id
 from issued_status ist
 join employees e on e.emp_id = ist.issued_emp_id
 join branch b on b.branch_id = e.branch_id
 group by 1,3
 order by 2 desc
 limit 3;
 


        
        
        
        
        
        




