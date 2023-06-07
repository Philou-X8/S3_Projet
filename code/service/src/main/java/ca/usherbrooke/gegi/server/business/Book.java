package ca.usherbrooke.gegi.server.business;

import java.sql.Timestamp;

public class Book {
    public String sigle = "";
    public Integer book_id = 0;
    public String label = "";
    public Long codeisbn = Integer.toUnsignedLong(0);
    public Integer author_id = 0;
    public Integer editor_id = 0;
    public Timestamp publicationdate = new Timestamp(1);
    public Integer format_id = 0;
    public String url = "";
    public Integer language_id = 0;
    public Integer image_id = 0;
    public String toString(){
        return "Book [ " + "id : " + book_id + ", " + label + ", by : " + author_id + ", lange : " + language_id;
    }
}
