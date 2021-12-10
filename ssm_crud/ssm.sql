CREATE DATABASE ssm_crud;
USE ssm_crud;
CREATE TABLE `tbl_dept` (
	`dept_id` INT (5) PRIMARY KEY AUTO_INCREMENT NOT NULL KEY AUTO_INCREMENT, 
	`dept_name` VARCHAR (666) NOT NULL
);
CREATE TABLE `tbl_emp` (
	`emp_id` INT (5) PRIMARY KEY AUTO_INCREMENT NOT NULL  KEY AUTO_INCREMENT,
	`emp_name` VARCHAR (225) NOT NULL,
	`gender` CHAR (8),
	`email` VARCHAR (30),
	`d_id` INT (5) ,
	FOREIGN KEY(d_id) REFERENCES tbl_dept(dept_id)
);


INSERT INTO `tbl_dept` (`dept_id`, `dept_name`) VALUES('1','研发部');
INSERT INTO `tbl_dept` (`dept_id`, `dept_name`) VALUES('2','测试部');
INSERT INTO `tbl_dept` (`dept_id`, `dept_name`) VALUES('3','运维部');
INSERT INTO `tbl_dept` (`dept_id`, `dept_name`) VALUES('4','财务部');
INSERT INTO `tbl_dept` (`dept_id`, `dept_name`) VALUES('5','市场部');
INSERT INTO `tbl_dept` (`dept_id`, `dept_name`) VALUES('6','后勤部');



INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('1','小白','G','xb@163.com','3');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('2','小蔡','M','xc@163.com','1');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('3','小李','M','xl@163.com','2');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('4','小褚','G','xz@163.com','1');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('5','小冯','M','xf@163.com','4');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('6','小高','G','xg@163.com','3');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('7','小敏','M','xm@163.com','4');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('8','小王','M','xw@163.com','6');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('9','小袁','G','xy@163.com','2');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('10','小辉','M','xh@163.com','3');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('11','小苏','M','xs@163.com','5');
INSERT INTO `tbl_emp` (`emp_id`, `emp_name`, `gender`, `email`, `d_id`) VALUES('12','小帆','G','xf@163.com','2');