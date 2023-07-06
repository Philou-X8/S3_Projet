package ca.usherbrooke.gegi.server.persistence;


import ca.usherbrooke.gegi.server.business.Book;
import ca.usherbrooke.gegi.server.business.ListedBooks;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface InventoryMapper {

    //Book getBook();
    List<Book> getBookAll();
    //Book getBookISBN(Long isbn);
    //Book getBookFromID(Integer idBook);
    //Book getBookFromSigle(String sigle);

    List<ListedBooks> requestBooksFromID(int id);
    List<ListedBooks> requestBooksFromSigle(String sigle);
    List<ListedBooks> requestBooksFromAutor();
    List<ListedBooks> requestBooksFromProgram(String program);
    List<ListedBooks> requestBooksFromAP();
    List<ListedBooks> requestBooksFromLanguage(String language);

    Book getBookFromTitle(String title);

    List<ListedBooks> getBookFromISBN(String isbn);

    List<ListedBooks> requestBooksFromAuthor(String author);

    void deleteBook(String bookID);
}
