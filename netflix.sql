# Exploratory data analysis.

# First we find out the description of the database. 
SELECT
    table_catalog,
    table_schema,
    table_name
FROM
    `netflix.INFORMATION_SCHEMA.TABLES`

-- Result: 

| table_catalog          | table_schema | table_name |
|------------------------|--------------|------------|
| scaler-dsml-sql-396714 | netflix      | netflix    |

# Then we find out the description of the table and its columns.
SELECT
    table_name,
    column_name,
    ordinal_position,
    is_nullable,
    data_type
FROM
    `netflix.INFORMATION_SCHEMA.COLUMNS`
WHERE
    table_name = 'netflix'

-- Result: 

| table_name | column_name  | ordinal_position | is_nullable | data_type |
|------------|--------------|------------------|-------------|-----------|
| netflix    | show_id      | 1                | YES         | INT64     |
| netflix    | type         | 2                | YES         | STRING    |
| netflix    | title        | 3                | YES         | STRING    |
| netflix    | director     | 4                | YES         | STRING    |
| netflix    | cast         | 5                | YES         | STRING    |
| netflix    | country      | 6                | YES         | STRING    |
| netflix    | date_added   | 7                | YES         | STRING    |
| netflix    | release_year | 8                | YES         | INT64     |
| netflix    | rating       | 9                | YES         | STRING    |
| netflix    | duration     | 10               | YES         | STRING    |
| netflix    | listed_in    | 11               | YES         | STRING    |
| netflix    | description  | 12               | YES         | STRING    |

# Find out the total number of records in the dataset.

SELECT
    COUNT(*) AS number_of_rows
FROM
    `netflix.netflix`

-- Result:

| number_of_rows |
|----------------|
| 6234           |

# Find out how many movies and TV shows are there in the dataset. 

SELECT
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS number_of_movies,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS number_of_tv_shows
FROM
    `netflix.netflix`

-- Result:

| number_of_movies | number_of_tv_shows |
|------------------|--------------------|
| 4265             | 1969               |

# What are the type of ratings for the movies in the dataset and how many are there.

SELECT
    rating,
    COUNT(show_id) AS number_of_movies
FROM
    `netflix.netflix`
WHERE
    type = 'Movie'
    AND rating IS NOT NULL
GROUP BY 1

-- Result:

| rating   | number_of_movies |
|----------|------------------|
| G        | 36               |
| R        | 506              |
| NR       | 202              |
| PG       | 183              |
| UR       | 7                |
| TV-G     | 80               |
| TV-Y     | 41               |
| NC-17    | 2                |
| PG-13    | 286              |
| TV-14    | 1038             |
| TV-MA    | 1348             |
| TV-PG    | 432              |
| TV-Y7    | 69               |
| TV-Y7-FV | 27               |

# Find the top 5 countries where maximum number of TV Shows and Movies were watched.

SELECT
    country,
    COUNT(show_id) AS number_of_shows
FROM
    `netflix.netflix`
WHERE
    country IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Result:

| country        | number_of_shows |
|----------------|-----------------|
| United States  | 2032            |
| India          | 777             |
| United Kingdom | 348             |
| Japan          | 176             |
| Canada         | 141             |

# Who is the most popular director in India.

SELECT
    director,
    COUNT(show_id) AS number_of_total_shows
FROM
    `netflix.netflix`
WHERE
    country = 'India'
    AND director IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Result:

| director          | number_of_total_shows |
|-------------------|-----------------------|
| David Dhawan      | 8                     |
| S.S. Rajamouli    | 7                     |
| Ram Gopal Varma   | 6                     |
| Rajiv Mehra       | 5                     |
| Madhur Bhandarkar | 5                     |

# What are the 5 most popular genres in movies. 

SELECT
    listed_in,
    COUNT(show_id) AS number_of_shows
FROM
    `netflix.netflix`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Result:

| listed_in                                          | number_of_shows |
|----------------------------------------------------|-----------------|
| Documentaries                                      | 299             |
| Stand-Up Comedy                                    | 273             |
| "Dramas, International Movies"                     | 248             |
| "Dramas, Independent Movies, International Movies" | 186             |
| "Comedies, Dramas, International Movies"           | 174             |

# What is the time range in which the dataset is recorded.

SELECT
    MIN(date_added) AS first_date,
    MAX(date_added) AS last_date
FROM
    `netflix.netflix`

-- Result:

| first_date       | last_date           |
|------------------|---------------------|
| " April 1, 2014" | "September 9, 2019" |

# How many shows have only 1 season?

SELECT
    COUNT(DISTINCT title) AS number_of_shows
FROM
    `netflix.netflix`
WHERE
    type = 'TV Show'
    AND duration LIKE '1 Season'

-- Result:

| number_of_shows |
|-----------------|
| 1315            |

