---
kind: rollup
dir: src/main/java/com/example/library
files:
  src/main/java/com/example/library/BookResource.java: 1b8092981f3dd348166ca5ac35b8773bb22e8158b11cc23a06afb6399a9fbc3d
  src/main/java/com/example/library/CheckoutService.java: 6fa4e001eb2cbe7f1ffa3b85a05149568798d9d7ec7207b9c4396d15b55f0509
  src/main/java/com/example/library/HealthResource.java: 2eb9ef8bbc0ab040b01c1999dfca9916cfce3940fb1316160eeacf34069af237
  src/main/java/com/example/library/OverdueCheckJob.java: 1b0c555ed3e07e1f85304f42af5d3720112a2f640c1f17a98c71fe16794e7823
spec_hash: 5f51487d30e999f7e66bff89addca61ac6d33cf2283cb3b07dc1086621277117
---
# src/main/java/com/example/library
## Summary
The library domain package: a REST resource (BookResource) and a scheduled job (OverdueCheckJob) as the two entry points, both backed by CheckoutService's business logic over the Book entity. HealthResource is the one file here with no connection to that domain -- a plain liveness check.

## Contents
- `src/main/java/com/example/library/Book.java` — (no document; not spec-bearing)
- `src/main/java/com/example/library/BookResource.java` — The REST entry point for the library's checkout flow -- three endpoints (list available, checkout, return) that each delegate straight to CheckoutService, with no business logic of their own beyond translating its boolean results into HTTP status codes.
- `src/main/java/com/example/library/CheckoutService.java` — The business-logic layer between BookResource and the Book entity: exposes checkout/return/list operations as simple boolean or list results, keeping transaction boundaries and availability rules out of the REST layer.
- `src/main/java/com/example/library/HealthResource.java` — A liveness-check endpoint with no connection to the library domain -- exists only to answer "is the process up," never touches Book or any of the checkout logic.
- `src/main/java/com/example/library/OverdueCheckJob.java` — A background job, unrelated to the HTTP API, that periodically surfaces which books are currently checked out -- the second kind of entry point this service exposes, alongside BookResource's REST endpoints.
