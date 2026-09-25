---
kind: file
source_paths: [src/main/java/com/example/library/BookResource.java]
file: { source_hash: 63cd38f8befb6721b3e146537a294c63e92787090e36107c8333a012d2d4bb1c, deps_hash: 208dcb7c577e585476a9661150f04b1f8e59ee4ef8f0b8cd71c949f8a5d6e0a7, spec_hash: 1b8092981f3dd348166ca5ac35b8773bb22e8158b11cc23a06afb6399a9fbc3d }
symbols:
  src/main/java/com/example/library/BookResource.java::BookResource: { source_hash: 36b92c0331761ae17d0294ac0f88f674c885d633891c8b229d5b9e3aaeaeb37c, deps_hash: 208dcb7c577e585476a9661150f04b1f8e59ee4ef8f0b8cd71c949f8a5d6e0a7, spec_hash: 48731f3d1e5c752387fa67975411bc26fc3f820e451eb18b46b46e1d94cd58af }
---
# src/main/java/com/example/library/BookResource.java
## Summary
The REST entry point for the library's checkout flow -- three endpoints (list available, checkout, return) that each delegate straight to CheckoutService, with no business logic of their own beyond translating its boolean results into HTTP status codes.

## `BookResource`
`@Path("/books")
public class BookResource`
### Summary
The REST resource for the library's checkout flow, mounted at /books.
### Behavior
Exposes three endpoints -- list available books, check one out, return one -- each a thin delegation to the injected CheckoutService, with no business logic of its own beyond translating a boolean/list result into an HTTP response.
### Depends on
- `src/main/java/com/example/library/Book.java::Book` — com.example.library
- `src/main/java/com/example/library/CheckoutService.java::CheckoutService` — com.example.library
- externals: jakarta.inject, jakarta.ws.rs, jakarta.ws.rs.core, java.util
