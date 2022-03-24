CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR (50),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN spicies VARCHAR(50);

-- CREATE NEW TABLES AND WORK ON PROJECT 3
CREATE TABLE owners (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INTEGER,
    PRIMARY KEY(id)

);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR (50),
    PRIMARY KEY (id)
);

ALTER animals ADD PRIMARY KEY(id);
ALTER TABLE animals DROP COLUMN spicies;
ALTER TABLE animals ADD COLUMN species_id INTEGER, ADD CONSTRAINT FK_SPECIES FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER, ADD CONSTRAINT FK_OWNERS FOREIGN KEY(owner_id) REFERENCES owners (id);

-- ADD VISIT,VETS AND SPECIALISATIONS TABLES
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY,
    species_id INT,
    vets_id INT,
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (vets_id) REFERENCES vets (id),
    PRIMARY KEY (id)
);

CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    date_of_visit DATE,
    animals_id INT,
    vets_id INT,
    FOREIGN KEY (animals_id) REFERENCES animals (id),
    FOREIGN KEY (vets_id) REFERENCES vets (id),
    PRIMARY KEY (id)
);