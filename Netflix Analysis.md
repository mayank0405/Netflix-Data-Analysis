# Netflix Movies and TV Shows Analysis 

## Context 
- This extensive dataset provides a rich repository on TV Shows and Movies on Netflix in Various Countries.
- The dataset for the following project can be found [here](https://www.kaggle.com/datasets/victorsoeiro/netflix-tv-shows-and-movies/data).

**_Since the dataset is huge, the results are also very large so for convenience we choose to show only a limited number of records in our queries and results._**

We have only used SQL for this project and on **Google BigQuery** platform.

**Author**: Mayank Singh

**Email**: mayanksingholive@gmail.com

**LinkedIn**: https://www.linkedin.com/in/mayank-singh-a71110156/ 

#### :pushpin: First we find out the description of the database.
````sql
SELECT
    table_catalog,
    table_schema,
    table_name
FROM
    `netflix.INFORMATION_SCHEMA.TABLES`;
````

**_Results_**

| table_catalog          | table_schema | table_name |
|------------------------|--------------|------------|
| scaler-dsml-sql-396714 | netflix      | netflix    |

❗ **Insight-** We use _INFORMATION_SCHEMA.TABLES_ to find out the tables present in the dataset. 

####  :pushpin: Then we find out the description of the table and its columns.
````sql
SELECT
    table_name,
    column_name,
    ordinal_position,
    is_nullable,
    data_type
FROM
    `netflix.INFORMATION_SCHEMA.COLUMNS`
WHERE
    table_name = 'netflix';
````

**_Results_**

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

❗ **Insight-** We use _INFORMATION_SCHEMA.COLUMNS_ to find the columns, their data types and other important attributes.

#### :pushpin: Find out the total number of records in the dataset.

````sql
SELECT
    COUNT(*) AS number_of_rows
FROM
    `netflix.netflix`;
````

**_Results_** 

| number_of_rows |
|----------------|
| 6234           |

❗ **Insight-** In order to find out the number of records in the dataset, we use **Count()** to count number of rows in the dataset.  

#### :pushpin: Find out how many movies and TV shows are there in the dataset.

````sql
SELECT
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS number_of_movies,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS number_of_tv_shows
FROM
    `netflix.netflix`;
````

**_Results_**

| number_of_movies | number_of_tv_shows |
|------------------|--------------------|
| 4265             | 1969               |

❗ **Insight-** We use the case function to first which records are movies and which are tv shows and then do a sum over them. For this we use **case** and **SUM()**. 

#### :pushpin: What are the type of ratings for the movies in the dataset and how many are there.

````sql
SELECT
    rating,
    COUNT(show_id) AS number_of_movies
FROM
    `netflix.netflix`
WHERE
    type = 'Movie'
    AND rating IS NOT NULL
GROUP BY 1;
````

**_Results_**

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

❗ **Insight-** In order to find the number of records for each rating, we use **count** and then **group by**. This  is because we are using non aggregated column with aggregated column.

#### :pushpin: Find the top 5 countries where maximum number of TV Shows and Movies were watched.

````sql
SELECT
    country,
    COUNT(show_id) AS number_of_shows
FROM
    `netflix.netflix`
WHERE
    country IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
````

**_Results_**

| country        | number_of_shows |
|----------------|-----------------|
| United States  | 2032            |
| India          | 777             |
| United Kingdom | 348             |
| Japan          | 176             |
| Canada         | 141             |

❗ **Insight-** For the top 5 countries we show country, **count** to count number of records and then we **group by country**. In the end we use **order by 2 desc** to order by second column in descending order to get greatest number of shows and then use **limit 5** to show only 5 records  

#### :pushpin: Who is the most popular director in India.

````sql
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
LIMIT 5;
````

**_Results_**

| director          | number_of_total_shows |
|-------------------|-----------------------|
| David Dhawan      | 8                     |
| S.S. Rajamouli    | 7                     |
| Ram Gopal Varma   | 6                     |
| Rajiv Mehra       | 5                     |
| Madhur Bhandarkar | 5                     |

❗ **Insight-** We use **where** for the country India and then find director and their total number of shows and use the same principle for ordering and limit. 

#### :pushpin: What are the 5 most popular genres in movies.

````sql
SELECT
    listed_in,
    COUNT(show_id) AS number_of_shows
FROM
    `netflix.netflix`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
````

**_Results_**

| listed_in                                          | number_of_shows |
|----------------------------------------------------|-----------------|
| Documentaries                                      | 299             |
| Stand-Up Comedy                                    | 273             |
| "Dramas, International Movies"                     | 248             |
| "Dramas, Independent Movies, International Movies" | 186             |
| "Comedies, Dramas, International Movies"           | 174             |

❗ **Insight-** Just like the above two queries the same principle has been used here to find the numbe rof records for each genre.

#### :pushpin: What is the time range in which the dataset is recorded.

````sql
SELECT
    MIN(date_added) AS first_date,
    MAX(date_added) AS last_date
FROM
    `netflix.netflix`;
````

**_Results_**

| first_date       | last_date           |
|------------------|---------------------|
| " April 1, 2014" | "September 9, 2019" |

❗ **Insight-** The **min** and **max** functions give us the minimum and maximum date respectively in the table.

#### :pushpin: How many shows have only 1 season?

````sql
SELECT
    COUNT(DISTINCT title) AS number_of_shows
FROM
    `netflix.netflix`
WHERE
    type = 'TV Show'
    AND duration LIKE '1 Season';
````

**_Results_**

| number_of_shows |
|-----------------|
| 1315            |

❗ **Insight-** For 1 season, becasue the duration column is a _string_ so we use **like** attribute to match the duration with '1 season' and then do the _count_. 

