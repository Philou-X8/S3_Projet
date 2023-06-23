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



CREATE VIEW recherche_par_autheur_view AS
SELECT book.label    AS book_label,
       book.codeISBN,
       author.label  AS author_label,
       ap.sigle,
       program.label AS program_label,
       image.data
FROM ap
         JOIN book ON ap.sigle = book.sigle
         JOIN field ON book.field_id = field.field_id
         JOIN author ON book.author_id = author.author_id
         JOIN associated_Sigle_Program ON associated_Sigle_Program.sigle = ap.sigle
         JOIN program ON associated_Sigle_Program.program_id = program.program_id
         JOIN image ON book.image_id = image.image_id;

/*
SELECT *
FROM recherche_par_autheur_view
WHERE author_label = 'Siddhartha RAO';


CREATE VIEW recherche_par_ISBN_view AS
SELECT book.label    AS book_label,
       book.codeISBN,
       author.label  AS author_label,
       ap.sigle,
       program.label AS program_label,
       image.data
FROM ap
         JOIN book ON ap.sigle = book.sigle
         JOIN field ON book.field_id = field.field_id
         JOIN author ON book.author_id = author.author_id
         JOIN associated_Sigle_Program ON ap.sigle = associated_Sigle_Program.sigle
         JOIN program ON associated_Sigle_Program.program_id = program.program_id
         JOIN image ON book.image_id = image.image_id;

SELECT *
FROM recherche_par_ISBN_view
WHERE codeISBN = '9782763781853';


CREATE view recherche_par_departement_view AS
SELECT book.label    AS book_label,
       book.codeISBN,
       author.label  AS author_label,
       ap.sigle,
       program.label AS program_label,
       image.data,
       field.label
FROM ap
         JOIN book ON ap.sigle = book.sigle
         JOIN field ON book.field_id = field.field_id
         JOIN author ON book.author_id = author.author_id
         JOIN associated_Sigle_Program ON ap.sigle = associated_Sigle_Program.sigle
         JOIN program ON associated_Sigle_Program.program_id = program.program_id
         JOIN image ON book.image_id = image.image_id;

/* Test unitaire */
SELECT book_label, codeISBN, author_label, sigle, program_label, data
FROM recherche_par_departement_view
WHERE label = 'Génie';


CREATE VIEW recherche_par_ap_view AS
SELECT ap.label      AS ap_label,
       book.label    AS book_label,
       book.codeISBN,
       author.label  AS author_label,
       ap.sigle,
       program.label AS program_label,
       image.data
FROM ap
         JOIN associated_Sigle_Program ON ap.sigle = associated_Sigle_Program.sigle
         JOIN program ON associated_Sigle_Program.program_id = program.program_id
         JOIN book ON ap.sigle = book.sigle
         JOIN author ON book.author_id = author.author_id
         JOIN image ON book.image_id = image.image_id;


/* Test unitaire */
SELECT book_label, codeISBN, author_label, sigle, program_label, data
FROM recherche_par_ap_view
WHERE ap_label = 'Atelier de programmation';


/*test unitaires 01*/


CREATE VIEW recherche_par_programme_view AS
SELECT book.label    AS book_label,
       book.codeISBN,
       author.label  AS author_label,
       ap.sigle,
       program.label AS program_label,
       image.data
FROM ap
         JOIN book ON ap.sigle = book.sigle
         JOIN field ON book.field_id = field.field_id
         JOIN author ON book.author_id = author.author_id
         JOIN associated_Sigle_Program ON ap.sigle = associated_Sigle_Program.sigle
         JOIN program ON associated_Sigle_Program.program_id = program.program_id
         JOIN image ON book.image_id = image.image_id;

SELECT *
FROM recherche_par_programme_view
where program_label = 'Génie Information';
CREATE view recherche_par_sigle_view AS
SELECT book.label    AS book_label,
       book.codeISBN,
       author.label  AS author_label,
       ap.sigle,
       program.label AS program_label,
       image.data
FROM ap
         JOIN book ON ap.sigle = book.sigle
         JOIN field ON book.field_id = field.field_id
         JOIN author ON book.author_id = author.author_id
         JOIN associated_Sigle_Program ON ap.sigle = associated_Sigle_Program.sigle
         JOIN program ON associated_Sigle_Program.program_id = program.program_id
         JOIN image ON book.image_id = image.image_id;
/* Test unitaire */
SELECT book_label, codeISBN, author_label, sigle, program_label, data
FROM recherche_par_sigle_view
WHERE sigle = 'GEN230';

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
         JOIN language l ON b.language_id = l.language_id;


INSERT INTO book (sigle, book_id, label, codeISBN, author_id, editor_id, publicationDate, format_id, URL, language_id,
                  field_id)
SELECT 'GIF371',
       (SELECT COALESCE(MAX(book_id), 0) + 1 FROM book),
       'Titre du livre',
       9191834567890,
       1,
       1,
       '2023-06-01',
       1,
       'https://example.com',
       1,
       1 WHERE NOT EXISTS (
    SELECT 1 FROM book WHERE sigle = 'GIF371'
);
 */

















