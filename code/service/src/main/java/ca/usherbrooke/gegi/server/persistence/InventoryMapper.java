package ca.usherbrooke.gegi.server.persistence;


import ca.usherbrooke.gegi.server.business.Book;
import ca.usherbrooke.gegi.server.business.ListedBooks;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;

@Mapper
public interface InventoryMapper {
    List<ListedBooks> requestBooksFromTitle(String title);
    List<ListedBooks> requestBooksFromIsbn(long isbn);
    List<ListedBooks> requestBooksFromSigle(String sigle);
    List<ListedBooks> requestBooksFromProgram(String program);
    List<ListedBooks> requestBooksFromAP(String topic);
    List<ListedBooks> requestBooksFromLanguage(String language);
    List<ListedBooks> requestBooksFromAuthor(String author);
    Book requestBookAllInfo(long isbn);

    void addBookToDB(
            @Param("book_label") String book_label,
            @Param("ISBN") long ISBN,
            @Param("publicationDate") Date publicationDate,
            @Param("format_id") int format_id,
            @Param("URL") String URL,
            @Param("language_id") int language_id,
            @Param("field_id") int field_id,
            @Param("author_labels") String author_labels,
            @Param("editor_labels") String editor_labels,
            @Param("sigles") String sigles
    );


    //List<ListedBooks> getBookFromISBN(String isbn);

    void deleteBook(String bookID);
}
