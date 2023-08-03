CREATE EXTENSION unaccent;
/**
 * Table pour stocker les champs.
 */
CREATE TABLE field
(
    field_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (field_id)
);

/**
 * Table pour stocker les programmes.
 */
CREATE TABLE program
(
    program_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (program_id),
    field_id INT NOT NULL,
    FOREIGN KEY (field_id) REFERENCES field(field_id)
);
/**
 * Table pour stocker les sigles.
 */

CREATE TABLE ap
(
    sigle varchar NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (sigle)
);
/**
 * Table pour stocker les images.
 */
CREATE TABLE image
(
    image_id INT NOT NULL,
    data bytea,
    PRIMARY KEY (image_id)
);
/**
 * Table pour stocker les langues.
 */
CREATE TABLE language
(
    language_id INT NOT NULL,
    label varchar NOT NULL,
    PRIMARY KEY (language_id)
);
/**
 * Table pour stocker les éditeurs.
 */
CREATE TABLE editor
(
    editor_id INT NOT NULL,
    label varchar NOT NULL,
    UNIQUE (editor_id),
    PRIMARY KEY (editor_id)
);

/**
 * Table pour stocker les auteurs.
 */
CREATE TABLE author
(
    author_id INT NOT NULL,
    label varchar NOT NULL,
    UNIQUE (author_id),
    PRIMARY KEY (author_id)
);


/**
 * Table pour stocker les types de format.
 */

CREATE TABLE typeformat
(
    typeformat_id INT     NOT NULL,
    label         varchar NOT NULL,
    PRIMARY KEY (typeformat_id)
);
/**
 * Table pour stocker les formats.
--1 = papier
--2 = pdf
--3 = Epub
--4 = site Internet
--5 = person"
 */

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
/**
 * Table pour stocker les livres.
 */

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

/**
 * Table pour stocker les associations entre les livres et les sigles.
 */

CREATE TABLE associated_to_SB

(
    book_id INT NOT NULL,
    sigle varchar NOT NULL,
    PRIMARY KEY (book_id, sigle),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (sigle) REFERENCES ap(sigle)
);
/**
 * Table pour stocker les associations entre les sigles et les programmes.
 */
CREATE TABLE associated_to_SP
(
    sigle varchar NOT NULL,
    program_id INT NOT NULL,
    PRIMARY KEY (program_id, sigle),
    FOREIGN KEY (program_id) REFERENCES program(program_id),
    FOREIGN KEY (sigle) REFERENCES ap(sigle)
);
/**
 * Table pour stocker les associations entre les auteurs et les livres.
 */

CREATE TABLE associated_to_AB
(
    author_id INT NOT NULL,
    book_id   INT NOT NULL,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (book_id) REFERENCES book (book_id)
);
/**
 * Table pour stocker les associations entre les éditeurs et les livres.
 */

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

/**
 * Vue de base pour les recherches.
 */
CREATE OR REPLACE VIEW recherche_base AS
SELECT book.label                                           AS book_label,
       book.codeISBN                                        AS isbn_label,
       string_agg(DISTINCT(author.label), ', ')::varchar    AS author_label,
       string_agg(DISTINCT(ap.sigle), ', ')::varchar        AS sigle_label,
       string_agg(DISTINCT(program.label), ', ')::varchar   AS program_label,
       language.label                                       AS language_label,
       string_agg(DISTINCT(ap.label), ', ')::varchar        AS ap_label,
       field.label                                          AS field_label
FROM ap
         JOIN associated_to_SB  ON ap.sigle = associated_to_SB.sigle
         JOIN book              ON associated_to_SB.book_id = book.book_id
         JOIN field             ON book.field_id = field.field_id
         JOIN associated_to_AB  ON book.book_id = associated_to_AB.book_id
         JOIN author            ON associated_to_AB.author_id = author.author_id
         JOIN associated_to_SP  ON ap.sigle = associated_to_SP.sigle
         JOIN program           ON associated_to_SP.program_id = program.program_id
         JOIN language          ON book.language_id = language.language_id
GROUP BY book_label,
         isbn_label,
         language_label,
         field_label;


CREATE OR REPLACE VIEW recherche_par_autheur_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label
FROM recherche_base

        /*JOIN program ON associated_Sigle_Program.program_id = program.program_id*/;
/* Test unitaire */
SELECT *
FROM recherche_par_autheur_view
WHERE author_label = 'Gilbert SYBILLE';

/**
 * Vue pour les recherches par ISBN.
 */
CREATE OR REPLACE VIEW recherche_par_ISBN_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label
FROM recherche_base;
/* Test unitaire */
SELECT *
FROM recherche_par_ISBN_view
WHERE isbn_label = '97813056321';
/**
 * Vue pour les recherches par département.
 */

CREATE OR REPLACE view recherche_par_departement_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label,
       field_label
FROM recherche_base;
/* Test unitaire */
SELECT book_label, isbn_label, author_label, sigle_label/*, program_label, data*/
FROM recherche_par_departement_view
WHERE field_label = 'Genie';


/**
 * Vue pour les recherches par sigle.
 */

