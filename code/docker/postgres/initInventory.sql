CREATE EXTENSION unaccent;

CREATE TABLE field
(
    field_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (field_id)
);


CREATE TABLE program
(
    program_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (program_id),
    field_id INT NOT NULL,
    FOREIGN KEY (field_id) REFERENCES field(field_id)
);

CREATE TABLE ap
(
    sigle varchar NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (sigle)
);

CREATE TABLE image
(
    image_id INT NOT NULL,
    data bytea,
    PRIMARY KEY (image_id)
);

CREATE TABLE language
(
    language_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (language_id)
);

CREATE TABLE editor
(
    editor_id INT NOT NULL,
    label varchar NOT NULL,
    UNIQUE (editor_id),
    PRIMARY KEY (editor_id)
);

CREATE TABLE author
(
    author_id INT NOT NULL,
    label varchar NOT NULL,
    UNIQUE (author_id),
    PRIMARY KEY (author_id)
);



CREATE TABLE typeformat
(
    typeformat_id INT     NOT NULL,
    label         varchar NOT NULL,
    PRIMARY KEY (typeformat_id)
);


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
--1 = papier
--2 = pdf
--3 = Epub
--4 = site Internet
--5 = person"

CREATE TABLE book
(
    book_id         INT     UNIQUE,
    label           varchar NOT NULL,
    codeISBN        BIGINT,
    publicationDate DATE,
    format_id       INT     NOT NULL,
    URL         varchar,
    language_id int,
    image_id    int,
    field_id    int not null,

    --1 = papier
    --2 = pdf
    --3 = Epub


    foreign key (image_id) REFERENCES image (image_id),
    --1 = francais
    --2 = anglais

    PRIMARY KEY (book_id),
    FOREIGN KEY (format_id) REFERENCES format (format_id),
    FOREIGN KEY (language_id) REFERENCES language (language_id),
    FOREIGN KEY (field_id) REFERENCES field (field_id),
    UNIQUE (codeISBN)
);

CREATE TABLE associated_to_SB

(
    book_id INT NOT NULL,
    sigle varchar NOT NULL,
    PRIMARY KEY (book_id, sigle),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (sigle) REFERENCES ap(sigle)
);
CREATE TABLE associated_to_SP
(
    sigle varchar NOT NULL,
    program_id INT NOT NULL,
    PRIMARY KEY (program_id, sigle),
    FOREIGN KEY (program_id) REFERENCES program(program_id),
    FOREIGN KEY (sigle) REFERENCES ap(sigle)
);


CREATE TABLE associated_to_AB
(
    author_id INT NOT NULL,
    book_id   INT NOT NULL,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (book_id) REFERENCES book (book_id)
);


