package ca.usherbrooke.gegi.server.service;



import ca.usherbrooke.gegi.server.business.*;

import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.SecurityContext;


import ca.usherbrooke.gegi.server.persistence.*;
import org.eclipse.microprofile.jwt.JsonWebToken;


import org.eclipse.microprofile.openapi.annotations.parameters.RequestBody;
import org.jsoup.parser.Parser;

import java.net.URI;
import java.net.URLDecoder;

@Path("/api")
@Produces({"application/json"})
@Consumes({"application/json"})
public class InventoryService {
    @Context
    SecurityContext securityContext;
    @Inject
    JsonWebToken jwt;
    @Inject
    InventoryMapper inventoryMapper;


    /********************************/
    /*@GET
    @Path("/getBook")
    @PermitAll
    public Book getBook() {
        Book book= inventoryMapper.getBook();

        return book;
    }*/
    /********************************/
    @GET
    @Path("/getBookAll")
    @PermitAll
    public List<Book> getBookAll() {
        List<Book> books = inventoryMapper.getBookAll();
        System.out.println("All book requested");

        listBooksFromProgram("genie");
        return books;
    }

    /**************** OLD ****************/
    @GET
    @Path("/getBookFromLanguage/{language}")
    @PermitAll
    public List<ListedBooks> getBookFromLanguage(@PathParam("language") String language){
        System.out.println("getBookFromLanguage : " + language);
        List<ListedBooks> books = inventoryMapper.requestBooksFromLanguage(language);

        return books;

    }

    @GET
    @Path("/deleteBook/{bookID}")
    @RolesAllowed("admin")
    public void deleteBook(@PathParam("bookID") String bookID){
        System.out.println("DeleteBook : "+bookID);
        //inventoryMapper.deleteBook(bookID);


    }

    /**************** OLD ****************/
    @GET
    @Path("/getBookFromTitle/{titleBook}")
    @PermitAll
    public Book getBookfromTitle(@PathParam("titleBook") String title){
        System.out.println("getBookTitle, param received: "+title);
        Book book = inventoryMapper.getBookFromTitle(title);
        if(book==null) book=new Book();
        System.out.println("SQL return : ISBN : "+book.codeisbn.toString());
        return book;
    }

    /**************** OLD ****************/
    @GET
    @Path("/getBookFromID/{idBook}")
    @PermitAll
    public List<ListedBooks> getBookFromID(
            @PathParam("idBook") Integer idBook
    ) {
        System.out.println("getBookISBN, param received: " + idBook.toString()); // print
        List<ListedBooks> book = inventoryMapper.requestBooksFromID(idBook);

        return book;
    }


    /**************** OLD ****************/
    @GET
    @Path("/getBookFromSigle/{sigleBook}")
    @PermitAll
    public List<ListedBooks> getBookFromSigle(
            @PathParam("sigleBook") String sigle
    ) {
        System.out.println("getBookISBN, param received: " + sigle); // print
        List<ListedBooks> book = inventoryMapper.requestBooksFromSigle(sigle);

        return book;
    }

    /**************** OLD ****************/
    @GET
    @Path("/getBookFromISBN/{isbn}")
    @PermitAll
    public List<ListedBooks> getBookFromISBN(@PathParam("isbn") String isbn){
        System.out.println("getBookFromISBN : " + isbn);
        List<ListedBooks> book = inventoryMapper.getBookFromISBN(isbn);

        return book;
    }

    /**********************************/
    /** NEW METHODES **/
    /**********************************/

    public static List<ListedBooks> collapseLines(List<ListedBooks> inList){
        List<ListedBooks> outList = new ArrayList<>();

        for(ListedBooks book : inList){

            boolean bookExist = false; // book already exist in new list

            // look if book is already in list
            for(ListedBooks newBook : outList){
                if (book.book_label.equals(newBook.book_label)){
                    bookExist = true;
                    if( ! newBook.author_label.contains(book.author_label)){
                        newBook.author_label = newBook.author_label + ", "  + book.author_label;
                    }
                    if( ! newBook.program_label.contains(book.program_label)){
                        newBook.program_label = newBook.program_label + ", "  + book.program_label;
                    }
                    break;
                }
            }

            // add current book to new list
            if(!bookExist){
                outList.add(book);
            }
        }
        return outList;
    }

    @GET
    @Path("/listBooksFromTitle/{title}")
    @PermitAll
    public List<ListedBooks> listBooksFromTitle(
            @PathParam("title") String titleURL
    ) {
        System.out.println("--------------------------");
        System.out.println("listBooksFromTitle, raw param received: " + titleURL); // print
        String title = URLDecoder.decode(titleURL, StandardCharsets.UTF_8);
        System.out.println("listBooksFromTitle, formated param received: " + title); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromTitle(title);
        System.out.println(books);
        if(books == null) books = new ArrayList<ListedBooks>();
        //books = collapseLines(books);
        System.out.println(books);
        return books;
    }

