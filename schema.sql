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