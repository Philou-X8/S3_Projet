package ca.usherbrooke.gegi.server.business;

import java.sql.Timestamp;

public class Book {
    public String book_label = "unnamed";
    public Long isbn_label = Integer.toUnsignedLong(0);
    public String date_label = "unnamed";
    public String url_label = "unnamed";
    public String author_label = "unnamed";
    public String editor_label = "unnamed";
    public String field_label = "unnamed";
    public String format_label = "unnamed";
    public String language_label = "unnamed";
    public String program_label = "unnamed";
    public String typeformat_label = "unnamed";
    public String sigle_label = "unnamed";
    public String ap_label = "unnamed";
    @Override
    public String toString(){
        return "Book [ ]";
    }
}
