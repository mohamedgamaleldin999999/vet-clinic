/* Database schema to keep the structure of entire database. */

-- Create the animals table
CREATE TABLE animals(
   id INT PRIMARY KEY NOT NULL,
   name TEXT NOT NULL,
   date_of_birth TIMESTAMP NOT NULL,
   escape_attempts INT,
   neutered BOOLEAN,
   weight_kg DECIMAL
);

ALTER TABLE animals
ADD species VARCHAR(255);


/* Create table owners */

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INTEGER
);