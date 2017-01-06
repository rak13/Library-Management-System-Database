--1. Details of THOSE customers WITH GRAMEEN PHONE SIM and live in chittagong
select *
from customer
where phone like '017%' and lower(city) = 'chittagong'

--2. names, id and phone numbers of those employees who work in a branch present in dhaka city ordered
--descending name
select A.ID, A.NAME, A.PHONE
from EMPLOYEE A, BRANCH B
where A.BRANCH_ID = B.ID and LOWER(B.CITY) = 'dhaka'
order by A.NAME desc

--3. number of books issued by those employees who have salary greater than 4000
select  A.Employee_ID, count((A.BOOK_ID))
from ISSUE A
group by A.Employee_ID
having A.Employee_ID in (
 select B.ID
 from Employee B
 where B.salary > 5000
)

--5. details of all customer's who have issued a book and other information of the books and it's issue and return date
select customer_ID, customer.name "Customer Name", book_ID, books.name "book name", 
author.name "Author Name", Issue.issue_date, Issue.Return_date
from ((issue inner join customer 
on customer_ID = customer.id) inner join books on book_ID = Books.id) 
inner join author on books.author_id = author.ID
order by customer.ID

-- 6. those bookID issued between '1-jan-2014' to '31-dec-2014'
select distinct(book_ID)
from ISSUE
where issue_date between '1-jan-2014' and '31-dec-2014'
order by book_id

--7. those employees whose salary > avg(salary)
select ID, name, salary
from employee
where salary > (
 select avg(salary)
 from employee
) 

--8. ID and name of books that were issued and have a publisher name that starts with 'MC'
select Book_ID, books.name
from issue inner join books on issue.Book_id = Books.id
where Book_ID in (
 select B.ID
 from Books B, Publisher
 where B.Publisher_ID = Publisher.ID and upper(Publisher.name) like (upper('Mc%'))
)

--9. Number of different books issued
select count(distinct(Book_ID))
from issue

--10. Branch ID and City name of thos Braches whose avg(salary) > the salary of atleast one female employee
select B.ID, B.city
from branch B inner join Employee E on B.ID = E.Branch_ID
group by B.ID, B.city
having avg(salary) > some(
  select salary
  from Employee Y
  where Y.Gender = 'F'
)

--11. Branch ID and City name of thos Braches whose avg(salary) > the salary all female employees
select B.ID, B.city
from branch B inner join Employee E on B.ID = E.Branch_ID
group by B.ID, B.city
having avg(salary) > all(
  select salary
  from Employee Y
  where Y.Gender = 'F'
)

--12. 1st check if no book with book_ID = 25 has been issued 
--and then show details of all issues involved with customer_ID =e code korte hob 1
select *
from issue
where not exists
(
 select *
 from issue 
 where book_id = 25
) and customer_ID = 1

--13. Information about those boooks that have "l" in it's name and whose no of books is not 0
select *
from books A
where lower(A.name) like '%l%' and exists
(
 select *
 from books B
 where A.name = B.name and no_of_books <> 0
) 
--14. union
select city from branch
union
select city from employee_details 

--14. update
update employee
set salary = salary+1000
where salary < (
	select avg(salary)
	from employee
)
--15. delete
delete from books
where ID > 15 and ID not in (
	select BOOK_ID
	from issue
)

--16. left join
select employee.name, branch.city 
from BRANCH left join employee 
on employee.city = branch.city