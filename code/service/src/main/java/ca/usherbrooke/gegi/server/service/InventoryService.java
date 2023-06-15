package ca.usherbrooke.gegi.server.service;

import ca.usherbrooke.gegi.server.business.Book;
import ca.usherbrooke.gegi.server.business.ListedBooks;
import ca.usherbrooke.gegi.server.business.Message;
import ca.usherbrooke.gegi.server.business.Person;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.SecurityContext;

import ca.usherbrooke.gegi.server.persistence.InventoryMapper;
import org.eclipse.microprofile.jwt.JsonWebToken;

import ca.usherbrooke.gegi.server.persistence.MessageMapper;
import org.eclipse.microprofile.openapi.annotations.parameters.RequestBody;
import org.jsoup.parser.Parser;

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
        Book book = inventoryMapper.getBook();
        return book;
    }
    /********************************/
    @GET
    @Path("/getBookAll")
    @PermitAll
    public List<Book> getBookAll() {
        List<Book> books = inventoryMapper.getBookAll();
        System.out.println("All book requested");

        listBooksFromProgram("Génie Information");
        return books;
    }


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


    @GET
    @Path("/listBooksFromProgram/{program}")
    @PermitAll
    public List<ListedBooks> listBooksFromProgram(
            @PathParam("program") String program
    ) {
        System.out.println("listBooksFromProgram, param received: " + program); // print
        List<ListedBooks> books = inventoryMapper.requestBooksFromProgram("Génie Information");
        //if(books == null) books = new ArrayList<ListedBooks>();
        System.out.println(books);
        return books;
    }



}
