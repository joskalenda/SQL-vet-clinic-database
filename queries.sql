select * from animals;
select * from animals WHERE name like '%mon';
select * from animals WHERE date_of_birth Between '2016-01-01' AND '2019-12-31';
select * from animals WHERE neutered = true AND  escape_attempts < 3;
select * from animals WHERE name = 'Agumon' OR name = 'Pikachu';
select name, escape_attempts from animals WHERE weight_kg > 10.5;
select name from animals WHERE neutered = true;
select name from animals WHERE name <> 'Gabumon';

BEGIN; /* begin the transaction */
UPDATE animals SET spicies = 'unspecified';
ROLLBACK; /* revert changes */

-- UPDATE SPICIES AND COMMIT
BEGIN;
UPDATE animals SET spicies = 'digimon'  WHERE name like '%mon';
UPDATE animals SET spicies = 'pokemon' WHERE spicies = '';
select * from animals;
COMMIT;
select * from animals;

-- DELETE ALL RECORDS AND REVERT CHANGES
BEGIN;
DELETE FROM animals;
ROLLBACK;
select * from animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SAVEPOINT_DELETED_DATE;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT_DELETED_DATE;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- ANSWER TO QUESTIONS
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals GROUP by spicies;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth Between '1990-01-01' AND '2000-12-31' GROUP BY spicies;