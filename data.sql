INSERT INTO tbl_animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 	('Agumon', '2020-02-03', 0, true, 10.23),
		('Gabumon', '2018-11-15', 2, true, 8),
		('Pikachu', '2021-06-07', 1, false, 15.04),
		('Devimon', '2017-05-12', 5, true, 11)


INSERT INTO tbl_animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 	('Charmander', '2020-02-08', 0, false, -11),
		('Plantom', '2021-11-15', 2, true, -5.7),
		('Squirtle', '2021-06-07', 3, false, -12.13),
		('Angemon', '2005-06-12', 1, true, 20.4),
		('Boarmon', '2005-06-07', 7, true, 20.4),
		('Blossom', '1998-10-13', 3, true, 17),
		('Ditto', '2022-05-14', 4, true, 22);


-- Polpulate owners table
INSERT INTO owners (full_name, age) 
	VALUES 	('Sam Smith', 34),
			('Jennifer Orwell', 19),
			('Bob', 45),
			('Melody Pond', 77),
			('Dean Winchester', 14),
			('Jodie Whittaker', 38);

-- Polpulate species table
INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');

-- Update species_id in the animals table
UPDATE tbl_animals 
	SET species_id = species.id
FROM species 
WHERE tbl_animals.name LIKE '%mon' AND species.name = 'Digimon';

UPDATE tbl_animals 
	SET species_id = species.id
FROM species 
WHERE tbl_animals.name NOT LIKE '%mon' AND species.name = 'Pokemon';

-- Update owners_id in the animals table
UPDATE tbl_animals 
	SET owner_id = owners.id
FROM owners 
WHERE tbl_animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';

UPDATE tbl_animals 
	SET owner_id = owners.id
FROM owners 
WHERE tbl_animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';

UPDATE tbl_animals 
	SET owner_id = owners.id
FROM owners 
WHERE tbl_animals.name in ('Devimon', 'Plantmon') and owners.full_name = 'Bob';

UPDATE tbl_animals 
	SET owner_id = owners.id
FROM owners 
WHERE tbl_animals.name in ('Charmander', 'Squirtle', 'Blossom') and owners.full_name = 'Melody Pond';

UPDATE tbl_animals 
	SET owner_id = owners.id
FROM owners 
WHERE tbl_animals.name in ('Angemon', 'Boarmon') and owners.full_name = 'Dean Winchester';

-- Populate vets table

INSERT INTO vets (name,	age, date_of_graduation) 
	VALUES 	('William Tatcher', 45, '2000-04-23'),
			('Maisy Smith',	26,	'2019-01-17'),
			('Stephanie Mendez', 64, '1981-05-04'),
			('Jack Harkness', 38, '2008-06-08');

-- Populate specializations table
INSERT INTO specializations (specie_id, vet_id) 
SELECT species.id , vets.id
FROM species
INNER JOIN vets ON vets.name = 'William Tatcher' AND species.name = 'Pokemon';

INSERT INTO specializations (specie_id, vet_id) 
SELECT species.id , vets.id
FROM species
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND species.name IN ('Digimon', 'Pokemon');

INSERT INTO specializations (specie_id, vet_id) 
SELECT species.id , vets.id
FROM species
INNER JOIN vets ON vets.name = 'Jack Harkness' AND species.name = 'Digimon';

-- Populate visits table
INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-05-24'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'William Tatcher' AND animals.name = 'Agumon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-06-22'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Agumon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-02-02'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Gabumon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-01-05'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Pikachu';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-03-08'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Pikachu';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-05-14'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Pikachu';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-05-04'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Devimon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-02-24'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Charmander';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-12-21'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Plantmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-08-10'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'William Tatcher' AND animals.name = 'Plantmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-04-07'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Plantmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-09-29'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Squirtle';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-10-03'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Angemon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-11-04'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Angemon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-01-24'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-05-15'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-02-27'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-08-03'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-05-24'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-01-11'
FROM tbl_animals as animals
INNER JOIN vets ON vets.name = 'William Tatcher' AND animals.name = 'Boarmon';