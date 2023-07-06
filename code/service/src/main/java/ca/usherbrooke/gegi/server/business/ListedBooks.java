package ca.usherbrooke.gegi.server.business;

public class ListedBooks {
    public String book_label = "unnamed";
    public Long isbn_label = Integer.toUnsignedLong(0);
    public String author_label = "unnamed";
    public String sigle_label = "unnamed";
    public String program_label = "unnamed";


    public Long codeisbn = Integer.toUnsignedLong(0);
    //public String author_label = "unnamed";
    public String sigle = "unnamed";
    //public String program_label = "unnamed";
    public Byte additional_data = 0;
    public String additional_label = "unnamed";

    @Override
    public String toString(){
        return "Book [ " + book_label + ", by: " + author_label + ", ISBN: " + isbn_label + ", sigle: " + sigle_label + ", program: " + program_label + " ] ";
    }

}
