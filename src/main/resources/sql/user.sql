DROP TABLE USER_TBL;

create table USER_TBL
(
	usrid varchar2(20) primary key,
	usrname varchar2(20) not null,
	usrphone varchar2(50)
);

insert into user_tbl
	(usrid, usrname, usrphone) 
values 
	('uid001', '유저1','111-1111');
	
commit;