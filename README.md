# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview

This project involves performing exploratory data analysis on a Netflix dataset using SQL. The goal is to uncover patterns, trends, and insights about the content available on Netflix.

## Objective

To analyze the Netflix catalog using SQL to answer important business and user-related questions such as:

- What kind of content is most common on Netflix?
- Which countries produce the most content?
- How has content distribution changed over the years?
- Which actors and directors appear most frequently?




## Dataset

The dataset used in this project was sourced from Kaggle:
[Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```
