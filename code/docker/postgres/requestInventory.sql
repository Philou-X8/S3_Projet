create table Inventaire (b int);


--Trouver les livres Anglais
select b.label
from book b
         join language l on b.language_id = l.language_id
where l.language_id = 2;

--Trouver le nom du livre fesant partie de Atelier de programmation
SELECT b.label
FROM book b
         JOIN ap a ON b.sigle = a.sigle
WHERE a.label = 'Atelier de programmation';

--Sélectionner tous les livres publiés en français :
SELECT b.label
FROM book b
         JOIN language l ON b.language_id = l.language_id
WHERE l.label = 'Français';

--Sélectionner tous les livres publiés après une certaine date
SELECT b.label
FROM book b
WHERE b.publicationDate < '2022-01-01';

--Sélectionner tous les livres dont le format est numérique (PDF ou EPUB) :
SELECT b.label, b.publicationDate, b.codeISBN
FROM book b
         JOIN format f ON b.format_id = f.format_id
         JOIN typeformat tf ON f.typeformat_id = tf.typeformat_id
WHERE tf.label = 'Papier';

--Sélectionner tous les livres d'un programme spécifique :
SELECT *
FROM book b
         JOIN ap a ON b.sigle = a.sigle
WHERE a.program_id = 1;



--Sélectionner tous les livres d'un auteur spécifique :
SELECT b.label
FROM book b
         JOIN author a ON b.author_id = a.author_id
WHERE a.label = 'Gilbert SYBILLE & Théodore WILDI';


--Sélectionner tous les livres d'un éditeur spécifique :
SELECT b.label
FROM book b
         JOIN editor e ON b.editor_id = e.editor_id
WHERE e.label = 'PUL - Presses U. de Laval';


--Sélectionner tous les livres associés à une AP spécifique :
SELECT b.label, b.codeISBN
FROM book b
         JOIN ap a ON b.sigle = a.sigle
WHERE a.label = 'GEN230';


--Sélectionner tous les livres dont le code ISBN est nul :
SELECT b.label
FROM book b
WHERE b.codeISBN IS NOT NULL;


--Sélectionner tous les livres dans un certain format et d'une certaine langue :
SELECT b.label
FROM book b
         JOIN format f ON b.format_id = f.format_id
         JOIN language l ON b.language_id = l.language_id
WHERE f.label = 'Papier' AND l.label = 'Anglais';


SELECT b.label
FROM book b
         JOIN ap a ON b.sigle = a.sigle
WHERE a.label = 'Atelier de programmation';

--Sélectionner tous les livres dont le format est numérique (PDF ou EPUB) :
SELECT b.label, b.publicationDate, b.codeISBN
FROM book b
         JOIN format f ON b.format_id = f.format_id
         JOIN typeformat tf ON f.typeformat_id = tf.typeformat_id
WHERE tf.label = 'Papier';

