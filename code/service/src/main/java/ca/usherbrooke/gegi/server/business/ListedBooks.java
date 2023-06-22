package ca.usherbrooke.gegi.server.business;

public class ListedBooks {
    public String book_label = "unnamed";
    public Long codeisbn = Integer.toUnsignedLong(0);
    public String author_label = "unnamed";
    public String sigle = "unnamed";
    public String program_label = "unnamed";
    public Byte additional_data = 0;
    public String additional_label = "unnamed";

    @Override
    public String toString(){
        return "Book [ " + book_label + ", by: " + author_label + ", ISBN: " + codeisbn + ", sigle: " + sigle + ", program: " + program_label + " ] ";
    }

}
