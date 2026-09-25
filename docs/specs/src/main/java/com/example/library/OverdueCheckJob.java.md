---
kind: file
source_paths: [src/main/java/com/example/library/OverdueCheckJob.java]
file: { source_hash: 99dca8577fe4383930a41235a963be4362fff7ff1553b487dff6757e649f0654, deps_hash: e872dd7fee24e678daede9dcbd7cd44933ed261efe3c2927a6e565855031e405, spec_hash: 1b0c555ed3e07e1f85304f42af5d3720112a2f640c1f17a98c71fe16794e7823 }
symbols:
  src/main/java/com/example/library/OverdueCheckJob.java::OverdueCheckJob: { source_hash: 91c1d3cc6d86ccae6d5b1438dd3b3fb1045c0567b7dee887b35756641df6510b, deps_hash: e872dd7fee24e678daede9dcbd7cd44933ed261efe3c2927a6e565855031e405, spec_hash: e9116e66d9e92beb2820a7be1145deb017a9183fe356ea4d4b462e42fd3ab991 }
---
# src/main/java/com/example/library/OverdueCheckJob.java
## Summary
A background job, unrelated to the HTTP API, that periodically surfaces which books are currently checked out -- the second kind of entry point this service exposes, alongside BookResource's REST endpoints.

## `OverdueCheckJob`
`@ApplicationScoped
public class OverdueCheckJob`
### Summary
A scheduled background job, independent of the HTTP API.
### Behavior
Runs once a day and logs every currently checked-out book -- a placeholder for real overdue tracking, but a genuine second entry point into this service alongside BookResource's REST endpoints.
### Depends on
- `src/main/java/com/example/library/Book.java::Book` — com.example.library
- externals: io.quarkus.scheduler, jakarta.enterprise.context, java.util
