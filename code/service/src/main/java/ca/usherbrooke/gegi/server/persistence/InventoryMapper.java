package ca.usherbrooke.gegi.server.persistence;


import ca.usherbrooke.gegi.server.business.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface InventoryMapper {

    Book getBook();
}
