CREATE DATABASE record_company;
USE record_company;

CREATE TABLE bands (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);
    
CREATE TABLE albums (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    band_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (band_id) REFERENCES bands(id)
);

CREATE TABLE songs (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albums(id)
);

-- Select the names of all the bands.
SELECT
    name AS 'Band Name'
FROM
    bands;

-- Select the oldest album.
SELECT
    name,
    release_year,
    band_id
FROM
    albums
WHERE
    release_year IS NOT NULL
ORDER BY
    release_year
LIMIT
    1;

-- Get all bands that have albums.
SELECT
    bands.name AS 'Band Name'
FROM
    bands
    JOIN albums ON bands.id = albums.band_id
GROUP BY
    bands.name;

-- Get all Bands that have No Albums.
SELECT
  bands.name AS 'Band Name'
FROM
  bands
  LEFT JOIN albums ON bands.id = albums.band_id
WHERE
  albums.name IS NULL
GROUP BY
  bands.id;
  
  -- Get the longest album.
SELECT
    albums.name AS 'Name',
    albums.release_year AS 'Release Year',
    sub.album_length AS 'Duration'
FROM
    albums,
    (
        SELECT
            album_id,
            SUM(length) AS album_length
        FROM
            songs
        GROUP BY
            album_id
        ORDER BY
            album_length DESC
    ) AS sub
WHERE
    albums.id = sub.album_id
ORDER BY
    sub.album_length DESC
LIMIT
    1; 
    
-- Update the release year of the album with no release year. (REVIEW AGAIN)
UPDATE
    albums
SET
    release_year = 1986
WHERE
    id = 4;
    
-- Insert an arbitrary record to the table.
INSERT INTO
    bands(name)
VALUES
('Favorite band name');

INSERT INTO
    albums(name, release_year, band_id)
VALUES
    ('Favorite album name', 2000, 8);
    
-- Get the id of the added album.
SELECT
    id
FROM
    albums
ORDER BY
    id DESC
LIMIT
    1;
    
-- Delete the added record.
DELETE FROM
    albums
WHERE
    id = 19;

-- Get the id of the added band.
SELECT
    id
FROM
    bands
ORDER BY
    id DESC
LIMIT
    1;

-- Delete the added band.
DELETE FROM
    bands
WHERE
    id = 8;

-- Get the average length of all songs.
SELECT AVG(length) AS 'Average Song Duration'
FROM songs;

-- Select the longest song of each album.
SELECT
    albums.name AS 'Album',
    albums.release_year AS 'Relase Year',
    MAX(length) AS 'Duration'
FROM
    songs
    JOIN albums ON songs.album_id = albums.id
GROUP BY
    songs.album_id;
    
-- Get the number of songs for each band.
SELECT *
FROM bands;

SELECT
    bands.name,
    sub.song_count AS 'Number of songs'
FROM
    bands,
    (
        SELECT
            COUNT(songs.name) AS song_count,
            albums.band_id
        FROM
            songs
            JOIN albums ON songs.album_id = albums.id
        GROUP BY
            band_id
    ) AS sub
WHERE
    bands.id = sub.band_id;