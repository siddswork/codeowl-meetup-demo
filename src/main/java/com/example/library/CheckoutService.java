package com.example.library;

import java.util.List;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class CheckoutService {

    public List<Book> listAvailable() {
        return Book.list("available", true);
    }

    @Transactional
    public boolean checkout(Long bookId) {
        Book book = Book.findById(bookId);
        if (book == null || !book.available) {
            return false;
        }
        book.available = false;
        return true;
    }

    @Transactional
    public boolean returnBook(Long bookId) {
        Book book = Book.findById(bookId);
        if (book == null) {
            return false;
        }
        book.available = true;
        return true;
    }
}
