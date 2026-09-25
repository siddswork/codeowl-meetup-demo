package com.example.library;

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import jakarta.persistence.Entity;

@Entity
public class Book extends PanacheEntity {

    public String title;

    public String author;

    public boolean available;

    // Staff-only notes -- never exposed through the API, deliberately
    // private so it never becomes part of Book's public shape.
    private String internalNotes;

    public String getInternalNotes() {
        return internalNotes;
    }

    public void setInternalNotes(String internalNotes) {
        this.internalNotes = internalNotes;
    }
}
