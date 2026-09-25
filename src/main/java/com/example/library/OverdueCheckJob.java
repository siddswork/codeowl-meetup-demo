package com.example.library;

import java.util.List;

import io.quarkus.scheduler.Scheduled;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class OverdueCheckJob {

    @Scheduled(every = "24h")
    void flagOverdueBooks() {
        List<Book> checkedOut = Book.list("available", false);
        for (Book book : checkedOut) {
            System.out.println("Checked out: " + book.title);
        }
    }
}
