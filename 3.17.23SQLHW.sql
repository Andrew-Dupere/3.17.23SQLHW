--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating

CREATE OR REPLACE PROCEDURE addfilm(title varchar,description varchar, RELEASE_year integer, 
LANGUAGE_id integer, rental_duration integer, rental_rate NUMERIC(5,2), "length" integer,
replacement_cost NUMERIC (5,2), rating mpaa_rating) 
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO film(title, description, RELEASE_year,  
	LANGUAGE_id, rental_duration, rental_rate, "length",
	replacement_cost, rating)
	VALUES (title, description, RELEASE_year,  
	LANGUAGE_id, rental_duration, rental_rate, "length",
	replacement_cost, rating);
END;
$$;


CALL addfilm('bigtitle','descriptionhere',2007,1,4,4.99,3,3.99,'NC-17');


SELECT * 
FROM film
WHERE title = 'bigtitle';



--2. Create a Stored Function that will take in a category_id and return the number of
--films in that category

SELECT category_id, count(film_id)
FROM film_category
GROUP BY category_id
HAVING category_id = 9;


CREATE OR REPLACE FUNCTION filmspercategory(categoryid integer)
RETURNS integer 
LANGUAGE plpgsql
AS $$
	DECLARE counts integer;
BEGIN
	SELECT count(film_id) INTO counts
	FROM film_category
	GROUP BY category_id
	HAVING category_id = categoryid;
	RETURN counts;
END;
$$;

SELECT filmspercategory(9);



