use zmckee_DB;

DROP TABLE IF EXISTS influences;
DROP TABLE IF EXISTS member_of;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS music_artist;
DROP TABLE IF EXISTS music_group;
DROP TABLE IF EXISTS record_label;

CREATE TABLE record_label(
    label_name  VARCHAR(50),
    label_year  INTEGER UNSIGNED,
    label_type  VARCHAR(50),
    PRIMARY KEY (label_name)
);

CREATE TABLE music_group(
    group_name      VARCHAR(100),
    year_founded    INTEGER UNSIGNED,
    PRIMARY KEY (group_name)
);

CREATE TABLE album(
    album_group         VARCHAR(100),
    album_title         VARCHAR(100),
    album_year          INTEGER UNSIGNED,
    album_label_name    VARCHAR(50),
    PRIMARY KEY (album_group, album_title),
    FOREIGN KEY (album_group) REFERENCES music_group(group_name),
    FOREIGN KEY (album_label_name) REFERENCES record_label(label_name)
);

CREATE TABLE song(
    song_title  VARCHAR(75),
    song_group  VARCHAR(100),
    song_album  VARCHAR(100),
    PRIMARY KEY (song_title, song_group, song_album),
    FOREIGN KEY (song_group, song_album) REFERENCES album(album_group, album_title)
);

CREATE TABLE music_artist(
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    birth_year INTEGER UNSIGNED,
    PRIMARY KEY (first_name, last_name)
);

CREATE TABLE member_of(
    group_name   VARCHAR(100),
    artist_first VARCHAR(50),
    artist_last  VARCHAR(50),
    year_started INTEGER UNSIGNED,
    year_ended   INTEGER UNSIGNED,
    PRIMARY KEY (group_name, artist_first, artist_last),
    FOREIGN KEY (artist_first, artist_last) REFERENCES music_artist(first_name, last_name),
    FOREIGN KEY (group_name) REFERENCES music_group(group_name)
);

CREATE TABLE influences(
    group_influencing VARCHAR(100),
    group_influenced  VARCHAR(100),
    PRIMARY KEY (group_influencing, group_influenced),
    FOREIGN KEY (group_influencing) REFERENCES music_group(group_name),
    FOREIGN KEY (group_influenced) REFERENCES music_group(group_name)
);

CREATE TABLE genre(
    group_name VARCHAR(100),
    genre_name VARCHAR(20),
    PRIMARY KEY (group_name, genre_name),
    FOREIGN KEY (group_name) REFERENCES music_group(group_name)
);

INSERT INTO record_label
VALUES ('Interscope',1990, 'Major'),
       ('Roswell Records', 1995, 'Major'),
       ('Atlantic Records', 1947, 'Major'),
       ('Republic Records', 1995, 'Major'),
       ('Indie Records', 1983, 'Independant'),
       ('Garage Records', 1989, 'Major'),
       ('Tidal Records', 1985, 'Independant');

INSERT INTO music_group
VALUES ('Smash Mouth', 1994),
       ('Foo Fighters', 1994),
       ('Led Zeppelin', 1968);

INSERT INTO genre
VALUES ('Smash Mouth', 'Rock'),
       ('Smash Mouth', 'Alt Rock'),
       ('Smash Mouth', 'Pop Rock'),
       ('Foo Fighters', 'Alt Rock'),
       ('Foo Fighters', 'Hard Rock'),
       ('Foo Fighters', 'Grunge'),
       ('Led Zeppelin', 'Classic Rock'),
       ('Led Zeppelin', 'Hard Rock');

INSERT INTO influences
VALUES ('Led Zeppelin', 'Foo Fighters'),
       ('Led Zeppelin', 'Smash Mouth');

/*Smash mouth members*/
INSERT INTO music_artist
VALUES ('Steve','Harwell',1967),
       ('Sean','Hurwitz',1979),
       ('Paul','De Lisle',1963),
       ('Michael','Klooster',1969),
       ('Randy','Cooke',1965),
       ('Smash','Mouth',1950);

INSERT INTO member_of
VALUES ('Smash Mouth', 'Steve', 'Harwell', 1990, NULL),
       ('Smash Mouth', 'Sean', 'Hurwitz', 2012, NULL),
       ('Smash Mouth', 'Paul', 'De Lisle', 1990, NULL),
       ('Smash Mouth', 'Michael', 'Klooster', 1990, NULL),
       ('Smash Mouth', 'Randy', 'Cooke', 1990, NULL),
       ('Smash Mouth', 'Smash', 'Mouth', 1990, NULL);