CREATE OR REPLACE VIEW recherche_par_ap_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label,
       ap_label
FROM recherche_base;


/* Test unitaire */
SELECT book_label, isbn_label, author_label, sigle_label, program_label
FROM recherche_par_ap_view
WHERE ap_label = 'Bases de donnees';

/**
 * Vue pour les recherches par titre.
 */
CREATE OR REPLACE view recherche_par_sigle_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label
FROM recherche_base;
/* Test unitaire */
SELECT book_label, isbn_label, author_label, sigle_label, program_label/*, data*/
FROM recherche_par_sigle_view
WHERE sigle_label = 'GEL345';

/**
 * Vue pour les recherches par programme.
 */

CREATE OR REPLACE VIEW recherche_par_programme_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label
FROM recherche_base;
/* Test unitaire */
SELECT *
FROM recherche_par_programme_view
where program_label = 'Genie Informatique';

/**
 * Vue pour les recherches par titre.
 */
CREATE OR REPLACE VIEW recherche_par_titre_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label
FROM recherche_base
;
/* Test unitaire */
SELECT *
FROM recherche_par_titre_view
where book_label = 'Reseaux 5e edition';
-- TEST ---------------------------------------------
select book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label
from recherche_par_titre_view -- change for title
where unaccent(LOWER(book_label)) like ('%' || unaccent(LOWER( 'de' )) || '%')
order by book_label desc;
-- TEST END ------------------------------------------
/**
 * Vue pour les recherches par langue.
 */
CREATE OR REPLACE VIEW recherche_par_langue_view AS
SELECT book_label,
       isbn_label,
       author_label,
       sigle_label,
       program_label,
       language_label
FROM recherche_base;
/* Test unitaire */
SELECT *
FROM recherche_par_langue_view
WHERE language_label = 'Anglais';


--------------------------------------------------------------


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
/**
 * Vue pour insérer un livre dans la table book.
 */


CREATE VIEW add_bookS_view AS
SELECT (SELECT COALESCE(MAX(book_id), 0) FROM book) + ROW_NUMBER() OVER () AS book_id,
       label, codeISBN, publicationDate, format_id, URL, language_id, image_id, field_id
FROM book;


/**
 * Vue pour retourner tous les detail d'un livre
 */
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


CREATE VIEW all_info_for_a_book AS
SELECT  book.label AS book_label,
        book.codeISBN AS isbn_label,
        book.publicationDate AS date_label,
        book.URL AS url_label,
        string_agg(DISTINCT(author.label), ', ')::varchar AS author_label,
        editor.label AS editor_label,
        field.label AS field_label,
        format.label AS format_label,
        language.label AS language_label,
        string_agg(DISTINCT(program.label), ', ')::varchar AS program_label,
        typeformat.label AS typeformat_label,
        string_agg(DISTINCT(associated_to_SB.sigle), ', ')::varchar AS sigle_label,
        string_agg(DISTINCT(ap.label), ', ')::varchar AS ap_label
FROM book
         JOIN field ON book.field_id = field.field_id
         JOIN image ON book.image_id = image.image_id
         JOIN language ON book.language_id = "language".language_id
         JOIN format ON book.format_id = format.format_id
         JOIN associated_to_AB ON book.book_id = associated_to_AB.book_id
         JOIN associated_to_EB ON book.book_id = associated_to_EB.book_id
         JOIN editor ON associated_to_EB.editor_id = editor.editor_id
         JOIN author ON associated_to_AB.author_id = author.author_id
         JOIN program ON field.field_id = program.field_id AND book.field_id = program.field_id
         JOIN associated_to_SB ON book.book_id = associated_to_SB.book_id
         JOIN associated_to_SP ON program.program_id = associated_to_SP.program_id
         JOIN typeformat ON format.typeformat_id = typeformat.typeformat_id
         JOIN ap ON associated_to_SB.sigle = ap.sigle AND associated_to_SP.sigle = ap.sigle
GROUP BY
    book_label,
    isbn_label,
    date_label,
    url_label,
    editor_label,
    field_label,
    format_label,
    language_label,
    typeformat_label

;

SELECT * FROM all_info_for_a_book WHERE book_label = 'Reseaux 5e edition' ;





--Insertion with add_book view
INSERT INTO add_book_view (book_label, ISBN, publicationDate, format_id, URL, language_id, field_id, author_labels, editor_labels, sigles)
VALUES ('Nouveau livre', 1234567890, '2023-11-11',1,'https://whatshappenningtomeyo.com',1,1,'George|Luc|Bill','wtf inc|inc inc','GIF601|GIF690');





-- Create the view with the INSERT rule
CREATE OR REPLACE VIEW add_book_view AS
SELECT
    b.label AS book_label,
    b.codeISBN AS ISBN,
    b.publicationDate,
    b.format_id,
    b.URL,
    b.language_id,
    b.field_id,
    author.label AS author_labels,
    editor.label AS editor_labels,
    ap.sigle AS sigles
