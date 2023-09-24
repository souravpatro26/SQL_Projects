--SQL Advance Case Study
use Mobile_manufacturer

--Q1--BEGIN 

--1.List all the states in which we have customers who have bought cellphones from 2005 till today.

select state 
from DIM_LOCATION L
inner join fact_transactions T on L.IDLocation =T.IDlocation
inner join dim_model M on T.IDmodel = M.IDmodel
where date between '01-01-2005' and GETDATE()
group by state

--Q1--END

--Q2--BEGIN
	
--2.What state in the US is buying more 'Samsung' cell phones?

select top 1 state 
from DIM_LOCATION L
inner join fact_transactions T on L.IDLocation =T.IDlocation
inner join dim_model M on T.IDmodel = M.IDmodel
inner join dim_manufacturer F on M.IDmanufacturer =F.IDmanufacturer
where manufacturer_name='samsung' and country='US'
group by state
order by sum(quantity) desc

--Q2--END

--Q3--BEGIN      
	
--3.Show the number of transactions for each model per zip code per state.

select Model_name, ZipCode, state , count(IDcustomer) No_of_Transactions
from DIM_LOCATION L
inner join fact_transactions T on L.IDLocation =T.IDlocation
inner join dim_model M on T.IDmodel = M.IDmodel
group by Model_name, ZipCode, state


--Q3--END

--Q4--BEGIN

--4.Show the cheapest cellphone

select top 1 IDmodel,Model_name,Unit_Price from dim_model
order by Unit_Price


--Q4--END

--Q5--BEGIN

--5.Find out the average price for each model in the top5 manufacturers in terms of sales quantity and order by average price.

select Manufacturer_Name,Model_name,Avg(unit_price) Avg_Unit_Price 
from dim_model M
inner join dim_manufacturer F on M.IDmanufacturer =F.IDmanufacturer
where Manufacturer_Name in
(select top 5 Manufacturer_Name
from dim_manufacturer F
inner join dim_model M on M.IDmanufacturer =F.IDmanufacturer
inner join fact_transactions T on T.IDmodel = M.IDmodel
group by Manufacturer_Name
order by sum(quantity))
group by Manufacturer_Name,Model_name
order by Avg(unit_price) desc


--Q5--END

--Q6--BEGIN

--6.List the names of the customers and the average amount spent in 2009, where the average is higher than 500

select Customer_Name,AVG(totalprice) AVG_spent
from DIM_CUSTOMER C
inner join FACT_TRANSACTIONS T on c.IDCustomer=T.IDCustomer
where Year(Date)=2009
group by Customer_Name
having AVG(totalprice)>500


--Q6--END
	
--Q7--BEGIN  
	
--7.List if there is any model that was in the top 5 in terms of quantity,simultaneously in 2008, 2009 and 2010	

select Model_Name,sum(quantity),t.Date
from DIM_MODEL m
inner join FACT_TRANSACTIONS t on m.IDModel=t.IDModel
where Year(date)=2008
group by Model_Name,date
order by sum(quantity) desc

having 
(select top 5 IDModel,sum(quantity) from FACT_TRANSACTIONS where year(date)=2008 group by IDModel order by sum(quantity) desc) and
(select top 5 IDModel,sum(quantity) from FACT_TRANSACTIONS where year(date)=2009 group by IDModel order by sum(quantity) desc) and
(select top 5 IDModel,sum(quantity) from FACT_TRANSACTIONS where year(date)=2010 group by IDModel order by sum(quantity) desc)


--Q7--END	
--Q8--BEGIN

--8.Show the manufacturer with the 2nd top sales in the year of 2009 and the manufacturer with the 2nd top sales in the year of 2010.
SELECT TOP 1 MANUFACTURER_NAME 
FROM DIM_MANUFACTURER T1
INNER JOIN DIM_MODEL T2 ON T1.IDMANUFACTURER= T2.IDMANUFACTURER
INNER JOIN FACT_TRANSACTIONS T3 ON T2.IDMODEL= T3.IDMODEL
GROUP BY MANUFACTURER_NAME
ORDER BY SUM(TOTALPRICE) DESC

--Q8--END
--Q9--BEGIN
--9.Show the manufacturers that sold cellphone in 2010 but didn’t in 2009.

SELECT MANUFACTURER_NAME FROM DIM_MANUFACTURER T1
INNER JOIN DIM_MODEL T2 ON T1.IDMANUFACTURER= T2.IDMANUFACTURER
INNER JOIN FACT_TRANSACTIONS T3 ON T2.IDMODEL= T3.IDMODEL
WHERE YEAR(DATE) = 2010 
EXCEPT 
SELECT MANUFACTURER_NAME FROM DIM_MANUFACTURER T1
INNER JOIN DIM_MODEL T2 ON T1.IDMANUFACTURER= T2.IDMANUFACTURER
INNER JOIN FACT_TRANSACTIONS T3 ON T2.IDMODEL= T3.IDMODEL
WHERE YEAR(DATE) = 2009	

--Q9--END

--Q10--BEGIN
--10.Find top 100 customers and their average spend, average quantity by each year.Also find the percentage of change in their spend.

SELECT TOP 100 CUSTOMER_NAME, 
AVG(CASE WHEN YEAR(DATE) = 2005 THEN TOTALPRICE END) AS AVERAGE_PRICE_2005,
AVG(CASE WHEN YEAR(DATE) = 2005 THEN QUANTITY END) AS AVERAGE_QTY_2005,
AVG(CASE WHEN YEAR(DATE) = 2018 THEN TOTALPRICE END) AS AVERAGE_PRICE_2018,
AVG(CASE WHEN YEAR(DATE) = 2018 THEN QUANTITY END) AS AVERAGE_QTY_2018
FROM DIM_CUSTOMER
INNER JOIN FACT_TRANSACTIONS T1 ON T1.IDCUSTOMER= DIM_CUSTOMER.IDCUSTOMER
GROUP BY CUSTOMER_NAME	

--Q10--END
	