/* Exercise 1. List the films where the yr is 1962 [Show id, title] */

SELECT id, title
FROM movie
WHERE yr=1962

/* Exercise 2. Give year of 'Citizen Kane'. */

SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

/* Exercise 3. List all of the Star Trek movies, include the id, title and yr (all of these movies 
include the words Star Trek in the title). Order results by year. */

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

/* Exercise 4. What id number does the actor 'Glenn Close' have? */

SELECT id
FROM actor
WHERE name = 'Glenn Close'

/* Exercise 5. What is the id of the film 'Casablanca' */

SELECT id
FROM movie
WHERE title = 'Casablanca'

/* Exercise 6. Obtain the cast list for 'Casablanca'.

Use movieid=11768, (or whatever value you got from the previous question) */

SELECT actor.name
FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid
WHERE title = 'Casablanca'

/* Exercise 7. What is the id of the film 'Casablanca' */

SELECT actor.name
FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid
WHERE title = 'Alien'

/* Exercise 8. List the films in which 'Harrison Ford' has appeared */

SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'

/* Exercise 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in 
the starring role] */

SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford' AND casting.ord <> 1

/* Exercise 10. List the films together with the leading star for all 1962 films. */

SELECT title, name
FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962 AND casting.ord = 1

/* Exercise 11. Which were the busiest years for 'Rock Hudson', show the year and the number of 
movies he made each year for any year in which he made more than 2 movies. */

SELECT yr,COUNT(title) FROM movie JOIN casting ON movie.id = casting.movieid 
                                  JOIN actor   ON casting.actorid = actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

/* Exercise 12. List the film title and the leading actor for all of the films 'Julie Andrews' 
played in. */

SELECT title, name
FROM movie JOIN casting on movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid
WHERE movieid IN
    (SELECT movieid 
    FROM casting
    WHERE actorid IN 
        (SELECT id 
        FROM actor
        WHERE name='Julie Andrews'))
    AND casting.ord = 1

/* Exercise 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. */

SELECT name
FROM actor
JOIN casting ON (id = actorid AND 
                        (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1) >= 15)
GROUP BY name

/* Exercise 14. List the films released in the year 1978 ordered by the number of actors in the cast, then 
by title. */

SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC, title

/* Exercise 15. List all the people who have worked with 'Art Garfunkel'. */

SELECT DISTINCT name
FROM casting JOIN actor ON actor.id = casting.actorid
WHERE movieid IN 
    (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) 
    AND name != 'Art Garfunkel'
