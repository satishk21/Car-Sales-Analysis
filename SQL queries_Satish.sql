use SQL_Project

Select * from Cars;
Alter table models
alter column model_ID INT;

Alter table fueltype
alter column fuel_ID INT;

Alter table transmission
alter column ID INT;

Alter table cclass
alter column ID INT;

Alter table cclass
alter column model_ID INT;

Alter table cclass
alter column year INT;

Alter table cclass
alter column price INT;

Alter table cclass
alter column mileage INT;

Alter table cclass
alter column engineSize float;

Alter table cclass
alter column transmission_ID INT;

Alter table cclass
alter column fuel_ID INT;


Select * from fueltype;

CREATE VIEW f_added
AS
Select ID, model_ID, year, price, mileage, tax, mpg, engineSize, transmission_ID, fuel_ID,Brand, fueltype from Cars
LEFT JOIN fueltype
ON Cars.fuel_ID = fueltype.f_ID;


Select * from f_added;

Select * from transmission;

CREATE VIEW f_T_added
AS
Select a.*, tr.transmission from f_added as a
LEFT JOIN transmission as tr
ON a.transmission_ID = tr.t_ID;

Select * from f_T_added;

CREATE VIEW f_T_M_added
AS
Select b.*, md.model_name from f_T_added as b
LEFT JOIN models as md
ON b.model_ID = md.m_ID;

Select * from f_T_M_added;

Select min(price) as Min_price, Max(price) as Max_price from f_T_M_added;



CREATE VIEW f_T_M_class_added
AS
Select *, 
case
when price BETWEEN 650 AND 60000
Then('LOW')
when price BETWEEN 60001 AND 130000
Then ('MEDIUM')
when price BETWEEN 130001 AND 160000
Then('HIGH')
end as income_class from f_T_M_added;

SELECT Brand,year, RANK() OVER(ORDER BY Count(Brand) DESC) AS Top_Brand FROM f_T_M_class_added
where year= 2014
group by Brand,year;

Select * from f_T_M_class_added;

CREATE VIEW Brand_wise
AS
SELECT year,
SUM(CASE WHEN Brand = 'Audi' THEN price END) AS 'Audi',
SUM(CASE WHEN Brand = 'BMW' THEN price END) AS 'BMW',
SUM(CASE WHEN Brand = 'Mercedes' THEN price END) AS 'Mercedes',
SUM(CASE WHEN Brand = 'Hyundai' THEN price END) AS 'Hyundai'
FROM f_T_M_class_added
GROUP BY year;


