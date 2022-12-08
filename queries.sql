-- Find all animals whose name ends in "mon".
	SELECT * FROM tbl_animals WHERE name LIKE '%mon'
	
-- List the name of all animals born between 2016 and 2019.
	SELECT name FROM tbl_animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'
	
-- List the name of all animals that are neutered and have less than 3 escape attempts.
	SELECT name FROM tbl_animals WHERE neutered = true AND escape_attempts < 3    
    
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
	SELECT date_of_birth FROM tbl_animals WHERE name IN('Agumon','Pikachu')
	
-- List name and escape attempts of animals that weigh more than 10.5kg
	SELECT name, escape_attempts FROM tbl_animals WHERE weight_kg > 10.5
	
-- Find all animals that are neutered.
	SELECT * FROM tbl_animals WHERE neutered = true
	
-- Find all animals not named Gabumon.
	SELECT * FROM tbl_animals WHERE name NOT LIKE 'Gabumon'
	
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
	SELECT * FROM tbl_animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3

/*Inside a transaction update the animals table by setting the species column to unspecified.
Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.*/
BEGIN TRANSACTION;
UPDATE tbl_animals SET species = 'unspecified'; 
SELECT * FROM tbl_animals;
ROLLBACK TRANSACTION;
SELECT * FROM tbl_animals;

-- Update species based on name
BEGIN TRANSACTION;
UPDATE tbl_animals SET species = 'digimon' WHERE name LIKE '%mon'; 
UPDATE tbl_animals SET species = 'pokemon' WHERE species IS NULL; 
COMMIT TRANSACTION;
SELECT * FROM tbl_animals;

-- Test deleting all records from the animal table
BEGIN TRANSACTION;
DELETE FROM tbl_animals; 
SELECT * FROM tbl_animals;
ROLLBACK TRANSACTION;
SELECT * FROM tbl_animals;

-- Update animals with negative weight
BEGIN TRANSACTION;
DELETE FROM tbl_animals WHERE date_of_birth > '2022-01-01'; 
SAVEPOINT SP; 
UPDATE tbl_animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP; 
UPDATE tbl_animals SET weight_kg = weight_kg * -1 where weight_kg < 0;
COMMIT TRANSACTION;
SELECT * FROM tbl_animals

-- How many animals are there?
SELECT COUNT(*) AS COUNT_OF_ANIMALS FROM tbl_animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS COUNT_OF_CALM_ANIMALS
FROM tbl_animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS AVERAGE_WEIGHT
FROM tbl_animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT SUM(escape_attempts), neutered
FROM tbl_animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) as MIN_WEIGHT, MAX(weight_kg) AS MAX_WEIGHT
FROM tbl_animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as AVERAGE_ESCAPES
FROM tbl_animals
WHERE date_of_birth between '1990-01-01' and '2000-12-31'
GROUP BY species;