CREATE TABLE associated_to_EB
(
    editor_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (editor_id, book_id),
    FOREIGN KEY (editor_id) REFERENCES editor(editor_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);


------------------------------------------------
--                   VIEWS                    --
------------------------------------------------


CREATE VIEW recherche_par_autheur_view AS
SELECT book.label    AS book_label,
       book.codeISBN AS isbn_label,
       author.label  AS author_label,
       ap.sigle      AS sigle_label,
       program.label AS program_label
FROM ap
         JOIN associated_to_SB on ap.sigle = associated_to_SB.sigle
         JOIN book ON associated_to_SB.book_id = book.book_id
         JOIN field ON book.field_id = field.field_id
         JOIN associated_to_ab on book.book_id = associated_to_AB.book_id
         JOIN author ON associated_to_AB.author_id = author.author_id
        JOIN program on field.field_id = program.field_id
        /*JOIN program ON associated_Sigle_Program.program_id = program.program_id*/;
SELECT *
FROM recherche_par_autheur_view
WHERE author_label = 'Gilbert SYBILLE';


CREATE VIEW recherche_par_ISBN_view AS
SELECT book.label    AS book_label,
       book.codeISBN AS isbn_label,
       author.label  AS author_label,
       ap.sigle      AS sigle_label,
       program.label AS program_label
FROM ap
         JOIN associated_to_SB on ap.sigle = associated_to_SB.sigle
         JOIN book ON associated_to_SB.book_id = book.book_id
         JOIN field ON book.field_id = field.field_id
         Join associated_to_AB on book.book_id = associated_to_AB.book_id
         JOIN author ON associated_to_AB.author_id = author.author_id
         JOIN program on field.field_id = program.field_id;

SELECT *
FROM recherche_par_ISBN_view
WHERE isbn_label = '97813056321';


CREATE view recherche_par_departement_view AS
SELECT book.label    AS book_label,
       book.codeISBN AS isbn_label,
       author.label  AS author_label,
       ap.sigle      AS sigle_label,
       program.label AS program_label,
       field.label
FROM ap
         JOIN associated_to_SB on ap.sigle = associated_to_SB.sigle
         JOIN book ON associated_to_SB.book_id = book.book_id
         JOIN field ON book.field_id = field.field_id
         Join associated_to_AB on book.book_id = associated_to_AB.book_id
         JOIN author ON associated_to_AB.author_id = author.author_id
         JOIN program on field.field_id = program.field_id;

/* Test unitaire */
SELECT book_label, isbn_label, author_label, sigle_label/*, program_label, data*/
FROM recherche_par_departement_view
WHERE label = 'Genie';


CREATE VIEW recherche_par_ap_view AS
SELECT book.label    AS book_label,
       book.codeISBN AS isbn_label,
       author.label  AS author_label,
       ap.sigle      AS sigle_label,
       program.label AS program_label,
       ap.label      AS ap_label

FROM ap

         JOIN associated_to_SB on ap.sigle = associated_to_SB.sigle
         JOIN book ON associated_to_SB.book_id = book.book_id
         JOIN field ON book.field_id = field.field_id
         Join associated_to_AB on book.book_id = associated_to_AB.book_id
         JOIN author ON associated_to_AB.author_id = author.author_id
         JOIN program on field.field_id = program.field_id;


/* Test unitaire */
SELECT book_label, isbn_label, author_label, sigle_label, program_label
FROM recherche_par_ap_view
WHERE ap_label = 'Bases de donnees';


CREATE view recherche_par_sigle_view AS
SELECT book.label    AS book_label,
       book.codeISBN AS isbn_label,
       author.label  AS author_label,
       ap.sigle      AS sigle_label,
       program.label AS program_label
FROM ap
         JOIN associated_to_SB on ap.sigle = associated_to_SB.sigle
         JOIN book ON associated_to_SB.book_id = book.book_id
         JOIN field ON book.field_id = field.field_id
         Join associated_to_AB on book.book_id = associated_to_AB.book_id
         JOIN author ON associated_to_AB.author_id = author.author_id
         JOIN program on field.field_id = program.field_id;
/* Test unitaire */
SELECT book_label, isbn_label, author_label, sigle_label, program_label/*, data*/
FROM recherche_par_sigle_view
WHERE sigle_label = 'GEL345';


CREATE VIEW recherche_par_programme_view AS
SELECT book.label    AS book_label,
       book.codeISBN AS isbn_label,
       author.label  AS author_label,
       ap.sigle      AS sigle_label,
       program.label AS program_label

FROM ap
         JOIN associated_to_SB on ap.sigle = associated_to_SB.sigle
         JOIN book ON associated_to_SB.book_id = book.book_id
         JOIN field ON book.field_id = field.field_id
         Join associated_to_AB on book.book_id = associated_to_AB.book_id
         JOIN author ON associated_to_AB.author_id = author.author_id
         JOIN program on field.field_id = program.field_id;
SELECT *
FROM recherche_par_programme_view
where program_label = 'Genie Informatique';




/*test unitaires 01
CREATE VIEW inserer_dans_ap_view AS
SELECT ap.sigle,
       ap.label,
       NULL AS program_id,
       b.book_id,
       b.codeISBN,
       a.author_id,
       e.editor_id,
       b.publicationDate,
       f.format_id,
       b.URL,
       l.language_id,
       b.field_id
FROM ap
         JOIN book b ON ap.sigle = b.sigle
         JOIN author a ON b.author_id = a.author_id
         JOIN editor e ON b.editor_id = e.editor_id
         JOIN format f ON b.format_id = f.format_id
         JOIN language l ON b.language_id = l.language_id;*/

CREATE VIEW add_bookS_view AS
SELECT (SELECT COALESCE(MAX(book_id), 0) FROM book) + ROW_NUMBER() OVER () AS book_id,
       label, codeISBN, publicationDate, format_id, URL, language_id, image_id, field_id
FROM book;

-- Créer la règle insert_book_rule
CREATE RULE insert_book_rule AS

    ON INSERT TO add_bookS_view
    DO INSTEAD
    INSERT INTO book (book_id, label, codeISBN, publicationDate, format_id, URL, language_id, image_id, field_id)
    SELECT NEW.book_id, NEW.label, NEW.codeISBN, NEW.publicationDate, NEW.format_id, NEW.URL, NEW.language_id, NEW.image_id, NEW.field_id;

-- Insérer un nouveau livre en utilisant la vue add_book_view
INSERT INTO add_bookS_view (book_id, label, codeISBN, publicationDate, format_id, URL, language_id, image_id, field_id)
VALUES ((SELECT COALESCE(MAX(book_id), 0) FROM book) + 1, 'Nouveau livre', 1234567890, '2023-06-24', 1, 'https://example.com', 1, 1, 1);


-- une vue pour retourner tous les detail d'un livre
CREATE VIEW book_details AS
SELECT b.book_id, b.label AS book_label, b.codeISBN, b.publicationDate, f.label AS format_label, b.URL, l.label AS language_label,
       i.data AS image_data, fi.label AS field_label, a.label AS author_label, e.label AS editor_label
FROM book b
         JOIN format f ON b.format_id = f.format_id
         LEFT JOIN language l ON b.language_id = l.language_id
         LEFT JOIN image i ON b.image_id = i.image_id
         JOIN field fi ON b.field_id = fi.field_id
         JOIN associated_to_AB atab ON b.book_id = atab.book_id
         JOIN author a ON atab.author_id = a.author_id
         JOIN associated_to_EB ateb ON b.book_id = ateb.book_id
         JOIN editor e ON ateb.editor_id = e.editor_id;

SELECT * FROM book_details WHERE book_id = 23 ;



