package ca.usherbrooke.gegi.server.persistence;


import ca.usherbrooke.gegi.server.business.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface InventoryMapper {

    Book getBook();
    Book getBookISBN(Long isbn);
    Book getBookFromID(Integer idBook);
    Book getBookFromSigle(String sigle);
}
