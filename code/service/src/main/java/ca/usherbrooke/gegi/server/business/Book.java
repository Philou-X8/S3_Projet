package ca.usherbrooke.gegi.server.business;

import java.sql.Timestamp;

public class Book {
    public String sigle;
    public Integer book_id;
    public String label;
    public Long codeisbn;
    public Integer author_id;
    public Integer editor_id;
    public Timestamp publicationdate;
    public Integer format_id;
    public String url;
    public Integer language_id;
    public Integer image_id;
    public String toString(){
        return "Book [ " + "id : " + book_id + ", " + label + ", by : " + author_id + ", lange : " + language_id;
    }
}
