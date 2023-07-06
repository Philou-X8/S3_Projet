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
    @GET
    @Path("/getBook")
    @PermitAll
    public Book getBook() {
        Book book= inventoryMapper.getBook();

        return book;
    }
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
    public Book getBookFromID(
            @PathParam("idBook") Integer idBook
    ) {
        System.out.println("getBookISBN, param received: " + idBook.toString()); // print
        Book book = inventoryMapper.getBookFromID(idBook);
        if(book==null) book = new Book();
        System.out.println("SQL return : ISBN : " + book.codeisbn.toString()); // print
        return book;
    }


    /**************** OLD ****************/
    @GET
    @Path("/getBookFromSigle/{sigleBook}")
    @PermitAll
    public Book getBookFromSigle(
            @PathParam("sigleBook") String sigle
    ) {
        System.out.println("getBookISBN, param received: " + sigle); // print
        Book book = inventoryMapper.getBookFromSigle(sigle);
        if(book==null) book = new Book();
        System.out.println("SQL return : ISBN : " + book.codeisbn.toString()); // print
        return book;
    }

    /**************** OLD ****************/
    @GET
    @Path("/getBookFromISBN/{isbn}")
    @PermitAll
    public Book getBookFromISBN(@PathParam("isbn") String isbn){
        System.out.println("getBookFromISBN : " + isbn);
        Book book = inventoryMapper.getBookFromISBN(isbn);
        if(book==null) book=new Book();
        return book;
    }

    @GET
    @Path("/listBooksFromTitle/{title}")
    @PermitAll
    public List<ListedBooks> listBooksFromTitle(
            @PathParam("title") String titleURL
            //@PathParam("program") String program
    ) {
        System.out.println("listBooksFromTitle, raw param received: " + titleURL); // print
        String title = URLDecoder.decode(titleURL, StandardCharsets.UTF_8);
        System.out.println("listBooksFromProgram, formated param received: " + title); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromTitle(title);
        if(books == null) books = new ArrayList<ListedBooks>();
        System.out.println(books);
        return books;
    }

    @GET
    @Path("/listBooksFromProgram/{program}")
    @PermitAll
    public List<ListedBooks> listBooksFromProgram(
            @PathParam("program") String programURL
            //@PathParam("program") String program
    ) {
        System.out.println("listBooksFromProgram, raw param received: " + programURL); // print
        String program = URLDecoder.decode(programURL, StandardCharsets.UTF_8);
        System.out.println("listBooksFromProgram, formated param received: " + program); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromProgram(program);
        //if(books == null) books = new ArrayList<ListedBooks>();
        System.out.println(books);
        return books;
    }

    @GET
    @Path("/listBooksFromAuthor/{auteur}")
    @PermitAll
    public List<ListedBooks> listBooksFromAuthor(@PathParam("auteur") String author){
        System.out.println("listBooksFromAuthor : "+author);

        //books= inventoryMapper.requestBooksFromAuthor(author);


        return null;
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
