


CREATE TABLE TRANSACTIONS (
tran_id int primary key,
Sec_id varchar (10),
sec_type varchar (10),
trade_px decimal (18, 10),
qty int,
direction varchar (10),
account int,
trd_date date
)

--ALTER TABLE TRANSACTIONS ADD FOREIGN KEY (Sec_id References PRICES (Sec_id)
--Couldn't create Sec_id primary key as its part of Composite key on other tables

CREATE TABLE PRICES (sec_id varchar (10) NOT NULL.
px_dt Date, px decimal (18, 10)
CONSTRAINT pk_prices PRIMARY KEY (Sec_id,px_dt)
)

--Insert into prices
insert into prices values ('El','03/05/2023',63.32)
insert into prices values ('E1','03/06/2023',64.32)
insert into prices values ('B2','03/05/2023',121.3)
insert into prices values ('B4','03/05/2023',205.3)
insert into prices values ('B2','03/05/2023',119)
insert into prices values ('B3','03/05/2023',115.23)
insert into prices values ('B5','03/05/2023',102)
insert into prices values ('El','03/01/2023',68)
insert into prices values ('B1','10/30/2022',101.2)
insert into prices values ('El','11/15/2022',53.2)


--Insert into Transactions
insert into transactions values (8392314, 'El', 'E', 60.32,10, 'B', 456, '03/07/2023') 
insert into transactions values (8392315, 'E2', 'E',20.23,12, 'S' ,457, '03/07/2023') 
insert into transactions values (8392316, 'B1', 'B', 101.23,300, 'B' ,457, '03/09/2023') 
insert into transactions values (8392317, 'B1', 'B', 102.02,400, 'S',456, '03/09/2023') 
insert into transactions values (8392318, 'El', 'E', 62.302,12, 'B', 456, '03/03/2023') 
insert into transactions values (8392319, 'E2'; 'E', 19.19,26, 'S' ,457, '03/08/20231') 
insert into transactions values (8392320, 'B2', 'B', 120.1,1, 'B',458, '03/03/2023')

--1. What are top 5 positions with highest exposure. Display account, sec_id, first trade date, last trade date, total quantity, exposure?
select TOP 5 account, t. Sec_id, min(t.trd_date)As First_Trade_Date, max(t.trd_date) AS Last_Trade_Date,SUM(t.qty) AS Total_Quantity,
ABS(SUM(t.trade_px-(p.px*t.qty))) as Exposure 
from TRANSACTIONS t join PRICES p on t.Sec_id=p.sec_id 
group by account,t.sec_id,p.px_dt
HAVING p.px_dt=MAX(p.px_dt)
order by Exposure desc

--2. Which positions do not have any prices in last 5 days? (Display the same columns as in q1)
--Here I am assuming max px_dt to compare prices in last 5 days as that reference is not provided in question.
select TOP 5 account, t. Sec_id, min(t.trd_date)As First_Trade_Date, max(t.trd_date) AS Last_Trade_Date,SUM(t.qty) AS Total_Quantity,
ABS(SUM(t.trade_px-(p.px*t.qty))) as Exposure
from TRANSACTIONS t join PRICES p on t.Sec_id=p.sec_id 
group by account,t.sec_id,p.px_dt
HAVING p.px_dt<DATEADD(MAX(p.px_dt),-5)
order by Exposure descs




