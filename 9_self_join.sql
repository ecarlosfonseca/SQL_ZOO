/* Exercise 1. How many stops are in the database. */

SELECT COUNT(id)
FROM stops

/* Exercise 2. Find the id value for the stop 'Craiglockhart' */

SELECT id
FROM stops 
WHERE name = 'Craiglockhart'

/* Exercise 3. Give the id and the name for the stops on the '4' 'LRT' service. */

SELECT id, name
FROM stops JOIN route ON stops.id = route.stop
WHERE num = '4' AND company = 'LRT'

/* Exercise 4. The query shown gives the number of routes that visit either London 
Road (149) or Craiglockhart (53). Run the query and notice the two services that link 
these stops have a count of 2. Add a HAVING clause to restrict the output to these two 
routes. */

SELECT company, num, COUNT(*)
FROM route WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING COUNT(*) = 2

/* Exercise 5. Execute the self join shown and observe that b.stop gives all the places 
you can get to from Craiglockhart, without changing routes. Change the query so that it 
shows the services from Craiglockhart to London Road. */

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53 AND b.stop = 
    (SELECT id 
    FROM stops 
    WHERE name = 'London Road')

/* Exercise 6. The query shown is similar to the previous one, however by joining two 
copies of the stops table we can refer to stops by name rather than by number. Change 
the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
If you are tired of these places try 'Fairmilehead' against 'Tollcross' */

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
             JOIN stops stopa ON a.stop = stopa.id
             JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart' AND stopb.name =  'London Road' 

/* Exercise 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') */

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = '115' AND b.stop = '137'

/* Exercise 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' */

SELECT a.company, a.num 
FROM route a JOIN route b ON (a.company=b.company AND a.num = b.num)
             JOIN stops stopa ON a.stop = stopa.id
             JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart' AND stopb.name =  'Tollcross'

/* Exercise 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking 
one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. 
of the relevant services. */

SELECT DISTINCT bstop.name, a.company, a.num 
FROM route AS a JOIN route AS b ON (a.company = b.company AND a.num = b.num)
			    JOIN stops AS astop ON a.stop = astop.id
			    JOIN stops AS bstop ON b.stop = bstop.id
WHERE astop.name = 'Craiglockhart'

/* Exercise 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus. */

SELECT a.num, a.company, stops.name, c.num, c.company
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
             JOIN stops ON stops.id = a.stop
             JOIN route c ON stops.id = c.stop
             JOIN route d ON (c.company = d.company AND c.num = d.num)
WHERE b.stop = 
    (select id 
    FROM stops 
    WHERE name = 'Craiglockhart')
AND d.stop = 
    (select id 
    FROM stops 
    WHERE name = 'Lochend')
