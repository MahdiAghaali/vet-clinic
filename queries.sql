--Find all animals whose name ends in "mon".
	SELECT * FROM tbl_animals WHERE name LIKE '%mon'
	
--List the name of all animals born between 2016 and 2019.
	SELECT name FROM tbl_animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31'
	
--List the name of all animals that are neutered and have less than 3 escape attempts.
	SELECT name FROM tbl_animals WHERE neutered = true AND escape_attempts < 3    
    
--List the date of birth of all animals named either "Agumon" or "Pikachu".
	SELECT date_of_birth FROM tbl_animals WHERE name IN('Agumon','Pikachu')
	
--List name and escape attempts of animals that weigh more than 10.5kg
	SELECT name, escape_attempts FROM tbl_animals WHERE weight_kg > 10.5
	
--Find all animals that are neutered.
	SELECT * FROM tbl_animals WHERE neutered = true
	
--Find all animals not named Gabumon.
	SELECT * FROM tbl_animals WHERE name NOT LIKE 'Gabumon'
	
--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
	SELECT * FROM tbl_animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3