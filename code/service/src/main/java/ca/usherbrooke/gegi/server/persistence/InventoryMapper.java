package ca.usherbrooke.gegi.server.persistence;


import ca.usherbrooke.gegi.server.business.Book;
import ca.usherbrooke.gegi.server.business.ListedBooks;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface InventoryMapper {

    Book getBook(); // old function
    List<Book> getBookAll(); // old function
    Book getBookISBN(Long isbn); // old function
    Book getBookFromID(Integer idBook); // old function
    Book getBookFromSigle(String sigle); // old function

    List<ListedBooks> requestBooksFromID(String ID);
    List<ListedBooks> requestBooksFromTitle(String title);
    List<ListedBooks> requestBooksFromIsbn(String isbn);
    List<ListedBooks> requestBooksFromSigle(String sigle);
    List<ListedBooks> requestBooksFromProgram(String program);
    List<ListedBooks> requestBooksFromAP(String topic);

    List<ListedBooks> requestBooksFromLanguage(String language);

    List<ListedBooks> requestBooksFromAuthor(String author);

    Book getBookFromTitle(String title);

    Book getBookFromISBN(String isbn);

    void deleteBook(String bookID);
}
