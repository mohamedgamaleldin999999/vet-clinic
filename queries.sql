/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


/* fix some positive weights to be negative as per the requirements and change a mistake in an animal name with id 6 */

BEGIN;
UPDATE ANIMALS SET WEIGHT_KG = WEIGHT_KG * (-1) WHERE NAME IN('Charmander', 'Plantmon', 'Squirtle', 'Angemon');
UPDATE animals
SET name = 'Plantmon'
WHERE id = 6;
COMMIT;


/* Inside a transaction update the animals table by setting the species column to unspecified.
Verify that change was made. Then roll back the change and verify that the species columns went
back to the state before the transaction. */

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


/* Update the species of the animals to pokemon/digimon and commit */

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


/* Delete all the records then rollback */

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


/* Updating the negative weights and deleting then rolling back some records */

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;



/* how many animals? */

SELECT COUNT(*) AS total_animals
FROM animals;


/* non-escape count */

SELECT COUNT(*) AS non_escape_count
FROM animals
WHERE escape_attempts = 0;


/* Average weight */

SELECT AVG(weight_kg) AS average_weight
FROM animals;


/* Who escapes more? */

SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;


/* min and max weight per type */

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;


/* Average attempts of animals born between 1990 and 2000 */

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- What animals belong to Melody Pond?

SELECT a.name
FROM animals a
INNER JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';


-- List of all animals that are Pokémon

SELECT a.name
FROM animals a
INNER JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';


-- List all owners and their animals

SELECT o.full_name, COALESCE(a.name, 'No animals') AS animal_name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;


-- How many animals are there per species?

SELECT s.name AS species_name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;


-- List all Digimon owned by Jennifer Orwell.

SELECT a.name
FROM animals a
INNER JOIN species s ON a.species_id = s.id
INNER JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';


-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT a.name
FROM animals a
INNER JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;


-- Who owns the most animals?

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;


-- Last animal seen by William Tatcher

SELECT a.name AS last_animal_seen
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN animals a ON v.animal_id = a.id
WHERE vet.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;
