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


/* Create table species */

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name TEXT
);


/* Add some columns to animals table */

ALTER TABLE animals
    DROP COLUMN species,
    ADD COLUMN id SERIAL PRIMARY KEY,
    ADD COLUMN species_id INTEGER,
    ADD COLUMN owner_id INTEGER,
    ADD FOREIGN KEY (species_id) REFERENCES species(id),
    ADD FOREIGN KEY (owner_id) REFERENCES owners(id);


-- Create vets table 

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);
