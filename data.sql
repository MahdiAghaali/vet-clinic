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