FROM
    book as b
        JOIN
    associated_to_AB atab ON b.book_id = atab.book_id
        JOIN
    author ON atab.author_id = author.author_id
        JOIN
    associated_to_EB ateb ON b.book_id = ateb.book_id
        JOIN
    editor ON ateb.editor_id = editor.editor_id
        JOIN
    associated_to_SB atsb ON b.book_id = atsb.book_id
        JOIN
    ap ON atsb.sigle = ap.sigle;





DROP TRIGGER IF EXISTS insert_into_add_book_view_trigger ON add_book_view;-- Create the trigger to use the trigger function
CREATE TRIGGER insert_into_add_book_view_trigger
    INSTEAD OF INSERT ON add_book_view
    FOR EACH ROW
    EXECUTE FUNCTION insert_into_add_book_view_function();



-- Create the trigger function
CREATE OR REPLACE FUNCTION insert_into_add_book_view_function()
    RETURNS TRIGGER AS
$$
DECLARE
    new_book_id INT;
    inserted_author_id INT;
    inserted_editor_id INT;
    author_label_arr TEXT[];
    author_label TEXT;
    editor_label_arr TEXT[];
    editor_label TEXT;
    sigle_label TEXT;
    sigle_label_arr TEXT[];
    current_author_id INT;
    current_editor_id INT;
BEGIN
    -- Check if the format_id and language_id exist in their respective tables
    IF NOT EXISTS (SELECT 1 FROM format WHERE format_id = NEW.format_id) THEN
        RAISE EXCEPTION 'Invalid format_id';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM language WHERE language_id = NEW.language_id) THEN
        RAISE EXCEPTION 'Invalid language_id';
    END IF;

    -- Split the sigles string and filter out non-existing sigles
    sigle_label_arr := string_to_array(NEW.sigles, '|');
    IF NOT EXISTS (
        SELECT 1
        FROM ap
        WHERE sigle = ANY(sigle_label_arr))
     THEN
        RAISE EXCEPTION 'Invalid sigle';
    END IF;

    -- Fetch the last inserted author_id and editor_id
    SELECT MAX(author_id)+1 INTO inserted_author_id FROM author;
    SELECT MAX(editor_id)+1 INTO inserted_editor_id FROM editor;
    SELECT MAX(book_id)+1 INTO new_book_id FROM book;

    -- Insert into the "book" table and get the book_id and codeISBN
    INSERT INTO book (book_id,label, codeISBN, publicationDate, format_id, URL, language_id, field_id)
    VALUES (new_book_id,NEW.book_label, NEW.ISBN, NEW.publicationDate, NEW.format_id, NEW.URL, NEW.language_id, NEW.field_id);

    -- Check if the ISBN is unique
    IF NOT FOUND THEN
        RAISE EXCEPTION 'The ISBN already exists';
    END IF;

    -- Split the authors string and insert into the "author" table with incremental IDs
    author_label_arr := string_to_array(NEW.author_labels, '|');

    -- Loop through every author in the array
    FOR i IN 1..array_length(author_label_arr, 1) LOOP
            author_label := author_label_arr[i];
            current_author_id := inserted_author_id;

            -- Verify if the author already exists
            SELECT author_id INTO current_author_id FROM author WHERE label = author_label;

            -- If it does not exist, insert the author using inserted_author_id
            IF NOT FOUND THEN
                INSERT INTO author (author_id, label) VALUES (inserted_author_id, author_label);
                current_author_id := inserted_author_id;
                inserted_author_id := inserted_author_id + 1;
            END IF;

            -- Insert into the association table using inserted_author_id
            INSERT INTO associated_to_AB (author_id, book_id) VALUES (current_author_id, new_book_id);

        END LOOP;



    -- Split the editors string and insert into the "editor" table with incremental IDs
    editor_label_arr := string_to_array(NEW.editor_labels, '|');
    current_editor_id := inserted_editor_id;

-- Loop through every editor in the array
    FOR i IN 1..array_length(editor_label_arr, 1) LOOP
            editor_label := editor_label_arr[i];
            current_editor_id := inserted_editor_id;

            -- Verify if the editor already exists
            SELECT editor_id INTO current_editor_id FROM editor WHERE label = editor_label;

            -- If it does not exist, insert the editor using inserted_editor_id
            IF NOT FOUND THEN
                INSERT INTO editor (editor_id, label) VALUES (inserted_editor_id, editor_label);
                current_editor_id := inserted_editor_id;
                inserted_editor_id := inserted_editor_id + 1;
            END IF;

            -- Insert into the association table using inserted_editor_id
            INSERT INTO associated_to_EB (editor_id, book_id) VALUES (current_editor_id, new_book_id);

            -- Increment inserted_editor_id
            inserted_editor_id := inserted_editor_id + 1;
        END LOOP;

    -- Split the sigles string and insert into the "associated_to_SB" table
    FOR i IN 1..array_length(sigle_label_arr, 1) LOOP
            sigle_label := sigle_label_arr[i];
            INSERT INTO associated_to_SB (book_id, sigle) VALUES (new_book_id, sigle_label);
        END LOOP;
        -- Return the new_book_id
    RETURN NEW;
END;
$$
    LANGUAGE plpgsql;