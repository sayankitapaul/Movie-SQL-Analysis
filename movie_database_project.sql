-- DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255),
    genre VARCHAR(100),
    director VARCHAR(255),
    release_year INT,
    rating DECIMAL(3,1),
    revenue_million DECIMAL(10,2)
);

INSERT INTO movies (movie_id, title, genre, director, release_year, rating, revenue_million)
VALUES
(1, 'Inception', 'Sci-Fi', 'Christopher Nolan', 2010, 8.8, 829.89),
(2, 'Interstellar', 'Sci-Fi', 'Christopher Nolan', 2014, 8.7, 701.80),
(3, 'The Dark Knight', 'Action', 'Christopher Nolan', 2008, 9.0, 1004.90),
(4, 'Titanic', 'Romance', 'James Cameron', 1997, 7.9, 2247.00),
(5, 'Avatar', 'Sci-Fi', 'James Cameron', 2009, 7.8, 2923.70),
(6, 'Joker', 'Drama', 'Todd Phillips', 2019, 8.4, 1074.40),
(7, 'Barbie', 'Comedy', 'Greta Gerwig', 2023, 7.2, 1445.60),
(8, 'Oppenheimer', 'Biography', 'Christopher Nolan', 2023, 8.5, 975.80),
(9, 'Dune', 'Sci-Fi', 'Denis Villeneuve', 2021, 8.1, 402.00),
(10, 'Top Gun: Maverick', 'Action', 'Joseph Kosinski', 2022, 8.3, 1495.70),
(11, 'The Batman', 'Action', 'Matt Reeves', 2022, 7.9, 770.80),
(12, 'Guardians of the Galaxy Vol. 3', 'Sci-Fi', 'James Gunn', 2023, 8.0, 845.60),
(13, 'Avengers: Endgame', 'Action', 'Anthony Russo', 2019, 8.4, 2797.50),
(14, 'Black Panther', 'Action', 'Ryan Coogler', 2018, 7.3, 1347.10),
(15, 'The Shawshank Redemption', 'Drama', 'Frank Darabont', 1994, 9.3, 58.30);

-- 1. View all movies
SELECT * FROM movies;

-- 2. Top rated movies
SELECT title, rating
FROM movies
ORDER BY rating DESC;

-- 3. Highest revenue movies
SELECT title, revenue_million
FROM movies
ORDER BY revenue_million DESC;

-- 4. Revenue by genre
SELECT genre,
       SUM(revenue_million) AS total_revenue
FROM movies
GROUP BY genre
ORDER BY total_revenue DESC;

-- 5. Average rating by genre
SELECT genre,
       ROUND(AVG(rating),2) AS average_rating
FROM movies
GROUP BY genre
ORDER BY average_rating DESC;

-- 6. Director with most movies
SELECT director,
       COUNT(*) AS movie_count
FROM movies
GROUP BY director
ORDER BY movie_count DESC;

-- 7. Movies released after 2015
SELECT *
FROM movies
WHERE release_year > 2015;

-- 8. Movies with rating above average
SELECT title, rating
FROM movies
WHERE rating >
(
    SELECT AVG(rating)
    FROM movies
);

-- 9. Rank movies by rating
SELECT
    title,
    rating,
    RANK() OVER(ORDER BY rating DESC) AS movie_rank
FROM movies;

-- 10. Dense rank by revenue
SELECT
    title,
    revenue_million,
    DENSE_RANK() OVER(ORDER BY revenue_million DESC) AS revenue_rank
FROM movies;

-- 11. Row number by release year
SELECT
    title,
    release_year,
    ROW_NUMBER() OVER(ORDER BY release_year DESC) AS row_num
FROM movies;

-- 12. Average revenue by director
SELECT
    director,
    ROUND(AVG(revenue_million),2) AS avg_revenue
FROM movies
GROUP BY director
ORDER BY avg_revenue DESC;

-- 13. Top movie in each genre
WITH ranked_movies AS
(
    SELECT *,
           RANK() OVER(PARTITION BY genre ORDER BY rating DESC) AS rnk
    FROM movies
)
SELECT *
FROM ranked_movies
WHERE rnk = 1;

-- 14. Total movies by year
SELECT
    release_year,
    COUNT(*) AS total_movies
FROM movies
GROUP BY release_year
ORDER BY release_year;

-- 15. Create a view
CREATE OR REPLACE VIEW high_rated_movies AS
SELECT *
FROM movies
WHERE rating >= 8.5;

-- View results
SELECT * FROM high_rated_movies;