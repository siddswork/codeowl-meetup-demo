---
kind: file
source_paths: [src/main/java/com/example/library/CheckoutService.java]
file: { source_hash: 26952149f6d04fc408a72bc7c2007e346eec156f58d44febb63931ef3d2b9474, deps_hash: e872dd7fee24e678daede9dcbd7cd44933ed261efe3c2927a6e565855031e405, spec_hash: 6fa4e001eb2cbe7f1ffa3b85a05149568798d9d7ec7207b9c4396d15b55f0509 }
symbols:
  src/main/java/com/example/library/CheckoutService.java::CheckoutService: { source_hash: 2cc1650910ea3c6b673709860f567cfee01d63b9c5cc646d0606d4cc13e35d09, deps_hash: e872dd7fee24e678daede9dcbd7cd44933ed261efe3c2927a6e565855031e405, spec_hash: f5ce5db96cdeabb5916387c4476ced24721e0329d2efa42e4f61caee289e7fb2 }
---
# src/main/java/com/example/library/CheckoutService.java
## Summary
The business-logic layer between BookResource and the Book entity: exposes checkout/return/list operations as simple boolean or list results, keeping transaction boundaries and availability rules out of the REST layer.

## `CheckoutService`
`@ApplicationScoped
public class CheckoutService`
### Summary
The business-logic layer between the REST resource and the Book entity.
### Behavior
Owns the checkout/return/list operations and their transaction boundaries -- BookResource never touches Book directly, only through this class.
### Depends on
- `src/main/java/com/example/library/Book.java::Book` — com.example.library
- externals: jakarta.enterprise.context, jakarta.transaction, java.util
