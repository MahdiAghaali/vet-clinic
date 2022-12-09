CREATE TABLE TBL_Animals (
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR,
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL
)

-- Add a column species of type string to your animals table. Modify your schema.sql file.
ALTER TABLE tbl_animals
ADD COLUMN species varchar;

--Create owners table
CREATE TABLE owners (
	id int GENERATED ALWAYS AS IDENTITY,
	full_name varchar(250),
	age int,
	PRIMARY KEY (id) 
);

--Create species table
CREATE TABLE species (
	id int GENERATED ALWAYS AS IDENTITY,
	name varchar(100),
	PRIMARY KEY (id)
);

ALTER TABLE tbl_animals DROP COLUMN species;
ALTER TABLE tbl_animals ADD species_id int REFERENCES species (id);
ALTER TABLE tbl_animals ADD owner_id  int REFERENCES owners (id);

-- Create vets table
CREATE TABLE vets (
	id int GENERATED ALWAYS AS IDENTITY, 
	name varchar(100),
	age int,
	date_of_graduation date,
	PRIMARY KEY (id)
);


-- Create specializations table
CREATE TABLE specializations (
	specie_id int REFERENCES  species (id), 
	vet_id int REFERENCES  vets (id) 
);

-- Create visits table
CREATE TABLE visits (
	animal_id int REFERENCES  animals (id), 
	vet_id int REFERENCES  vets (id) ,
	visit_date date
);