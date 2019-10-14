/* Zach McKee
   CPSC 321
   Homework 6
*/

use zmckee_DB;

DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Border;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS Country;

/* Create table statements */
CREATE TABLE Country(
    country_code VARCHAR(10),
    country_name VARCHAR(100) NOT NULL,
    gdp          INT UNSIGNED NOT NULL,
    inflation    FLOAT NOT NULL,
    PRIMARY KEY (country_code)
);

CREATE TABLE Province(
    province_name VARCHAR(100),
    country_code  VARCHAR(10),
    area          INT UNSIGNED NOT NULL,
    PRIMARY KEY (province_name, country_code),
    FOREIGN KEY (country_code) REFERENCES Country(country_code)
);

CREATE TABLE City(
    city_name       VARCHAR(100),
    province_name   VARCHAR(100),
    country_code    VARCHAR(10),
    population      INT UNSIGNED NOT NULL,
    PRIMARY KEY (city_name, province_name, country_code),
    FOREIGN KEY (province_name, country_code) REFERENCES Province(province_name, country_code)
);

CREATE TABLE Border(
    country_code_1 VARCHAR(10), 
    country_code_2 VARCHAR(10), 
    border_length INT UNSIGNED NOT NULL,
    PRIMARY KEY (country_code_1, country_code_2),
    FOREIGN KEY (country_code_1) REFERENCES Country(country_code),
    FOREIGN KEY (country_code_2) REFERENCES Country(country_code)
);

/* Table population */
INSERT INTO Country VALUES
    ('US', 'United States', 62606, 1.7),
    ('DE', 'Germany', 54983, 1.7),
    ('UK', 'United Kingdom', 46781, 2.0),
    ('CA', 'Canada', 51546, 2.1);

INSERT INTO Province VALUES
    ('Washington', 'US', 184827),
    ('Texas', 'US', 695662),
    ('Bavaria', 'DE', 70552),
    ('Berlin', 'DE', 892),
    ('Greater London', 'UK', 1570),
    ('South East', 'UK', 19100),
    ('British Columbia', 'CA', 944735),
    ('Ontario', 'CA', 1076395);

INSERT INTO City VALUES
    ('Seattle', 'Washington', 'US', 724745),
    ('Spokane', 'Washington', 'US', 217108),
    ('Austin', 'Texas', 'US', 950715),
    ('Houston', 'Texas', 'US', 2313000),
    ('Munich', 'Bavaria', 'DE', 1450000),
    ('Nuremberg', 'Bavaria', 'DE', 515201),
    ('Berlin', 'Berlin', 'DE', 3575000),
    ('London', 'Greater London', 'UK', 81360000),
    ('Dover', 'South East', 'UK', 115803),
    ('Canterbury','South East', 'UK', 43432),
    ('Vancover', 'British Columbia', 'CA', 675218),
    ('Whistler', 'British Columbia', 'CA', 11854),
    ('Dryden', 'Ontario', 'CA', 7749),
    ('Toronto', 'Ontario', 'CA', 2731571);

INSERT INTO Border VALUES
    ('US', 'CA', 8891),
    ('UK', 'US', 2000),
    ('UK', 'DE', 5000);

/* Querys */

/* Q2 */
SET @gdp = 50000;
SET @inf_rate = 3.0;
SET @area = 10000;

SELECT DISTINCT c.country_name, c.country_code, c.gdp, c.inflation
FROM Country c, Province p
WHERE p.country_code = c.country_code
  AND c.gdp >= @gdp
  AND c.inflation <= @inf_rate
  AND p.area <= @area;

/* Q3 */
SELECT DISTINCT c.country_name, c.country_code, c.gdp, c.inflation
FROM Country c JOIN Province p ON c.country_code = p.country_code
WHERE c.gdp >= @gdp
  AND c.inflation <= @inf_rate
  AND p.area <= @area;

/* Q4 */
SELECT p.country_code, co.country_name, p.province_name, c.city_name, c.population, p.area
FROM Province p, Country co, City c
WHERE p.country_code = co.country_code
  AND p.country_code = c.country_code
  AND c.population > 1000;

/* Q5 */
SELECT p.country_code, co.country_name, p.province_name, c.city_name, c.population, p.area
FROM Province p JOIN Country co ON p.country_code = co.country_code
     JOIN City c ON p.country_code = c.country_code
WHERE c.population > 1000;

/* Q6 */
SET @high_gdp = 60000;
SET @low_gdp = 50000;
SELECT SUM(p.area) as TotalArea
FROM Province p JOIN Country c on p.country_code = c.country_code
WHERE c.gdp > @low_gdp
  AND c.gdp < @high_gdp;

/* Q7 */
SELECT DISTINCT MIN(gdp),MAX(gdp),AVG(gdp),MIN(inflation),MAX(inflation),AVG(inflation)
FROM Country;

/* Q8 */
SET @country_code = 'CA';
SELECT COUNT(*), AVG(c.population)
FROM City c
WHERE c.country_code = @country_code;

/* Q9 */
SET @city_name = 'Seattle';
SET @country_code = 'US';
SET @province_name = 'Washington';
SELECT AVG(c.population)
FROM City c
WHERE c.city_name != @city_name
  AND c.country_code = @country_code
  AND c.province_name = @province_name;

/* Q10 */
SET @country_code = 'US';
SELECT COUNT(*), AVG(b.border_length)
FROM Border b
WHERE b.country_code_1 = @country_code 
   OR b.country_code_2 = @country_code;

/* Q11 */
