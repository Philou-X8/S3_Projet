CREATE TABLE field
(
    field_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (field_id)
);
insert into field(values (1, 'Génie'));
insert into field(values (2, 'Arts, lettres et langues'));
insert into field(values (3, 'Droit'));
insert into field(values (4, 'Environnement et développement durable'));
insert into field(values (5, 'Études plurisectorielles'));
insert into field(values (6,'Administration résultats'));
insert into field(values (7, 'Informatique'));
insert into field(values (8, 'Musique'));
insert into field(values (9, 'Sciences de l activité physique'));
insert into field(values (10, 'Sciences de la santé'));
insert into field(values (11, 'Sciences de l éducation Sciences humaines'));
insert into field(values (12, 'Sciences pures'));

CREATE TABLE program
(
    program_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (program_id),
    field_id INT NOT NULL,
    FOREIGN KEY (field_id) REFERENCES field(field_id)
);
insert into program(values (1, 'Génie Information',1));
insert into program(values (2, 'Génie Mécanique',1));
insert into program(values (3, 'Génie Électrique',1));
insert into program(values (4, 'Génie Civil',1));

CREATE TABLE ap
(
    sigle varchar NOT NULL,
    label varchar NOT NULL,
    program_id int,
    FOREIGN KEY(program_id) REFERENCES program(program_id),
    PRIMARY KEY (sigle)
);

insert into ap(values('GIF302', 'Conception d un système informatique distrib',1));
insert into ap(values('GIF332', 'Réseaux et protocoles de communication',1));
insert into ap(values('GIF333', 'Théorie groupes et algèbre abstraite en ing.',1));
insert into ap(values('GIF350', 'Modèles de conception',1));
insert into ap(values('GIF371', 'Ondes guidées',1));
insert into ap(values('GIF380', 'Sécurité informatique et cryptographie',1));
insert into ap(values('GIF391', 'Systèmes distribués nuage',1));
insert into ap(values('GIF620', 'Bases de données',1));
insert into ap(values('GEN200', 'Conception d un système électronique et info',1));
insert into ap(values('GEN211', 'Mathématiques des signaux à temps continu',1));
insert into ap(values('GEN230', 'Électronique analogique I',1));
insert into ap(values('GEN241', 'Modélisation et programmation orientées objet',1));
insert into ap(values('GEN272', 'Ingénierie durable évaluation impacts envir',1));
insert into ap(values('GIF242', 'Concepts avancés en program. orientée objet',1));
insert into ap(values('GIF250', 'Interfaces utilisateurs graphiques',1));
insert into ap(values('GIF270',	'Structures de données et complexité',1));
insert into ap(values('GIN120',	'Santé et sécurité du travail',1));
insert into ap(values('GEN101', 'Résolution de problème et conception en génie',1));
insert into ap(values('GEN111', 'La communication et le travail en équipe',1));
insert into ap(values('GEN122', 'Équations différentielles linéaires',1));
insert into ap(values('GENJ24', 'Mathématiques de base pour l’ingénieur',1));
insert into ap(values('GEN134', 'Électricité et magnétisme',1));
insert into ap(values('GEN135', 'Circuits électriques I',1));
insert into ap(values('GEN136', 'Circuits électriques ll',1));
insert into ap(values('GEN145', 'Atelier de programmation',1));
insert into ap(values('GEN146', 'Introduction programmation algorithmes',1));
insert into ap(values('GEN181', 'Modélisation 3D',1));


CREATE TABLE image
(
    image_id INT NOT NULL,
    data bytea,
    PRIMARY KEY (image_id)
);
insert into image(values (1, '/images/1.jpg'));
insert into image(values (2, '/images/C++ in One Hour a Day, Sams Teach Yourself - 8th Ed.jpg'));
CREATE TABLE language
(
    language_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (language_id)
);
insert into language(values ( 1, 'Français'));
insert into language(values ( 2, 'Anglais'));
insert into language(values ( 3, 'Espagnol'));
insert into language(values ( 4, 'Portugais'));
insert into language(values ( 5, 'Allemand'));

CREATE TABLE editor
(
    editor_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (editor_id)
);
insert into editor(values (1,'PUL - Presses U. de Laval'));
insert into editor(values (2,'SAMS'));

CREATE TABLE author
(
    author_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (author_id)
);
insert into author(values (1,'Gilbert SYBILLE & Théodore WILDI'));
insert into author(values (2,'Siddhartha RAO'));