/*Smash mouth albums*/
INSERT INTO album
VALUES ('Smash Mouth', 'Astro Lounge', 1999, 'Interscope'),
       ('Smash Mouth', 'Fush Yu Mang', 1997, 'Interscope');

INSERT INTO song
VALUES ('Flo', 'Smash Mouth', 'Fush Yu Mang'),
       ('Beer Goggles', 'Smash Mouth', 'Fush Yu Mang'),
       ('Walkin on the Sun', 'Smash Mouth', 'Fush Yu Mang'),
       ('Lets Rock', 'Smash Mouth', 'Fush Yu Mang'),
       ('All Star', 'Smash Mouth', 'Astro Lounge'),
       ('Waste', 'Smash Mouth', 'Astro Lounge'),
       ('Home', 'Smash Mouth', 'Astro Lounge'),
       ('Radio', 'Smash Mouth', 'Astro Lounge'),
       ('The Rain Song', 'Smash Mouth' ,'Astro Lounge');

/*Foo fighters members*/
INSERT INTO music_artist
VALUES ('Dave', 'Grohl',1969),
       ('Nate','Mendel',1982),
       ('Pat','Smear',1959),
       ('Taylor','Hawkins',1972),
       ('Chris','Shiflett',1971),
       ('Foo', 'Fighters', 1900);

INSERT INTO member_of
VALUES ('Foo Fighters', 'Dave', 'Grohl',1994,NULL),
       ('Foo Fighters', 'Nate', 'Mendel', 1994, NULL),
       ('Foo Fighters', 'Pat', 'Smear', 1994, NULL),
       ('Foo Fighters', 'Taylor', 'Hawkins', 1996, NULL),
       ('Foo Fighters', 'Chris', 'Shiflett', 1999, NULL),
       ('Foo Fighters', 'Foo', 'Fighters', 1994, NULL);

/*Foo Fighters songs*/
INSERT INTO album
VALUES ('Foo Fighters', 'Foo Fighters', 1995, 'Roswell Records'),
       ('Foo Fighters', 'The Colour and the Shape', 1997, 'Roswell Records');

INSERT INTO song
VALUES ('This is a Call', 'Foo Fighters', 'Foo Fighters'),
       ('Big Me' , 'Foo Fighters', 'Foo Fighters'),
       ('Good Grief' , 'Foo Fighters', 'Foo Fighters'),
       ('For All the Cows' , 'Foo Fighters', 'Foo Fighters'),
       ('Doll' , 'Foo Fighters', 'The Colour and the Shape'),
       ('My Hero' , 'Foo Fighters', 'The Colour and the Shape'),
       ('Everlong' , 'Foo Fighters', 'The Colour and the Shape'),
       ('My Poor Brain' , 'Foo Fighters', 'The Colour and the Shape'),
       ('You Shook Me', 'Foo Fighters', 'The Colour and the Shape');

/*Led Zeppelin members*/
INSERT INTO music_artist
VALUES ('Robert', 'Plant', 1948),
       ('Jimmy', 'Page', 1944),
       ('John', 'Baldwin', 1946),
       ('John', 'Bonham', 1948);

INSERT INTO member_of
VALUES ('Led Zeppelin', 'Robert', 'Plant', 1968, 1980),
       ('Led Zeppelin', 'Jimmy', 'Page', 1968, 1980),
       ('Led Zeppelin', 'John', 'Baldwin', 1968, 1980),
       ('Led Zeppelin', 'John', 'Bonham', 1968, 1980),
       ('Foo Fighters', 'John', 'Baldwin', 2000, NULL),
       ('Smash Mouth', 'Jimmy','Page',1990, NULL);

/*Led Zeppelin songs*/
INSERT INTO album
VALUES ('Led Zeppelin', 'Led Zeppelin', 1969, 'Atlantic Records'),
       ('Led Zeppelin', 'Houses of the Holy', 1973, 'Atlantic Records');

       
INSERT INTO song
VALUES ('Good Times Bad Times', 'Led Zeppelin', 'Led Zeppelin'),
       ('You Shook Me', 'Led Zeppelin', 'Led Zeppelin'),
       ('Communication Breakdown', 'Led Zeppelin', 'Led Zeppelin'),
       ('How Many More Times', 'Led Zeppelin', 'Led Zeppelin'),
       ('The Song Remains the Same', 'Led Zeppelin', 'Houses of the Holy'),
       ('The Rain Song', 'Led Zeppelin', 'Houses of the Holy'),
       ('Dancing Days', 'Led Zeppelin', 'Houses of the Holy'),
       ('The Ocean', 'Led Zeppelin', 'Houses of the Holy');