/*
*********************************************************************
Name: MySQL Sample Database company
Link: https://liveascoder.com/mysql-tutorial/download-mysql-sample-database
MySQL - 5.7.13-log : Database - company
*********************************************************************
*/
SET NAMES utf8;

DROP DATABASE IF EXISTS company;

CREATE DATABASE IF NOT EXISTS company DEFAULT CHARACTER SET utf8;

USE company;

/*Table structure for table branches */

DROP TABLE IF EXISTS branches;

CREATE TABLE branches (
  branchid int(11) NOT NULL,
  city VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  address VARCHAR(100) DEFAULT NULL,
  state VARCHAR(50) NOT NULL,
  country VARCHAR(50) NOT NULL,
  postalcode VARCHAR(15) NOT NULL,
  PRIMARY KEY (branchid)
);

/*Data for the table branches */

INSERT INTO branches(branchid,city,phone,address,state,country,postalcode) VALUES 

/*Table structure for table department */

DROP TABLE IF EXISTS department;

CREATE TABLE department (
  departmentid INT(11) NOT NULL,
  departmentname VARCHAR(50) NOT NULL,
  PRIMARY KEY (departmentid)
);

/*Data for the table department */

INSERT INTO department(departmentid,departmentname) VALUES 

/*Table structure for table employees */

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  employeeid INT(11) NOT NULL,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  dob date NOT NULL,
  email VARCHAR(100) NOT NULL,
  jobtitle VARCHAR(50) NOT NULL,
  salary FLOAT(10,2) DEFAULT NULL,
  reportto INT(11) DEFAULT NULL,
  branchid INT(11) DEFAULT NULL,
  departmentid INT(11) DEFAULT NULL,
  PRIMARY KEY (employeeid),
  KEY emp_branch_FK (branchid),
  KEY emp_department_FK (departmentid),
  CONSTRAINT emp_branch_FK FOREIGN KEY (branchid) REFERENCES branches (branchid),
  CONSTRAINT emp_department_FK FOREIGN KEY (departmentid) REFERENCES department (departmentid)
);

/*Data for the table employees */

INSERT INTO employees(employeeid,firstname,lastname,dob,email,jobtitle,salary,reportto,branchid,departmentid) VALUES 