CREATE TABLE typeformat
(
    typeformat_id INT     NOT NULL,
    label         varchar NOT NULL,
    PRIMARY KEY (typeformat_id)
);
insert into typeformat(values (1,'Papier'));
insert into typeformat(values (2,'Digital'));

CREATE TABLE format
(
    format_id INT NOT NULL,
    label varchar NOT NULL,
    typeformat_id INT NOT NULL,
    --1 = papier
    --2 = digital
    PRIMARY KEY (format_id),
    FOREIGN KEY (typeformat_id) REFERENCES typeformat(typeformat_id)
);
insert into format(values (1, 'Papier', 1));
insert into format(values (2, 'PDF', 2));
insert into format(values (3, 'Epub', 2));


CREATE TABLE book
(
    sigle varchar NOT NULL,foreign key(sigle) REFERENCES ap(sigle),
    book_id INT NOT NULL,
    label varchar NOT NULL,
    codeISBN BIGINT,
    author_id int,
    editor_id int,
    publicationDate timestamp,
    format_id INT NOT NULL,
    --1 = papier
    --2 = pdf
    --3 = Epub

    URL varchar,
    language_id int,
    image_id int, foreign key(image_id) REFERENCES image(image_id),
    --1 = francais
    --2 = anglais


    PRIMARY KEY (book_id),
    FOREIGN KEY (format_id) REFERENCES format(format_id),
    FOREIGN KEY (language_id) REFERENCES language(language_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (editor_id) REFERENCES editor(editor_id),
    UNIQUE (codeISBN)
);
INSERT INTO book (sigle, book_id, label, codeISBN, author_id, editor_id, publicationDate, format_id, URL, language_id, image_id)
values ('GEN230', 1, 'Électrotechnique - 4e éd.',9782763781853, 1, 1, '2007-08-01', 1, 'https://usherbrooke.coop/fr/boutique/categories/livres-scolaires-8110/electrotechnique---4e-ed-1899232', 1, 1);
insert into book(values ('GEN145', 2, 'C++ in One Hour a Day, Sams Teach Yourself - 8th Ed.',9780789757746, 2, 2, '2016-12-28', 1, 'https://usherbrooke.coop/fr/boutique/categories/genie-informatique-8154/c-in-one-hour-a-day-sams-teach-yourself---8th-ed-1923433',2 ,2));
delete from book where book_id = 2;

CREATE TABLE associated_to
(
    book_Id INT NOT NULL,
    sigle varchar NOT NULL,
    PRIMARY KEY (book_Id, sigle),
    FOREIGN KEY (book_Id) REFERENCES book(book_Id),
    FOREIGN KEY (sigle) REFERENCES ap(sigle)
);
CREATE TABLE associated__to
(
    sigle varchar NOT NULL,
    programId INT NOT NULL,
    PRIMARY KEY (programId, sigle),
    FOREIGN KEY (programId) REFERENCES program(program_id),
    FOREIGN KEY (sigle) REFERENCES ap(sigle)
);
CREATE TABLE associated_to
(
    book_id INT NOT NULL,
    sigle varchar NOT NULL,
    PRIMARY KEY (book_id, sigle),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (sigle) REFERENCES ap(sigle)
);

CREATE TABLE content
(
    image_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (image_id, book_id),
    FOREIGN KEY (image_id) REFERENCES image(image_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
INSERT INTO content (book_id, image_id)
VALUES (1, 1);
INSERT INTO content (book_id, image_id)
VALUES (2, 2);
CREATE TABLE associated_to_LB
(
    language_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (language_id, book_id),
    FOREIGN KEY (language_id) REFERENCES language(language_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
INSERT INTO associated_to_LB (language_id, book_id) values (1, 1);
INSERT INTO associated_to_LB (language_id, book_id) values (2, 2);
;
CREATE TABLE associated_to_EB
(
    editor_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (editor_id, book_id),
    FOREIGN KEY (editor_id) REFERENCES editor(editor_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
INSERT INTO associated_to_EB (editor_id, book_id) VALUES (1, 1);
INSERT INTO associated_to_EB(editor_id, book_id) VALUES (2, 2);


CREATE TABLE associated_to_AB
(
    author_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO associated_to_AB (author_id, book_id) VALUES (1, 1);
INSERT INTO associated_to_AB (author_id, book_id) VALUES (2, 2);