    @GET
    @Path("/listBooksFromISBN/{isbn}")
    @PermitAll
    public List<ListedBooks> listBooksFromISBN(
            @PathParam("isbn") String isbnURL
    ) {
        System.out.println("--------------------------");
        System.out.println("listBooksFromISBN, raw param received: " + isbnURL); // print
        try{
            Long isbn = Integer.toUnsignedLong(Integer.parseInt(isbnURL));
            System.out.println("listBooksFromISBN, formated param received: " + isbn); // print
            List<ListedBooks> books = inventoryMapper.requestBooksFromIsbn(isbn);

            if(books == null) books = new ArrayList<ListedBooks>();
            //books = collapseLines(books);
            System.out.println(books);
            return books;
        } catch (NumberFormatException e) {
            return new ArrayList<ListedBooks>();
        }


    }

    @GET
    @Path("/listBooksFromSigle/{sigle}")
    @PermitAll
    public List<ListedBooks> listBooksFromSigle(
            @PathParam("sigle") String sigleURL
    ) {
        System.out.println("--------------------------");
        System.out.println("listBooksFromSigle, raw param received: " + sigleURL); // print
        String sigle = URLDecoder.decode(sigleURL, StandardCharsets.UTF_8);
        System.out.println("listBooksFromSigle, formated param received: " + sigle); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromSigle(sigle);
        if(books == null) books = new ArrayList<ListedBooks>();
        //books = collapseLines(books);
        System.out.println(books);
        return books;
    }

    @GET
    @Path("/listBooksFromProgram/{program}")
    @PermitAll
    public List<ListedBooks> listBooksFromProgram(
            @PathParam("program") String programURL
    ) {
        System.out.println("--------------------------");
        System.out.println("listBooksFromProgram, raw param received: " + programURL); // print
        String program = URLDecoder.decode(programURL, StandardCharsets.UTF_8);
        System.out.println("listBooksFromProgram, formated param received: " + program); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromProgram(program);
        if(books == null) books = new ArrayList<ListedBooks>();
        //books = collapseLines(books);
        System.out.println(books);
        return books;
    }

    @GET
    @Path("/listBooksFromAP/{ap}")
    @PermitAll
    public List<ListedBooks> listBooksFromAP(
            @PathParam("ap") String apURL
    ) {
        System.out.println("--------------------------");
        System.out.println("listBooksFromAP, raw param received: " + apURL); // print
        String ap = URLDecoder.decode(apURL, StandardCharsets.UTF_8);
        System.out.println("listBooksFromAP, formated param received: " + ap); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromAP(ap);
        if(books == null) books = new ArrayList<ListedBooks>();
        //books = collapseLines(books);
        System.out.println(books);
        return books;
    }

    @GET
    @Path("/listBooksFromLanguage/{language}")
    @PermitAll
    public List<ListedBooks> listBooksFromLanguage(
            @PathParam("language") String languageURL
    ) {
        System.out.println("--------------------------");
        System.out.println("requestBooksFromLanguage, raw param received: " + languageURL); // print
        String language = URLDecoder.decode(languageURL, StandardCharsets.UTF_8);
        System.out.println("requestBooksFromLanguage, formated param received: " + language); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromLanguage(language);
        if(books == null) books = new ArrayList<ListedBooks>();
        //books = collapseLines(books);
        System.out.println(books);
        return books;
    }

    @GET
    @Path("/listBooksFromAuthor/{author}")
    @PermitAll
    public List<ListedBooks> listBooksFromAuthor(
            @PathParam("author") String authorURL
    ) {
        System.out.println("--------------------------");
        System.out.println("requestBooksFromAuthor, raw param received: " + authorURL); // print
        String author = URLDecoder.decode(authorURL, StandardCharsets.UTF_8);
        System.out.println("requestBooksFromAuthor, formated param received: " + author); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromAuthor(author);
        if(books == null) books = new ArrayList<ListedBooks>();
        //books = collapseLines(books);
        System.out.println(books);
        return books;
    }


    @GET
    @Path("/addBook/{params}")
    @RolesAllowed("admin")
    public void addBook(@PathParam("params") String params ){


        int indexFirstSplit = params.indexOf('|');
        int indexSecondSplit = params.indexOf('|',indexFirstSplit+1);
        int indexThirdSplit = params.indexOf('|',indexSecondSplit+1);
        int indexFourthSplit = params.indexOf('|',indexThirdSplit+1);
        int indexFifthSplit = params.indexOf('|',indexFourthSplit+1);
        int indexSixthSplit = params.indexOf('|',indexFifthSplit+1);



        String cours = params.substring(0,indexFirstSplit);
        String title = params.substring(indexFirstSplit+1,indexSecondSplit);
        String author = params.substring(indexSecondSplit+1,indexThirdSplit);
        String editor = params.substring(indexThirdSplit+1,indexFourthSplit);
        String isbn = params.substring(indexFourthSplit+1, indexFifthSplit);
        String url = params.substring(indexFifthSplit+1,indexSixthSplit);
        String language = params.substring(indexSixthSplit+1);

        System.out.println(cours + " "+title + " "+author+ " "+editor+" "+isbn+" "+url+" "+language);


        System.out.println("method called :  "+params);

    }



}
