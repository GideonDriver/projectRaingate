# P.1 Raingate

## Project Description

Do you need a web-based application for your employees to make reimbursement requests? It can be difficult to manage these requests, but Raingate has you covered! It's easy for employees to create an account, send in requests and view their ongoing/resolved requests. And managers can easily view and deal with those requests.

## Technologies Used

* Java 1.8
* Servlets
* JDBC
* SQL
* PL/SQL
* HTML/CSS
* Bootstrap
* JavaScript
* AJAX
* JUnit
* Log4j

## Features

An Employee can: 
* Login. 
* View the employee home page. 
* Logout. 
* Submit a reimbursement request. 
* View their pending reimbursement requests. 
* View their resolved reimbursement requests. 
* View their information. 
* Update their information. 

A Manager can: 
* Login. 
* View the manager home page. 
* Logout. 
* Approve/Deny pending reimbursement requests. 
* View all pending requests of all employees. 
* View all resolved requests of all employees. 
* View reimbursement requests of a specific employee. 
* View all employees.

## Getting Started
   
1. Run git clone command in terminal: git clone https://github.com/GideonDriver/raingate
2. Update db.properties file with you PostgreSQL username & password
3. Run the two create table commands (available in Postgresql Commands.txt) in your database administration tool (I used DBeaver 22.0.0)
4. There are also example users you can add in the Postgresql Commands.txt file, modify one of these and run it to create a manager account.
