package ca.usherbrooke.gegi.server.persistence;


import ca.usherbrooke.gegi.server.business.Book;
import ca.usherbrooke.gegi.server.business.ListedBooks;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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



    //List<ListedBooks> getBookFromISBN(String isbn);

    void deleteBook(String bookID);
}
