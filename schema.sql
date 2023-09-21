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

/* fix some positive weights to be negative as per the requirements and change a mistake in an animal name with id 6 */

BEGIN;
UPDATE ANIMALS SET WEIGHT_KG = WEIGHT_KG * (-1) WHERE NAME IN('Charmander', 'Plantmon', 'Squirtle', 'Angemon');
UPDATE animals
SET name = 'Plantmon'
WHERE id = 6;
COMMIT;

