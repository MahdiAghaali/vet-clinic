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

-- What animals belong to Melody Pond?
SELECT
	tbl_animals.name
FROM tbl_animals INNER JOIN owners ON tbl_animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
	tbl_animals.name
FROM tbl_animals INNER JOIN species ON tbl_animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT 
	owners.full_name, STRING_AGG (tbl_animals.name, ',') as animals
FROM owners LEFT JOIN tbl_animals ON owners.id = tbl_animals.owner_id
GROUP BY owners.full_name;

-- How many animals are there per species?
SELECT
	species.name, COUNT(tbl_animals.name) AS qty
FROM tbl_animals INNER JOIN species ON tbl_animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT
	tbl_animals.name
FROM tbl_animals 
INNER JOIN owners ON tbl_animals.owner_id = owners.id
INNER JOIN species ON tbl_animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon' ;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
	tbl_animals.name
FROM tbl_animals INNER JOIN owners ON tbl_animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT
	owners.FULL_name
FROM tbl_animals INNER JOIN owners ON tbl_animals.owner_id = owners.id
GROUP BY owners.full_name 
ORDER BY COUNT(tbl_animals.id) DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT tbl_animals.name 
FROM visits 
INNER JOIN tbl_animals ON tbl_animals.id = visits.animal_id
INNER JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC 
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT(animal_id)) as Qty_Different_Animals
FROM visits 
INNER JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, STRING_AGG(species.name, ',') as specializations
FROM vets 
LEFT JOIN specializations on vets.id = specializations.vet_id
LEFT JOIN species ON specializations.specie_id = species.id
GROUP BY vets.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT DISTINCT(tbl_animals.name) AS Animal_name 
FROM tbl_animals 
INNER JOIN visits on tbl_animals.id = visits.animal_id
INNER JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT tbl_animals.name   
FROM tbl_animals 
INNER JOIN visits ON tbl_animals.id = visits.animal_id
GROUP BY tbl_animals.name
ORDER BY COUNT(tbl_animals.id) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT tbl_animals.name   
FROM vets 
INNER JOIN visits ON vets.id = visits.vet_id
INNER JOIN tbl_animals ON visits.animal_id = tbl_animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT 
	tbl_animals.*, vets.* , visit_date
FROM visits 
INNER JOIN tbl_animals ON tbl_animals.id = visits.animal_id 
INNER JOIN vets ON vets.id = visits.vet_id
ORDER BY visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS Qty
FROM visits 
INNER JOIN tbl_animals ON visits.animal_id = tbl_animals.id 
INNER JOIN vets ON visits.vet_id = vets.id
WHERE tbl_animals.species_id NOT IN (
	SELECT specie_id FROM specializations 
	WHERE vet_id = vets.id
);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name
FROM visits 
INNER JOIN vets on visits.vet_id = vets.id 
INNER JOIN tbl_animals ON visits.animal_id = tbl_animals.id 
INNER JOIN species ON tbl_animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;