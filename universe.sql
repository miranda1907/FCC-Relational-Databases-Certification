CREATE DATABASE universe;

CREATE TABLE galaxy();

CREATE TABLE star();

CREATE TABLE planet();

CREATE TABLE moon();

CREATE TABLE asteroid();

ALTER TABLE galaxy ADD COLUMN galaxy_id SERIAL PRIMARY KEY;
ALTER TABLE star ADD COLUMN star_id SERIAL PRIMARY KEY;
ALTER TABLE planet ADD COLUMN planet_id SERIAL PRIMARY KEY;
ALTER TABLE moon ADD COLUMN moon_id SERIAL PRIMARY KEY;
ALTER TABLE asteroid ADD COLUMN asteroid_id SERIAL PRIMARY KEY;



ALTER TABLE galaxy ADD COLUMN name VARCHAR(60) UNIQUE NOT NULL;
ALTER TABLE star ADD COLUMN name VARCHAR(60) UNIQUE NOT NULL;
ALTER TABLE planet ADD COLUMN name VARCHAR(60) UNIQUE NOT NULL;
ALTER TABLE moon ADD COLUMN name VARCHAR(60) UNIQUE NOT NULL;
ALTER TABLE asteroid ADD COLUMN name VARCHAR(60) UNIQUE NOT NULL;

ALTER TABLE galaxy ADD COLUMN age INT;
ALTER TABLE star ADD COLUMN age INT;
ALTER TABLE planet ADD COLUMN age INT;
ALTER TABLE moon ADD COLUMN age INT;

ALTER TABLE galaxy ADD COLUMN type TEXT;
ALTER TABLE star ADD COLUMN type VARCHAR(60);
ALTER TABLE planet ADD COLUMN type TEXT;
ALTER TABLE moon ADD COLUMN is_tidally_locked BOOLEAN;
ALTER TABLE asteroid ADD COLUMN size NUMERIC;


ALTER TABLE galaxy ADD COLUMN distance_from_earth NUMERIC;
ALTER TABLE star ADD COLUMN visible_without_equipment BOOLEAN;
ALTER TABLE planet ADD COLUMN orbits_sun BOOLEAN;
ALTER TABLE moon ADD COLUMN distance_from_the_planet NUMERIC;

ALTER TABLE star ADD COLUMN galaxy_id INT;
ALTER TABLE star ADD FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id);

ALTER TABLE planet ADD COLUMN star_id INT;
ALTER TABLE planet ADD FOREIGN KEY (star_id) REFERENCES star(star_id);

ALTER TABLE moon ADD COLUMN planet_id INT;
ALTER TABLE moon ADD FOREIGN KEY (planet_id) REFERENCES planet(planet_id);

INSERT INTO galaxy(galaxy_id, name, age, type, distance_from_earth) 
VALUES(1, 'Milky Way', 13, 'barred spiral', 26000),
(2, 'Andromeda I', 10, 'barred spiral', 2400000),
(3, 'Black Eye Galaxy', 13, 'unbarred spiral', 17000000),
(4, 'Bode Galaxy', 13, 'grand design spiral', 12000000),
(5, 'Coma Pinwheel Galaxy', 13, 'grand design spiral', 56000000),
(6, 'Condor Galaxy', 5, 'barred spiral', 212000000), 
(7, 'Unknown', 0, NULL, 0);

INSERT INTO star(star_id, name, age, type, visible_without_equipment, galaxy_id)
VALUES (1, 'The Sun', 4, 'G-type main-sequence', TRUE, 1),
(2, 'RR Lyrae variables', 13, 'Spectral Class A or F', FALSE, 2),
(3, 'The Counter-Rotating Stars', 1, 'Spectral Class O and B', FALSE, 3),
(4, 'SN 1993J', 11, 'B-type helium', FALSE, 4),
(5, 'PTF 10fqs', 0.5, 'Luminous Red Nova', FALSE, 5),
(6, 'SN 1997cl', 0.2, 'white dwarf', FALSE, 6),
(7, 'Unknown', 0, NULL, FALSE, 7);

INSERT INTO planet(planet_id, name, age, type, orbits_sun, star_id) 
VALUES (1, 'Earth', 4.5, 'terrestrial', TRUE, 1),
(2, 'Mercury', 4.5, 'terrestrial', TRUE, 1),
(3, 'Venus', 4.5, 'terrestrial',  TRUE, 1),
(4, 'Mars', 4.6, 'Terrestrial', TRUE, 1),
(5, 'Jupiter', 4.6, 'Gas Giant', TRUE, 1),
(6, 'Saturn', 4.5, 'Gas Giant', TRUE, 1),
(7, 'Uranus', 4.5, 'Ice Giant', TRUE, 1),
(8, 'Neptune', 4.5, 'Ice Giant', TRUE, 1),
(9, 'Kepler-186f', 4, 'Terrestrial', FALSE, 7),
(10, '55 Cancri e', 7.6, 'Super-Earth', FALSE, 7),
(11, 'TOI-700 d', 1.5, 'Terrestrial', FALSE, 7),
(12, 'HD 189733 b', 6, 'Hot Jupiter', FALSE, 7);

INSERT INTO moon(moon_id, name, age, is_tidally_locked, distance_from_the_planet, planet_id) 
VALUES(1, 'The Moon', 4.46, TRUE, 384400, 1),
(2, 'Phobos', 4.5, TRUE, 9377, 4),
(3, 'Deimos', 4.5, TRUE, 23460, 4),
(4, 'Io', 4.5, TRUE, 421700, 5),
(5, 'Europa', 4.5, TRUE, 670900, 5),
(6, 'Ganymede', 4.5, TRUE, 1070400, 5),
(7, 'Callisto', 4.5, TRUE, 1882700, 5),
(8, 'Amalthea', 4.5, TRUE, 181400, 5),
(9, 'Titan', 4.5, TRUE, 1221870, 6),
(10, 'Enceladus', 4.5, TRUE, 238000, 6),
(11, 'Mimas', 4.5, TRUE, 185520, 6),
(12, 'Tethys', 4.5, TRUE, 294660, 6),
(13, 'Dione', 4.5, TRUE, 377400, 6),
(14, 'Rhea', 4.5, TRUE, 527040, 6),
(15, 'Iapetus', 4.5, TRUE, 3561300, 6),
(16, 'Ariel', 4.5, TRUE, 191020, 7),
(17, 'Umbriel', 4.5, TRUE, 266000, 7),
(18, 'Titania', 4.5, TRUE, 435910, 7),
(19, 'Oberon', 4.5, TRUE, 583520, 7),
(20, 'Triton', 4.5, TRUE, 354760, 8);

INSERT INTO asteroid(asteroid_id, name, size)
VALUES(1, 'Ceres', 940),
(2, 'Vesta', 525),
(3, 'Pallas', 512);