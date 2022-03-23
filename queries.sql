/*Queries that provide answers to the questions from all projects.*/

select * from animals;
select * from animals WHERE name like '%mon';
select * from animals WHERE date_of_birth Between '2016-01-01' AND '2019-12-31';
select * from animals WHERE neutered = true AND  escape_attempts < 3;
select * from animals WHERE name = 'Agumon' OR name = 'Pikachu';
select name, escape_attempts from animals WHERE weight_kg > 10.5;
select name from animals WHERE neutered = true;
select name from animals WHERE name <> 'Gabumon';
