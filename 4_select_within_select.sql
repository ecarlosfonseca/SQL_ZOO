/* Exercise 1. List each country name where the population is larger than that of 'Russia'. */
SELECT name 
FROM world
WHERE population >
    (SELECT population 
    FROM world
    WHERE name='Russia')

/* Exercise 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */

SELECT name 
FROM world
WHERE gdp/population > 
    (SELECT gdp/population 
    FROM world 
    WHERE name = 'United Kingdom') 
    AND continent = 'Europe'

/* Exercise 3. List the name and continent of countries in the continents containing either Argentina 
or Australia. Order by name of the country. */

SELECT name, continent
FROM world
WHERE continent IN 
    (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))

/* Exercise 4. Which country has a population that is more than Canada but less than Poland? 
Show the name and the population. */

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland')

/* Exercise 5. Germany (population 80 million) has the largest population of the countries in Europe. 
Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of
the population of Germany.

The format should be Name. */

SELECT name, 
       CONCAT(ROUND(100 * population / (SELECT population FROM world WHERE name = 'Germany'),0), '%')
FROM world
WHERE continent = 'Europe'

/* Exercise 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] 
(Some countries may have NULL gdp values) */

SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp) from world WHERE continent = 'Europe')

/* Exercise 7. Find the largest country (by area) in each continent, show the continent, the name 
and the area: */

SELECT continent, name, area 
FROM world x
WHERE area >= ALL
    (SELECT area 
    FROM world y
    WHERE y.continent=x.continent
    AND area>0)

/* Exercise 8. List each continent and the name of the country that comes first alphabetically. */

Select  x.continent, x.name
From world x
Where x.name <= ALL (select y.name from world y where x.continent=y.continent)

/* Exercise 9. Find the continents where all countries have a population <= 25000000. Then find the 
names of the countries associated with these continents. Show name, continent and population. */

SELECT name, continent, population
from world
WHERE continent NOT IN 
    (SELECT DISTINCT(continent) FROM world WHERE population > 25000000)

/* Exercise 10. Some countries have populations more than three times that of any of their neighbours 
(in the same continent). Give the countries and continents. */

SELECT x.name, x.continent
FROM world x
WHERE x.population >ALL
    (SELECT population * 3
    FROM world y
    WHERE y.continent = x.continent
    AND x.name<>y.name)

