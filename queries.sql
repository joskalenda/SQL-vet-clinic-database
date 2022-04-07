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

-- MULTIPLE TABLE QUERIES PART
SELECT animals.name, owners.full_name FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals
  INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name  FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(animals.name) as AnimalCount FROM species
  INNER JOIN animals ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name AS animal_name, owners.full_name AS owner_name FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
  INNER JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name, owners.full_name FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.name) FROM owners
  JOIN animals ON animals.owner_id = owners.id
  GROUP BY owners.full_name
ORDER BY COUNT DESC LIMIT 1;


-- JOIN AND VISIT QUERIES PART
SELECT animals.name, vets.name, visits.date_of_visit FROM vets
  JOIN visits ON vets.id = visits.vets_id
  JOIN animals ON animals.id = visits.animals_id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT COUNT(animals.name) AS count_animals FROM animals
  JOIN visits ON animals.id = visits.animals_id
  JOIN vets ON visits.vets_id = vets.id
  WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM vets
  LEFT JOIN specializations ON vets.id = specializations.vets_id
  LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name, visits.date_of_visit FROM animals
  JOIN visits ON visits.animals_id = animals.id
  JOIN vets ON vets.id = visits.vets_id
  WHERE vets.id =3  AND visits.date_of_visit >= '2020-04-01' AND visits.date_of_visit <= '2020-08-30';

SELECT animals.name, COUNT(*) FROM animals
  JOIN visits ON animals.id=visits.animals_id
  GROUP BY name ORDER BY COUNT DESC LIMIT 1;

SELECT animals.name, visits.date_of_visit FROM visits
  JOIN animals ON visits.animals_id = animals.id
  JOIN vets ON visits.vets_id = vets.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visits.date_of_visit ASC LIMIT 1;

SELECT animals.name, visits.date_of_visit, vets.name AS Vets_name FROM visits
  JOIN animals ON visits.animals_id = animals.id
  JOIN vets ON visits.vets_id = vets.id
  ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT vets.name, COUNT(visits.id) FROM visits
  JOIN vets ON visits.vets_id = vets.id
  JOIN animals ON visits.animals_id = animals.id
  JOIN specializations ON vets.id = specializations.vets_id
  WHERE specializations.species_id != animals.species_id
  GROUP BY vets.name;

SELECT species.name as species_name, vets.name as vets_name, COUNT(*) FROM vets
  JOIN visits ON visits.vets_id = vets.id
  JOIN animals ON visits.animals_id = animals.id
  JOIN species ON animals.species_id = species.id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name, vets.name
  ORDER BY COUNT(*) DESC LIMIT 1;

  -- PERFORMANCE AND NORMALISATION
SELECT COUNT(*) FROM visits where animals_id = 4;
SELECT * FROM visits where vets_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';