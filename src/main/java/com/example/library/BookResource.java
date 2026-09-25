package com.example.library;

import java.util.List;

import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;

@Path("/books")
public class BookResource {

    @Inject
    CheckoutService checkoutService;

    @GET
    public List<Book> listAvailable() {
        return checkoutService.listAvailable();
    }

    @POST
    @Path("/{id}/checkout")
    public Response checkout(@PathParam("id") Long id) {
        boolean ok = checkoutService.checkout(id);
        return ok ? Response.ok().build() : Response.status(Response.Status.CONFLICT).build();
    }

    @POST
    @Path("/{id}/return")
    public Response returnBook(@PathParam("id") Long id) {
        boolean ok = checkoutService.returnBook(id);
        return ok ? Response.ok().build() : Response.status(Response.Status.NOT_FOUND).build();
    }
}
